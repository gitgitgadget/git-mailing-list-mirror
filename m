Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBE8C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B3020771
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwFhVIRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgGGOVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGOVi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA60C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so37271781wrs.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=kuLtLX58bcOOwwX666v2MIZVDIjJSDFVxYyDnwbkG/0=;
        b=dwFhVIRD24sOZ+9GoO70/Mr72EQIpJ48FW51i0gEU0ojapvfEwx8ipnM7R0fQoolKa
         K/Tnx7hB2vRpEYxtq0EcJI7CMCmD8VMRQfc941PmIZFJkmRM77gCa+owUYbuGFV2+7Ui
         QIUFK7s337ZPpX2a2fSk98kOXING9VlXBvjR4UkmThxZCuDPMu3vqi1/8hUmlojaJpWa
         0GXcokEwBrve6IZ1LfR2MeVi8pBQmDjYmtg/yh3kbAr32WM7Po5mosda4NsgSI1+G/Ck
         G28miVGE26XldxFdiChdSrpMFtny5cvFrjsXmMm/RXF5cSj+cKchr02QlSeqlchZqNKD
         xYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kuLtLX58bcOOwwX666v2MIZVDIjJSDFVxYyDnwbkG/0=;
        b=fZR2t7buud6L45Q+9RxM9L8efEd1yiPgDledeMqBdqJvB+YNylKSdG/XSJ4G7093S9
         jW5a3sbrxfBryzEmZsQS9iFn4Hk5CIMeHJvTD0fKOVyHnSxDnoKoxnkfx7K8kqw/XDWU
         6YoHWps9U6QF4P+3yv6/5QuvMtAe61XeRivTR3xwtnGVNR94zvlRvPvRjgxXJk27jip8
         5oGmTlLllOXOCN+EK+WOEzMSP8J2hg3aubEyAUJup2K8zs3uJAW5wGvqyB7znBQMx+5h
         JJ13NbXGBYM5M/y3kzFRnawJYXcOH4CMM1GObRhzMa56/zm1VsokoCj3iEYkamm8N7KV
         UJSA==
X-Gm-Message-State: AOAM53029TP6GCChxkeplGk72MHLjdhfDNfjtnchNqB+0ajiujpXp+fK
        qB/IAgjI0Siey2FmyHaARjfjeizL
X-Google-Smtp-Source: ABdhPJyKpzjIvQEmzBtjVYZfZJV4/TAt4rh9Yx4DCwxuu0cAXZp1TVUsB7jU3P0Za4HCPvmrUIYvSQ==
X-Received: by 2002:adf:ed87:: with SMTP id c7mr52359770wro.422.1594131696758;
        Tue, 07 Jul 2020 07:21:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 65sm1625171wre.6.2020.07.07.07.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:36 -0700 (PDT)
Message-Id: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:14 +0000
Subject: [PATCH 00/21] Maintenance builtin, allowing 'gc --auto' customization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a second attempt at redesigning Git's repository maintenance
patterns. The first attempt [1] included a way to run jobs in the background
using a long-lived process; that idea was rejected and is not included in
this series. A future series will use the OS to handle scheduling tasks.

[1] 
https://lore.kernel.org/git/pull.597.git.1585946894.gitgitgadget@gmail.com/

As mentioned before, git gc already plays the role of maintaining Git
repositories. It has accumulated several smaller pieces in its long history,
including:

 1. Repacking all reachable objects into one pack-file (and deleting
    unreachable objects).
 2. Packing refs.
 3. Expiring reflogs.
 4. Clearing rerere logs.
 5. Updating the commit-graph file.

While expiring reflogs, clearing rererelogs, and deleting unreachable
objects are suitable under the guise of "garbage collection", packing refs
and updating the commit-graph file are not as obviously fitting. Further,
these operations are "all or nothing" in that they rewrite almost all
repository data, which does not perform well at extremely large scales.
These operations can also be disruptive to foreground Git commands when git
gc --auto triggers during routine use.

This series does not intend to change what git gc does, but instead create
new choices for automatic maintenance activities, of which git gc remains
the only one enabled by default.

The new maintenance tasks are:

 * 'commit-graph' : write and verify a single layer of an incremental
   commit-graph.
 * 'loose-objects' : prune packed loose objects, then create a new pack from
   a batch of loose objects.
 * 'pack-files' : expire redundant packs from the multi-pack-index, then
   repack using the multi-pack-index's incremental repack strategy.
 * 'fetch' : fetch from each remote, storing the refs in 'refs/hidden//'.

