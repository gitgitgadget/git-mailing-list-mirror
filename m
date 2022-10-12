Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBE9C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiJLJBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJLJBl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:01:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C389273308
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:37 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j16so25242579wrh.5
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fz5E1XC2OmTfKWT7BfP0NNJzvNY6pFIlNmx0X2eP9mg=;
        b=GW5wVqU1dHLwXqSxMLsBDRay8utVspXgn7UB8X95l9TKsZVcjnpMHL3BP8gqEWMyqk
         uCcY6GudWkMsnnAo/TqeKCMhuM1PE+JmdjYxXcnghW5H9UGRjThBnBM1kl5RASD2zgpE
         f/UI8P8UddOtsMFd822sxKbuXlT6NtSHhjNoAgIFt3h88AL+SYYCm1AFi5kZt5mOfOZK
         Rf4fRnFpjT8QS2+fhOrt5yMSQ1qRanzbNjSh5Um1zorBaQnfO1hRSAkj7odG/Yp9JjSf
         TaMfrxucIMIszYAs0qcw0GLM5wptY5eM5xPEKzb2k9Emlw9HS5RLdCzBc3MfEU4KfUOj
         w3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fz5E1XC2OmTfKWT7BfP0NNJzvNY6pFIlNmx0X2eP9mg=;
        b=7ocCYTe8CdS3ggPMsDAPJvO52LzHSJvHUTygWdmq3eHip23pjOa3Kr51m4ZlA3A3Wq
         KziKdcnaVjnnO5HUCFaSX64897sNi1BdOuGkchpk7F18PFOaAfjo/LO0h3XXgX5fWEpj
         OgXLVNwx6dFQs3s9pz6CGUr1YTuL2H5iNPetjRrTNGBZozNO6ygf0XtWY1yEyZ04hsuG
         ISklvWl0fjaEJgR0AAl3TwVr0Nyz4AYeu7FjEVPhNtAReWDR8mKJEIUB3rXV8jIX4y8C
         QOeRMLKt2eBdgEi5B9KLtEckG2lvk+DzyfnndWT7OEujeY4GrLK7J+37RO/EE/Z6V6k/
         +7tQ==
X-Gm-Message-State: ACrzQf3/NSLcgflK5Uv96oMeRJ/jXLHP3+K+HjW2fjNOoI8lvqRBPE3m
        Xh630gcO88s9PBEwvOjov61yTCUYP/ntiw==
X-Google-Smtp-Source: AMsMyM7bHRZwmOv0ax+yZIGhPz2gXRgMvN5uQQpmQVWb1pk72EuMAOZWVBTwl3Eu2vlnCrEU1A2JAQ==
X-Received: by 2002:a5d:6484:0:b0:230:7cad:c268 with SMTP id o4-20020a5d6484000000b002307cadc268mr9644886wri.335.1665565295191;
        Wed, 12 Oct 2022 02:01:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:01:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/22] run-command API: pass functions & opts via struct
Date:   Wed, 12 Oct 2022 11:01:08 +0200
Message-Id: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series changes the run-command API so that we pass options via a
struct instead of via the argument list, the end result is that an API
user looks like e.g.:

     +       const struct run_process_parallel_opts opts = {
     +               .tr2_category = "submodule",
     +               .tr2_label = "parallel/update",
     +
     +               .processes = update_data->max_jobs,
     +
     +               .get_next_task = update_clone_get_next_task,
     +               .start_failure = update_clone_start_failure,
     +               .task_finished = update_clone_task_finished,
     +               .data = &suc,
     +       };
     [...]
     -       run_processes_parallel_tr2(suc.update_data->max_jobs, update_clone_get_next_task,
     -                                  update_clone_start_failure,
     -                                  update_clone_task_finished, &suc, "submodule",
     -                                  "parallel/update");
     +       run_processes_parallel(&opts);

For v1 see
https://lore.kernel.org/git/cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com/;
Changes since v1 (inline comments on listed patches) 

For (passing CI) & a branch for this:
https://github.com/avar/git/tree/avar/hook-run-process-parallel-tty-regression-2-argument-passing-2

I've locally rebased Calvin's
https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/
on this, which is based on v1 of this series. There are conflicts, but
they're trivial/easy to solve.

Ævar Arnfjörð Bjarmason (22):
  hook tests: fix redirection logic error in 96e7225b310
  submodule tests: reset "trace.out" between "grep" invocations
  run-command tests: test stdout of run_command_parallel()
  run-command test helper: use "else if" pattern

These are the same.

  run-command API: have "run_processes_parallel{,_tr2}()" return void

Early test change needed to exit(), before we adjust exit() behavior.

  run-command tests: use "return", not "exit"

Ditto.

  run-command.c: remove dead assignment in while-loop
  run-command.c: use C99 "for (TYPE VAR = ..." syntax where useful

These two are new, the C99 for-loop syntax isn't just being used
willy-nilly, but as we were changing a previous "int i" to a "int" and
a "size_t" in some cases this really made things simpler, the
alternative being to split "i" into "i", "j" etc.

  run-command API: make "n" parameter a "size_t"

That "n" to "size_t" change, which the preceding change was prepping
for.

  run-command API: don't fall back on online_cpus()

Phillip Wood wondered why we couldn't keep this, hopefully the later
parts of the series now make the case for it, i.e. we can now nicely
pass all parameters "const" all the way down (not at this point, but
soon...).

  run-command.c: use designated init for pp_init(), add "const"

Starting some of that "const"-ing.

  run-command API: add nascent "struct run_process_parallel_opts"

Renamed the .jobs member to .processes, per feedback.

  run-command API: make run_process_parallel{,_tr2}() thin wrappers
  run-command API: have run_process_parallel() take an "opts" struct
  run-command API: move *_tr2() users to "run_processes_parallel()"
  run-command.c: make "struct parallel_processes" const if possible

Mostly rebasing changes on the above.

  run-command.c: don't copy *_fn to "struct parallel_processes"
  run-command.c: don't copy "ungroup" to "struct parallel_processes"
  run-command.c: don't copy "data" to "struct parallel_processes"
  run-command.c: use "opts->processes", not "pp->max_processes"
  run-command.c: pass "opts" further down, and use "opts->processes"

Only the "ungroup" was here in v1, these all make the API much easier
to extend, as we don't need to copy various data as boilerplate, and
make the ownership clearer.

  run-command.c: remove "pp->max_processes", add "const" to signal()
    handler

In particular here we narrow down a special-case where the signal
handler needs different const-ing.

 builtin/fetch.c             |  25 ++--
 builtin/submodule--helper.c |  16 ++-
 hook.c                      |  23 ++--
 run-command.c               | 249 ++++++++++++++++--------------------
 run-command.h               |  71 +++++++---
 submodule-config.c          |   2 +
 submodule.c                 |  18 ++-
 t/helper/test-run-command.c |  77 +++++++----
 t/t0061-run-command.sh      |  25 ++--
 t/t1800-hook.sh             |   2 +-
 t/t5526-fetch-submodules.sh |  16 ++-
 11 files changed, 296 insertions(+), 228 deletions(-)

