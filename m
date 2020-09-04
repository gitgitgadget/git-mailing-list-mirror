Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5BDC433E2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 15:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C852074D
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 15:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X668khKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIDPma (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIDPmK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 11:42:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61FDC061244
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 08:42:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t10so7237062wrv.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Y+o7t/lhqY8ybLsC2ndu/awZGrjI4fISeZRWi8jeoqI=;
        b=X668khKe41MODWsWsJWs5R0UCNtxGgsMhn5rrNH6q8tbSt/KYtT9f6c4KZimAH/LY4
         M2hVvyDtf/AQQx6subvQhk+uojHo92DhArT/yuSWKS3O1ZhsuJDc3f8uKPQgFBiswwkm
         me9+CIgfeyAHjNx88XVXgs1UfJqvNk/5BCe69R3mbnm8IlAtq7Zyyd7x4oqGRFazGDxA
         6lV87Zc4BAuRx3hePfwPOcyolSZ3L9hn1Oy5DCtur7rBnqRuu0eU5suLNJacc7oozS2I
         Ea8i8iZUEwa0mgpkqHWJ5/vbZq8PVH0USCDxkCnRw/uZR//BQ/I8QS+P2rlVN4nIWkfF
         kIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y+o7t/lhqY8ybLsC2ndu/awZGrjI4fISeZRWi8jeoqI=;
        b=eWw1VmSFtuh2/Bp7WVsn9GgCHmEeseNB8td+mHn4WD+2gBAF8AulLoG4wO8H+mftuN
         YLrDZ9nn57rlBB9WQRmQHB/F7II8rDNjvdUZC8ttxgA6KfzIiAdIAT/G+qhYAGRWI98i
         URl5e7kWmpCmC8ITMuRvbRJmP/moCVhGKB+P5Sjb2ATxO+28rcdx9GMD6LY+okaK/OZZ
         Fyu2HS6b0RkCEb1DAgEirqjonkSI9MdDGvPvgJQmgUNo7bSStSELXrg6WEyaWPYjdnLY
         dD6z4hPqg9vxOWiVVIPlrIapCyR3BVaugs7tdUDLIZBqAiVbChdw/Xm56dWyG4HUOKSu
         q0RA==
X-Gm-Message-State: AOAM530/x4vrRzGnVXH9wMPfEQDnWDVBO65bK4vJ56MEP9caOpg2G4Mr
        FiGQdEOD/GNqiZRf05yyOU5r2TgNMnY=
X-Google-Smtp-Source: ABdhPJxGPabD0CVpCv09+R0GGaCKM00SFoI8Ty0CAF0mpkjP9ZvnJl4xrqVd/EDOGnABKCNjOC1i/g==
X-Received: by 2002:adf:b602:: with SMTP id f2mr7939046wre.186.1599234128009;
        Fri, 04 Sep 2020 08:42:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h184sm12592302wmh.41.2020.09.04.08.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:42:07 -0700 (PDT)
Message-Id: <pull.724.git.1599234126.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Sep 2020 15:41:59 +0000
Subject: [PATCH 0/7] Maintenance III: Background maintenance
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        congdanhqx@gmail.com, Derrick Stolee <derrickstolee@github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on ds/maintenance-part-2 and replaces the RFC from [1].

[1] 
https://lore.kernel.org/git/pull.680.v3.git.1598629517.gitgitgadget@gmail.com/

This series introduces background maintenance to Git, through an integration
with cron and crontab.

Some preliminary work is done to allow a new --schedule option that tells
the command which tasks to run based on a maintenance.<task>.schedule config
option. The timing is not enforced by Git, but instead is expected to be
provided as a hint from a cron schedule. The options are "hourly", "daily",
and "weekly".

A new for-each-repo builtin runs Git commands on every repo in a given list.
Currently, the list is stored as a config setting, allowing a new 
maintenance.repos config list to store the repositories registered for
background maintenance. Others may want to add a --file=<file> option for
their own workflows, but I focused on making this as simple as possible for
now.

The updates to the git maintenance builtin include new register/unregister 
subcommands and start/stop subcommands. The register subcommand initializes
the config while the start subcommand does everything register does plus 
update the cron table. The unregister and stop commands reverse this
process.

A troubleshooting guide is added to Documentation/git-maintenance.txt to
advise expert users who choose to create custom cron schedules.

The very last patch is entirely optional. It sets a recommended schedule
based on my own experience with very large repositories. I'm open to other
suggestions, but these are ones that I think work well and don't cause a
"rewrite the world" scenario like running nightly 'gc' would do.

I've been testing this scenario on my macOS laptop and Linux desktop. I have
modified my cron task to provide logging via trace2 so I can see what's
happening. A future direction here would be to add some maintenance logs to
the repository so we can track what is happening and diagnose whether the
maintenance strategy is working on real repos.

Note: git maintenance (start|stop) only works on machines with cron by
design. The proper thing to do on Windows will come later. Perhaps this
command should be marked as unavailable on Windows somehow, or at least a
better error than "cron may not be available on your system". I did find
that that message is helpful sometimes: macOS worker agents for CI builds
typically do not have cron available.

Derrick Stolee (7):
  maintenance: optionally skip --auto process
  maintenance: add --schedule option and config
  for-each-repo: run subcommands on configured repos
  maintenance: add [un]register subcommands
  maintenance: add start/stop subcommands
  maintenance: recommended schedule in register/start
  maintenance: add troubleshooting guide to docs

 .gitignore                           |   1 +
 Documentation/config/maintenance.txt |  10 +
 Documentation/git-for-each-repo.txt  |  59 ++++++
 Documentation/git-maintenance.txt    |  88 +++++++-
 Makefile                             |   2 +
 builtin.h                            |   1 +
 builtin/for-each-repo.c              |  58 ++++++
 builtin/gc.c                         | 292 ++++++++++++++++++++++++++-
 command-list.txt                     |   1 +
 git.c                                |   1 +
 run-command.c                        |   6 +
 t/helper/test-crontab.c              |  35 ++++
 t/helper/test-tool.c                 |   1 +
 t/helper/test-tool.h                 |   1 +
 t/t0068-for-each-repo.sh             |  30 +++
 t/t7900-maintenance.sh               | 114 ++++++++++-
 t/test-lib.sh                        |   6 +
 17 files changed, 698 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/git-for-each-repo.txt
 create mode 100644 builtin/for-each-repo.c
 create mode 100644 t/helper/test-crontab.c
 create mode 100755 t/t0068-for-each-repo.sh


base-commit: e576ac2c7c7f6c7aa5ac08a516baeb61bf723596
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-724%2Fderrickstolee%2Fmaintenance%2Fscheduled-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-724/derrickstolee/maintenance/scheduled-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/724
-- 
gitgitgadget
