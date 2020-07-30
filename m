Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375F7C433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96B120829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfpF4Lun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgG3WYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbgG3WYg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240BBC061574
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r4so23321131wrx.9
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1iNjLse4jqPZc7+2YhB/6goZwrHkOwkQLOVLhexlXUw=;
        b=qfpF4Lun/3Fbko9BL1ffitNW5HLoVWyxEdiIau/awoxPtaHzdlew8M3Bv7chQ6w/iF
         L8y0ZVUfn3izVYJY0JK75Le5WkSCqoaZf8XG1VvvrSeUEdQFROc0e2yzn9R0cotT7h1s
         6KNI3EdPDJv3Uv9IUeHFPfTp/qGJFov/4ck57m8XYnP/OzVrmqmIB3XXzrbGr6C76t3O
         uEmeSAIGIryrZxiF9CFFbU6saEKAX9dbbD+FiNgj4Twahm6XdPPdtoa9YrvSnE9qliS2
         Ff1kLMBs2l5ysFMRJpYy7IhlBUFz0GfQi4m/mJoPrcRMrlFfhzBbXa4OY6pkQJBBL7vI
         6ZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1iNjLse4jqPZc7+2YhB/6goZwrHkOwkQLOVLhexlXUw=;
        b=APDG102dBqigOpioRPrQCQcVnjHYKyVAa/TSJLIYm3LnQXhjvyueGGahRt7lC3QFYs
         E9I+cppc6lwZ1M9FQ7/cbYycoZrVbgedJJHH7VgbsCKSEm8snsMZUFnk+345RRMovQYt
         GLtB4vpssWj4vJv3R7zwk+27JM6DrEMQ4WrtlblDpElA4Hw1MQloVAzL1rlxn2GsBJsr
         NECZlDYZ74bzLXRUIQYl6eR0OrMKCoo4HFXh7MlnJItXCsGSaSR72lkpRFIqA1KHU2Js
         kPcmcXh7f9q8PDS+TQS315OUSG8omz+QRBYWtmC9AwgnF8NfgKNFH7un0apo4LXGEHm0
         MMPA==
X-Gm-Message-State: AOAM53091MlYeJUvamDguh08OJjadk5ObL2L/o94GFN6WKQgKOW6C1G0
        j9mPaCGJnKtVdhg3tMk3igJOR6BS
X-Google-Smtp-Source: ABdhPJx4Kqw1BdP3qfhlGipXz4PiHe2zA6u5e07lt+sTObcnfyaK53NKh9lG9d5F6ZiWwHDqKbwkzw==
X-Received: by 2002:a5d:4611:: with SMTP id t17mr635540wrq.243.1596147873180;
        Thu, 30 Jul 2020 15:24:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18sm10733953wrs.46.2020.07.30.15.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:28 -0700 (PDT)
Message-Id: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:06 +0000
Subject: [PATCH v3 00/20] Maintenance builtin, allowing 'gc --auto' customization
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
   
   

UPDATES in V3
=============

 * This series is now based on jk/strvec, as there are several places where
   I was adding new callers to argv_array_push* and run_command_v_opt()
   which have been replaced with strvec_push*() and run_command(), using a
   'struct child_process'.
   
   
 * I added and updates Junio's patch from jc/no-update-fetch-head into the
   proper place before the 'prefetch' task. The 'prefetch' task now uses
   --no-write-fetch-head to avoid issues with FETCH_HEAD.
   
   
 * Since there were concerns around core.multiPackIndex, I added some extra
   care checking for that config being enabled. Since that already needed to
   adjust the config value from its existing implementation in midx.c, I
   added it to repo-settings and made it enabled by default.
   
   
 * Lots of feedback from the previous round. Thanks, all! I fully expect to
   have at least one more round of feedback, but things are improving quite
   a lot.
   
   

Thanks, -Stolee

Derrick Stolee (19):
  maintenance: create basic maintenance runner
  maintenance: add --quiet option
  maintenance: replace run_auto_gc()
  maintenance: initialize task array
  maintenance: add commit-graph task
  maintenance: add --task option
  maintenance: take a lock on the objects directory
  maintenance: add prefetch task
  maintenance: add loose-objects task
  midx: enable core.multiPackIndex by default
  maintenance: add incremental-repack task
  maintenance: auto-size incremental-repack batch
  maintenance: create maintenance.<task>.enabled config
  maintenance: use pointers to check --auto
  maintenance: add auto condition for commit-graph task
  maintenance: create auto condition for loose-objects
  maintenance: add incremental-repack auto condition
  midx: use start_delayed_progress()
  maintenance: add trace2 regions for task execution

Junio C Hamano (1):
  fetch: optionally allow disabling FETCH_HEAD update

 .gitignore                           |   1 +
 Documentation/config.txt             |   2 +
 Documentation/config/core.txt        |   4 +-
 Documentation/config/fetch.txt       |   7 +
 Documentation/config/maintenance.txt |  32 ++
 Documentation/fetch-options.txt      |  16 +-
 Documentation/git-clone.txt          |   6 +-
 Documentation/git-maintenance.txt    | 127 +++++
 builtin.h                            |   1 +
 builtin/am.c                         |   2 +-
 builtin/commit.c                     |   2 +-
 builtin/fetch.c                      |  25 +-
 builtin/gc.c                         | 713 +++++++++++++++++++++++++++
 builtin/merge.c                      |   2 +-
 builtin/pull.c                       |   3 +-
 builtin/rebase.c                     |   4 +-
 commit-graph.c                       |   8 +-
 commit-graph.h                       |   1 +
 git.c                                |   1 +
 midx.c                               |  23 +-
 midx.h                               |   1 +
 object.h                             |   1 +
 repo-settings.c                      |   6 +
 repository.h                         |   2 +
 run-command.c                        |  16 +-
 run-command.h                        |   2 +-
 t/t5319-multi-pack-index.sh          |  15 +-
 t/t5510-fetch.sh                     |  41 +-
 t/t5514-fetch-multiple.sh            |   2 +-
 t/t5521-pull-options.sh              |  16 +
 t/t7900-maintenance.sh               | 215 ++++++++
 31 files changed, 1240 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/config/maintenance.txt
 create mode 100644 Documentation/git-maintenance.txt
 create mode 100755 t/t7900-maintenance.sh


base-commit: 90dfbf331c0ade4c15c74276c466e32e384f9ceb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-671%2Fderrickstolee%2Fmaintenance%2Fgc-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-671/derrickstolee/maintenance/gc-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/671

