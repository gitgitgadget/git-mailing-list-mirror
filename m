Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859C9C433ED
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 13:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2D361492
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 13:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbhDXNrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 09:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhDXNqz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Apr 2021 09:46:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AB8C061574
        for <git@vger.kernel.org>; Sat, 24 Apr 2021 06:46:15 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so2667227wmq.4
        for <git@vger.kernel.org>; Sat, 24 Apr 2021 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=tDaUWtPlgrHCr82PxZumVNT1+aE8Vc4mGAj0CpqleFs=;
        b=dYeg9ctXGT0cazNrQg0mVaISS3QuNoB9GpNjfQuEwe6ZIWZmA7zHz+mIO34vUBTirD
         O+/QNMX6TUqK2k8qfWMSFVQvl/U1F/J1/2Oj2s7jNXistyJv2JHrN2rHHhW+McKIC8PU
         MvCjBoW9qTdUmGF78Rp30MTriqCcU1P+mYjRzCYQTfQItX/PtL5CHhqq9vvvdogFEZ9Y
         S4Ym2UXLuWv8tstc/UQSeIzCvZ8R040b6uuBa+c12gkemThgL4IgK587Qa77YKqCD4lD
         tJDVY4/lcuiqlVB70TXngEE6KQ524gm/tQfYO28fvgEmn7rt+AM6CYkUw/WTyc/K2ZoK
         hjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tDaUWtPlgrHCr82PxZumVNT1+aE8Vc4mGAj0CpqleFs=;
        b=nKzHwv/hsFw4IhBNwSKTtwlqIK2RB577FYzRtT0xvXD5gCjfgGR8vL6NWDqfqeiIfD
         0AvtjurXSo5iYxK69C0J6lk84eq13ZPKScDa9+wQfnqbuyDDok6wdjAI5fYnw8xKxZHl
         gw7VS6Rp4KdoX/zWGVkKhQIweBMI2hjYEVxBlGbmJV0R2jcx+3Um05GU8Pnb1Etr2u7A
         7ALzwQrH+HHTns0VpfelYoMsaYXFZAqUIpHksJ9F8AdUFKq36LaBJYylWMPIIuegwqwV
         OE6qAHadepdBj63eq1TqwZomHF4qcMcmhh83sBOI2SsPLxfsWtGQKpmKAE7Lryind1IX
         xrFw==
X-Gm-Message-State: AOAM531fRiPEzSu4ByemFnmuVOqpntYdF57SfbHU+hQYR/7piHzxNd1O
        gvRTHP2HI1v0qvAewcTeboffMQ3iaRuNXw==
X-Google-Smtp-Source: ABdhPJzg1wFkkt38+Yf1AWA2Lt9TrW+v6esROtl2RjQMnArvXF0QHs96uAhWKBZ7DStHW7IgLH0O1Q==
X-Received: by 2002:a05:600c:20d:: with SMTP id 13mr9434197wmi.29.1619271974035;
        Sat, 24 Apr 2021 06:46:14 -0700 (PDT)
Received: from [192.168.0.169] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id n16sm2410252wrp.50.2021.04.24.06.46.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Apr 2021 06:46:13 -0700 (PDT)
To:     git <git@vger.kernel.org>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Subject: git pull --rebase silently skipping commits
Message-ID: <17e490f6-c393-0232-3236-3c1758b8bd25@gmail.com>
Date:   Sat, 24 Apr 2021 15:46:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I started my PC and as always did a 'git fetch'.  I noticed that I 
forgot to push a commit the other day, so I had the following situation:

