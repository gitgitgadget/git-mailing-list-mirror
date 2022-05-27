Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EFAC433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 09:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244824AbiE0JOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 05:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiE0JOl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 05:14:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DE4AA
        for <git@vger.kernel.org>; Fri, 27 May 2022 02:14:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso4211285wmh.3
        for <git@vger.kernel.org>; Fri, 27 May 2022 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V933hJCSIU5YwFcb9Q4OvtM4jxB+oT5V1pmz25/nJeU=;
        b=dODKdiMPDMh6ffHA+9IIEugoyLaq23ykCMzEaTmOjcXB21lV1chVzWhFqJ5P79u5GT
         fWStnecKBM2v4nGfvvJJ2mnyhn/lfFaCkuaYol0RplY1gX/IrqBDc/uBjdtqRYxDD6pZ
         cFZcvUSjLJQFq5Xg3i6FBc1hs+PUmay2j1qioDF1/IkkiW3fm4L0ifDpm6SuKuH5X6wr
         OCHDCusjJ6dduy3xwBP0lrYQEhvEBJzT3VSXWcbDD6gru6YNHGZPhgRd+6W8F6vmEYvv
         vjd733CzQlQM3jeW+ZyJfS75qk1WeA1PrL/NrfZgA2w7VXtirh5a9IQx+HmVypPLKEtY
         CmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V933hJCSIU5YwFcb9Q4OvtM4jxB+oT5V1pmz25/nJeU=;
        b=ZbkCjaz3yktLJfM1B+DusYXCYpYWsrMapU/sx/RyDESWJ2tiWnH7ifXSkz4MLivVQ3
         er8V3KcItgufB/TyK31pXN3aRssR9cEPX6QEJ6LECn0IVMrPKdHcJ0RIbfQ9ntEoaPu6
         0qTLwc5BHZi85vjDeZPDI7RXd77XDoVvL2SCzP/GyUE/ceYU/+FhYkNl7Qd9QuE+eLXN
         Yxa2xvKLn1MmkUmJ48f0gjyA3ChNYs+EszqoWEyYv1WgPau488Ptqg0uyzeoF/DjR/T4
         1CAPkDeYLfYWh0MmK9IfcJXi4PlRzehFoye89bSEBKrQZx7tl23kuBKqPsjxaJhM2jRQ
         B5XQ==
X-Gm-Message-State: AOAM533l6HS3o7cIRT4Me/brs40scKV+o8johBMU6vVH353JM1OrBiui
        p63MqBZbgjIEWbDUOjcc+7h+0uURSFFrlQ==
X-Google-Smtp-Source: ABdhPJyI9Pc8tVwMuaHiB4I2cVlIW7W4+eSV5v1DbLKxTZ4MC2ipcOW8u4tISh0y1Tn6Pr+fZmewtQ==
X-Received: by 2002:a05:600c:209:b0:397:4a0f:7 with SMTP id 9-20020a05600c020900b003974a0f0007mr5993414wmi.91.1653642877950;
        Fri, 27 May 2022 02:14:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11-20020a05600c3acb00b003942a244ecbsm1551466wms.16.2022.05.27.02.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 02:14:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/2] hook API: connect hooks to the TTY again, fixes a v2.36.0 regression
Date:   Fri, 27 May 2022 11:14:29 +0200
Message-Id: <cover-v3-0.2-00000000000-20220527T090618Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1046.g586767a6996
In-Reply-To: <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of [1] which aims to address the concerns about the previous
8-part series being too large to fix a release regression. "If it
isn't bolted down, throw it overboard!".

The main change here is:

 * The new "ungroup" parameter is now passed via an "extern" parameter.
 * Tests for existing run-command.c behavior (not narrowly needed for
   the regression fix) are gone.
 * Adding an INIT macro is gone, instead we explicitly  initialize to NULL.
 * Stray bugfix for existing hook test is gone.