Range-diff vs v2:

  1:  63ec602a07 !  1:  12fe73bb72 maintenance: create basic maintenance runner
     @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
      +
      +static int maintenance_task_gc(void)
      +{
     -+	int result;
     -+	struct argv_array cmd = ARGV_ARRAY_INIT;
     ++	struct child_process child = CHILD_PROCESS_INIT;
      +
     -+	argv_array_pushl(&cmd, "gc", NULL);
     ++	child.git_cmd = 1;
     ++	strvec_push(&child.args, "gc");
      +
      +	if (opts.auto_flag)
     -+		argv_array_pushl(&cmd, "--auto", NULL);
     ++		strvec_push(&child.args, "--auto");
      +
      +	close_object_store(the_repository->objects);
     -+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
     -+	argv_array_clear(&cmd);
     -+
     -+	return result;
     ++	return run_command(&child);
      +}
      +
      +static int maintenance_run(void)
     @@ t/t7900-maintenance.sh (new)
      +
      +test_description='git maintenance builtin'
      +
     -+GIT_TEST_COMMIT_GRAPH=0
     -+GIT_TEST_MULTI_PACK_INDEX=0
     -+
      +. ./test-lib.sh
      +
      +test_expect_success 'help text' '
     -+	test_must_fail git maintenance -h 2>err &&
     ++	test_expect_code 129 git maintenance -h 2>err &&
      +	test_i18ngrep "usage: git maintenance run" err
      +'
      +
     -+test_expect_success 'gc [--auto]' '
     ++test_expect_success 'run [--auto]' '
      +	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run &&
      +	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
      +	grep ",\"gc\"]" run-no-auto.txt  &&
  2:  1d37e55cb7 !  2:  6e533e43d7 maintenance: add --quiet option
     @@ builtin/gc.c: static const char * const builtin_maintenance_usage[] = {
      @@ builtin/gc.c: static int maintenance_task_gc(void)
       
       	if (opts.auto_flag)
     - 		argv_array_pushl(&cmd, "--auto", NULL);
     + 		strvec_push(&child.args, "--auto");
      +	if (opts.quiet)
     -+		argv_array_pushl(&cmd, "--quiet", NULL);
     ++		strvec_push(&child.args, "--quiet");
       
       	close_object_store(the_repository->objects);
     - 	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
     + 	return run_command(&child);
      @@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
       	static struct option builtin_maintenance_options[] = {
       		OPT_BOOL(0, "auto", &opts.auto_flag,
     @@ t/t7900-maintenance.sh: test_expect_success 'help text' '
       	test_i18ngrep "usage: git maintenance run" err
       '
       
     --test_expect_success 'gc [--auto]' '
     +-test_expect_success 'run [--auto]' '
      -	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run &&
     -+test_expect_success 'gc [--auto|--quiet]' '
     ++test_expect_success 'run [--auto|--quiet]' '
      +	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run --no-quiet &&
       	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
      +	GIT_TRACE2_EVENT="$(pwd)/run-quiet.txt" git maintenance run --quiet &&
  3:  f164d1a0b4 !  3:  c4674fc211 maintenance: replace run_auto_gc()
     @@ Commit message
      
          Rename run_auto_gc() to run_auto_maintenance() to be clearer what is
          happening on this call, and to expose all callers in the current diff.
     +    Rewrite the method to use a struct child_process to simplify the calls
     +    slightly.
      
          Since 'git fetch' already allows disabling the 'git gc --auto'
          subprocess, add an equivalent option with a different name to be more
     @@ Documentation/fetch-options.txt: ifndef::git-pull[]
       	Allow several <repository> and <group> arguments to be
       	specified. No <refspec>s may be specified.
       
     -+--[no-]maintenance::
     ++--[no-]auto-maintenance::
       --[no-]auto-gc::
      -	Run `git gc --auto` at the end to perform garbage collection
      -	if needed. This is enabled by default.
     -+	Run `git maintenance run --auto` at the end to perform garbage
     -+	collection if needed. This is enabled by default.
     ++	Run `git maintenance run --auto` at the end to perform automatic
     ++	repository maintenance if needed. (`--[no-]auto-gc` is a synonym.)
     ++	This is enabled by default.
       
       --[no-]write-commit-graph::
       	Write a commit-graph after fetching. This overrides the config
     @@ Documentation/git-clone.txt: repository using this option and then delete branch
      -which automatically call `git gc --auto`. (See linkgit:git-gc[1].)
      -If these objects are removed and were referenced by the cloned repository,
      -then the cloned repository will become corrupt.
     -+which automatically call `git maintenance run --auto` and `git gc --auto`.
     -+(See linkgit:git-maintenance[1] and linkgit:git-gc[1].) If these objects
     -+are removed and were referenced by the cloned repository, then the cloned
     -+repository will become corrupt.
     ++which automatically call `git maintenance run --auto`. (See
     ++linkgit:git-maintenance[1].) If these objects are removed and were referenced
     ++by the cloned repository, then the cloned repository will become corrupt.
       +
       Note that running `git repack` without the `--local` option in a repository
       cloned with `--shared` will copy objects from the source repository into a pack
     @@ builtin/fetch.c: static struct option builtin_fetch_options[] = {
       	OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
       			N_("report that we have only objects reachable from this object")),
       	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
     -+	OPT_BOOL(0, "maintenance", &enable_auto_gc,
     ++	OPT_BOOL(0, "auto-maintenance", &enable_auto_gc,
      +		 N_("run 'maintenance --auto' after fetching")),
       	OPT_BOOL(0, "auto-gc", &enable_auto_gc,
      -		 N_("run 'gc --auto' after fetching")),
     @@ run-command.c: int run_processes_parallel_tr2(int n, get_next_task_fn get_next_t
      -int run_auto_gc(int quiet)
      +int run_auto_maintenance(int quiet)
       {
     - 	struct argv_array argv_gc_auto = ARGV_ARRAY_INIT;
     - 	int status;
     +-	struct strvec argv_gc_auto = STRVEC_INIT;
     +-	int status;
     ++	struct child_process maint = CHILD_PROCESS_INIT;
       
     --	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
     -+	argv_array_pushl(&argv_gc_auto, "maintenance", "run", "--auto", NULL);
     - 	if (quiet)
     - 		argv_array_push(&argv_gc_auto, "--quiet");
     -+	else
     -+		argv_array_push(&argv_gc_auto, "--no-quiet");
     +-	strvec_pushl(&argv_gc_auto, "gc", "--auto", NULL);
     +-	if (quiet)
     +-		strvec_push(&argv_gc_auto, "--quiet");
     +-	status = run_command_v_opt(argv_gc_auto.items, RUN_GIT_CMD);
     +-	strvec_clear(&argv_gc_auto);
     +-	return status;
     ++	maint.git_cmd = 1;
     ++	strvec_pushl(&maint.args, "maintenance", "run", "--auto", NULL);
     ++	strvec_push(&maint.args, quiet ? "--quiet" : "--no-quiet");
      +
     - 	status = run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
     - 	argv_array_clear(&argv_gc_auto);
     - 	return status;
     ++	return run_command(&maint);
     + }
      
       ## run-command.h ##
      @@ run-command.h: int run_hook_ve(const char *const *env, const char *name, va_list args);
  4:  8e260bccf1 !  4:  b9332c1318 maintenance: initialize task array
     @@ Commit message
          future command-line argument) along with a function pointer to its
          implementation and a boolean for whether the step is enabled.
      
     -    A list of pointers to these structs are initialized with the full list
     -    of implemented tasks along with a default order. For now, this list only
     -    contains the "gc" task. This task is also the only task enabled by
     -    default.
     +    A list these structs are initialized with the full list of implemented
     +    tasks along with a default order. For now, this list only contains the
     +    "gc" task. This task is also the only task enabled by default.
      
     +    The run subcommand will return a nonzero exit code if any task fails.
     +    However, it will attempt all tasks in its loop before returning with the
     +    failure. Also each failed task will send an error message.
     +
     +    Helped-by: Taylor Blau <me@ttaylorr.com>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
     - 	return 0;
     - }
     - 
     -+#define MAX_NUM_TASKS 1
     -+
     - static const char * const builtin_maintenance_usage[] = {
     - 	N_("git maintenance run [<options>]"),
     - 	NULL
      @@ builtin/gc.c: static int maintenance_task_gc(void)
     - 	return result;
     + 	return run_command(&child);
       }
       
      +typedef int maintenance_task_fn(void);
     @@ builtin/gc.c: static int maintenance_task_gc(void)
      +	unsigned enabled:1;
      +};
      +
     -+static struct maintenance_task *tasks[MAX_NUM_TASKS];
     -+static int num_tasks;
     ++enum maintenance_task_label {
     ++	TASK_GC,
     ++
     ++	/* Leave as final value */
     ++	TASK__COUNT
     ++};
     ++
     ++static struct maintenance_task tasks[] = {
     ++	[TASK_GC] = {
     ++		"gc",
     ++		maintenance_task_gc,
     ++		1,
     ++	},
     ++};
      +
       static int maintenance_run(void)
       {
     @@ builtin/gc.c: static int maintenance_task_gc(void)
      +	int i;
      +	int result = 0;
      +
     -+	for (i = 0; !result && i < num_tasks; i++) {
     -+		if (!tasks[i]->enabled)
     ++	for (i = 0; i < TASK__COUNT; i++) {
     ++		if (!tasks[i].enabled)
      +			continue;
     -+		result = tasks[i]->fn();
     ++
     ++		if (tasks[i].fn()) {
     ++			error(_("task '%s' failed"), tasks[i].name);
     ++			result = 1;
     ++		}
      +	}
      +
      +	return result;
     -+}
     -+
     -+static void initialize_tasks(void)
     -+{
     -+	int i;
     -+	num_tasks = 0;
     -+
     -+	for (i = 0; i < MAX_NUM_TASKS; i++)
     -+		tasks[i] = xcalloc(1, sizeof(struct maintenance_task));
     -+
     -+	tasks[num_tasks]->name = "gc";
     -+	tasks[num_tasks]->fn = maintenance_task_gc;
     -+	tasks[num_tasks]->enabled = 1;
     -+	num_tasks++;
       }
       
       int cmd_maintenance(int argc, const char **argv, const char *prefix)
     -@@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
     - 				   builtin_maintenance_options);
     - 
     - 	opts.quiet = !isatty(2);
     -+	initialize_tasks();
     - 
     - 	argc = parse_options(argc, argv, prefix,
     - 			     builtin_maintenance_options,
  5:  04552b1d2e !  5:  a4d9836bed maintenance: add commit-graph task
     @@ Documentation/git-maintenance.txt: run::
       	stands for "garbage collection," but this task performs many
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
     - 	return 0;
     - }
     - 
     --#define MAX_NUM_TASKS 1
     -+#define MAX_NUM_TASKS 2
     - 
     - static const char * const builtin_maintenance_usage[] = {
     - 	N_("git maintenance run [<options>]"),
      @@ builtin/gc.c: static struct maintenance_opts {
       	int quiet;
       } opts;
       
      +static int run_write_commit_graph(void)
      +{
     -+	int result;
     -+	struct argv_array cmd = ARGV_ARRAY_INIT;
     ++	struct child_process child = CHILD_PROCESS_INIT;
      +
     -+	argv_array_pushl(&cmd, "commit-graph", "write",
     -+			 "--split", "--reachable", NULL);
     ++	child.git_cmd = 1;
     ++	strvec_pushl(&child.args, "commit-graph", "write",
     ++		     "--split", "--reachable", NULL);
      +
      +	if (opts.quiet)
     -+		argv_array_push(&cmd, "--no-progress");
     -+
     -+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
     -+	argv_array_clear(&cmd);
     ++		strvec_push(&child.args, "--no-progress");
      +
     -+	return result;
     ++	return !!run_command(&child);
      +}
      +
      +static int run_verify_commit_graph(void)
      +{
     -+	int result;
     -+	struct argv_array cmd = ARGV_ARRAY_INIT;
     ++	struct child_process child = CHILD_PROCESS_INIT;
      +
     -+	argv_array_pushl(&cmd, "commit-graph", "verify",
     -+			 "--shallow", NULL);
     ++	child.git_cmd = 1;
     ++	strvec_pushl(&child.args, "commit-graph", "verify",
     ++		     "--shallow", NULL);
      +
      +	if (opts.quiet)
     -+		argv_array_push(&cmd, "--no-progress");
     ++		strvec_push(&child.args, "--no-progress");
      +
     -+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
     -+	argv_array_clear(&cmd);
     -+
     -+	return result;
     ++	return !!run_command(&child);
      +}
      +
      +static int maintenance_task_commit_graph(void)
     @@ builtin/gc.c: static struct maintenance_opts {
      +	struct repository *r = the_repository;
      +	char *chain_path;
      +
     -+	/* Skip commit-graph when --auto is specified. */
     -+	if (opts.auto_flag)
     -+		return 0;
     -+
      +	close_object_store(r->objects);
      +	if (run_write_commit_graph()) {
      +		error(_("failed to write commit-graph"));
     @@ builtin/gc.c: static struct maintenance_opts {
      +
       static int maintenance_task_gc(void)
       {
     - 	int result;
     -@@ builtin/gc.c: static void initialize_tasks(void)
     - 	tasks[num_tasks]->fn = maintenance_task_gc;
     - 	tasks[num_tasks]->enabled = 1;
     - 	num_tasks++;
     -+
     -+	tasks[num_tasks]->name = "commit-graph";
     -+	tasks[num_tasks]->fn = maintenance_task_commit_graph;
     -+	num_tasks++;
     - }
     + 	struct child_process child = CHILD_PROCESS_INIT;
     +@@ builtin/gc.c: struct maintenance_task {
     + 
     + enum maintenance_task_label {
     + 	TASK_GC,
     ++	TASK_COMMIT_GRAPH,
       
     - int cmd_maintenance(int argc, const char **argv, const char *prefix)
     + 	/* Leave as final value */
     + 	TASK__COUNT
     +@@ builtin/gc.c: static struct maintenance_task tasks[] = {
     + 		maintenance_task_gc,
     + 		1,
     + 	},
     ++	[TASK_COMMIT_GRAPH] = {
     ++		"commit-graph",
     ++		maintenance_task_commit_graph,
     ++	},
     + };
     + 
     + static int maintenance_run(void)
      
       ## commit-graph.c ##
      @@ commit-graph.c: static char *get_split_graph_filename(struct object_directory *odb,
     @@ commit-graph.h: struct commit;
       /*
      
       ## t/t7900-maintenance.sh ##
     -@@ t/t7900-maintenance.sh: test_expect_success 'help text' '
     - 	test_i18ngrep "usage: git maintenance run" err
     - '
     +@@ t/t7900-maintenance.sh: test_description='git maintenance builtin'
       
     --test_expect_success 'gc [--auto|--quiet]' '
     -+test_expect_success 'run [--auto|--quiet]' '
     - 	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run --no-quiet &&
     - 	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
     - 	GIT_TRACE2_EVENT="$(pwd)/run-quiet.txt" git maintenance run --quiet &&
     + . ./test-lib.sh
     + 
     ++GIT_TEST_COMMIT_GRAPH=0
     ++
     + test_expect_success 'help text' '
     + 	test_expect_code 129 git maintenance -h 2>err &&
     + 	test_i18ngrep "usage: git maintenance run" err
  6:  a09b1c1687 !  6:  dafb0d9bbc maintenance: add --task option
     @@ Commit message
          references. We use the hashmap to match the --task=<task> arguments into
          the task struct data.
      
     +    Keep in mind that the 'enabled' member of the maintenance_task struct is
     +    a placeholder for a future 'maintenance.<task>.enabled' config option.
     +    Thus, we use the 'enabled' member to specify which tasks are run when
     +    the user does not specify any --task=<task> arguments. The 'enabled'
     +    member should be ignored if --task=<task> appears.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/git-maintenance.txt ##
     @@ builtin/gc.c: typedef int maintenance_task_fn(void);
       	const char *name;
       	maintenance_task_fn *fn;
      -	unsigned enabled:1;
     -+	int task_order;
      +	unsigned enabled:1,
      +		 selected:1;
     ++	int selected_order;
       };
       
     - static struct maintenance_task *tasks[MAX_NUM_TASKS];
     - static int num_tasks;
     + enum maintenance_task_label {
     +@@ builtin/gc.c: static struct maintenance_task tasks[] = {
     + 	},
     + };
       
      +static int compare_tasks_by_selection(const void *a_, const void *b_)
      +{
      +	const struct maintenance_task *a, *b;
     -+	a = (const struct maintenance_task *)a_;
     -+	b = (const struct maintenance_task *)b_;
      +
     -+	return b->task_order - a->task_order;
     ++	a = (const struct maintenance_task *)&a_;
     ++	b = (const struct maintenance_task *)&b_;
     ++
     ++	return b->selected_order - a->selected_order;
      +}
      +
       static int maintenance_run(void)
     @@ builtin/gc.c: typedef int maintenance_task_fn(void);
       	int result = 0;
       
      +	if (opts.tasks_selected)
     -+		QSORT(tasks, num_tasks, compare_tasks_by_selection);
     ++		QSORT(tasks, TASK__COUNT, compare_tasks_by_selection);
      +
     - 	for (i = 0; !result && i < num_tasks; i++) {
     --		if (!tasks[i]->enabled)
     -+		if (opts.tasks_selected && !tasks[i]->selected)
     + 	for (i = 0; i < TASK__COUNT; i++) {
     +-		if (!tasks[i].enabled)
     ++		if (opts.tasks_selected && !tasks[i].selected)
      +			continue;
      +
     -+		if (!opts.tasks_selected && !tasks[i]->enabled)
     ++		if (!opts.tasks_selected && !tasks[i].enabled)
       			continue;
     -+
     - 		result = tasks[i]->fn();
     - 	}
       
     -@@ builtin/gc.c: static void initialize_tasks(void)
     - 	num_tasks++;
     + 		if (tasks[i].fn()) {
     +@@ builtin/gc.c: static int maintenance_run(void)
     + 	return result;
       }
       
      +static int task_option_parse(const struct option *opt,
     @@ builtin/gc.c: static void initialize_tasks(void)
      +
      +	BUG_ON_OPT_NEG(unset);
      +
     -+	if (!arg || !strlen(arg)) {
     -+		error(_("--task requires a value"));
     -+		return 1;
     -+	}
     -+
      +	opts.tasks_selected++;
      +
     -+	for (i = 0; i < MAX_NUM_TASKS; i++) {
     -+		if (tasks[i] && !strcasecmp(tasks[i]->name, arg)) {
     -+			task = tasks[i];
     ++	for (i = 0; i < TASK__COUNT; i++) {
     ++		if (!strcasecmp(tasks[i].name, arg)) {
     ++			task = &tasks[i];
      +			break;
      +		}
      +	}
     @@ builtin/gc.c: static void initialize_tasks(void)
      +	}
      +
      +	task->selected = 1;
     -+	task->task_order = opts.tasks_selected;
     ++	task->selected_order = opts.tasks_selected;
      +
      +	return 0;
      +}
  7:  e9260a9c3f !  7:  1b00524da3 maintenance: take a lock on the objects directory
     @@ builtin/gc.c: static int maintenance_run(void)
      +	free(lock_path);
       
       	if (opts.tasks_selected)
     - 		QSORT(tasks, num_tasks, compare_tasks_by_selection);
     + 		QSORT(tasks, TASK__COUNT, compare_tasks_by_selection);
      @@ builtin/gc.c: static int maintenance_run(void)
     - 		result = tasks[i]->fn();
     + 		}
       	}
       
      +	rollback_lock_file(&lk);
  -:  ---------- >  8:  0e94e04dcd fetch: optionally allow disabling FETCH_HEAD update
  8:  3165b8916d !  9:  9e38ade15c maintenance: add prefetch task
     @@ Commit message
      
          2. --refmap= removes the configured refspec which usually updates
             refs/remotes/<remote>/* with the refs advertised by the remote.
     +       While this looks confusing, this was documented and tested by
     +       b40a50264ac (fetch: document and test --refmap="", 2020-01-21),
     +       including this sentence in the documentation:
     +
     +            Providing an empty `<refspec>` to the `--refmap` option
     +            causes Git to ignore the configured refspecs and rely
     +            entirely on the refspecs supplied as command-line arguments.
      
          3. By adding a new refspec "+refs/heads/*:refs/prefetch/<remote>/*"
             we can ensure that we actually load the new values somewhere in
     @@ Commit message
          4. --prune will delete the refs/prefetch/<remote> refs that no
             longer appear on the remote.
      
     +    5. --no-write-fetch-head prevents updating FETCH_HEAD.
     +
          We've been using this step as a critical background job in Scalar
          [1] (and VFS for Git). This solved a pain point that was showing up
          in user reports: fetching was a pain! Users do not like waiting to
     @@ Documentation/git-maintenance.txt: since it will not expire `.graph` files that
       the expiration delay.
       
      +prefetch::
     -+	The `fetch` task updates the object directory with the latest objects
     -+	from all registered remotes. For each remote, a `git fetch` command
     -+	is run. The refmap is custom to avoid updating local or remote
     ++	The `prefetch` task updates the object directory with the latest
     ++	objects from all registered remotes. For each remote, a `git fetch`
     ++	command is run. The refmap is custom to avoid updating local or remote
      +	branches (those in `refs/heads` or `refs/remotes`). Instead, the
      +	remote refs are stored in `refs/prefetch/<remote>/`. Also, tags are
      +	not updated.
      ++
     -+This means that foreground fetches are still required to update the
     -+remote refs, but the users is notified when the branches and tags are
     -+updated on the remote.
     ++This is done to avoid disrupting the remote-tracking branches. The end users
     ++expect these refs to stay unmoved unless they initiate a fetch.  With prefetch
     ++task, however, the objects necessary to complete a later real fetch would
     ++already be obtained, so the real fetch would go faster.  In the ideal case,
     ++it will just become an update to bunch of remote-tracking branches without
     ++any object transfer.
      +
       gc::
       	Cleanup unnecessary files and optimize the local repository. "GC"
     @@ builtin/gc.c
       
       #define FAILED_RUN "failed to run %s"
       
     -@@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
     - 	return 0;
     - }
     - 
     --#define MAX_NUM_TASKS 2
     -+#define MAX_NUM_TASKS 3
     - 
     - static const char * const builtin_maintenance_usage[] = {
     - 	N_("git maintenance run [<options>]"),
      @@ builtin/gc.c: static int maintenance_task_commit_graph(void)
       	return 1;
       }
       
      +static int fetch_remote(const char *remote)
      +{
     -+	int result;
     -+	struct argv_array cmd = ARGV_ARRAY_INIT;
     -+	struct strbuf refmap = STRBUF_INIT;
     ++	struct child_process child = CHILD_PROCESS_INIT;
      +
     -+	argv_array_pushl(&cmd, "fetch", remote, "--prune",
     -+			 "--no-tags", "--refmap=", NULL);
     ++	child.git_cmd = 1;
     ++	strvec_pushl(&child.args, "fetch", remote, "--prune", "--no-tags",
     ++		     "--no-write-fetch-head", "--refmap=", NULL);
      +
     -+	strbuf_addf(&refmap, "+refs/heads/*:refs/prefetch/%s/*", remote);
     -+	argv_array_push(&cmd, refmap.buf);
     ++	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote);
      +
      +	if (opts.quiet)
     -+		argv_array_push(&cmd, "--quiet");
     ++		strvec_push(&child.args, "--quiet");
      +
     -+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
     -+
     -+	strbuf_release(&refmap);
     -+	return result;
     ++	return !!run_command(&child);
      +}
      +
      +static int fill_each_remote(struct remote *remote, void *cbdata)
     @@ builtin/gc.c: static int maintenance_task_commit_graph(void)
      +		goto cleanup;
      +	}
      +
     -+	/*
     -+	 * Do not modify the result based on the success of the 'fetch'
     -+	 * operation, as a loss of network could cause 'fetch' to fail
     -+	 * quickly. We do not want that to stop the rest of our
     -+	 * background operations.
     -+	 */
      +	for (item = remotes.items;
      +	     item && item < remotes.items + remotes.nr;
      +	     item++)
     -+		fetch_remote(item->string);
     ++		result |= fetch_remote(item->string);
      +
      +cleanup:
      +	string_list_clear(&remotes, 0);
     @@ builtin/gc.c: static int maintenance_task_commit_graph(void)
      +
       static int maintenance_task_gc(void)
       {
     - 	int result;
     -@@ builtin/gc.c: static void initialize_tasks(void)
     - 	for (i = 0; i < MAX_NUM_TASKS; i++)
     - 		tasks[i] = xcalloc(1, sizeof(struct maintenance_task));
     + 	struct child_process child = CHILD_PROCESS_INIT;
     +@@ builtin/gc.c: struct maintenance_task {
     + };
       
     -+	tasks[num_tasks]->name = "prefetch";
     -+	tasks[num_tasks]->fn = maintenance_task_prefetch;
     -+	num_tasks++;
     -+
     - 	tasks[num_tasks]->name = "gc";
     - 	tasks[num_tasks]->fn = maintenance_task_gc;
     - 	tasks[num_tasks]->enabled = 1;
     + enum maintenance_task_label {
     ++	TASK_PREFETCH,
     + 	TASK_GC,
     + 	TASK_COMMIT_GRAPH,
     + 
     +@@ builtin/gc.c: enum maintenance_task_label {
     + };
     + 
     + static struct maintenance_task tasks[] = {
     ++	[TASK_PREFETCH] = {
     ++		"prefetch",
     ++		maintenance_task_prefetch,
     ++	},
     + 	[TASK_GC] = {
     + 		"gc",
     + 		maintenance_task_gc,
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'run --task duplicate' '
  9:  83648f4865 ! 10:  0128fdfd1a maintenance: add loose-objects task
     @@ Documentation/git-maintenance.txt: gc::
       --auto::
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
     - 	return 0;
     - }
     - 
     --#define MAX_NUM_TASKS 3
     -+#define MAX_NUM_TASKS 4
     - 
     - static const char * const builtin_maintenance_usage[] = {
     - 	N_("git maintenance run [<options>]"),
      @@ builtin/gc.c: static int maintenance_task_gc(void)
     - 	return result;
     + 	return run_command(&child);
       }
       
      +static int prune_packed(void)
      +{
     -+	struct argv_array cmd = ARGV_ARRAY_INIT;
     -+	argv_array_pushl(&cmd, "prune-packed", NULL);
     ++	struct child_process child = CHILD_PROCESS_INIT;
     ++
     ++	child.git_cmd = 1;
     ++	strvec_push(&child.args, "prune-packed");
      +
      +	if (opts.quiet)
     -+		argv_array_push(&cmd, "--quiet");
     ++		strvec_push(&child.args, "--quiet");
      +
     -+	return run_command_v_opt(cmd.argv, RUN_GIT_CMD);
     ++	return !!run_command(&child);
      +}
      +
      +struct write_loose_object_data {
     @@ builtin/gc.c: static int maintenance_task_gc(void)
      +	int batch_size;
      +};
      +
     -+static int loose_object_exists(const struct object_id *oid,
     -+			       const char *path,
     -+			       void *data)
     ++static int bail_on_loose(const struct object_id *oid,
     ++			 const char *path,
     ++			 void *data)
      +{
      +	return 1;
      +}
     @@ builtin/gc.c: static int maintenance_task_gc(void)
      +	struct repository *r = the_repository;
      +	int result = 0;
      +	struct write_loose_object_data data;
     -+	struct strbuf prefix = STRBUF_INIT;
     -+	struct child_process *pack_proc;
     ++	struct child_process pack_proc = CHILD_PROCESS_INIT;
      +
      +	/*
      +	 * Do not start pack-objects process
      +	 * if there are no loose objects.
      +	 */
      +	if (!for_each_loose_file_in_objdir(r->objects->odb->path,
     -+					   loose_object_exists,
     ++					   bail_on_loose,
      +					   NULL, NULL, NULL))
      +		return 0;
      +
     -+	pack_proc = xmalloc(sizeof(*pack_proc));
     -+
     -+	child_process_init(pack_proc);
     ++	pack_proc.git_cmd = 1;
      +
     -+	strbuf_addstr(&prefix, r->objects->odb->path);
     -+	strbuf_addstr(&prefix, "/pack/loose");
     -+
     -+	argv_array_pushl(&pack_proc->args, "git", "pack-objects", NULL);
     ++	strvec_push(&pack_proc.args, "pack-objects");
      +	if (opts.quiet)
     -+		argv_array_push(&pack_proc->args, "--quiet");
     -+	argv_array_push(&pack_proc->args, prefix.buf);
     ++		strvec_push(&pack_proc.args, "--quiet");
     ++	strvec_pushf(&pack_proc.args, "%s/pack/loose", r->objects->odb->path);
      +
     -+	pack_proc->in = -1;
     ++	pack_proc.in = -1;
      +
     -+	if (start_command(pack_proc)) {
     ++	if (start_command(&pack_proc)) {
      +		error(_("failed to start 'git pack-objects' process"));
     -+		result = 1;
     -+		goto cleanup;
     ++		return 1;
      +	}
      +
     -+	data.in = xfdopen(pack_proc->in, "w");
     ++	data.in = xfdopen(pack_proc.in, "w");
      +	data.count = 0;
      +	data.batch_size = 50000;
      +
     @@ builtin/gc.c: static int maintenance_task_gc(void)
      +
      +	fclose(data.in);
      +
     -+	if (finish_command(pack_proc)) {
     ++	if (finish_command(&pack_proc)) {
      +		error(_("failed to finish 'git pack-objects' process"));
      +		result = 1;
      +	}
      +
     -+cleanup:
     -+	strbuf_release(&prefix);
     -+	free(pack_proc);
      +	return result;
      +}
      +
     @@ builtin/gc.c: static int maintenance_task_gc(void)
       typedef int maintenance_task_fn(void);
       
       struct maintenance_task {
     -@@ builtin/gc.c: static void initialize_tasks(void)
     - 	tasks[num_tasks]->fn = maintenance_task_prefetch;
     - 	num_tasks++;
     +@@ builtin/gc.c: struct maintenance_task {
       
     -+	tasks[num_tasks]->name = "loose-objects";
     -+	tasks[num_tasks]->fn = maintenance_task_loose_objects;
     -+	num_tasks++;
     -+
     - 	tasks[num_tasks]->name = "gc";
     - 	tasks[num_tasks]->fn = maintenance_task_gc;
     - 	tasks[num_tasks]->enabled = 1;
     + enum maintenance_task_label {
     + 	TASK_PREFETCH,
     ++	TASK_LOOSE_OBJECTS,
     + 	TASK_GC,
     + 	TASK_COMMIT_GRAPH,
     + 
     +@@ builtin/gc.c: static struct maintenance_task tasks[] = {
     + 		"prefetch",
     + 		maintenance_task_prefetch,
     + 	},
     ++	[TASK_LOOSE_OBJECTS] = {
     ++		"loose-objects",
     ++		maintenance_task_loose_objects,
     ++	},
     + 	[TASK_GC] = {
     + 		"gc",
     + 		maintenance_task_gc,
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
     @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
      +
      +	# Hack to stop maintenance from running during "git commit"
      +	echo in use >.git/objects/maintenance.lock &&
     ++
     ++	# Assuming that "git commit" creates at least one loose object
      +	test_commit create-loose-object &&
      +	rm .git/objects/maintenance.lock &&
      +
     @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
      +	test_cmp obj-dir-before obj-dir-between &&
      +	ls .git/objects/pack/*.pack >packs-between &&
      +	test_line_count = 2 packs-between &&
     ++	ls .git/objects/pack/loose-*.pack >loose-packs &&
     ++	test_line_count = 1 loose-packs &&
      +
      +	# The second run deletes loose objects
      +	# but does not create a pack-file.
  -:  ---------- > 11:  c2baf6e119 midx: enable core.multiPackIndex by default
 10:  b6328c2106 ! 12:  00f47c4848 maintenance: add incremental-repack task
     @@ Commit message
             size" is calculated by taking the size of the pack-file divided
             by the number of objects in the pack-file and multiplied by the
             number of objects from the multi-pack-index with offset in that
     -       pack-file. The expected size approximats how much data from that
     +       pack-file. The expected size approximates how much data from that
             pack-file will contribute to the resulting pack-file size. The
             intention is that the resulting pack-file will be close in size
             to the provided batch size.
     @@ builtin/gc.c
       
       #define FAILED_RUN "failed to run %s"
       
     -@@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
     - 	return 0;
     - }
     - 
     --#define MAX_NUM_TASKS 4
     -+#define MAX_NUM_TASKS 5
     - 
     - static const char * const builtin_maintenance_usage[] = {
     - 	N_("git maintenance run [<options>]"),
      @@ builtin/gc.c: static int maintenance_task_loose_objects(void)
       	return prune_packed() || pack_loose();
       }
       
      +static int multi_pack_index_write(void)
      +{
     -+	int result;
     -+	struct argv_array cmd = ARGV_ARRAY_INIT;
     -+	argv_array_pushl(&cmd, "multi-pack-index", "write", NULL);
     ++	struct child_process child = CHILD_PROCESS_INIT;
     ++
     ++	child.git_cmd = 1;
     ++	strvec_pushl(&child.args, "multi-pack-index", "write", NULL);
      +
      +	if (opts.quiet)
     -+		argv_array_push(&cmd, "--no-progress");
     ++		strvec_push(&child.args, "--no-progress");
      +
     -+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
     -+	argv_array_clear(&cmd);
     ++	if (run_command(&child))
     ++		return error(_("failed to write multi-pack-index"));
      +
     -+	return result;
     ++	return 0;
      +}
      +
      +static int rewrite_multi_pack_index(void)
     @@ builtin/gc.c: static int maintenance_task_loose_objects(void)
      +	unlink(midx_name);
      +	free(midx_name);
      +
     -+	if (multi_pack_index_write()) {
     -+		error(_("failed to rewrite multi-pack-index"));
     -+		return 1;
     -+	}
     -+
     -+	return 0;
     ++	return multi_pack_index_write();
      +}
      +
     -+static int multi_pack_index_verify(void)
     ++static int multi_pack_index_verify(const char *message)
      +{
     -+	int result;
     -+	struct argv_array cmd = ARGV_ARRAY_INIT;
     -+	argv_array_pushl(&cmd, "multi-pack-index", "verify", NULL);
     ++	struct child_process child = CHILD_PROCESS_INIT;
     ++
     ++	child.git_cmd = 1;
     ++	strvec_pushl(&child.args, "multi-pack-index", "verify", NULL);
      +
      +	if (opts.quiet)
     -+		argv_array_push(&cmd, "--no-progress");
     ++		strvec_push(&child.args, "--no-progress");
      +
     -+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
     -+	argv_array_clear(&cmd);
     ++	if (run_command(&child)) {
     ++		warning(_("'git multi-pack-index verify' failed %s"), message);
     ++		return 1;
     ++	}
      +
     -+	return result;
     ++	return 0;
      +}
      +
      +static int multi_pack_index_expire(void)
      +{
     -+	int result;
     -+	struct argv_array cmd = ARGV_ARRAY_INIT;
     -+	argv_array_pushl(&cmd, "multi-pack-index", "expire", NULL);
     ++	struct child_process child = CHILD_PROCESS_INIT;
     ++
     ++	child.git_cmd = 1;
     ++	strvec_pushl(&child.args, "multi-pack-index", "expire", NULL);
      +
      +	if (opts.quiet)
     -+		argv_array_push(&cmd, "--no-progress");
     ++		strvec_push(&child.args, "--no-progress");
      +
      +	close_object_store(the_repository->objects);
     -+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
     -+	argv_array_clear(&cmd);
      +
     -+	return result;
     ++	if (run_command(&child))
     ++		return error(_("'git multi-pack-index expire' failed"));
     ++
     ++	return 0;
      +}
      +
      +static int multi_pack_index_repack(void)
      +{
     -+	int result;
     -+	struct argv_array cmd = ARGV_ARRAY_INIT;
     -+	argv_array_pushl(&cmd, "multi-pack-index", "repack", NULL);
     ++	struct child_process child = CHILD_PROCESS_INIT;
     ++
     ++	child.git_cmd = 1;
     ++	strvec_pushl(&child.args, "multi-pack-index", "repack", NULL);
      +
      +	if (opts.quiet)
     -+		argv_array_push(&cmd, "--no-progress");
     ++		strvec_push(&child.args, "--no-progress");
      +
     -+	argv_array_push(&cmd, "--batch-size=0");
     ++	strvec_push(&child.args, "--batch-size=0");
      +
      +	close_object_store(the_repository->objects);
     -+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
      +
     -+	if (result && multi_pack_index_verify()) {
     -+		warning(_("multi-pack-index verify failed after repack"));
     -+		result = rewrite_multi_pack_index();
     -+	}
     ++	if (run_command(&child))
     ++		return error(_("'git multi-pack-index repack' failed"));
      +
     -+	return result;
     ++	return 0;
      +}
      +
      +static int maintenance_task_incremental_repack(void)
      +{
     -+	if (multi_pack_index_write()) {
     -+		error(_("failed to write multi-pack-index"));
     -+		return 1;
     ++	prepare_repo_settings(the_repository);
     ++	if (!the_repository->settings.core_multi_pack_index) {
     ++		warning(_("skipping incremental-repack task because core.multiPackIndex is disabled"));
     ++		return 0;
      +	}
      +
     -+	if (multi_pack_index_verify()) {
     -+		warning(_("multi-pack-index verify failed after initial write"));
     -+		return rewrite_multi_pack_index();
     -+	}
     -+
     -+	if (multi_pack_index_expire()) {
     -+		error(_("multi-pack-index expire failed"));
     ++	if (multi_pack_index_write())
      +		return 1;
     -+	}
     -+
     -+	if (multi_pack_index_verify()) {
     -+		warning(_("multi-pack-index verify failed after expire"));
     ++	if (multi_pack_index_verify("after initial write"))
      +		return rewrite_multi_pack_index();
     -+	}
     -+
     -+	if (multi_pack_index_repack()) {
     -+		error(_("multi-pack-index repack failed"));
     ++	if (multi_pack_index_expire())
      +		return 1;
     -+	}
     -+
     ++	if (multi_pack_index_verify("after expire step"))
     ++		return !!rewrite_multi_pack_index();
     ++	if (multi_pack_index_repack())
     ++		return 1;
     ++	if (multi_pack_index_verify("after repack step"))
     ++		return !!rewrite_multi_pack_index();
      +	return 0;
      +}
      +
       typedef int maintenance_task_fn(void);
       
       struct maintenance_task {
     -@@ builtin/gc.c: static void initialize_tasks(void)
     - 	tasks[num_tasks]->fn = maintenance_task_loose_objects;
     - 	num_tasks++;
     +@@ builtin/gc.c: struct maintenance_task {
     + enum maintenance_task_label {
     + 	TASK_PREFETCH,
     + 	TASK_LOOSE_OBJECTS,
     ++	TASK_INCREMENTAL_REPACK,
     + 	TASK_GC,
     + 	TASK_COMMIT_GRAPH,
       
     -+	tasks[num_tasks]->name = "incremental-repack";
     -+	tasks[num_tasks]->fn = maintenance_task_incremental_repack;
     -+	num_tasks++;
     -+
     - 	tasks[num_tasks]->name = "gc";
     - 	tasks[num_tasks]->fn = maintenance_task_gc;
     - 	tasks[num_tasks]->enabled = 1;
     +@@ builtin/gc.c: static struct maintenance_task tasks[] = {
     + 		"loose-objects",
     + 		maintenance_task_loose_objects,
     + 	},
     ++	[TASK_INCREMENTAL_REPACK] = {
     ++		"incremental-repack",
     ++		maintenance_task_incremental_repack,
     ++	},
     + 	[TASK_GC] = {
     + 		"gc",
     + 		maintenance_task_gc,
      
       ## midx.c ##
      @@
     @@ midx.h: struct multi_pack_index {
       int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
       int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
      
     + ## t/t5319-multi-pack-index.sh ##
     +@@
     + test_description='multi-pack-indexes'
     + . ./test-lib.sh
     + 
     ++GIT_TEST_MULTI_PACK_INDEX=0
     + objdir=.git/objects
     + 
     + midx_read_expect () {
     +
       ## t/t7900-maintenance.sh ##
     +@@ t/t7900-maintenance.sh: test_description='git maintenance builtin'
     + . ./test-lib.sh
     + 
     + GIT_TEST_COMMIT_GRAPH=0
     ++GIT_TEST_MULTI_PACK_INDEX=0
     + 
     + test_expect_success 'help text' '
     + 	test_expect_code 129 git maintenance -h 2>err &&
      @@ t/t7900-maintenance.sh: test_expect_success 'loose-objects task' '
       	test_cmp packs-between packs-after
       '
 11:  478c7f1d0b ! 13:  ef2a231956 maintenance: auto-size incremental-repack batch
     @@ Commit message
          When repacking during the 'incremental-repack' task, we use the
          --batch-size option in 'git multi-pack-index repack'. The initial setting
          used --batch-size=0 to repack everything into a single pack-file. This is
     -    not sustaintable for a large repository. The amount of work required is
     +    not sustainable for a large repository. The amount of work required is
          also likely to use too many system resources for a background job.
      
          Update the 'incremental-repack' task by dynamically computing a
     @@ Commit message
      
       ## builtin/gc.c ##
      @@ builtin/gc.c: static int multi_pack_index_expire(void)
     - 	return result;
     + 	return 0;
       }
       
     -+#define TWO_GIGABYTES (2147483647)
     -+#define UNSET_BATCH_SIZE ((unsigned long)-1)
     ++#define TWO_GIGABYTES (0x7FFF)
      +
      +static off_t get_auto_pack_size(void)
      +{
     @@ builtin/gc.c: static int multi_pack_index_expire(void)
      +
       static int multi_pack_index_repack(void)
       {
     - 	int result;
     - 	struct argv_array cmd = ARGV_ARRAY_INIT;
     -+	struct strbuf batch_arg = STRBUF_INIT;
     -+
     - 	argv_array_pushl(&cmd, "multi-pack-index", "repack", NULL);
     - 
     + 	struct child_process child = CHILD_PROCESS_INIT;
     +@@ builtin/gc.c: static int multi_pack_index_repack(void)
       	if (opts.quiet)
     - 		argv_array_push(&cmd, "--no-progress");
     + 		strvec_push(&child.args, "--no-progress");
       
     --	argv_array_push(&cmd, "--batch-size=0");
     -+	strbuf_addf(&batch_arg, "--batch-size=%"PRIuMAX,
     -+		    (uintmax_t)get_auto_pack_size());
     -+	argv_array_push(&cmd, batch_arg.buf);
     +-	strvec_push(&child.args, "--batch-size=0");
     ++	strvec_pushf(&child.args, "--batch-size=%"PRIuMAX,
     ++				  (uintmax_t)get_auto_pack_size());
       
       	close_object_store(the_repository->objects);
     - 	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
     -+	strbuf_release(&batch_arg);
       
     - 	if (result && multi_pack_index_verify()) {
     - 		warning(_("multi-pack-index verify failed after repack"));
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'incremental-repack task' '
 12:  a3c64930a0 ! 14:  99840c4b8f maintenance: create maintenance.<task>.enabled config
     @@ Documentation/git-maintenance.txt: SUBCOMMANDS
      
       ## builtin/gc.c ##
      @@ builtin/gc.c: static int maintenance_run(void)
     - static void initialize_tasks(void)
     - {
     - 	int i;
     -+	struct strbuf config_name = STRBUF_INIT;
     - 	num_tasks = 0;
     + 	return result;
     + }
       
     - 	for (i = 0; i < MAX_NUM_TASKS; i++)
     -@@ builtin/gc.c: static void initialize_tasks(void)
     - 	tasks[num_tasks]->name = "commit-graph";
     - 	tasks[num_tasks]->fn = maintenance_task_commit_graph;
     - 	num_tasks++;
     -+
     -+	for (i = 0; i < num_tasks; i++) {
     ++static void initialize_task_config(void)
     ++{
     ++	int i;
     ++	struct strbuf config_name = STRBUF_INIT;
     ++	for (i = 0; i < TASK__COUNT; i++) {
      +		int config_value;
      +
      +		strbuf_setlen(&config_name, 0);
     -+		strbuf_addf(&config_name, "maintenance.%s.enabled", tasks[i]->name);
     ++		strbuf_addf(&config_name, "maintenance.%s.enabled",
     ++			    tasks[i].name);
      +
      +		if (!git_config_get_bool(config_name.buf, &config_value))
     -+			tasks[i]->enabled = config_value;
     ++			tasks[i].enabled = config_value;
      +	}
      +
      +	strbuf_release(&config_name);
     - }
     - 
     ++}
     ++
       static int task_option_parse(const struct option *opt,
     + 			     const char *arg, int unset)
     + {
     +@@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
     + 				   builtin_maintenance_options);
     + 
     + 	opts.quiet = !isatty(2);
     ++	initialize_task_config();
     + 
     + 	argc = parse_options(argc, argv, prefix,
     + 			     builtin_maintenance_options,
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'run [--auto|--quiet]' '
 13:  dbacc2b76c ! 15:  a087c63572 maintenance: use pointers to check --auto
     @@ builtin/gc.c: static int maintenance_task_incremental_repack(void)
       	const char *name;
       	maintenance_task_fn *fn;
      +	maintenance_auto_fn *auto_condition;
     - 	int task_order;
       	unsigned enabled:1,
       		 selected:1;
     + 	int selected_order;
     +@@ builtin/gc.c: static struct maintenance_task tasks[] = {
     + 	[TASK_GC] = {
     + 		"gc",
     + 		maintenance_task_gc,
     ++		need_to_gc,
     + 		1,
     + 	},
     + 	[TASK_COMMIT_GRAPH] = {
      @@ builtin/gc.c: static int maintenance_run(void)
     - 		if (!opts.tasks_selected && !tasks[i]->enabled)
     + 		if (!opts.tasks_selected && !tasks[i].enabled)
       			continue;
       
      +		if (opts.auto_flag &&
     -+		    (!tasks[i]->auto_condition ||
     -+		     !tasks[i]->auto_condition()))
     ++		    (!tasks[i].auto_condition ||
     ++		     !tasks[i].auto_condition()))
      +			continue;
      +
     - 		result = tasks[i]->fn();
     - 	}
     - 
     -@@ builtin/gc.c: static void initialize_tasks(void)
     - 
     - 	tasks[num_tasks]->name = "gc";
     - 	tasks[num_tasks]->fn = maintenance_task_gc;
     -+	tasks[num_tasks]->auto_condition = need_to_gc;
     - 	tasks[num_tasks]->enabled = 1;
     - 	num_tasks++;
     - 
     -@@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
     - 				   builtin_maintenance_options);
     - 
     - 	opts.quiet = !isatty(2);
     + 		if (tasks[i].fn()) {
     + 			error(_("task '%s' failed"), tasks[i].name);
     + 			result = 1;
     +@@ builtin/gc.c: static void initialize_task_config(void)
     + {
     + 	int i;
     + 	struct strbuf config_name = STRBUF_INIT;
      +	gc_config();
     - 	initialize_tasks();
     ++
     + 	for (i = 0; i < TASK__COUNT; i++) {
     + 		int config_value;
       
     - 	argc = parse_options(argc, argv, prefix,
      
       ## t/t5514-fetch-multiple.sh ##
      @@ t/t5514-fetch-multiple.sh: test_expect_success 'git fetch --multiple (two remotes)' '
 14:  9af2309f08 ! 16:  ef3a854508 maintenance: add auto condition for commit-graph task
     @@ builtin/gc.c: static struct maintenance_opts {
      +
       static int run_write_commit_graph(void)
       {
     - 	int result;
     -@@ builtin/gc.c: static void initialize_tasks(void)
     + 	struct child_process child = CHILD_PROCESS_INIT;
     +@@ builtin/gc.c: static struct maintenance_task tasks[] = {
     + 	[TASK_COMMIT_GRAPH] = {
     + 		"commit-graph",
     + 		maintenance_task_commit_graph,
     ++		should_write_commit_graph,
     + 	},
     + };
       
     - 	tasks[num_tasks]->name = "commit-graph";
     - 	tasks[num_tasks]->fn = maintenance_task_commit_graph;
     -+	tasks[num_tasks]->auto_condition = should_write_commit_graph;
     - 	num_tasks++;
     - 
     - 	for (i = 0; i < num_tasks; i++) {
      
       ## object.h ##
      @@ object.h: struct object_array {
 15:  42e316ca58 ! 17:  6ac3a58f2f maintenance: create auto condition for loose-objects
     @@ builtin/gc.c: struct write_loose_object_data {
      +					     NULL, NULL, &count);
      +}
      +
     - static int loose_object_exists(const struct object_id *oid,
     - 			       const char *path,
     - 			       void *data)
     -@@ builtin/gc.c: static void initialize_tasks(void)
     - 
     - 	tasks[num_tasks]->name = "loose-objects";
     - 	tasks[num_tasks]->fn = maintenance_task_loose_objects;
     -+	tasks[num_tasks]->auto_condition = loose_object_auto_condition;
     - 	num_tasks++;
     - 
     - 	tasks[num_tasks]->name = "incremental-repack";
     + static int bail_on_loose(const struct object_id *oid,
     + 			 const char *path,
     + 			 void *data)
     +@@ builtin/gc.c: static struct maintenance_task tasks[] = {
     + 	[TASK_LOOSE_OBJECTS] = {
     + 		"loose-objects",
     + 		maintenance_task_loose_objects,
     ++		loose_object_auto_condition,
     + 	},
     + 	[TASK_INCREMENTAL_REPACK] = {
     + 		"incremental-repack",
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'loose-objects task' '
 16:  3d527cb0dd ! 18:  801b262d1c maintenance: add incremental-repack auto condition
     @@ builtin/gc.c: static int maintenance_task_loose_objects(void)
      +
       static int multi_pack_index_write(void)
       {
     - 	int result;
     -@@ builtin/gc.c: static void initialize_tasks(void)
     - 
     - 	tasks[num_tasks]->name = "incremental-repack";
     - 	tasks[num_tasks]->fn = maintenance_task_incremental_repack;
     -+	tasks[num_tasks]->auto_condition = incremental_repack_auto_condition;
     - 	num_tasks++;
     - 
     - 	tasks[num_tasks]->name = "gc";
     + 	struct child_process child = CHILD_PROCESS_INIT;
     +@@ builtin/gc.c: static struct maintenance_task tasks[] = {
     + 	[TASK_INCREMENTAL_REPACK] = {
     + 		"incremental-repack",
     + 		maintenance_task_incremental_repack,
     ++		incremental_repack_auto_condition,
     + 	},
     + 	[TASK_GC] = {
     + 		"gc",
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'incremental-repack task' '
 17:  a0f00f8ab8 = 19:  9b4cef7635 midx: use start_delayed_progress()
 18:  f24db7739f ! 20:  39eb83ad1e maintenance: add trace2 regions for task execution
     @@ Commit message
      
       ## builtin/gc.c ##
      @@ builtin/gc.c: static int maintenance_run(void)
     - 		     !tasks[i]->auto_condition()))
     + 		     !tasks[i].auto_condition()))
       			continue;
       
     -+		trace2_region_enter("maintenance", tasks[i]->name, r);
     - 		result = tasks[i]->fn();
     -+		trace2_region_leave("maintenance", tasks[i]->name, r);
     ++		trace2_region_enter("maintenance", tasks[i].name, r);
     + 		if (tasks[i].fn()) {
     + 			error(_("task '%s' failed"), tasks[i].name);
     + 			result = 1;
     + 		}
     ++		trace2_region_leave("maintenance", tasks[i].name, r);
       	}
       
       	rollback_lock_file(&lk);

-- 
gitgitgadget
