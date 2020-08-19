Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C496FC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F7B207FF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqghN1ZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHSRQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHSRQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 13:16:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E73C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:16:55 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so22248559wrh.10
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=vD13crU6jJR342Cz1pHR2wsIxfJqx1N0ibPYyplDlLU=;
        b=sqghN1ZH2wb++3JGXJOdNbkZjZMW+U+kdFHoJP/gOHwdVINtQ98AlOV3ca4swEs8gS
         1fRYnSRL5XvabPeTLZe0m/whSWUOQWO2s4YovCkSBRFqSD5UjcLVl5Jx/mIIMk3QqyHM
         CWj6AR2xCPDoHjg6XfEB1EJST6MxB6LTMCeXE/p0yxkxXEeAv7aj1h+nHnYsw3kQjbio
         PdMSqOyDV4C0Fge1vQmUjoRrZbxc4CJJal0g3BBV9TRUYz17i/Z3Z7PLAo3o4wca7ZXU
         WyvmeU1MBf+n2VKP5yAi9wCQ3ypUKcrliwslIedMB7yTkcwM7J42smybbgNathQnr56S
         UizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vD13crU6jJR342Cz1pHR2wsIxfJqx1N0ibPYyplDlLU=;
        b=P5SG536SG6xLMgGrqG5T7vi86VKa5akjyEMGFNeSiNQcacv/UKgdxI1n75kKgQjuXr
         zOjJ9Ms3/8pdr5Dck72JuV38Xsv7Yb298L8mVOsANJVWTRthFIytgnPqDlmuEp1lAVft
         WaGlULf4jtviAVmz7ABiboGomrA0qoSPwqaFGCQrgyQcOboQW8HIjhE+mrEp9j0EmdK6
         KN2uRsIppSflyopejN46G5SLQNMoFFAMx6L5o9wRR8YQAbcdsnB53RYVA9909P5YnLNf
         Jdic3AA4PLdSFnkDFwoIYC1XiJ+07rEu7kFuQlkkCW8tZxUPzKT4reoRZhzAwkKOXNML
         i8Iw==
X-Gm-Message-State: AOAM533bO5qOJDfPPWGGAMbTmvb+MzCiuDGbCwhyUcrP+Xsg+3Ier8yd
        aE1Ev0EheK+Tjuh2tkAG4ie0hV1cIc0=
X-Google-Smtp-Source: ABdhPJzb6yUsMpHcI42S6cEOLy3SGnl5ctN01he6A0680k2BRtTY4TENNHkMcLIG82UGFIcZF06VMg==
X-Received: by 2002:adf:92a1:: with SMTP id 30mr28018185wrn.56.1597857414088;
        Wed, 19 Aug 2020 10:16:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11sm6061798wmi.15.2020.08.19.10.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 10:16:53 -0700 (PDT)
Message-Id: <pull.680.git.1597857408.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 17:16:41 +0000
Subject: [PATCH 0/7] [RFC] Maintenance III: background maintenance
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on ds/maintenance-part-2, but with some local updates to
review feedback. It won't apply cleanly right now. This RFC is for early
feedback and not intended to make a new tracking branch until v2.

This RFC is intended to show how I hope to integrate true background
maintenance into Git. As opposed to my original RFC [1], this entirely
integrates with cron (through crontab [-e|-l]) to launch maintenance
commands in the background.

[1] 
https://lore.kernel.org/git/pull.597.git.1585946894.gitgitgadget@gmail.com/

Some preliminary work is done to allow a new --scheduled option that
triggers enabled tasks only if they have not been run in some amount of
time. The timestamp of the previous run is stored in the 
maintenance.<task>.lastRun config value while the interval is stored in the 
maintenance.<task>.schedule config value.

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

The very last patch is entirely optional. It sets a recommended schedule
based on my own experience with very large repositories. I'm open to other
suggestions, but these are ones that I think work well and don't cause a
"rewrite the world" scenario like running nightly 'gc' would do.

I've been testing this scenario on my macOS laptop for a while and my Linux
machine. I have modified my cron task to provide logging via trace2 so I can
see what's happening. A future direction here would be to add some
maintenance logs to the repository so we can track what is happening and
diagnose whether the maintenance strategy is working on real repos.

It could be helpful for contributors to suggest ways to configure certain
jobs to run "nightly" or "overnight on a weekend" instead of just "whenever
the last run was long enough ago." One way to do this would be to set the 
lastRun config to be at the time of day that the job should run. Another
option would be to make the cron table more complicated with multiple rows,
but I would prefer to avoid that option if there is a simpler mechanism.

Note: git maintenance (start|stop) only works on machines with cron by
design. The proper thing to do on Windows will come later. Perhaps this
command should be marked as unavailable on Windows somehow, or at least a
better error than "cron may not be available on your system". I did find
that that message is helpful sometimes: macOS worker agents for CI builds
typically do not have cron available.

Thanks, -Stolee

Derrick Stolee (7):
  maintenance: optionally skip --auto process
  maintenance: store the "last run" time in config
  maintenance: add --scheduled option and config
  for-each-repo: run subcommands on configured repos
  maintenance: add [un]register subcommands
  maintenance: add start/stop subcommands
  maintenance: recommended schedule in register/start

 .gitignore                           |   1 +
 Documentation/config/maintenance.txt |  19 ++
 Documentation/git-for-each-repo.txt  |  45 +++++
 Documentation/git-maintenance.txt    |  44 ++++-
 Makefile                             |   2 +
 builtin.h                            |   1 +
 builtin/for-each-repo.c              |  58 ++++++
 builtin/gc.c                         | 282 ++++++++++++++++++++++++++-
 git-gvfs-helper                      | Bin 0 -> 11171736 bytes
 git.c                                |   1 +
 run-command.c                        |   8 +
 t/helper/test-crontab.c              |  35 ++++
 t/helper/test-gvfs-protocol          | Bin 0 -> 10946928 bytes
 t/helper/test-tool.c                 |   1 +
 t/helper/test-tool.h                 |   1 +
 t/t0068-for-each-repo.sh             |  30 +++
 t/t7900-maintenance.sh               |  95 ++++++++-
 t/test-lib.sh                        |   6 +
 18 files changed, 625 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/git-for-each-repo.txt
 create mode 100644 builtin/for-each-repo.c
 create mode 100755 git-gvfs-helper
 create mode 100644 t/helper/test-crontab.c
 create mode 100755 t/helper/test-gvfs-protocol
 create mode 100755 t/t0068-for-each-repo.sh


base-commit: 0c43c64dd2fb41ac14038f1c3143bddbc6c35585
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-680%2Fderrickstolee%2Fmaintenance%2Fscheduled-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-680/derrickstolee/maintenance/scheduled-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/680
-- 
gitgitgadget