alx@msi:~/src/alx/config$ git tree -8
* 226e73c - Thu, 22 Apr 2021 22:28:37 +0200 (2 days ago) (tag: v0.8.0, 
origin/main, origin/HEAD)
|           Makefile: ffix - Alejandro Colomar
* 29cac15 - Thu, 22 Apr 2021 22:21:56 +0200 (2 days ago)
|           Makefile: remove unused option of read - Alejandro Colomar
* 5adc827 - Thu, 22 Apr 2021 22:20:16 +0200 (2 days ago)
|           Makefile: use INSTALL_DATA instead of plain install - 
Alejandro Colomar
* 28df09e - Thu, 22 Apr 2021 22:12:40 +0200 (2 days ago)
|           Makefile: Don't hardcode things - Alejandro Colomar
* 9cdb873 - Thu, 22 Apr 2021 22:11:32 +0200 (2 days ago)
|           ssh: Simplify code, and don't overwrite other contents of 
.ssh/config - Alejandro Colomar
| * 4d2f5ad - Thu, 22 Apr 2021 19:22:16 +0200 (2 days ago) (HEAD -> main)
|/            sudo: Rename user alex to alx - Alejandro Colomar
* ad1d205 - Thu, 22 Apr 2021 12:51:10 +0200 (2 days ago) (tag: v0.7.0)
|           hosts: Don't overwrite the hole file - Alejandro Colomar
* c5137b5 - Wed, 21 Apr 2021 14:14:34 +0200 (3 days ago) (tag: v0.6.2)
|           Makefile: ffix - Alejandro Colomar
alx@msi:~/src/alx/config$



Normally I would've run 'git rebase origin/main', but recently I knew 
about 'git pull --rebase', so I was tried it.  However, to my surprise, 
it silently skipped the local commit:

alx@msi:~/src/alx/config$ git pull --rebase
Successfully rebased and updated refs/heads/main.
alx@msi:~/src/alx/config$ git tree -8
* 226e73c - Thu, 22 Apr 2021 22:28:37 +0200 (2 days ago) (HEAD -> main, 
tag: v0.8.0, origin/main, origin/HEAD)
|           Makefile: ffix - Alejandro Colomar
* 29cac15 - Thu, 22 Apr 2021 22:21:56 +0200 (2 days ago)
|           Makefile: remove unused option of read - Alejandro Colomar
* 5adc827 - Thu, 22 Apr 2021 22:20:16 +0200 (2 days ago)
|           Makefile: use INSTALL_DATA instead of plain install - 
Alejandro Colomar
* 28df09e - Thu, 22 Apr 2021 22:12:40 +0200 (2 days ago)
|           Makefile: Don't hardcode things - Alejandro Colomar
* 9cdb873 - Thu, 22 Apr 2021 22:11:32 +0200 (2 days ago)
|           ssh: Simplify code, and don't overwrite other contents of 
.ssh/config - Alejandro Colomar
* ad1d205 - Thu, 22 Apr 2021 12:51:10 +0200 (2 days ago) (tag: v0.7.0)
|           hosts: Don't overwrite the hole file - Alejandro Colomar
* c5137b5 - Wed, 21 Apr 2021 14:14:34 +0200 (3 days ago) (tag: v0.6.2)
|           Makefile: ffix - Alejandro Colomar
* 5244a5c - Wed, 21 Apr 2021 14:12:05 +0200 (3 days ago) (tag: v0.6.1)
|           sshd: restart service after installing - Alejandro Colomar
alx@msi:~/src/alx/config$


When trying 'git pull --rebase=interactive', I see the following:

noop 

 

# Rebase 4d2f5ad..4d2f5ad onto 226e73c (1 command)


I'd expect 'git pull --rebase' to be an equivalent of 'git fetch origin 
&& git rebase origin/main'.  But this time I had to use rebase:

