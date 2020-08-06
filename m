Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBA8C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9D12086A
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtAX+BNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgHFQz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbgHFQzS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:55:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07C1C0F26C8
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 08:48:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x5so9284179wmi.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 08:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=mTgmrC93yXUUa6PyMqa5OCmav8EdQO2ykvWBSBVgUFM=;
        b=MtAX+BNMzVW0HdFU92S39b7117y8Jngb8fdejxw2YsdYeCt5m8+rOEWJaEzuV4mvNS
         jdRuR4mLkRC1ji+3xrDm3Iv7Kz/A2l4oqbS3w7WQoWH5iEQ3aeBLJMjDGoBG/EjPY3FE
         JIOUGaOUQU8JK8hGCfepMcjo103xulKSm3Z3XQxK37+rDsrz5thFY4KZS/AKgqXe7QyF
         jpF8qmVScUKXi+aVLz7tOway2LN0KyNcF5g4W6jpfR7xKfRHXd2ikA9XW0FcHUqKtGtl
         DMkk8ClzySdqNEnuhoJRO/X2QC8JO5NNvyRpp92K9S3HV7l48l2Rn/9zsEZChjTHz4nw
         SDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mTgmrC93yXUUa6PyMqa5OCmav8EdQO2ykvWBSBVgUFM=;
        b=LjJVoZIawUSwZsOJkJOOZ+ZYUdf/MOAL3luDZLhDR5nokiccwDFAHmmzba3tSOyG/c
         bs2IGUJyN6dPSfp/IBK08HTWMFQTnhnEfpR8gaq8w0wBWAadrnEEUBPFiuYl6tsKdk0D
         rZn7ZcIQ7NenCDnBkj0soI4pT+HtssVROGblvUuFvgzff9XcBVInTEmFDCLhS8K7cL8B
         7Amto9Lnriti2XEwn+6yHpmF8WyzXH5gVqOBepqkFWi4qcFKXxOkaa3+yidJV461pMbM
         xjeSQRpr45cmkcfTBr+W44U4cSEhdPNnKhcGaCkKwGuSEmpOFMnMi2+IjlfMJk/jjTiQ
         PoAA==
X-Gm-Message-State: AOAM5300+lZTDN8t+j6I6A/TODpLI+Bj7YqHL1fe+ILWjxdOZPh1Elo9
        T6snsu1+So++qCn7C2Gk9lTXHmhc
X-Google-Smtp-Source: ABdhPJwEhC7DwVOfmgb9qBjCT8maG4bqFms+KoCd0h9unSK+exgnqDrt2+wm7HVebl+VRurMhS4fLA==
X-Received: by 2002:a7b:c38e:: with SMTP id s14mr8515216wmj.124.1596728923411;
        Thu, 06 Aug 2020 08:48:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p22sm6369623wmc.38.2020.08.06.08.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:48:42 -0700 (PDT)
Message-Id: <pull.695.git.1596728921.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 15:48:30 +0000
Subject: [PATCH 00/11] Maintenance I: Command, gc and commit-graph tasks
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

