Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A448DC77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 13:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjEBNvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 09:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbjEBNvr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 09:51:47 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D2710F
        for <git@vger.kernel.org>; Tue,  2 May 2023 06:51:34 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1aaec6f189cso19329185ad.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 06:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1683035494; x=1685627494;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EJbi73xirC2lgQWKHbsYdSrRrzinZxe1WYO6TaTD9no=;
        b=Y15YB3nBa4uuOll3ou8OoiPQ9hOWnaFvJXnBq2H1VrauSZ2rQlRYGpsxGOTxsQATAU
         aOI4xjQqt0tcMCeC+zFDevYXMoxAYEfbrryHGu/05Yabw0K7ZD1JOARxAM0c/wLEZ97e
         Gi1V4VeyEOOqg5eA8245RoJvrrJ2xiI44TlMzOkEFOXzHe6xg/S/elU0zyGY74PPilAa
         P0aJ5FD1EY/4oY7i5MwRT8/Wr2dDgDCbUVy6STg79euvlc/AS/p2l0NiLKcmThtMnVjz
         vT7Iudoinr47wMQxQ3H+x5iABCUayLVcOuSbpI8ShDbM9XfgjaEUN3KwOJOz/L8vT6vP
         kcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683035494; x=1685627494;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJbi73xirC2lgQWKHbsYdSrRrzinZxe1WYO6TaTD9no=;
        b=XYUap1QiWE1sq/ekCYKhOnT6EMmwHz11PUt3k3j58sD1xgSYGmvDHR3O6l3NdFIR95
         CxxVHpF5up908PYZbIWMawV1YntKPpTNR66xiPKNhZ8I5OVz/mxkk8t2zu+DLpeRW1y+
         dZnzqKs/dEIeXXrzy7PBdggoN5gmKyTlSYNiu+BXfcpFf3yDus/KFJa2M4QFq2pOwBAd
         ETZjoaAHJ3FUVNevMPhn5+FHL1On76qjWBjp0sq0R2CyF3sNYsqJDw9uzBcbUbjdVmXW
         LLqJvFn21twR482MD1MVijFjTeV4qnTwsm5UJegT2gT468N96eZnUS12wP5PemTdmttC
         uVkA==
X-Gm-Message-State: AC+VfDxeU8nqFHpVTsDC9mjF9M62ZTAhCYea/nQL5RGGYCYwHZpezXWt
        uyE9hCGusGDVVfsNcrl4iiJT30KMiPo3Toq1JvuBD+F4BFl4zkCi2vw=
X-Google-Smtp-Source: ACHHUZ5MmMpHgtU8qBeF/RrPkQ+BbePhS48Va8r3h4EJ7erJE6Wb8L8MV0E9vWgHSV+Rwo1b1m81KVXx/aysXKdsLXo=
X-Received: by 2002:a17:903:230d:b0:1a9:3b64:3747 with SMTP id
 d13-20020a170903230d00b001a93b643747mr21120850plh.17.1683035493566; Tue, 02
 May 2023 06:51:33 -0700 (PDT)
MIME-Version: 1.0
From:   Anthony Sottile <asottile@umich.edu>
Date:   Tue, 2 May 2023 09:51:26 -0400
Message-ID: <CA+dzEBm-uVbsiq26J+Zt10RDg7sEH2FFTwAhbeXOaH_0u0Rx=g@mail.gmail.com>
Subject: cannot checkout file in partial clone on windows
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this appears to be a windows-specific issue

short reproduction:

```bash
set -euxo pipefail

rm -rf t
git init t
cd t
git remote add origin https://github.com/pre-commit/pre-commit-hooks
git config extensions.partialClone true
git fetch origin HEAD --quiet --filter=blob:none --tags

git checkout v4.4.0 -- .pre-commit-hooks.yaml

ls -al
```

on linux it produces this output:

```console
$ bash t.sh
+ rm -rf t
+ git init t
Initialized empty Git repository in /tmp/t/.git/
+ cd t
+ git remote add origin https://github.com/pre-commit/pre-commit-hooks
+ git config extensions.partialClone true
+ git fetch origin HEAD --quiet --filter=blob:none --tags
+ git checkout v4.4.0 -- .pre-commit-hooks.yaml
remote: Enumerating objects: 1, done.
remote: Counting objects: 100% (1/1), done.
remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (1/1), 1.73 KiB | 1.73 MiB/s, done.
+ ls -al
total 36
drwxr-xr-x  3 asottile asottile  4096 May  2 09:48 .
drwxrwxrwt 27 root     root     20480 May  2 09:47 ..
drwxr-xr-x  7 asottile asottile  4096 May  2 09:48 .git
-rw-r--r--  1 asottile asottile  6950 May  2 09:48 .pre-commit-hooks.yaml

```

on windows it does the following:

```console
>bash t.sh
+ rm -rf t
+ git init t
Initialized empty Git repository in
C:/Users/Anthony/workspace/pre-commit/t/.git/
+ cd t
+ git remote add origin https://github.com/pre-commit/pre-commit-hooks
+ git config extensions.partialClone true
+ git fetch origin HEAD --quiet --filter=blob:none --tags
+ git checkout v4.4.0 -- .pre-commit-hooks.yaml
remote: Enumerating objects: 1, done.
remote: Counting objects: 100% (1/1), done.
remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (1/1), 1.73 KiB | 1.73 MiB/s, done.
error: unable to read sha1 file of .pre-commit-hooks.yaml
(f8523d4a677b2904df1ebf50c826323b2555edeb)
```

I can work around it by running `git show
v4.4.0:.pre-commit-hooks.yaml > /dev/null` before the checkout oddly
enough:

```console
>bash t.sh
+ rm -rf t
+ git init t
Initialized empty Git repository in
C:/Users/Anthony/workspace/pre-commit/t/.git/
+ cd t
+ git remote add origin https://github.com/pre-commit/pre-commit-hooks
+ git config extensions.partialClone true
+ git fetch origin HEAD --quiet --filter=blob:none --tags
+ git show v4.4.0:.pre-commit-hooks.yaml
remote: Enumerating objects: 1, done.
remote: Counting objects: 100% (1/1), done.
remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (1/1), 1.73 KiB | 1.73 MiB/s, done.
+ git checkout v4.4.0 -- .pre-commit-hooks.yaml
+ ls -al
total 20
drwxr-xr-x 1 Anthony 197609    0 May  2 09:50 .
drwxr-xr-x 1 Anthony 197609    0 May  2 09:50 ..
drwxr-xr-x 1 Anthony 197609    0 May  2 09:50 .git
-rw-r--r-- 1 Anthony 197609 6950 May  2 09:50 .pre-commit-hooks.yaml
```

anthony
