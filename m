Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39662C433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 21:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0279B64E02
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 21:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhBVVro (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 16:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhBVVri (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 16:47:38 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45903C061574
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 13:46:58 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id x129so2724263pfx.7
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 13:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/mZU3O7gYZRbY1fTZw8qi7+1TJ47M61NJSygq8UoAS0=;
        b=aYLNroBWA7IuU2qP9R+v9yf2L+FG3rfZzsAWJ44K9Nk10On6T4NgC1sEKgL91e6ree
         Ww8QsydSz188NltQseD3eD/Mbg7H5sQlmQwLezxq+OJ70N3d/ThPEqh0xDkllnwbOypO
         LqeEnBGodEfdxEOSSKfb2P/wzsmnhzvVaSFvhSP/TD+MbwvghnyczjnEvH/oUgInfOXq
         8HzCrPMWDwdibIavJi0IHVuE+Lyo5+PYbg2qxf3PD650cC9EsYcA8uIGLiD+AcHlHIFu
         lb463NsDm42Sd+c06WQpCcpfQVWKZksFOIHUt0uqhyosC5/BO9Lr/AIBcwdR+uzUB435
         O6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/mZU3O7gYZRbY1fTZw8qi7+1TJ47M61NJSygq8UoAS0=;
        b=PxQ6KaVZ+FOVkWSsgAQ2omfPh05+RXEG0RN1mTLnlkPgetvchPBYxfeeCPXpG/tBUQ
         GOv1voubFUdx87dWRK06IUFAx8WMN4TOlSy1NF6A/hwmsZiRuyKUUUdChqkDAAK3Qz3D
         X4Fcm24rhx956TayaFXQnk8TTMtKtEisAni/uFw9RdRAuWogkoq09peoosIfEGCKTGIV
         pOpNr/o2vJZ1pmaiLBMJ0DY49TcBu86BkuU4bQ7o7bXrpLpphL2Hs9jNbpBxn0a/wzOL
         x07+d57pdx1eezh0gqIrX+ujnL1ZHa4TrsPGUAxBEN+k1PTmVEGGfdFhcLHLlIQkK3ZT
         4GFw==
X-Gm-Message-State: AOAM532L52Ex4tXXJ24UHQMX9dc7N38TfFnD1hxhyfAQlgosmJfFFfnC
        r/jDec5C3L2JdH4ZkbJYxhB0CQ==
X-Google-Smtp-Source: ABdhPJwZh1ZSULLx1kiZD8zCHRQeTAW7sf803ONHvBAPpeYhjTOLavVGcpcvmCAEOxVKKPK+ljVc1g==
X-Received: by 2002:a62:bd05:0:b029:1ab:6d2:5edf with SMTP id a5-20020a62bd050000b02901ab06d25edfmr23200377pff.32.1614030417628;
        Mon, 22 Feb 2021 13:46:57 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:398c:f3d9:88c:7d6a])
        by smtp.gmail.com with ESMTPSA id 143sm19572289pfw.3.2021.02.22.13.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 13:46:56 -0800 (PST)
Date:   Mon, 22 Feb 2021 13:46:51 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 12/17] hook: allow parallel hook execution
Message-ID: <YDQmS2qN/lrm547L@google.com>
References: <20201222000220.1491091-13-emilyshaffer@google.com>
 <20210201060422.1313603-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201060422.1313603-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 31, 2021 at 10:04:22PM -0800, Jonathan Tan wrote:
> 
> > In many cases, there's no reason not to allow hooks to execute in
> > parallel. run_processes_parallel() is well-suited - it's a task queue
> > that runs its housekeeping in series, which means users don't
> > need to worry about thread safety on their callback data. True
> > multithreaded execution with the async_* functions isn't necessary here.
> > Synchronous hook execution can be achieved by only allowing 1 job to run
> > at a time.
> > 
> > Teach run_hooks() to use that function for simple hooks which don't
> > require stdin or capture of stderr.
> 
> Which hooks would be run in parallel, and which hooks in series? I don't
> see code that distinguishes between them.

It's up to the caller, who can set run_hooks_opt.jobs. In part II of
this series I made a guess at which ones should run in parallel or in
series and specified it in Documentation/githooks.txt.

> 
> > 
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> > 
> > Notes:
> >     Per AEvar's request - parallel hook execution on day zero.
> >     
> >     In most ways run_processes_parallel() worked great for me - but it didn't
> >     have great support for hooks where we pipe to and from. I had to add this
> >     support later in the series.
> >     
> >     Since I modified an existing and in-use library I'd appreciate a keen look on
> >     these patches.
> 
> What is the existing and in-use library that you're modifying?

