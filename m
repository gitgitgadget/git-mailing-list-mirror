Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B06C38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 17:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJ2RA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 13:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ2RAY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 13:00:24 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D83013E9A
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 10:00:23 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 17so3046896pfv.4
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X1ek/M/PuByvaOUJLIgBA0u4nf8ZduCzZn9gvQmA34U=;
        b=ofvVKq89Icp6MtRS7YQh2sP0S0+dwgzNGvOqZYaZGsnCgvPQdEx2SsbNoZAvLUTO+K
         WVlKkTW8/CNhON+mGAlOP7i6fS1UPBhC3LhblaR+ncRj3muiXLXO6Jg3SdLkbNnLbpnl
         i71FpG62BiH6ChL/LUQJ+JFUXuCsK92CnL76rQei8m5n67r89qWmC54RC5nIwWugzqKH
         OTUbJbElFpdGOpn25WNv7perfF2Inpdw9P+AEVlcQm4k0zSvYLmD0zM7JBfQzO/ln1Ia
         71DjcwkZeaWJLWCgOHnCCx1K2H7vTDDt8Ru48iocD4snZ95vEP0LLT8XfGG/emITsvl2
         N6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X1ek/M/PuByvaOUJLIgBA0u4nf8ZduCzZn9gvQmA34U=;
        b=b0rjT1m1HT8I1oIzMYNq3U6EobvCuoyrHiJSd4ysUPXyiqeWyDqu7oqMnLT0f0qpdp
         G+UoM8v47inAQy0FO22IPPztU2IVbysdd9THeDB+Y8ZsRpI4oVyFwAnYdg72uAh1fW3h
         6q+iRV8JDbCUsn/gPFj53bCPeFbSIXd5qk9/29MldLwKtSq651HFuEwbGzty3TRScMp2
         1SIDZdPFWkP4zc8FCSrogIlOl8EiYqOMJ9181D36k2hG5WBjeOaUORYlaM/d26N6dAdt
         4sPudM0eVkX5abIW+lHzIwFm0/2Vq2Rnx5CdHB9bcgy3dGwMEV3296UpwlMEf5e5iorj
         T5cg==
X-Gm-Message-State: ACrzQf15NvRbUtUZeR9TyaUXc7sxVSGO5/ilb+Kx9fAzwBbCN56zlGVF
        BEkYtDN18bubx3R8gGvO2BO3JKwnM/FjxZxMa7c+2PGNBS4zxg==
X-Google-Smtp-Source: AMsMyM7wsYKAa6EQr7DgfIlrYz+SchfluL/5Au2HHrycTznb4OQd+zYblZEUB6KeSEfeuTbDfqn035QxJzdKBCb0PxA=
X-Received: by 2002:a63:1a07:0:b0:46b:2825:f9cf with SMTP id
 a7-20020a631a07000000b0046b2825f9cfmr4829145pga.370.1667062822743; Sat, 29
 Oct 2022 10:00:22 -0700 (PDT)
MIME-Version: 1.0
From:   man dog <dogman888888@gmail.com>
Date:   Sun, 30 Oct 2022 01:59:41 +0900
Message-ID: <CAFOPqVXz2XwzX8vGU7wLuqb2ZuwTuOFAzBLRM_QPk+NJa=eC-g@mail.gmail.com>
Subject: Bug report: git -L requires excessive memory.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
git log -L /regex/,/regex/:myfile to a repo in which 2MB text file is
committed about 2800 times.

What did you expect to happen? (Expected behavior)
get the result.

What happened instead? (Actual behavior)
fatal: Out of memory, malloc failed (tried to allocate 2346801 bytes)

What's different between what you expected and what actually happened?
The function requires too much memory.
-n option should work for -L function.

Anything else you want to add:
I made a script to reproduce this. Please run the script below.
Results in each environments are in its header.
A workaround which is given in other BBS is included also.




#!/bin/bash
#
# Bug report: git -L requires excessive memory.
# Run this script to reproduce
#
# MINGW32(git version 2.38.1.windows.1) fatal: Out of memory, malloc
failed (tried to allocate 2346801 bytes)
# MINGW64(git version 2.38.1.windows.1) requires  8.6GB
# Linux64(git version 2.20.1          ) requires 13.1GB
#

git --version

if [ ! -d .git ]; then
  git init
  c=${1:-3000}
  for (( i=0;i<c;i++)); do
    gawk -v r="$i" '
      BEGIN{
        for (i=0;i<100;i++) {
          if (r>=i) {
            printf("function func_%03d(){ // revised at %d\n",i,
int((r-i)/100)*100+i%100)
            printf("  // contents of function\n")
            printf("}\n")
            make_subfuncs(i);
          }
        }
        exit
      }
      function make_subfuncs(i,    j){
        for (j=0;j<300;j++) {
          printf("function func_%03d_sub%03d(){\n",i,j)
          printf("  // contents of sub functions are NOT revised.\n")
          printf("}\n")
        }
      }' > test.txt
    git add test.txt
    git commit -m "revision $i"
  done
  git gc
fi

git log -L /func_007\(/,/}$/:test.txt # this command requires excessive memory.
git log -L /func_007\(/,/}$/:test.txt -n 10 # -n option doesn't work also.
#git log -L /func_007\(/,/}$/:test.txt HEAD~10..HEAD~0 # this works.

#
# This can be a workaround
#
step=50
num=`git log | grep -c commit`
for ((i=0;i<$num;i+=$step)); do
  end=$((i+$step))
  range=HEAD~$end..HEAD~$i
  if [ $end -ge $num ]; then
    range=HEAD~$i
  fi
#  echo $range
  git --no-pager log -L /func_007\(/,/}$/:test.txt $range
done




[System Info]
[Enabled Hooks]
