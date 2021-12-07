Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E37C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 09:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhLGJVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 04:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbhLGJVU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 04:21:20 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3222C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 01:17:50 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r11so53988711edd.9
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 01:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=PkGRLUta2OlxQgJVBsXDsRlPw1eittvsWfd1LD+8CGY=;
        b=dC6TWYaWTkbqBUkwdxdVIaAIfiunNVqHbMhIqL4DRH6pnoUVSVtCWfe1eIGhp7AsPQ
         SIJMpQ27ITyQhc/B/OFUuhO2r5NY1Iqu92BSgPeAOHktrZN1GrSqFgIl5vUKi/AxSeEZ
         eWCatfqJW/zPeZZklA+qeZKfWm9lsO4V3yKx98a+nj/AJ4q/BumYb28PUfuekMTlbrfV
         cwDXtrOsWaApz/AwfGnHAklO657LXwJjW4o4GGnteLpZWdVFj8ndN5dxw+2B1koV7vqn
         N1mnK2ATovx4wwTbA9oUYyevbioIk6PxiX022hJ7RS6ocgZ7rjlOQUYG7Xme6ihrCo9Z
         5cMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=PkGRLUta2OlxQgJVBsXDsRlPw1eittvsWfd1LD+8CGY=;
        b=T+2vb9wjg+iLDMrGM3ZxlfGKMEHq+HCxNIrJSvNi9tyzsfxCzVWHSIPJN1J6w9CdFi
         G++++11iB+ipTh0NYKHag+LhHiHru7W3mkgvRVlAZpYsjgRTfxStiXh/2ZsyzAkyhJKJ
         AynZUkryp5wvDW96xsu/vFf8hlemdrXdGo0U1p7wvWpGw1n0V7ooI48jIwUauhsydaaE
         3Nrzz8U5ZoXN+osqz38WcxmfyrFQBqMgAjNkYbNVVISMAEuH/zT/4qTeQ3hP7G2ePdit
         4ujIcULB9Y9UfxoNkJjtjH/KYkR2yEc9QJTbHq7KCvzxlGlPC5tejnk3Mkj9pp8/twc9
         ROOw==
X-Gm-Message-State: AOAM530/PrOC0mUfvpMQ+dMUw6lVxYW0ovBoSUOmqb3ho3twOltb58Q1
        ZvjXInsrlkfW+8BfqYnjzQQOCeoqoR/68w==
X-Google-Smtp-Source: ABdhPJwAI45Oc7NkkuTyhN3ZEQ7In6M/owdcpwZM/gnVAsTaiadstrSpwneD+Y43ZNdnQDy18s+gXA==
X-Received: by 2002:a50:e608:: with SMTP id y8mr7278030edm.39.1638868669030;
        Tue, 07 Dec 2021 01:17:49 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sc27sm8663324ejc.125.2021.12.07.01.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 01:17:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muWbb-0013PF-78;
        Tue, 07 Dec 2021 10:17:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, chooglen@google.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v5 2/2] branch: add flags and config to inherit tracking
Date:   Tue, 07 Dec 2021 10:08:14 +0100
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com>
 <c7e4af9a365cc61e682c3c73045fb1ee4b79cfbf.1638859949.git.steadmon@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <c7e4af9a365cc61e682c3c73045fb1ee4b79cfbf.1638859949.git.steadmon@google.com>
Message-ID: <211207.86ilw0pydg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 06 2021, Josh Steadmon wrote:

> It can be helpful when creating a new branch to use the existing
> tracking configuration from the branch point. However, there is
> currently not a method to automatically do so.
>
> Teach git-{branch,checkout,switch} an "inherit" argument to the
> "--track" option. When this is set, creating a new branch will cause the
> tracking configuration to default to the configuration of the branch
> point, if set.
>
> For example, if branch "main" tracks "origin/main", and we run
> `git checkout --track=inherit -b feature main`, then branch "feature"
> will track "origin/main". Thus, `git status` will show us how far
> ahead/behind we are from origin, and `git pull` will pull from origin.
>
> This is particularly useful when creating branches across many
> submodules, such as with `git submodule foreach ...` (or if running with
> a patch such as [1], which we use at $job), as it avoids having to
> manually set tracking info for each submodule.
>
> Since we've added an argument to "--track", also add "--track=direct" as
> another way to explicitly get the original "--track" behavior ("--track"
> without an argument still works as well).
> @@ -10,7 +10,8 @@ enum branch_track {
>  	BRANCH_TRACK_REMOTE,
>  	BRANCH_TRACK_ALWAYS,
>  	BRANCH_TRACK_EXPLICIT,
> -	BRANCH_TRACK_OVERRIDE
> +	BRANCH_TRACK_OVERRIDE,
> +	BRANCH_TRACK_INHERIT
>  };

So we've got 5 items in this enum...

>  
>  extern enum branch_track git_branch_track;
> diff --git a/builtin/branch.c b/builtin/branch.c
> index b23b1d1752..ebde5023c3 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -632,8 +632,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		OPT__VERBOSE(&filter.verbose,
>  			N_("show hash and subject, give twice for upstream branch")),
>  		OPT__QUIET(&quiet, N_("suppress informational messages")),
> -		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-pull(1))"),
> -			BRANCH_TRACK_EXPLICIT),
> +		OPT_CALLBACK_F('t', "track",  &track, "direct|inherit",
> +			N_("set branch tracking configuration"),
> +			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
> +			parse_opt_tracking_mode),
>  		OPT_SET_INT_F(0, "set-upstream", &track, N_("do not use"),
>  			BRANCH_TRACK_OVERRIDE, PARSE_OPT_HIDDEN),

But map --track, --track=direct --track=inherit to 3/5 of them. Will it
ever make sense to do the oher 2/5 (I really haven't checked)....

>  		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("change the upstream info")),
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index b5d477919a..45dab414ea 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1532,8 +1532,10 @@ static struct option *add_common_switch_branch_options(
>  {
>  	struct option options[] = {
>  		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named commit")),
> -		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
> -			BRANCH_TRACK_EXPLICIT),
> +		OPT_CALLBACK_F('t', "track",  &opts->track, "direct|inherit",
> +			N_("set up tracking mode (see git-pull(1))"),
> +			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
> +			parse_opt_tracking_mode),
>  		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
>  			   PARSE_OPT_NOCOMPLETE),
>  		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),

I wonder if this interface wouldn't be a lot simpler as:

    --track
    --track-explicit --track-direct --track-inherit

Both because it'll work better for auto-complete, and we can (and
presumably some will want) just make --track mean whatever configured
--track-THING you want.

in any case, isn't there a NONEG missing here, or is --no-track-direct
etc. handled by OPT_CALLBACK_F() (I forget...).

>  	if (!strcmp(var, "branch.autosetupmerge")) {
> -		if (value && !strcasecmp(value, "always")) {
> +		if (value && !strcmp(value, "always")) {

...This probably makes sense, but it seems like the behavior change of
"let's not take this case-insensitive" should be split up into its own
change...

> +	test_must_fail git rev-parse --verify HEAD^ &&
> +	git checkout main &&
> +	git config branch.autosetupmerge inherit &&
> +	git checkout --orphan eta &&
> +	test -z "$(git config branch.eta.merge)" &&
> +	test -z "$(git config branch.eta.remote)" &&

Better with the test_must_be_empty etc. helpers.

> +	test refs/heads/eta = "$(git symbolic-ref HEAD)" &&

and this with test_cmp.

(ditto occurances below)
