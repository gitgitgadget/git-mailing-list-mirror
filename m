Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD45DC433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D9A42071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkKR3XB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgHYSdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYSdv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:33:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045B2C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:33:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x9so3102845wmi.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Dl3gLz/Xj7wHX9FuGuC79UT5ZZvK5skikmiByTEeZhc=;
        b=WkKR3XB/plj2RvBKpYO1Fsc5P25fvfzGLYu60Io95ujJkw7Ra4Uo3OwxYbYtF4x++E
         Z4mYMsCyTb19ozAlIdY+BZKxqn+KGGFimOpuTrqVjxYHV7AiSwjokIcU5v9901s75+H/
         cdWo6AhltT1YODing3ao2SYcmMMEjIZ41o7/NHIygTrLb2349n1QCkRItrjwdt0lHyRp
         GwyIzB71N5TKWxzw3+nALdfTsudlSm6uh5yx7RKJjYChPdDwsWrPb3QqUBxBDMUfmfqM
         8pKme5gxH38sHpD8XlQD2V7Sj9d4Km6VIbmFtP1QYoQPkenaN7tBdCVFVojnkqo+3C7h
         qjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Dl3gLz/Xj7wHX9FuGuC79UT5ZZvK5skikmiByTEeZhc=;
        b=YEyN6kNgI4HyHtOxxfS0lIJHclnTYRM4Ze1NZl/qij7WWDsy17fdY78bO3MHv8YxnX
         PDg+9gvz21uwwpP8lauMUpIHmxsA1GLQYY4RSyj/ZI+4zKap7yO+r5gJj+I3jEbdm61E
         Q4BXZIbUepmLoAARWytb5N8/QvtOBjaZYzGGuQBhmwpkcuiSMYa1pzxaMyFM5XCji8Bl
         1NEj5CgXbhrG+5gsVpREieWCWaXfPE7OlV7R3w++8nY3kP8Mg411BoGV29vwOi+tcVV4
         o889ebSwbh7QcVMaHJvRLTSSG5g8J4fqv6zLBAFEpNkHYUR1oiMxXvTjPQRrl1Hjfbvy
         HwmA==
X-Gm-Message-State: AOAM532p5NaZd3u/EdXdfiENm454X+/EN9AOGuvwqa9G2cKMg8MAXdDV
        3k1Jp7mK8xZheGzfw2WyaJD6gON8HbU=
X-Google-Smtp-Source: ABdhPJyT3fvDFm/XZVTEYtoOMukZH+x+5lpl6tht0oqAC+tr1QmscZLAyvOw3OefCMs/CysQuw/EvA==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr3349033wms.165.1598380428450;
        Tue, 25 Aug 2020 11:33:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm7581469wmb.48.2020.08.25.11.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:33:47 -0700 (PDT)
Message-Id: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
References: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:33:35 +0000
Subject: [PATCH v3 00/11] Maintenance I: Command, gc and commit-graph tasks
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-695%2Fderrickstolee%2Fmaintenance%2Fbuiltin-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-695/derrickstolee/maintenance/builtin-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/695

