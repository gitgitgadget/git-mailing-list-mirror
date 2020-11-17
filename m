Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE9EC2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 20:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9FF20773
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 20:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xnNyOLZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgKQUEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 15:04:24 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54624 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgKQUEV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 15:04:21 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DAFC6FF8FD;
        Tue, 17 Nov 2020 15:04:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tl8e1Vc5OB6/L5Vau6EF1233HIE=; b=xnNyOL
        ZaxIBWbXsswJO0weAFHLECFZ8QvKIKESllCwFYHR29lv6+aE1SxbTbOaPYLNiE/s
        8fD9dDgCtVg3GFkBQUqMJXE85UR0ByJu0PsReEVPcQIPRNamNgWQc6g9aiXZiN36
        Vvurm441+x4IXQPNChHcqS+NOUOGISwbnoO/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hl2ohhOtTlXLX1N1kgemP+2hXa8IMJOj
        5ZRAObkw3mFt1vjxjnWp9GSAnKdIzpwx9Wc+5zz5iJLDdHa5Lkp+5ZQ4HTDSc2Zz
        G7jhfxCYRqurkaDUelVdk9axQF3mMFRrc6W1ViY/xTSQnULwuLGXsUezmh2P3Fke
        aQD+yu9Mff8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D5B22FF8FC;
        Tue, 17 Nov 2020 15:04:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1AFDAFF8FA;
        Tue, 17 Nov 2020 15:04:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org, lanodan <contact+git@hacktivis.me>
Subject: Re: [PATCH v2] help.c: configurable suggestions
References: <20201117152535.9795-1-sir@cmpwn.com>
Date:   Tue, 17 Nov 2020 12:04:15 -0800
In-Reply-To: <20201117152535.9795-1-sir@cmpwn.com> (Drew DeVault's message of
        "Tue, 17 Nov 2020 10:25:35 -0500")
Message-ID: <xmqqd00b698g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 127C017C-2910-11EB-B855-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault <sir@cmpwn.com> writes:

> This allows users to disable guessing the commands or options that they
> meant to use.
> ---

Missing sign-off.

>  Documentation/config/help.txt | 14 +++++++-------
>  help.c                        | 27 ++++++++++++++++++++++-----
>  2 files changed, 29 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
> index 224bbf5a28..99d1e33750 100644
> --- a/Documentation/config/help.txt
> +++ b/Documentation/config/help.txt
> @@ -8,13 +8,13 @@ help.format::
>  	the default. 'web' and 'html' are the same.
>  
>  help.autoCorrect::
> -	Automatically correct and execute mistyped commands after
> -	waiting for the given number of deciseconds (0.1 sec). If more
> -	than one command can be deduced from the entered text, nothing
> -	will be executed.  If the value of this option is negative,
> -	the corrected command will be executed immediately. If the
> -	value is 0 - the command will be just shown but not executed.
> -	This is the default.
> +	If git detects typos and can identify exactly one valid command similar
> +	to the error, git will automatically run the intended command after
> +	waiting a duration of time defined by this configuration value in
> +	deciseconds (0.1 sec). If this value is 0, the suggested corrections
> +	will be shown, but not executed. If -1, the suggested command is run
> +	immediately. If -2, suggestions are not shown at all. The default value
> +	is zero.

This changes behaviour for those who have relied on our promise that
any negative value means immediate execution.  Now -2 means a totally
different thing.

I thought I already showed you how to make it a "number or keyword"
in my previous review comment to avoid such a needless behaviour
change---did our mails cross?

Thanks.

>  help.htmlPath::
>  	Specify the path where the HTML documentation resides. File system paths
> diff --git a/help.c b/help.c
> index 919cbb9206..2fd27cffb0 100644
> --- a/help.c
> +++ b/help.c
> @@ -472,12 +472,18 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
>  static int autocorrect;
>  static struct cmdnames aliases;
>  
> +#define AUTOCORRECT_NEVER (-2)
> +#define AUTOCORRECT_IMMEDIATELY (-1)
> +
>  static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
>  {
>  	const char *p;
>  
> -	if (!strcmp(var, "help.autocorrect"))
> -		autocorrect = git_config_int(var,value);
> +	if (!strcasecmp(var, "help.autocorrect")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		autocorrect = git_config_int(var, value);
> +	}
>  	/* Also use aliases for command lookup */
>  	if (skip_prefix(var, "alias.", &p))
>  		add_cmdname(&aliases, p, strlen(p));
> @@ -525,6 +531,11 @@ const char *help_unknown_cmd(const char *cmd)
>  
>  	read_early_config(git_unknown_cmd_config, NULL);
>  
> +	if (autocorrect == AUTOCORRECT_NEVER) {
> +		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
> +		exit(1);
> +	}
> +
>  	load_command_list("git-", &main_cmds, &other_cmds);
>  
>  	add_cmd_list(&main_cmds, &aliases);
> @@ -586,7 +597,7 @@ const char *help_unknown_cmd(const char *cmd)
>  		     n++)
>  			; /* still counting */
>  	}
> -	if (autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
> +	if (autocorrect != 0 && n == 1 && SIMILAR_ENOUGH(best_similarity)) {

I see there is nothing gained by writing "!= 0" explicitly here.

