Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386B4C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 14:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbiFBOIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 10:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbiFBOIF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 10:08:05 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D2124DE59
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 07:08:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so2837362wmz.2
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 07:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zFG7dmBUkKIYBtsFQtHXxwADJ1G1M+sAK1Unsz6YHt0=;
        b=eo8eZRE9LZv1+h2XrfoG2cza6cGg03f7Mu3P0qt3Ux+NKaF4m0JrVaqOA9xyIsJbjq
         PBlaiAn/bUicA8b65w0dq/zGt7NZKHYMo1PmSes6cMb/yygmBVFIAUr0OWSRzP3mQNFG
         OEiIax1VNsMG+U2hdAgs51IWZMLo0xhj4eoU9oGgdJg/92RXL3S49873UlbQcpfjozUp
         W0r9gaVgQkivsBBZ2W20A0a38EIMarojjLH5b+w50Glu98CK1MVZ88/G5FHoQaSGjKqn
         Q2cdtMMNkQAF0Kh0+9dhCTgzcjwEJWtj0kmzFExWD35FDCxbGSPyiFAQmx2ZljkSsQQc
         KcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFG7dmBUkKIYBtsFQtHXxwADJ1G1M+sAK1Unsz6YHt0=;
        b=08alqcoz1Sr1x/vDAqxzYHokJz2eZnvCD3t80it5kfZMsoEeL0ZkazLUhL7sEpV41Y
         XppfwpDW6vGXiIjXEdkwe1wk5lClQFDG3N2vRyA1viZFmhHUJaGHcMfRn3fxaRUysyqf
         lwN8rk2FUtTSsF6fypAQ4vD//VbESLJ4yP0aCQ963llj+UqsLRlpHbc/tHRRBdk6MKLM
         WGyX4Wf2SqJGjV5sfwPB2wqoyxy+QwhaAbgfa3z/yIgY+tbTXfKoNCrDnclOEKfot1Ji
         eyl+g3EVDELTo7yWAvoAZnflgQLJQerKUsgX1xw91Gn0WDp4XvSEF1ab8tHAhCf4JW8D
         +rwg==
X-Gm-Message-State: AOAM533RTM0Rycq7aVHhdhadiG1lIJTJ/vW6SuO0axbDSiAqPDzECtJC
        5Z63DicNlx0trJMhCxRRwr4+GnMPouhUAA==
X-Google-Smtp-Source: ABdhPJwuWj4VMH2ozxtFe7iN2NUqTMBfp5xL3zFau5RNkY396BKTcNVHzZaGI1J23qw1OIwdUCn85A==
X-Received: by 2002:a05:600c:154d:b0:394:880f:ae3a with SMTP id f13-20020a05600c154d00b00394880fae3amr32939512wmg.13.1654178881086;
        Thu, 02 Jun 2022 07:08:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b0039744bd664esm9271514wmq.13.2022.06.02.07.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:08:00 -0700 (PDT)
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
Subject: [PATCH v5 0/2] hook API: connect hooks to the TTY again, fixes a v2.36.0 regression
Date:   Thu,  2 Jun 2022 16:07:55 +0200
Message-Id: <cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.gb3ecdfb3e6a
In-Reply-To: <cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com>
References: <cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a v2.36.0 regression[1]. See [2] for the v4. The
reasons for why a regression needs this relatively large change to
move forward is discussed in past rounds, e.g. around [3]. CI at
https://github.com/avar/git/actions/runs/2428475773