Range-diff against v1:
 1:  2e213e70038 =  1:  bc51dfcb1be hook tests: fix redirection logic error in 96e7225b310
 2:  605b15fceab =  2:  3027f5587a7 submodule tests: reset "trace.out" between "grep" invocations
 3:  d8042722e49 =  3:  c4923358bbd run-command tests: test stdout of run_command_parallel()
 4:  6d15fbe6c26 =  4:  26e28086252 run-command test helper: use "else if" pattern
 6:  c86dc59d07c !  5:  5e09dc68fd9 run-command API: have "run_processes_parallel{,_tr2}()" return void
    @@ t/helper/test-run-command.c: static int testsuite(int argc, const char **argv)
      
      	if (suite.failed.nr > 0) {
      		ret = 1;
    +@@ t/helper/test-run-command.c: int cmd__run_command(int argc, const char **argv)
    + 	strvec_pushv(&proc.args, (const char **)argv + 3);
    + 
    + 	if (!strcmp(argv[1], "run-command-parallel")) {
    +-		exit(run_processes_parallel(jobs, parallel_next,
    +-					    NULL, NULL, &proc));
    ++		run_processes_parallel(jobs, parallel_next, NULL, NULL, &proc);
    + 	} else if (!strcmp(argv[1], "run-command-abort")) {
    +-		exit(run_processes_parallel(jobs, parallel_next,
    +-					    NULL, task_finished, &proc));
    ++		run_processes_parallel(jobs, parallel_next, NULL,
    ++				       task_finished, &proc);
    + 	} else if (!strcmp(argv[1], "run-command-no-jobs")) {
    +-		exit(run_processes_parallel(jobs, no_job,
    +-					    NULL, task_finished, &proc));
    ++		run_processes_parallel(jobs, no_job, NULL, task_finished,
    ++				       &proc);
    + 	} else {
    + 		fprintf(stderr, "check usage\n");
    + 		return 1;
    + 	}
    ++	exit(0);
    + }
 5:  4ebbf6207fe !  6:  e4e91dbbf9e run-command tests: use "return", not "exit"
    @@ Commit message
         run-command tests: use "return", not "exit"
     
         Change the "run-command" test helper to "return" instead of calling
    -    "exit", see 338abb0f045 (builtins + test helpers: use return instead of exit() in cmd_*, 2021-06-08)
    +    "exit", see 338abb0f045 (builtins + test helpers: use return instead
    +    of exit() in cmd_*, 2021-06-08)
     
         Because we'd previously gotten past the SANITIZE=leak check by using
    -    exit() here we need to move to "goto cleanup" pattern. See
    -    fdc8f79f1f1 (leak tests: run various "test-tool" tests in t00*.sh
    -    SANITIZE=leak, 2021-10-12) for prior art. for when this code was opted
    -    into the "linux-leaks" job.
    +    exit() here we need to move to "goto cleanup" pattern.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/helper/test-run-command.c: int cmd__run_command(int argc, const char **argv)
      	if (!strcmp(argv[1], "--ungroup")) {
      		argv += 1;
     @@ t/helper/test-run-command.c: int cmd__run_command(int argc, const char **argv)
    - 	strvec_pushv(&proc.args, (const char **)argv + 3);
    - 
    - 	if (!strcmp(argv[1], "run-command-parallel")) {
    --		exit(run_processes_parallel(jobs, parallel_next,
    --					    NULL, NULL, &proc));
    -+		run_processes_parallel(jobs, parallel_next, NULL, NULL,
    -+				       &proc);
    - 	} else if (!strcmp(argv[1], "run-command-abort")) {
    --		exit(run_processes_parallel(jobs, parallel_next,
    --					    NULL, task_finished, &proc));
    -+		run_processes_parallel(jobs, parallel_next, NULL,
    -+				       task_finished, &proc);
    - 	} else if (!strcmp(argv[1], "run-command-no-jobs")) {
    --		exit(run_processes_parallel(jobs, no_job,
    --					    NULL, task_finished, &proc));
    -+		run_processes_parallel(jobs, no_job, NULL, task_finished,
    -+				       &proc);
    + 		run_processes_parallel(jobs, no_job, NULL, task_finished,
    + 				       &proc);
      	} else {
     +		ret = 1;
      		fprintf(stderr, "check usage\n");
     -		return 1;
     +		goto cleanup;
      	}
    +-	exit(0);
     +	ret = 0;
     +cleanup:
     +	child_process_clear(&proc);
 -:  ----------- >  7:  b90961ae76d run-command.c: remove dead assignment in while-loop
 -:  ----------- >  8:  279b0430c5d run-command.c: use C99 "for (TYPE VAR = ..." syntax where useful
 7:  a9810aaa852 !  9:  a900711270c run-command API: make "jobs" parameter an "unsigned int"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    run-command API: make "jobs" parameter an "unsigned int"
    +    run-command API: make "n" parameter a "size_t"
     
    -    The rename the "n" variable added in c553c72eed6 (run-command: add an
    -    asynchronous parallel child processor, 2015-12-15) to "jobs", and
    -    change the type to an "unsigned int". As we'll see in a subsequent
    -    commit we do pass "0" here, but never "jobs < 0".
    +    Make the "n" variable added in c553c72eed6 (run-command: add an
    +    asynchronous parallel child processor, 2015-12-15) a "size_t". As
    +    we'll see in a subsequent commit we do pass "0" here, but never "jobs
    +    < 0".
     
    -    The only users of the "jobs" parameter are:
    +    We could have made it an "unsigned int", but as we're having to change
    +    this let's not leave another case in the codebase where a size_t and
    +    "unsigned int" size differ on some platforms. In this case it's likely
    +    to never matter, but it's easier to not need to worry about it.
    +
    +    After this and preceding changes:
    +
    +            make run-command.o DEVOPTS=extra-all CFLAGS=-Wno-unused-parameter
    +
    +    Only has one (and new) -Wsigned-compare warning, about a comparison of
    +    "i" to online_cpus(), a subsequent commit will adjust & deal with
    +    online_cpus() and that warning.
    +
    +    The only users of the "n" parameter are:
     
          * builtin/fetch.c: defaults to 1, reads from the "fetch.parallel"
            config. As seen in the code that parses the config added in
            d54dea77dba (fetch: let --jobs=<n> parallelize --multiple, too,
            2019-10-05) will die if the git_config_int() return value is < 0.
     
    -       It will however pass us jobs = 0, as we'll see in a subsequent
    -       commit.
    +       It will however pass us n = 0, as we'll see in a subsequent commit.
     
          * submodule.c: defaults to 1, reads from "submodule.fetchJobs"
            config. Read via code originally added in a028a1930c6 (fetching
    @@ Commit message
            submodule.fetchjobs from submodule-config parsing, 2017-08-02).
     
            Like builtin/fetch.c it will die if the git_config_int() return
    -       value is < 0, but like builtin/fetch.c it will pass us jobs = 0.
    +       value is < 0, but like builtin/fetch.c it will pass us n = 0.
     
          * builtin/submodule--helper.c: defaults to 1. Read via code
            originally added in 2335b870fa7 (submodule update: expose parallelism
    @@ run-command.c: int run_processes_parallel_ungroup;
      
     -	int max_processes;
     -	int nr_processes;
    -+	unsigned int max_processes;
    -+	unsigned int nr_processes;
    ++	size_t max_processes;
    ++	size_t nr_processes;
      
      	get_next_task_fn get_next_task;
      	start_failure_fn start_failure;
    +@@ run-command.c: struct parallel_processes {
    + 	unsigned shutdown : 1;
    + 	unsigned ungroup : 1;
    + 
    +-	int output_owner;
    ++	size_t output_owner;
    + 	struct strbuf buffered_output; /* of finished children */
    + };
    + 
    +@@ run-command.c: static int default_task_finished(int result,
    + 
    + static void kill_children(struct parallel_processes *pp, int signo)
    + {
    +-	int i, n = pp->max_processes;
    +-
    +-	for (i = 0; i < n; i++)
    ++	for (size_t i = 0; i < pp->max_processes; i++)
    + 		if (pp->children[i].state == GIT_CP_WORKING)
    + 			kill(pp->children[i].process.pid, signo);
    + }
     @@ run-command.c: static void handle_children_on_signal(int signo)
      }
      
      static void pp_init(struct parallel_processes *pp,
     -		    int n,
    -+		    unsigned int jobs,
    ++		    size_t n,
      		    get_next_task_fn get_next_task,
      		    start_failure_fn start_failure,
      		    task_finished_fn task_finished,
      		    void *data, int ungroup)
      {
     -	int i;
    -+	unsigned int i;
    - 
    --	if (n < 1)
    --		n = online_cpus();
    -+	if (jobs < 1)
    -+		jobs = online_cpus();
    +-
    + 	if (n < 1)
    + 		n = online_cpus();
      
    --	pp->max_processes = n;
    -+	pp->max_processes = jobs;
    + 	pp->max_processes = n;
      
     -	trace_printf("run_processes_parallel: preparing to run up to %d tasks", n);
    -+	trace_printf("run_processes_parallel: preparing to run up to %d tasks",
    -+		     jobs);
    ++	trace_printf("run_processes_parallel: preparing to run up to %"PRIuMAX" tasks",
    ++		     (uintmax_t)n);
      
      	pp->data = data;
      	if (!get_next_task)
     @@ run-command.c: static void pp_init(struct parallel_processes *pp,
    - 	pp->output_owner = 0;
    - 	pp->shutdown = 0;
    - 	pp->ungroup = ungroup;
    --	CALLOC_ARRAY(pp->children, n);
    -+	CALLOC_ARRAY(pp->children, jobs);
    - 	if (pp->ungroup)
    - 		pp->pfd = NULL;
    - 	else
    --		CALLOC_ARRAY(pp->pfd, n);
    -+		CALLOC_ARRAY(pp->pfd, jobs);
    + 		CALLOC_ARRAY(pp->pfd, n);
      	strbuf_init(&pp->buffered_output, 0);
      
     -	for (i = 0; i < n; i++) {
    -+	for (i = 0; i < jobs; i++) {
    ++	for (size_t i = 0; i < n; i++) {
      		strbuf_init(&pp->children[i].err, 0);
      		child_process_init(&pp->children[i].process);
      		if (pp->pfd) {
    +@@ run-command.c: static void pp_init(struct parallel_processes *pp,
    + 
    + static void pp_cleanup(struct parallel_processes *pp)
    + {
    +-	int i;
    +-
    + 	trace_printf("run_processes_parallel: done");
    +-	for (i = 0; i < pp->max_processes; i++) {
    ++	for (size_t i = 0; i < pp->max_processes; i++) {
    + 		strbuf_release(&pp->children[i].err);
    + 		child_process_clear(&pp->children[i].process);
    + 	}
    +@@ run-command.c: static void pp_cleanup(struct parallel_processes *pp)
    +  */
    + static int pp_start_one(struct parallel_processes *pp)
    + {
    +-	int i, code;
    ++	size_t i;
    ++	int code;
    + 
    + 	for (i = 0; i < pp->max_processes; i++)
    + 		if (pp->children[i].state == GIT_CP_FREE)
    +@@ run-command.c: static int pp_start_one(struct parallel_processes *pp)
    + 
    + static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
    + {
    +-	int i;
    +-
    + 	while (poll(pp->pfd, pp->max_processes, output_timeout) < 0) {
    + 		if (errno == EINTR)
    + 			continue;
    +@@ run-command.c: static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
    + 	}
    + 
    + 	/* Buffer output from all pipes. */
    +-	for (i = 0; i < pp->max_processes; i++) {
    ++	for (size_t i = 0; i < pp->max_processes; i++) {
    + 		if (pp->children[i].state == GIT_CP_WORKING &&
    + 		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
    + 			int n = strbuf_read_once(&pp->children[i].err,
    +@@ run-command.c: static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
    + 
    + static void pp_output(struct parallel_processes *pp)
    + {
    +-	int i = pp->output_owner;
    ++	size_t i = pp->output_owner;
    + 
    + 	if (pp->children[i].state == GIT_CP_WORKING &&
    + 	    pp->children[i].err.len) {
    +@@ run-command.c: static void pp_output(struct parallel_processes *pp)
    + 
    + static int pp_collect_finished(struct parallel_processes *pp)
    + {
    +-	int i, code;
    +-	int n = pp->max_processes;
    ++	int code;
    ++	size_t i, n = pp->max_processes;
    + 	int result = 0;
    + 
    + 	while (pp->nr_processes > 0) {
     @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp)
      	return result;
      }
      
     -void run_processes_parallel(int n,
    -+void run_processes_parallel(unsigned int jobs,
    ++void run_processes_parallel(size_t n,
      			    get_next_task_fn get_next_task,
      			    start_failure_fn start_failure,
      			    task_finished_fn task_finished,
     @@ run-command.c: void run_processes_parallel(int n,
    - 	/* unset for the next API user */
    - 	run_processes_parallel_ungroup = 0;
    - 
    --	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
    -+	pp_init(&pp, jobs, get_next_task, start_failure, task_finished, pp_cb,
    - 		ungroup);
    - 	while (1) {
    - 		for (i = 0;
    + 		if (!pp.nr_processes)
    + 			break;
    + 		if (ungroup) {
    +-			int i;
    +-
    +-			for (i = 0; i < pp.max_processes; i++)
    ++			for (size_t i = 0; i < pp.max_processes; i++)
    + 				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
    + 		} else {
    + 			pp_buffer_stderr(&pp, output_timeout);
     @@ run-command.c: void run_processes_parallel(int n,
      	pp_cleanup(&pp);
      }
      
     -void run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
    -+void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_task,
    ++void run_processes_parallel_tr2(size_t n, get_next_task_fn get_next_task,
      				start_failure_fn start_failure,
      				task_finished_fn task_finished, void *pp_cb,
      				const char *tr2_category, const char *tr2_label)
    - {
    - 	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
    --				   ((n < 1) ? online_cpus() : n));
    -+				   ((jobs < 1) ? online_cpus() : jobs));
    - 
    --	run_processes_parallel(n, get_next_task, start_failure,
    -+	run_processes_parallel(jobs, get_next_task, start_failure,
    - 			       task_finished, pp_cb);
    - 
    - 	trace2_region_leave(tr2_category, tr2_label, NULL);
     
      ## run-command.h ##
    -@@ run-command.h: typedef int (*task_finished_fn)(int result,
    - 				void *pp_task_cb);
    - 
    - /**
    -- * Runs up to n processes at the same time. Whenever a process can be
    -+ * Runs up to 'jobs' processes at the same time. Whenever a process can be
    -  * started, the callback get_next_task_fn is called to obtain the data
    -  * required to start another child process.
    -  *
     @@ run-command.h: typedef int (*task_finished_fn)(int result,
       * API reads that setting.
       */
      extern int run_processes_parallel_ungroup;
     -void run_processes_parallel(int n,
    -+void run_processes_parallel(unsigned int jobs,
    ++void run_processes_parallel(size_t n,
      			    get_next_task_fn,
      			    start_failure_fn,
      			    task_finished_fn,
      			    void *pp_cb);
     -void run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
    -+void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn, start_failure_fn,
    ++void run_processes_parallel_tr2(size_t n, get_next_task_fn, start_failure_fn,
      				task_finished_fn, void *pp_cb,
      				const char *tr2_category, const char *tr2_label);
      
 8:  4223980f296 ! 10:  eb9d672b0d8 run-command API: don't fall back on online_cpus()
    @@ builtin/fetch.c: static int git_fetch_config(const char *k, const char *v, void
     
      ## run-command.c ##
     @@ run-command.c: static void pp_init(struct parallel_processes *pp,
    + 		    task_finished_fn task_finished,
    + 		    void *data, int ungroup)
      {
    - 	unsigned int i;
    +-	if (n < 1)
    +-		n = online_cpus();
    ++	if (!n)
    ++		BUG("you must provide a non-zero number of processes!");
      
    --	if (jobs < 1)
    --		jobs = online_cpus();
    -+	if (!jobs)
    -+		BUG("you must provide a non-zero number of jobs!");
    + 	pp->max_processes = n;
      
    - 	pp->max_processes = jobs;
    - 
    -@@ run-command.c: void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_tas
    +@@ run-command.c: void run_processes_parallel_tr2(size_t n, get_next_task_fn get_next_task,
    + 				task_finished_fn task_finished, void *pp_cb,
      				const char *tr2_category, const char *tr2_label)
      {
    - 	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
    --				   ((jobs < 1) ? online_cpus() : jobs));
    -+				   jobs);
    +-	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
    +-				   ((n < 1) ? online_cpus() : n));
    ++	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d", n);
      
    - 	run_processes_parallel(jobs, get_next_task, start_failure,
    + 	run_processes_parallel(n, get_next_task, start_failure,
      			       task_finished, pp_cb);
     
      ## submodule-config.c ##
 9:  015edcc42f9 ! 11:  aedda10d8e1 run-command.c: add an initializer for "struct parallel_processes"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    run-command.c: add an initializer for "struct parallel_processes"
    +    run-command.c: use designated init for pp_init(), add "const"
     
    -    Add a PARALLEL_PROCESSES_INIT macro for the "struct
    -    parallel_processes" used in run-command.c.
    +    Use a designated initializer to initialize those parts of pp_init()
    +    that don't need any conditionals for their initialization, this sets
    +    us on a path to pp_init() itself into mostly a validation and
    +    allocation function.
     
    -    This allows us to do away with a call to strbuf_init(), and to rely on
    -    other fields being NULL'd.
    +    Since we're doing that we can add "const" to some of the members of
    +    the "struct parallel_processes", which helps to clarify and
    +    self-document this code. E.g. we never alter the "data" pointer we
    +    pass t user callbacks, nor (after the preceding change to stop
    +    invoking online_cpus()) do we change "max_processes", the same goes
    +    for the "ungroup" option.
    +
    +    We can also do away with a call to strbuf_init() in favor of macro
    +    initialization, and to rely on other fields being NULL'd or zero'd.
    +
    +    Making members of a struct "const" rather that the pointer to the
    +    struct itself is usually painful, as e.g. it precludes us from
    +    incrementally setting up the structure. In this case we only set it up
    +    with the assignment in run_process_parallel() and pp_init(), and don't
    +    pass the struct pointer around as "const", so making individual
    +    members "const" is worth the potential hassle for extra safety.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## run-command.c ##
    +@@ run-command.c: enum child_state {
    + 
    + int run_processes_parallel_ungroup;
    + struct parallel_processes {
    +-	void *data;
    ++	void *const data;
    + 
    +-	size_t max_processes;
    ++	const size_t max_processes;
    + 	size_t nr_processes;
    + 
    + 	get_next_task_fn get_next_task;
     @@ run-command.c: struct parallel_processes {
    - 	int output_owner;
    + 	struct pollfd *pfd;
    + 
    + 	unsigned shutdown : 1;
    +-	unsigned ungroup : 1;
    ++	const unsigned ungroup : 1;
    + 
    + 	size_t output_owner;
      	struct strbuf buffered_output; /* of finished children */
    - };
    -+#define PARALLEL_PROCESSES_INIT { \
    -+	.buffered_output = STRBUF_INIT, \
    -+}
    +@@ run-command.c: static void handle_children_on_signal(int signo)
    + }
    + 
    + static void pp_init(struct parallel_processes *pp,
    +-		    size_t n,
    + 		    get_next_task_fn get_next_task,
    + 		    start_failure_fn start_failure,
    +-		    task_finished_fn task_finished,
    +-		    void *data, int ungroup)
    ++		    task_finished_fn task_finished)
    + {
    ++	const size_t n = pp->max_processes;
    ++
    + 	if (!n)
    + 		BUG("you must provide a non-zero number of processes!");
    + 
    +-	pp->max_processes = n;
    +-
    + 	trace_printf("run_processes_parallel: preparing to run up to %"PRIuMAX" tasks",
    + 		     (uintmax_t)n);
      
    - static int default_start_failure(struct strbuf *out,
    - 				 void *pp_cb,
    +-	pp->data = data;
    + 	if (!get_next_task)
    + 		BUG("you need to specify a get_next_task function");
    + 	pp->get_next_task = get_next_task;
     @@ run-command.c: static void pp_init(struct parallel_processes *pp,
    - 	pp->shutdown = 0;
    - 	pp->ungroup = ungroup;
    - 	CALLOC_ARRAY(pp->children, jobs);
    + 	pp->start_failure = start_failure ? start_failure : default_start_failure;
    + 	pp->task_finished = task_finished ? task_finished : default_task_finished;
    + 
    +-	pp->nr_processes = 0;
    +-	pp->output_owner = 0;
    +-	pp->shutdown = 0;
    +-	pp->ungroup = ungroup;
    + 	CALLOC_ARRAY(pp->children, n);
     -	if (pp->ungroup)
     -		pp->pfd = NULL;
     -	else
     +	if (!pp->ungroup)
    - 		CALLOC_ARRAY(pp->pfd, jobs);
    + 		CALLOC_ARRAY(pp->pfd, n);
     -	strbuf_init(&pp->buffered_output, 0);
      
    - 	for (i = 0; i < jobs; i++) {
    + 	for (size_t i = 0; i < n; i++) {
      		strbuf_init(&pp->children[i].err, 0);
    -@@ run-command.c: void run_processes_parallel(unsigned int jobs,
    +@@ run-command.c: void run_processes_parallel(size_t n,
      	int output_timeout = 100;
      	int spawn_cap = 4;
      	int ungroup = run_processes_parallel_ungroup;
     -	struct parallel_processes pp;
    -+	struct parallel_processes pp = PARALLEL_PROCESSES_INIT;
    ++	struct parallel_processes pp = {
    ++		.max_processes = n,
    ++		.data = pp_cb,
    ++		.buffered_output = STRBUF_INIT,
    ++		.ungroup = ungroup,
    ++	};
      
      	/* unset for the next API user */
      	run_processes_parallel_ungroup = 0;
    + 
    +-	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
    +-		ungroup);
    ++	pp_init(&pp, get_next_task, start_failure, task_finished);
    + 	while (1) {
    + 		for (int i = 0;
    + 		    i < spawn_cap && !pp.shutdown &&
10:  613ccb85fa2 ! 12:  fde2af11579 run-command API: add nascent "struct run_process_parallel_opts"
    @@ Commit message
         itself, as well as the "run_processes_parallel_tr2()" wrapper
         function.
     
    +    Since we need to change all of the occurrences of "n" to
    +    "opt->SOMETHING" let's take the opportunity and rename the terse "n"
    +    to "processes". We could also have picked "max_processes", "jobs",
    +    "threads" etc., but as the API is named "run_processes_parallel()"
    +    let's go with "processes".
    +
         1. https://lore.kernel.org/git/cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ run-command.c: static void handle_children_on_signal(int signo)
      }
      
      static void pp_init(struct parallel_processes *pp,
    --		    unsigned int jobs,
     -		    get_next_task_fn get_next_task,
     -		    start_failure_fn start_failure,
    --		    task_finished_fn task_finished,
    --		    void *data, int ungroup)
    +-		    task_finished_fn task_finished)
     +		    const struct run_process_parallel_opts *opts)
      {
    - 	unsigned int i;
    -+	void *data = opts->data;
    +-	const size_t n = pp->max_processes;
    ++	const size_t n = opts->processes;
     +	get_next_task_fn get_next_task = opts->get_next_task;
     +	start_failure_fn start_failure = opts->start_failure;
     +	task_finished_fn task_finished = opts->task_finished;
      
    --	if (!jobs)
    -+	if (!opts->jobs)
    - 		BUG("you must provide a non-zero number of jobs!");
    - 
    --	pp->max_processes = jobs;
    -+	pp->max_processes = opts->jobs;
    - 
    - 	trace_printf("run_processes_parallel: preparing to run up to %d tasks",
    --		     jobs);
    -+		     opts->jobs);
    - 
    - 	pp->data = data;
    - 	if (!get_next_task)
    -@@ run-command.c: static void pp_init(struct parallel_processes *pp,
    - 	pp->nr_processes = 0;
    - 	pp->output_owner = 0;
    - 	pp->shutdown = 0;
    --	pp->ungroup = ungroup;
    --	CALLOC_ARRAY(pp->children, jobs);
    -+	pp->ungroup = opts->ungroup;
    -+	CALLOC_ARRAY(pp->children, opts->jobs);
    - 	if (!pp->ungroup)
    --		CALLOC_ARRAY(pp->pfd, jobs);
    -+		CALLOC_ARRAY(pp->pfd, opts->jobs);
    + 	if (!n)
    + 		BUG("you must provide a non-zero number of processes!");
    +@@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp)
    + 	return result;
    + }
      
    --	for (i = 0; i < jobs; i++) {
    -+	for (i = 0; i < opts->jobs; i++) {
    - 		strbuf_init(&pp->children[i].err, 0);
    - 		child_process_init(&pp->children[i].process);
    - 		if (pp->pfd) {
    -@@ run-command.c: void run_processes_parallel(unsigned int jobs,
    - 	int i, code;
    +-void run_processes_parallel(size_t n,
    ++void run_processes_parallel(size_t processes,
    + 			    get_next_task_fn get_next_task,
    + 			    start_failure_fn start_failure,
    + 			    task_finished_fn task_finished,
    +@@ run-command.c: void run_processes_parallel(size_t n,
    + 	int code;
      	int output_timeout = 100;
      	int spawn_cap = 4;
     -	int ungroup = run_processes_parallel_ungroup;
    - 	struct parallel_processes pp = PARALLEL_PROCESSES_INIT;
    + 	struct parallel_processes pp = {
    +-		.max_processes = n,
    ++		.max_processes = processes,
    + 		.data = pp_cb,
    + 		.buffered_output = STRBUF_INIT,
    +-		.ungroup = ungroup,
    ++		.ungroup = run_processes_parallel_ungroup,
    ++	};
     +	const struct run_process_parallel_opts opts = {
    -+		.jobs = jobs,
    ++		.processes = processes,
    ++
     +		.get_next_task = get_next_task,
     +		.start_failure = start_failure,
     +		.task_finished = task_finished,
    ++
     +		.ungroup = run_processes_parallel_ungroup,
    -+		.data = pp_cb,
    -+	};
    + 	};
      
      	/* unset for the next API user */
      	run_processes_parallel_ungroup = 0;
      
    --	pp_init(&pp, jobs, get_next_task, start_failure, task_finished, pp_cb,
    --		ungroup);
    +-	pp_init(&pp, get_next_task, start_failure, task_finished);
     +	pp_init(&pp, &opts);
    ++
      	while (1) {
    - 		for (i = 0;
    + 		for (int i = 0;
      		    i < spawn_cap && !pp.shutdown &&
    -@@ run-command.c: void run_processes_parallel(unsigned int jobs,
    +@@ run-command.c: void run_processes_parallel(size_t n,
      		}
      		if (!pp.nr_processes)
      			break;
     -		if (ungroup) {
     +		if (opts.ungroup) {
    - 			int i;
    - 
    - 			for (i = 0; i < pp.max_processes; i++)
    + 			for (size_t i = 0; i < pp.max_processes; i++)
    + 				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
    + 		} else {
     
      ## run-command.h ##
     @@ run-command.h: typedef int (*task_finished_fn)(int result,
    - 				void *pp_cb,
      				void *pp_task_cb);
      
    -+/**
    + /**
    +- * Runs up to n processes at the same time. Whenever a process can be
     + * Option used by run_processes_parallel(), { 0 }-initialized means no
     + * options.
     + */
     +struct run_process_parallel_opts
     +{
     +	/**
    -+	 * jobs: see 'jobs' in run_processes_parallel() below.
    ++	 * processes: see 'processes' in run_processes_parallel() below.
     +	 */
    -+	int jobs;
    ++	size_t processes;
     +
     +	/**
     +	 * ungroup: see 'ungroup' in run_processes_parallel() below.
    @@ run-command.h: typedef int (*task_finished_fn)(int result,
     +	 * NULL to omit any special handling.
     +	 */
     +	task_finished_fn task_finished;
    -+
    -+	/**
    -+	 * data: user data, will be passed as "pp_cb" to the callback
    -+	 * parameters.
    -+	 */
    -+	void *data;
     +};
     +
    - /**
    -  * Runs up to 'jobs' processes at the same time. Whenever a process can be
    ++/**
    ++ * Runs N 'processes' at the same time. Whenever a process can be
       * started, the callback get_next_task_fn is called to obtain the data
    +  * required to start another child process.
    +  *
     @@ run-command.h: typedef int (*task_finished_fn)(int result,
       * (both stdout and stderr) is routed to stderr in a manner that output
       * from different tasks does not interleave (but see "ungroup" below).
    @@ run-command.h: typedef int (*task_finished_fn)(int result,
       * If the "ungroup" option isn't specified, the API will set the
       * "stdout_to_stderr" parameter in "struct child_process" and provide
       * the callbacks with a "struct strbuf *out" parameter to write output
    +@@ run-command.h: typedef int (*task_finished_fn)(int result,
    +  * API reads that setting.
    +  */
    + extern int run_processes_parallel_ungroup;
    +-void run_processes_parallel(size_t n,
    ++void run_processes_parallel(size_t processes,
    + 			    get_next_task_fn,
    + 			    start_failure_fn,
    + 			    task_finished_fn,
    + 			    void *pp_cb);
    +-void run_processes_parallel_tr2(size_t n, get_next_task_fn, start_failure_fn,
    +-				task_finished_fn, void *pp_cb,
    ++void run_processes_parallel_tr2(size_t processes, get_next_task_fn,
    ++				start_failure_fn, task_finished_fn, void *pp_cb,
    + 				const char *tr2_category, const char *tr2_label);
    + 
    + /**
11:  bad36eabfe9 ! 13:  01e894bed90 run-command API: make run_process_parallel{,_tr2}() thin wrappers
    @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp)
      	return result;
      }
      
    --void run_processes_parallel(unsigned int jobs,
    +-void run_processes_parallel(size_t processes,
     -			    get_next_task_fn get_next_task,
     -			    start_failure_fn start_failure,
     -			    task_finished_fn task_finished,
     -			    void *pp_cb)
    -+static void run_processes_parallel_1(const struct run_process_parallel_opts *opts)
    ++static void run_processes_parallel_1(const struct run_process_parallel_opts *opts, void *pp_cb)
      {
    - 	int i, code;
    + 	int code;
      	int output_timeout = 100;
      	int spawn_cap = 4;
    - 	struct parallel_processes pp = PARALLEL_PROCESSES_INIT;
    + 	struct parallel_processes pp = {
    +-		.max_processes = processes,
    ++		.max_processes = opts->processes,
    + 		.data = pp_cb,
    + 		.buffered_output = STRBUF_INIT,
    + 		.ungroup = run_processes_parallel_ungroup,
    + 	};
     -	const struct run_process_parallel_opts opts = {
    --		.jobs = jobs,
    +-		.processes = processes,
    +-
     -		.get_next_task = get_next_task,
     -		.start_failure = start_failure,
     -		.task_finished = task_finished,
    +-
     -		.ungroup = run_processes_parallel_ungroup,
    --		.data = pp_cb,
     -	};
     +	/* options */
     +	const char *tr2_category = opts->tr2_category;
    @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp)
     -	pp_init(&pp, &opts);
     +	if (do_trace2)
     +		trace2_region_enter_printf(tr2_category, tr2_label, NULL,
    -+					   "max:%d", opts->jobs);
    -+
    ++					   "max:%d", opts->processes);
    + 
     +	pp_init(&pp, opts);
      	while (1) {
    - 		for (i = 0;
    + 		for (int i = 0;
      		    i < spawn_cap && !pp.shutdown &&
    -@@ run-command.c: void run_processes_parallel(unsigned int jobs,
    +@@ run-command.c: void run_processes_parallel(size_t processes,
      		}
      		if (!pp.nr_processes)
      			break;
     -		if (opts.ungroup) {
     +		if (opts->ungroup) {
    - 			int i;
    - 
    - 			for (i = 0; i < pp.max_processes; i++)
    -@@ run-command.c: void run_processes_parallel(unsigned int jobs,
    + 			for (size_t i = 0; i < pp.max_processes; i++)
    + 				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
    + 		} else {
    +@@ run-command.c: void run_processes_parallel(size_t processes,
      	}
      
      	pp_cleanup(&pp);
    @@ run-command.c: void run_processes_parallel(unsigned int jobs,
     +		trace2_region_leave(tr2_category, tr2_label, NULL);
     +}
     +
    -+void run_processes_parallel(unsigned int jobs,
    ++void run_processes_parallel(size_t processes,
     +			    get_next_task_fn get_next_task,
     +			    start_failure_fn start_failure,
     +			    task_finished_fn task_finished,
     +			    void *pp_cb)
     +{
     +	const struct run_process_parallel_opts opts = {
    -+		.jobs = jobs,
    ++		.processes = processes,
     +		.ungroup = run_processes_parallel_ungroup,
     +
     +		.get_next_task = get_next_task,
     +		.start_failure = start_failure,
     +		.task_finished = task_finished,
    -+
    -+		.data = pp_cb,
     +	};
     +
    -+	run_processes_parallel_1(&opts);
    ++	run_processes_parallel_1(&opts, pp_cb);
      }
      
    - void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_task,
    -@@ run-command.c: void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_tas
    +-void run_processes_parallel_tr2(size_t n, get_next_task_fn get_next_task,
    ++void run_processes_parallel_tr2(size_t processes, get_next_task_fn get_next_task,
    + 				start_failure_fn start_failure,
      				task_finished_fn task_finished, void *pp_cb,
      				const char *tr2_category, const char *tr2_label)
      {
    --	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
    --				   jobs);
    +-	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d", n);
     +	const struct run_process_parallel_opts opts = {
     +		.tr2_category = tr2_category,
     +		.tr2_label = tr2_label,
     +
    -+		.jobs = jobs,
    ++		.processes = processes,
     +		.ungroup = run_processes_parallel_ungroup,
      
    --	run_processes_parallel(jobs, get_next_task, start_failure,
    +-	run_processes_parallel(n, get_next_task, start_failure,
     -			       task_finished, pp_cb);
     +		.get_next_task = get_next_task,
     +		.start_failure = start_failure,
     +		.task_finished = task_finished,
    -+
    -+		.data = pp_cb,
     +	};
      
     -	trace2_region_leave(tr2_category, tr2_label, NULL);
    -+	run_processes_parallel_1(&opts);
    ++	run_processes_parallel_1(&opts, pp_cb);
      }
      
      int run_auto_maintenance(int quiet)
    @@ run-command.h: typedef int (*task_finished_fn)(int result,
     +	const char *tr2_label;
     +
      	/**
    - 	 * jobs: see 'jobs' in run_processes_parallel() below.
    + 	 * processes: see 'processes' in run_processes_parallel() below.
      	 */
12:  eeaac80fbac ! 14:  41c2886b44b run-command API: have run_process_parallel() take an "opts" struct
    @@ hook.c: int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
     +		.tr2_category = "hook",
     +		.tr2_label = hook_name,
     +
    -+		.jobs = 1,
    ++		.processes = 1,
     +		.ungroup = 1,
     +
     +		.get_next_task = pick_next_hook,
    @@ run-command.c: enum child_state {
      
     -int run_processes_parallel_ungroup;
      struct parallel_processes {
    - 	void *data;
    + 	void *const data;
      
     @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp)
      	return result;
      }
      
    --static void run_processes_parallel_1(const struct run_process_parallel_opts *opts)
    +-static void run_processes_parallel_1(const struct run_process_parallel_opts *opts, void *pp_cb)
     +void run_processes_parallel(const struct run_process_parallel_opts *opts)
      {
    - 	int i, code;
    + 	int code;
      	int output_timeout = 100;
    -@@ run-command.c: static void run_processes_parallel_1(const struct run_process_parallel_opts *opt
    + 	int spawn_cap = 4;
    + 	struct parallel_processes pp = {
    + 		.max_processes = opts->processes,
    +-		.data = pp_cb,
    ++		.data = opts->data,
    + 		.buffered_output = STRBUF_INIT,
    +-		.ungroup = run_processes_parallel_ungroup,
    ++		.ungroup = opts->ungroup,
    + 	};
    + 	/* options */
    + 	const char *tr2_category = opts->tr2_category;
      	const char *tr2_label = opts->tr2_label;
      	const int do_trace2 = tr2_category && tr2_label;
      
    @@ run-command.c: static void run_processes_parallel_1(const struct run_process_par
     -
      	if (do_trace2)
      		trace2_region_enter_printf(tr2_category, tr2_label, NULL,
    - 					   "max:%d", opts->jobs);
    + 					   "max:%d", opts->processes);
     @@ run-command.c: static void run_processes_parallel_1(const struct run_process_parallel_opts *opt
      		trace2_region_leave(tr2_category, tr2_label, NULL);
      }
      
    --void run_processes_parallel(unsigned int jobs,
    +-void run_processes_parallel(size_t processes,
     -			    get_next_task_fn get_next_task,
     -			    start_failure_fn start_failure,
     -			    task_finished_fn task_finished,
     -			    void *pp_cb)
     -{
     -	const struct run_process_parallel_opts opts = {
    --		.jobs = jobs,
    +-		.processes = processes,
     -		.ungroup = run_processes_parallel_ungroup,
     -
     -		.get_next_task = get_next_task,
     -		.start_failure = start_failure,
     -		.task_finished = task_finished,
    --
    --		.data = pp_cb,
     -	};
     -
    --	run_processes_parallel_1(&opts);
    +-	run_processes_parallel_1(&opts, pp_cb);
     -}
     -
    - void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_task,
    + void run_processes_parallel_tr2(size_t processes, get_next_task_fn get_next_task,
      				start_failure_fn start_failure,
      				task_finished_fn task_finished, void *pp_cb,
    -@@ run-command.c: void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_tas
    +@@ run-command.c: void run_processes_parallel_tr2(size_t processes, get_next_task_fn get_next_task
    + 	const struct run_process_parallel_opts opts = {
    + 		.tr2_category = tr2_category,
      		.tr2_label = tr2_label,
    - 
    - 		.jobs = jobs,
    +-
    + 		.processes = processes,
     -		.ungroup = run_processes_parallel_ungroup,
      
      		.get_next_task = get_next_task,
      		.start_failure = start_failure,
    -@@ run-command.c: void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_tas
    - 		.data = pp_cb,
    + 		.task_finished = task_finished,
      	};
      
    --	run_processes_parallel_1(&opts);
    +-	run_processes_parallel_1(&opts, pp_cb);
     +	run_processes_parallel(&opts);
      }
      
    @@ run-command.c: void run_processes_parallel_tr2(unsigned int jobs, get_next_task_
     
      ## run-command.h ##
     @@ run-command.h: struct run_process_parallel_opts
    + 	 * NULL to omit any special handling.
    + 	 */
    + 	task_finished_fn task_finished;
    ++
    ++	/**
    ++	 * data: user data, will be passed as "pp_cb" to the callback
    ++	 * parameters.
    ++	 */
    ++	void *data;
      };
      
      /**
     + * Options are passed via the "struct run_process_parallel_opts" above.
     + *
    -  * Runs up to 'jobs' processes at the same time. Whenever a process can be
    +  * Runs N 'processes' at the same time. Whenever a process can be
     - * started, the callback get_next_task_fn is called to obtain the data
     + * started, the callback opts.get_next_task is called to obtain the data
       * required to start another child process.
    @@ run-command.h: struct run_process_parallel_opts
     - * API reads that setting.
       */
     -extern int run_processes_parallel_ungroup;
    --void run_processes_parallel(unsigned int jobs,
    +-void run_processes_parallel(size_t processes,
     -			    get_next_task_fn,
     -			    start_failure_fn,
     -			    task_finished_fn,
     -			    void *pp_cb);
     +void run_processes_parallel(const struct run_process_parallel_opts *opts);
    - void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn, start_failure_fn,
    - 				task_finished_fn, void *pp_cb,
    + void run_processes_parallel_tr2(size_t processes, get_next_task_fn,
    + 				start_failure_fn, task_finished_fn, void *pp_cb,
      				const char *tr2_category, const char *tr2_label);
     
      ## t/helper/test-run-command.c ##
    @@ t/helper/test-run-command.c: static int testsuite(int argc, const char **argv)
      
     -	run_processes_parallel(max_jobs, next_test, test_failed,
     -			       test_finished, &suite);
    -+	opts.jobs = max_jobs;
    ++	opts.processes = max_jobs;
     +	run_processes_parallel(&opts);
      
      	if (suite.failed.nr > 0) {
    @@ t/helper/test-run-command.c: int cmd__run_command(int argc, const char **argv)
      	strvec_pushv(&proc.args, (const char **)argv + 3);
      
      	if (!strcmp(argv[1], "run-command-parallel")) {
    --		run_processes_parallel(jobs, parallel_next, NULL, NULL,
    --				       &proc);
    +-		run_processes_parallel(jobs, parallel_next, NULL, NULL, &proc);
     +		opts.get_next_task = parallel_next;
      	} else if (!strcmp(argv[1], "run-command-abort")) {
     -		run_processes_parallel(jobs, parallel_next, NULL,
    @@ t/helper/test-run-command.c: int cmd__run_command(int argc, const char **argv)
      		fprintf(stderr, "check usage\n");
      		goto cleanup;
      	}
    -+	opts.jobs = jobs;
    ++	opts.processes = jobs;
     +	run_processes_parallel(&opts);
      	ret = 0;
      cleanup:
13:  37d194a338f ! 15:  391d1d99d91 run-command API: move *_tr2() users to "run_processes_parallel()"
    @@ builtin/fetch.c: static int fetch_multiple(struct string_list *list, int max_chi
     +			.tr2_category = "fetch",
     +			.tr2_label = "parallel/fetch",
     +
    -+			.jobs = max_children,
    ++			.processes = max_children,
     +
     +			.get_next_task = &fetch_next_remote,
     +			.start_failure = &fetch_failed_to_start,
    @@ builtin/submodule--helper.c: static int update_submodules(struct update_data *up
     +		.tr2_category = "submodule",
     +		.tr2_label = "parallel/update",
     +
    -+		.jobs = update_data->max_jobs,
    ++		.processes = update_data->max_jobs,
     +
     +		.get_next_task = update_clone_get_next_task,
     +		.start_failure = update_clone_start_failure,
    @@ run-command.c: void run_processes_parallel(const struct run_process_parallel_opt
      		trace2_region_leave(tr2_category, tr2_label, NULL);
      }
      
    --void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_task,
    +-void run_processes_parallel_tr2(size_t processes, get_next_task_fn get_next_task,
     -				start_failure_fn start_failure,
     -				task_finished_fn task_finished, void *pp_cb,
     -				const char *tr2_category, const char *tr2_label)
    @@ run-command.c: void run_processes_parallel(const struct run_process_parallel_opt
     -	const struct run_process_parallel_opts opts = {
     -		.tr2_category = tr2_category,
     -		.tr2_label = tr2_label,
    --
    --		.jobs = jobs,
    +-		.processes = processes,
     -
     -		.get_next_task = get_next_task,
     -		.start_failure = start_failure,
     -		.task_finished = task_finished,
    --
    --		.data = pp_cb,
     -	};
     -
     -	run_processes_parallel(&opts);
    @@ run-command.h: struct run_process_parallel_opts
       * conditions due to writing in parallel to stdout and stderr.
       */
      void run_processes_parallel(const struct run_process_parallel_opts *opts);
    --void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn, start_failure_fn,
    --				task_finished_fn, void *pp_cb,
    +-void run_processes_parallel_tr2(size_t processes, get_next_task_fn,
    +-				start_failure_fn, task_finished_fn, void *pp_cb,
     -				const char *tr2_category, const char *tr2_label);
      
      /**
    @@ submodule.c: int fetch_submodules(struct repository *r,
     +		.tr2_category = "submodule",
     +		.tr2_label = "parallel/fetch",
     +
    -+		.jobs = max_parallel_jobs,
    ++		.processes = max_parallel_jobs,
     +
     +		.get_next_task = get_next_submodule,
     +		.start_failure = fetch_start_failure,
 -:  ----------- > 16:  acac50cc1a5 run-command.c: make "struct parallel_processes" const if possible
14:  68605f4034b ! 17:  fdd64236985 run-command.c: don't copy *_fn to "struct parallel_processes"
    @@ Commit message
     
      ## run-command.c ##
     @@ run-command.c: struct parallel_processes {
    - 	unsigned int max_processes;
    - 	unsigned int nr_processes;
    + 	const size_t max_processes;
    + 	size_t nr_processes;
      
     -	get_next_task_fn get_next_task;
     -	start_failure_fn start_failure;
    @@ run-command.c: struct parallel_processes {
      		enum child_state state;
      		struct child_process process;
     @@ run-command.c: struct parallel_processes {
    - 	.buffered_output = STRBUF_INIT, \
    - }
    + 	struct strbuf buffered_output; /* of finished children */
    + };
      
     -static int default_start_failure(struct strbuf *out,
     -				 void *pp_cb,
    @@ run-command.c: struct parallel_processes {
     -	return 0;
     -}
     -
    - static void kill_children(struct parallel_processes *pp, int signo)
    + static void kill_children(const struct parallel_processes *pp, int signo)
      {
    - 	int i, n = pp->max_processes;
    + 	for (size_t i = 0; i < pp->max_processes; i++)
     @@ run-command.c: static void pp_init(struct parallel_processes *pp,
    + 		    const struct run_process_parallel_opts *opts)
      {
    - 	unsigned int i;
    - 	void *data = opts->data;
    + 	const size_t n = opts->processes;
     -	get_next_task_fn get_next_task = opts->get_next_task;
     -	start_failure_fn start_failure = opts->start_failure;
     -	task_finished_fn task_finished = opts->task_finished;
      
    - 	if (!opts->jobs)
    - 		BUG("you must provide a non-zero number of jobs!");
    + 	if (!n)
    + 		BUG("you must provide a non-zero number of processes!");
     @@ run-command.c: static void pp_init(struct parallel_processes *pp,
    - 		     opts->jobs);
    + 	trace_printf("run_processes_parallel: preparing to run up to %"PRIuMAX" tasks",
    + 		     (uintmax_t)n);
      
    - 	pp->data = data;
     -	if (!get_next_task)
     +	if (!opts->get_next_task)
      		BUG("you need to specify a get_next_task function");
    @@ run-command.c: static void pp_init(struct parallel_processes *pp,
     -	pp->start_failure = start_failure ? start_failure : default_start_failure;
     -	pp->task_finished = task_finished ? task_finished : default_task_finished;
      
    - 	pp->nr_processes = 0;
    - 	pp->output_owner = 0;
    + 	CALLOC_ARRAY(pp->children, n);
    + 	if (!pp->ungroup)
     @@ run-command.c: static void pp_cleanup(struct parallel_processes *pp)
       * <0 no new job was started, user wishes to shutdown early. Use negative code
       *    to signal the children.
    @@ run-command.c: static void pp_cleanup(struct parallel_processes *pp)
     +static int pp_start_one(struct parallel_processes *pp,
     +			const struct run_process_parallel_opts *opts)
      {
    - 	int i, code;
    - 
    + 	size_t i;
    + 	int code;
     @@ run-command.c: static int pp_start_one(struct parallel_processes *pp)
      	if (i == pp->max_processes)
      		BUG("bookkeeping is hard");
    @@ run-command.c: static int pp_start_one(struct parallel_processes *pp)
      		if (!pp->ungroup) {
      			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
      			strbuf_reset(&pp->children[i].err);
    -@@ run-command.c: static void pp_output(struct parallel_processes *pp)
    +@@ run-command.c: static void pp_output(const struct parallel_processes *pp)
      	}
      }
      
    @@ run-command.c: static void pp_output(struct parallel_processes *pp)
     +static int pp_collect_finished(struct parallel_processes *pp,
     +			       const struct run_process_parallel_opts *opts)
      {
    - 	int i, code;
    - 	int n = pp->max_processes;
    + 	int code;
    + 	size_t i, n = pp->max_processes;
     @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp)
      
      		code = finish_command(&pp->children[i].process);
15:  60d66fbd90a ! 18:  17f34d81ecd run-command.c: don't copy "ungroup" to "struct parallel_processes"
    @@ run-command.c: struct parallel_processes {
      	struct pollfd *pfd;
      
      	unsigned shutdown : 1;
    --	unsigned ungroup : 1;
    +-	const unsigned ungroup : 1;
      
    - 	int output_owner;
    + 	size_t output_owner;
      	struct strbuf buffered_output; /* of finished children */
     @@ run-command.c: static void pp_init(struct parallel_processes *pp,
    - 	pp->nr_processes = 0;
    - 	pp->output_owner = 0;
    - 	pp->shutdown = 0;
    --	pp->ungroup = opts->ungroup;
    - 	CALLOC_ARRAY(pp->children, opts->jobs);
    + 		BUG("you need to specify a get_next_task function");
    + 
    + 	CALLOC_ARRAY(pp->children, n);
     -	if (!pp->ungroup)
     +	if (!opts->ungroup)
    - 		CALLOC_ARRAY(pp->pfd, opts->jobs);
    + 		CALLOC_ARRAY(pp->pfd, n);
      
    - 	for (i = 0; i < opts->jobs; i++) {
    + 	for (size_t i = 0; i < n; i++) {
     @@ run-command.c: static int pp_start_one(struct parallel_processes *pp,
      		BUG("bookkeeping is hard");
      
    @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp,
      			; /* no strbuf_*() work to do here */
      		} else if (i != pp->output_owner) {
      			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
    +@@ run-command.c: void run_processes_parallel(const struct run_process_parallel_opts *opts)
    + 		.max_processes = opts->processes,
    + 		.data = opts->data,
    + 		.buffered_output = STRBUF_INIT,
    +-		.ungroup = opts->ungroup,
    + 	};
    + 	/* options */
    + 	const char *tr2_category = opts->tr2_category;
 -:  ----------- > 19:  9cbee2dfe76 run-command.c: don't copy "data" to "struct parallel_processes"
 -:  ----------- > 20:  2dabed9e155 run-command.c: use "opts->processes", not "pp->max_processes"
 -:  ----------- > 21:  c1a286a8ebb run-command.c: pass "opts" further down, and use "opts->processes"
 -:  ----------- > 22:  541f41566e7 run-command.c: remove "pp->max_processes", add "const" to signal() handler
-- 
2.38.0.971.ge79ff6d20e7

