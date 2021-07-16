Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58AAC636CB
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 08:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9481B613DA
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 08:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238357AbhGPIzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbhGPIzE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 04:55:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DA6C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 01:52:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qb4so13993186ejc.11
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=7D5A/4S3gK9uPqquPF2JuMbITb/Ujcu7qigxYWEr6SE=;
        b=SFByAQAizZ4xt337sl2uK9N+fhYWm60AsHS/Rgs6rX8arfa5H8VEYkkSJHA4rN3J4Y
         PBATYfjMMMUCWgZBPtoROtmGX8pec8mgDAIzYRL66bdJofxfQbqW+3gCkQRISL8EgAoS
         g3CkukQN4DEPkz0GjwKK+QsOabvxgrgdRszHWA7VAMXRdcDxSNZr59lnlUEs8ihh4sGL
         xHGpkvoj3ZhxJuqIxPQAbYh00QD+g7zeZWdL+W/Hrwl6fp0INcdhR74T2EzILr5gsroP
         s2ZK60G10ItXo+7JJqcxAdT1oBxbM/WhiUIUGtelAjhoq5963IF71KGXMnH1dTxeSAqs
         k5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=7D5A/4S3gK9uPqquPF2JuMbITb/Ujcu7qigxYWEr6SE=;
        b=asnSQGWlbPVt6sMmxOUgze/FOjDsiB0ZPkDkBSRvjOXFc25uzDMl3g3a3JeOteF6VB
         tqyz/p3tOGmuRzWwRp2Tn/SisufvdqeNfWZmu8mbmlwVtxoCQpDa2evPTGz2OFzD5wLp
         B8BYKqwdvOmH3dur9Xdyr41HxCHYH+AoX0J67xhBRuiK76rpU6iadi27p2PM67OxCnU3
         mIXp2GQO4kjuhsw3JZgyrNtFDtIX11t3sX6dfLdpF+mi+HWmifAP+YTETDqu0tLLbKtZ
         wlS/66J3TaiO/LfQTTsoLJhlkt/oDePEkCznPjymg3sSCtC3LFAye1H7YtFVnKgS0OVC
         bSSw==
X-Gm-Message-State: AOAM532uVGqNkEMIQRdJ9QuQY5EmYxFXyTgvDzti3fXXKBIH7NRJWweY
        Tw06CL7MrpY658U9SYxD1IehTOpvuRY=
X-Google-Smtp-Source: ABdhPJxGdumbqRNr4GdgrE+ZxBu90M3sM+cfN76dBktcqx2DGSQ/YtSpxxX/UN+OL1M8JdvWWRNtUQ==
X-Received: by 2002:a17:907:2151:: with SMTP id rk17mr10682351ejb.3.1626425528612;
        Fri, 16 Jul 2021 01:52:08 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id cb4sm2649949ejb.72.2021.07.16.01.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 01:52:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/9] hook: allow parallel hook execution
Date:   Fri, 16 Jul 2021 10:36:10 +0200
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-3-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210715232603.3415111-3-emilyshaffer@google.com>
Message-ID: <87r1fyy728.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 15 2021, Emily Shaffer wrote:

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

This doesn't mention...

>  	int ret;
> -	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> +	struct run_hooks_opt opt;
>  
> +	run_hooks_opt_init_sync(&opt);


...why we need to bring the s/macro/func/ init pattern, back, but looking ahead...

> +int configured_hook_jobs(void)a
> +{
> +	int n = online_cpus();
> +	git_config_get_int("hook.jobs", &n);
> +
> +	return n;
> +}
> +
>  int hook_exists(const char *name)
>  {
>  	return !!find_hook(name);
> @@ -117,6 +125,26 @@ struct list_head* hook_list(const char* hookname)
>  	return hook_head;
>  }
>  
> +void run_hooks_opt_init_sync(struct run_hooks_opt *o)
> +{
> +	strvec_init(&o->env);
> +	strvec_init(&o->args);
> +	o->path_to_stdin = NULL;
> +	o->jobs = 1;
> +	o->dir = NULL;
> +	o->feed_pipe = NULL;
> +	o->feed_pipe_ctx = NULL;
> +	o->consume_sideband = NULL;
> +	o->invoked_hook = NULL;
> +	o->absolute_path = 0;
> +}
> +
> +void run_hooks_opt_init_async(struct run_hooks_opt *o)
> +{
> +	run_hooks_opt_init_sync(o);
> +	o->jobs = configured_hook_jobs();
> +}

...okey, so it's because you brought back the "call jobs function" in
one of the init functions.

I had a comment in a previous round, I found
https://lore.kernel.org/git/87lf7bzbrk.fsf@evledraar.gmail.com/, but I
think there was a later one where I commented on the "jobs" field
specifically.

Anyway, it seems much easier to me to just keep the simpler macro init
and then:

> -	if (options->jobs != 1)
> -		BUG("we do not handle %d or any other != 1 job number yet", options->jobs);
> -
>  	run_processes_parallel_tr2(options->jobs,
>  				   pick_next_hook,
>  				   notify_start_failure,

There's this one place where we use the "jobs" parameter, just do
something like this there:
        
        int configured_hook_jobs(void)
        {
                static int jobs;
                if (!jobs)
                    return jobs;
                if (git_config_get_int("hook.jobs", &jobs))
                    jobs = online_cpus();
                return jobs;
        }

I.e. you also needlessly call online_cpus() when we're about to override
it in the config. The git_config_get_int()'s return value indicates
whether you need to do that. Then just:

    int jobs = options->jobs ? options->jobs : configured_hook_jobs();
    run_processes_parallel_tr2(jobs, [...]);

Or some such, i.e. we can defer getting the job number away from startup
to when we actually need to start those jobs, and your whole use of a
function init pattern came down to doing that really early.

As an aside if you /do/ need to do init-via-function my 5726a6b4012 (*.c
*_init(): define in terms of corresponding *_INIT macro, 2021-07-01) in
"next" shows a much nicer way to do that. I.e. you'd just do:

    void run_hooks_opt_init_sync(struct run_hooks_opt *o)
    {
         struct run_hooks_opt blank = RUN_HOOKS_OPT_INIT;
         memcpy(o, &blank, sizeof(*o));
    }

    void run_hooks_opt_init_async(struct run_hooks_opt *o)
    {
        run_hooks_opt_init_sync(o);
        o->jobs = configured_hook_jobs();
    }

In some cases we do actually need to do init via functions, but can init
a large option via the macro, which IMO is nicer to read, but here I
think we don't need the functions at all per the above.