Changes since v4, mainly to address comments by Johannes (thanks for
the review!):

 * First, some things like renaming "ungroup" to something else &
   rewriting the tests I didn't do because I thought keeping the
   inter/range-diff down in size outweighed re-arranging or changing
   the code at this late stage.

   In the case of the suggested shorter test in
   https://lore.kernel.org/git/nycvar.QRO.7.76.6.2206011827300.349@tvgsbejvaqbjf.bet/
   the replacement wasn't testing the same thing. I.e. we don't see
   what's connected to a TTY if we redirect one of stdout or stderr
   anymore, which is important to get right.

 * Ditto the suggestion to e.g. add a parameter for "ungroup". I agree
   that's better, but that approach was in the earlier and much larger
   round[4], here we're trying to aim for the smallest possible
   regression fix by line count & complexity.

 * I retained the performance test(s) for "parallel" and "git hook
   run" in 1/2 and 2/2. Yes, the former isn't ours, but I think it
   helps to explain the code, implementation and resulting performance
   with reference to existing well-known software that's doing the
   exact same thing we're doing here.

 * Stopped using "const" in "const int ungroup", and dropped some of
   those variables entirely.

 * Inlined the pp_mark_ungrouped_for_cleanup() function. I added an
   "int i" in the inner scope in run_processes_parallel() even though
   we have one in the outer, just to make it clear that we're not
   caring about the other one (or clobbering it).

 * I just got rid of the two added BUG(). It's obvious enough from the
   calling code that those two functions are !ungroup only, so we can
   do without the sprinkling of BUG() and larger resulting diff.

 * Passed an --ungroup parameter in the tests instead of passing a
   parameter by environment variable.

 * Fixed a minor s/reported in/reported against/ phrasing in the 2/2
   commit message.

1. https://lore.kernel.org/git/CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com/
2. https://lore.kernel.org/git/cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com/
3. https://lore.kernel.org/git/220526.86pmk060xa.gmgdl@evledraar.gmail.com/
4. https://lore.kernel.org/git/cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (2):
  run-command: add an "ungroup" option to run_process_parallel()
  hook API: fix v2.36.0 regression: hooks should be connected to a TTY

 hook.c                      |  1 +
 run-command.c               | 70 +++++++++++++++++++++++++++----------
 run-command.h               | 30 ++++++++++++----
 t/helper/test-run-command.c | 22 ++++++++++--
 t/t0061-run-command.sh      | 30 ++++++++++++++++
 t/t1800-hook.sh             | 37 ++++++++++++++++++++
 6 files changed, 161 insertions(+), 29 deletions(-)

