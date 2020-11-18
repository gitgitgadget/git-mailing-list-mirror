Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E8EC6369E
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 17:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522B6248AA
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 17:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pFrPuVty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgKRRRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 12:17:07 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63642 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgKRRRG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 12:17:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1126510C82D;
        Wed, 18 Nov 2020 12:17:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hj79zB52RYVN4sRkgJ7uwvmxOLs=; b=pFrPuV
        tyhrH1RtPByDtUrcL6sSirjKbPozs1CADwLOPbTGguYdLLXBRImKa2W3/Z+Cxl1M
        kqKOwLQdUt06ie3A8CmKcCfqhzmk1vK+r9AKjhyMO8F1qOjhn+jRCNo9M1ZjpKyV
        Ciy8nar6I/vQtSddf5LQlZQKrrpoozDupHyqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iv0TJcG+LDam/B/lMnsUbaCA7lj2lxYc
        QMyEmjytFC3Vty8j44zBzagvzOl970cYZDbiVztAxRZmr4RbFyQrUKL8djMuOhgw
        MMf1R7G17cAZBKkNhdsEe9Pl2RXgBqC67atJ2oEYB1dC5DhNhMVPqTgwuik2n73A
        Ih03a6oTdOQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A7A310C82C;
        Wed, 18 Nov 2020 12:17:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4D8F010C827;
        Wed, 18 Nov 2020 12:17:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org, lanodan <contact+git@hacktivis.me>
Subject: Re: [PATCH v3] help.c: configurable suggestions
References: <20201118144218.23233-1-sir@cmpwn.com>
Date:   Wed, 18 Nov 2020 09:16:58 -0800
In-Reply-To: <20201118144218.23233-1-sir@cmpwn.com> (Drew DeVault's message of
        "Wed, 18 Nov 2020 09:42:18 -0500")
Message-ID: <xmqqima237qt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE80E452-29C1-11EB-B2B0-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault <sir@cmpwn.com> writes:

> This allows users to disable guessing the commands or options that they
> meant to use.

It is unclear from this description alone why this is needed.  The
seller of this change needs to emphasize how this is better than
setting the variable to "0" (do not autocorrect).  My guess is that
some users do not even need the suggestion of correct spelling when
they made a typo?

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
> +	deciseconds (0.1 sec).  If this value is 0, the suggested corrections
> +	will be shown, but not executed. If "immediate", the suggested command
> +	is run immediately. If "never", suggestions are not shown at all. The
> +	default value is zero.

Imagine existing users who set the variable to -1 long time ago
wonders what it is doing in their ~/.gitconfig file.  This paragraph
still needs to describe how a negative value is treated.

> diff --git a/help.c b/help.c
> index 919cbb9206..61a7c1ea17 100644
> --- a/help.c
> +++ b/help.c
> @@ -472,12 +472,26 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
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
> +	if (!strcmp(var, "help.autocorrect")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		if (!strcmp(value, "never")) {
> +			autocorrect = AUTOCORRECT_NEVER;
> +		} else if (!strcmp(value, "immediate")) {
> +			autocorrect = AUTOCORRECT_IMMEDIATELY;
> +		} else {
> +			int v = git_config_int(var, value);
> +			autocorrect = (v < 0)
> +				? AUTOCORRECT_IMMEDIATELY : v;
> +		}
> +	}
>  	/* Also use aliases for command lookup */
>  	if (skip_prefix(var, "alias.", &p))
>  		add_cmdname(&aliases, p, strlen(p));
> @@ -525,6 +539,11 @@ const char *help_unknown_cmd(const char *cmd)
>  
>  	read_early_config(git_unknown_cmd_config, NULL);
>  
> +	if (autocorrect == AUTOCORRECT_NEVER) {
> +		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
> +		exit(1);

OK, so when we encounter an unknown word that follows "git" on the
comand line, we immediately exit without doing the guesswork.  This
is needed because we are skipping not just the guessing and
suggesting, but showing this error message by exiting early here.

Makes sense.

> +	}
> +
>  	load_command_list("git-", &main_cmds, &other_cmds);
>  
>  	add_cmd_list(&main_cmds, &aliases);
> @@ -594,7 +613,7 @@ const char *help_unknown_cmd(const char *cmd)
>  			   _("WARNING: You called a Git command named '%s', "
>  			     "which does not exist."),
>  			   cmd);
> -		if (autocorrect < 0)
> +		if (autocorrect == AUTOCORRECT_IMMEDIATELY)
>  			fprintf_ln(stderr,
>  				   _("Continuing under the assumption that "
>  				     "you meant '%s'."),
> @@ -706,10 +725,16 @@ NORETURN void help_unknown_ref(const char *ref, const char *cmd,
>  			       const char *error)
>  {
>  	int i;
> -	struct string_list suggested_refs = guess_refs(ref);
> +	struct string_list suggested_refs;
>  
>  	fprintf_ln(stderr, _("%s: %s - %s"), cmd, ref, error);
>  
> +	if (autocorrect == AUTOCORRECT_NEVER) {
> +		exit(1);
> +	}

I am not sure how the change in this hunk is justifiable.

The auto correction is about guessing mistyped commands and
optionally going forward to execute it.  Some users (like me) who
set it to 0 currently may want to set it to "never", but I'd imagine
that not all of these users would want to lose the local branch vs
remote-tracking branch correction (certainly not me).  It might be
convenient for some folks if both of these can be squelched with a
single knob, but it must be possible to enable them independently.

This is a tangent, but it seems to me that help_unknown_ref() is way
under-used and lacks usefulness too much---probably these contribute
to each other.

It only gets used by "git merge $name" and only when the missing
$name branch exists as remote-tracking branches of some remotes,
i.e.  "you said $name, which does not exist, but you could have
typed $remote/$name to refer to the remote-tracking branch").

I would imagine that it would help users who type "git checkout
mext" to suggest "you may have typoed 'next'", for example, and "git
checkout -b my-topic next" to offer "you said 'next' that does not
exist; did you mean 'origin/next'?"  It might be a good exercise to
first make inventory of other possible places that would benefit,
which may suggest what other sources guess_refs() should grab its
candidates from (#leftoverbits).

> +
> +	suggested_refs = guess_refs(ref);
> +
>  	if (suggested_refs.nr > 0) {
>  		fprintf_ln(stderr,
>  			   Q_("\nDid you mean this?",
