Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D8EC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 03:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJUDGp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 23:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJUDGl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 23:06:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F06170456
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:06:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so466707ejc.4
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RcGIjlKkvU8dPIjOOzv5U3Vuriqtlb0zz0jV58Scfes=;
        b=SSz9e6ju30rYJIC5KDdKw55e8EUitEaVVOfYLS2P0uLxbkzDC4nS+HkT7qEdKNj+bG
         TGtb4KGGJUn6xgoOkZbOmLNPOsjNkmWFbexVBd1hfSz5BBgFe+2iB6vPf6iDyAODy8xX
         BZIAcx5YFhBqlI/4hZuJKL62vq8LCdyFPaVImMIuecvZjmJGm74sW55/zskzQJbKg8Mp
         p47CRx1Qx/2wQqDScpbG34+u+sP9zXUMIcV8TeaiFNK6/hjts04uuxr0MOXnHH608XZi
         BTZgNeivCVToVa5sGI2/314KHbjRkSodz61yQMmkOzfZAAlpjqtgMt7/VrcO+H8oANcD
         GsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcGIjlKkvU8dPIjOOzv5U3Vuriqtlb0zz0jV58Scfes=;
        b=rWb6oQj3zPgn1ZM5wHLr6xYu0lixPGlFrD9vqoAC+xNYO12JdmkaR7w4dNuNLulOMh
         WPF5LKEOVpCNKpAJwtHdKFVKLAkfQtBTbTonnxm8e0opz6hFu+dTXJ7K8M7Q13Gs+U2F
         nxuhCbhiQl2ysFgLV+v/XrcX0M7cPAC7TGf9X6N4wDRejTIepBiLMrlx8xA1KDi8xlJV
         Dyf1Iomw4xM4W9Uz1W4LMXykhdmRaYt+0sMubB3Ac4khvFVHtMfjNSqtsJu9gH3WwlcK
         Gy8DcNacUtCVmRTR4j7U3goi0u0flZHeEkdkmFwYDO+z1WbG7SMb49dCA6fuAHRDX2oy
         T4Ng==
X-Gm-Message-State: ACrzQf3qgws4R8sDVyj7DTaqJLBU3QVh/sN/XzikANpLt9c2KElSMULk
        OyEslupHBpQFH7N1apiviia3RqgsuwrgVw==
X-Google-Smtp-Source: AMsMyM6HWiNZ4i7LFgcZ9QTIfHGBILR3tdK9efE4fy+Idnm94wp1qJbpMMEiX2jSq3Yoym00Hipegw==
X-Received: by 2002:a17:907:d9e:b0:78e:2ff7:72f4 with SMTP id go30-20020a1709070d9e00b0078e2ff772f4mr13120046ejc.608.1666321595633;
        Thu, 20 Oct 2022 20:06:35 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906784700b0078d9e26db54sm11109425ejm.88.2022.10.20.20.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 20:06:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oliMj-006kwb-2r;
        Fri, 21 Oct 2022 05:06:33 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v3 2/6] run-command: add hide_output to
 run_processes_parallel_opts
Date:   Fri, 21 Oct 2022 04:54:27 +0200
References: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
 <20221020232532.1128326-3-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221020232532.1128326-3-calvinwan@google.com>
Message-ID: <221021.86lep9g9ja.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 20 2022, Calvin Wan wrote:

