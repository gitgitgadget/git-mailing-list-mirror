Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CC3C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E8CA60E52
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhGWIvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGWIvh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 04:51:37 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048BAC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:32:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id he41so2751929ejc.6
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=vBohQUfUxejStetl2F9nkKgRG8l7eOFTqcLCVrM1yBI=;
        b=AW4EOlWB+7rYvBWgKAGkkbtlOA2dfd6PEpISRvwEYfk6TDMfyTvUHUYevj9BcNo4kg
         bxq2hv9LQ1hBGyT2SkUm714Zw6o4Gy0eQmW6xHP6vRkY691Kskr4e4f7btEO73vZxc2i
         hs1Q21Ulp3seQhKN40VDnVnbJsWBSQg/pezclONIlacwj1T27dlMtUEKU7THJJnNv8TA
         rA/nlYQNXqC2ZYZdx8FdfGbvkEMbCuD84b4P4QPYLv5O3vSJvt+EnWHWnZFViPQL9M7O
         +642XhmdAa/H1+PKLlmg+Njk5gyvPbzRtbkWjLAk9A+EVZnri1kBXOKEqw/n2XbMCIyi
         IBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=vBohQUfUxejStetl2F9nkKgRG8l7eOFTqcLCVrM1yBI=;
        b=GKng+LDW0Jm96QaqjdksxUHgSQkEzgxi1guXGmUK/xTAI1LZ6Pf1ZJvYYBqX5MOVgM
         clZoT24ZrmlOBCI24rphtgP7D93nLR7rZqEQHfrKoCbVMSvAw9d7NBK8/XVbUKv0pOQ1
         7BpMVI1U9lYWC1Mx0rMdegPoy1N/bvRYbL0T6Ghi3CJHoHh7WWNNJjc+f/R1GDiAnpmS
         P+1C1AWZccIs5KhCuoyzvZUmwdRnGAOTMZbOtWVHTFI1RQQmiQmDRlbiLH6pU5KCvMUx
         07Ze2Y1j/HF1rzE9je255SDLCe30IwvmjBsBBs4xvibChpIlCOD0kx1oHldRF876kOe1
         gS/w==
X-Gm-Message-State: AOAM5301wnHzDzhNmQWyheMuwrMFcPctnEf4ZcHWsJ+f0SuEKvylmc4o
        7eSD/YU8IlFkMhaHp4g/KgU=
X-Google-Smtp-Source: ABdhPJylcLQ9nvu076wV/KVKoD1gOLftQTk7jVlmzKlHRdzMLaDyuuJTrZ1Hc2WWppn8bRPPO5gI8w==
X-Received: by 2002:a17:906:4f14:: with SMTP id t20mr3704049eju.12.1627032728557;
        Fri, 23 Jul 2021 02:32:08 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n2sm13694658edi.32.2021.07.23.02.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 02:32:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/9] hook: allow parallel hook execution
Date:   Fri, 23 Jul 2021 11:30:47 +0200
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-3-emilyshaffer@google.com>
 <87r1fyy728.fsf@evledraar.gmail.com> <YPnfWfHMWTWvJJkH@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPnfWfHMWTWvJJkH@google.com>
Message-ID: <87wnphs7de.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, Emily Shaffer wrote:

> On Fri, Jul 16, 2021 at 10:36:10AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>>=20
>> On Thu, Jul 15 2021, Emily Shaffer wrote:
>>=20
>> > In many cases, there's no reason not to allow hooks to execute in
>> > parallel. run_processes_parallel() is well-suited - it's a task queue
>> > that runs its housekeeping in series, which means users don't
>> > need to worry about thread safety on their callback data. True
>> > multithreaded execution with the async_* functions isn't necessary her=
e.
>> > Synchronous hook execution can be achieved by only allowing 1 job to r=
un
>> > at a time.
>> >
>> > Teach run_hooks() to use that function for simple hooks which don't
>> > require stdin or capture of stderr.
>>=20
>> This doesn't mention...
>>=20
>> >  	int ret;
>> > -	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
>> > +	struct run_hooks_opt opt;
>> >=20=20
>> > +	run_hooks_opt_init_sync(&opt);
>>=20
>>=20
>> ...why we need to bring the s/macro/func/ init pattern, back, but lookin=
g ahead...
>>=20
>> > +int configured_hook_jobs(void)a
>> > +{
>> > +	int n =3D online_cpus();
>> > +	git_config_get_int("hook.jobs", &n);
>> > +
>> > +	return n;
>> > +}
>> > +
>> >  int hook_exists(const char *name)
>> >  {
>> >  	return !!find_hook(name);
>> > @@ -117,6 +125,26 @@ struct list_head* hook_list(const char* hookname)
>> >  	return hook_head;
>> >  }
>> >=20=20
>> > +void run_hooks_opt_init_sync(struct run_hooks_opt *o)
>> > +{
>> > +	strvec_init(&o->env);
>> > +	strvec_init(&o->args);
>> > +	o->path_to_stdin =3D NULL;
>> > +	o->jobs =3D 1;
>> > +	o->dir =3D NULL;
>> > +	o->feed_pipe =3D NULL;
>> > +	o->feed_pipe_ctx =3D NULL;
>> > +	o->consume_sideband =3D NULL;
>> > +	o->invoked_hook =3D NULL;
>> > +	o->absolute_path =3D 0;
>> > +}
>> > +
>> > +void run_hooks_opt_init_async(struct run_hooks_opt *o)
>> > +{
>> > +	run_hooks_opt_init_sync(o);
>> > +	o->jobs =3D configured_hook_jobs();
>> > +}
>>=20
>> ...okey, so it's because you brought back the "call jobs function" in
>> one of the init functions.
>>=20
>> I had a comment in a previous round, I found
>> https://lore.kernel.org/git/87lf7bzbrk.fsf@evledraar.gmail.com/, but I
>> think there was a later one where I commented on the "jobs" field
>> specifically.
>>=20
>> Anyway, it seems much easier to me to just keep the simpler macro init
>> and then:
>>=20
>> > -	if (options->jobs !=3D 1)
>> > -		BUG("we do not handle %d or any other !=3D 1 job number yet", optio=
ns->jobs);
>> > -
>> >  	run_processes_parallel_tr2(options->jobs,
>> >  				   pick_next_hook,
>> >  				   notify_start_failure,
>>=20
>> There's this one place where we use the "jobs" parameter, just do
>> something like this there:
>>=20=20=20=20=20=20=20=20=20
>>         int configured_hook_jobs(void)
>>         {
>>                 static int jobs;
>>                 if (!jobs)
>>                     return jobs;
>>                 if (git_config_get_int("hook.jobs", &jobs))
>>                     jobs =3D online_cpus();
>>                 return jobs;
>>         }
>>=20
>> I.e. you also needlessly call online_cpus() when we're about to override
>> it in the config. The git_config_get_int()'s return value indicates
>> whether you need to do that. Then just:
>>=20
>>     int jobs =3D options->jobs ? options->jobs : configured_hook_jobs();
>>     run_processes_parallel_tr2(jobs, [...]);
>
> Ahh, and then let RUN_HOOKS_OPT_INIT_ASYNC set jobs to 0 ("go look it
> up"). Yeah, that makes sense.
>
> Shout if somehow you meant to leave just one initializer macro;
> otherwise, I'll do it this way - with RUN_HOOKS_OPT_INIT_ASYNC and
> RUN_HOOKS_OPT_INIT_SYNC. I think it's valuable for hook callers to make
> it very plain at the callsite whether they're parallelizable or not, and
> I think
>
>  struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
>  opt.jobs =3D 0;
>
> doesn't make that as obvious.

Yes agreed, sorry about the ambiguity, I meant we should have two init
macros, just like e.g. STRING_LIST_INIT_NODUP and STRING_LIST_INIT_DUP.
