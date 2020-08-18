Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038FBC433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCDBE20786
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y33Fg/JH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHROX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgHROXN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:23:13 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57E7C061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:23:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so15489107wmc.0
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ny15p/e+6+AaYf1Cnz0Kef6Po9hWjHmAIYKtLliXa/Q=;
        b=Y33Fg/JHTZNZNaJNSKdt8OYM9s+mjXw/JATdGzrP/8dqDSiN1rSZoSa61LcKtvtx35
         Ztt3c5CLyA091X9f8bWDnjYKJAU0V0KmLIKnhshPQVGMvUbh0iCMYkzGFa+0IYj8o7CW
         Oa0LqwGfSi7VF+s6lBdDrdGrDciOtTmhweBjRsUT43ZEFv0KFS809gTY+3XuOpIGluA6
         HFvPQ9x6XZgb6jxxGc6i5S7NvPkthJ40mMzdZ52I06XqJr+S3oEJoO/eFuqWBsyxKj8B
         m0lCRAqiq7/xED1lqyvcSDtZDTReh1Smvom8VK2wyeolmxnrfmmMrk80jOloTIrxx6x/
         bsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ny15p/e+6+AaYf1Cnz0Kef6Po9hWjHmAIYKtLliXa/Q=;
        b=KkiWT61SwaYAaEu6MlbxltO2jGFHBunLBtRbyPD5XPXxooSv36I8CSBSzwp+OBvyYq
         l1M+ObowXpVXJVcol5Vs+rhyc9JR4lhf1MQTvy9kNd2ExKbbFfn6GAmCZbjp/n5QazKh
         ls9FfscrBSTwWd0DTnD0pJAYT3jz0DhvUmaxpUZ3bQDQQXv7/TnsWpzckI/oMaQ/vSug
         RbhBjYP6D8tNb2vaWp/pmHhK4lPeP7Bk/3FKcsWUB3rnkS4Wd9ntFA6kR9i/aksQJ4up
         ynEdJu7vVSL8eXvFuxrE//SvZ21WlcisZACAejT3b9fb+urrpxRlTMnmZClkHXGQ1U5Y
         66Uw==
X-Gm-Message-State: AOAM532LBeuWAlbCNRHX8FP6VjMVKhF2XpINTNM55kUbxdQfOHklW9D0
        JlZqEQ8PU/ps9f8qPOLcNCq+YT7sNVg=
X-Google-Smtp-Source: ABdhPJzC1bHc/dWpmmfWyqDJV0N5xVBodV0yhY/QLi8VvV4St2TnqJmXkw8ojUp6Mhcu72oKQJTXAQ==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr148893wmi.183.1597760590984;
        Tue, 18 Aug 2020 07:23:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm37533748wrq.0.2020.08.18.07.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:23:10 -0700 (PDT)
Message-Id: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.git.1596728921.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:22:57 +0000
Subject: [PATCH v2 00/11] Maintenance I: Command, gc and commit-graph tasks
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

This series is based on jk/strvec.

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
 Documentation/config/maintenance.txt |  14 ++
 Documentation/fetch-options.txt      |   6 +-
 Documentation/git-clone.txt          |   6 +-
 Documentation/git-maintenance.txt    |  79 ++++++
 builtin.h                            |   1 +
 builtin/am.c                         |   2 +-
 builtin/commit.c                     |   2 +-
 builtin/fetch.c                      |   6 +-
 builtin/gc.c                         | 354 +++++++++++++++++++++++++++
 builtin/merge.c                      |   2 +-
 builtin/rebase.c                     |   4 +-
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
 23 files changed, 580 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/config/maintenance.txt
 create mode 100644 Documentation/git-maintenance.txt
 create mode 100755 t/t7900-maintenance.sh


base-commit: d70a9eb611a9d242c1d26847d223b8677609305b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-695%2Fderrickstolee%2Fmaintenance%2Fbuiltin-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-695/derrickstolee/maintenance/builtin-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/695

