Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05231C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 19:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D707E60FD8
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 19:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhHXTa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 15:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhHXTa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 15:30:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1C8C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 12:30:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u14so21709521ejf.13
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 12:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=l5WbAkCYRYugeIweELmKyDRJYZ1NP4KU5qLYwjt5Tnk=;
        b=nDsdz7E8TlKT+tf0jSfEV57RrCrk06wQCQb+8Q3Muj8SNCiW55x/li7K9Lr/ZfEhGm
         wjx8ZzRwmFPqKvUz7QMcAGmGTAXLh/Msvhvl8+ILLXHPLQ4ttMX2/2SitEvWkeELGdhm
         X2bBRMfha6VTKFXT1JAhEyj3SKDDCY/9FpVFnzrqP1sz3y+3UfzQJNcZthPfKyfp1OVX
         CwRWgoCVE+px9cqcHhDCrX/X34KoOQnoYY0pAKAIe3aYoCRjKFPipxvLnkcx71kkGl4u
         xSVDZoGg4CpeApVSyJ1ytx8r+yfJCMNFytAe67vxuKW8dDXjMJ39gQZwD+UyI+tF6EwK
         LcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=l5WbAkCYRYugeIweELmKyDRJYZ1NP4KU5qLYwjt5Tnk=;
        b=P8MRA9G96P/56EiW4OJMkDxnpXgeJLlbYO1s3Hta5QqzYRb5ah02vxs0JBoYtshkXz
         exvJLSaX/ymMGXM309Y5StHhg2OMkJ4FsyM6MmROcDuzXONDy9sShIQLZcXlBP0B35Th
         sXiMI9AupZQLROwOiLQ0SJ31NSmCxrPSQiQm2PNroWD7EPA/YalSOGwWXBlOT22TZ/ZJ
         gDDaKyssr0irFb4HaQiRaEMzl9+vldCnaDYOMbrRQCb27opLxmoq+eucklPSEEsV2ez1
         YS5NMvLUTu6mEviPJi+YexB4aLGU5/4Ch4ReTbjkuyPswwT/vSShElZuv6EtvsB4A+v1
         AHFQ==
X-Gm-Message-State: AOAM532IQkKvLXojQGO10w3lHNVBD/vxEI8kDJMmSkNTYAFqW28A8Sxb
        zpDb3+LiGwhJ3C3FYWydOT8=
X-Google-Smtp-Source: ABdhPJxdMW6aWKvwhXIddDJzQ2M5hHGgJYA26z9JjZ5rVSoSkSJUGfWdSeBOa89ZiPwUcbOnyhYSbw==
X-Received: by 2002:a17:906:6d9:: with SMTP id v25mr43317776ejb.192.1629833410375;
        Tue, 24 Aug 2021 12:30:10 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s3sm9963911ejm.49.2021.08.24.12.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 12:30:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 4/6] hook: allow running non-native hooks
Date:   Tue, 24 Aug 2021 17:55:13 +0200
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-5-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210819033450.3382652-5-emilyshaffer@google.com>
Message-ID: <87o89mej3y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 18 2021, Emily Shaffer wrote:

> As the hook architecture and 'git hook run' become more featureful, we
> may find wrappers wanting to use the hook architecture to run their own
> hooks, thereby getting nice things like parallelism and idiomatic Git
> configuration for free. Enable this by letting 'git hook run' bypass the
> known_hooks() check.
>
> We do still want to keep known_hooks() around, though - by die()ing when
> an internal Git call asks for run_hooks("my-new-hook"), we can remind
> Git developers to update Documentation/githooks.txt with their new hook,
> which in turn helps Git users discover this new hook.
>
> [...]
>
> +It's possible to use this command to refer to hooks which are not native to Git,
> +for example if a wrapper around Git wishes to expose hooks into its own
> +operation in a way which is already familiar to Git users. However, wrappers
> +invoking such hooks should be careful to name their hook events something which
> +Git is unlikely to use for a native hook later on. For example, Git is much less
> +likely to create a `mytool-validate-commit` hook than it is to create a
> +`validate-commit` hook.
> +
>  SUBCOMMANDS
>  -----------

The goal here makes sense, but...

> diff --git a/builtin/hook.c b/builtin/hook.c
> index d21f303eca..80397d39f5 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -46,7 +46,7 @@ static int list(int argc, const char **argv, const char *prefix)
>  
>  	hookname = argv[0];
>  
> -	head = hook_list(hookname);
> +	head = list_hooks_gently(hookname);
>  
>  	if (list_empty(head))
>  		return 1;
> @@ -105,7 +105,7 @@ static int run(int argc, const char **argv, const char *prefix)
>  	git_config(git_default_config, NULL);
>  
>  	hook_name = argv[0];
> -	hooks = list_hooks(hook_name);
> +	hooks = list_hooks_gently(hook_name);
>  	if (list_empty(hooks)) {
>  		/* ... act like run_hooks_oneshot() under --ignore-missing */
>  		if (ignore_missing)

This introduces a bug v.s. the previous state, e.g. before:

    $ git hook run --ignore-missing foobar
    fatal: the hook 'foobar' is not known to git, should be in hook-list.h via githooks(5)

But after we'll silently ignore it. I.e. we've conflated
--ignore-missing with a new and hypothetical (and this is now a synonym
of) --ignore-missing-and-allow-unknown-hook-names.

So we've conflated the user's one-shot "foobar" script with wanting to
catch a typo in e.g. git-send-email.perl.

Also instead of the user's typos being caught with a die (here using
your BUG(...) version):

    $ git hook list pre-recive
    BUG: hook.c:115: Don't recognize hook event 'pre-recive'! Is it documented in Documentation/githooks.txt?
    Aborted

We'll now silently return 1, so indistinguishabl from typing it properly
as pre-receive.

All that being said I think it's arguable that if we're going to allow
"git hook run blahblah" that the die() in the base topic in my
"hook-list.h: add a generated list of hooks, like config-list.h" is more
trouble than it's worth.

I.e. do we really need to be concerned about new hooks being added and
someone forgetting a githooks.txt update, or a typo in the git.git code
that nobody notices? Probably not.

But I think the change here is clearly broken vis-a-vis the stated goals
of its commit message as it stands, i.e. "[...]we do still want to keep
known_hooks() around, though[...]". Should we fix it by adding a new
internal-only flag to the command, or just saying we shouldn't have the
behavior at all? What do you think.

Aside from that, this change seems to be untested, I tried making this
non-gentle for testing, and all tests still passed. I.e. we don't have
any tests for running such a hook like mytool-validate-commit, but
should as part of this change.
