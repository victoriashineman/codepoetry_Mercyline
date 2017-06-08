clear capture log using "C:\Documents and Settings\courses\761 and 762\w07\2SLS\2SLS.log", replace use "C:\Documents and Settings\courses\761 and 762\w07\2SLS\2SLSeg.dta"  
summarize  
gen lwage=log(wage)  
** IV regression (2SLS) ** ivreg lwage age married smsa (educ = nearc2 nearc4)  
** general version of Hausman test ** predict ivresid,residuals est store ivreg reg lwage educ age married smsa  hausman ivreg .,constant sigmamore df(1)  
** Wu version of Hausman test ** quietly reg educ age married smsa nearc2 nearc4 predict educhat,xb reg lwage educ age married smsa educhat  
** overidentification test ** quietly reg ivresid age married smsa nearc2 nearc4 predict explresid,xb matrix accum rssmat = explresid,noconstant matrix accum tssmat = ivresid,noconstant scalar nobs=e(N) scalar x2=nobs*rssmat[1,1]/tssmat[1,1] scalar pval=1-chi2(1,x2) scalar list x2 pval  
log close
close
