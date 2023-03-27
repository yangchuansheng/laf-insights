#!/bin/bash

[ -f "$GITHUB_ENV" ] && source $GITHUB_ENV

for i in $(cat repo.txt);
do
  for j in {1..30};
  do
      curl -s -H "Accept: application/vnd.github.v3+json" -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/repos/$i/contributors?per_page=100&page=$j"|jq -r '.[].login'|sort|uniq >> ks_all_contributors_source.txt
  done
done

cat all_contributors_source.txt|grep -Ev "\-bot|\[bot\]|^null$"|sort|uniq > all_contributors_${DATE}.txt