Hm, this note wasn't super specific. From this point onwards in the
series I make changes to the run-command.h:run_processes_parallel()
library, although not in this commit itself. I think I meant "from here
on out, help me look at run-command.h".

I'll try to make the note a little better next series, sorry for the
confusion :) :)

> 
> > @@ -246,11 +255,96 @@ void run_hooks_opt_clear(struct run_hooks_opt *o)
> >  	strvec_clear(&o->args);
> >  }
> >  
> > +
> > +static int pick_next_hook(struct child_process *cp,
> > +			  struct strbuf *out,
> > +			  void *pp_cb,
> > +			  void **pp_task_cb)
> > +{
> > +	struct hook_cb_data *hook_cb = pp_cb;
> > +
> > +	struct hook *hook = list_entry(hook_cb->run_me, struct hook, list);
> > +
> > +	if (hook_cb->head == hook_cb->run_me)
> > +		return 0;
> > +
> > +	cp->env = hook_cb->options->env.v;
> > +	cp->stdout_to_stderr = 1;
> > +	cp->trace2_hook_name = hook->command.buf;
> > +
> > +	/* reopen the file for stdin; run_command closes it. */
> > +	if (hook_cb->options->path_to_stdin) {
> > +		cp->no_stdin = 0;
> > +		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
> > +	} else {
> > +		cp->no_stdin = 1;
> > +	}
> > +
> > +	/*
> > +	 * Commands from the config could be oneliners, but we know
> > +	 * for certain that hookdir commands are not.
> > +	 */
> > +	if (hook->from_hookdir)
> > +		cp->use_shell = 0;
> > +	else
> > +		cp->use_shell = 1;
> > +
> > +	/* add command */
> > +	strvec_push(&cp->args, hook->command.buf);
> > +
> > +	/*
> > +	 * add passed-in argv, without expanding - let the user get back
> > +	 * exactly what they put in
> > +	 */
> > +	strvec_pushv(&cp->args, hook_cb->options->args.v);
> 
> I just skimmed over this setup-process-for-hook part - it would have
> been much clearer if it was refactored into its own function before this
> patch (or better yet, written as its own function in the first place).
> As it is, there are some unnecessary rewritings - e.g. setting stdin
> after env, and the use_shell setup.

Yeah, that makes sense. Will see if I can change it for next round :)

> 
> > diff --git a/hook.h b/hook.h
> 
> [snip]
> 
> > +/*
> > + * Callback provided to feed_pipe_fn and consume_sideband_fn.
> > + */
> > +struct hook_cb_data {
> > +	int rc;
> > +	struct list_head *head;
> > +	struct list_head *run_me;
> > +	struct run_hooks_opt *options;
> > +};
> 
> Could this be in hook.c instead?

It ends up being needed publicly by
https://lore.kernel.org/git/20201222000435.1529768-17-emilyshaffer@google.com
(receive-pack: convert receive hooks to hook.h), which writes its own
stdin provider callback. (In a later commit, a "void* options" gets
added to this struct.)

At that point it's needed because the run-command callback structure can
provide one context pointer for the overall work queue, and one context
pointer for the individual task; this one is the "overall work queue"
pointer.

From hook.h's perspective, the entire hook_cb_data is needed for
pick_next_hook; but run-command.h:run_processes_parallel() doesn't have
a way to tease out a smaller amount of the context pointer for various
callbacks. If we wanted to obfuscate "hook_cb_data" we'd need to add
another indirection and call back to hook.h first, who could then tease
out the client-provided context and then call the client callback, but
to me it sounds unnecessarily complex.

> 
> Also, I think it's clearer if run_me was a struct hook, and set to NULL
> when iteration reaches the end. If you disagree, I think it needs some
> documentation (e.g. "the embedded linked list part of the hook that must
> be run next; if equal to head, then iteration has ended" or something
> like that).

Yeah, I don't see a huge reason not to do that, sure.

> 
> > +#define RUN_HOOKS_OPT_INIT_SYNC  {   		\
> >  	.env = STRVEC_INIT, 			\
> >  	.args = STRVEC_INIT, 			\
> >  	.path_to_stdin = NULL,			\
> > +	.jobs = 1,				\
> >  	.run_hookdir = configured_hookdir_opt()	\
> >  }
> 
> This is not used anywhere.

It is used in part II by hooks which are not able to be parallelized.

 - Emily