Range-diff vs v1:

  1:  2b9deb6d6a !  1:  e09e4a4a87 maintenance: create basic maintenance runner
     @@ Documentation/git-maintenance.txt (new)
      +-----------
      +Run tasks to optimize Git repository data, speeding up other Git commands
      +and reducing storage requirements for the repository.
     -++
     ++
      +Git commands that add repository data, such as `git add` or `git fetch`,
      +are optimized for a responsive user experience. These commands do not take
      +time to optimize the Git data, since such optimizations scale with the full
      +size of the repository while these user commands each perform a relatively
      +small action.
     -++
     ++
      +The `git maintenance` command provides flexibility for how to optimize the
      +Git repository.
      +
     @@ Documentation/git-maintenance.txt (new)
      +-----
      +
      +gc::
     -+	Cleanup unnecessary files and optimize the local repository. "GC"
     ++	Clean up unnecessary files and optimize the local repository. "GC"
      +	stands for "garbage collection," but this task performs many
     -+	smaller tasks. This task can be rather expensive for large
     -+	repositories, as it repacks all Git objects into a single pack-file.
     -+	It can also be disruptive in some situations, as it deletes stale
     -+	data.
     ++	smaller tasks. This task can be expensive for large repositories,
     ++	as it repacks all Git objects into a single pack-file. It can also
     ++	be disruptive in some situations, as it deletes stale data. See
     ++	linkgit:git-gc[1] for more details on garbage collection in Git.
      +
      +OPTIONS
      +-------
     @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
      +
      +int cmd_maintenance(int argc, const char **argv, const char *prefix)
      +{
     -+	static struct maintenance_opts opts;
     -+	static struct option builtin_maintenance_options[] = {
     ++	struct maintenance_opts opts;
     ++	struct option builtin_maintenance_options[] = {
      +		OPT_BOOL(0, "auto", &opts.auto_flag,
      +			 N_("run tasks based on the state of the repository")),
      +		OPT_END()
     @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
      +			     builtin_maintenance_usage,
      +			     PARSE_OPT_KEEP_UNKNOWN);
      +
     -+	if (argc == 1) {
     -+		if (!strcmp(argv[0], "run"))
     -+			return maintenance_run(&opts);
     -+	}
     ++	if (argc != 1)
     ++		usage_with_options(builtin_maintenance_usage,
     ++				   builtin_maintenance_options);
     ++
     ++	if (!strcmp(argv[0], "run"))
     ++		return maintenance_run(&opts);
      +
     -+	usage_with_options(builtin_maintenance_usage,
     -+			   builtin_maintenance_options);
     ++	die(_("invalid subcommand: %s"), argv[0]);
      +}
      
       ## git.c ##
     @@ t/t7900-maintenance.sh (new)
      +
      +test_expect_success 'help text' '
      +	test_expect_code 129 git maintenance -h 2>err &&
     -+	test_i18ngrep "usage: git maintenance run" err
     ++	test_i18ngrep "usage: git maintenance run" err &&
     ++	test_expect_code 128 git maintenance barf 2>err &&
     ++	test_i18ngrep "invalid subcommand: barf" err
      +'
      +
      +test_expect_success 'run [--auto]' '
  2:  d5faef26af !  2:  adae48d235 maintenance: add --quiet option
     @@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_opts *opts)
       	close_object_store(the_repository->objects);
       	return run_command(&child);
      @@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
     - 	static struct option builtin_maintenance_options[] = {
     + 	struct option builtin_maintenance_options[] = {
       		OPT_BOOL(0, "auto", &opts.auto_flag,
       			 N_("run tasks based on the state of the repository")),
      +		OPT_BOOL(0, "quiet", &opts.quiet,
     @@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefi
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'help text' '
     - 	test_i18ngrep "usage: git maintenance run" err
     + 	test_i18ngrep "invalid subcommand: barf" err
       '
       
      -test_expect_success 'run [--auto]' '
  3:  233811310b =  3:  91741a0cfc maintenance: replace run_auto_gc()
  4:  7efa23abc8 =  4:  1db3b96280 maintenance: initialize task array
  5:  902b742032 !  5:  50b457fd57 maintenance: add commit-graph task
     @@ Documentation/git-maintenance.txt: run::
      +	issue, then the chain file is removed and the `commit-graph` is
      +	rewritten from scratch.
      ++
     -+The verification only checks the top layer of the `commit-graph` chain.
     -+If the incremental write merged the new commits with at least one
     -+existing layer, then there is potential for on-disk corruption being
     -+carried forward into the new file. This will be noticed and the new
     -+commit-graph file will be clean as Git reparses the commit data from
     -+the object database.
     -++
      +The incremental write is safe to run alongside concurrent Git processes
      +since it will not expire `.graph` files that were in the previous
      +`commit-graph-chain` file. They will be deleted by a later run based on
      +the expiration delay.
      +
       gc::
     - 	Cleanup unnecessary files and optimize the local repository. "GC"
     + 	Clean up unnecessary files and optimize the local repository. "GC"
       	stands for "garbage collection," but this task performs many
      
       ## builtin/gc.c ##
     @@ t/t7900-maintenance.sh: test_description='git maintenance builtin'
      +
       test_expect_success 'help text' '
       	test_expect_code 129 git maintenance -h 2>err &&
     - 	test_i18ngrep "usage: git maintenance run" err
     + 	test_i18ngrep "usage: git maintenance run" err &&
  6:  dddbcc4f3d !  6:  85268bd53e maintenance: add --task option
     @@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
      +
       int cmd_maintenance(int argc, const char **argv, const char *prefix)
       {
     - 	static struct maintenance_opts opts;
     + 	struct maintenance_opts opts;
      @@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
       			 N_("run tasks based on the state of the repository")),
       		OPT_BOOL(0, "quiet", &opts.quiet,
  7:  79af39be13 =  7:  6f86cfaa94 maintenance: take a lock on the objects directory
  8:  69bfc6a4b2 =  8:  5c0f9d69d1 maintenance: create maintenance.<task>.enabled config
  9:  df21bbb000 =  9:  68bf5bef4b maintenance: use pointers to check --auto
 10:  e67e259aef = 10:  fc097c389a maintenance: add auto condition for commit-graph task
 11:  a5d1914846 = 11:  46fbe161aa maintenance: add trace2 regions for task execution

-- 
gitgitgadget