These tasks are all disabled by default, but can be enabled with config
options or run explicitly using "git maintenance run --task=". There are
additional config options to allow customizing the conditions for which the
tasks run during the '--auto' option. ('fetch' will never run with the
'--auto' option.)

 Because 'gc' is implemented as a maintenance task, the most dramatic change
of this series is to convert the 'git gc --auto' calls into 'git maintenance
run --auto' calls at the end of some Git commands. By default, the only
change is that 'git gc --auto' will be run below an additional 'git
maintenance' process.

The 'git maintenance' builtin has a 'run' subcommand so it can be extended
later with subcommands that manage background maintenance, such as 'start',
'stop', 'pause', or 'schedule'. These are not the subject of this series, as
it is important to focus on the maintenance activities themselves.

An expert user could set up scheduled background maintenance themselves with
the current series. I have the following crontab data set up to run
maintenance on an hourly basis:

0 * * * * git -C /<path-to-repo> maintenance run --no-quiet >>/<path-to-repo>/.git/maintenance.log

My config includes all tasks except the 'gc' task. The hourly run is
over-aggressive, but is sufficient for testing. I'll replace it with daily
when I feel satisfied.

Hopefully this direction is seen as a positive one. My goal was to add more
options for expert users, along with the flexibility to create background
maintenance via the OS in a later series.

OUTLINE
=======

Patches 1-4 remove some references to the_repository in builtin/gc.c before
we start depending on code in that builtin.

Patches 5-7 create the 'git maintenance run' builtin and subcommand as a
simple shim over 'git gc' and replaces calls to 'git gc --auto' from other
commands.

Patches 8-15 create new maintenance tasks. These are the same tasks sent in
the previous RFC.

Patches 16-21 create more customization through config and perform other
polish items.

FUTURE WORK
===========

 * Add 'start', 'stop', and 'schedule' subcommands to initialize the
   commands run in the background.
   
   
 * Split the 'gc' builtin into smaller maintenance tasks that are enabled by
   default, but might have different '--auto' conditions and more config
   options.
   
   
 * Replace config like 'gc.writeCommitGraph' and 'fetch.writeCommitGraph'
   with use of the 'commit-graph' task.
   
   

Thanks, -Stolee

Derrick Stolee (21):
  gc: use the_repository less often
  gc: use repository in too_many_loose_objects()
  gc: use repo config
  gc: drop the_repository in log location
  maintenance: create basic maintenance runner
  maintenance: add --quiet option
  maintenance: replace run_auto_gc()
  maintenance: initialize task array and hashmap
  maintenance: add commit-graph task
  maintenance: add --task option
  maintenance: take a lock on the objects directory
  maintenance: add fetch task
  maintenance: add loose-objects task
  maintenance: add pack-files task
  maintenance: auto-size pack-files batch
  maintenance: create maintenance.<task>.enabled config
  maintenance: use pointers to check --auto
  maintenance: add auto condition for commit-graph task
  maintenance: create auto condition for loose-objects
  maintenance: add pack-files auto condition
  midx: use start_delayed_progress()

 .gitignore                           |   1 +
 Documentation/config.txt             |   2 +
 Documentation/config/maintenance.txt |  32 +
 Documentation/fetch-options.txt      |   5 +-
 Documentation/git-clone.txt          |   7 +-
 Documentation/git-maintenance.txt    | 124 ++++
 builtin.h                            |   1 +
 builtin/am.c                         |   2 +-
 builtin/commit.c                     |   2 +-
 builtin/fetch.c                      |   6 +-
 builtin/gc.c                         | 881 +++++++++++++++++++++++++--
 builtin/merge.c                      |   2 +-
 builtin/rebase.c                     |   4 +-
 commit-graph.c                       |   8 +-
 commit-graph.h                       |   1 +
 config.c                             |  24 +-
 config.h                             |   2 +
 git.c                                |   1 +
 midx.c                               |  12 +-
 midx.h                               |   1 +
 object.h                             |   1 +
 run-command.c                        |   7 +-
 run-command.h                        |   2 +-
 t/t5319-multi-pack-index.sh          |  14 +-
 t/t5510-fetch.sh                     |   2 +-
 t/t5514-fetch-multiple.sh            |   2 +-
 t/t7900-maintenance.sh               | 211 +++++++
 27 files changed, 1265 insertions(+), 92 deletions(-)
 create mode 100644 Documentation/config/maintenance.txt
 create mode 100644 Documentation/git-maintenance.txt
 create mode 100755 t/t7900-maintenance.sh


base-commit: 4a0fcf9f760c9774be77f51e1e88a7499b53d2e2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-671%2Fderrickstolee%2Fmaintenance%2Fgc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-671/derrickstolee/maintenance/gc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/671
-- 
gitgitgadget
