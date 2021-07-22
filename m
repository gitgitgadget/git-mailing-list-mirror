Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDAFC4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F67560EB3
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhGVUcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhGVUcb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:32:31 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B07C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:13:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c11so660070plg.11
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=686cnFL0i0Q43qx2mZ/DUD39IazmEkPTqxg980kojsI=;
        b=jYqpaAVHvJTESiG9YjeM+Q196yVyBjO+qC9WYKlw4dtylebRx1hwpaO65r4bVI6GKd
         GBoIrrl2bkruTj1/ovAy9vXAe4fAw6gcWzzMhVCDrLQ1ZSqQ+TD9F5oqdtJ5r1INu0iG
         qzKUZ++me981XcCZsQcyb8d5/ulQgT9s4AHFJk8xOOpjISU+/F27IZQek8J5yoerXIHw
         F+1CfPgE94scE4gNxmcfX+Pq0mTQhOuVS2+Uf8GtpSeJCOH+ld4WPtiLUIu5AA72CQdY
         RnY/Kw1znxjk+YxCXRvf/0qvjcGsJmzMsT5Z/Hdvx+lYOAhHOcjrIirKJAD59M6I8qsl
         nc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=686cnFL0i0Q43qx2mZ/DUD39IazmEkPTqxg980kojsI=;
        b=o5Dzy7stAGC3/tmYqM6+EMHAHNw+TbcQRyQYPJereBTCIO4q6tIIy4EGeGDxXusjSp
         sKgk/YVWU3hHDgMGi0JeYg8jYnWzEDAbfhBeMUGkl+rkmUTad7oebac9wOgn6BSuvD7V
         dG8YwHyTPZ5+sM+lDxGIsNCvIw0iKc74/tTXxd92fdxuR6Lau33Fjw6Sxv8A7T44pLih
         wMXyZNxblXFDpqiUDuSJ00NhX4gvVUNz8hSlGKooBAkvvQrLtRum+82SqtjABs6J6gHB
         5Dm48mte7omZp21MZq0X18hwCmKPPuPdnXZO20jcBoN8ZYHJO0fiwKlvvrZcrvbT6QgL
         AGbQ==
X-Gm-Message-State: AOAM533v3KvzW//7lGX+rGLRF1eWDNh3qVLs/bFsZ2td20xC9WNYXyIM
        hPdmVOB3FLV5UH51HpWFZzug+A==
X-Google-Smtp-Source: ABdhPJwpZZGTjcz4sZKBUOPOkYqDnGM8LuVaUhGmM01RV9K9YWtSimeHT+8CkDfY1oaZ89Ygnz4jYQ==
X-Received: by 2002:a17:902:c64b:b029:12a:d8db:d0fe with SMTP id s11-20020a170902c64bb029012ad8dbd0femr1329929pls.11.1626988384210;
        Thu, 22 Jul 2021 14:13:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:83f3:cefc:ff34:3095])
        by smtp.gmail.com with ESMTPSA id y4sm3920011pjg.9.2021.07.22.14.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:13:03 -0700 (PDT)
