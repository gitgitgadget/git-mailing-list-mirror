Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87358C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 20:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242294AbiERUFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 16:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242255AbiERUFe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 16:05:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658382375C0
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:05:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h14so4163086wrc.6
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wr0hUOwXx26wYV4cGjqZBUfi6h6/ebdZCOt35YRl1zQ=;
        b=I5JkXhdqqPX+YsyGKm0BSGSHtLo6/3O0N3prhe4pcYjnsvgNBSJ5kPJyk4kUUJdc/S
         Y3hoi/mWadQhc2xJdYnp7edkuf1cRBALP2+5PKXUz2uk0yQuU4q/g+Tobc1r7fLE+Lks
         qsooQgY92DtiplJkCs5Sr22Wd2s8Tg4iUJA1pdgg1QHu5rH4tnUgIljYmJvijIiPNqYB
         gGajclkgNXRuxm/0aLBwUbXV8Ddpy4PzF5aLEz0Nh+jedWAfBZtXRsjr4wHAoHkHNGJP
         ciQ01YBNOSymvzAco40R4anfXQJW2KVRIdm5N3ZyVJMxVu38qECZERmYN8GApJh4tkMh
         42dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wr0hUOwXx26wYV4cGjqZBUfi6h6/ebdZCOt35YRl1zQ=;
        b=4ZD978vvSc/ImQQHY9LJuEh3w3YaXEMaBsU/O3a43f01H8UVzAOy8+tAPIOf0Yxk14
         yX/zblKSBwiWUs5Kl+0nAAw7CFtfmSqF1OLA3EJEZRU1Nj99GG6FFdbNMTzriXia9+ZC
         ZZQ+jFm1NradSTQ5yzeVLQJME8VBHKQrsS0cPrkd9Ufc8mlkgJClwDVzqttl0Z3n7FeG
         u6WlEPjZTiO4XoJe/CUYMhLQGrjYtYZBhhrJ0P7ybf3ZEWWKzCTl8rP3DtbXgilakTSI
         cGz3rq+JQCr8jX3lt2B8udP56W6gG6z4FjU2LiS8RRIWeKxWQuqImfOl9bmrNIhhW6lT
         MyBQ==
X-Gm-Message-State: AOAM531vJYM2ZqL8wNxdKoO6kv70GvmfNbVHXP4ioTy+hgVOticq8anX
        vWVA6oNCjQHqsJunL31+w/Gd61Q4Dp7Waw==
X-Google-Smtp-Source: ABdhPJxbP5WBhxQ79q+HV5GlArNsCJfFMi17BL+QoVnCZztORJV3xrZdLSQDqotWEBm5iDgmvkF1pg==
X-Received: by 2002:adf:ed8a:0:b0:20c:fe1d:d9e3 with SMTP id c10-20020adfed8a000000b0020cfe1dd9e3mr1122816wro.546.1652904329238;
        Wed, 18 May 2022 13:05:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020adfb612000000b0020d00174eabsm2674441wre.94.2022.05.18.13.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:05:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/8] hook API: connect hooks to the TTY again, fixes a v2.36.0 regression
Date:   Wed, 18 May 2022 22:05:16 +0200
Message-Id: <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.952.g0ae626f6cd7
In-Reply-To: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of v1[1]. I believe this addresses all comments on the v1
(but perhaps I missed something). Changes:

 * The run_processes_parallel() now takes only one argument, the new
   "opts" struct which has options, callbacks etc. This will also make
   the subsequent config-based hooks topic less churny (it needs new
   callbacks).

   As a result the whole internal *_tr2() wrapper/static function are
   gone.

 * Replaced checks of "ungroup" with whether we have a NULL or not
   (e.g. for pp->pfd), also for free().

 * Typo/grammar fixes in commit messages.

 * Hopefully the 8/8 is less confusing vis-a-vis
   https://lore.kernel.org/git/xmqqfslva3mx.fsf@gitster.g/; I.e. now
   we only add "stdout_to_stderr".

 * The 01/08 and 04/08 are new: Splitting those out made subsequent
   diffs smaller.

 * Tweaked 5/8 a bit to make the diff smaller.

 * Used "err" and "out", not "actual" and "out" in tests, per Junio's
   suggestion.

Passing CI for this series at: https://github.com/avar/git/actions/runs/2346571047

1. https://lore.kernel.org/git/cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (8):
  run-command tests: change if/if/... to if/else if/else
  run-command API: use "opts" struct for run_processes_parallel{,_tr2}()
  run-command tests: test stdout of run_command_parallel()
  run-command.c: add an initializer for "struct parallel_processes"
  run-command: add an "ungroup" option to run_process_parallel()
  hook tests: fix redirection logic error in 96e7225b310
  hook API: don't redundantly re-set "no_stdin" and "stdout_to_stderr"
  hook API: fix v2.36.0 regression: hooks should be connected to a TTY

 builtin/fetch.c             |  18 +++--
 builtin/submodule--helper.c |  15 ++--
 hook.c                      |  28 +++++---
 run-command.c               | 132 +++++++++++++++++++++++-------------
 run-command.h               |  66 ++++++++++++++----
 submodule.c                 |  18 +++--
 t/helper/test-run-command.c |  65 ++++++++++++------
 t/t0061-run-command.sh      |  55 ++++++++++++---
 t/t1800-hook.sh             |  39 ++++++++++-
 9 files changed, 316 insertions(+), 120 deletions(-)