Range-diff against v4:
1:  f1170b02553 ! 1:  d018b7c4441 run-command: add an "ungroup" option to run_process_parallel()
    @@ Commit message
                 NTTY
     
         Another is as GNU parallel's documentation notes a potential for
    -    optimization. Our results will be a bit different, but in cases where
    +    optimization. As demonstrated in next commit our results with "git
    +    hook run" will be similar, but generally speaking this shows that if
         you want to run processes in parallel where the exact order isn't
         important this can be a lot faster:
     
    @@ run-command.c: static void pp_init(struct parallel_processes *pp,
      		    start_failure_fn start_failure,
      		    task_finished_fn task_finished,
     -		    void *data)
    -+		    void *data, const int ungroup)
    ++		    void *data, int ungroup)
      {
      	int i;
      
    @@ run-command.c: static void pp_init(struct parallel_processes *pp,
      	for (i = 0; i < n; i++) {
      		strbuf_init(&pp->children[i].err, 0);
      		child_process_init(&pp->children[i].process);
    -+		if (!pp->pfd)
    -+			continue;
    - 		pp->pfd[i].events = POLLIN | POLLHUP;
    - 		pp->pfd[i].fd = -1;
    +-		pp->pfd[i].events = POLLIN | POLLHUP;
    +-		pp->pfd[i].fd = -1;
    ++		if (pp->pfd) {
    ++			pp->pfd[i].events = POLLIN | POLLHUP;
    ++			pp->pfd[i].fd = -1;
    ++		}
      	}
    -@@ run-command.c: static void pp_cleanup(struct parallel_processes *pp)
    -  */
    - static int pp_start_one(struct parallel_processes *pp)
    - {
    -+	const int ungroup = pp->ungroup;
    - 	int i, code;
      
    - 	for (i = 0; i < pp->max_processes; i++)
    + 	pp_for_signal = pp;
     @@ run-command.c: static int pp_start_one(struct parallel_processes *pp)
      		BUG("bookkeeping is hard");
      
      	code = pp->get_next_task(&pp->children[i].process,
     -				 &pp->children[i].err,
    -+				 ungroup ? NULL : &pp->children[i].err,
    ++				 pp->ungroup ? NULL : &pp->children[i].err,
      				 pp->data,
      				 &pp->children[i].data);
      	if (!code) {
     -		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
     -		strbuf_reset(&pp->children[i].err);
    -+		if (!ungroup) {
    ++		if (!pp->ungroup) {
     +			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
     +			strbuf_reset(&pp->children[i].err);
     +		}
    @@ run-command.c: static int pp_start_one(struct parallel_processes *pp)
      	}
     -	pp->children[i].process.err = -1;
     -	pp->children[i].process.stdout_to_stderr = 1;
    -+	if (!ungroup) {
    ++	if (!pp->ungroup) {
     +		pp->children[i].process.err = -1;
     +		pp->children[i].process.stdout_to_stderr = 1;
     +	}
    @@ run-command.c: static int pp_start_one(struct parallel_processes *pp)
      
      	if (start_command(&pp->children[i].process)) {
     -		code = pp->start_failure(&pp->children[i].err,
    -+		code = pp->start_failure(ungroup ? NULL : &pp->children[i].err,
    ++		code = pp->start_failure(pp->ungroup ? NULL :
    ++					 &pp->children[i].err,
      					 pp->data,
      					 pp->children[i].data);
     -		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
     -		strbuf_reset(&pp->children[i].err);
    -+		if (!ungroup) {
    ++		if (!pp->ungroup) {
     +			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
     +			strbuf_reset(&pp->children[i].err);
     +		}
    @@ run-command.c: static int pp_start_one(struct parallel_processes *pp)
      	return 0;
      }
      
    -+static void pp_mark_ungrouped_for_cleanup(struct parallel_processes *pp)
    -+{
    -+	int i;
    -+
    -+	if (!pp->ungroup)
    -+		BUG("only reachable if 'ungrouped'");
    -+
    -+	for (i = 0; i < pp->max_processes; i++)
    -+		pp->children[i].state = GIT_CP_WAIT_CLEANUP;
    -+}
    -+
    - static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
    - {
    - 	int i;
    - 
    -+	if (pp->ungroup)
    -+		BUG("unreachable with 'ungrouped'");
    -+
    - 	while ((i = poll(pp->pfd, pp->max_processes, output_timeout)) < 0) {
    - 		if (errno == EINTR)
    - 			continue;
     @@ run-command.c: static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
      static void pp_output(struct parallel_processes *pp)
      {
      	int i = pp->output_owner;
    -+
    -+	if (pp->ungroup)
    -+		BUG("unreachable with 'ungrouped'");
     +
      	if (pp->children[i].state == GIT_CP_WORKING &&
      	    pp->children[i].err.len) {
      		strbuf_write(&pp->children[i].err, stderr);
    -@@ run-command.c: static void pp_output(struct parallel_processes *pp)
    - 
    - static int pp_collect_finished(struct parallel_processes *pp)
    - {
    -+	const int ungroup = pp->ungroup;
    - 	int i, code;
    - 	int n = pp->max_processes;
    - 	int result = 0;
     @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp)
    + 
      		code = finish_command(&pp->children[i].process);
      
    - 		code = pp->task_finished(code,
    --					 &pp->children[i].err, pp->data,
    --					 pp->children[i].data);
    -+					 ungroup ? NULL : &pp->children[i].err,
    -+					 pp->data, pp->children[i].data);
    +-		code = pp->task_finished(code,
    ++		code = pp->task_finished(code, pp->ungroup ? NULL :
    + 					 &pp->children[i].err, pp->data,
    + 					 pp->children[i].data);
      
    - 		if (code)
    - 			result = code;
     @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp)
      
      		pp->nr_processes--;
    @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp)
      		child_process_init(&pp->children[i].process);
      
     -		if (i != pp->output_owner) {
    -+		if (ungroup) {
    ++		if (pp->ungroup) {
     +			; /* no strbuf_*() work to do here */
     +		} else if (i != pp->output_owner) {
      			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
      			strbuf_reset(&pp->children[i].err);
      		} else {
     @@ run-command.c: int run_processes_parallel(int n,
    + 	int i, code;
      	int output_timeout = 100;
      	int spawn_cap = 4;
    ++	int ungroup = run_processes_parallel_ungroup;
      	struct parallel_processes pp;
    -+	const int ungroup = run_processes_parallel_ungroup;
      
     -	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb);
     +	/* unset for the next API user */
    @@ run-command.c: int run_processes_parallel(int n,
     -		pp_buffer_stderr(&pp, output_timeout);
     -		pp_output(&pp);
     +		if (ungroup) {
    -+			pp_mark_ungrouped_for_cleanup(&pp);
    ++			int i;
    ++
    ++			for (i = 0; i < pp.max_processes; i++)
    ++				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
     +		} else {
     +			pp_buffer_stderr(&pp, output_timeout);
     +			pp_output(&pp);
    @@ t/helper/test-run-command.c: static int task_finished(int result,
      }
      
     @@ t/helper/test-run-command.c: int cmd__run_command(int argc, const char **argv)
    - 	strvec_clear(&proc.args);
    - 	strvec_pushv(&proc.args, (const char **)argv + 3);
    + 	if (!strcmp(argv[1], "run-command"))
    + 		exit(run_command(&proc));
      
    -+	if (getenv("RUN_PROCESSES_PARALLEL_UNGROUP"))
    ++	if (!strcmp(argv[1], "--ungroup")) {
    ++		argv += 1;
    ++		argc -= 1;
     +		run_processes_parallel_ungroup = 1;
    ++	}
     +
    - 	if (!strcmp(argv[1], "run-command-parallel"))
    - 		exit(run_processes_parallel(jobs, parallel_next,
    - 					    NULL, NULL, &proc));
    + 	jobs = atoi(argv[2]);
    + 	strvec_clear(&proc.args);
    + 	strvec_pushv(&proc.args, (const char **)argv + 3);
     
      ## t/t0061-run-command.sh ##
     @@ t/t0061-run-command.sh: test_expect_success 'run_command runs in parallel with more jobs available than
    @@ t/t0061-run-command.sh: test_expect_success 'run_command runs in parallel with m
      '
      
     +test_expect_success 'run_command runs ungrouped in parallel with more jobs available than tasks' '
    -+	RUN_PROCESSES_PARALLEL_UNGROUP=1 \
    -+	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    ++	test-tool run-command --ungroup run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
     +	test_line_count = 8 out &&
     +	test_line_count = 4 err
     +'
    @@ t/t0061-run-command.sh: test_expect_success 'run_command runs in parallel with m
      '
      
     +test_expect_success 'run_command runs ungrouped in parallel with as many jobs as tasks' '
    -+	RUN_PROCESSES_PARALLEL_UNGROUP=1 \
    -+	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    ++	test-tool run-command --ungroup run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
     +	test_line_count = 8 out &&
     +	test_line_count = 4 err
     +'
    @@ t/t0061-run-command.sh: test_expect_success 'run_command runs in parallel with m
      '
      
     +test_expect_success 'run_command runs ungrouped in parallel with more tasks than jobs available' '
    -+	RUN_PROCESSES_PARALLEL_UNGROUP=1 \
    -+	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    ++	test-tool run-command --ungroup run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
     +	test_line_count = 8 out &&
     +	test_line_count = 4 err
     +'
    @@ t/t0061-run-command.sh: test_expect_success 'run_command is asked to abort grace
      '
      
     +test_expect_success 'run_command is asked to abort gracefully (ungroup)' '
    -+	RUN_PROCESSES_PARALLEL_UNGROUP=1 \
    -+	test-tool run-command run-command-abort 3 false >out 2>err &&
    ++	test-tool run-command --ungroup run-command-abort 3 false >out 2>err &&
     +	test_must_be_empty out &&
     +	test_line_count = 6 err
     +'
    @@ t/t0061-run-command.sh: test_expect_success 'run_command outputs ' '
      '
      
     +test_expect_success 'run_command outputs (ungroup) ' '
    -+	RUN_PROCESSES_PARALLEL_UNGROUP=1 \
    -+	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    ++	test-tool run-command --ungroup run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
     +	test_must_be_empty out &&
     +	test_cmp expect err
     +'
2:  8ab09f28729 ! 2:  b0f0dc7492a hook API: fix v2.36.0 regression: hooks should be connected to a TTY
    @@ Metadata
      ## Commit message ##
         hook API: fix v2.36.0 regression: hooks should be connected to a TTY
     
    -    Fix a regression reported[1] in f443246b9f2 (commit: convert
    +    Fix a regression reported[1] against f443246b9f2 (commit: convert
         {pre-commit,prepare-commit-msg} hook to hook.h, 2021-12-22): Due to
         using the run_process_parallel() API in the earlier 96e7225b310 (hook:
         add 'run' subcommand, 2021-12-22) we'd capture the hook's stderr and
-- 
2.36.1.1103.gb3ecdfb3e6a

