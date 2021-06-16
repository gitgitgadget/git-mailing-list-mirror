Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB72C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA6F611BE
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhFPASY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 20:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhFPASY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 20:18:24 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45579C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 17:16:18 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id h3so736125ilc.9
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 17:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rosekunkel-me.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=5OOmEEA5+riO7ZEG4lBriDU99/GisUxZ5d9b+j6P92Y=;
        b=rfsCuXDQZhuEibZX8fjvlknR90q/t/UA9I2rGGkfzrTXHelxR5aopsxtEeMXcqtR4q
         5xJIz3Bic3pi50Tx+5ZlC2Jo5hqYIJodqU6BzPEGEjdV1J8QBB59H2ZMJKkuqArvj7qH
         yFYyXnKjxGpL8htDl9gVY+qjqO9F6JmGytDF75CXZGc6VUAu8klV3C0njPY3d536aqGY
         TRGGxa7JbeYxUIm+O3hxRLHgfAiEqQKF/QWR/URFOByg+b1l4aIsP8+PvaNcLZtKt6fI
         aOGMKNhVf3EofPxgmG8BhP62RPcXx70xk2/qbl9ZmVSOY7RzokbdsX5v0Khj136XFRmW
         VwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5OOmEEA5+riO7ZEG4lBriDU99/GisUxZ5d9b+j6P92Y=;
        b=GrmFNtEEBiZiHef+5Ub1fGkQoG49nq2oWUhmo6ymXTg13gV3ouZJ73Uqgh+ipL7XC5
         Rh+qqKBaeGNiGvrx7TvxHOEkpNtSlCO66uFifzWHfY2TfKqLl/NhN8/4WvJQZKuAc+yX
         5gLbJb4OlH8jHAnUNfN+yrymd/1wctunyOqd/2dnO5dZh/pg4Omut4dN7ildxSqjS0Y/
         ogmJGkzfwyHPzlY5aoPeQgCcSI8WTloEI6/YnNQEGj9pS/cMR6Mtd392FP0w2uZe4A0v
         VhiZXuAWigqHh6mWnw26SWpuHo2M5UrB9nkMZL2NSwpvo5ujjoijsQI4xMnKTwXlJssc
         sgDA==
X-Gm-Message-State: AOAM532rVRSQgjQjR0Q4jGJ80uodAtGU7gCv1kNkOH2+E5wUEzjzJMlJ
        qYwXSSnDw6YvWyd5/hTH00vcV+q/qBhluJul2U84JbJXrN7hAw==
X-Google-Smtp-Source: ABdhPJwujGjPpNYn3nJK2FRreVfQv8pdQmXOOqSQ9uOfj41CKzRmVO59YI5ADKjjoTiqdTQ6igPr4LR1H0OfN8AFXVM=
X-Received: by 2002:a05:6e02:4d0:: with SMTP id f16mr1498478ils.252.1623802577520;
 Tue, 15 Jun 2021 17:16:17 -0700 (PDT)
MIME-Version: 1.0
From:   Rose Kunkel <rose@rosekunkel.me>
Date:   Tue, 15 Jun 2021 17:16:06 -0700
Message-ID: <CAKjYmsELpf9r3bAJj_JUHgVegw_7z2KzyuR_6FYYngpC1XmNeg@mail.gmail.com>
Subject: [BUG] `git reset --hard` fails with `update = none` submodules
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# What did you do before the bug happened? (Steps to reproduce your issue)
1. Clone a git repository that sets `update = none` in .gitmodules:
$ git clone --recurse-submodules https://github.com/ubolonton/tree-sitter-langs

2. Perform a hard reset:
$ cd tree-sitter-langs
$ git reset --hard

# What did you expect to happen? (Expected behavior)
The reset should succeed and do nothing.

# What happened instead? (Actual behavior)
The reset command fails with
```
fatal: not a git repository: ../../.git/modules/repos/agda
fatal: could not reset submodule index
```

[System Info]
git version:
git version 2.32.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.12.10-hardened1-1-hardened #1 SMP PREEMPT Thu, 10 Jun
2021 21:12:42 +0000 x86_64
compiler info: gnuc: 11.1
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /usr/bin/zsh