Range-diff against v1:
-:  ----------- > 1:  26a81eff267 run-command tests: change if/if/... to if/else if/else
1:  8bf71ce63dd ! 2:  5f0a6e9925f run-command API: replace run_processes_parallel_tr2() with opts struct
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    run-command API: replace run_processes_parallel_tr2() with opts struct
    +    run-command API: use "opts" struct for run_processes_parallel{,_tr2}()
     
    -    Add a new "struct run_process_parallel_opts" to cover the trace2
    -    use-case added in ee4512ed481 (trace2: create new combined trace
    -    facility, 2019-02-22). A subsequent commit will add more options, and
    -    having a proliferation of new functions or extra parameters would
    -    result in needless churn.
    +    Add a new "struct run_process_parallel_opts" to replace the growing
    +    run_processes_parallel() and run_processes_parallel_tr2() argument
    +    lists. This refactoring makes it easier to add new options and
    +    parameters easier.
     
    -    It makes for a smaller change to make run_processes_parallel() and
    -    run_processes_parallel_tr2() wrapper functions for the new "static"
    -    run_processes_parallel_1(), which contains the main logic. We pass
    -    down "opts" to the *_1() function even though it isn't used there
    -    yet (only in the *_tr2() function), a subsequent commit will make more
    -    use of it.
    +    The *_tr2() variant of the function was added in ee4512ed481 (trace2:
    +    create new combined trace facility, 2019-02-22), and has subsequently
    +    been used by every caller except t/helper/test-run-command.c.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/fetch.c: static int fetch_multiple(struct string_list *list, int max_chi
     +		struct run_process_parallel_opts run_opts = {
     +			.tr2_category = "fetch",
     +			.tr2_label = "parallel/fetch",
    ++
    ++			.jobs = max_children,
    ++
    ++			.get_next_task = &fetch_next_remote,
    ++			.start_failure = &fetch_failed_to_start,
    ++			.task_finished = &fetch_finished,
    ++			.data = &state,
     +		};
      
      		strvec_push(&argv, "--end-of-options");
    @@ builtin/fetch.c: static int fetch_multiple(struct string_list *list, int max_chi
     -						    &fetch_finished,
     -						    &state,
     -						    "fetch", "parallel/fetch");
    -+		result = run_processes_parallel(max_children,
    -+						&fetch_next_remote,
    -+						&fetch_failed_to_start,
    -+						&fetch_finished, &state,
    -+						&run_opts);
    ++		result = run_processes_parallel(&run_opts);
      
      		if (!result)
      			result = state.result;
    @@ builtin/submodule--helper.c: static int update_submodules(struct update_data *up
     +	struct run_process_parallel_opts run_opts = {
     +		.tr2_category = "submodule",
     +		.tr2_label = "parallel/update",
    ++
    ++		.get_next_task = update_clone_get_next_task,
    ++		.start_failure = update_clone_start_failure,
    ++		.task_finished = update_clone_task_finished,
    ++		.data = &suc,
     +	};
      
      	suc.update_data = update_data;
    @@ builtin/submodule--helper.c: static int update_submodules(struct update_data *up
     -				   update_clone_start_failure,
     -				   update_clone_task_finished, &suc, "submodule",
     -				   "parallel/update");
    -+	run_processes_parallel(suc.update_data->max_jobs,
    -+			       update_clone_get_next_task,
    -+			       update_clone_start_failure,
    -+			       update_clone_task_finished, &suc, &run_opts);
    ++	run_opts.jobs = suc.update_data->max_jobs;
    ++	run_processes_parallel(&run_opts);
      
      	/*
      	 * We saved the output and put it out all at once now.
     
      ## hook.c ##
     @@ hook.c: int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
    + 		.options = options,
    + 	};
      	const char *const hook_path = find_hook(hook_name);
    - 	int jobs = 1;
    +-	int jobs = 1;
    ++	const int jobs = 1;
      	int ret = 0;
     +	struct run_process_parallel_opts run_opts = {
     +		.tr2_category = "hook",
     +		.tr2_label = hook_name,
    ++
    ++		.jobs = jobs,
    ++
    ++		.get_next_task = pick_next_hook,
    ++		.start_failure = notify_start_failure,
    ++		.task_finished = notify_hook_finished,
    ++		.data = &cb_data,
     +	};
      
      	if (!options)
    @@ hook.c: int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
     -				   &cb_data,
     -				   "hook",
     -				   hook_name);
    -+	run_processes_parallel(jobs, pick_next_hook, notify_start_failure,
    -+			       notify_hook_finished, &cb_data, &run_opts);
    ++	run_processes_parallel(&run_opts);
      	ret = cb_data.rc;
      cleanup:
      	strbuf_release(&abs_path);
     
      ## run-command.c ##
    +@@ run-command.c: static void handle_children_on_signal(int signo)
    + }
    + 
    + static void pp_init(struct parallel_processes *pp,
    +-		    int n,
    +-		    get_next_task_fn get_next_task,
    +-		    start_failure_fn start_failure,
    +-		    task_finished_fn task_finished,
    +-		    void *data)
    ++		    struct run_process_parallel_opts *opts)
    + {
    + 	int i;
    ++	int n = opts->jobs;
    ++	void *data = opts->data;
    ++	get_next_task_fn get_next_task = opts->get_next_task;
    ++	start_failure_fn start_failure = opts->start_failure;
    ++	task_finished_fn task_finished = opts->task_finished;
    + 
    + 	if (n < 1)
    + 		n = online_cpus();
     @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp)
      	return result;
      }
    @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp)
     -			   start_failure_fn start_failure,
     -			   task_finished_fn task_finished,
     -			   void *pp_cb)
    -+static int run_processes_parallel_1(int n, get_next_task_fn get_next_task,
    -+				    start_failure_fn start_failure,
    -+				    task_finished_fn task_finished,
    -+				    void *pp_cb,
    -+				    struct run_process_parallel_opts *opts)
    ++int run_processes_parallel(struct run_process_parallel_opts *opts)
      {
      	int i, code;
      	int output_timeout = 100;
    + 	int spawn_cap = 4;
    + 	struct parallel_processes pp;
    ++	const char *tr2_category = opts->tr2_category;
    ++	const char *tr2_label = opts->tr2_label;
    ++	const int do_trace2 = tr2_category && tr2_label;
    ++	const int n = opts->jobs;
    + 
    +-	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb);
    ++	if (do_trace2)
    ++		trace2_region_enter_printf(tr2_category, tr2_label, NULL,
    ++					   "max:%d", ((n < 1) ? online_cpus()
    ++						      : n));
    ++
    ++	pp_init(&pp, opts);
    + 	while (1) {
    + 		for (i = 0;
    + 		    i < spawn_cap && !pp.shutdown &&
     @@ run-command.c: int run_processes_parallel(int n,
    - 	return 0;
    - }
    + 	}
      
    + 	pp_cleanup(&pp);
    +-	return 0;
    +-}
    +-
     -int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
     -			       start_failure_fn start_failure,
     -			       task_finished_fn task_finished, void *pp_cb,
     -			       const char *tr2_category, const char *tr2_label)
    -+static int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
    -+				      start_failure_fn start_failure,
    -+				      task_finished_fn task_finished,
    -+				      void *pp_cb,
    -+				      struct run_process_parallel_opts *opts)
    - {
    -+	const char *tr2_category = opts->tr2_category;
    -+	const char *tr2_label = opts->tr2_label;
    - 	int result;
    +-{
    +-	int result;
      
    - 	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
    - 				   ((n < 1) ? online_cpus() : n));
    +-	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
    +-				   ((n < 1) ? online_cpus() : n));
    ++	if (do_trace2)
    ++		trace2_region_leave(tr2_category, tr2_label, NULL);
      
     -	result = run_processes_parallel(n, get_next_task, start_failure,
     -					task_finished, pp_cb);
    -+	result = run_processes_parallel_1(n, get_next_task, start_failure,
    -+					  task_finished, pp_cb, opts);
    - 
    - 	trace2_region_leave(tr2_category, tr2_label, NULL);
    - 
    - 	return result;
    +-
    +-	trace2_region_leave(tr2_category, tr2_label, NULL);
    +-
    +-	return result;
    ++	return 0;
      }
      
    -+int run_processes_parallel(int n, get_next_task_fn get_next_task,
    -+			   start_failure_fn start_failure,
    -+			   task_finished_fn task_finished, void *pp_cb,
    -+			   struct run_process_parallel_opts *opts)
    -+{
    -+	if (opts->tr2_category && opts->tr2_label)
    -+		return run_processes_parallel_tr2(n, get_next_task,
    -+						  start_failure, task_finished,
    -+						  pp_cb, opts);
    -+
    -+	return run_processes_parallel_1(n, get_next_task, start_failure,
    -+					task_finished, pp_cb, opts);
    -+}
    -+
    -+
      int run_auto_maintenance(int quiet)
    - {
    - 	int enabled;
     
      ## run-command.h ##
     @@ run-command.h: typedef int (*task_finished_fn)(int result,
    - 				void *pp_cb,
      				void *pp_task_cb);
      
    -+/**
    + /**
     + * Options to pass to run_processes_parallel(), { 0 }-initialized
     + * means no options. Fields:
     + *
     + * tr2_category & tr2_label: sets the trace2 category and label for
     + * logging. These must either be unset, or both of them must be set.
    ++ *
    ++ * jobs: see 'n' in run_processes_parallel() below.
    ++ *
    ++ * *_fn & data: see run_processes_parallel() below.
     + */
     +struct run_process_parallel_opts
     +{
     +	const char *tr2_category;
     +	const char *tr2_label;
    ++
    ++	int jobs;
    ++
    ++	get_next_task_fn get_next_task;
    ++	start_failure_fn start_failure;
    ++	task_finished_fn task_finished;
    ++	void *data;
     +};
     +
    - /**
    ++/**
    ++ * Options are passed via the "struct run_process_parallel_opts" above.
    ++
       * Runs up to n processes at the same time. Whenever a process can be
       * started, the callback get_next_task_fn is called to obtain the data
    +  * required to start another child process.
     @@ run-command.h: typedef int (*task_finished_fn)(int result,
    -  *
       * start_failure_fn and task_finished_fn can be NULL to omit any
       * special handling.
    -+ *
    -+ * Options are passed via a "struct run_process_parallel_opts".
       */
     -int run_processes_parallel(int n,
     -			   get_next_task_fn,
    @@ run-command.h: typedef int (*task_finished_fn)(int result,
     -int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
     -			       task_finished_fn, void *pp_cb,
     -			       const char *tr2_category, const char *tr2_label);
    -+int run_processes_parallel(int n, get_next_task_fn, start_failure_fn,
    -+			   task_finished_fn, void *pp_cb,
    -+			   struct run_process_parallel_opts *opts);
    ++int run_processes_parallel(struct run_process_parallel_opts *opts);
      
      /**
       * Convenience function which prepares env_array for a command to be run in a
    @@ submodule.c: int fetch_submodules(struct repository *r,
     +	struct run_process_parallel_opts run_opts = {
     +		.tr2_category = "submodule",
     +		.tr2_label = "parallel/fetch",
    ++
    ++		.jobs = max_parallel_jobs,
    ++
    ++		.get_next_task = get_next_submodule,
    ++		.start_failure = fetch_start_failure,
    ++		.task_finished = fetch_finish,
    ++		.data = &spf,
     +	};
      
      	spf.r = r;
    @@ submodule.c: int fetch_submodules(struct repository *r,
     -				   fetch_finish,
     -				   &spf,
     -				   "submodule", "parallel/fetch");
    -+	run_processes_parallel(max_parallel_jobs, get_next_submodule,
    -+			       fetch_start_failure, fetch_finish, &spf,
    -+			       &run_opts);
    ++	run_processes_parallel(&run_opts);
      
      	if (spf.submodules_with_errors.len > 0)
      		fprintf(stderr, _("Errors during submodule fetch:\n%s"),
     
      ## t/helper/test-run-command.c ##
     @@ t/helper/test-run-command.c: static int testsuite(int argc, const char **argv)
    + 			 "write JUnit-style XML files"),
    + 		OPT_END()
    + 	};
    ++	struct run_process_parallel_opts run_opts = {
    ++		.get_next_task = next_test,
    ++		.start_failure = test_failed,
    ++		.task_finished = test_finished,
    ++		.data = &suite,
    ++	};
    + 
    + 	argc = parse_options(argc, argv, NULL, options,
    + 			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
    +@@ t/helper/test-run-command.c: static int testsuite(int argc, const char **argv)
    + 
    + 	fprintf(stderr, "Running %"PRIuMAX" tests (%d at a time)\n",
      		(uintmax_t)suite.tests.nr, max_jobs);
    ++	run_opts.jobs = max_jobs;
      
    - 	ret = run_processes_parallel(max_jobs, next_test, test_failed,
    +-	ret = run_processes_parallel(max_jobs, next_test, test_failed,
     -				     test_finished, &suite);
    -+				     test_finished, &suite, NULL);
    ++	ret = run_processes_parallel(&run_opts);
      
      	if (suite.failed.nr > 0) {
      		ret = 1;
     @@ t/helper/test-run-command.c: int cmd__run_command(int argc, const char **argv)
    - {
    - 	struct child_process proc = CHILD_PROCESS_INIT;
      	int jobs;
    + 	get_next_task_fn next_fn = NULL;
    + 	task_finished_fn finished_fn = NULL;
     +	struct run_process_parallel_opts opts = { 0 };
      
      	if (argc > 1 && !strcmp(argv[1], "testsuite"))
      		exit(testsuite(argc - 1, argv + 1));
     @@ t/helper/test-run-command.c: int cmd__run_command(int argc, const char **argv)
    + 	jobs = atoi(argv[2]);
    + 	strvec_clear(&proc.args);
    + 	strvec_pushv(&proc.args, (const char **)argv + 3);
    ++	opts.jobs = jobs;
    ++	opts.data = &proc;
      
    - 	if (!strcmp(argv[1], "run-command-parallel"))
    - 		exit(run_processes_parallel(jobs, parallel_next,
    --					    NULL, NULL, &proc));
    -+					    NULL, NULL, &proc, &opts));
    - 
    - 	if (!strcmp(argv[1], "run-command-abort"))
    --		exit(run_processes_parallel(jobs, parallel_next,
    --					    NULL, task_finished, &proc));
    -+		exit(run_processes_parallel(jobs, parallel_next, NULL,
    -+					    task_finished, &proc, &opts));
    - 
    - 	if (!strcmp(argv[1], "run-command-no-jobs"))
    --		exit(run_processes_parallel(jobs, no_job,
    --					    NULL, task_finished, &proc));
    -+		exit(run_processes_parallel(jobs, no_job, NULL, task_finished,
    -+					    &proc, &opts));
    + 	if (!strcmp(argv[1], "run-command-parallel")) {
    + 		next_fn = parallel_next;
    +@@ t/helper/test-run-command.c: int cmd__run_command(int argc, const char **argv)
    + 		return 1;
    + 	}
      
    - 	fprintf(stderr, "check usage\n");
    - 	return 1;
    +-	exit(run_processes_parallel(jobs, next_fn, NULL, finished_fn, &proc));
    ++	opts.get_next_task = next_fn;
    ++	opts.task_finished = finished_fn;
    ++	exit(run_processes_parallel(&opts));
    + }
2:  d9c9b158130 ! 3:  a8e1fc07b65 run-command tests: test stdout of run_command_parallel()
    @@ t/t0061-run-command.sh: World
      
      test_expect_success 'run_command runs in parallel with more jobs available than tasks' '
     -	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
    -+	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
    +-	test_cmp expect actual
    ++	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
     +	test_must_be_empty out &&
    - 	test_cmp expect actual
    ++	test_cmp expect err
      '
      
      test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
     -	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
    -+	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
    +-	test_cmp expect actual
    ++	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
     +	test_must_be_empty out &&
    - 	test_cmp expect actual
    ++	test_cmp expect err
      '
      
      test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
     -	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
    -+	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
    +-	test_cmp expect actual
    ++	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
     +	test_must_be_empty out &&
    - 	test_cmp expect actual
    ++	test_cmp expect err
      '
      
    + cat >expect <<-EOF
     @@ t/t0061-run-command.sh: asking for a quick stop
      EOF
      
      test_expect_success 'run_command is asked to abort gracefully' '
     -	test-tool run-command run-command-abort 3 false 2>actual &&
    -+	test-tool run-command run-command-abort 3 false >out 2>actual &&
    +-	test_cmp expect actual
    ++	test-tool run-command run-command-abort 3 false >out 2>err &&
     +	test_must_be_empty out &&
    - 	test_cmp expect actual
    ++	test_cmp expect err
      '
      
    + cat >expect <<-EOF
     @@ t/t0061-run-command.sh: no further jobs available
      EOF
      
      test_expect_success 'run_command outputs ' '
     -	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
    -+	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
    +-	test_cmp expect actual
    ++	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
     +	test_must_be_empty out &&
    - 	test_cmp expect actual
    ++	test_cmp expect err
      '
      
    + test_trace () {
-:  ----------- > 4:  663936fb4ad run-command.c: add an initializer for "struct parallel_processes"
3:  d76f63c2948 ! 5:  c2e015ed840 run-command: add an "ungroup" option to run_process_parallel()
    @@ run-command.c: struct parallel_processes {
      	struct pollfd *pfd;
      
      	unsigned shutdown : 1;
    -+	unsigned ungroup:1;
    ++	unsigned ungroup : 1;
      
      	int output_owner;
      	struct strbuf buffered_output; /* of finished children */
     @@ run-command.c: static void pp_init(struct parallel_processes *pp,
    - 		    get_next_task_fn get_next_task,
    - 		    start_failure_fn start_failure,
    - 		    task_finished_fn task_finished,
    --		    void *data)
    -+		    void *data, struct run_process_parallel_opts *opts)
    - {
    -+	const int ungroup = opts->ungroup;
    - 	int i;
    - 
    - 	if (n < 1)
    -@@ run-command.c: static void pp_init(struct parallel_processes *pp,
    - 	pp->start_failure = start_failure ? start_failure : default_start_failure;
    - 	pp->task_finished = task_finished ? task_finished : default_task_finished;
    - 
    -+	pp->ungroup = ungroup;
    -+
      	pp->nr_processes = 0;
      	pp->output_owner = 0;
      	pp->shutdown = 0;
    ++	pp->ungroup = opts->ungroup;
      	CALLOC_ARRAY(pp->children, n);
     -	CALLOC_ARRAY(pp->pfd, n);
    -+	if (!ungroup)
    ++	if (!pp->ungroup)
     +		CALLOC_ARRAY(pp->pfd, n);
    -+
    - 	strbuf_init(&pp->buffered_output, 0);
      
      	for (i = 0; i < n; i++) {
      		strbuf_init(&pp->children[i].err, 0);
      		child_process_init(&pp->children[i].process);
    -+		if (ungroup)
    ++		if (!pp->pfd)
     +			continue;
      		pp->pfd[i].events = POLLIN | POLLHUP;
      		pp->pfd[i].fd = -1;
      	}
    -@@ run-command.c: static void pp_init(struct parallel_processes *pp,
    - 
    - static void pp_cleanup(struct parallel_processes *pp)
    - {
    -+	const int ungroup = pp->ungroup;
    - 	int i;
    - 
    - 	trace_printf("run_processes_parallel: done");
     @@ run-command.c: static void pp_cleanup(struct parallel_processes *pp)
    - 	}
    - 
    - 	free(pp->children);
    --	free(pp->pfd);
    -+	if (!ungroup)
    -+		free(pp->pfd);
    - 
    - 	/*
      	 * When get_next_task added messages to the buffer in its last
      	 * iteration, the buffered output is non empty.
      	 */
     -	strbuf_write(&pp->buffered_output, stderr);
    --	strbuf_release(&pp->buffered_output);
    -+	if (!ungroup) {
    ++	if (!pp->ungroup)
     +		strbuf_write(&pp->buffered_output, stderr);
    -+		strbuf_release(&pp->buffered_output);
    -+	}
    + 	strbuf_release(&pp->buffered_output);
      
      	sigchain_pop_common();
    - }
     @@ run-command.c: static void pp_cleanup(struct parallel_processes *pp)
       */
      static int pp_start_one(struct parallel_processes *pp)
    @@ run-command.c: static int pp_start_one(struct parallel_processes *pp)
      	}
     -	pp->children[i].process.err = -1;
     -	pp->children[i].process.stdout_to_stderr = 1;
    --	pp->children[i].process.no_stdin = 1;
    -+
     +	if (!ungroup) {
     +		pp->children[i].process.err = -1;
     +		pp->children[i].process.stdout_to_stderr = 1;
    -+		pp->children[i].process.no_stdin = 1;
     +	}
    + 	pp->children[i].process.no_stdin = 1;
      
      	if (start_command(&pp->children[i].process)) {
     -		code = pp->start_failure(&pp->children[i].err,
    @@ run-command.c: static int pp_start_one(struct parallel_processes *pp)
      	pp->nr_processes++;
      	pp->children[i].state = GIT_CP_WORKING;
     -	pp->pfd[i].fd = pp->children[i].process.err;
    -+	if (!ungroup)
    ++	if (pp->pfd)
     +		pp->pfd[i].fd = pp->children[i].process.err;
      	return 0;
      }
    @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp)
      		pp->nr_processes--;
      		pp->children[i].state = GIT_CP_FREE;
     -		pp->pfd[i].fd = -1;
    -+		if (!ungroup)
    ++		if (pp->pfd)
     +			pp->pfd[i].fd = -1;
      		child_process_init(&pp->children[i].process);
      
     -		if (i != pp->output_owner) {
     +		if (ungroup) {
    -+			/* no strbuf_*() work to do here */
    ++			; /* no strbuf_*() work to do here */
     +		} else if (i != pp->output_owner) {
      			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
      			strbuf_reset(&pp->children[i].err);
      		} else {
    -@@ run-command.c: static int run_processes_parallel_1(int n, get_next_task_fn get_next_task,
    - 				    void *pp_cb,
    - 				    struct run_process_parallel_opts *opts)
    - {
    -+	const int ungroup = opts->ungroup;
    - 	int i, code;
    - 	int output_timeout = 100;
    - 	int spawn_cap = 4;
    - 	struct parallel_processes pp;
    - 
    --	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb);
    -+	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
    -+		opts);
    - 	while (1) {
    - 		for (i = 0;
    - 		    i < spawn_cap && !pp.shutdown &&
    -@@ run-command.c: static int run_processes_parallel_1(int n, get_next_task_fn get_next_task,
    +@@ run-command.c: int run_processes_parallel(struct run_process_parallel_opts *opts)
      		}
      		if (!pp.nr_processes)
      			break;
     -		pp_buffer_stderr(&pp, output_timeout);
     -		pp_output(&pp);
    -+		if (ungroup) {
    ++		if (opts->ungroup) {
     +			pp_mark_working_for_cleanup(&pp);
     +		} else {
     +			pp_buffer_stderr(&pp, output_timeout);
    @@ run-command.h: typedef int (*start_failure_fn)(struct strbuf *out,
       * pp_task_cb is the callback cookie as passed into get_next_task_fn.
     @@ run-command.h: typedef int (*task_finished_fn)(int result,
       *
    -  * tr2_category & tr2_label: sets the trace2 category and label for
    -  * logging. These must either be unset, or both of them must be set.
    -+ *
    +  * jobs: see 'n' in run_processes_parallel() below.
    +  *
     + * ungroup: Ungroup output. Output is printed as soon as possible and
     + * bypasses run-command's internal processing. This may cause output
     + * from different commands to be mixed.
    ++ *
    +  * *_fn & data: see run_processes_parallel() below.
       */
      struct run_process_parallel_opts
    - {
    - 	const char *tr2_category;
    +@@ run-command.h: struct run_process_parallel_opts
      	const char *tr2_label;
    + 
    + 	int jobs;
     +	unsigned int ungroup:1;
    - };
      
    - /**
    + 	get_next_task_fn get_next_task;
    + 	start_failure_fn start_failure;
     @@ run-command.h: struct run_process_parallel_opts
       *
       * The children started via this function run in parallel. Their output
    @@ run-command.h: struct run_process_parallel_opts
       *
       * start_failure_fn and task_finished_fn can be NULL to omit any
       * special handling.
    -  *
    -- * Options are passed via a "struct run_process_parallel_opts".
    -+ * Options are passed via a "struct run_process_parallel_opts". If the
    -+ * "ungroup" option isn't specified the callbacks will get a pointer
    -+ * to a "struct strbuf *out", and must not write to stdout or stderr
    -+ * as such output will mess up the output of the other parallel
    ++ *
    ++ * If the "ungroup" option isn't specified the callbacks will get a
    ++ * pointer to a "struct strbuf *out", and must not write to stdout or
    ++ * stderr as such output will mess up the output of the other parallel
     + * processes. If "ungroup" option is specified callbacks will get a
     + * NULL "struct strbuf *out" parameter, and are responsible for
     + * emitting their own output, including dealing with any race
     + * conditions due to writing in parallel to stdout and stderr.
       */
    - int run_processes_parallel(int n, get_next_task_fn, start_failure_fn,
    - 			   task_finished_fn, void *pp_cb,
    + int run_processes_parallel(struct run_process_parallel_opts *opts);
    + 
     
      ## t/helper/test-run-command.c ##
     @@ t/helper/test-run-command.c: static int parallel_next(struct child_process *cp,
    @@ t/helper/test-run-command.c: static int task_finished(int result,
      }
      
     @@ t/helper/test-run-command.c: int cmd__run_command(int argc, const char **argv)
    - 	strvec_clear(&proc.args);
    - 	strvec_pushv(&proc.args, (const char **)argv + 3);
    + 	opts.jobs = jobs;
    + 	opts.data = &proc;
      
    --	if (!strcmp(argv[1], "run-command-parallel"))
    +-	if (!strcmp(argv[1], "run-command-parallel")) {
     +	if (!strcmp(argv[1], "run-command-parallel") ||
     +	    !strcmp(argv[1], "run-command-parallel-ungroup")) {
    -+		opts.ungroup = !strcmp(argv[1], "run-command-parallel-ungroup");
    - 		exit(run_processes_parallel(jobs, parallel_next,
    - 					    NULL, NULL, &proc, &opts));
    -+	}
    - 
    --	if (!strcmp(argv[1], "run-command-abort"))
    -+	if (!strcmp(argv[1], "run-command-abort") ||
    -+	    !strcmp(argv[1], "run-command-abort-ungroup")) {
    -+		opts.ungroup = !strcmp(argv[1], "run-command-abort-ungroup");
    - 		exit(run_processes_parallel(jobs, parallel_next, NULL,
    - 					    task_finished, &proc, &opts));
    -+	}
    - 
    --	if (!strcmp(argv[1], "run-command-no-jobs"))
    -+	if (!strcmp(argv[1], "run-command-no-jobs") ||
    -+	    !strcmp(argv[1], "run-command-no-jobs-ungroup")) {
    -+		opts.ungroup = !strcmp(argv[1], "run-command-no-jobs-ungroup");
    - 		exit(run_processes_parallel(jobs, no_job, NULL, task_finished,
    - 					    &proc, &opts));
    -+	}
    + 		next_fn = parallel_next;
    +-	} else if (!strcmp(argv[1], "run-command-abort")) {
    ++	} else if (!strcmp(argv[1], "run-command-abort") ||
    ++		   !strcmp(argv[1], "run-command-abort-ungroup")) {
    + 		next_fn = parallel_next;
    + 		finished_fn = task_finished;
    +-	} else if (!strcmp(argv[1], "run-command-no-jobs")) {
    ++	} else if (!strcmp(argv[1], "run-command-no-jobs") ||
    ++		   !strcmp(argv[1], "run-command-no-jobs-ungroup")) {
    + 		next_fn = no_job;
    + 		finished_fn = task_finished;
    + 	} else {
    +@@ t/helper/test-run-command.c: int cmd__run_command(int argc, const char **argv)
    + 		return 1;
    + 	}
      
    - 	fprintf(stderr, "check usage\n");
    - 	return 1;
    ++	opts.ungroup = ends_with(argv[1], "-ungroup");
    + 	opts.get_next_task = next_fn;
    + 	opts.task_finished = finished_fn;
    + 	exit(run_processes_parallel(&opts));
     
      ## t/t0061-run-command.sh ##
     @@ t/t0061-run-command.sh: test_expect_success 'run_command runs in parallel with more jobs available than
    - 	test_cmp expect actual
    + 	test_cmp expect err
      '
      
     +test_expect_success 'run_command runs ungrouped in parallel with more jobs available than tasks' '
    @@ t/t0061-run-command.sh: test_expect_success 'run_command runs in parallel with m
     +'
     +
      test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
    - 	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
    + 	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
      	test_must_be_empty out &&
    - 	test_cmp expect actual
    + 	test_cmp expect err
      '
      
     +test_expect_success 'run_command runs ungrouped in parallel with as many jobs as tasks' '
    @@ t/t0061-run-command.sh: test_expect_success 'run_command runs in parallel with m
     +'
     +
      test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
    - 	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
    + 	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
      	test_must_be_empty out &&
    - 	test_cmp expect actual
    + 	test_cmp expect err
      '
      
     +test_expect_success 'run_command runs ungrouped in parallel with more tasks than jobs available' '
    @@ t/t0061-run-command.sh: test_expect_success 'run_command runs in parallel with m
      preloaded output of a child
      asking for a quick stop
     @@ t/t0061-run-command.sh: test_expect_success 'run_command is asked to abort gracefully' '
    - 	test_cmp expect actual
    + 	test_cmp expect err
      '
      
     +test_expect_success 'run_command is asked to abort gracefully (ungroup)' '
    @@ t/t0061-run-command.sh: test_expect_success 'run_command is asked to abort grace
      no further jobs available
      EOF
     @@ t/t0061-run-command.sh: test_expect_success 'run_command outputs ' '
    - 	test_cmp expect actual
    + 	test_cmp expect err
      '
      
     +test_expect_success 'run_command outputs (ungroup) ' '
    -+	test-tool run-command run-command-no-jobs-ungroup 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
    ++	test-tool run-command run-command-no-jobs-ungroup 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
     +	test_must_be_empty out &&
    -+	test_cmp expect actual
    ++	test_cmp expect err
     +'
     +
      test_trace () {
4:  cf62569b2e0 = 6:  84e92c6f7c7 hook tests: fix redirection logic error in 96e7225b310
5:  98c26c9917b ! 7:  bf7d871565f hook API: don't redundantly re-set "no_stdin" and "stdout_to_stderr"
    @@ Commit message
         hook API: don't redundantly re-set "no_stdin" and "stdout_to_stderr"
     
         Amend code added in 96e7225b310 (hook: add 'run' subcommand,
    -    2021-12-22) top stop setting these two flags. We use the
    +    2021-12-22) to stop setting these two flags. We use the
         run_process_parallel() API added in c553c72eed6 (run-command: add an
         asynchronous parallel child processor, 2015-12-15), which always sets
         these in pp_start_one() (in addition to setting .err = -1).
6:  de3664f6d2b ! 8:  238155fcb9d hook API: fix v2.36.0 regression: hooks should be connected to a TTY
    @@ Commit message
                   './git hook run seq-hook' in 'HEAD~0' ran
                     1.30 ± 0.02 times faster than './git hook run seq-hook' in 'origin/master'
     
    -    In the preceding commit we removed the "no_stdin=1" and
    -    "stdout_to_stderr=1" assignments. This change brings them back as with
    -    ".ungroup=1" the run_process_parallel() function doesn't provide them
    -    for us implicitly.
    +    In the preceding commit we removed the "stdout_to_stderr=1" assignment
    +    as being redundant. This change brings it back as with ".ungroup=1"
    +    the run_process_parallel() function doesn't provide them for us
    +    implicitly.
     
         As an aside omitting the stdout_to_stderr=1 here would have all tests
         pass, except those that test "git hook run" itself in
    @@ Commit message
     
      ## hook.c ##
     @@ hook.c: static int pick_next_hook(struct child_process *cp,
    - 	if (!hook_path)
      		return 0;
      
    -+	cp->no_stdin = 1;
      	strvec_pushv(&cp->env_array, hook_cb->options->env.v);
    -+	cp->stdout_to_stderr = 1;
    ++	cp->stdout_to_stderr = 1; /* because of .ungroup = 1 */
      	cp->trace2_hook_name = hook_cb->hook_name;
      	cp->dir = hook_cb->options->dir;
      
     @@ hook.c: int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
    - 		.options = options,
    - 	};
    - 	const char *const hook_path = find_hook(hook_name);
    --	int jobs = 1;
    -+	const int jobs = 1;
    - 	int ret = 0;
    - 	struct run_process_parallel_opts run_opts = {
    - 		.tr2_category = "hook",
      		.tr2_label = hook_name,
    + 
    + 		.jobs = jobs,
     +		.ungroup = jobs == 1,
    - 	};
      
    + 		.get_next_task = pick_next_hook,
    + 		.start_failure = notify_start_failure,
    +@@ hook.c: int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
      	if (!options)
      		BUG("a struct run_hooks_opt must be provided to run_hooks");
      
-- 
2.36.1.952.g0ae626f6cd7

