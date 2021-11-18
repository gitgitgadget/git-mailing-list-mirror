Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F293CC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB24161A8A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhKRQoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhKRQoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:44:16 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9701FC061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 08:41:16 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id z26so8769595iod.10
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 08:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=j2viuBiNZD4ZaDdGkPu7YSVtJBbhw3O031RUL6XNSDY=;
        b=b4bDeN2ADCrxgFKG+55H8kNRd8cx2PhU9WTpLKA6K1F8i/ckKbTtFS63OMh1QVGtUt
         Z80ijG2tQw0KSQwypBfJVJ6sKG7Mh5oOcf2DPiGYm/+pUCg6ZIJEgl91gZm/sOqbM+NV
         I6ArCY+5HSmhJJaerMtUPOvQz06yhJyr0D0gifCvzV1YC3RfHSeZPezY4roLxFFmfEw6
         gYBBJJgpqVV0na+feaFhvO6cVs2Ec6ASU5FdBC1b3kqm54DEQdWA7Q3+Y77h6IN8AHMq
         Yf12XusV4I/m9MYpDM99mqhr0QAYqSCaXqMwFOHRMNyCJ201XOjEYqGW7CTwKZISFdRb
         MOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=j2viuBiNZD4ZaDdGkPu7YSVtJBbhw3O031RUL6XNSDY=;
        b=NDjI4Z/hQ2RgeeNvs1IzVC7aJIV5dRgp44PGc/qZ4hewemYOvClR+S45BKAvCA705K
         K1DZ8C2RomR8UwZ3moz/COH9BuxtScEWkB56P1BMRBkZZHsE+4E0xtDmhE5O+CbWXQ+D
         cHmO0UNuZqFwE1oI/W5fMFOA4dZb1hFhijJKEC4P3HV18VzuCwHuF9Rw23SPaKf/BtTG
         HCQXClzbTFFHg1BqtN7T2usT1TeDPrscyt/s/WM5JTW/773X3wN8a5g5gVE63NGTPU5y
         ahOy8CX8F5TvxIRykVYIVevkbU+y8ml3iEZu3Lv5iuv7QdVzHtjvcM2gwQqprRKo+jFK
         1hLg==
X-Gm-Message-State: AOAM532mjRhc+GK81h57kRs8jyM+x6k12f1beYVUUrVtVfB14Uks8ISu
        WnBsMsH+8svTlFKOMovWboy3i9VxnBUQ/MI/po8Ema6fAV8=
X-Google-Smtp-Source: ABdhPJyAA3rJ34e2U3XcRZJwMuQC9r2zxRkeX7vQU0hCYkW0ciWuaKrM6hJ89Z0p1IKcdx8OOehJpGHhSvOw0Pug5sw=
X-Received: by 2002:a05:6602:2cd4:: with SMTP id j20mr368783iow.106.1637253675532;
 Thu, 18 Nov 2021 08:41:15 -0800 (PST)
MIME-Version: 1.0
From:   Danial Alihosseini <danial.alihosseini@gmail.com>
Date:   Thu, 18 Nov 2021 20:11:04 +0330
Message-ID: <CACLOEFZz7bunO2S5-ec1K10B9AJU4-m50j3j9c=12R6d1D+-dg@mail.gmail.com>
Subject: git 2.34.0: Behavior of `**` in gitignore is different from previous versions.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Consider the following project structure
- data
  - data1
    - file1
    - file1.txt
  - data2
    - file2
    - file2.txt
- .gitignore


`.gitignore` is as follows:
```
data/**
!data/**/
!data/**/*.txt
```
What did you expect to happen? (Expected behavior)

I expect all files in `data` folder to be ignored except `.txt` files.

What happened instead? (Actual behavior)

`file1` and `file2` are not ignored.
Here is the `check-ignore` output:
```
$ git check-ignore -v data/data1/file1
.gitignore:2:!/data/**/ data/data1/file1
```

What's different between what you expected and what actually happened?
It seems that the behavior of `**` in gitignore is different from
previous versions.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.34.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.2-arch1-1
compiler info: gnuc: 11.1
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]