Range-diff vs v2:

  1:  e09e4a4a87 !  1:  aa961af387 maintenance: create basic maintenance runner
     @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
       	return 0;
       }
      +
     -+static const char * const builtin_maintenance_usage[] = {
     -+	N_("git maintenance run [<options>]"),
     ++static const char * const builtin_maintenance_run_usage[] = {
     ++	N_("git maintenance run [--auto]"),
      +	NULL
      +};
      +
     -+struct maintenance_opts {
     ++struct maintenance_run_opts {
      +	int auto_flag;
      +};
      +
     -+static int maintenance_task_gc(struct maintenance_opts *opts)
     ++static int maintenance_task_gc(struct maintenance_run_opts *opts)
      +{
      +	struct child_process child = CHILD_PROCESS_INIT;
      +
     @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
      +	return run_command(&child);
      +}
      +
     -+static int maintenance_run(struct maintenance_opts *opts)
     ++static int maintenance_run(int argc, const char **argv, const char *prefix)
      +{
     -+	return maintenance_task_gc(opts);
     -+}
     -+
     -+int cmd_maintenance(int argc, const char **argv, const char *prefix)
     -+{
     -+	struct maintenance_opts opts;
     -+	struct option builtin_maintenance_options[] = {
     ++	struct maintenance_run_opts opts;
     ++	struct option builtin_maintenance_run_options[] = {
      +		OPT_BOOL(0, "auto", &opts.auto_flag,
      +			 N_("run tasks based on the state of the repository")),
      +		OPT_END()
      +	};
     -+
      +	memset(&opts, 0, sizeof(opts));
      +
     -+	if (argc == 2 && !strcmp(argv[1], "-h"))
     -+		usage_with_options(builtin_maintenance_usage,
     -+				   builtin_maintenance_options);
     -+
      +	argc = parse_options(argc, argv, prefix,
     -+			     builtin_maintenance_options,
     -+			     builtin_maintenance_usage,
     -+			     PARSE_OPT_KEEP_UNKNOWN);
     ++			     builtin_maintenance_run_options,
     ++			     builtin_maintenance_run_usage,
     ++			     PARSE_OPT_STOP_AT_NON_OPTION);
     ++
     ++	if (argc != 0)
     ++		usage_with_options(builtin_maintenance_run_usage,
     ++				   builtin_maintenance_run_options);
     ++	return maintenance_task_gc(&opts);
     ++}
     ++
     ++static const char builtin_maintenance_usage[] = N_("git maintenance run [<options>]");
      +
     -+	if (argc != 1)
     -+		usage_with_options(builtin_maintenance_usage,
     -+				   builtin_maintenance_options);
     ++int cmd_maintenance(int argc, const char **argv, const char *prefix)
     ++{
     ++	if (argc == 2 && !strcmp(argv[1], "-h"))
     ++		usage(builtin_maintenance_usage);
      +
     -+	if (!strcmp(argv[0], "run"))
     -+		return maintenance_run(&opts);
     ++	if (!strcmp(argv[1], "run"))
     ++		return maintenance_run(argc - 1, argv + 1, prefix);
      +
     -+	die(_("invalid subcommand: %s"), argv[0]);
     ++	die(_("invalid subcommand: %s"), argv[1]);
      +}
      
     + ## command-list.txt ##
     +@@ command-list.txt: git-ls-remote                           plumbinginterrogators
     + git-ls-tree                             plumbinginterrogators
     + git-mailinfo                            purehelpers
     + git-mailsplit                           purehelpers
     ++git-maintenance                         mainporcelain
     + git-merge                               mainporcelain           history
     + git-merge-base                          plumbinginterrogators
     + git-merge-file                          plumbingmanipulators
     +
       ## git.c ##
      @@ git.c: static struct cmd_struct commands[] = {
       	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
  2:  adae48d235 !  2:  5386d8a628 maintenance: add --quiet option
     @@ Documentation/git-maintenance.txt: OPTIONS
       Part of the linkgit:git[1] suite
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static const char * const builtin_maintenance_usage[] = {
     +@@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
     + }
       
     - struct maintenance_opts {
     + static const char * const builtin_maintenance_run_usage[] = {
     +-	N_("git maintenance run [--auto]"),
     ++	N_("git maintenance run [--auto] [--[no-]quiet]"),
     + 	NULL
     + };
     + 
     + struct maintenance_run_opts {
       	int auto_flag;
      +	int quiet;
       };
       
     - static int maintenance_task_gc(struct maintenance_opts *opts)
     -@@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_opts *opts)
     + static int maintenance_task_gc(struct maintenance_run_opts *opts)
     +@@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_run_opts *opts)
       
       	if (opts->auto_flag)
       		strvec_push(&child.args, "--auto");
     @@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_opts *opts)
       
       	close_object_store(the_repository->objects);
       	return run_command(&child);
     -@@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
     - 	struct option builtin_maintenance_options[] = {
     +@@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char *prefix)
     + 	struct option builtin_maintenance_run_options[] = {
       		OPT_BOOL(0, "auto", &opts.auto_flag,
       			 N_("run tasks based on the state of the repository")),
      +		OPT_BOOL(0, "quiet", &opts.quiet,
      +			 N_("do not report progress or other information over stderr")),
       		OPT_END()
       	};
     - 
     -@@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
     - 		usage_with_options(builtin_maintenance_usage,
     - 				   builtin_maintenance_options);
     + 	memset(&opts, 0, sizeof(opts));
       
      +	opts.quiet = !isatty(2);
      +
       	argc = parse_options(argc, argv, prefix,
     - 			     builtin_maintenance_options,
     - 			     builtin_maintenance_usage,
     + 			     builtin_maintenance_run_options,
     + 			     builtin_maintenance_run_usage,
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'help text' '
  3:  91741a0cfc =  3:  e28b332df4 maintenance: replace run_auto_gc()
  4:  1db3b96280 !  4:  82326c1c38 maintenance: initialize task array
     @@ Commit message
      
          The run subcommand will return a nonzero exit code if any task fails.
          However, it will attempt all tasks in its loop before returning with the
     -    failure. Also each failed task will send an error message.
     +    failure. Also each failed task will print an error message.
      
          Helped-by: Taylor Blau <me@ttaylorr.com>
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_opts *opts)
     +@@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_run_opts *opts)
       	return run_command(&child);
       }
       
     -+typedef int maintenance_task_fn(struct maintenance_opts *opts);
     ++typedef int maintenance_task_fn(struct maintenance_run_opts *opts);
      +
      +struct maintenance_task {
      +	const char *name;
     @@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_opts *opts)
      +	},
      +};
      +
     - static int maintenance_run(struct maintenance_opts *opts)
     - {
     --	return maintenance_task_gc(opts);
     ++static int maintenance_run_tasks(struct maintenance_run_opts *opts)
     ++{
      +	int i;
      +	int result = 0;
      +
     @@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_opts *opts)
      +	}
      +
      +	return result;
     ++}
     ++
     + static int maintenance_run(int argc, const char **argv, const char *prefix)
     + {
     + 	struct maintenance_run_opts opts;
     +@@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char *prefix)
     + 	if (argc != 0)
     + 		usage_with_options(builtin_maintenance_run_usage,
     + 				   builtin_maintenance_run_options);
     +-	return maintenance_task_gc(&opts);
     ++	return maintenance_run_tasks(&opts);
       }
       
     - int cmd_maintenance(int argc, const char **argv, const char *prefix)
     + static const char builtin_maintenance_usage[] = N_("git maintenance run [<options>]");
  5:  50b457fd57 !  5:  06984a42bf maintenance: add commit-graph task
     @@ Commit message
          maintenance: add commit-graph task
      
          The first new task in the 'git maintenance' builtin is the
     -    'commit-graph' job. It is based on the sequence of events in the
     -    'commit-graph' job in Scalar [1]. This sequence is as follows:
     +    'commit-graph' task. This updates the commit-graph file
     +    incrementally with the command
      
     -    1. git commit-graph write --reachable --split
     -    2. git commit-graph verify --shallow
     -    3. If the verify succeeds, stop.
     -    4. Delete the commit-graph-chain file.
     -    5. git commit-graph write --reachable --split
     +            git commit-graph write --reachable --split
      
          By writing an incremental commit-graph file using the "--split"
          option we minimize the disruption from this operation. The default
     @@ Commit message
          This could be avoided by a future update to use the --expire-time
          argument when writing the commit-graph.
      
     -    By using 'git commit-graph verify --shallow' we can ensure that
     -    the file we just wrote is valid. This is an extra safety precaution
     -    that is faster than our 'write' subcommand. In the rare situation
     -    that the newest layer of the commit-graph is corrupt, we can "fix"
     -    the corruption by deleting the commit-graph-chain file and rewrite
     -    the full commit-graph as a new one-layer commit graph. This does
     -    not completely prevent _that_ file from being corrupt, but it does
     -    recompute the commit-graph by parsing commits from the object
     -    database. In our use of this step in Scalar and VFS for Git, we
     -    have only seen this issue arise because our microsoft/git fork
     -    reverted 43d3561 ("commit-graph write: don't die if the existing
     -    graph is corrupt" 2019-03-25) for a while to keep commit-graph
     -    writes very fast. We dropped the revert when updating to v2.23.0.
     -    The verify still has potential for catching corrupt data across
     -    the layer boundary: if the new file has commit X with parent Y
     -    in an old file but the commit ID for Y in the old file had a
     -    bitswap, then we will notice that in the 'verify' command.
     -
     -    [1] https://github.com/microsoft/scalar/blob/master/Scalar.Common/Maintenance/CommitGraphStep.cs
     -
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/git-maintenance.txt ##
     @@ Documentation/git-maintenance.txt: run::
       
      +commit-graph::
      +	The `commit-graph` job updates the `commit-graph` files incrementally,
     -+	then verifies that the written data is correct. If the new layer has an
     -+	issue, then the chain file is removed and the `commit-graph` is
     -+	rewritten from scratch.
     -++
     -+The incremental write is safe to run alongside concurrent Git processes
     -+since it will not expire `.graph` files that were in the previous
     -+`commit-graph-chain` file. They will be deleted by a later run based on
     -+the expiration delay.
     ++	then verifies that the written data is correct. The incremental
     ++	write is safe to run alongside concurrent Git processes since it
     ++	will not expire `.graph` files that were in the previous
     ++	`commit-graph-chain` file. They will be deleted by a later run based
     ++	on the expiration delay.
      +
       gc::
       	Clean up unnecessary files and optimize the local repository. "GC"
       	stands for "garbage collection," but this task performs many
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: struct maintenance_opts {
     +@@ builtin/gc.c: struct maintenance_run_opts {
       	int quiet;
       };
       
     -+static int run_write_commit_graph(struct maintenance_opts *opts)
     ++static int run_write_commit_graph(struct maintenance_run_opts *opts)
      +{
      +	struct child_process child = CHILD_PROCESS_INIT;
      +
     @@ builtin/gc.c: struct maintenance_opts {
      +	return !!run_command(&child);
      +}
      +
     -+static int run_verify_commit_graph(struct maintenance_opts *opts)
     ++static int maintenance_task_commit_graph(struct maintenance_run_opts *opts)
      +{
     -+	struct child_process child = CHILD_PROCESS_INIT;
     -+
     -+	child.git_cmd = 1;
     -+	strvec_pushl(&child.args, "commit-graph", "verify",
     -+		     "--shallow", NULL);
     -+
     -+	if (opts->quiet)
     -+		strvec_push(&child.args, "--no-progress");
     -+
     -+	return !!run_command(&child);
     -+}
     -+
     -+static int maintenance_task_commit_graph(struct maintenance_opts *opts)
     -+{
     -+	struct repository *r = the_repository;
     -+	char *chain_path;
     -+
     -+	close_object_store(r->objects);
     ++	close_object_store(the_repository->objects);
      +	if (run_write_commit_graph(opts)) {
      +		error(_("failed to write commit-graph"));
      +		return 1;
      +	}
      +
     -+	if (!run_verify_commit_graph(opts))
     -+		return 0;
     -+
     -+	warning(_("commit-graph verify caught error, rewriting"));
     -+
     -+	chain_path = get_commit_graph_chain_filename(r->objects->odb);
     -+	if (unlink(chain_path)) {
     -+		UNLEAK(chain_path);
     -+		die(_("failed to remove commit-graph at %s"), chain_path);
     -+	}
     -+	free(chain_path);
     -+
     -+	if (!run_write_commit_graph(opts))
     -+		return 0;
     -+
     -+	error(_("failed to rewrite commit-graph"));
     -+	return 1;
     ++	return 0;
      +}
      +
     - static int maintenance_task_gc(struct maintenance_opts *opts)
     + static int maintenance_task_gc(struct maintenance_run_opts *opts)
       {
       	struct child_process child = CHILD_PROCESS_INIT;
      @@ builtin/gc.c: struct maintenance_task {
     @@ builtin/gc.c: static struct maintenance_task tasks[] = {
      +	},
       };
       
     - static int maintenance_run(struct maintenance_opts *opts)
     + static int maintenance_run_tasks(struct maintenance_run_opts *opts)
      
       ## commit-graph.c ##
      @@ commit-graph.c: static char *get_split_graph_filename(struct object_directory *odb,
     @@ commit-graph.c: static void expire_commit_graphs(struct write_commit_graph_conte
       		ctx->num_commit_graphs_after = 0;
      
       ## commit-graph.h ##
     -@@ commit-graph.h: struct commit;
     - struct bloom_filter_settings;
     +@@ commit-graph.h: struct raw_object_store;
     + struct string_list;
       
       char *get_commit_graph_filename(struct object_directory *odb);
      +char *get_commit_graph_chain_filename(struct object_directory *odb);
  6:  85268bd53e !  6:  69298aee24 maintenance: add --task option
     @@ Documentation/git-maintenance.txt: OPTIONS
       
      +--task=<task>::
      +	If this option is specified one or more times, then only run the
     -+	specified tasks in the specified order.
     ++	specified tasks in the specified order. See the 'TASKS' section
     ++	for the list of accepted `<task>` values.
      +
       GIT
       ---
       Part of the linkgit:git[1] suite
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: typedef int maintenance_task_fn(struct maintenance_opts *opts);
     - struct maintenance_task {
     +@@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
     + }
     + 
     + static const char * const builtin_maintenance_run_usage[] = {
     +-	N_("git maintenance run [--auto] [--[no-]quiet]"),
     ++	N_("git maintenance run [--auto] [--[no-]quiet] [--task=<task>]"),
     + 	NULL
     + };
     + 
     +@@ builtin/gc.c: struct maintenance_task {
       	const char *name;
       	maintenance_task_fn *fn;
     --	unsigned enabled:1;
     -+	unsigned enabled:1,
     -+		 selected:1;
     + 	unsigned enabled:1;
     ++
     ++	/* -1 if not selected. */
      +	int selected_order;
       };
       
     @@ builtin/gc.c: static struct maintenance_task tasks[] = {
      +	return b->selected_order - a->selected_order;
      +}
      +
     - static int maintenance_run(struct maintenance_opts *opts)
     + static int maintenance_run_tasks(struct maintenance_run_opts *opts)
       {
      -	int i;
      +	int i, found_selected = 0;
       	int result = 0;
       
      +	for (i = 0; !found_selected && i < TASK__COUNT; i++)
     -+		found_selected = tasks[i].selected;
     ++		found_selected = tasks[i].selected_order >= 0;
      +
      +	if (found_selected)
      +		QSORT(tasks, TASK__COUNT, compare_tasks_by_selection);
      +
       	for (i = 0; i < TASK__COUNT; i++) {
      -		if (!tasks[i].enabled)
     -+		if (found_selected && !tasks[i].selected)
     ++		if (found_selected && tasks[i].selected_order < 0)
      +			continue;
      +
      +		if (!found_selected && !tasks[i].enabled)
       			continue;
       
       		if (tasks[i].fn(opts)) {
     -@@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
     +@@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts)
       	return result;
       }
       
     @@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
      +	BUG_ON_OPT_NEG(unset);
      +
      +	for (i = 0; i < TASK__COUNT; i++) {
     -+		num_selected += tasks[i].selected;
     ++		if (tasks[i].selected_order >= 0)
     ++			num_selected++;
      +		if (!strcasecmp(tasks[i].name, arg)) {
      +			task = &tasks[i];
      +		}
     @@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
      +		return 1;
      +	}
      +
     -+	if (task->selected) {
     ++	if (task->selected_order >= 0) {
      +		error(_("task '%s' cannot be selected multiple times"), arg);
      +		return 1;
      +	}
      +
     -+	task->selected = 1;
      +	task->selected_order = num_selected + 1;
      +
      +	return 0;
      +}
      +
     - int cmd_maintenance(int argc, const char **argv, const char *prefix)
     + static int maintenance_run(int argc, const char **argv, const char *prefix)
       {
     - 	struct maintenance_opts opts;
     -@@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
     ++	int i;
     + 	struct maintenance_run_opts opts;
     + 	struct option builtin_maintenance_run_options[] = {
     + 		OPT_BOOL(0, "auto", &opts.auto_flag,
       			 N_("run tasks based on the state of the repository")),
       		OPT_BOOL(0, "quiet", &opts.quiet,
       			 N_("do not report progress or other information over stderr")),
     @@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefi
      +			PARSE_OPT_NONEG, task_option_parse),
       		OPT_END()
       	};
     + 	memset(&opts, 0, sizeof(opts));
     + 
     + 	opts.quiet = !isatty(2);
       
     ++	for (i = 0; i < TASK__COUNT; i++)
     ++		tasks[i].selected_order = -1;
     ++
     + 	argc = parse_options(argc, argv, prefix,
     + 			     builtin_maintenance_run_options,
     + 			     builtin_maintenance_run_usage,
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'run [--auto|--quiet]' '
  7:  6f86cfaa94 !  7:  3d513acdd8 maintenance: take a lock on the objects directory
     @@ Commit message
          lock is never committed, since it does not represent meaningful data.
          Instead, it is only a placeholder.
      
     -    If the lock file already exists, then fail silently. This will become
     -    very important later when we implement the 'fetch' task, as this is our
     -    stop-gap from creating a recursive process loop between 'git fetch' and
     -    'git maintenance run'.
     +    If the lock file already exists, then fail with a warning. If '--auto'
     +    is specified, then instead no warning is shown and no tasks are attempted.
     +    This will become very important later when we implement the 'prefetch'
     +    task, as this is our stop-gap from creating a recursive process loop
     +    between 'git fetch' and 'git maintenance run --auto'.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
     +@@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts)
       {
       	int i, found_selected = 0;
       	int result = 0;
     @@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
      +		 * that case.
      +		 */
      +		if (!opts->auto_flag && !opts->quiet)
     -+			error(_("lock file '%s' exists, skipping maintenance"),
     -+			      lock_path);
     ++			warning(_("lock file '%s' exists, skipping maintenance"),
     ++				lock_path);
      +		free(lock_path);
      +		return 0;
      +	}
      +	free(lock_path);
       
       	for (i = 0; !found_selected && i < TASK__COUNT; i++)
     - 		found_selected = tasks[i].selected;
     -@@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
     + 		found_selected = tasks[i].selected_order >= 0;
     +@@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts)
       		}
       	}
       
  8:  5c0f9d69d1 !  8:  712f5f2d8e maintenance: create maintenance.<task>.enabled config
     @@ Documentation/config/maintenance.txt (new)
      @@
      +maintenance.<task>.enabled::
      +	This boolean config option controls whether the maintenance task
     -+	with name `<task>` is run when no `--task` option is specified.
     -+	By default, only `maintenance.gc.enabled` is true.
     ++	with name `<task>` is run when no `--task` option is specified to
     ++	`git maintenance run`. These config values are ignored if a
     ++	`--task` option exists. By default, only `maintenance.gc.enabled`
     ++	is true.
      
       ## Documentation/git-maintenance.txt ##
      @@ Documentation/git-maintenance.txt: SUBCOMMANDS
     @@ Documentation/git-maintenance.txt: SUBCOMMANDS
       
       TASKS
       -----
     +@@ Documentation/git-maintenance.txt: OPTIONS
     + 
     + --task=<task>::
     + 	If this option is specified one or more times, then only run the
     +-	specified tasks in the specified order. See the 'TASKS' section
     +-	for the list of accepted `<task>` values.
     ++	specified tasks in the specified order. If no `--task=<task>`
     ++	arguments are specified, then only the tasks with
     ++	`maintenance.<task>.enabled` configured as `true` are considered.
     ++	See the 'TASKS' section for the list of accepted `<task>` values.
     + 
     + GIT
     + ---
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
     +@@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts)
       	return result;
       }
       
     @@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
       static int task_option_parse(const struct option *opt,
       			     const char *arg, int unset)
       {
     -@@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
     - 				   builtin_maintenance_options);
     +@@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char *prefix)
     + 	memset(&opts, 0, sizeof(opts));
       
       	opts.quiet = !isatty(2);
      +	initialize_task_config();
       
     - 	argc = parse_options(argc, argv, prefix,
     - 			     builtin_maintenance_options,
     + 	for (i = 0; i < TASK__COUNT; i++)
     + 		tasks[i].selected_order = -1;
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'run [--auto|--quiet]' '
  9:  68bf5bef4b !  9:  69d3b48fd4 maintenance: use pointers to check --auto
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_opts *opts)
     +@@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_run_opts *opts)
       
     - typedef int maintenance_task_fn(struct maintenance_opts *opts);
     + typedef int maintenance_task_fn(struct maintenance_run_opts *opts);
       
      +/*
      + * An auto condition function returns 1 if the task should run
     @@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_opts *opts)
       	const char *name;
       	maintenance_task_fn *fn;
      +	maintenance_auto_fn *auto_condition;
     - 	unsigned enabled:1,
     - 		 selected:1;
     - 	int selected_order;
     + 	unsigned enabled:1;
     + 
     + 	/* -1 if not selected. */
      @@ builtin/gc.c: static struct maintenance_task tasks[] = {
       	[TASK_GC] = {
       		"gc",
     @@ builtin/gc.c: static struct maintenance_task tasks[] = {
       		1,
       	},
       	[TASK_COMMIT_GRAPH] = {
     -@@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
     +@@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts)
       		if (!found_selected && !tasks[i].enabled)
       			continue;
       
 10:  fc097c389a ! 10:  4c3115fe35 maintenance: add auto condition for commit-graph task
     @@ Commit message
      
       ## Documentation/config/maintenance.txt ##
      @@ Documentation/config/maintenance.txt: maintenance.<task>.enabled::
     - 	This boolean config option controls whether the maintenance task
     - 	with name `<task>` is run when no `--task` option is specified.
     - 	By default, only `maintenance.gc.enabled` is true.
     + 	`git maintenance run`. These config values are ignored if a
     + 	`--task` option exists. By default, only `maintenance.gc.enabled`
     + 	is true.
      +
      +maintenance.commit-graph.auto::
      +	This integer config option controls how often the `commit-graph` task
     @@ builtin/gc.c
       
       #define FAILED_RUN "failed to run %s"
       
     -@@ builtin/gc.c: struct maintenance_opts {
     +@@ builtin/gc.c: struct maintenance_run_opts {
       	int quiet;
       };
       
      +/* Remember to update object flag allocation in object.h */
     -+#define PARENT1		(1u<<16)
     ++#define SEEN		(1u<<0)
      +
     -+static int num_commits_not_in_graph = 0;
     -+static int limit_commits_not_in_graph = 100;
     ++struct cg_auto_data {
     ++	int num_not_in_graph;
     ++	int limit;
     ++};
      +
      +static int dfs_on_ref(const char *refname,
      +		      const struct object_id *oid, int flags,
      +		      void *cb_data)
      +{
     ++	struct cg_auto_data *data = (struct cg_auto_data *)cb_data;
      +	int result = 0;
      +	struct object_id peeled;
      +	struct commit_list *stack = NULL;
     @@ builtin/gc.c: struct maintenance_opts {
      +		for (parent = commit->parents; parent; parent = parent->next) {
      +			if (parse_commit(parent->item) ||
      +			    commit_graph_position(parent->item) != COMMIT_NOT_FROM_GRAPH ||
     -+			    parent->item->object.flags & PARENT1)
     ++			    parent->item->object.flags & SEEN)
      +				continue;
      +
     -+			parent->item->object.flags |= PARENT1;
     -+			num_commits_not_in_graph++;
     ++			parent->item->object.flags |= SEEN;
     ++			data->num_not_in_graph++;
      +
     -+			if (num_commits_not_in_graph >= limit_commits_not_in_graph) {
     ++			if (data->num_not_in_graph >= data->limit) {
      +				result = 1;
      +				break;
      +			}
     @@ builtin/gc.c: struct maintenance_opts {
      +static int should_write_commit_graph(void)
      +{
      +	int result;
     ++	struct cg_auto_data data;
      +
     ++	data.num_not_in_graph = 0;
     ++	data.limit = 100;
      +	git_config_get_int("maintenance.commit-graph.auto",
     -+			   &limit_commits_not_in_graph);
     ++			   &data.limit);
      +
     -+	if (!limit_commits_not_in_graph)
     ++	if (!data.limit)
      +		return 0;
     -+	if (limit_commits_not_in_graph < 0)
     ++	if (data.limit < 0)
      +		return 1;
      +
     -+	result = for_each_ref(dfs_on_ref, NULL);
     ++	result = for_each_ref(dfs_on_ref, &data);
      +
     -+	clear_commit_marks_all(PARENT1);
     ++	clear_commit_marks_all(SEEN);
      +
      +	return result;
      +}
      +
     - static int run_write_commit_graph(struct maintenance_opts *opts)
     + static int run_write_commit_graph(struct maintenance_run_opts *opts)
       {
       	struct child_process child = CHILD_PROCESS_INIT;
      @@ builtin/gc.c: static struct maintenance_task tasks[] = {
     @@ builtin/gc.c: static struct maintenance_task tasks[] = {
      
       ## object.h ##
      @@ object.h: struct object_array {
     +  * sha1-name.c:                                              20
        * list-objects-filter.c:                                      21
        * builtin/fsck.c:           0--3
     ++ * builtin/gc.c:             0
        * builtin/index-pack.c:                                     2021
     -+ * builtin/maintenance.c:                           16
        * builtin/pack-objects.c:                                   20
        * builtin/reflog.c:                   10--12
     -  * builtin/show-branch.c:    0-------------------------------------------26
 11:  46fbe161aa ! 11:  652a8eac57 maintenance: add trace2 regions for task execution
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
     +@@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts)
       		     !tasks[i].auto_condition()))
       			continue;
       

-- 
gitgitgadget