etc. I think all of those still make sense, but they're something I
can rebase on this topic once it (hopefully) lands. In the meantime
the updated commit messages for the remaining two (see start of the
range-diff below) argue for this being a a safe API change, even if
the interface is a bit nasty.

1. https://lore.kernel.org/git/cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com

Ævar Arnfjörð Bjarmason (2):
  run-command: add an "ungroup" option to run_process_parallel()
  hook API: fix v2.36.0 regression: hooks should be connected to a TTY

 hook.c                      |  1 +
 run-command.c               | 88 ++++++++++++++++++++++++++++---------
 run-command.h               | 31 ++++++++++---
 t/helper/test-run-command.c | 19 ++++++--
 t/t0061-run-command.sh      | 35 +++++++++++++++
 t/t1800-hook.sh             | 37 ++++++++++++++++
 6 files changed, 181 insertions(+), 30 deletions(-)

Range-diff against v2:
1:  26a81eff267 < -:  ----------- run-command tests: change if/if/... to if/else if/else
2:  5f0a6e9925f < -:  ----------- run-command API: use "opts" struct for run_processes_parallel{,_tr2}()
3:  a8e1fc07b65 < -:  ----------- run-command tests: test stdout of run_command_parallel()
4:  663936fb4ad < -:  ----------- run-command.c: add an initializer for "struct parallel_processes"
5:  c2e015ed840 ! 1:  aabd99de680 run-command: add an "ungroup" option to run_process_parallel()
    @@ Commit message
         user, i.e. they'd typically use one mode or the other, and would know
         whether they'd provided "ungroup" or not.
     
    +    We could also avoid the strbuf_init() for "buffered_output" by having
    +    "struct parallel_processes" use a static PARALLEL_PROCESSES_INIT
    +    initializer, but let's leave that cleanup for later.
    +
    +    Using a global "run_processes_parallel_ungroup" variable to enable
    +    this option is rather nasty, but is being done here to produce as
    +    minimal of a change as possible for a subsequent regression fix. This
    +    change is extracted from a larger initial version[1] which ends up
    +    with a better end-state for the API, but in doing so needed to modify
    +    all existing callers of the API. Let's defer that for now, and
    +    narrowly focus on what we need for fixing the regression in the
    +    subsequent commit.
    +
    +    It's safe to do this with a global variable because:
    +
    +     A) hook.c is the only user of it that sets it to non-zero, and before
    +        we'll get any other API users we'll refactor away this method of
    +        passing in the option, i.e. re-roll [1].
    +
    +     B) Even if hook.c wasn't the only user we don't have callers of this
    +        API that concurrently invoke this parallel process starting API
    +        itself in parallel.
    +
    +    As noted above "A" && "B" are rather nasty, and we don't want to live
    +    with those caveats long-term, but for now they should be an acceptable
    +    compromise.
    +
    +    1. https://lore.kernel.org/git/cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## run-command.c ##
    @@ run-command.c: int pipe_command(struct child_process *cmd,
     +	GIT_CP_WAIT_CLEANUP, /* only for !ungroup */
      };
      
    ++int run_processes_parallel_ungroup;
      struct parallel_processes {
    + 	void *data;
    + 
     @@ run-command.c: struct parallel_processes {
      	struct pollfd *pfd;
      
    @@ run-command.c: struct parallel_processes {
      
      	int output_owner;
      	struct strbuf buffered_output; /* of finished children */
    +@@ run-command.c: static void pp_init(struct parallel_processes *pp,
    + 		    get_next_task_fn get_next_task,
    + 		    start_failure_fn start_failure,
    + 		    task_finished_fn task_finished,
    +-		    void *data)
    ++		    void *data,  const int ungroup)
    + {
    + 	int i;
    + 
     @@ run-command.c: static void pp_init(struct parallel_processes *pp,
      	pp->nr_processes = 0;
      	pp->output_owner = 0;
      	pp->shutdown = 0;
    -+	pp->ungroup = opts->ungroup;
    ++	pp->ungroup = ungroup;
      	CALLOC_ARRAY(pp->children, n);
     -	CALLOC_ARRAY(pp->pfd, n);
    -+	if (!pp->ungroup)
    ++	if (pp->ungroup)
    ++		pp->pfd = NULL;
    ++	else
     +		CALLOC_ARRAY(pp->pfd, n);
    + 	strbuf_init(&pp->buffered_output, 0);
      
      	for (i = 0; i < n; i++) {
      		strbuf_init(&pp->children[i].err, 0);
    @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp)
      			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
      			strbuf_reset(&pp->children[i].err);
      		} else {
    -@@ run-command.c: int run_processes_parallel(struct run_process_parallel_opts *opts)
    +@@ run-command.c: int run_processes_parallel(int n,
    + 	int output_timeout = 100;
    + 	int spawn_cap = 4;
    + 	struct parallel_processes pp;
    ++	const int ungroup = run_processes_parallel_ungroup;
    + 
    +-	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb);
    ++	/* unset for the next API user */
    ++	run_processes_parallel_ungroup = 0;
    ++
    ++	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
    ++		ungroup);
    + 	while (1) {
    + 		for (i = 0;
    + 		    i < spawn_cap && !pp.shutdown &&
    +@@ run-command.c: int run_processes_parallel(int n,
      		}
      		if (!pp.nr_processes)
      			break;
     -		pp_buffer_stderr(&pp, output_timeout);
     -		pp_output(&pp);
    -+		if (opts->ungroup) {
    ++		if (ungroup) {
     +			pp_mark_working_for_cleanup(&pp);
     +		} else {
     +			pp_buffer_stderr(&pp, output_timeout);
    @@ run-command.h: typedef int (*start_failure_fn)(struct strbuf *out,
       * pp_cb is the callback cookie as passed into run_processes_parallel,
       * pp_task_cb is the callback cookie as passed into get_next_task_fn.
     @@ run-command.h: typedef int (*task_finished_fn)(int result,
    -  *
    -  * jobs: see 'n' in run_processes_parallel() below.
    -  *
    -+ * ungroup: Ungroup output. Output is printed as soon as possible and
    -+ * bypasses run-command's internal processing. This may cause output
    -+ * from different commands to be mixed.
    -+ *
    -  * *_fn & data: see run_processes_parallel() below.
    -  */
    - struct run_process_parallel_opts
    -@@ run-command.h: struct run_process_parallel_opts
    - 	const char *tr2_label;
    - 
    - 	int jobs;
    -+	unsigned int ungroup:1;
    - 
    - 	get_next_task_fn get_next_task;
    - 	start_failure_fn start_failure;
    -@@ run-command.h: struct run_process_parallel_opts
       *
       * The children started via this function run in parallel. Their output
       * (both stdout and stderr) is routed to stderr in a manner that output
    @@ run-command.h: struct run_process_parallel_opts
     + * NULL "struct strbuf *out" parameter, and are responsible for
     + * emitting their own output, including dealing with any race
     + * conditions due to writing in parallel to stdout and stderr.
    ++ * The "ungroup" option can be enabled by setting the global
    ++ * "run_processes_parallel_ungroup" to "1" before invoking
    ++ * run_processes_parallel(), it will be set back to "0" as soon as the
    ++ * API reads that setting.
       */
    - int run_processes_parallel(struct run_process_parallel_opts *opts);
    - 
    ++extern int run_processes_parallel_ungroup;
    + int run_processes_parallel(int n,
    + 			   get_next_task_fn,
    + 			   start_failure_fn,
     
      ## t/helper/test-run-command.c ##
     @@ t/helper/test-run-command.c: static int parallel_next(struct child_process *cp,
    @@ t/helper/test-run-command.c: static int task_finished(int result,
      }
      
     @@ t/helper/test-run-command.c: int cmd__run_command(int argc, const char **argv)
    - 	opts.jobs = jobs;
    - 	opts.data = &proc;
    + 	strvec_clear(&proc.args);
    + 	strvec_pushv(&proc.args, (const char **)argv + 3);
      
    --	if (!strcmp(argv[1], "run-command-parallel")) {
    -+	if (!strcmp(argv[1], "run-command-parallel") ||
    -+	    !strcmp(argv[1], "run-command-parallel-ungroup")) {
    - 		next_fn = parallel_next;
    --	} else if (!strcmp(argv[1], "run-command-abort")) {
    -+	} else if (!strcmp(argv[1], "run-command-abort") ||
    -+		   !strcmp(argv[1], "run-command-abort-ungroup")) {
    - 		next_fn = parallel_next;
    - 		finished_fn = task_finished;
    --	} else if (!strcmp(argv[1], "run-command-no-jobs")) {
    -+	} else if (!strcmp(argv[1], "run-command-no-jobs") ||
    -+		   !strcmp(argv[1], "run-command-no-jobs-ungroup")) {
    - 		next_fn = no_job;
    - 		finished_fn = task_finished;
    - 	} else {
    -@@ t/helper/test-run-command.c: int cmd__run_command(int argc, const char **argv)
    - 		return 1;
    - 	}
    - 
    -+	opts.ungroup = ends_with(argv[1], "-ungroup");
    - 	opts.get_next_task = next_fn;
    - 	opts.task_finished = finished_fn;
    - 	exit(run_processes_parallel(&opts));
    ++	if (getenv("RUN_PROCESSES_PARALLEL_UNGROUP"))
    ++		run_processes_parallel_ungroup = 1;
    ++
    + 	if (!strcmp(argv[1], "run-command-parallel"))
    + 		exit(run_processes_parallel(jobs, parallel_next,
    + 					    NULL, NULL, &proc));
     
      ## t/t0061-run-command.sh ##
     @@ t/t0061-run-command.sh: test_expect_success 'run_command runs in parallel with more jobs available than
    - 	test_cmp expect err
    + 	test_cmp expect actual
      '
      
     +test_expect_success 'run_command runs ungrouped in parallel with more jobs available than tasks' '
    -+	test-tool run-command run-command-parallel-ungroup 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    ++	RUN_PROCESSES_PARALLEL_UNGROUP=1 \
    ++	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
     +	test_line_count = 8 out &&
     +	test_line_count = 4 err
     +'
     +
      test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
    - 	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    - 	test_must_be_empty out &&
    - 	test_cmp expect err
    + 	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
    + 	test_cmp expect actual
      '
      
     +test_expect_success 'run_command runs ungrouped in parallel with as many jobs as tasks' '
    -+	test-tool run-command run-command-parallel-ungroup 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    ++	RUN_PROCESSES_PARALLEL_UNGROUP=1 \
    ++	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
     +	test_line_count = 8 out &&
     +	test_line_count = 4 err
     +'
     +
      test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
    - 	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    - 	test_must_be_empty out &&
    - 	test_cmp expect err
    + 	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
    + 	test_cmp expect actual
      '
      
     +test_expect_success 'run_command runs ungrouped in parallel with more tasks than jobs available' '
    -+	test-tool run-command run-command-parallel-ungroup 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    ++	RUN_PROCESSES_PARALLEL_UNGROUP=1 \
    ++	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
     +	test_line_count = 8 out &&
     +	test_line_count = 4 err
     +'
    @@ t/t0061-run-command.sh: test_expect_success 'run_command runs in parallel with m
      preloaded output of a child
      asking for a quick stop
     @@ t/t0061-run-command.sh: test_expect_success 'run_command is asked to abort gracefully' '
    - 	test_cmp expect err
    + 	test_cmp expect actual
      '
      
     +test_expect_success 'run_command is asked to abort gracefully (ungroup)' '
    -+	test-tool run-command run-command-abort-ungroup 3 false >out 2>err &&
    ++	RUN_PROCESSES_PARALLEL_UNGROUP=1 \
    ++	test-tool run-command run-command-abort 3 false >out 2>err &&
     +	test_must_be_empty out &&
     +	test_line_count = 6 err
     +'
    @@ t/t0061-run-command.sh: test_expect_success 'run_command is asked to abort grace
      no further jobs available
      EOF
     @@ t/t0061-run-command.sh: test_expect_success 'run_command outputs ' '
    - 	test_cmp expect err
    + 	test_cmp expect actual
      '
      
     +test_expect_success 'run_command outputs (ungroup) ' '
    -+	test-tool run-command run-command-no-jobs-ungroup 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    ++	RUN_PROCESSES_PARALLEL_UNGROUP=1 \
    ++	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
     +	test_must_be_empty out &&
     +	test_cmp expect err
     +'
6:  84e92c6f7c7 < -:  ----------- hook tests: fix redirection logic error in 96e7225b310
7:  bf7d871565f < -:  ----------- hook API: don't redundantly re-set "no_stdin" and "stdout_to_stderr"
8:  238155fcb9d ! 2:  ec27e3906e1 hook API: fix v2.36.0 regression: hooks should be connected to a TTY
    @@ Commit message
                   './git hook run seq-hook' in 'HEAD~0' ran
                     1.30 ± 0.02 times faster than './git hook run seq-hook' in 'origin/master'
     
    -    In the preceding commit we removed the "stdout_to_stderr=1" assignment
    -    as being redundant. This change brings it back as with ".ungroup=1"
    -    the run_process_parallel() function doesn't provide them for us
    -    implicitly.
    -
    -    As an aside omitting the stdout_to_stderr=1 here would have all tests
    -    pass, except those that test "git hook run" itself in
    -    t1800-hook.sh. But our tests passing is the result of another test
    -    blind spot, as was the case with the regression being fixed here. The
    -    "stdout_to_stderr=1" for hooks is long-standing behavior, see
    -    e.g. 1d9e8b56fe3 (Split back out update_hook handling in receive-pack,
    -    2007-03-10) and other follow-up commits (running "git log" with
    -    "--reverse -p -Gstdout_to_stderr" is a good start).
    -
         1. https://lore.kernel.org/git/CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com/
     
         Reported-by: Anthony Sottile <asottile@umich.edu>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## hook.c ##
    -@@ hook.c: static int pick_next_hook(struct child_process *cp,
    - 		return 0;
    - 
    - 	strvec_pushv(&cp->env_array, hook_cb->options->env.v);
    -+	cp->stdout_to_stderr = 1; /* because of .ungroup = 1 */
    - 	cp->trace2_hook_name = hook_cb->hook_name;
    - 	cp->dir = hook_cb->options->dir;
    - 
     @@ hook.c: int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
    - 		.tr2_label = hook_name,
    - 
    - 		.jobs = jobs,
    -+		.ungroup = jobs == 1,
    - 
    - 		.get_next_task = pick_next_hook,
    - 		.start_failure = notify_start_failure,
    -@@ hook.c: int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
    - 	if (!options)
    - 		BUG("a struct run_hooks_opt must be provided to run_hooks");
    - 
    -+	if (jobs != 1 || !run_opts.ungroup)
    -+		BUG("TODO: think about & document order & interleaving of parallel hook output");
    -+
    - 	if (options->invoked_hook)
    - 		*options->invoked_hook = 0;
    + 		cb_data.hook_path = abs_path.buf;
    + 	}
      
    ++	run_processes_parallel_ungroup = 1;
    + 	run_processes_parallel_tr2(jobs,
    + 				   pick_next_hook,
    + 				   notify_start_failure,
     
      ## t/t1800-hook.sh ##
     @@ t/t1800-hook.sh: test_description='git-hook command'
-- 
2.36.1.1046.g586767a6996

