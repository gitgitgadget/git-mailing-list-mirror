Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AA9C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 17:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348259AbiEZRTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 13:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348124AbiEZRTK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 13:19:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EDA4CD43
        for <git@vger.kernel.org>; Thu, 26 May 2022 10:19:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x2-20020a17090a1f8200b001e07a64c461so4950784pja.4
        for <git@vger.kernel.org>; Thu, 26 May 2022 10:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Wmn2TcPaOo2os0RyqkDhi67EReE7GMdaMy/ODHaDpoY=;
        b=V8wbkDhmLTeS1/RhTnh28ZlU5M/2GM1XOcyFUcVTifYOyuqa4l7n04lG4tNBoW8dEs
         fQjr+msC9XN8WShR9SXms6U88Wv3u9e9SB/g1bbjmmXs4ATsWTt+BQLAwhWN/yucEZvU
         g0NesfI2V3zRxAsG/MwmgacrrZIVHPW8Z7uU3gqHzJp/7vtTGWFgzbjsO4rrfxieZAOI
         PkMGw2r1BIItVFVgXHKLGCtON1thfLIFyO4Hej3fjYYLbUAu0ygSfn42gKQDEa5wvUd8
         tqiYoEN6WrF5E6/FisP9jwbhvG1qtGQWmOXIlKqqD1Ve3/f9vlH0kJsZ/kQJc3Ay63Cq
         dFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Wmn2TcPaOo2os0RyqkDhi67EReE7GMdaMy/ODHaDpoY=;
        b=oOJzQF8OCadV0s5zSxpG8d5RV9MKfq0mRZk3Z+m5l4QqOP0znodQuhxU2qrX/EgsnX
         +soDUy2G36+Sh02YD5TvihN0+qOTN9SIMh9QRFJ0mYjDJTz/tGok9Mj9kk4YvubEwX7K
         BWqiYEu3+/O5pbV1OD2JyRoiuhYqjQdPnFHtqbDpZpkEF7kDPGzLqMcza4pyzbBIS/uQ
         blSPXjrHX3lUQCGRFEgtQKhFITGHj7XbkBW7POEcFS0bxg8agAjYELX4rjXZQHU1G5aL
         BbEbrQNJ+ps3NDuaci7o+nUdbnJIE1FvLaYaJoR3VC2cxxsRUla20FfqfSM9HAU7vbAS
         J/yA==
X-Gm-Message-State: AOAM533a5Ftel7TPAxBk7zlgfZ0J+rUlGO5O+Kb/dLmIdntWOLRXelrV
        SzfjgsOhqIsXNgx7CPavQfhDdw==
X-Google-Smtp-Source: ABdhPJzpo2J/PeabDkHCEKgAJX/2tCRYMvDVw3eY/gkCS6yGuPgB5UI0bYKHBVE3H3x2AJu5sNn6NA==
X-Received: by 2002:a17:90a:4282:b0:1de:c783:4e79 with SMTP id p2-20020a17090a428200b001dec7834e79mr3660067pjg.235.1653585547762;
        Thu, 26 May 2022 10:19:07 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:dcef:8d9b:c712:c6ca])
        by smtp.gmail.com with ESMTPSA id v187-20020a6261c4000000b0051853e6617fsm1768691pfb.89.2022.05.26.10.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 10:19:07 -0700 (PDT)
Date:   Thu, 26 May 2022 10:18:59 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 5/8] run-command: add an "ungroup" option to
 run_process_parallel()
