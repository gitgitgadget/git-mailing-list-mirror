Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1096C433F5
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 23:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhLZXNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 18:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbhLZXNt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 18:13:49 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D5AC06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 15:13:48 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o20so55344080eds.10
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 15:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=vewgKwOSV0AQObpOWZ96GAkmZnebYZVib9FSSkV9Zww=;
        b=aVEaD9apqpQNJ2JiYwyOHTCaM99jzCePvo83Nh3xpZwUnzP8Kxilp1q6aistbI2fsp
         9JNycXvZ3BR3PX8/lR2u/fH6RexfIMwePu3RHQV1fgQOKoKRgIuGwz7eKOTapFlY6mSF
         3MpYRiMomTj5F7TOkoilzQLdaaBfCtNg1/2HKuOgFOW9oDKBsH1xQESsD+Dbq44musUp
         DJkGnYvR5NpidZhAc35Wzc2BngEowrM13rVFy7N+Lff73+R4k5zxQjmwHNqEJ2mLqwlO
         UVylndyZejChlftMjZ7mjvF7PFl9uQJiixfo0854WfwKrHyzFfcDlR6/RL+lL09LTv8g
         rlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=vewgKwOSV0AQObpOWZ96GAkmZnebYZVib9FSSkV9Zww=;
        b=18HAZZjcqagGQzt8hvelmAz9wkfisMJcggagVjVMY80SDkRLfMRX9XxX/lxnMMsMQZ
         Eo280EGtU6kMSKKBFa7hviEV9Nr44amejfwpqUCnGXTzWA8yab7qHnTExBOeoteu5V5x
         9D8tLVE8kYg76KyfQzwJ2dOV0Mv4MUUObx4gfrrGGYvjFNN1lbu1sKGilntYWMl9uwUU
         H4C1JVbZJU8BMeCprsjCgrY9ck7ZjgyjiazPJxeEZ0HW43yK6OAPTSSNIZ/sLhm9bZaU
         VNkFppghT8sMByJ+Ht0XiRRYFEUMN0iiIhLqHxfXd3LhyELVaWjW0tkYwk2Wb4CdK5O1
         BPyA==
X-Gm-Message-State: AOAM5301wLYoVZreVIjllHFQ67/4op1NCujBsNRJ86GjOuc8aXFtQduI
        yyhsbjKmKse6/o0GwpooB+Cwdkup1A1AjSLc
X-Google-Smtp-Source: ABdhPJwEPsawlIno/2BgBjIytVfEILVkDZo4BuEsyJ5CM6u7tOhXo1hzYY13zfveu8fKHA3XXpBxXA==
X-Received: by 2002:a05:6402:270a:: with SMTP id y10mr13976195edd.282.1640560427163;
        Sun, 26 Dec 2021 15:13:47 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id ga37sm4556151ejc.65.2021.12.26.15.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 15:13:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n1ci1-000HSF-4l;
        Mon, 27 Dec 2021 00:13:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] grep: allow scripts to ignore configured pattern type
Date:   Mon, 27 Dec 2021 00:09:05 +0100
References: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
 <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
 <patch-v5-3.7-f02f246aa23-20211222T025214Z-avarab@gmail.com>
 <xmqq35mj7yd4.fsf@gitster.g> <xmqqfsqh35vu.fsf_-_@gitster.g>
 <xmqqa6gp35a6.fsf_-_@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqa6gp35a6.fsf_-_@gitster.g>
Message-ID: <211227.86czljez86.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 24 2021, Junio C Hamano wrote:

> We made a mistake to add grep.extendedRegexp configuration variable
> long time ago, and made things even worse by introducing an even
> more generalized grep.patternType configuration variable.
>
> This was mostly because interactive users were lazy and wanted a way
> to declare "I do not live in the ancient age, and my regexps are
> always extended" and write "git grep" without having to type three
> more letters " -E" on the command line.
>
> But this in turn forces script writers to always specify what kind
> of patterns they are writing, because without such command line
> override, the interpretation of the patterns they write in their
> scripts will be affected by the configuration variables of the user
> who is running their script.
>
> Introduce GIT_DISABLE_GREP_PATTERN_CONFIG environment variable that
> script writers can set to "true" and export at the very beginning of
> their script to defeat grep.extendedRegexp and grep.patternType
> configuration variables.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * This is merely a weather balloon without proper documentation and
>    test.  It might be even better idea to make such an environment
>    variable to _specify_ what kind of pattern the script uses,
>    instead of "we defeat end-user configuration and now we are
>    forced to write in basic or have to write -E/-P etc.", which is
>    what this patch does.

You note the lack of documentation. I do think anything in this
direction would do well to:

 * Specify what it is we're promising now exactly. The git-grep
   command is in "main porcelain" now, this change sounds like we're
   promising to make its output more plumbing-like.

 * As an aside I think a good follow-up to my series would be to
   just start warning() and eventually die()-ing on grep.extendedRegexp
   which would make this a bit simpler.

 * A "GIT_DISABLE_GREP_PATTERN_CONFIG" seems overly narrow. Just a few lines
   from the code being patched here we read the grep.lineNumber config, which is
   similarly annoying if you're parsing the "git grep" output, so at least a
   "GIT_DISABLE_GREP_CONFIG" would be handy.

 * But more generally we've had discussions on and off on-list about supporting
   a generic way to disable reading the config. Supporting e.g. "git --no-config" or
   a "GIT_NO_CONFIG" would be handy, even if all it did for now (and we could document
   it as such) would be to change the behavior of grep.
 

>  grep.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index fe847a0111..0cfb698b51 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -77,10 +77,15 @@ int grep_config(const char *var, const char *value, void *cb)
>  {
>  	struct grep_opt *opt = &grep_defaults;
>  	const char *slot;
> +	static int disable_pattern_type_config = -1;
>  
>  	if (userdiff_config(var, value) < 0)
>  		return -1;
>  
> +	if (disable_pattern_type_config < 0)
> +		disable_pattern_type_config =
> +			git_env_bool("GIT_DISABLE_GREP_PATTERN_CONFIG", 0);
> +
>  	/*
>  	 * The instance of grep_opt that we set up here is copied by
>  	 * grep_init() to be used by each individual invocation.
> @@ -90,12 +95,14 @@ int grep_config(const char *var, const char *value, void *cb)
>  	 */
>  
>  	if (!strcmp(var, "grep.extendedregexp")) {
> -		opt->extended_regexp_option = git_config_bool(var, value);
> +		if (!disable_pattern_type_config)
> +			opt->extended_regexp_option = git_config_bool(var, value);
>  		return 0;
>  	}
>  
>  	if (!strcmp(var, "grep.patterntype")) {
> -		opt->pattern_type_option = parse_pattern_type_arg(var, value);
> +		if (!disable_pattern_type_config)
> +			opt->pattern_type_option = parse_pattern_type_arg(var, value);
>  		return 0;
>  	}

