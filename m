Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAA9C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 23:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B0060D07
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 23:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhHQAA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 20:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbhHQAA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 20:00:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82A7C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 16:59:54 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so3048793pjb.3
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 16:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5RW62agxqoEmTlnffopSXdJHpwfVgOeEdpVy+gSgDTQ=;
        b=IPNNYuaX28E6czJFqc+p/4o1NvX4Hz6A6gZ5foXOABfzfwamtIybIeZXBgrOWMX3MZ
         XmEz2Auc2QrTyK4OVSCwmSnb8VQrQZIrR1ySX8HPter8RZJem1DcewVsnWmTt0HPGkQX
         T1KXhnKS+U3Y/Na0LW6sTghPCOqGnxXhinv7e+RNLVUTZ+H8KTDxVamDmdn1AAhg2/YO
         +NeZ1DTtPnySDNQDLjCItjH32QcNugRDdpiXbVlgu8ndzJKdz31hbQCx5hEiiSXkxQIP
         TrwbX8iNY27ynaQffOdLcUsnKK5d1LdLSn5t1jEwQrmUsT5mNJ5cbPpGH3FGjAonhy04
         GxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5RW62agxqoEmTlnffopSXdJHpwfVgOeEdpVy+gSgDTQ=;
        b=oaJyeSjXdxSZ6hsSGvwj3IIwI0Jarq8iD1f9LvrQe3rkm49B4ptPxvqt/Iph7huckT
         YjLtOghoAwCEq2LUAchDudWkxOcEcPnzwRv7dB6SixMp6GCtyYVWqfykiCTQQBxIaYUv
         7LTLcX5AZMrO3DlFcHqtVrMjxwDVW+h/QWcR1b4cavheBYxZVPK+D5yztUSChqphXzar
         K3HYKHzNBu6pUhkUOMHtVWE2W3fTUDwcjdjf2JS3OOvz7Y/gyLMVWwuFzCPSxt4gL3J/
         LmM75owyl7VU5xFuIflWGwEpQYSwqzQxcJRsVW04yhrBE5hY25E0x3MD14Uzp9/Jk6Hy
         YrHg==
X-Gm-Message-State: AOAM532Fds5qdgOErd6VgIBZhNW2i7CTGrdTdqSrbu6oGf9xwlyx4kvs
        ptgl642CJrEBzavHMbwYUJHl2Q==
X-Google-Smtp-Source: ABdhPJxI7bkVYTiIbUgfR2/Sud18sEhBFae7gRcYC5z4TALmE9aXj2Yn9EWdduxqytKxFjfmHRcu6w==
X-Received: by 2002:a17:90a:fa3:: with SMTP id 32mr555010pjz.68.1629158393959;
        Mon, 16 Aug 2021 16:59:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:aa0c:5f92:878f:e03a])
        by smtp.gmail.com with ESMTPSA id e7sm278556pfc.145.2021.08.16.16.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 16:59:53 -0700 (PDT)
Date:   Mon, 16 Aug 2021 16:59:45 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 2/6] hook: allow parallel hook execution
Message-ID: <YRr78f5YgGjBmBYp@google.com>
References: <20210812004258.74318-1-emilyshaffer@google.com>
 <20210812004258.74318-3-emilyshaffer@google.com>
 <xmqqmtpm4kmy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmtpm4kmy.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 10:51:01AM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
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
> Since run_hooks() has been using run_processes_parallel_tr2()
> already in the ab/config-based-hooks-base topic, the above
> description puzzled me quite a bit.  I think you meant to say with
> this step you update the callers to pass either .jobs=1 or .jobs=0
> in the hooks_opt, so that hooks _can_ run in parallel (as opposed
> to using hardcoded jobs=1 in run_hooks() when calling the underlying
> run_processes_parallel_tr2() function).

I think you are right, and this commit message is from a much older
version of the series. Ok; I will reword it. I think it can be much
simpler.

