Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD21C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9DB22220A
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdzQ2USm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIQSS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIQSMh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 14:12:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57180C06178B
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:11:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so3047884wrp.8
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kSI9asZgyeAS+QqjtKULGkysNH3KTOVTQ2HN0PLBsbo=;
        b=qdzQ2USmvqcQ2RImr85BgANHqu9gAALOYou8YXOnmm/9B52qphyTRMbghKmFdtKOV3
         F5bErMAoRlLQhmtgolvgj/lQZyXGZh8Bhwpl2OjakTm6KAtRDf9dtIo7fLu8RH3Liszs
         j6TdbncCAkNpM0BvNazyVnAq7DZdbXpx3L0caF7YvLzdpOfkAw++8B9KO0Ual6fO+Yk8
         om2Rik3GQghfrZNJiyIzNlksI/tgG4h+hAsLBXE5vkEYT4aC5YCnDCDBH3v8u0MBRbW6
         xXT2/9t1LFzkvEezKDIDomMOElK84b2YdC+79c0AsXorgMdVvxs+vE3aEpN6hkefcTU+
         mUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kSI9asZgyeAS+QqjtKULGkysNH3KTOVTQ2HN0PLBsbo=;
        b=bPSpMOsdKUmCwnogw79ecIvkfdtoILx7kuJ7EMc3Yzxlrph1r9npTg2vU0NEbx/5WR
         oYwGvQyJa69Ygeqf9RWcj2MOPwnklnfmaUXhb49mXV1cxWkEyrlXLe5kgXsOsVT7QcWG
         EFsbw2FQxuvIGRUaVj93GrD8GToUgV6BoypEER4aq+Dag+XB0zMAj8jIeU7TzbpjiKm7
         iyOJedGKCsUS9ivBIEHYOWQ/Ldad4WXX07FqPvx+M6VrnLHjF8k+dZcl9oU6rZy+qmT7
         O0EGrKYXuccb786O9vVFFfUj0qaSzFH4vHHttbzKgI4o6tywCS/0wkGtgvGY9ZVJQdBI
         QpKQ==
X-Gm-Message-State: AOAM531a9fQWJpHILPymu2AiyCgZQzgLPSs+5PU9ChwDXoLydfRSE2Oo
        ek0ZLATKohHJs6aWrWgnHQq6qamqe8o=
X-Google-Smtp-Source: ABdhPJzZHin6Mu4CO8yxanGr6JQQUjvKJM+T+L59KCKL8wu4XrvGf5fCSWg4n5TfS/z53dcz3g44lQ==
X-Received: by 2002:adf:84c3:: with SMTP id 61mr33022712wrg.131.1600366314591;
        Thu, 17 Sep 2020 11:11:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w81sm356524wmg.47.2020.09.17.11.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 11:11:54 -0700 (PDT)
Message-Id: <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
References: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Sep 2020 18:11:41 +0000
Subject: [PATCH v5 00/11] Maintenance I: Command, gc and commit-graph tasks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>
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

Update in v4
============

A segfault when running just "git maintenance" is fixed.

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
 builtin/gc.c                         | 337 +++++++++++++++++++++++++++
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
 t/t7900-maintenance.sh               |  65 ++++++
 t/test-lib-functions.sh              |  33 +++
 24 files changed, 568 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/config/maintenance.txt
 create mode 100644 Documentation/git-maintenance.txt
 create mode 100755 t/t7900-maintenance.sh


base-commit: 887952b8c680626f4721cb5fa57704478801aca4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-695%2Fderrickstolee%2Fmaintenance%2Fbuiltin-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-695/derrickstolee/maintenance/builtin-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/695

Range-diff vs v4:

  1:  aa961af387 !  1:  00a0d63508 maintenance: create basic maintenance runner
     @@ Commit message
      
          Helped-by: Jonathan Nieder <jrnieder@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## .gitignore ##
      @@
     @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
      +
      +int cmd_maintenance(int argc, const char **argv, const char *prefix)
      +{
     -+	if (argc == 2 && !strcmp(argv[1], "-h"))
     ++	if (argc < 2 ||
     ++	    (argc == 2 && !strcmp(argv[1], "-h")))
      +		usage(builtin_maintenance_usage);
      +
      +	if (!strcmp(argv[1], "run"))
     @@ t/t7900-maintenance.sh (new)
      +	test_expect_code 129 git maintenance -h 2>err &&
      +	test_i18ngrep "usage: git maintenance run" err &&
      +	test_expect_code 128 git maintenance barf 2>err &&
     -+	test_i18ngrep "invalid subcommand: barf" err
     ++	test_i18ngrep "invalid subcommand: barf" err &&
     ++	test_expect_code 129 git maintenance 2>err &&
     ++	test_i18ngrep "usage: git maintenance" err
      +'
      +
      +test_expect_success 'run [--auto]' '
  2:  5386d8a628 !  2:  52eb937f49 maintenance: add --quiet option
     @@ Commit message
          Pipe the option to the 'git gc' child process.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Documentation/git-maintenance.txt ##
      @@ Documentation/git-maintenance.txt: OPTIONS
     @@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'help text' '
     - 	test_i18ngrep "invalid subcommand: barf" err
     + 	test_i18ngrep "usage: git maintenance" err
       '
       
      -test_expect_success 'run [--auto]' '
  3:  e28b332df4 !  3:  3cbdeeafb5 maintenance: replace run_auto_gc()
     @@ Commit message
          documentation to include these options at the same time.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Documentation/fetch-options.txt ##
      @@ Documentation/fetch-options.txt: ifndef::git-pull[]
  4:  82326c1c38 !  4:  1d2f2731bd maintenance: initialize task array
     @@ Commit message
          Helped-by: Taylor Blau <me@ttaylorr.com>
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/gc.c ##
      @@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_run_opts *opts)
  5:  06984a42bf !  5:  8204ebbf83 maintenance: add commit-graph task
     @@ Commit message
          argument when writing the commit-graph.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Documentation/git-maintenance.txt ##
      @@ Documentation/git-maintenance.txt: run::
  6:  69298aee24 !  6:  91b8555c9e maintenance: add --task option
     @@ Commit message
          member should be ignored if --task=<task> appears.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Documentation/git-maintenance.txt ##
      @@ Documentation/git-maintenance.txt: SUBCOMMANDS
  7:  c57998a1c8 !  7:  1a0a3eebb8 maintenance: take a lock on the objects directory
     @@ Commit message
          loop between 'git fetch' and 'git maintenance run --auto'.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/gc.c ##
      @@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts)
  8:  dc2a092366 !  8:  713207b4a1 maintenance: create maintenance.<task>.enabled config
     @@ Commit message
          tasks (or turn off the 'gc' task).
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Documentation/config.txt ##
      @@ Documentation/config.txt: include::config/mailinfo.txt[]
  9:  f5f1e85b03 !  9:  d424cda058 maintenance: use pointers to check --auto
     @@ Commit message
          gc.autoDetach as a maintenance.autoDetach config option.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/gc.c ##
      @@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_run_opts *opts)
 10:  8f84b03c46 ! 10:  7a2a4e1e52 maintenance: add auto condition for commit-graph task
     @@ Commit message
          run every time.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Documentation/config/maintenance.txt ##
      @@ Documentation/config/maintenance.txt: maintenance.<task>.enabled::
 11:  2d6414d89b ! 11:  20a74abd96 maintenance: add trace2 regions for task execution
     @@ Commit message
          maintenance: add trace2 regions for task execution
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/gc.c ##
      @@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts)

-- 
gitgitgadget
