Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E1FC83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25ADF208FE
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SdOlq88O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgD2QfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:35:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60767 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgD2QfX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 12:35:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6150C849A;
        Wed, 29 Apr 2020 12:35:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6OO1RTt3WG5kvB0mZY5okPLnQT4=; b=SdOlq8
        8O8aQUZZhkaJuxp14mZQAK9bOBdgQ7jrFTcVYBosyaJZtPHSnNsq8BZ2JpZ8kh70
        +a6o+PxBT2MzgI0xPbEzOx1mdJIDGicDLph5q9/t3f0qaIcSgFCvXIKMJKd+R+l4
        +apa9gpOMPEnK0jkgG4pUYZzGFRw2gCFTvTUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K85xLR1D/O7/szP7acLw9hyoLflrVD+T
        piiA8oFQZsZGKbR+ygy4Y8kREspzcW48Q1SuhaQNT4//4G3wXxfY6XhYBh3euJCw
        3k5NLW56qKZPVnHrJNjLIWcLO4vTsgHKkyvkfv/SKZYIDXYlo33buMVivWutMvYM
        6QtCwWwmNjk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BFD76C8499;
        Wed, 29 Apr 2020 12:35:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 07908C8498;
        Wed, 29 Apr 2020 12:35:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Robert Simpson <no-reply@MailScreen.com>
Subject: Re: [PATCH] switch: fix errors and comments related to -c and -C
References: <60af77100df823b4112c08e6c1b8533f.squirrel@socialwebmail.com>
        <0f7f9eefc056dd4d9b11dab737e00235b3243a2f.1588150804.git.liu.denton@gmail.com>
Date:   Wed, 29 Apr 2020 09:35:18 -0700
In-Reply-To: <0f7f9eefc056dd4d9b11dab737e00235b3243a2f.1588150804.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 29 Apr 2020 05:00:19 -0400")
Message-ID: <xmqqv9lixnax.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A5BFB04-8A37-11EA-8562-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> An alternative implementation which was considered involved inserting
> option name variants into a struct which is passed in by each command
> variant. Even though this approach is more general and could be
> applicable for future differing option names, it seemed like an
> over-engineered solution when the current pair of options are the only
> differing ones. We should probably avoid adding options which have
> different names anyway.

Sure.  Or another alternative is to take "-B/-b" silently without
advertising.  It's not like the reason why we introduced "-C/-c" was
because we wanted to reuse them in "switch" for other purposes.

> Reported-by: Robert Simpson <no-reply@MailScreen.com>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>
> Notes:
>     Robert, is the email listed above correct? If not, please let me know
>     which email to use. (I hope that this reaches you somehow.)

If we do not get any response, it is OK to remove the fake e-mail
address and recording only the namee (this is only OK for trailers
that are not SoB; the Signed-off-by: trailers want to be more
strict).

> +enum cmd_variant {
> +	CMD_CHECKOUT,
> +	CMD_SWITCH,
> +	CMD_RESTORE
> +};

Yuck, but OK.  Does "git restore" even take -b/-c/--orphan option?
I somehow doubt it.

This is too invasive for what it achieves.

How about having a file-scope global

/* create-branch option (either b or c) */
static char cb_option = 'b';

and then ...

> +
>  static int checkout_main(int argc, const char **argv, const char *prefix,
>  			 struct checkout_opts *opts, struct option *options,
> -			 const char * const usagestr[])
> +			 const char * const usagestr[],
> +			 enum cmd_variant variant)
>  {
>  	struct branch_info new_branch_info;
>  	int parseopt_flags = 0;
> @@ -1586,7 +1593,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  	}
>  
>  	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
> -		die(_("-b, -B and --orphan are mutually exclusive"));
> +		die(variant == CMD_CHECKOUT ?
> +				_("-b, -B and --orphan are mutually exclusive") :
> +				_("-c, -C and --orphan are mutually exclusive"));

... use it here like

		die(_("-%c, -%c and --orphan are mutually exclusive"),
		      cb_option, toupper(cb_option));



>  	if (opts->overlay_mode == 1 && opts->patch_mode)
>  		die(_("-p and --overlay are mutually exclusive"));
> @@ -1614,7 +1623,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  	/*
>  	 * From here on, new_branch will contain the branch to be checked out,
>  	 * and new_branch_force and new_orphan_branch will tell us which one of
> -	 * -b/-B/--orphan is being used.
> +	 * -b/-B/-c/-C/--orphan is being used.
>  	 */
>  	if (opts->new_branch_force)
>  		opts->new_branch = opts->new_branch_force;
> @@ -1622,7 +1631,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  	if (opts->new_orphan_branch)
>  		opts->new_branch = opts->new_orphan_branch;
>  
> -	/* --track without -b/-B/--orphan should DWIM */
> +	/* --track without -b/-B/--orphan for checkout or -c/-C/--orphan for switch should DWIM */

Way overlong comment.  Just 

	/* --track without -b/-B/-c/-C/--orphan should DWIM */

is sufficient, no?

>  	if (opts->track != BRANCH_TRACK_UNSPECIFIED && !opts->new_branch) {
>  		const char *argv0 = argv[0];
>  		if (!argc || !strcmp(argv0, "--"))
> @@ -1631,7 +1640,8 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  		skip_prefix(argv0, "remotes/", &argv0);
>  		argv0 = strchr(argv0, '/');
>  		if (!argv0 || !argv0[1])
> -			die(_("missing branch name; try -b"));
> +			die(_("missing branch name; try -%c"),
> +					variant == CMD_CHECKOUT ? 'b' : 'c');

Likewise,

			die(_("missing branch name; try -%c"), cb_option);

>  		opts->new_branch = argv0 + 1;
>  	}

And override cb_option in one of these helpers, perhaps like ...

> @@ -1785,7 +1795,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  	options = add_checkout_path_options(&opts, options);
>  
>  	ret = checkout_main(argc, argv, prefix, &opts,
> -			    options, checkout_usage);
> +			    options, checkout_usage, CMD_CHECKOUT);
>  	FREE_AND_NULL(options);
>  	return ret;
>  }
> @@ -1823,7 +1833,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
>  	options = add_common_switch_branch_options(&opts, options);
>  

... here (the other one uses 'b')

	cb_option = 'c';

>  	ret = checkout_main(argc, argv, prefix, &opts,
> -			    options, switch_branch_usage);
> +			    options, switch_branch_usage, CMD_SWITCH);
>  	FREE_AND_NULL(options);
>  	return ret;
>  }

... and you do not have to change function signature of
checkout_main() at all.

> @@ -1860,7 +1870,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
>  	options = add_checkout_path_options(&opts, options);
>  
>  	ret = checkout_main(argc, argv, prefix, &opts,
> -			    options, restore_usage);
> +			    options, restore_usage, CMD_RESTORE);
>  	FREE_AND_NULL(options);
>  	return ret;
>  }
