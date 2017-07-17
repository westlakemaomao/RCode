#leafletCN 中国地图可视化
getwd()
library(RMySQL)
conn <- dbConnect(MySQL(), dbname = "news", 
                  username="recsys", password="]^gSQrODZ", host="127.0.0.1", port=3310)
today<-Sys.Date()-1
today
sql<-paste("SELECT location,sum(clickpv)/sum(recomnum) FROM news.user_trait_pv_uv_stat where daystring='",today,"' group by location;",sep="")
sql
dbSendQuery(conn,"set names gbk")
rs<-dbSendQuery(conn,sql)
result<-dbFetch(rs,n=-1)
result
View(result)
fix(result)
names(result)<-c("location","recompv")
##add leaflet
library(leafletCN)
#recompv
geojsonMap(result,"china",popup = paste(result$location,":",result$recompv),palette = "Reds",legendTitle = "recompv")


