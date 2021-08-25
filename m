Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901CDC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 01:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73EA2610FD
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 01:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhHYBwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 21:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhHYBwU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 21:52:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DC6C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 18:51:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id j14-20020a1c230e000000b002e748b9a48bso2766429wmj.0
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 18:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=bFqXUvr28lgJAjeQGhE1kVh2NhFk90io4RkM12dyX98=;
        b=efhOZw7QVTt2+2AJ5etBUk23B2r+mPBqZgJpRXsnzjuckfFgKQJ+99KLoOyQxpId/L
         WAS5NFVbULaEuQPtBHSYtLNsLXZQQsVZbBbQMfDw3sISvnRfi5Xf2TRqL7P6Dnj7PEgO
         EhHlJZEhA2knTXQWKMGDWRgVvxoCbPWm8TWJ8ATxI/9B2Rq+/WXOHMpkVnd+5/0NXnYj
         9ThYjjyvNZ3Xi8vIzQaca1wRaHU9cw+O7FmCruigJkqZ2ZrJDncldmL5c4E+mInoBUBg
         UnCMuuE7DI+4r2iP7WEPDAmRnyi2MSWNNDzbV2rPDDFAhCdDoK8DL+JPSUkns3q1RoSj
         pThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bFqXUvr28lgJAjeQGhE1kVh2NhFk90io4RkM12dyX98=;
        b=cihQpvhCDS96yuffsyd0KvE6eogClHEEnMdMmUQS9b1r0reL9Q7qI/+7hWE5e8wtCZ
         XPxbsNq3xBPDSJH+52xo7JXomp/pyTgmmRlkLatI0sB9bq9ogUHghEK3RWGAgvxmwmfu
         ayUSoY9FTt/fmPIaWdSs/l9PjDPWPecrQgu8gCLSiKTXp7Goo2Xml9em/YHugXO8DM/3
         /1RXzoLkvzRvlWwTyFjV91Q4wyLBbXJ5yB8eCWaMqVylKkwEHF/EZEbP4lyiM63R/LE4
         oYJMcvfMV6hnMX4JAnVNBpr+4f2zBhWklFHx1yp2PuK06+Z4C1gw7dFzGZQIbU8Twufr
         GbNg==
X-Gm-Message-State: AOAM532DDt+2XG8TBVzWfCT/8jGboX5QHtpKWHUsjLx38YBrRBPa3Q8y
        Y/YJSqUjC/+GTFF0mcTUfHq2NldYzVs=
X-Google-Smtp-Source: ABdhPJxVo4FTWPCoLdxvnsCLKcoMrlBI1E6Wa4qXDsztcR3g7X4okeNDnOfSQm/4RFOldrEFH2yr1g==
X-Received: by 2002:a05:600c:a41:: with SMTP id c1mr6541558wmq.109.1629856294058;
        Tue, 24 Aug 2021 18:51:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b4sm19020273wro.97.2021.08.24.18.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 18:51:33 -0700 (PDT)
Message-Id: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Aug 2021 01:51:30 +0000
Subject: [PATCH 0/2] [RFC] Implement a bulk-checkin option for core.fsyncObjectFiles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git for Windows has had fsyncing of object files enabled since "409cae91eb
(mingw: change core.fsyncObjectFiles = 1 by default, 2017-09-04)".

There have been requests to make core.fsyncObjectFiles the default
everywhere, but there are concerns about its performance cost (perf results
below). There's a long and gory thread here:
https://lore.kernel.org/git/87a7xcw8sa.fsf@linux-m68k.org/t/.

My change introduces the new 'core.fsyncobjectFiles = 2' setting, which
batches the data-integrity FLUSH command sent to the disk across multiple
loose object files added to the object database.

We take advantage of the bulk-checkin hooks already in the add command and
add some hooks to the update-index (which is used internally by stash).
Details are in the last patch of the series.

Here's a simple performance test script:

    #!/bin/sh
    git clone https://github.com/nodejs/node.git node-repo-cache
    git clone node-repo-cache node-repo
    cd node-repo
    git --version
    
    find . -name "*.c" -exec sh -c 'echo foo1 >> $1' -- {} \;
    echo "----GIT stash fsync"
    time git -c core.fsyncObjectFiles=true stash push
    
    find . -name "*.c" -exec sh -c 'echo foo2 >> $1' -- {} \;
    echo "----GIT stash fsync_defer"
    time git -c core.fsyncObjectFiles=2 stash push
    
    find . -name "*.c" -exec sh -c 'echo foo3 >> $1' -- {} \;
    echo "----GIT stash no_fsync"
    time git -c core.fsyncObjectFiles=false stash push
    
    cd ..
    rm -r -f node-repo


Hardware:

 * Mac - Mac Mini 2018 running MacOS 11.5.1, APFS with a 1TB Apple NMVE SSD,
 * Linux - Ubuntu 20.04 - ext4 running on a Hyper-V VM with a fixed VHDX
   backed by a Samsung PM981.
 * Win - Windows NTFS - Same Hyper-V host as Linux. Operation | Mac | Linux
   | Windows

---------------- |---------|-------|---------- git fsync | 40.6 s | 7.8 s |
6.9s git fsync_defer | 6.5 s | 2.1 s | 3.8s git no_fsync | 1.7 s | 1.0 s |
2.6s

The windows version of git is slightly different:
https://github.com/git-for-windows/git/pull/3391. I also used a
Windows-specific test script.

I hope I'm CC'ing a reasonable set of people on this patch, based on the
last discussion.

Thanks, Neeraj Singh Windows Core File Systems.

Neeraj Singh (2):
  object-file: use futimes rather than utime
  core.fsyncobjectfiles: batch disk flushes

 Documentation/config/core.txt |  17 ++++--
 Makefile                      |   4 ++
 builtin/add.c                 |   3 +-
 builtin/update-index.c        |   3 +
 bulk-checkin.c                | 105 +++++++++++++++++++++++++++++++---
 bulk-checkin.h                |   4 +-
 compat/mingw.c                |  42 +++++++++-----
 compat/mingw.h                |   2 +
 config.c                      |   4 +-
 config.mak.uname              |   2 +
 configure.ac                  |   8 +++
 git-compat-util.h             |   7 +++
 object-file.c                 |  23 ++------
 wrapper.c                     |  36 ++++++++++++
 write-or-die.c                |   2 +-
 15 files changed, 213 insertions(+), 49 deletions(-)


base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1076%2Fneerajsi-msft%2Fneerajsi%2Fbulk-fsync-object-files-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1076/neerajsi-msft/neerajsi/bulk-fsync-object-files-v1
Pull-Request: https://github.com/git/git/pull/1076
-- 
gitgitgadget
