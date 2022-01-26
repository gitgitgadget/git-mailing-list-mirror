Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD981C2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 13:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbiAZNjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbiAZNjH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 08:39:07 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9DBC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:39:07 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a8so38987443ejc.8
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Debv580/pqrn/5fVNcdWlGpfVes6tSlGEdpk/JfuuCw=;
        b=BThCXXfOjbngewYgnIvEfbgzkqFjyyktmpZQkaR8KExGRXdNAjdmFTpjDNyvil0m4H
         Go5YPKgVT+TMeXr3P4uTNRF9HHR+KTD/WmE12ijQRo3IZorE9fMBszvxEnWk+4Nq1xk4
         S0hWflp0Pj5yRL1mUB10DOUhrRCp7/S61Vz1dPfPXeyv8QVIbgLssbRLiKwNq9B4Fd71
         RL3d4ZtxitaRtosO4v2Ilfk98Huhu7k5TfAjJh8JB9Cmg2HKBjxj/Uho70wrJJ6TeL+Q
         8QUBMJgccHL9v4xiTsnOCE/pOyzNobpjb+QQX7yy3FKrvwYn28YWsIrHRPSuMEfmxHd2
         la2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Debv580/pqrn/5fVNcdWlGpfVes6tSlGEdpk/JfuuCw=;
        b=nyXl5C8TBBTWo0i/ZN4pruIeB5afiaVS6udKxYlmaw/AAWT/jJ/+TiKHdH5o13sPun
         Pf3WyRwcJMaH3Hokri7ZTjzJlgZphk+0V1jj/hBIx9mylhLPwISGPhgoved+UwKwYB+s
         SkWGXEqOxhbxqxhb0/OGkbiMmsIsfjDcV85GYs7oBuxK0+IKgKnxSXlmlHiYHzLoQlmP
         ozzUD2hLqlrNDsK4pqZXby/SmJRL1YqHriwuw4/8UQTn6nJXVs/C9JJ4krXQIl4qSMJl
         poUqJA+dBFM95kGq+lqQMxHj/zw24IyPSloulwo+gXo/QS4QJjwYaF4/0PQOup4nw+qV
         +Spg==
X-Gm-Message-State: AOAM531+pC7JulDoiFWrL+RcLtznCWutuf5MX+lJBy/a+jazNLcD3NAd
        CnpY4ngRAmXP5LB7taq0mpyCAaObqPA=
X-Google-Smtp-Source: ABdhPJxfxQRh47RrCmPF6K2gEUet53AHmXs1UqdMf2URNLK1lIfZvtngxGIYO+toWROIWgHMPfkPhw==
X-Received: by 2002:a17:907:2d8e:: with SMTP id gt14mr17921549ejc.22.1643204345536;
        Wed, 26 Jan 2022 05:39:05 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j20sm7383713eje.81.2022.01.26.05.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:39:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCiVr-0037x4-FE;
        Wed, 26 Jan 2022 14:39:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 11/14] reset_head(): take struct rebase_head_opts
Date:   Wed, 26 Jan 2022 14:35:11 +0100
References: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
 <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
 <d170703e8334a6f082f18b9e5bde3be3a60deed7.1643202349.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <d170703e8334a6f082f18b9e5bde3be3a60deed7.1643202349.git.gitgitgadget@gmail.com>
Message-ID: <220126.86fspafwg8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 26 2022, Phillip Wood via GitGitGadget wrote:

> @@ -669,13 +672,15 @@ static int run_am(struct rebase_options *opts)
>  
>  	status = run_command(&format_patch);
>  	if (status) {
> +		struct reset_head_opts ropts = { 0 };
>  		unlink(rebased_patches);
>  		free(rebased_patches);
>  		strvec_clear(&am.args);
>  
> -		reset_head(the_repository, &opts->orig_head,
> -			   opts->head_name, 0,
> -			   NULL, NULL, DEFAULT_REFLOG_ACTION);
> +		ropts.oid = &opts->orig_head;
> +		ropts.branch = opts->head_name;
> +		ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
> +		reset_head(the_repository, &ropts);
>  		error(_("\ngit encountered an error while preparing the "
>  			"patches to replay\n"
>  			"these revisions:\n"

Wouldn't these and the rest be easier to read as:

	struct reset_head_opts ropts = {
		.oid = &opts->orig_head,
                .branch = opts->head_name,
                .default_reflog_action = DEFAULT_REFLOG_ACTION,
        };

....


> @@ -814,14 +819,17 @@ static int rebase_config(const char *var, const char *value, void *data)
>  static int checkout_up_to_date(struct rebase_options *options)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> +	struct reset_head_opts ropts = { 0 };
>  	int ret = 0;
>  
>  	strbuf_addf(&buf, "%s: checkout %s",
>  		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
>  		    options->switch_to);
> -	if (reset_head(the_repository, &options->orig_head,
> -		       options->head_name, RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
> -		       NULL, buf.buf, NULL) < 0)
> +	ropts.oid = &options->orig_head;
> +	ropts.branch = options->head_name;
> +	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
> +	ropts.head_msg = buf.buf;

...and then for some of the ones like this "ropts.head_msg = buf.buf"
assignment you just do that one immediately after the strbuf_addf() or
whatever modifies it.

That way it's clear what options we get from the function arguments and
can populate right away, and which ones we need to run some code in the
function before we can update "ropts".

[Ditto for the elided parts below]

>  #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
>  
> +/* Request a detached checkout */
>  #define RESET_HEAD_DETACH (1<<0)
> +/* Request a reset rather than a checkout */
>  #define RESET_HEAD_HARD (1<<1)
> +/* Run the post-checkout hook */
>  #define RESET_HEAD_RUN_POST_CHECKOUT_HOOK (1<<2)
> +/* Only update refs, do not touch the worktree */
>  #define RESET_HEAD_REFS_ONLY (1<<3)
> +/* Update ORIG_HEAD as well as HEAD */
>  #define RESET_ORIG_HEAD (1<<4)
>  
> -int reset_head(struct repository *r, struct object_id *oid,
> -	       const char *switch_to_branch, unsigned flags,
> -	       const char *reflog_orig_head, const char *reflog_head,
> -	       const char *default_reflog_action);
> +struct reset_head_opts {
> +	/*
> +	 * The commit to checkout/reset to. Defaults to HEAD.
> +	 */
> +	const struct object_id *oid;
> +	/*
> +	 * Optional branch to switch to.
> +	 */
> +	const char *branch;
> +	/*
> +	 * Flags defined above.
> +	 */
> +	unsigned flags;

It's nice to make these sort of things an enum type for the reasons
explained in 3f9ab7ccdea (parse-options.[ch]: consistently use "enum
parse_opt_flags", 2021-10-08), i.e. gdb and the like will give you the
labels in the debugger.
