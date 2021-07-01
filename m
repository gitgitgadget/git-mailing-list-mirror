Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80A6C11F69
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 747E961416
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbhGAWm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 18:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhGAWm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 18:42:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7726C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 15:40:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id l24so10596918edr.11
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 15:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=z/aRFxteEUS3zZeMDklg/lmgk7pQWP1Hphbnf+6MdZ8=;
        b=HkYA9+0RNZmyiXoyQ0TtU9MfxvipXQ9fN4TI1g1VfevIS9w1M4vDEm1tkGjQ9eGo1r
         kqHzWavvEdvfMPp1c5o1XwrG+ghrg7MYFV8dBWzlfofV74FxZZzTv/c6Og0jI3PeYtDR
         tXbRHgIqIa9kKMDASHNTqvhVjgdt5CBPKuWa0xjFwZuhJ7bAGOmWMRmtL5fDDh+x//9p
         FVKBpAEI7cWqC7O+yfIfDzd+/xL8H6eFLOIwLvXm6pUHkHB+DVDotmkbQ4HVabGJcUqo
         jt5iGcPK9HcgA8clu46uha77mzi0HL/06eVl8VJI9gsZybLxTTZznvzzxMtq7fPnRtAd
         SbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=z/aRFxteEUS3zZeMDklg/lmgk7pQWP1Hphbnf+6MdZ8=;
        b=ukQjItGbBAAmZ+mhtTgkgKoAQ1/M6WE/+8FbPNpGbJAh1ehGc7dAEUpt0pu4mpu1FH
         My57lGX8L8kxw1bQHLaBQM9h5FC9pT86jGcCO9SDAX9NNp//GoKDSKFeh7Tvb8Vsi+/c
         wjDzAARngm5Cjr75qaDLSj1eQZtW9QsnMrx8xNNjDgthUAGaMSvCf66c/76vfm2rueDJ
         xm4UjM/ycKAaZj/2T52IC0k0AZs+kBKzS+Aaa3w0Bgi+NiWYxo1nv1vCmKp2HGDvmN4e
         DP72HFpxp7cuokHjxfBl4VQ+aXQkdhdRWoFFMz5EL8paxqwvwRMmbg9KVrOccXQlGK6Z
         OFaQ==
X-Gm-Message-State: AOAM532/Uv9DcK4lkjp4I+MQ2zeCBzMBmLCNCoYsqn5oQLObTq1JdkMr
        nZENsG1/T/OuLYZjGfKxrGsVClj3tEwVwA==
X-Google-Smtp-Source: ABdhPJwn8hAYQkKSW5yxAkQy7bOgEyi9O7v6wBSGQwJtSvzZORqLLS80HOWXUidgtLQjEkz/kR/yhw==
X-Received: by 2002:aa7:cc0c:: with SMTP id q12mr2838532edt.90.1625179224846;
        Thu, 01 Jul 2021 15:40:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p26sm372902ejn.106.2021.07.01.15.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 15:40:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 08/34] fsmonitor--daemon: add a built-in fsmonitor
 daemon
Date:   Fri, 02 Jul 2021 00:36:57 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <f88db92d4259d1c29827e97e957daf6eda39c551.1625150864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <f88db92d4259d1c29827e97e957daf6eda39c551.1625150864.git.gitgitgadget@gmail.com>
Message-ID: <871r8hd5ew.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:

A general comment on this series (including previous patches). We've
usually tried to bend over backwards in git's codebase not to have big
ifdef blocks, so we compile most code the same everywhere. We waste a
bit of object code, but that's fine.

See 9c897c5c2ad (pack-objects: remove #ifdef NO_PTHREADS, 2018-11-03)
for a good exmaple of bad code being turned to good.

E.g. in this case:

> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
> +
> +int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
> +{
> +	const char *subcmd;
> +
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	if (argc < 2)
> +		usage_with_options(builtin_fsmonitor__daemon_usage, options);
> +
> +	if (argc == 2 && !strcmp(argv[1], "-h"))
> +		usage_with_options(builtin_fsmonitor__daemon_usage, options);
> +
> +	git_config(git_default_config, NULL);
> +
> +	subcmd = argv[1];
> +	argv--;
> +	argc++;
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     builtin_fsmonitor__daemon_usage, 0);
> +
> +	die(_("Unhandled subcommand '%s'"), subcmd);
> +}
> +
> +#else
> +int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
> +{
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	if (argc == 2 && !strcmp(argv[1], "-h"))
> +		usage_with_options(builtin_fsmonitor__daemon_usage, options);
> +
> +	die(_("fsmonitor--daemon not supported on this platform"));
> +}
> +#endif

This whole thing could really just be a
-DHAVE_FSMONITOR_DAEMON_BACKEND=1 or -DHAVE_FSMONITOR_DAEMON_BACKEND=0
somewhere (depending), and then somewhere in the middle of the first
function:

	if (!HAVE_FSMONITOR_DAEMON_BACKEND)
	    	die(_("fsmonitor--daemon not supported on this platform"));
