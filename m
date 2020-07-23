Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF417C433ED
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832AD206E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzZ28fFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgGWR4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbgGWR4q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 13:56:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951E5C0619E2
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a14so6011691wra.5
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kBgjJPYnhLcRtTZD3pYK0aEMvSUBf7UOaLSAI46bpj4=;
        b=MzZ28fFQx4xldbmh3q5EL0LebZEru6tdlVeHFVWywUNqppFwG38MKZz8XQgNrR6Z4O
         C96X6wCSO12S2gCEcyECIST3dOPsZ6wjjLxJZbYypNMW7NFz6irlD0Rwixcv4s9AEgKE
         161gDRq5cwCkwDIyu9J/4948poYgX+A6D3TxxoZHrpZ0dBWJ+OzN5Yw/8Tp7XuODJedR
         TrUmjD+nhtktpm3BCsLQDKqIecUSUgUbCEhjhApTw4UB6S8q5RXENNq7YOd25xwCU1xh
         OEcpjUi1y25qAOSimQ6QYD7fIOulTiuHV5mLufnUZlyRVuMQSWEnSvsSenSr3bkbTH1g
         D/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kBgjJPYnhLcRtTZD3pYK0aEMvSUBf7UOaLSAI46bpj4=;
        b=ETf85zL0cDUf6Z8k1BxakWg8OWDMM45EzOmp4E+Jlv+pVvoD+iEERyDuGFdQbR3vvD
         bd0hnI0QiM7DV+NAu2dG9U5ibXIxW8N3e2CVEoin6tLTGcn4gjNkl9K8PX1jFB8isGiD
         63wtn8TdBXHYEDX1stXKUYxF2jByHTjFeTBHo/7S0U+2Mz3grzMupdoUm4QB+aX3hiop
         rGyM2cXlqj265sYiOIFKIiHNE0SE1e0EVhKN4VZpuwaNgjX4nYQQobsdgZ9K3kzLUlEx
         RDjFDiXglNy6JOTNbgFpgi2fMROnexGJnBbmPAA5c34ODhzvT60x+mBGkZpezRM8N+Iv
         CV9g==
X-Gm-Message-State: AOAM530G3K0GmR2rBbLM9UcAHqOLNmHb66sfVHnDX0l/DG7GHWJtJwrk
        HCvIfBSJD0I1CTzzvq42fp30ZDvP
X-Google-Smtp-Source: ABdhPJzUdhXuAqtP/1Xjq77Z+WT/Up3TzkfW7OwRSbU1XB1JB/YCBOyrSBISkQ3usyVUm74lhOvgaA==
X-Received: by 2002:adf:8282:: with SMTP id 2mr5041409wrc.76.1595527002100;
        Thu, 23 Jul 2020 10:56:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13sm4612103wro.64.2020.07.23.10.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:56:41 -0700 (PDT)
Message-Id: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 17:56:22 +0000
Subject: [PATCH v2 00/18] Maintenance builtin, allowing 'gc --auto' customization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, Derrick Stolee <derrickstolee@github.com>
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
 * 'fetch' : fetch from each remote, storing the refs in 'refs/prefetch//'.

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
   commands run in the background. You can see my progress towards this goal
   here: https://github.com/gitgitgadget/git/pull/680
   
   
 * Split the 'gc' builtin into smaller maintenance tasks that are enabled by
   default, but might have different '--auto' conditions and more config
   options.
   
   
 * Replace config like 'gc.writeCommitGraph' and 'fetch.writeCommitGraph'
   with use of the 'commit-graph' task.
   
   
 * Update the builtin to use struct repository *r properly, especially when
   calling subcommands.
   
   

UPDATES in V2
=============

I'm sending this between v2.28.0-rc2 adn v2.28.0 as the release things have
become a bit quiet.

 * The biggest disruption to the range-diff is that I removed the premature
   use of struct repository *r and instead continue to rely on 
   the_repository. This means several patches were dropped that did prep
   work in builtin/gc.c.
   
   
 * I dropped the task hashmap and opted for a linear scan. This task list
   will always be too small to justify the extra complication of the
   hashmap.
   
   
 * struct maintenance_opts is properly static now.
   
   
 * Some tasks are renamed: fetch -> prefetch, pack-files ->
   incremental-repack.
   
   
 * With the rename, the prefetch task uses refs/prefetch/ instead of 
   refs/hidden/.
   
   
 * A trace2 region around the task executions are added.
   
   

Thanks, -Stolee

Derrick Stolee (18):
  maintenance: create basic maintenance runner
  maintenance: add --quiet option
  maintenance: replace run_auto_gc()
  maintenance: initialize task array
  maintenance: add commit-graph task
  maintenance: add --task option
  maintenance: take a lock on the objects directory
  maintenance: add prefetch task
  maintenance: add loose-objects task
  maintenance: add incremental-repack task
  maintenance: auto-size incremental-repack batch
  maintenance: create maintenance.<task>.enabled config
  maintenance: use pointers to check --auto
  maintenance: add auto condition for commit-graph task
  maintenance: create auto condition for loose-objects
  maintenance: add incremental-repack auto condition
  midx: use start_delayed_progress()
  maintenance: add trace2 regions for task execution

 .gitignore                           |   1 +
 Documentation/config.txt             |   2 +
 Documentation/config/maintenance.txt |  32 ++
 Documentation/fetch-options.txt      |   5 +-
 Documentation/git-clone.txt          |   7 +-
 Documentation/git-maintenance.txt    | 124 +++++
 builtin.h                            |   1 +
 builtin/am.c                         |   2 +-
 builtin/commit.c                     |   2 +-
 builtin/fetch.c                      |   6 +-
 builtin/gc.c                         | 753 +++++++++++++++++++++++++++
 builtin/merge.c                      |   2 +-
 builtin/rebase.c                     |   4 +-
 commit-graph.c                       |   8 +-
 commit-graph.h                       |   1 +
 git.c                                |   1 +
 midx.c                               |  12 +-
 midx.h                               |   1 +
 object.h                             |   1 +
 run-command.c                        |   7 +-
 run-command.h                        |   2 +-
 t/t5319-multi-pack-index.sh          |  14 +-
 t/t5510-fetch.sh                     |   2 +-
 t/t5514-fetch-multiple.sh            |   2 +-
 t/t7900-maintenance.sh               | 211 ++++++++
 25 files changed, 1169 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/config/maintenance.txt
 create mode 100644 Documentation/git-maintenance.txt
 create mode 100755 t/t7900-maintenance.sh


base-commit: 4a0fcf9f760c9774be77f51e1e88a7499b53d2e2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-671%2Fderrickstolee%2Fmaintenance%2Fgc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-671/derrickstolee/maintenance/gc-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/671

