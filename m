Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46A8C433E2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E162206F2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0rrcF8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbgIDNJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730348AbgIDNJT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 09:09:19 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BBBC061244
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 06:09:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so6659121wrs.11
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 06:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qolEFt3iMnDsYImRMfH8w4QIXscOrH2sZq7Cx9AzSFI=;
        b=u0rrcF8oZV+XEieeykU3RZZJboK8EIaAK9/stBZByPtuE4oQ5mPyvHMdTC5IniFCQr
         NHQLxLvlOL65z9VZKBCNeJ7jwGP/UO4cfJfEHv+lG89ueB92vHtW7qBQlm/Ks2086mNR
         +/necsEa3dJ8mYF+qMS1ks/BZjtBvQ4kuZgdgXjRPtgopWqeERcKQfFxaAYp0yga7sQ9
         rIIW+YOScqj2DcH7wMwmlzKGPWeWuFOFIlYS7yKW1PtsoxKzDQ8PtmqHWMGsvIZL8tTL
         NFRQyiM1+o/k4kkeISRrRyFZ/VnwxOLQX1shIqE1tcHXQmJcVz6k6W9OUq7rEieQuEi8
         xbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qolEFt3iMnDsYImRMfH8w4QIXscOrH2sZq7Cx9AzSFI=;
        b=pA1So13pWvIw2uv8yPvOR+qp/6qOUEFQBtoUmrJL6/KrVGUlTTNGQJ8mWP6Qz+HCkn
         X+67Zcuj5ZFgi0UxHvVpFfSL1re6vRwlxOpfVGqKd0Der1ZUr9KaImzPMYTX0+gnIuw0
         xShbMA3iyFQkx7xuxnSLHksUTaruTyqQhQgpr/zFyyQtQ+OkcTyN9QB7HprD5pJmQaJq
         st1Q+KVn9WdN8dTR9MfVdXfqJTGrr7XNEFd+ICU5Q7KyrYKyLhk8Zlh6Um/cQ1u0HYpm
         wh7qGaIOgwZDrIcLHi9xcZSwECeg33Qzaj0EweZMbMLaS93cvRAXgqljZXiF9jrAwH11
         THAg==
X-Gm-Message-State: AOAM5333/s3C1ad5MhiVH6Z+QLPyXTok3CtfNtmZJvczFEDRS+/IzFXU
        eH7NAF+OybKBy5CF6j4/h2dryKf5BZI=
X-Google-Smtp-Source: ABdhPJzNa/3Ci6R2BuTrYDW+ODq9X7C8BjiW8rqanEzEJuG3ISChBXpu8paQxOXgrmvPUWeWqflFWA==
X-Received: by 2002:adf:f707:: with SMTP id r7mr7616576wrp.413.1599224957361;
        Fri, 04 Sep 2020 06:09:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2sm12275056wrn.44.2020.09.04.06.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 06:09:16 -0700 (PDT)
Message-Id: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
References: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Sep 2020 13:09:04 +0000
Subject: [PATCH v4 00/11] Maintenance I: Command, gc and commit-graph tasks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on jc/no-update-fetch-head.

This patch series contains 11patches that were going to be part of v4 of
ds/maintenance [1], but the discussion has gotten really long. To help focus
the conversation, I'm splitting out the portions that create and test the
'maintenance' builtin from the additional tasks (prefetch, loose-objects,
incremental-repack) that can be brought in later.

[1] 
https://lore.kernel.org/git/pull.671.git.1594131695.gitgitgadget@gmail.com/

As mentioned before, git gc already plays the role of maintaining Git
repositories. It has accumulated several smaller pieces in its long history,
including:

 1. Repacking all reachable objects into one pack-file (and deleting
    unreachable objects).
 2. Packing refs.
 3. Expiring reflogs.
 4. Clearing rerere logs.
 5. Updating the commit-graph file.
 6. Pruning worktrees.

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
 * 'prefetch' : fetch from each remote, storing the refs in 'refs/prefetch/
   /'.

The only included tasks are the 'gc' and 'commit-graph' tasks. The rest will
follow in a follow-up series. Including the 'commit-graph' task here allows
us to build and test features like config settings and the --task= 
command-line argument.

These tasks are all disabled by default, but can be enabled with config
options or run explicitly using "git maintenance run --task=". There are
additional config options to allow customizing the conditions for which the
tasks run during the '--auto' option.

 Because 'gc' is implemented as a maintenance task, the most dramatic change
of this series is to convert the 'git gc --auto' calls into 'git maintenance
run --auto' calls at the end of some Git commands. By default, the only
change is that 'git gc --auto' will be run below an additional 'git
maintenance' process.

The 'git maintenance' builtin has a 'run' subcommand so it can be extended
later with subcommands that manage background maintenance, such as 'start'
or 'stop'. These are not the subject of this series, as it is important to
focus on the maintenance activities themselves.

Updates since v3
================

 * Two commit-message typos are fixed.

Thanks for all of the review!

Updates since v2
================

 * Based on jc/no-update-fetch-head instead of jk/strvec.
   
   
 * I realized that the other maintenance subcommands should not accept the
   options for the 'run' subcommand, so I reorganized the option parsing
   into that subcommand. This makes the range-diff noisier than it would
   have been otherwise.
   
   
 * While updating the parsing, I also updated the usage strings.
   
   
 * The "verify, then delete and rewrite on failure" logic is removed. I'll
   consider bringing this back with a way to test the behavior in a later
   patch series.
   
   
 * Other feedback from Jonathan Tan is applied.
   
   