alx@msi:~/src/alx/config$ git reset 4d2f --h
HEAD is now at 4d2f5ad sudo: Rename user alex to alx
alx@msi:~/src/alx/config$ git tree -8
* 226e73c - Thu, 22 Apr 2021 22:28:37 +0200 (2 days ago) (tag: v0.8.0, 
origin/main, origin/HEAD)
|           Makefile: ffix - Alejandro Colomar
* 29cac15 - Thu, 22 Apr 2021 22:21:56 +0200 (2 days ago)
|           Makefile: remove unused option of read - Alejandro Colomar
* 5adc827 - Thu, 22 Apr 2021 22:20:16 +0200 (2 days ago)
|           Makefile: use INSTALL_DATA instead of plain install - 
Alejandro Colomar
* 28df09e - Thu, 22 Apr 2021 22:12:40 +0200 (2 days ago)
|           Makefile: Don't hardcode things - Alejandro Colomar
* 9cdb873 - Thu, 22 Apr 2021 22:11:32 +0200 (2 days ago)
|           ssh: Simplify code, and don't overwrite other contents of 
.ssh/config - Alejandro Colomar
| * 4d2f5ad - Thu, 22 Apr 2021 19:22:16 +0200 (2 days ago) (HEAD -> main)
|/            sudo: Rename user alex to alx - Alejandro Colomar
* ad1d205 - Thu, 22 Apr 2021 12:51:10 +0200 (2 days ago) (tag: v0.7.0)
|           hosts: Don't overwrite the hole file - Alejandro Colomar
* c5137b5 - Wed, 21 Apr 2021 14:14:34 +0200 (3 days ago) (tag: v0.6.2)
|           Makefile: ffix - Alejandro Colomar
alx@msi:~/src/alx/config$ git rebase origin/main
Successfully rebased and updated refs/heads/main.
alx@msi:~/src/alx/config$ git tree -8
* 72f6ab9 - Thu, 22 Apr 2021 19:22:16 +0200 (2 days ago) (HEAD -> main)
|           sudo: Rename user alex to alx - Alejandro Colomar
* 226e73c - Thu, 22 Apr 2021 22:28:37 +0200 (2 days ago) (tag: v0.8.0, 
origin/main, origin/HEAD)
|           Makefile: ffix - Alejandro Colomar
* 29cac15 - Thu, 22 Apr 2021 22:21:56 +0200 (2 days ago)
|           Makefile: remove unused option of read - Alejandro Colomar
* 5adc827 - Thu, 22 Apr 2021 22:20:16 +0200 (2 days ago)
|           Makefile: use INSTALL_DATA instead of plain install - 
Alejandro Colomar
* 28df09e - Thu, 22 Apr 2021 22:12:40 +0200 (2 days ago)
|           Makefile: Don't hardcode things - Alejandro Colomar
* 9cdb873 - Thu, 22 Apr 2021 22:11:32 +0200 (2 days ago)
|           ssh: Simplify code, and don't overwrite other contents of 
.ssh/config - Alejandro Colomar
* ad1d205 - Thu, 22 Apr 2021 12:51:10 +0200 (2 days ago) (tag: v0.7.0)
|           hosts: Don't overwrite the hole file - Alejandro Colomar
* c5137b5 - Wed, 21 Apr 2021 14:14:34 +0200 (3 days ago) (tag: v0.6.2)
|           Makefile: ffix - Alejandro Colomar
alx@msi:~/src/alx/config$


I wonder if it may be due to this text, which I don't really understand:

alx@msi:~$ man git-pull | sed -n '/-r, --rebase/,/^$/p'
        -r, --rebase[=false|true|merges|preserve|interactive]
            When true, rebase the current branch on top of the
            upstream branch after fetching. If there is a
            remote-tracking branch corresponding to the upstream
            branch and the upstream branch was rebased since last
            fetched, the rebase uses that information to avoid
            rebasing non-local changes.

What does it mean "the upstream branch was rebased since last fetched"?
May it be the reason that it skipped that commit?  Isn't 'git pull 
--rebase' designed for what I'm using it?  In this case it's not really 
necessary, but it removes the need for specifying the branch I'm on, 
which is why I preferred it over 'git rebase'.


Thanks,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
Senior SW Engineer; http://www.alejandro-colomar.es/