Range-diff vs v1:

  1:  85dda7db28 <  -:  ---------- gc: use the_repository less often
  2:  303ad4bdc7 <  -:  ---------- gc: use repository in too_many_loose_objects()
  3:  9dfa9e8f6f <  -:  ---------- gc: use repo config
  4:  e13d351e9f <  -:  ---------- gc: drop the_repository in log location
  5:  5f89e0ec9b !  1:  63ec602a07 maintenance: create basic maintenance runner
     @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
      +	NULL
      +};
      +
     -+struct maintenance_opts {
     ++static struct maintenance_opts {
      +	int auto_flag;
      +} opts;
      +
     -+static int maintenance_task_gc(struct repository *r)
     ++static int maintenance_task_gc(void)
      +{
      +	int result;
      +	struct argv_array cmd = ARGV_ARRAY_INIT;
     @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
      +	if (opts.auto_flag)
      +		argv_array_pushl(&cmd, "--auto", NULL);
      +
     -+	close_object_store(r->objects);
     ++	close_object_store(the_repository->objects);
      +	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
      +	argv_array_clear(&cmd);
      +
      +	return result;
      +}
      +
     -+static int maintenance_run(struct repository *r)
     ++static int maintenance_run(void)
      +{
     -+	return maintenance_task_gc(r);
     ++	return maintenance_task_gc();
      +}
      +
      +int cmd_maintenance(int argc, const char **argv, const char *prefix)
      +{
     -+	struct repository *r = the_repository;
     -+
      +	static struct option builtin_maintenance_options[] = {
      +		OPT_BOOL(0, "auto", &opts.auto_flag,
      +			 N_("run tasks based on the state of the repository")),
     @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
      +
      +	if (argc == 1) {
      +		if (!strcmp(argv[0], "run"))
     -+			return maintenance_run(r);
     ++			return maintenance_run();
      +	}
      +
      +	usage_with_options(builtin_maintenance_usage,
  6:  018a9331e2 !  2:  1d37e55cb7 maintenance: add --quiet option
     @@ Documentation/git-maintenance.txt: OPTIONS
       ## builtin/gc.c ##
      @@ builtin/gc.c: static const char * const builtin_maintenance_usage[] = {
       
     - struct maintenance_opts {
     + static struct maintenance_opts {
       	int auto_flag;
      +	int quiet;
       } opts;
       
     - static int maintenance_task_gc(struct repository *r)
     -@@ builtin/gc.c: static int maintenance_task_gc(struct repository *r)
     + static int maintenance_task_gc(void)
     +@@ builtin/gc.c: static int maintenance_task_gc(void)
       
       	if (opts.auto_flag)
       		argv_array_pushl(&cmd, "--auto", NULL);
      +	if (opts.quiet)
      +		argv_array_pushl(&cmd, "--quiet", NULL);
       
     - 	close_object_store(r->objects);
     + 	close_object_store(the_repository->objects);
       	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
      @@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
       	static struct option builtin_maintenance_options[] = {
  7:  335a8938c6 =  3:  f164d1a0b4 maintenance: replace run_auto_gc()
  8:  5cdd38afa6 !  4:  8e260bccf1 maintenance: initialize task array and hashmap
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    maintenance: initialize task array and hashmap
     +    maintenance: initialize task array
      
          In anticipation of implementing multiple maintenance tasks inside the
     -    'maintenance' builtin, use a list and hashmap of structs to describe the
     -    work to be done.
     +    'maintenance' builtin, use a list of structs to describe the work to be
     +    done.
      
          The struct maintenance_task stores the name of the task (as given by a
          future command-line argument) along with a function pointer to its
     @@ Commit message
          contains the "gc" task. This task is also the only task enabled by
          default.
      
     -    This list is also inserted into a hashmap. This allows command-line
     -    arguments to quickly find the tasks by name, not sensitive to case. To
     -    ensure this list and hashmap work well together, the list only contains
     -    pointers to the struct information. This will allow a sort on the list
     -    while preserving the hashmap data.
     -
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/gc.c ##
     @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
       static const char * const builtin_maintenance_usage[] = {
       	N_("git maintenance run [<options>]"),
       	NULL
     -@@ builtin/gc.c: static int maintenance_task_gc(struct repository *r)
     +@@ builtin/gc.c: static int maintenance_task_gc(void)
       	return result;
       }
       
     -+typedef int maintenance_task_fn(struct repository *r);
     ++typedef int maintenance_task_fn(void);
      +
      +struct maintenance_task {
     -+	struct hashmap_entry ent;
      +	const char *name;
      +	maintenance_task_fn *fn;
      +	unsigned enabled:1;
      +};
      +
     -+static int task_entry_cmp(const void *unused_cmp_data,
     -+			  const struct hashmap_entry *eptr,
     -+			  const struct hashmap_entry *entry_or_key,
     -+			  const void *keydata)
     -+{
     -+	const struct maintenance_task *e1, *e2;
     -+	const char *name = keydata;
     -+
     -+	e1 = container_of(eptr, const struct maintenance_task, ent);
     -+	e2 = container_of(entry_or_key, const struct maintenance_task, ent);
     -+
     -+	return strcasecmp(e1->name, name ? name : e2->name);
     -+}
     ++static struct maintenance_task *tasks[MAX_NUM_TASKS];
     ++static int num_tasks;
      +
     -+struct maintenance_task *tasks[MAX_NUM_TASKS];
     -+int num_tasks;
     -+struct hashmap task_map;
     -+
     - static int maintenance_run(struct repository *r)
     + static int maintenance_run(void)
       {
     --	return maintenance_task_gc(r);
     +-	return maintenance_task_gc();
      +	int i;
      +	int result = 0;
      +
      +	for (i = 0; !result && i < num_tasks; i++) {
      +		if (!tasks[i]->enabled)
      +			continue;
     -+		result = tasks[i]->fn(r);
     ++		result = tasks[i]->fn();
      +	}
      +
      +	return result;
     @@ builtin/gc.c: static int maintenance_task_gc(struct repository *r)
      +	tasks[num_tasks]->fn = maintenance_task_gc;
      +	tasks[num_tasks]->enabled = 1;
      +	num_tasks++;
     -+
     -+	hashmap_init(&task_map, task_entry_cmp, NULL, MAX_NUM_TASKS);
     -+
     -+	for (i = 0; i < num_tasks; i++) {
     -+		hashmap_entry_init(&tasks[i]->ent,
     -+				   strihash(tasks[i]->name));
     -+		hashmap_add(&task_map, &tasks[i]->ent);
     -+	}
       }
       
       int cmd_maintenance(int argc, const char **argv, const char *prefix)
  9:  c8fbd14d41 !  5:  04552b1d2e maintenance: add commit-graph task
     @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
       
       static const char * const builtin_maintenance_usage[] = {
       	N_("git maintenance run [<options>]"),
     -@@ builtin/gc.c: struct maintenance_opts {
     +@@ builtin/gc.c: static struct maintenance_opts {
       	int quiet;
       } opts;
       
     -+static int run_write_commit_graph(struct repository *r)
     ++static int run_write_commit_graph(void)
      +{
      +	int result;
      +	struct argv_array cmd = ARGV_ARRAY_INIT;
      +
     -+	argv_array_pushl(&cmd, "-C", r->worktree,
     -+			 "commit-graph", "write",
     -+			 "--split", "--reachable",
     -+			 NULL);
     ++	argv_array_pushl(&cmd, "commit-graph", "write",
     ++			 "--split", "--reachable", NULL);
      +
      +	if (opts.quiet)
     -+		argv_array_pushl(&cmd, "--no-progress", NULL);
     ++		argv_array_push(&cmd, "--no-progress");
      +
      +	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
      +	argv_array_clear(&cmd);
     @@ builtin/gc.c: struct maintenance_opts {
      +	return result;
      +}
      +
     -+static int run_verify_commit_graph(struct repository *r)
     ++static int run_verify_commit_graph(void)
      +{
      +	int result;
      +	struct argv_array cmd = ARGV_ARRAY_INIT;
      +
     -+	argv_array_pushl(&cmd, "-C", r->worktree,
     -+			 "commit-graph", "verify",
     ++	argv_array_pushl(&cmd, "commit-graph", "verify",
      +			 "--shallow", NULL);
      +
      +	if (opts.quiet)
     -+		argv_array_pushl(&cmd, "--no-progress", NULL);
     ++		argv_array_push(&cmd, "--no-progress");
      +
      +	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
      +	argv_array_clear(&cmd);
     @@ builtin/gc.c: struct maintenance_opts {
      +	return result;
      +}
      +
     -+static int maintenance_task_commit_graph(struct repository *r)
     ++static int maintenance_task_commit_graph(void)
      +{
     ++	struct repository *r = the_repository;
      +	char *chain_path;
      +
      +	/* Skip commit-graph when --auto is specified. */
     @@ builtin/gc.c: struct maintenance_opts {
      +		return 0;
      +
      +	close_object_store(r->objects);
     -+	if (run_write_commit_graph(r)) {
     ++	if (run_write_commit_graph()) {
      +		error(_("failed to write commit-graph"));
      +		return 1;
      +	}
      +
     -+	if (!run_verify_commit_graph(r))
     ++	if (!run_verify_commit_graph())
      +		return 0;
      +
      +	warning(_("commit-graph verify caught error, rewriting"));
     @@ builtin/gc.c: struct maintenance_opts {
      +	}
      +	free(chain_path);
      +
     -+	if (!run_write_commit_graph(r))
     ++	if (!run_write_commit_graph())
      +		return 0;
      +
      +	error(_("failed to rewrite commit-graph"));
      +	return 1;
      +}
      +
     - static int maintenance_task_gc(struct repository *r)
     + static int maintenance_task_gc(void)
       {
       	int result;
      @@ builtin/gc.c: static void initialize_tasks(void)
     + 	tasks[num_tasks]->fn = maintenance_task_gc;
       	tasks[num_tasks]->enabled = 1;
       	num_tasks++;
     - 
     ++
      +	tasks[num_tasks]->name = "commit-graph";
      +	tasks[num_tasks]->fn = maintenance_task_commit_graph;
      +	num_tasks++;
     -+
     - 	hashmap_init(&task_map, task_entry_cmp, NULL, MAX_NUM_TASKS);
     + }
       
     - 	for (i = 0; i < num_tasks; i++) {
     + int cmd_maintenance(int argc, const char **argv, const char *prefix)
      
       ## commit-graph.c ##
      @@ commit-graph.c: static char *get_split_graph_filename(struct object_directory *odb,
 10:  c081a3bd29 !  6:  a09b1c1687 maintenance: add --task option
     @@ Documentation/git-maintenance.txt: OPTIONS
      
       ## builtin/gc.c ##
      @@ builtin/gc.c: static const char * const builtin_maintenance_usage[] = {
     - struct maintenance_opts {
     + static struct maintenance_opts {
       	int auto_flag;
       	int quiet;
      +	int tasks_selected;
       } opts;
       
     - static int run_write_commit_graph(struct repository *r)
     -@@ builtin/gc.c: struct maintenance_task {
     - 	struct hashmap_entry ent;
     + static int run_write_commit_graph(void)
     +@@ builtin/gc.c: typedef int maintenance_task_fn(void);
     + struct maintenance_task {
       	const char *name;
       	maintenance_task_fn *fn;
      -	unsigned enabled:1;
     @@ builtin/gc.c: struct maintenance_task {
      +		 selected:1;
       };
       
     - static int task_entry_cmp(const void *unused_cmp_data,
     -@@ builtin/gc.c: struct maintenance_task *tasks[MAX_NUM_TASKS];
     - int num_tasks;
     - struct hashmap task_map;
     + static struct maintenance_task *tasks[MAX_NUM_TASKS];
     + static int num_tasks;
       
      +static int compare_tasks_by_selection(const void *a_, const void *b_)
      +{
     @@ builtin/gc.c: struct maintenance_task *tasks[MAX_NUM_TASKS];
      +	return b->task_order - a->task_order;
      +}
      +
     - static int maintenance_run(struct repository *r)
     + static int maintenance_run(void)
       {
       	int i;
       	int result = 0;
     @@ builtin/gc.c: struct maintenance_task *tasks[MAX_NUM_TASKS];
      +		if (!opts.tasks_selected && !tasks[i]->enabled)
       			continue;
      +
     - 		result = tasks[i]->fn(r);
     + 		result = tasks[i]->fn();
       	}
       
      @@ builtin/gc.c: static void initialize_tasks(void)
     - 	}
     + 	num_tasks++;
       }
       
      +static int task_option_parse(const struct option *opt,
      +			     const char *arg, int unset)
      +{
     -+	struct maintenance_task *task;
     -+	struct maintenance_task key;
     ++	int i;
     ++	struct maintenance_task *task = NULL;
      +
      +	BUG_ON_OPT_NEG(unset);
      +
     @@ builtin/gc.c: static void initialize_tasks(void)
      +
      +	opts.tasks_selected++;
      +
     -+	key.name = arg;
     -+	hashmap_entry_init(&key.ent, strihash(key.name));
     -+
     -+	task = hashmap_get_entry(&task_map, &key, ent, NULL);
     ++	for (i = 0; i < MAX_NUM_TASKS; i++) {
     ++		if (tasks[i] && !strcasecmp(tasks[i]->name, arg)) {
     ++			task = tasks[i];
     ++			break;
     ++		}
     ++	}
      +
      +	if (!task) {
      +		error(_("'%s' is not a valid task"), arg);
     @@ builtin/gc.c: static void initialize_tasks(void)
      +
       int cmd_maintenance(int argc, const char **argv, const char *prefix)
       {
     - 	struct repository *r = the_repository;
     + 	static struct option builtin_maintenance_options[] = {
      @@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
       			 N_("run tasks based on the state of the repository")),
       		OPT_BOOL(0, "quiet", &opts.quiet,
 11:  fc1fb5f3cc !  7:  e9260a9c3f maintenance: take a lock on the objects directory
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static int maintenance_run(struct repository *r)
     +@@ builtin/gc.c: static int maintenance_run(void)
       {
       	int i;
       	int result = 0;
      +	struct lock_file lk;
     ++	struct repository *r = the_repository;
      +	char *lock_path = xstrfmt("%s/maintenance", r->objects->odb->path);
      +
      +	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
     @@ builtin/gc.c: static int maintenance_run(struct repository *r)
       
       	if (opts.tasks_selected)
       		QSORT(tasks, num_tasks, compare_tasks_by_selection);
     -@@ builtin/gc.c: static int maintenance_run(struct repository *r)
     - 		result = tasks[i]->fn(r);
     +@@ builtin/gc.c: static int maintenance_run(void)
     + 		result = tasks[i]->fn();
       	}
       
      +	rollback_lock_file(&lk);
 12:  cbaa5ecc4f !  8:  3165b8916d maintenance: add fetch task
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    maintenance: add fetch task
     +    maintenance: add prefetch task
      
          When working with very large repositories, an incremental 'git fetch'
          command can download a large amount of data. If there are many other
     @@ Commit message
          the background. This can break up a large daily fetch into several
          smaller hourly fetches.
      
     +    The task is called "prefetch" because it is work done in advance
     +    of a foreground fetch to make that 'git fetch' command much faster.
     +
          However, if we simply ran 'git fetch <remote>' in the background,
          then the user running a foregroudn 'git fetch <remote>' would lose
          some important feedback when a new branch appears or an existing
     @@ Commit message
          2. --refmap= removes the configured refspec which usually updates
             refs/remotes/<remote>/* with the refs advertised by the remote.
      
     -    3. By adding a new refspec "+refs/heads/*:refs/hidden/<remote>/*"
     +    3. By adding a new refspec "+refs/heads/*:refs/prefetch/<remote>/*"
             we can ensure that we actually load the new values somewhere in
             our refspace while not updating refs/heads or refs/remotes. By
             storing these refs here, the commit-graph job will update the
             commit-graph with the commits from these hidden refs.
      
     -    4. --prune will delete the refs/hidden/<remote> refs that no
     +    4. --prune will delete the refs/prefetch/<remote> refs that no
             longer appear on the remote.
      
          We've been using this step as a critical background job in Scalar
     @@ Documentation/git-maintenance.txt: since it will not expire `.graph` files that
       `commit-graph-chain` file. They will be deleted by a later run based on
       the expiration delay.
       
     -+fetch::
     -+	The `fetch` job updates the object directory with the latest objects
     ++prefetch::
     ++	The `fetch` task updates the object directory with the latest objects
      +	from all registered remotes. For each remote, a `git fetch` command
      +	is run. The refmap is custom to avoid updating local or remote
      +	branches (those in `refs/heads` or `refs/remotes`). Instead, the
     -+	remote refs are stored in `refs/hidden/<remote>/`. Also, no tags are
     -+	updated.
     ++	remote refs are stored in `refs/prefetch/<remote>/`. Also, tags are
     ++	not updated.
      ++
      +This means that foreground fetches are still required to update the
      +remote refs, but the users is notified when the branches and tags are
     @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
       
       static const char * const builtin_maintenance_usage[] = {
       	N_("git maintenance run [<options>]"),
     -@@ builtin/gc.c: static int maintenance_task_commit_graph(struct repository *r)
     +@@ builtin/gc.c: static int maintenance_task_commit_graph(void)
       	return 1;
       }
       
     -+static int fetch_remote(struct repository *r, const char *remote)
     ++static int fetch_remote(const char *remote)
      +{
      +	int result;
      +	struct argv_array cmd = ARGV_ARRAY_INIT;
      +	struct strbuf refmap = STRBUF_INIT;
      +
     -+	argv_array_pushl(&cmd, "-C", r->worktree,
     -+			 "fetch", remote, "--prune",
     ++	argv_array_pushl(&cmd, "fetch", remote, "--prune",
      +			 "--no-tags", "--refmap=", NULL);
      +
     -+	strbuf_addf(&refmap, "+refs/heads/*:refs/hidden/%s/*", remote);
     ++	strbuf_addf(&refmap, "+refs/heads/*:refs/prefetch/%s/*", remote);
      +	argv_array_push(&cmd, refmap.buf);
      +
      +	if (opts.quiet)
     @@ builtin/gc.c: static int maintenance_task_commit_graph(struct repository *r)
      +	return 0;
      +}
      +
     -+static int maintenance_task_fetch(struct repository *r)
     ++static int maintenance_task_prefetch(void)
      +{
      +	int result = 0;
      +	struct string_list_item *item;
     @@ builtin/gc.c: static int maintenance_task_commit_graph(struct repository *r)
      +	for (item = remotes.items;
      +	     item && item < remotes.items + remotes.nr;
      +	     item++)
     -+		fetch_remote(r, item->string);
     ++		fetch_remote(item->string);
      +
      +cleanup:
      +	string_list_clear(&remotes, 0);
      +	return result;
      +}
      +
     - static int maintenance_task_gc(struct repository *r)
     + static int maintenance_task_gc(void)
       {
       	int result;
      @@ builtin/gc.c: static void initialize_tasks(void)
       	for (i = 0; i < MAX_NUM_TASKS; i++)
       		tasks[i] = xcalloc(1, sizeof(struct maintenance_task));
       
     -+	tasks[num_tasks]->name = "fetch";
     -+	tasks[num_tasks]->fn = maintenance_task_fetch;
     ++	tasks[num_tasks]->name = "prefetch";
     ++	tasks[num_tasks]->fn = maintenance_task_prefetch;
      +	num_tasks++;
      +
       	tasks[num_tasks]->name = "gc";
     @@ t/t7900-maintenance.sh: test_expect_success 'run --task duplicate' '
       	test_i18ngrep "cannot be selected multiple times" err
       '
       
     -+test_expect_success 'run --task=fetch with no remotes' '
     -+	git maintenance run --task=fetch 2>err &&
     ++test_expect_success 'run --task=prefetch with no remotes' '
     ++	git maintenance run --task=prefetch 2>err &&
      +	test_must_be_empty err
      +'
      +
     -+test_expect_success 'fetch multiple remotes' '
     ++test_expect_success 'prefetch multiple remotes' '
      +	git clone . clone1 &&
      +	git clone . clone2 &&
      +	git remote add remote1 "file://$(pwd)/clone1" &&
     @@ t/t7900-maintenance.sh: test_expect_success 'run --task duplicate' '
      +	git -C clone2 switch -c two &&
      +	test_commit -C clone1 one &&
      +	test_commit -C clone2 two &&
     -+	GIT_TRACE2_EVENT="$(pwd)/run-fetch.txt" git maintenance run --task=fetch &&
     -+	grep ",\"fetch\",\"remote1\"" run-fetch.txt &&
     -+	grep ",\"fetch\",\"remote2\"" run-fetch.txt &&
     ++	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch &&
     ++	grep ",\"fetch\",\"remote1\"" run-prefetch.txt &&
     ++	grep ",\"fetch\",\"remote2\"" run-prefetch.txt &&
      +	test_path_is_missing .git/refs/remotes &&
     -+	test_cmp clone1/.git/refs/heads/one .git/refs/hidden/remote1/one &&
     -+	test_cmp clone2/.git/refs/heads/two .git/refs/hidden/remote2/two &&
     -+	git log hidden/remote1/one &&
     -+	git log hidden/remote2/two
     ++	test_cmp clone1/.git/refs/heads/one .git/refs/prefetch/remote1/one &&
     ++	test_cmp clone2/.git/refs/heads/two .git/refs/prefetch/remote2/two &&
     ++	git log prefetch/remote1/one &&
     ++	git log prefetch/remote2/two
      +'
      +
       test_done
 13:  66a1f662ce !  9:  83648f4865 maintenance: add loose-objects task
     @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
       
       static const char * const builtin_maintenance_usage[] = {
       	N_("git maintenance run [<options>]"),
     -@@ builtin/gc.c: static int maintenance_task_gc(struct repository *r)
     +@@ builtin/gc.c: static int maintenance_task_gc(void)
       	return result;
       }
       
     -+
     -+static int prune_packed(struct repository *r)
     ++static int prune_packed(void)
      +{
      +	struct argv_array cmd = ARGV_ARRAY_INIT;
     -+	argv_array_pushl(&cmd, "-C", r->worktree, "prune-packed", NULL);
     ++	argv_array_pushl(&cmd, "prune-packed", NULL);
      +
      +	if (opts.quiet)
      +		argv_array_push(&cmd, "--quiet");
     @@ builtin/gc.c: static int maintenance_task_gc(struct repository *r)
      +	return ++(d->count) > d->batch_size;
      +}
      +
     -+static int pack_loose(struct repository *r)
     ++static int pack_loose(void)
      +{
     ++	struct repository *r = the_repository;
      +	int result = 0;
      +	struct write_loose_object_data data;
      +	struct strbuf prefix = STRBUF_INIT;
     @@ builtin/gc.c: static int maintenance_task_gc(struct repository *r)
      +	strbuf_addstr(&prefix, r->objects->odb->path);
      +	strbuf_addstr(&prefix, "/pack/loose");
      +
     -+	argv_array_pushl(&pack_proc->args, "git", "-C", r->worktree,
     -+			 "pack-objects", NULL);
     ++	argv_array_pushl(&pack_proc->args, "git", "pack-objects", NULL);
      +	if (opts.quiet)
      +		argv_array_push(&pack_proc->args, "--quiet");
      +	argv_array_push(&pack_proc->args, prefix.buf);
     @@ builtin/gc.c: static int maintenance_task_gc(struct repository *r)
      +	return result;
      +}
      +
     -+static int maintenance_task_loose_objects(struct repository *r)
     ++static int maintenance_task_loose_objects(void)
      +{
     -+	return prune_packed(r) || pack_loose(r);
     ++	return prune_packed() || pack_loose();
      +}
      +
     - typedef int maintenance_task_fn(struct repository *r);
     + typedef int maintenance_task_fn(void);
       
       struct maintenance_task {
      @@ builtin/gc.c: static void initialize_tasks(void)
     - 	tasks[num_tasks]->fn = maintenance_task_fetch;
     + 	tasks[num_tasks]->fn = maintenance_task_prefetch;
       	num_tasks++;
       
      +	tasks[num_tasks]->name = "loose-objects";
     @@ builtin/gc.c: static void initialize_tasks(void)
       	tasks[num_tasks]->enabled = 1;
      
       ## t/t7900-maintenance.sh ##
     -@@ t/t7900-maintenance.sh: test_expect_success 'fetch multiple remotes' '
     - 	git log hidden/remote2/two
     +@@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
     + 	git log prefetch/remote2/two
       '
       
      +test_expect_success 'loose-objects task' '
 14:  f98790024f ! 10:  b6328c2106 maintenance: add pack-files task
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    maintenance: add pack-files task
     +    maintenance: add incremental-repack task
      
          The previous change cleaned up loose objects using the
          'loose-objects' that can be run safely in the background. Add a
     @@ Commit message
          2019-06-10) and 'git multi-pack-index repack' was added in ce1e4a1
          (midx: implement midx_repack(), 2019-06-10).
      
     -    The 'pack-files' job runs the following steps:
     +    The 'incremental-repack' task runs the following steps:
      
          1. 'git multi-pack-index write' creates a multi-pack-index file if
             one did not exist, and otherwise will update the multi-pack-index
     @@ Commit message
             intention is that the resulting pack-file will be close in size
             to the provided batch size.
      
     -       The next run of the pack-files job will delete these repacked
     -       pack-files during the 'expire' step.
     +       The next run of the incremental-repack task will delete these
     +       repacked pack-files during the 'expire' step.
      
             In this version, the batch size is set to "0" which ignores the
             size restrictions when selecting the pack-files. It instead
     @@ Documentation/git-maintenance.txt: loose-objects::
       	thousand objects to prevent the job from taking too long on a
       	repository with many loose objects.
       
     -+pack-files::
     -+	The `pack-files` job incrementally repacks the object directory
     ++incremental-repack::
     ++	The `incremental-repack` job repacks the object directory
      +	using the `multi-pack-index` feature. In order to prevent race
      +	conditions with concurrent Git commands, it follows a two-step
      +	process. First, it deletes any pack-files included in the
     @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
       
       static const char * const builtin_maintenance_usage[] = {
       	N_("git maintenance run [<options>]"),
     -@@ builtin/gc.c: static int maintenance_task_loose_objects(struct repository *r)
     - 	return prune_packed(r) || pack_loose(r);
     +@@ builtin/gc.c: static int maintenance_task_loose_objects(void)
     + 	return prune_packed() || pack_loose();
       }
       
     -+static int multi_pack_index_write(struct repository *r)
     ++static int multi_pack_index_write(void)
      +{
      +	int result;
      +	struct argv_array cmd = ARGV_ARRAY_INIT;
     -+	argv_array_pushl(&cmd, "-C", r->worktree,
     -+			 "multi-pack-index", "write", NULL);
     ++	argv_array_pushl(&cmd, "multi-pack-index", "write", NULL);
      +
      +	if (opts.quiet)
      +		argv_array_push(&cmd, "--no-progress");
     @@ builtin/gc.c: static int maintenance_task_loose_objects(struct repository *r)
      +	return result;
      +}
      +
     -+static int rewrite_multi_pack_index(struct repository *r)
     ++static int rewrite_multi_pack_index(void)
      +{
     ++	struct repository *r = the_repository;
      +	char *midx_name = get_midx_filename(r->objects->odb->path);
      +
      +	unlink(midx_name);
      +	free(midx_name);
      +
     -+	if (multi_pack_index_write(r)) {
     ++	if (multi_pack_index_write()) {
      +		error(_("failed to rewrite multi-pack-index"));
      +		return 1;
      +	}
     @@ builtin/gc.c: static int maintenance_task_loose_objects(struct repository *r)
      +	return 0;
      +}
      +
     -+static int multi_pack_index_verify(struct repository *r)
     ++static int multi_pack_index_verify(void)
      +{
      +	int result;
      +	struct argv_array cmd = ARGV_ARRAY_INIT;
     -+	argv_array_pushl(&cmd, "-C", r->worktree,
     -+			 "multi-pack-index", "verify", NULL);
     ++	argv_array_pushl(&cmd, "multi-pack-index", "verify", NULL);
      +
      +	if (opts.quiet)
      +		argv_array_push(&cmd, "--no-progress");
     @@ builtin/gc.c: static int maintenance_task_loose_objects(struct repository *r)
      +	return result;
      +}
      +
     -+static int multi_pack_index_expire(struct repository *r)
     ++static int multi_pack_index_expire(void)
      +{
      +	int result;
      +	struct argv_array cmd = ARGV_ARRAY_INIT;
     -+	argv_array_pushl(&cmd, "-C", r->worktree,
     -+			 "multi-pack-index", "expire", NULL);
     ++	argv_array_pushl(&cmd, "multi-pack-index", "expire", NULL);
      +
      +	if (opts.quiet)
      +		argv_array_push(&cmd, "--no-progress");
      +
     -+	close_object_store(r->objects);
     ++	close_object_store(the_repository->objects);
      +	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
      +	argv_array_clear(&cmd);
      +
      +	return result;
      +}
      +
     -+static int multi_pack_index_repack(struct repository *r)
     ++static int multi_pack_index_repack(void)
      +{
      +	int result;
      +	struct argv_array cmd = ARGV_ARRAY_INIT;
     -+	argv_array_pushl(&cmd, "-C", r->worktree,
     -+			 "multi-pack-index", "repack", NULL);
     ++	argv_array_pushl(&cmd, "multi-pack-index", "repack", NULL);
      +
      +	if (opts.quiet)
      +		argv_array_push(&cmd, "--no-progress");
      +
      +	argv_array_push(&cmd, "--batch-size=0");
      +
     -+	close_object_store(r->objects);
     ++	close_object_store(the_repository->objects);
      +	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
      +
     -+	if (result && multi_pack_index_verify(r)) {
     ++	if (result && multi_pack_index_verify()) {
      +		warning(_("multi-pack-index verify failed after repack"));
     -+		result = rewrite_multi_pack_index(r);
     ++		result = rewrite_multi_pack_index();
      +	}
      +
      +	return result;
      +}
      +
     -+static int maintenance_task_pack_files(struct repository *r)
     ++static int maintenance_task_incremental_repack(void)
      +{
     -+	if (multi_pack_index_write(r)) {
     ++	if (multi_pack_index_write()) {
      +		error(_("failed to write multi-pack-index"));
      +		return 1;
      +	}
      +
     -+	if (multi_pack_index_verify(r)) {
     ++	if (multi_pack_index_verify()) {
      +		warning(_("multi-pack-index verify failed after initial write"));
     -+		return rewrite_multi_pack_index(r);
     ++		return rewrite_multi_pack_index();
      +	}
      +
     -+	if (multi_pack_index_expire(r)) {
     ++	if (multi_pack_index_expire()) {
      +		error(_("multi-pack-index expire failed"));
      +		return 1;
      +	}
      +
     -+	if (multi_pack_index_verify(r)) {
     ++	if (multi_pack_index_verify()) {
      +		warning(_("multi-pack-index verify failed after expire"));
     -+		return rewrite_multi_pack_index(r);
     ++		return rewrite_multi_pack_index();
      +	}
      +
     -+	if (multi_pack_index_repack(r)) {
     ++	if (multi_pack_index_repack()) {
      +		error(_("multi-pack-index repack failed"));
      +		return 1;
      +	}
     @@ builtin/gc.c: static int maintenance_task_loose_objects(struct repository *r)
      +	return 0;
      +}
      +
     - typedef int maintenance_task_fn(struct repository *r);
     + typedef int maintenance_task_fn(void);
       
       struct maintenance_task {
      @@ builtin/gc.c: static void initialize_tasks(void)
       	tasks[num_tasks]->fn = maintenance_task_loose_objects;
       	num_tasks++;
       
     -+	tasks[num_tasks]->name = "pack-files";
     -+	tasks[num_tasks]->fn = maintenance_task_pack_files;
     ++	tasks[num_tasks]->name = "incremental-repack";
     ++	tasks[num_tasks]->fn = maintenance_task_incremental_repack;
      +	num_tasks++;
      +
       	tasks[num_tasks]->name = "gc";
     @@ t/t7900-maintenance.sh: test_expect_success 'loose-objects task' '
       	test_cmp packs-between packs-after
       '
       
     -+test_expect_success 'pack-files task' '
     ++test_expect_success 'incremental-repack task' '
      +	packDir=.git/objects/pack &&
      +	for i in $(test_seq 1 5)
      +	do
     @@ t/t7900-maintenance.sh: test_expect_success 'loose-objects task' '
      +
      +	# the job repacks the two into a new pack, but does not
      +	# delete the old ones.
     -+	git maintenance run --task=pack-files &&
     ++	git maintenance run --task=incremental-repack &&
      +	ls $packDir/*.pack >packs-between &&
      +	test_line_count = 4 packs-between &&
      +
      +	# the job deletes the two old packs, and does not write
      +	# a new one because only one pack remains.
     -+	git maintenance run --task=pack-files &&
     ++	git maintenance run --task=incremental-repack &&
      +	ls .git/objects/pack/*.pack >packs-after &&
      +	test_line_count = 1 packs-after
      +'
 15:  8be89707d2 ! 11:  478c7f1d0b maintenance: auto-size pack-files batch
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    maintenance: auto-size pack-files batch
     +    maintenance: auto-size incremental-repack batch
      
     -    When repacking during the 'pack-files' job, we use the --batch-size
     -    option in 'git multi-pack-index repack'. The initial setting used
     -    --batch-size=0 to repack everything into a single pack-file. This is not
     -    sustaintable for a large repository. The amount of work required is also
     -    likely to use too many system resources for a background job.
     +    When repacking during the 'incremental-repack' task, we use the
     +    --batch-size option in 'git multi-pack-index repack'. The initial setting
     +    used --batch-size=0 to repack everything into a single pack-file. This is
     +    not sustaintable for a large repository. The amount of work required is
     +    also likely to use too many system resources for a background job.
      
     -    Update the 'pack-files' maintenance task by dynamically computing a
     +    Update the 'incremental-repack' task by dynamically computing a
          --batch-size option based on the current pack-file structure.
      
          The dynamic default size is computed with this idea in mind for a client
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static int multi_pack_index_expire(struct repository *r)
     +@@ builtin/gc.c: static int multi_pack_index_expire(void)
       	return result;
       }
       
      +#define TWO_GIGABYTES (2147483647)
      +#define UNSET_BATCH_SIZE ((unsigned long)-1)
      +
     -+static off_t get_auto_pack_size(struct repository *r)
     ++static off_t get_auto_pack_size(void)
      +{
      +	/*
      +	 * The "auto" value is special: we optimize for
     @@ builtin/gc.c: static int multi_pack_index_expire(struct repository *r)
      +	off_t second_largest_size = 0;
      +	off_t result_size;
      +	struct packed_git *p;
     ++	struct repository *r = the_repository;
      +
      +	reprepare_packed_git(r);
      +	for (p = get_all_packs(r); p; p = p->next) {
     @@ builtin/gc.c: static int multi_pack_index_expire(struct repository *r)
      +	return result_size;
      +}
      +
     - static int multi_pack_index_repack(struct repository *r)
     + static int multi_pack_index_repack(void)
       {
       	int result;
       	struct argv_array cmd = ARGV_ARRAY_INIT;
      +	struct strbuf batch_arg = STRBUF_INIT;
      +
     - 	argv_array_pushl(&cmd, "-C", r->worktree,
     - 			 "multi-pack-index", "repack", NULL);
     + 	argv_array_pushl(&cmd, "multi-pack-index", "repack", NULL);
       
       	if (opts.quiet)
       		argv_array_push(&cmd, "--no-progress");
       
      -	argv_array_push(&cmd, "--batch-size=0");
      +	strbuf_addf(&batch_arg, "--batch-size=%"PRIuMAX,
     -+			    (uintmax_t)get_auto_pack_size(r));
     ++		    (uintmax_t)get_auto_pack_size());
      +	argv_array_push(&cmd, batch_arg.buf);
       
     - 	close_object_store(r->objects);
     + 	close_object_store(the_repository->objects);
       	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
      +	strbuf_release(&batch_arg);
       
     - 	if (result && multi_pack_index_verify(r)) {
     + 	if (result && multi_pack_index_verify()) {
       		warning(_("multi-pack-index verify failed after repack"));
      
       ## t/t7900-maintenance.sh ##
     -@@ t/t7900-maintenance.sh: test_expect_success 'pack-files task' '
     +@@ t/t7900-maintenance.sh: test_expect_success 'incremental-repack task' '
       	test_line_count = 4 packs-between &&
       
       	# the job deletes the two old packs, and does not write
      -	# a new one because only one pack remains.
      +	# a new one because the batch size is not high enough to
      +	# pack the largest pack-file.
     - 	git maintenance run --task=pack-files &&
     + 	git maintenance run --task=incremental-repack &&
       	ls .git/objects/pack/*.pack >packs-after &&
      -	test_line_count = 1 packs-after
      +	test_line_count = 2 packs-after
 16:  1551aec4fd ! 12:  a3c64930a0 maintenance: create maintenance.<task>.enabled config
     @@ Documentation/git-maintenance.txt: SUBCOMMANDS
       -----
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static int maintenance_run(struct repository *r)
     - 	return result;
     - }
     - 
     --static void initialize_tasks(void)
     -+static void initialize_tasks(struct repository *r)
     +@@ builtin/gc.c: static int maintenance_run(void)
     + static void initialize_tasks(void)
       {
       	int i;
      +	struct strbuf config_name = STRBUF_INIT;
     @@ builtin/gc.c: static int maintenance_run(struct repository *r)
       
       	for (i = 0; i < MAX_NUM_TASKS; i++)
      @@ builtin/gc.c: static void initialize_tasks(void)
     - 	hashmap_init(&task_map, task_entry_cmp, NULL, MAX_NUM_TASKS);
     - 
     - 	for (i = 0; i < num_tasks; i++) {
     -+		int config_value;
     + 	tasks[num_tasks]->name = "commit-graph";
     + 	tasks[num_tasks]->fn = maintenance_task_commit_graph;
     + 	num_tasks++;
      +
     - 		hashmap_entry_init(&tasks[i]->ent,
     - 				   strihash(tasks[i]->name));
     - 		hashmap_add(&task_map, &tasks[i]->ent);
     ++	for (i = 0; i < num_tasks; i++) {
     ++		int config_value;
      +
      +		strbuf_setlen(&config_name, 0);
      +		strbuf_addf(&config_name, "maintenance.%s.enabled", tasks[i]->name);
      +
     -+		if (!repo_config_get_bool(r, config_name.buf, &config_value))
     ++		if (!git_config_get_bool(config_name.buf, &config_value))
      +			tasks[i]->enabled = config_value;
     - 	}
     ++	}
      +
      +	strbuf_release(&config_name);
       }
       
       static int task_option_parse(const struct option *opt,
     -@@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
     - 				   builtin_maintenance_options);
     - 
     - 	opts.quiet = !isatty(2);
     --	initialize_tasks();
     -+	initialize_tasks(r);
     - 
     - 	argc = parse_options(argc, argv, prefix,
     - 			     builtin_maintenance_options,
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'run [--auto|--quiet]' '
 17:  130130b662 ! 13:  dbacc2b76c maintenance: use pointers to check --auto
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static int maintenance_task_pack_files(struct repository *r)
     +@@ builtin/gc.c: static int maintenance_task_incremental_repack(void)
       
     - typedef int maintenance_task_fn(struct repository *r);
     + typedef int maintenance_task_fn(void);
       
      +/*
      + * An auto condition function returns 1 if the task should run
      + * and 0 if the task should NOT run. See needs_to_gc() for an
      + * example.
      + */
     -+typedef int maintenance_auto_fn(struct repository *r);
     ++typedef int maintenance_auto_fn(void);
      +
       struct maintenance_task {
     - 	struct hashmap_entry ent;
       	const char *name;
       	maintenance_task_fn *fn;
      +	maintenance_auto_fn *auto_condition;
       	int task_order;
       	unsigned enabled:1,
       		 selected:1;
     -@@ builtin/gc.c: static int maintenance_run(struct repository *r)
     +@@ builtin/gc.c: static int maintenance_run(void)
       		if (!opts.tasks_selected && !tasks[i]->enabled)
       			continue;
       
      +		if (opts.auto_flag &&
      +		    (!tasks[i]->auto_condition ||
     -+		     !tasks[i]->auto_condition(r)))
     ++		     !tasks[i]->auto_condition()))
      +			continue;
      +
     - 		result = tasks[i]->fn(r);
     + 		result = tasks[i]->fn();
       	}
       
     -@@ builtin/gc.c: static void initialize_tasks(struct repository *r)
     +@@ builtin/gc.c: static void initialize_tasks(void)
       
       	tasks[num_tasks]->name = "gc";
       	tasks[num_tasks]->fn = maintenance_task_gc;
     @@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefi
       				   builtin_maintenance_options);
       
       	opts.quiet = !isatty(2);
     -+	gc_config(r);
     - 	initialize_tasks(r);
     ++	gc_config();
     + 	initialize_tasks();
       
       	argc = parse_options(argc, argv, prefix,
      
 18:  37fa3f6157 ! 14:  9af2309f08 maintenance: add auto condition for commit-graph task
     @@ builtin/gc.c
       
       #define FAILED_RUN "failed to run %s"
       
     -@@ builtin/gc.c: struct maintenance_opts {
     +@@ builtin/gc.c: static struct maintenance_opts {
       	int tasks_selected;
       } opts;
       
     @@ builtin/gc.c: struct maintenance_opts {
      +	return result;
      +}
      +
     -+static int should_write_commit_graph(struct repository *r)
     ++static int should_write_commit_graph(void)
      +{
      +	int result;
      +
     -+	repo_config_get_int(r, "maintenance.commit-graph.auto",
     -+			    &limit_commits_not_in_graph);
     ++	git_config_get_int("maintenance.commit-graph.auto",
     ++			   &limit_commits_not_in_graph);
      +
      +	if (!limit_commits_not_in_graph)
      +		return 0;
     @@ builtin/gc.c: struct maintenance_opts {
      +	return result;
      +}
      +
     - static int run_write_commit_graph(struct repository *r)
     + static int run_write_commit_graph(void)
       {
       	int result;
     -@@ builtin/gc.c: static void initialize_tasks(struct repository *r)
     +@@ builtin/gc.c: static void initialize_tasks(void)
       
       	tasks[num_tasks]->name = "commit-graph";
       	tasks[num_tasks]->fn = maintenance_task_commit_graph;
      +	tasks[num_tasks]->auto_condition = should_write_commit_graph;
       	num_tasks++;
       
     - 	hashmap_init(&task_map, task_entry_cmp, NULL, MAX_NUM_TASKS);
     + 	for (i = 0; i < num_tasks; i++) {
      
       ## object.h ##
      @@ object.h: struct object_array {
 19:  4744fdaae9 ! 15:  42e316ca58 maintenance: create auto condition for loose-objects
     @@ builtin/gc.c: struct write_loose_object_data {
      +	return 0;
      +}
      +
     -+static int loose_object_auto_condition(struct repository *r)
     ++static int loose_object_auto_condition(void)
      +{
      +	int count = 0;
      +
     -+	repo_config_get_int(r, "maintenance.loose-objects.auto",
     -+			    &loose_object_auto_limit);
     ++	git_config_get_int("maintenance.loose-objects.auto",
     ++			   &loose_object_auto_limit);
      +
      +	if (!loose_object_auto_limit)
      +		return 0;
      +	if (loose_object_auto_limit < 0)
      +		return 1;
      +
     -+	return for_each_loose_file_in_objdir(r->objects->odb->path,
     ++	return for_each_loose_file_in_objdir(the_repository->objects->odb->path,
      +					     loose_object_count,
      +					     NULL, NULL, &count);
      +}
     @@ builtin/gc.c: struct write_loose_object_data {
       static int loose_object_exists(const struct object_id *oid,
       			       const char *path,
       			       void *data)
     -@@ builtin/gc.c: static void initialize_tasks(struct repository *r)
     +@@ builtin/gc.c: static void initialize_tasks(void)
       
       	tasks[num_tasks]->name = "loose-objects";
       	tasks[num_tasks]->fn = maintenance_task_loose_objects;
      +	tasks[num_tasks]->auto_condition = loose_object_auto_condition;
       	num_tasks++;
       
     - 	tasks[num_tasks]->name = "pack-files";
     + 	tasks[num_tasks]->name = "incremental-repack";
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'loose-objects task' '
     @@ t/t7900-maintenance.sh: test_expect_success 'loose-objects task' '
      +	done
      +'
      +
     - test_expect_success 'pack-files task' '
     + test_expect_success 'incremental-repack task' '
       	packDir=.git/objects/pack &&
       	for i in $(test_seq 1 5)
 20:  fbe03b9af9 ! 16:  3d527cb0dd maintenance: add pack-files auto condition
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    maintenance: add pack-files auto condition
     +    maintenance: add incremental-repack auto condition
      
     -    The pack-files task updates the multi-pack-index by deleting pack-files
     -    that have been replaced with new packs, then repacking a batch of small
     -    pack-files into a larger pack-file. This incremental repack is faster
     +    The incremental-repack task updates the multi-pack-index by deleting pack-
     +    files that have been replaced with new packs, then repacking a batch of
     +    small pack-files into a larger pack-file. This incremental repack is faster
          than rewriting all object data, but is slower than some other
          maintenance activities.
      
     -    The 'maintenance.pack-files.auto' config option specifies how many
     +    The 'maintenance.incremental-repack.auto' config option specifies how many
          pack-files should exist outside of the multi-pack-index before running
          the step. These pack-files could be created by 'git fetch' commands or
          by the loose-objects task. The default value is 10.
     @@ Documentation/config/maintenance.txt: maintenance.loose-objects.auto::
       	loose objects is at least the value of `maintenance.loose-objects.auto`.
       	The default value is 100.
      +
     -+maintenance.pack-files.auto::
     -+	This integer config option controls how often the `pack-files` task
     -+	should be run as part of `git maintenance run --auto`. If zero, then
     -+	the `pack-files` task will not run with the `--auto` option. A
     -+	negative value will force the task to run every time. Otherwise, a
     -+	positive value implies the command should run when the number of
     -+	pack-files not in the multi-pack-index is at least the value of
     -+	`maintenance.pack-files.auto`. The default value is 10.
     ++maintenance.incremental-repack.auto::
     ++	This integer config option controls how often the `incremental-repack`
     ++	task should be run as part of `git maintenance run --auto`. If zero,
     ++	then the `incremental-repack` task will not run with the `--auto`
     ++	option. A negative value will force the task to run every time.
     ++	Otherwise, a positive value implies the command should run when the
     ++	number of pack-files not in the multi-pack-index is at least the value
     ++	of `maintenance.incremental-repack.auto`. The default value is 10.
      
       ## builtin/gc.c ##
      @@
     @@ builtin/gc.c
       
       #define FAILED_RUN "failed to run %s"
       
     -@@ builtin/gc.c: static int maintenance_task_loose_objects(struct repository *r)
     - 	return prune_packed(r) || pack_loose(r);
     +@@ builtin/gc.c: static int maintenance_task_loose_objects(void)
     + 	return prune_packed() || pack_loose();
       }
       
     -+static int pack_files_auto_condition(struct repository *r)
     ++static int incremental_repack_auto_condition(void)
      +{
      +	struct packed_git *p;
      +	int enabled;
     -+	int pack_files_auto_limit = 10;
     ++	int incremental_repack_auto_limit = 10;
      +	int count = 0;
      +
     -+	if (repo_config_get_bool(r, "core.multiPackIndex", &enabled) ||
     ++	if (git_config_get_bool("core.multiPackIndex", &enabled) ||
      +	    !enabled)
      +		return 0;
      +
     -+	repo_config_get_int(r, "maintenance.pack-files.auto",
     -+			    &pack_files_auto_limit);
     ++	git_config_get_int("maintenance.incremental-repack.auto",
     ++			   &incremental_repack_auto_limit);
      +
     -+	if (!pack_files_auto_limit)
     ++	if (!incremental_repack_auto_limit)
      +		return 0;
     -+	if (pack_files_auto_limit < 0)
     ++	if (incremental_repack_auto_limit < 0)
      +		return 1;
      +
     -+	for (p = get_packed_git(r);
     -+	     count < pack_files_auto_limit && p;
     ++	for (p = get_packed_git(the_repository);
     ++	     count < incremental_repack_auto_limit && p;
      +	     p = p->next) {
      +		if (!p->multi_pack_index)
      +			count++;
      +	}
      +
     -+	return count >= pack_files_auto_limit;
     ++	return count >= incremental_repack_auto_limit;
      +}
      +
     - static int multi_pack_index_write(struct repository *r)
     + static int multi_pack_index_write(void)
       {
       	int result;
     -@@ builtin/gc.c: static void initialize_tasks(struct repository *r)
     +@@ builtin/gc.c: static void initialize_tasks(void)
       
     - 	tasks[num_tasks]->name = "pack-files";
     - 	tasks[num_tasks]->fn = maintenance_task_pack_files;
     -+	tasks[num_tasks]->auto_condition = pack_files_auto_condition;
     + 	tasks[num_tasks]->name = "incremental-repack";
     + 	tasks[num_tasks]->fn = maintenance_task_incremental_repack;
     ++	tasks[num_tasks]->auto_condition = incremental_repack_auto_condition;
       	num_tasks++;
       
       	tasks[num_tasks]->name = "gc";
      
       ## t/t7900-maintenance.sh ##
     -@@ t/t7900-maintenance.sh: test_expect_success 'pack-files task' '
     +@@ t/t7900-maintenance.sh: test_expect_success 'incremental-repack task' '
       	test_line_count = 2 packs-after
       '
       
     -+test_expect_success 'maintenance.pack-files.auto' '
     ++test_expect_success 'maintenance.incremental-repack.auto' '
      +	git repack -adk &&
      +	git config core.multiPackIndex true &&
      +	git multi-pack-index write &&
     -+	GIT_TRACE2_EVENT=1 git -c maintenance.pack-files.auto=1 maintenance \
     -+		run --auto --task=pack-files >out &&
     ++	GIT_TRACE2_EVENT=1 git -c maintenance.incremental-repack.auto=1 \
     ++		maintenance run --auto --task=incremental-repack >out &&
      +	! grep "\"multi-pack-index\"" out &&
      +	for i in 1 2
      +	do
     @@ t/t7900-maintenance.sh: test_expect_success 'pack-files task' '
      +		^HEAD~1
      +		EOF
      +		GIT_TRACE2_EVENT=$(pwd)/trace-A-$i git \
     -+			-c maintenance.pack-files.auto=2 \
     -+			maintenance run --auto --task=pack-files &&
     ++			-c maintenance.incremental-repack.auto=2 \
     ++			maintenance run --auto --task=incremental-repack &&
      +		! grep "\"multi-pack-index\"" trace-A-$i &&
      +		test_commit B-$i &&
      +		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
     @@ t/t7900-maintenance.sh: test_expect_success 'pack-files task' '
      +		^HEAD~1
      +		EOF
      +		GIT_TRACE2_EVENT=$(pwd)/trace-B-$i git \
     -+			-c maintenance.pack-files.auto=2 \
     -+			maintenance run --auto --task=pack-files >out &&
     ++			-c maintenance.incremental-repack.auto=2 \
     ++			maintenance run --auto --task=incremental-repack >out &&
      +		grep "\"multi-pack-index\"" trace-B-$i >/dev/null || return 1
      +	done
      +'
 21:  f7fdf72e9d = 17:  a0f00f8ab8 midx: use start_delayed_progress()
  -:  ---------- > 18:  f24db7739f maintenance: add trace2 regions for task execution

-- 
gitgitgadget
