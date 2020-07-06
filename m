Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AB5C433DF
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 22:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE97020715
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 22:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J5rB8V3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgGFWbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 18:31:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51016 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGFWbf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 18:31:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC49970A0A;
        Mon,  6 Jul 2020 18:31:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x1Fop0EmgF/JyGqZNPNL0yzn9FA=; b=J5rB8V
        3IClH7/wU1D/noYU7stsBe3qYFRL1BbTJQ+k2LVDCFPcSOqJb3XaSTMYKPaOjrzR
        w2eozf8siVr5Ai1FmmzaCCUdXRRl+k3otwN5O+AHsOBmgQIPC05DZxeSnmAYHyjO
        i9e4y97JlsCeJfRs9b88gzi3exNhgmgzi591o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vLu2XgqClKvNWgpOQFDdFPsWruHz0ZG+
        0a2uK4LK1P1Xz0DGHewg9g5fNVR/nPhRsFhfb9YkkivZkd2FHyzqotkCqYoTecQq
        ely2iwh+pAqoJ5zVQTf99V0RksE9kNHmajnnNl6WcldQnG5TI0JwmNAnOur3xYA5
        9iEhfFKxPm8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A539A70A09;
        Mon,  6 Jul 2020 18:31:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A66E70A07;
        Mon,  6 Jul 2020 18:31:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        Lin Sun <lin.sun@zoom.us>
Subject: Re: [PATCH v9] Support auto-merge for meld to follow the vim-diff behavior
References: <pull.781.v8.git.git.1593825400699.gitgitgadget@gmail.com>
        <pull.781.v9.git.git.1594002423685.gitgitgadget@gmail.com>
Date:   Mon, 06 Jul 2020 15:31:29 -0700
In-Reply-To: <pull.781.v9.git.git.1594002423685.gitgitgadget@gmail.com>
        (sunlin via GitGitGadget's message of "Mon, 06 Jul 2020 02:27:03
        +0000")
Message-ID: <xmqqzh8c8eda.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 700C492E-BFD8-11EA-9C65-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"sunlin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lin Sun <lin.sun@zoom.us>
>
> Make the mergetool used with "meld" backend behave similarly to "vimdiff" by
> telling it to auto-merge non-conflicting parts and highlight the conflicting
> parts when `mergetool.meld.useAutoMerge` is configured with `true`, or `auto`
> for detecting the `--auto-merge` option automatically.

This reads well.

> +mergetool.meld.useAutoMerge::
> +	When the `--auto-merge` is given, meld will merge all non-conflicting
> +	parts automatically, highlight the conflicting parts and waiting for

s/waiting/wait/, I presume, i.e. "merge", "highlight" and "wait" all 
share the "meld will" that starts the sentence.

> +	user decision.  Setting `mergetool.meld.useAutoMerge` to `true` tells
> +	Git to unconditionally use the `--auto-merge` option with `meld`.
> +	Setting this value to `auto` makes git detect whether `--auto-merge`
> +	is supported and will only use `--auto-merge` when available.  A
> +	value of `false` avoids using `--auto-merge` altogether, and is the
> +	default value.

Other than that, this reads well, too.

> diff --git a/mergetools/meld b/mergetools/meld
> index 7a08470f88..ba6607a088 100644
> --- a/mergetools/meld
> +++ b/mergetools/meld
> @@ -3,34 +3,88 @@ diff_cmd () {
>  }
>  
>  merge_cmd () {
> +	check_meld_for_features
> +
> +	option_auto_merge=
> +	if test "$meld_use_auto_merge_option" = true
>  	then
> +		option_auto_merge="--auto-merge"
>  	fi
>  
>  	if test "$meld_has_output_option" = true
>  	then
> +		"$merge_tool_path" $option_auto_merge --output="$MERGED" \
>  			"$LOCAL" "$BASE" "$REMOTE"
>  	else
> +		"$merge_tool_path" $option_auto_merge "$LOCAL" "$MERGED" "$REMOTE"
>  	fi
>  }

OK.

> +# Get meld help message
> +init_meld_help_msg () {
> +	if test -z "$meld_help_msg"
> +	then
> +		meld_path="$(git config mergetool.meld.path || echo meld)"
> +		meld_help_msg=$($meld_path --help 2>&1)
> +	fi
> +}

OK.

> +# Check the features and set flags
> +check_meld_for_features () {
> +	# Check whether we should use 'meld --output <file>'
> +	if test -z "$meld_has_output_option"
>  	then
> +		meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
> +		case "$meld_has_output_option" in
> +		true|false)
> +			: use configured value
> +			;;

I think the assignment before "case" would have yielded a non-zero
exist status, so that would be another way to tell if we got a
proper boolean value, but this is also good.

> +		*)
> +			: empty or invalid configured value, detecting "--output" automatically
> +			init_meld_help_msg
> +
> +			case "$meld_help_msg" in
> +			*"--output="* | *'[OPTION...]'*)
> +				# All version that has [OPTION...] supports --output
> +				meld_has_output_option=true
> +				;;
> +			*)
> +				meld_has_output_option=false
> +				;;
> +			esac
> +			;;

OK.

> +		esac
> +	fi
> +	# Check whether we should use 'meld --auto-merge ...'
> +	if test -z "$meld_use_auto_merge_option"
>  	then
> +		meld_use_auto_merge_option=$(git config mergetool.meld.useAutoMerge)
> +		case "$meld_use_auto_merge_option" in
> +		"")
> +			meld_use_auto_merge_option=false

This is wrong, isn't it?  I have

	[rerere] enabled

in my .git/config and I'd certainly get an empty string if you ask
about it in a non-bool context:

    $ o=$(git config --bool rerere.enabled); echo $o
    true
    $ o=$(git config rerere.enabled); echo $o

    $    

In short, I think you can just drop this test for an empty string here.

> +			;;
> +		[Aa]uto)

Does any other configuration variable that takes "auto" take "Auto",
"AUTO", etc. as syonyms?  It's not like we said "you must create a
file whose name is auto to trigger this feature" and some people
live on a case insensitive filesystem that may make it impossible
for them to do so, so I do not see much point in doing this.

> +			# testing the "--auto-merge" option only if config is "[Aa]uto"
> +			init_meld_help_msg
> +
> +			case "$meld_help_msg" in
> +			*"--auto-merge"*)
> +				meld_use_auto_merge_option=true
> +				;;
> +			*)
> +				meld_use_auto_merge_option=false
> +				;;
> +			esac

I didn't notice this until now, but for "--auto-merge", the "if your
meld is new enough, the option name may not appear and you would
only see [OPTION...]" rule we had for the "--output" does not apply?

I am not a meld user, and "yes, my code is correct" is a perfectly
good answer (in other word, the above question is NOT a rhetorical
one that points out an error in the code being reviewed).

> +			;;
> +		*)
> +			bool_value=$(git config --bool mergetool.meld.useAutoMerge 2>/dev/null)
> +			if test -n "$bool_value"
> +			then
> +				meld_use_auto_merge_option="$bool_value"
> +			else
> +				meld_use_auto_merge_option=false
> +			fi
> +			;;

Perhaps the whole thing is easier to read if it is structured more
like so:

	varname=mergetool.meld.useAutoMerge
	if meld_use_auto_merge_option=$(git config --bool "$varname" 2>/dev/null)
	then
        	: happy
	else
                # not a boolean.  Is it 'auto'?
		val=$(git config "$varname")
                case "$val" in
                auto)
                        ;;
                *)
                        die "unrecognized value '$val' for $varname"
                        ;;;
                esac
                ... here we auto detect ...
	fi

Thanks.