Date:   Thu, 22 Jul 2021 14:12:57 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/9] hook: allow parallel hook execution
Message-ID: <YPnfWfHMWTWvJJkH@google.com>
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-3-emilyshaffer@google.com>
 <87r1fyy728.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1fyy728.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 10:36:10AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Jul 15 2021, Emily Shaffer wrote:
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
> This doesn't mention...
> 
> >  	int ret;
> > -	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> > +	struct run_hooks_opt opt;
> >  
> > +	run_hooks_opt_init_sync(&opt);
> 
> 
> ...why we need to bring the s/macro/func/ init pattern, back, but looking ahead...
> 
> > +int configured_hook_jobs(void)a
> > +{
> > +	int n = online_cpus();
> > +	git_config_get_int("hook.jobs", &n);
> > +
> > +	return n;
> > +}
> > +
> >  int hook_exists(const char *name)
> >  {
> >  	return !!find_hook(name);
> > @@ -117,6 +125,26 @@ struct list_head* hook_list(const char* hookname)
> >  	return hook_head;
> >  }
> >  
> > +void run_hooks_opt_init_sync(struct run_hooks_opt *o)
> > +{
> > +	strvec_init(&o->env);
> > +	strvec_init(&o->args);
> > +	o->path_to_stdin = NULL;
> > +	o->jobs = 1;
> > +	o->dir = NULL;
> > +	o->feed_pipe = NULL;
> > +	o->feed_pipe_ctx = NULL;
> > +	o->consume_sideband = NULL;
> > +	o->invoked_hook = NULL;
> > +	o->absolute_path = 0;
> > +}
> > +
> > +void run_hooks_opt_init_async(struct run_hooks_opt *o)
> > +{
> > +	run_hooks_opt_init_sync(o);
> > +	o->jobs = configured_hook_jobs();
> > +}
> 
> ...okey, so it's because you brought back the "call jobs function" in
> one of the init functions.
> 
> I had a comment in a previous round, I found
> https://lore.kernel.org/git/87lf7bzbrk.fsf@evledraar.gmail.com/, but I
> think there was a later one where I commented on the "jobs" field
> specifically.
> 
> Anyway, it seems much easier to me to just keep the simpler macro init
> and then:
> 
> > -	if (options->jobs != 1)
> > -		BUG("we do not handle %d or any other != 1 job number yet", options->jobs);
> > -
> >  	run_processes_parallel_tr2(options->jobs,
> >  				   pick_next_hook,
> >  				   notify_start_failure,
> 
> There's this one place where we use the "jobs" parameter, just do
> something like this there:
>         
>         int configured_hook_jobs(void)
>         {
>                 static int jobs;
>                 if (!jobs)
>                     return jobs;
>                 if (git_config_get_int("hook.jobs", &jobs))
>                     jobs = online_cpus();
>                 return jobs;
>         }
> 
> I.e. you also needlessly call online_cpus() when we're about to override
> it in the config. The git_config_get_int()'s return value indicates
> whether you need to do that. Then just:
> 
>     int jobs = options->jobs ? options->jobs : configured_hook_jobs();
>     run_processes_parallel_tr2(jobs, [...]);

Ahh, and then let RUN_HOOKS_OPT_INIT_ASYNC set jobs to 0 ("go look it
up"). Yeah, that makes sense.

Shout if somehow you meant to leave just one initializer macro;
otherwise, I'll do it this way - with RUN_HOOKS_OPT_INIT_ASYNC and
RUN_HOOKS_OPT_INIT_SYNC. I think it's valuable for hook callers to make
it very plain at the callsite whether they're parallelizable or not, and
I think

 struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 opt.jobs = 0;

doesn't make that as obvious.

> 
> Or some such, i.e. we can defer getting the job number away from startup
> to when we actually need to start those jobs, and your whole use of a
> function init pattern came down to doing that really early.
> 
> As an aside if you /do/ need to do init-via-function my 5726a6b4012 (*.c
> *_init(): define in terms of corresponding *_INIT macro, 2021-07-01) in
> "next" shows a much nicer way to do that. I.e. you'd just do:
> 
>     void run_hooks_opt_init_sync(struct run_hooks_opt *o)
>     {
>          struct run_hooks_opt blank = RUN_HOOKS_OPT_INIT;
>          memcpy(o, &blank, sizeof(*o));
>     }
> 
>     void run_hooks_opt_init_async(struct run_hooks_opt *o)
>     {
>         run_hooks_opt_init_sync(o);
>         o->jobs = configured_hook_jobs();
>     }
> 
> In some cases we do actually need to do init via functions, but can init
> a large option via the macro, which IMO is nicer to read, but here I
> think we don't need the functions at all per the above.