> Output from child processes and callbacks may not be necessary to
> print out for every invoker of run_processes_parallel. Add
> hide_output as an option to not print said output.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  run-command.c               | 8 +++++---
>  run-command.h               | 9 +++++++++
>  t/helper/test-run-command.c | 6 ++++++
>  t/t0061-run-command.sh      | 6 ++++++
>  4 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 03787bc7f5..3aa28ad6dc 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1603,7 +1603,8 @@ static void pp_cleanup(struct parallel_processes *pp,
>  	 * When get_next_task added messages to the buffer in its last
>  	 * iteration, the buffered output is non empty.
>  	 */
> -	strbuf_write(&pp->buffered_output, stderr);
> +	if (!opts->hide_output)
> +		strbuf_write(&pp->buffered_output, stderr);
>  	strbuf_release(&pp->buffered_output);
>  
>  	sigchain_pop_common();
> @@ -1754,7 +1755,7 @@ static int pp_collect_finished(struct parallel_processes *pp,
>  			pp->pfd[i].fd = -1;
>  		child_process_init(&pp->children[i].process);
>  
> -		if (opts->ungroup) {
> +		if (opts->ungroup || opts->hide_output) {
>  			; /* no strbuf_*() work to do here */
>  		} else if (i != pp->output_owner) {
>  			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> @@ -1826,7 +1827,8 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
>  				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
>  		} else {
>  			pp_buffer_stderr(&pp, opts, output_timeout);
> -			pp_output(&pp);
> +			if (!opts->hide_output)
> +				pp_output(&pp);
>  		}
>  		code = pp_collect_finished(&pp, opts);
>  		if (code) {
> diff --git a/run-command.h b/run-command.h
> index b4584c3698..4570812c08 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -496,6 +496,11 @@ struct run_process_parallel_opts
>  	 */
>  	unsigned int ungroup:1;
>  
> +	/**
> +	 * hide_output: see 'hide_output' in run_processes_parallel() below.
> +	 */
> +	unsigned int hide_output:1;
> +
>  	/**
>  	 * get_next_task: See get_next_task_fn() above. This must be
>  	 * specified.
> @@ -547,6 +552,10 @@ struct run_process_parallel_opts
>   * NULL "struct strbuf *out" parameter, and are responsible for
>   * emitting their own output, including dealing with any race
>   * conditions due to writing in parallel to stdout and stderr.
> + * 
> + * If the "hide_output" option is set, any output in the "struct strbuf
> + * *out" parameter will not be printed by this function. This includes
> + * output from child processes as well as callbacks.
>   */
>  void run_processes_parallel(const struct run_process_parallel_opts *opts);
>  
> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index e9b41419a0..1af443db4d 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -446,6 +446,12 @@ int cmd__run_command(int argc, const char **argv)
>  		opts.ungroup = 1;
>  	}
>  
> +	if (!strcmp(argv[1], "--hide-output")) {
> +		argv += 1;
> +		argc -= 1;
> +		opts.hide_output = 1;
> +	}
> +
>  	if (!strcmp(argv[1], "--pipe-output")) {
>  		argv += 1;
>  		argc -= 1;
> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index e50e57db89..a0219f6093 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -180,6 +180,12 @@ test_expect_success 'run_command runs ungrouped in parallel with more tasks than
>  	test_line_count = 4 err
>  '
>  
> +test_expect_success 'run_command hides output when run in parallel' '
> +	test-tool run-command --hide-output run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
> +	test_must_be_empty out &&
> +	test_must_be_empty err
> +'
> +
>  cat >expect <<-EOF
>  preloaded output of a child
>  asking for a quick stop

I may just be missing something, but doesn't "struct child_process"
already have e.g. "no_stderr", "no_stdout" etc. that we can use?
I.e. isn't this thing equivalent to running:

	your-command >/dev/null 2>/dev/null

Which is what the non-parallel API already supports.

Now, IIRC if you just set that in the "get_next_task" callback it won't
work in the parallel API, or you'll block waiting for I/O that'll never
come or whatever.

But that'll be because the parallel interface currently only suppors a
subset of the full "child_process" combination of options, and maybe it
doesn't grok this.

But if that's the case we should just extend the API to support
"no_stdout", "no_stderr" etc., no?

I.e. hypothetically the parallel one could support 100% of the "struct
child_process" combination of options, we just haven't bothered yet.

But I don't see why the parallel API should grow options that we already
have in "struct child_process", instead we should set them there, and it
should gradually learn to deal with them.

I think it's also fine to have some basic sanity checks there, e.g. I
could see how for something like this we don't want to support piping
only some children to /dev/null but not others, and that it should be
all or nothing (maybe it makes state management when we loop over them
easier).

Or again, maybe I'm missing something...