Message-ID: <Yo+2cbMueQyAI186@google.com>
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
 <patch-v2-5.8-c2e015ed840-20220518T195858Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-5.8-c2e015ed840-20220518T195858Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 18, 2022 at 10:05:21PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> Extend the parallel execution API added in c553c72eed6 (run-command:
> add an asynchronous parallel child processor, 2015-12-15) to support a
> mode where the stdout and stderr of the processes isn't captured and
> output in a deterministic order, instead we'll leave it to the kernel
> and stdio to sort it out.
> 
> This gives the API same functionality as GNU parallel's --ungroup
> option. As we'll see in a subsequent commit the main reason to want
> this is to support stdout and stderr being connected to the TTY in the
> case of jobs=1, demonstrated here with GNU parallel:
> 
> 	$ parallel --ungroup 'test -t {} && echo TTY || echo NTTY' ::: 1 2
> 	TTY
> 	TTY
> 	$ parallel 'test -t {} && echo TTY || echo NTTY' ::: 1 2
> 	NTTY
> 	NTTY
> 
> Another is as GNU parallel's documentation notes a potential for
> optimization. Our results will be a bit different, but in cases where
> you want to run processes in parallel where the exact order isn't
> important this can be a lot faster:
> 
> 	$ hyperfine -r 3 -L o ,--ungroup 'parallel {o} seq ::: 10000000 >/dev/null '
> 	Benchmark 1: parallel  seq ::: 10000000 >/dev/null
> 	  Time (mean ± σ):     220.2 ms ±   9.3 ms    [User: 124.9 ms, System: 96.1 ms]
> 	  Range (min … max):   212.3 ms … 230.5 ms    3 runs
> 
> 	Benchmark 2: parallel --ungroup seq ::: 10000000 >/dev/null
> 	  Time (mean ± σ):     154.7 ms ±   0.9 ms    [User: 136.2 ms, System: 25.1 ms]
> 	  Range (min … max):   153.9 ms … 155.7 ms    3 runs
> 
> 	Summary
> 	  'parallel --ungroup seq ::: 10000000 >/dev/null ' ran
> 	    1.42 ± 0.06 times faster than 'parallel  seq ::: 10000000 >/dev/null '
> 
> A large part of the juggling in the API is to make the API safer for
> its maintenance and consumers alike.
> 
> For the maintenance of the API we e.g. avoid malloc()-ing the
> "pp->pfd", ensuring that SANITIZE=address and other similar tools will
> catch any unexpected misuse.
> 
> For API consumers we take pains to never pass the non-NULL "out"
> buffer to an API user that provided the "ungroup" option. The
> resulting code in t/helper/test-run-command.c isn't typical of such a
> user, i.e. they'd typically use one mode or the other, and would know
> whether they'd provided "ungroup" or not.

Ah, interesting, so it's a little finer grained than my suggestion of
"just always ungroup when jobs=1". Since it's an option directly
available to the caller, that means they could use it for something
where the ordering really doesn't matter as much as the rate, such as if
they wanted a bunch of subprocesses to split up some work in parallel or
something. I like the flexibility, even though I know before I said "why
don't we hide this functionality". So I was wrong, and this looks nice
to me :)

