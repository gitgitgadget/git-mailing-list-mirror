Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A14C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 06:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E0D64E25
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 06:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhBAG0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 01:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhBAGFG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 01:05:06 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45939C061573
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:04:25 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id t14so8881620plr.15
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Vl0BSBzIRqilVVf2nyZloj8AR1lEN1tSrpKmthfYTn8=;
        b=iCmrsMFnKzcpPHvjWrebi4HnjtF92a7gGhHD1S0U1HDlk4pgMZMdSCf7Ku9TI+RksU
         XiWJmVPajSSe6TAY0HTlk4uz67u5Sn1Qv0gP1iw+2R4UWFcJPRXchzBzsH9BYB4Dnr2y
         hrY0p2/McS59tB9TodWYhQF4h5XgrT2tISRGKCU+y867wD+E0o/NXC+00WfntvlnPSCs
         UoWecjhd1Za7r0ZOC1kqJm2A2n5dPKT8fB8RDl2MOSz56Q479AOLQZjgCR98SrWQxda/
         78GoUqu8vakHZ2pR+NN9hMo/bEZv6pX0HIUWvB/XNEAii5uc5PPDW0rPW4670GZdIisP
         9ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Vl0BSBzIRqilVVf2nyZloj8AR1lEN1tSrpKmthfYTn8=;
        b=S6NH7rQEuK4nNf77GUtsYbgrfaGoFNlmfdpMJJ0lLURiYQIeyjbkHr85Fub2fDXSZR
         RHadC7JLrmsGTmOHZcplprsVC/UounzTqxy/vV9Q6cy+5VQvlY3BAxTFzXkmhxObIWaL
         tARavAxVN77ACYwSG/6iFvV0wEehGMbw3TpkiSmzzGnvNtWAEWBDuii/aIhOcRWJfxWM
         UmFuskNlA5AUNPaSJcUVt0nOftsFYj3xUobaH6ier4xcxEFokJmGSLT2jVUY6f1+0f6R
         7uX7HC1Mfb3/JifbNMdAhWPtV85UVfHYHBZiWIZUVim+RDH7pPnl6dqd4KVX4i9Qx2L4
         k92A==
X-Gm-Message-State: AOAM531kMIlZ6sed7ucc2eyZwePbaYKpumggWTFNejKr3Uhaq5DCQpj1
        4+2OjWY+DXnb2ECX9Ds42knD9KT5cvt+6sreq9Iz
X-Google-Smtp-Source: ABdhPJwJwah3V3eEmeV3/JjvtsAr3fzwzTKe6o5lbNQPdxMwBSj3SepE0TH6b/xT1oW0YXe2Ghi1Ia8LdFI6ntuof0/C
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:9585:0:b029:1c5:10ce:ba7f with
 SMTP id z5-20020aa795850000b02901c510ceba7fmr14965563pfj.79.1612159464700;
 Sun, 31 Jan 2021 22:04:24 -0800 (PST)
Date:   Sun, 31 Jan 2021 22:04:22 -0800
In-Reply-To: <20201222000220.1491091-13-emilyshaffer@google.com>
Message-Id: <20210201060422.1313603-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-13-emilyshaffer@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v7 12/17] hook: allow parallel hook execution
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In many cases, there's no reason not to allow hooks to execute in
> parallel. run_processes_parallel() is well-suited - it's a task queue
> that runs its housekeeping in series, which means users don't
> need to worry about thread safety on their callback data. True
> multithreaded execution with the async_* functions isn't necessary here.
> Synchronous hook execution can be achieved by only allowing 1 job to run
> at a time.
> 
> Teach run_hooks() to use that function for simple hooks which don't
> require stdin or capture of stderr.

Which hooks would be run in parallel, and which hooks in series? I don't
see code that distinguishes between them.

> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> 
> Notes:
>     Per AEvar's request - parallel hook execution on day zero.
>     
>     In most ways run_processes_parallel() worked great for me - but it didn't
>     have great support for hooks where we pipe to and from. I had to add this
>     support later in the series.
>     
>     Since I modified an existing and in-use library I'd appreciate a keen look on
>     these patches.

What is the existing and in-use library that you're modifying?

> @@ -246,11 +255,96 @@ void run_hooks_opt_clear(struct run_hooks_opt *o)
>  	strvec_clear(&o->args);
>  }
>  
> +
> +static int pick_next_hook(struct child_process *cp,
> +			  struct strbuf *out,
> +			  void *pp_cb,
> +			  void **pp_task_cb)
> +{
> +	struct hook_cb_data *hook_cb = pp_cb;
> +
> +	struct hook *hook = list_entry(hook_cb->run_me, struct hook, list);
> +
> +	if (hook_cb->head == hook_cb->run_me)
> +		return 0;
> +
> +	cp->env = hook_cb->options->env.v;
> +	cp->stdout_to_stderr = 1;
> +	cp->trace2_hook_name = hook->command.buf;
> +
> +	/* reopen the file for stdin; run_command closes it. */
> +	if (hook_cb->options->path_to_stdin) {
> +		cp->no_stdin = 0;
> +		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
> +	} else {
> +		cp->no_stdin = 1;
> +	}
> +
> +	/*
> +	 * Commands from the config could be oneliners, but we know
> +	 * for certain that hookdir commands are not.
> +	 */
> +	if (hook->from_hookdir)
> +		cp->use_shell = 0;
> +	else
> +		cp->use_shell = 1;
> +
> +	/* add command */
> +	strvec_push(&cp->args, hook->command.buf);
> +
> +	/*
> +	 * add passed-in argv, without expanding - let the user get back
> +	 * exactly what they put in
> +	 */
> +	strvec_pushv(&cp->args, hook_cb->options->args.v);

I just skimmed over this setup-process-for-hook part - it would have
been much clearer if it was refactored into its own function before this
patch (or better yet, written as its own function in the first place).
As it is, there are some unnecessary rewritings - e.g. setting stdin
after env, and the use_shell setup.

> diff --git a/hook.h b/hook.h

[snip]

> +/*
> + * Callback provided to feed_pipe_fn and consume_sideband_fn.
> + */
> +struct hook_cb_data {
> +	int rc;
> +	struct list_head *head;
> +	struct list_head *run_me;
> +	struct run_hooks_opt *options;
> +};

Could this be in hook.c instead?

Also, I think it's clearer if run_me was a struct hook, and set to NULL
when iteration reaches the end. If you disagree, I think it needs some
documentation (e.g. "the embedded linked list part of the hook that must
be run next; if equal to head, then iteration has ended" or something
like that).

> +#define RUN_HOOKS_OPT_INIT_SYNC  {   		\
>  	.env = STRVEC_INIT, 			\
>  	.args = STRVEC_INIT, 			\
>  	.path_to_stdin = NULL,			\
> +	.jobs = 1,				\
>  	.run_hookdir = configured_hookdir_opt()	\
>  }

This is not used anywhere.