Updates since v1 (of this series)
=================================

 * Documentation fixes.
   
   
 * The builtin code had some slight tweaks in PATCH 1.
   
   

UPDATES since v3 of [1]
=======================

 * The biggest change here is the use of "test_subcommand", based on
   Jonathan Nieder's approach. This requires having the exact command-line
   figured out, which now requires spelling out all --no- [quiet%7Cprogress] 
   options. I also added a bunch of "2>/dev/null" checks because of the
   isatty(2) calls. Without that, the behavior will change depending on
   whether the test is run with -x/-v or without.
   
   
 * The option parsing has changed to use a local struct and pass that struct
   to the helper methods. This is instead of having a global singleton.
   
   

Thanks, -Stolee

Cc: sandals@crustytoothpaste.net [sandals@crustytoothpaste.net], 
steadmon@google.com [steadmon@google.com], jrnieder@gmail.com
[jrnieder@gmail.com], peff@peff.net [peff@peff.net], congdanhqx@gmail.com
[congdanhqx@gmail.com], phillip.wood123@gmail.com
[phillip.wood123@gmail.com], emilyshaffer@google.com
[emilyshaffer@google.com], sluongng@gmail.com [sluongng@gmail.com], 
jonathantanmy@google.com [jonathantanmy@google.com]

Derrick Stolee (11):
  maintenance: create basic maintenance runner
  maintenance: add --quiet option
  maintenance: replace run_auto_gc()
  maintenance: initialize task array
  maintenance: add commit-graph task
  maintenance: add --task option
  maintenance: take a lock on the objects directory
  maintenance: create maintenance.<task>.enabled config
  maintenance: use pointers to check --auto
  maintenance: add auto condition for commit-graph task
  maintenance: add trace2 regions for task execution

 .gitignore                           |   1 +
 Documentation/config.txt             |   2 +
 Documentation/config/maintenance.txt |  16 ++
 Documentation/fetch-options.txt      |   6 +-
 Documentation/git-clone.txt          |   6 +-
 Documentation/git-maintenance.txt    |  79 +++++++
 builtin.h                            |   1 +
 builtin/am.c                         |   2 +-
 builtin/commit.c                     |   2 +-
 builtin/fetch.c                      |   6 +-
 builtin/gc.c                         | 336 +++++++++++++++++++++++++++
 builtin/merge.c                      |   2 +-
 builtin/rebase.c                     |   4 +-
 command-list.txt                     |   1 +
 commit-graph.c                       |   8 +-
 commit-graph.h                       |   1 +
 git.c                                |   1 +
 object.h                             |   1 +
 run-command.c                        |  16 +-
 run-command.h                        |   2 +-
 t/t5510-fetch.sh                     |   2 +-
 t/t5514-fetch-multiple.sh            |   2 +-
 t/t7900-maintenance.sh               |  63 +++++
 t/test-lib-functions.sh              |  33 +++
 24 files changed, 565 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/config/maintenance.txt
 create mode 100644 Documentation/git-maintenance.txt
 create mode 100755 t/t7900-maintenance.sh


base-commit: 887952b8c680626f4721cb5fa57704478801aca4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-695%2Fderrickstolee%2Fmaintenance%2Fbuiltin-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-695/derrickstolee/maintenance/builtin-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/695

Range-diff vs v3:

  1:  aa961af387 =  1:  aa961af387 maintenance: create basic maintenance runner
  2:  5386d8a628 =  2:  5386d8a628 maintenance: add --quiet option
  3:  e28b332df4 =  3:  e28b332df4 maintenance: replace run_auto_gc()
  4:  82326c1c38 =  4:  82326c1c38 maintenance: initialize task array
  5:  06984a42bf =  5:  06984a42bf maintenance: add commit-graph task
  6:  69298aee24 =  6:  69298aee24 maintenance: add --task option
  7:  3d513acdd8 !  7:  c57998a1c8 maintenance: take a lock on the objects directory
     @@ Commit message
          lock is never committed, since it does not represent meaningful data.
          Instead, it is only a placeholder.
      
     -    If the lock file already exists, then fail with a warning. If '--auto'
     -    is specified, then instead no warning is shown and no tasks are attempted.
     -    This will become very important later when we implement the 'prefetch'
     -    task, as this is our stop-gap from creating a recursive process loop
     -    between 'git fetch' and 'git maintenance run --auto'.
     +    If the lock file already exists, then no maintenance tasks are
     +    attempted. This will become very important later when we implement the
     +    'prefetch' task, as this is our stop-gap from creating a recursive process
     +    loop between 'git fetch' and 'git maintenance run --auto'.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
  8:  712f5f2d8e =  8:  dc2a092366 maintenance: create maintenance.<task>.enabled config
  9:  69d3b48fd4 =  9:  f5f1e85b03 maintenance: use pointers to check --auto
 10:  4c3115fe35 ! 10:  8f84b03c46 maintenance: add auto condition for commit-graph task
     @@ Commit message
          option.
      
          To compute the count, use a depth-first search starting at each ref, and
     -    leaving markers using the PARENT1 flag. If this count reaches the limit,
     +    leaving markers using the SEEN flag. If this count reaches the limit,
          then terminate early and start the task. Otherwise, this operation will
          peel every ref and parse the commit it points to. If these are all in
          the commit-graph, then this is typically a very fast operation. Users
 11:  652a8eac57 = 11:  2d6414d89b maintenance: add trace2 regions for task execution

-- 
gitgitgadget