I think we actually could even automatically set ungroup if jobs=1 as
well, because then there is no reason to buffer the output - it uses
additional memory for us, and it makes output slower to see for the end
user. But I do not really mind enough to want a reroll.

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  run-command.c               | 76 ++++++++++++++++++++++++++++---------
>  run-command.h               | 31 +++++++++++----
>  t/helper/test-run-command.c | 26 ++++++++++---
>  t/t0061-run-command.sh      | 30 +++++++++++++++
>  4 files changed, 132 insertions(+), 31 deletions(-)
> 
> diff --git a/run-command.c b/run-command.c
> index 839c85d12e5..39e09ee39fc 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1468,7 +1468,7 @@ int pipe_command(struct child_process *cmd,
>  enum child_state {
>  	GIT_CP_FREE,
>  	GIT_CP_WORKING,
> -	GIT_CP_WAIT_CLEANUP,
> +	GIT_CP_WAIT_CLEANUP, /* only for !ungroup */
>  };
>  
>  struct parallel_processes {
> @@ -1494,6 +1494,7 @@ struct parallel_processes {
>  	struct pollfd *pfd;
>  
>  	unsigned shutdown : 1;
> +	unsigned ungroup : 1;
>  
>  	int output_owner;
>  	struct strbuf buffered_output; /* of finished children */
> @@ -1563,12 +1564,16 @@ static void pp_init(struct parallel_processes *pp,
>  	pp->nr_processes = 0;
>  	pp->output_owner = 0;
>  	pp->shutdown = 0;
> +	pp->ungroup = opts->ungroup;

I was worried about what happens if the caller changes the value of
run_processes_parallel_opt.ungroup in the middle of execution, but since
we're copying the value away during init, I think it will have no
effect. OK.

>  	CALLOC_ARRAY(pp->children, n);
> -	CALLOC_ARRAY(pp->pfd, n);
> +	if (!pp->ungroup)
> +		CALLOC_ARRAY(pp->pfd, n);
>  
>  	for (i = 0; i < n; i++) {
>  		strbuf_init(&pp->children[i].err, 0);
>  		child_process_init(&pp->children[i].process);
> +		if (!pp->pfd)
> +			continue;
>  		pp->pfd[i].events = POLLIN | POLLHUP;
>  		pp->pfd[i].fd = -1;
>  	}
> @@ -1594,7 +1599,8 @@ static void pp_cleanup(struct parallel_processes *pp)
>  	 * When get_next_task added messages to the buffer in its last
>  	 * iteration, the buffered output is non empty.
>  	 */
> -	strbuf_write(&pp->buffered_output, stderr);
> +	if (!pp->ungroup)
> +		strbuf_write(&pp->buffered_output, stderr);
>  	strbuf_release(&pp->buffered_output);
>  
>  	sigchain_pop_common();
> @@ -1609,6 +1615,7 @@ static void pp_cleanup(struct parallel_processes *pp)
>   */
>  static int pp_start_one(struct parallel_processes *pp)
>  {
> +	const int ungroup = pp->ungroup;
>  	int i, code;
>  
>  	for (i = 0; i < pp->max_processes; i++)
> @@ -1618,24 +1625,30 @@ static int pp_start_one(struct parallel_processes *pp)
>  		BUG("bookkeeping is hard");
>  
>  	code = pp->get_next_task(&pp->children[i].process,
> -				 &pp->children[i].err,
> +				 ungroup ? NULL : &pp->children[i].err,
>  				 pp->data,
>  				 &pp->children[i].data);
>  	if (!code) {
> -		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> -		strbuf_reset(&pp->children[i].err);
> +		if (!ungroup) {
> +			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> +			strbuf_reset(&pp->children[i].err);
> +		}
>  		return 1;
>  	}
> -	pp->children[i].process.err = -1;
> -	pp->children[i].process.stdout_to_stderr = 1;
> +	if (!ungroup) {
> +		pp->children[i].process.err = -1;
> +		pp->children[i].process.stdout_to_stderr = 1;
> +	}

Hm, so for now if ungroup=1, we ignore the stdout entirely? It looks
like in patch 8 we're relying on the get_next_task callback to set these
instead, right? Or am I misunderstanding it, and the child's stderr goes
to our stderr by default?

>  	pp->children[i].process.no_stdin = 1;
>  
>  	if (start_command(&pp->children[i].process)) {
> -		code = pp->start_failure(&pp->children[i].err,
> +		code = pp->start_failure(ungroup ? NULL : &pp->children[i].err,
>  					 pp->data,
>  					 pp->children[i].data);
> -		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> -		strbuf_reset(&pp->children[i].err);
> +		if (!ungroup) {
> +			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> +			strbuf_reset(&pp->children[i].err);
> +		}
>  		if (code)
>  			pp->shutdown = 1;
>  		return code;
> @@ -1643,14 +1656,26 @@ static int pp_start_one(struct parallel_processes *pp)
>  
>  	pp->nr_processes++;
>  	pp->children[i].state = GIT_CP_WORKING;
> -	pp->pfd[i].fd = pp->children[i].process.err;
> +	if (pp->pfd)
> +		pp->pfd[i].fd = pp->children[i].process.err;
>  	return 0;
>  }
>  
> +static void pp_mark_working_for_cleanup(struct parallel_processes *pp)
> +{
> +	int i;
> +
> +	for (i = 0; i < pp->max_processes; i++)
> +		if (pp->children[i].state == GIT_CP_WORKING)
> +			pp->children[i].state = GIT_CP_WAIT_CLEANUP;
> +}
> +
>  static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
>  {
>  	int i;
>  
> +	assert(!pp->ungroup);
> +
>  	while ((i = poll(pp->pfd, pp->max_processes, output_timeout)) < 0) {
>  		if (errno == EINTR)
>  			continue;
> @@ -1677,6 +1702,9 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
>  static void pp_output(struct parallel_processes *pp)
>  {
>  	int i = pp->output_owner;
> +
> +	assert(!pp->ungroup);
> +
>  	if (pp->children[i].state == GIT_CP_WORKING &&
>  	    pp->children[i].err.len) {
>  		strbuf_write(&pp->children[i].err, stderr);
> @@ -1686,10 +1714,15 @@ static void pp_output(struct parallel_processes *pp)
>  
>  static int pp_collect_finished(struct parallel_processes *pp)
>  {
> +	const int ungroup = pp->ungroup;
>  	int i, code;
>  	int n = pp->max_processes;
>  	int result = 0;
>  
> +	if (ungroup)
> +		for (i = 0; i < pp->max_processes; i++)
> +			pp->children[i].state = GIT_CP_WAIT_CLEANUP;
> +
>  	while (pp->nr_processes > 0) {
>  		for (i = 0; i < pp->max_processes; i++)
>  			if (pp->children[i].state == GIT_CP_WAIT_CLEANUP)
> @@ -1700,8 +1733,8 @@ static int pp_collect_finished(struct parallel_processes *pp)
>  		code = finish_command(&pp->children[i].process);
>  
>  		code = pp->task_finished(code,
> -					 &pp->children[i].err, pp->data,
> -					 pp->children[i].data);
> +					 ungroup ? NULL : &pp->children[i].err,
> +					 pp->data, pp->children[i].data);
>  
>  		if (code)
>  			result = code;
> @@ -1710,10 +1743,13 @@ static int pp_collect_finished(struct parallel_processes *pp)
>  
>  		pp->nr_processes--;
>  		pp->children[i].state = GIT_CP_FREE;
> -		pp->pfd[i].fd = -1;
> +		if (pp->pfd)
> +			pp->pfd[i].fd = -1;
>  		child_process_init(&pp->children[i].process);
>  
> -		if (i != pp->output_owner) {
> +		if (ungroup) {
> +			; /* no strbuf_*() work to do here */
> +		} else if (i != pp->output_owner) {
>  			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
>  			strbuf_reset(&pp->children[i].err);
>  		} else {
> @@ -1774,8 +1810,12 @@ int run_processes_parallel(struct run_process_parallel_opts *opts)
>  		}
>  		if (!pp.nr_processes)
>  			break;
> -		pp_buffer_stderr(&pp, output_timeout);
> -		pp_output(&pp);
> +		if (opts->ungroup) {
> +			pp_mark_working_for_cleanup(&pp);
> +		} else {
> +			pp_buffer_stderr(&pp, output_timeout);
> +			pp_output(&pp);
> +		}
>  		code = pp_collect_finished(&pp);
>  		if (code) {
>  			pp.shutdown = 1;
> diff --git a/run-command.h b/run-command.h
> index b0268ed3db1..dcb6ded4b55 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -405,6 +405,10 @@ void check_pipe(int err);
>   * pp_cb is the callback cookie as passed to run_processes_parallel.
>   * You can store a child process specific callback cookie in pp_task_cb.
>   *
> + * The "struct strbuf *err" parameter is either a pointer to a string
> + * to write errors to, or NULL if the "ungroup" option was
> + * provided. See run_processes_parallel() below.
> + *
>   * Even after returning 0 to indicate that there are no more processes,
>   * this function will be called again until there are no more running
>   * child processes.
> @@ -423,9 +427,9 @@ typedef int (*get_next_task_fn)(struct child_process *cp,
>   * This callback is called whenever there are problems starting
>   * a new process.
>   *
> - * You must not write to stdout or stderr in this function. Add your
> - * message to the strbuf out instead, which will be printed without
> - * messing up the output of the other parallel processes.
> + * The "struct strbuf *err" parameter is either a pointer to a string
> + * to write errors to, or NULL if the "ungroup" option was
> + * provided. See run_processes_parallel() below.

I think we are losing some useful information here ("do not write
directly to stdout or stderr from here"). Same for below.

>   *
>   * pp_cb is the callback cookie as passed into run_processes_parallel,
>   * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> @@ -441,9 +445,9 @@ typedef int (*start_failure_fn)(struct strbuf *out,
>  /**
>   * This callback is called on every child process that finished processing.
>   *
> - * You must not write to stdout or stderr in this function. Add your
> - * message to the strbuf out instead, which will be printed without
> - * messing up the output of the other parallel processes.
> + * The "struct strbuf *err" parameter is either a pointer to a string
> + * to write errors to, or NULL if the "ungroup" option was
> + * provided. See run_processes_parallel() below.
>   *
>   * pp_cb is the callback cookie as passed into run_processes_parallel,
>   * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> @@ -466,6 +470,10 @@ typedef int (*task_finished_fn)(int result,
>   *
>   * jobs: see 'n' in run_processes_parallel() below.
>   *
> + * ungroup: Ungroup output. Output is printed as soon as possible and
> + * bypasses run-command's internal processing. This may cause output
> + * from different commands to be mixed.
> + *
>   * *_fn & data: see run_processes_parallel() below.
>   */
>  struct run_process_parallel_opts
> @@ -474,6 +482,7 @@ struct run_process_parallel_opts
>  	const char *tr2_label;
>  
>  	int jobs;
> +	unsigned int ungroup:1;
>  
>  	get_next_task_fn get_next_task;
>  	start_failure_fn start_failure;
> @@ -490,10 +499,18 @@ struct run_process_parallel_opts
>   *
>   * The children started via this function run in parallel. Their output
>   * (both stdout and stderr) is routed to stderr in a manner that output
> - * from different tasks does not interleave.
> + * from different tasks does not interleave (but see "ungroup" above).

Hm, I think it would be more accurate to say, "By default, their output
(blah blah)..." because in fact when we set ungroup, it does interleave.
But this is a small nit, from reading "ungroup" it becomes clear.

>   *
>   * start_failure_fn and task_finished_fn can be NULL to omit any
>   * special handling.
> + *
> + * If the "ungroup" option isn't specified the callbacks will get a
> + * pointer to a "struct strbuf *out", and must not write to stdout or
> + * stderr as such output will mess up the output of the other parallel
> + * processes. If "ungroup" option is specified callbacks will get a
> + * NULL "struct strbuf *out" parameter, and are responsible for
> + * emitting their own output, including dealing with any race
> + * conditions due to writing in parallel to stdout and stderr.
>   */
>  int run_processes_parallel(struct run_process_parallel_opts *opts);
>  
> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index 56a806f228b..986acbce5f2 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -31,7 +31,11 @@ static int parallel_next(struct child_process *cp,
>  		return 0;
>  
>  	strvec_pushv(&cp->args, d->args.v);
> -	strbuf_addstr(err, "preloaded output of a child\n");
> +	if (err)
> +		strbuf_addstr(err, "preloaded output of a child\n");
> +	else
> +		fprintf(stderr, "preloaded output of a child\n");
> +
>  	number_callbacks++;
>  	return 1;
>  }
> @@ -41,7 +45,10 @@ static int no_job(struct child_process *cp,
>  		  void *cb,
>  		  void **task_cb)
>  {
> -	strbuf_addstr(err, "no further jobs available\n");
> +	if (err)
> +		strbuf_addstr(err, "no further jobs available\n");
> +	else
> +		fprintf(stderr, "no further jobs available\n");
>  	return 0;
>  }
>  
> @@ -50,7 +57,10 @@ static int task_finished(int result,
>  			 void *pp_cb,
>  			 void *pp_task_cb)
>  {
> -	strbuf_addstr(err, "asking for a quick stop\n");
> +	if (err)
> +		strbuf_addstr(err, "asking for a quick stop\n");
> +	else
> +		fprintf(stderr, "asking for a quick stop\n");
>  	return 1;
>  }
>  
> @@ -422,12 +432,15 @@ int cmd__run_command(int argc, const char **argv)
>  	opts.jobs = jobs;
>  	opts.data = &proc;
>  
> -	if (!strcmp(argv[1], "run-command-parallel")) {
> +	if (!strcmp(argv[1], "run-command-parallel") ||
> +	    !strcmp(argv[1], "run-command-parallel-ungroup")) {
>  		next_fn = parallel_next;
> -	} else if (!strcmp(argv[1], "run-command-abort")) {
> +	} else if (!strcmp(argv[1], "run-command-abort") ||
> +		   !strcmp(argv[1], "run-command-abort-ungroup")) {
>  		next_fn = parallel_next;
>  		finished_fn = task_finished;
> -	} else if (!strcmp(argv[1], "run-command-no-jobs")) {
> +	} else if (!strcmp(argv[1], "run-command-no-jobs") ||
> +		   !strcmp(argv[1], "run-command-no-jobs-ungroup")) {
>  		next_fn = no_job;
>  		finished_fn = task_finished;
>  	} else {
> @@ -435,6 +448,7 @@ int cmd__run_command(int argc, const char **argv)
>  		return 1;
>  	}
>  
> +	opts.ungroup = ends_with(argv[1], "-ungroup");
>  	opts.get_next_task = next_fn;
>  	opts.task_finished = finished_fn;
>  	exit(run_processes_parallel(&opts));
> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index 7d00f3cc2af..3628719a06d 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -135,18 +135,36 @@ test_expect_success 'run_command runs in parallel with more jobs available than
>  	test_cmp expect err
>  '
>  
> +test_expect_success 'run_command runs ungrouped in parallel with more jobs available than tasks' '
> +	test-tool run-command run-command-parallel-ungroup 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
> +	test_line_count = 8 out &&
> +	test_line_count = 4 err
> +'
> +
>  test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
>  	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
>  	test_must_be_empty out &&
>  	test_cmp expect err
>  '
>  
> +test_expect_success 'run_command runs ungrouped in parallel with as many jobs as tasks' '
> +	test-tool run-command run-command-parallel-ungroup 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
> +	test_line_count = 8 out &&
> +	test_line_count = 4 err
> +'
> +
>  test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
>  	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
>  	test_must_be_empty out &&
>  	test_cmp expect err
>  '
>  
> +test_expect_success 'run_command runs ungrouped in parallel with more tasks than jobs available' '
> +	test-tool run-command run-command-parallel-ungroup 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
> +	test_line_count = 8 out &&
> +	test_line_count = 4 err
> +'
> +
>  cat >expect <<-EOF
>  preloaded output of a child
>  asking for a quick stop
> @@ -162,6 +180,12 @@ test_expect_success 'run_command is asked to abort gracefully' '
>  	test_cmp expect err
>  '
>  
> +test_expect_success 'run_command is asked to abort gracefully (ungroup)' '
> +	test-tool run-command run-command-abort-ungroup 3 false >out 2>err &&
> +	test_must_be_empty out &&
> +	test_line_count = 6 err
> +'
> +
>  cat >expect <<-EOF
>  no further jobs available
>  EOF
> @@ -172,6 +196,12 @@ test_expect_success 'run_command outputs ' '
>  	test_cmp expect err
>  '
>  
> +test_expect_success 'run_command outputs (ungroup) ' '
> +	test-tool run-command run-command-no-jobs-ungroup 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
> +	test_must_be_empty out &&
> +	test_cmp expect err
> +'
> +
>  test_trace () {
>  	expect="$1"
>  	shift
> -- 
> 2.36.1.952.g0ae626f6cd7
> 