> 
> I do not think SYNC and ASYNC are great adjectives for what you are
> doing in this step.  Wouldn't ASYNC mean "the caller tells the hooks
> to run, continues without waiting for them to finish"?  In order to
> let more than one hooks to run at the same time, the caller has to
> continue without waiting for the first one it started so that it can
> start the second one before the first one finishes (otherwise these
> two hooks will not run at the same time), but ASYNC implys a lot
> more than that.  After starting all of these hooks, the caller may
> continue doing things that are not even related to these spawned
> hooks if a hook is run asynchronously.
> 
> But I do not think that is what is happening here.  After all,
> run_processes_parallel_tr2() will not return until all of the
> subprocesses are culled.
> 
> Perhaps the distinction you are trying to express is easier to
> convey to readers if you instead used the verb TO RUN with the
> adverb SERIALLY vs IN PARALLEL (as opposed to SYNCHRONOUSLY vs
> ASYNCHRONOUSLY)?

Good point. I think you are right and I'll change the init macros to
SERIAL/PARALLEL instead.

> 
> > diff --git a/builtin/hook.c b/builtin/hook.c
> > index 4d39c9e75e..12c9126032 100644
> > --- a/builtin/hook.c
> > +++ b/builtin/hook.c
> > @@ -22,7 +22,7 @@ static const char * const builtin_hook_run_usage[] = {
> >  static int run(int argc, const char **argv, const char *prefix)
> >  {
> >  	int i;
> > -	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> > +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SYNC;
> >  	int ignore_missing = 0;
> >  	const char *hook_name;
> >  	struct list_head *hooks;
> > @@ -32,6 +32,8 @@ static int run(int argc, const char **argv, const char *prefix)
> >  			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
> >  		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
> >  			   N_("file to read into hooks' stdin")),
> > +		OPT_INTEGER('j', "jobs", &opt.jobs,
> > +			    N_("run up to <n> hooks simultaneously")),
> >  		OPT_END(),
> >  	};
> >  	int ret;
> 
> OK, so by default "git hook" runs 1 at a time but we can instruct to
> run the optimal number of jobs via "git hook -j0" etc.

Is it surprising for an explicitly provided "-j0" to still be overridden
by a config if one was provided? That is, "-j0" doesn't mean
"-j$(nproc)" as it does in many other Unixy tools, here. It means
"-j(hook.jobs OR $(nproc))". I guess you could also say that "if you
configured hook.jobs, it is because you decided nproc was less optimal
than the value you put into hook.jobs" - so maybe it is fine?

> 
> > diff --git a/hook.c b/hook.c
> > index 80e150548c..37f682c6d8 100644
> > --- a/hook.c
> > +++ b/hook.c
> > @@ -228,6 +228,28 @@ static int notify_hook_finished(int result,
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Determines how many jobs to use after we know we want to parallelize. First
> > + * priority is the config 'hook.jobs' and second priority is the number of CPUs.
> > + */
> > +static int configured_hook_jobs(void)
> > +{
> > +	/*
> > +	 * The config and the CPU count probably won't change during the process
> > +	 * lifetime, so cache the result in case we invoke multiple hooks during
> > +	 * one process.
> > +	 */
> > +	static int jobs = 0;
> > +	if (jobs)
> > +		return jobs;
> > +
> > +	if (git_config_get_int("hook.jobs", &jobs))
> > +		/* if the config isn't set, fall back to CPU count. */
> > +		jobs = online_cpus();
> > +
> > +	return jobs;
> > +}
> 
> Not a suggestion to make this improvement as a part of this series,
> but there already are more than several codepaths doing essentially
> the same thing as above, taking their own configuration or
> environment variables and falling back to online_cpus().
> 
> It may be worth introducing a shared helper function so that this
> can become
> 
> 	static int configured_hook_jobs(void)
> 	{
> 		static int jobs; /* no need for "= 0" */
> 
> 		if (!jobs)
> 			jobs = default_parallelism("hook.jobs", NULL);
> 		return jobs;
> 	}
> 
> where the new helper takes the configuration and environment
> variable names.

Sounds handy.

 - Emily