Here is the range-diff from the v3 of [1].

 1:  12fe73bb72 !  1:  2b9deb6d6a maintenance: create basic maintenance runner
    @@ Commit message
         'gc' builtin entirely at some point, leaving 'git gc' as an alias for
         some specific arguments to 'git maintenance run'.

    +    Create a new test_subcommand helper that allows us to test if a certain
    +    subcommand was run. It requires storing the GIT_TRACE2_EVENT logs in a
    +    file. A negation mode is available that will be used in later tests.
    +
    +    Helped-by: Jonathan Nieder <jrnieder@gmail.com>
         Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## .gitignore ##
    @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
     +    NULL
     +};
     +
    -+static struct maintenance_opts {
    ++struct maintenance_opts {
     +    int auto_flag;
    -+} opts;
    ++};
     +
    -+static int maintenance_task_gc(void)
    ++static int maintenance_task_gc(struct maintenance_opts *opts)
     +{
     +    struct child_process child = CHILD_PROCESS_INIT;
     +
     +    child.git_cmd = 1;
     +    strvec_push(&child.args, "gc");
     +
    -+    if (opts.auto_flag)
    ++    if (opts->auto_flag)
     +        strvec_push(&child.args, "--auto");
     +
     +    close_object_store(the_repository->objects);
     +    return run_command(&child);
     +}
     +
    -+static int maintenance_run(void)
    ++static int maintenance_run(struct maintenance_opts *opts)
     +{
    -+    return maintenance_task_gc();
    ++    return maintenance_task_gc(opts);
     +}
     +
     +int cmd_maintenance(int argc, const char **argv, const char *prefix)
     +{
    ++    static struct maintenance_opts opts;
     +    static struct option builtin_maintenance_options[] = {
     +        OPT_BOOL(0, "auto", &opts.auto_flag,
     +             N_("run tasks based on the state of the repository")),
    @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
     +
     +    if (argc == 1) {
     +        if (!strcmp(argv[0], "run"))
    -+            return maintenance_run();
    ++            return maintenance_run(&opts);
     +    }
     +
     +    usage_with_options(builtin_maintenance_usage,
    @@ t/t7900-maintenance.sh (new)
     +test_expect_success 'run [--auto]' '
     +    GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run &&
     +    GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
    -+    grep ",\"gc\"]" run-no-auto.txt  &&
    -+    grep ",\"gc\",\"--auto\"]" run-auto.txt
    ++    test_subcommand git gc <run-no-auto.txt &&
    ++    test_subcommand git gc --auto <run-auto.txt
     +'
     +
     +test_done
    +
    + ## t/test-lib-functions.sh ##
    +@@ t/test-lib-functions.sh: test_path_is_hidden () {
    +     case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
    +     return 1
    + }
    ++
    ++# Check that the given command was invoked as part of the
    ++# trace2-format trace on stdin.
    ++#
    ++#    test_subcommand [!] <command> <args>... < <trace>
    ++#
    ++# For example, to look for an invocation of "git upload-pack
    ++# /path/to/repo"
    ++#
    ++#    GIT_TRACE2_EVENT=event.log git fetch ... &&
    ++#    test_subcommand git upload-pack "$PATH" <event.log
    ++#
    ++# If the first parameter passed is !, this instead checks that
    ++# the given command was not called.
    ++#
    ++test_subcommand () {
    ++    local negate=
    ++    if test "$1" = "!"
    ++    then
    ++        negate=t
    ++        shift
    ++    fi
    ++
    ++    local expr=$(printf '"%s",' "$@")
    ++    expr="${expr%,}"
    ++
    ++    if test -n "$negate"
    ++    then
    ++        ! grep "\[$expr\]"
    ++    else
    ++        grep "\[$expr\]"
    ++    fi
    ++}
 2:  6e533e43d7 !  2:  d5faef26af maintenance: add --quiet option
    @@ Documentation/git-maintenance.txt: OPTIONS
      ## builtin/gc.c ##
     @@ builtin/gc.c: static const char * const builtin_maintenance_usage[] = {

    - static struct maintenance_opts {
    + struct maintenance_opts {
          int auto_flag;
     +    int quiet;
    - } opts;
    + };

    - static int maintenance_task_gc(void)
    -@@ builtin/gc.c: static int maintenance_task_gc(void)
    + static int maintenance_task_gc(struct maintenance_opts *opts)
    +@@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_opts *opts)

    -     if (opts.auto_flag)
    +     if (opts->auto_flag)
              strvec_push(&child.args, "--auto");
    -+    if (opts.quiet)
    ++    if (opts->quiet)
     +        strvec_push(&child.args, "--quiet");
    ++    else
    ++        strvec_push(&child.args, "--no-quiet");

          close_object_store(the_repository->objects);
          return run_command(&child);
    @@ t/t7900-maintenance.sh: test_expect_success 'help text' '

     -test_expect_success 'run [--auto]' '
     -    GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run &&
    +-    GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
    +-    test_subcommand git gc <run-no-auto.txt &&
    +-    test_subcommand git gc --auto <run-auto.txt
     +test_expect_success 'run [--auto|--quiet]' '
    -+    GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run --no-quiet &&
    -     GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
    -+    GIT_TRACE2_EVENT="$(pwd)/run-quiet.txt" git maintenance run --quiet &&
    -     grep ",\"gc\"]" run-no-auto.txt  &&
    --    grep ",\"gc\",\"--auto\"]" run-auto.txt
    -+    grep ",\"gc\",\"--auto\"" run-auto.txt &&
    -+    grep ",\"gc\",\"--quiet\"" run-quiet.txt
    ++    GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" \
    ++        git maintenance run 2>/dev/null &&
    ++    GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" \
    ++        git maintenance run --auto 2>/dev/null &&
    ++    GIT_TRACE2_EVENT="$(pwd)/run-no-quiet.txt" \
    ++        git maintenance run --no-quiet 2>/dev/null &&
    ++    test_subcommand git gc --quiet <run-no-auto.txt &&
    ++    test_subcommand git gc --auto --quiet <run-auto.txt &&
    ++    test_subcommand git gc --no-quiet <run-no-quiet.txt
      '

      test_done
 3:  c4674fc211 !  3:  233811310b maintenance: replace run_auto_gc()
    @@ run-command.c: int run_processes_parallel_tr2(int n, get_next_task_fn get_next_t
     -    strvec_pushl(&argv_gc_auto, "gc", "--auto", NULL);
     -    if (quiet)
     -        strvec_push(&argv_gc_auto, "--quiet");
    --    status = run_command_v_opt(argv_gc_auto.items, RUN_GIT_CMD);
    +-    status = run_command_v_opt(argv_gc_auto.v, RUN_GIT_CMD);
     -    strvec_clear(&argv_gc_auto);
     -    return status;
     +    maint.git_cmd = 1;
 4:  b9332c1318 !  4:  7efa23abc8 maintenance: initialize task array
    @@ Commit message
         Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## builtin/gc.c ##
    -@@ builtin/gc.c: static int maintenance_task_gc(void)
    +@@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_opts *opts)
          return run_command(&child);
      }

    -+typedef int maintenance_task_fn(void);
    ++typedef int maintenance_task_fn(struct maintenance_opts *opts);
     +
     +struct maintenance_task {
     +    const char *name;
    @@ builtin/gc.c: static int maintenance_task_gc(void)
     +    },
     +};
     +
    - static int maintenance_run(void)
    + static int maintenance_run(struct maintenance_opts *opts)
      {
    --    return maintenance_task_gc();
    +-    return maintenance_task_gc(opts);
     +    int i;
     +    int result = 0;
     +
    @@ builtin/gc.c: static int maintenance_task_gc(void)
     +        if (!tasks[i].enabled)
     +            continue;
     +
    -+        if (tasks[i].fn()) {
    ++        if (tasks[i].fn(opts)) {
     +            error(_("task '%s' failed"), tasks[i].name);
     +            result = 1;
     +        }
 5:  a4d9836bed !  5:  902b742032 maintenance: add commit-graph task
    @@ Documentation/git-maintenance.txt: run::
          stands for "garbage collection," but this task performs many

      ## builtin/gc.c ##
    -@@ builtin/gc.c: static struct maintenance_opts {
    +@@ builtin/gc.c: struct maintenance_opts {
          int quiet;
    - } opts;
    + };

    -+static int run_write_commit_graph(void)
    ++static int run_write_commit_graph(struct maintenance_opts *opts)
     +{
     +    struct child_process child = CHILD_PROCESS_INIT;
     +
    @@ builtin/gc.c: static struct maintenance_opts {
     +    strvec_pushl(&child.args, "commit-graph", "write",
     +             "--split", "--reachable", NULL);
     +
    -+    if (opts.quiet)
    ++    if (opts->quiet)
     +        strvec_push(&child.args, "--no-progress");
     +
     +    return !!run_command(&child);
     +}
     +
    -+static int run_verify_commit_graph(void)
    ++static int run_verify_commit_graph(struct maintenance_opts *opts)
     +{
     +    struct child_process child = CHILD_PROCESS_INIT;
     +
    @@ builtin/gc.c: static struct maintenance_opts {
     +    strvec_pushl(&child.args, "commit-graph", "verify",
     +             "--shallow", NULL);
     +
    -+    if (opts.quiet)
    ++    if (opts->quiet)
     +        strvec_push(&child.args, "--no-progress");
     +
     +    return !!run_command(&child);
     +}
     +
    -+static int maintenance_task_commit_graph(void)
    ++static int maintenance_task_commit_graph(struct maintenance_opts *opts)
     +{
     +    struct repository *r = the_repository;
     +    char *chain_path;
     +
     +    close_object_store(r->objects);
    -+    if (run_write_commit_graph()) {
    ++    if (run_write_commit_graph(opts)) {
     +        error(_("failed to write commit-graph"));
     +        return 1;
     +    }
     +
    -+    if (!run_verify_commit_graph())
    ++    if (!run_verify_commit_graph(opts))
     +        return 0;
     +
     +    warning(_("commit-graph verify caught error, rewriting"));
    @@ builtin/gc.c: static struct maintenance_opts {
     +    }
     +    free(chain_path);
     +
    -+    if (!run_write_commit_graph())
    ++    if (!run_write_commit_graph(opts))
     +        return 0;
     +
     +    error(_("failed to rewrite commit-graph"));
     +    return 1;
     +}
     +
    - static int maintenance_task_gc(void)
    + static int maintenance_task_gc(struct maintenance_opts *opts)
      {
          struct child_process child = CHILD_PROCESS_INIT;
     @@ builtin/gc.c: struct maintenance_task {
    @@ builtin/gc.c: static struct maintenance_task tasks[] = {
     +    },
      };

    - static int maintenance_run(void)
    + static int maintenance_run(struct maintenance_opts *opts)

      ## commit-graph.c ##
     @@ commit-graph.c: static char *get_split_graph_filename(struct object_directory *odb,
 6:  dafb0d9bbc !  6:  dddbcc4f3d maintenance: add --task option
    @@ Commit message
         Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## Documentation/git-maintenance.txt ##
    +@@ Documentation/git-maintenance.txt: SUBCOMMANDS
    + -----------
    + 
    + run::
    +-    Run one or more maintenance tasks.
    ++    Run one or more maintenance tasks. If one or more `--task=<task>`
    ++    options are specified, then those tasks are run in the provided
    ++    order. Otherwise, only the `gc` task is run.
    + 
    + TASKS
    + -----
     @@ Documentation/git-maintenance.txt: OPTIONS
      --quiet::
          Do not report progress or other information over `stderr`.
    @@ Documentation/git-maintenance.txt: OPTIONS
      Part of the linkgit:git[1] suite

      ## builtin/gc.c ##
    -@@ builtin/gc.c: static const char * const builtin_maintenance_usage[] = {
    - static struct maintenance_opts {
    -     int auto_flag;
    -     int quiet;
    -+    int tasks_selected;
    - } opts;
    - 
    - static int run_write_commit_graph(void)
    -@@ builtin/gc.c: typedef int maintenance_task_fn(void);
    +@@ builtin/gc.c: typedef int maintenance_task_fn(struct maintenance_opts *opts);
      struct maintenance_task {
          const char *name;
          maintenance_task_fn *fn;
    @@ builtin/gc.c: static struct maintenance_task tasks[] = {
     +    return b->selected_order - a->selected_order;
     +}
     +
    - static int maintenance_run(void)
    + static int maintenance_run(struct maintenance_opts *opts)
      {
    -     int i;
    +-    int i;
    ++    int i, found_selected = 0;
          int result = 0;

    -+    if (opts.tasks_selected)
    ++    for (i = 0; !found_selected && i < TASK__COUNT; i++)
    ++        found_selected = tasks[i].selected;
    ++
    ++    if (found_selected)
     +        QSORT(tasks, TASK__COUNT, compare_tasks_by_selection);
     +
          for (i = 0; i < TASK__COUNT; i++) {
     -        if (!tasks[i].enabled)
    -+        if (opts.tasks_selected && !tasks[i].selected)
    ++        if (found_selected && !tasks[i].selected)
     +            continue;
     +
    -+        if (!opts.tasks_selected && !tasks[i].enabled)
    ++        if (!found_selected && !tasks[i].enabled)
                  continue;

    -         if (tasks[i].fn()) {
    -@@ builtin/gc.c: static int maintenance_run(void)
    +         if (tasks[i].fn(opts)) {
    +@@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
          return result;
      }

     +static int task_option_parse(const struct option *opt,
     +                 const char *arg, int unset)
     +{
    -+    int i;
    ++    int i, num_selected = 0;
     +    struct maintenance_task *task = NULL;
     +
     +    BUG_ON_OPT_NEG(unset);
     +
    -+    opts.tasks_selected++;
    -+
     +    for (i = 0; i < TASK__COUNT; i++) {
    ++        num_selected += tasks[i].selected;
     +        if (!strcasecmp(tasks[i].name, arg)) {
     +            task = &tasks[i];
    -+            break;
     +        }
     +    }
     +
    @@ builtin/gc.c: static int maintenance_run(void)
     +    }
     +
     +    task->selected = 1;
    -+    task->selected_order = opts.tasks_selected;
    ++    task->selected_order = num_selected + 1;
     +
     +    return 0;
     +}
     +
      int cmd_maintenance(int argc, const char **argv, const char *prefix)
      {
    -     static struct option builtin_maintenance_options[] = {
    +     static struct maintenance_opts opts;
     @@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefix)
                   N_("run tasks based on the state of the repository")),
              OPT_BOOL(0, "quiet", &opts.quiet,
    @@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefi

      ## t/t7900-maintenance.sh ##
     @@ t/t7900-maintenance.sh: test_expect_success 'run [--auto|--quiet]' '
    -     grep ",\"gc\",\"--quiet\"" run-quiet.txt
    +     test_subcommand git gc --no-quiet <run-no-quiet.txt
      '

     +test_expect_success 'run --task=<task>' '
    -+    GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" git maintenance run --task=commit-graph &&
    -+    GIT_TRACE2_EVENT="$(pwd)/run-gc.txt" git maintenance run --task=gc &&
    -+    GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" git maintenance run --task=commit-graph &&
    -+    GIT_TRACE2_EVENT="$(pwd)/run-both.txt" git maintenance run --task=commit-graph --task=gc &&
    -+    ! grep ",\"gc\"" run-commit-graph.txt  &&
    -+    grep ",\"gc\"" run-gc.txt  &&
    -+    grep ",\"gc\"" run-both.txt  &&
    -+    grep ",\"commit-graph\",\"write\"" run-commit-graph.txt  &&
    -+    ! grep ",\"commit-graph\",\"write\"" run-gc.txt  &&
    -+    grep ",\"commit-graph\",\"write\"" run-both.txt
    ++    GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" \
    ++        git maintenance run --task=commit-graph 2>/dev/null &&
    ++    GIT_TRACE2_EVENT="$(pwd)/run-gc.txt" \
    ++        git maintenance run --task=gc 2>/dev/null &&
    ++    GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" \
    ++        git maintenance run --task=commit-graph 2>/dev/null &&
    ++    GIT_TRACE2_EVENT="$(pwd)/run-both.txt" \
    ++        git maintenance run --task=commit-graph --task=gc 2>/dev/null &&
    ++    test_subcommand ! git gc --quiet <run-commit-graph.txt &&
    ++    test_subcommand git gc --quiet <run-gc.txt &&
    ++    test_subcommand git gc --quiet <run-both.txt &&
    ++    test_subcommand git commit-graph write --split --reachable --no-progress <run-commit-graph.txt &&
    ++    test_subcommand ! git commit-graph write --split --reachable --no-progress <run-gc.txt &&
    ++    test_subcommand git commit-graph write --split --reachable --no-progress <run-both.txt
     +'
     +
     +test_expect_success 'run --task=bogus' '
 7:  1b00524da3 !  7:  79af39be13 maintenance: take a lock on the objects directory
    @@ Commit message
         Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## builtin/gc.c ##
    -@@ builtin/gc.c: static int maintenance_run(void)
    +@@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
      {
    -     int i;
    +     int i, found_selected = 0;
          int result = 0;
     +    struct lock_file lk;
     +    struct repository *r = the_repository;
    @@ builtin/gc.c: static int maintenance_run(void)
     +         * recursive process stack. Do not report an error in
     +         * that case.
     +         */
    -+        if (!opts.auto_flag && !opts.quiet)
    ++        if (!opts->auto_flag && !opts->quiet)
     +            error(_("lock file '%s' exists, skipping maintenance"),
     +                  lock_path);
     +        free(lock_path);
    @@ builtin/gc.c: static int maintenance_run(void)
     +    }
     +    free(lock_path);

    -     if (opts.tasks_selected)
    -         QSORT(tasks, TASK__COUNT, compare_tasks_by_selection);
    -@@ builtin/gc.c: static int maintenance_run(void)
    +     for (i = 0; !found_selected && i < TASK__COUNT; i++)
    +         found_selected = tasks[i].selected;
    +@@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
              }
          }

 8:  0e94e04dcd <  -:  ---------- fetch: optionally allow disabling FETCH_HEAD update
 9:  9e38ade15c <  -:  ---------- maintenance: add prefetch task
10:  0128fdfd1a <  -:  ---------- maintenance: add loose-objects task
11:  c2baf6e119 <  -:  ---------- midx: enable core.multiPackIndex by default
12:  00f47c4848 <  -:  ---------- maintenance: add incremental-repack task
13:  ef2a231956 <  -:  ---------- maintenance: auto-size incremental-repack batch
14:  99840c4b8f !  8:  69bfc6a4b2 maintenance: create maintenance.<task>.enabled config
    @@ Documentation/git-maintenance.txt: SUBCOMMANDS
      -----------

      run::
    --    Run one or more maintenance tasks.
    +-    Run one or more maintenance tasks. If one or more `--task=<task>`
    +-    options are specified, then those tasks are run in the provided
    +-    order. Otherwise, only the `gc` task is run.
     +    Run one or more maintenance tasks. If one or more `--task` options
     +    are specified, then those tasks are run in that order. Otherwise,
     +    the tasks are determined by which `maintenance.<task>.enabled`
    @@ Documentation/git-maintenance.txt: SUBCOMMANDS
      -----

      ## builtin/gc.c ##
    -@@ builtin/gc.c: static int maintenance_run(void)
    +@@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
          return result;
      }

    @@ builtin/gc.c: int cmd_maintenance(int argc, const char **argv, const char *prefi

      ## t/t7900-maintenance.sh ##
     @@ t/t7900-maintenance.sh: test_expect_success 'run [--auto|--quiet]' '
    -     grep ",\"gc\",\"--quiet\"" run-quiet.txt
    +     test_subcommand git gc --no-quiet <run-no-quiet.txt
      '

     +test_expect_success 'maintenance.<task>.enabled' '
     +    git config maintenance.gc.enabled false &&
     +    git config maintenance.commit-graph.enabled true &&
    -+    git config maintenance.loose-objects.enabled true &&
    -+    GIT_TRACE2_EVENT="$(pwd)/run-config.txt" git maintenance run &&
    -+    ! grep ",\"fetch\"" run-config.txt &&
    -+    ! grep ",\"gc\"" run-config.txt &&
    -+    ! grep ",\"multi-pack-index\"" run-config.txt &&
    -+    grep ",\"commit-graph\"" run-config.txt &&
    -+    grep ",\"prune-packed\"" run-config.txt
    ++    GIT_TRACE2_EVENT="$(pwd)/run-config.txt" git maintenance run 2>err &&
    ++    test_subcommand ! git gc --quiet <run-config.txt &&
    ++    test_subcommand git commit-graph write --split --reachable --no-progress <run-config.txt
     +'
     +
      test_expect_success 'run --task=<task>' '
    -     GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" git maintenance run --task=commit-graph &&
    -     GIT_TRACE2_EVENT="$(pwd)/run-gc.txt" git maintenance run --task=gc &&
    +     GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" \
    +         git maintenance run --task=commit-graph 2>/dev/null &&
15:  a087c63572 !  9:  df21bbb000 maintenance: use pointers to check --auto
    @@ Commit message
         Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## builtin/gc.c ##
    -@@ builtin/gc.c: static int maintenance_task_incremental_repack(void)
    +@@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_opts *opts)

    - typedef int maintenance_task_fn(void);
    + typedef int maintenance_task_fn(struct maintenance_opts *opts);

     +/*
     + * An auto condition function returns 1 if the task should run
    @@ builtin/gc.c: static struct maintenance_task tasks[] = {
              1,
          },
          [TASK_COMMIT_GRAPH] = {
    -@@ builtin/gc.c: static int maintenance_run(void)
    -         if (!opts.tasks_selected && !tasks[i].enabled)
    +@@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
    +         if (!found_selected && !tasks[i].enabled)
                  continue;

    -+        if (opts.auto_flag &&
    ++        if (opts->auto_flag &&
     +            (!tasks[i].auto_condition ||
     +             !tasks[i].auto_condition()))
     +            continue;
     +
    -         if (tasks[i].fn()) {
    +         if (tasks[i].fn(opts)) {
                  error(_("task '%s' failed"), tasks[i].name);
                  result = 1;
     @@ builtin/gc.c: static void initialize_task_config(void)
    @@ t/t5514-fetch-multiple.sh: test_expect_success 'git fetch --multiple (two remote

      ## t/t7900-maintenance.sh ##
     @@ t/t7900-maintenance.sh: test_expect_success 'run [--auto|--quiet]' '
    -     GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
    -     GIT_TRACE2_EVENT="$(pwd)/run-quiet.txt" git maintenance run --quiet &&
    -     grep ",\"gc\"]" run-no-auto.txt  &&
    --    grep ",\"gc\",\"--auto\"" run-auto.txt &&
    -+    ! grep ",\"gc\",\"--auto\"" run-auto.txt &&
    -     grep ",\"gc\",\"--quiet\"" run-quiet.txt
    +     GIT_TRACE2_EVENT="$(pwd)/run-no-quiet.txt" \
    +         git maintenance run --no-quiet 2>/dev/null &&
    +     test_subcommand git gc --quiet <run-no-auto.txt &&
    +-    test_subcommand git gc --auto --quiet <run-auto.txt &&
    ++    test_subcommand ! git gc --auto --quiet <run-auto.txt &&
    +     test_subcommand git gc --no-quiet <run-no-quiet.txt
      '

16:  ef3a854508 ! 10:  e67e259aef maintenance: add auto condition for commit-graph task
    @@ Documentation/config/maintenance.txt: maintenance.<task>.enabled::

      ## builtin/gc.c ##
     @@
    + #include "blob.h"
    + #include "tree.h"
      #include "promisor-remote.h"
    - #include "remote.h"
    - #include "midx.h"
     +#include "refs.h"

      #define FAILED_RUN "failed to run %s"

    -@@ builtin/gc.c: static struct maintenance_opts {
    -     int tasks_selected;
    - } opts;
    +@@ builtin/gc.c: struct maintenance_opts {
    +     int quiet;
    + };

     +/* Remember to update object flag allocation in object.h */
     +#define PARENT1        (1u<<16)
    @@ builtin/gc.c: static struct maintenance_opts {
     +    return result;
     +}
     +
    - static int run_write_commit_graph(void)
    + static int run_write_commit_graph(struct maintenance_opts *opts)
      {
          struct child_process child = CHILD_PROCESS_INIT;
     @@ builtin/gc.c: static struct maintenance_task tasks[] = {
17:  6ac3a58f2f <  -:  ---------- maintenance: create auto condition for loose-objects
18:  801b262d1c <  -:  ---------- maintenance: add incremental-repack auto condition
19:  9b4cef7635 <  -:  ---------- midx: use start_delayed_progress()
20:  39eb83ad1e ! 11:  a5d1914846 maintenance: add trace2 regions for task execution
    @@ Commit message
         Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## builtin/gc.c ##
    -@@ builtin/gc.c: static int maintenance_run(void)
    +@@ builtin/gc.c: static int maintenance_run(struct maintenance_opts *opts)
                   !tasks[i].auto_condition()))
                  continue;

     +        trace2_region_enter("maintenance", tasks[i].name, r);
    -         if (tasks[i].fn()) {
    +         if (tasks[i].fn(opts)) {
                  error(_("task '%s' failed"), tasks[i].name);
                  result = 1;
              }

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
 Documentation/git-maintenance.txt    |  86 +++++++
 builtin.h                            |   1 +
 builtin/am.c                         |   2 +-
 builtin/commit.c                     |   2 +-
 builtin/fetch.c                      |   6 +-
 builtin/gc.c                         | 353 +++++++++++++++++++++++++++
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
 t/t7900-maintenance.sh               |  61 +++++
 t/test-lib-functions.sh              |  33 +++
 23 files changed, 584 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/config/maintenance.txt
 create mode 100644 Documentation/git-maintenance.txt
 create mode 100755 t/t7900-maintenance.sh


base-commit: d70a9eb611a9d242c1d26847d223b8677609305b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-695%2Fderrickstolee%2Fmaintenance%2Fbuiltin-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-695/derrickstolee/maintenance/builtin-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/695
-- 
gitgitgadget
