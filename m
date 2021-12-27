Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B28C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 18:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhL0S0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 13:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhL0S0l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 13:26:41 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BD5C06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 10:26:41 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s1so33796246wra.6
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 10:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=8Gm1HHRZZ4+RLqp27cNkPjC4dDfgn4e7Gc6axhEdPdQ=;
        b=Jj6GR1SN/cksSTuVZBRQGC/fSVd4eU7+8Mmv7TqVEcupUwW8JwavKRtqp0MbzEo5iH
         8F+Pi/6eJToPca8BO+O3Xpj7qv8DErxt8FNWpZ1vnWsRs0StdyG+KquLuIFa7YVxzIHl
         2DVscLEm+WKdl+jsVhVSPXDg5ROeDeTMjcgeiO3Wsl8o6WhE4biENcKXjkN21ae7jAA4
         HO0BVGTovU4vsSs5eeqA7r5zzGdSzMFbDwpIpZA853AlPPe6/DLnG/2ktlKZDKI89dUr
         RM+ThK9wWFyC93zHVRvkG3U/l3cKTG6+L+17t5nsSPwCnp6aOS99ke+PdyFdBE/am+tk
         A5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8Gm1HHRZZ4+RLqp27cNkPjC4dDfgn4e7Gc6axhEdPdQ=;
        b=v/3eHPnGzDn2pE0C5b2+53h3uoFKCjWN6VJzCcxFu3/MqtAYKIhJs2JvQwPI3FahE0
         4iOJXM6Ct6xFi5zExHjY+coLvE8VPud+pudx3dzQgAQ09KGg0MoWj07qfiZJoynYCJ1r
         iPkw6NWE0h5joE22qwAB+jH54nby9zC0m4xOEzWGnDSFUO3u1iYU2C1uwwhm1GijNl12
         M3/kWnQ1i/C6GfJx1vgFvXPUdiuuGj/fRz41/xKm5vbgA3cjC6q0ulJ8zCair2Nx0q1i
         +V2tGi1+FSqlz4V6D+99xu7TyTA8UI5z9y+CGpn+ULqiDfcaCFFjxj1yTMWTKAiqG7hx
         zJCw==
X-Gm-Message-State: AOAM533MJqxkxyD/k7ZMB3w5+jpgAkuQfQCILRIi1/g5Rhkjyupl1HAv
        gTGmn7t3aDYv+W0VqJEm7SNUPyos4n0=
X-Google-Smtp-Source: ABdhPJyvQ3MYZ+ehszl6EhzuoTkDsI+BSx8j6a5NjulEZHZWBgsKUvqIZxYk2qL/jJ7at5ChNzMoWA==
X-Received: by 2002:adf:c606:: with SMTP id n6mr2209156wrg.481.1640629599714;
        Mon, 27 Dec 2021 10:26:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10sm18285464wrc.55.2021.12.27.10.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 10:26:39 -0800 (PST)
Message-Id: <pull.1125.git.git.1640629598.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Dec 2021 18:26:36 +0000
Subject: [PATCH 0/2] Consolidate find_header logic into one function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This addresses the NEEDSWORK comment in builtin/receive-pack.c:

 /**
   * NEEDSWORK: reuse find_commit_header() from jk/commit-author-parsing
   * after dropping "_commit" from its name and possibly moving it out
   * of commit.c
   **/


There is some duplicated logic between find_header and find_commit_header
that can be consolidated instead of having two places in the code that do
essentially the same thing. For the sake of simpler and more DRY code, use
find_commit_header and rename it to find_header since it is not limited to
finding headers for only commits.

This is my first attempt to address a NEEDSWORK issue, and I'm relatively
new to C so any feedback would be appreciated!

John Cai (2):
  receive-pack.c: consolidate find header logic
  commit.c: rename find_commit_header to find_header

 builtin/am.c                |  2 +-
 builtin/commit.c            |  2 +-
 builtin/receive-pack.c      | 48 ++++++++++++++++---------------------
 commit.c                    |  7 +++---
 commit.h                    |  2 +-
 gpg-interface.c             |  2 +-
 pretty.c                    |  2 +-
 sequencer.c                 |  2 +-
 t/helper/test-fast-rebase.c |  2 +-
 9 files changed, 32 insertions(+), 37 deletions(-)


base-commit: 2ae0a9cb8298185a94e5998086f380a355dd8907
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1125%2Fjohn-cai%2Fjc%2Freplace-find-header-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1125/john-cai/jc/replace-find-header-v1
Pull-Request: https://github.com/git/git/pull/1125
-- 
gitgitgadget
