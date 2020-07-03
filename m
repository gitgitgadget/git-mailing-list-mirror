Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6214CC433E0
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 01:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A2820747
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 01:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ovb9lzU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgGCBuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 21:50:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59214 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgGCBuX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 21:50:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05F987541C;
        Thu,  2 Jul 2020 21:50:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HhzZxjfuYqAl
        C1sfscAPfYu4IjI=; b=ovb9lzU/8GvCmYU+p90tqzfocstRMTcVT0apB5y/uP5x
        83ZUZ81Fw7KGhAR7DGjtL7AY3D1slG9dwJyIUxnvSiEz7PE6W0oAFTovpm8E2IvJ
        1wXQ/dkdn8pacKBNvtWjQaxELemmdWp2tKt+bJg75JdJblKLEmtfJapiIMhvBnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Iq0n3m
        C8OlmhvzURwFQY3VoTdoAxloyzZR3M0ILL2u6O15Y/7LDQ2SyPv+Kejd5Bk5Q33n
        IadXR+iokh/v0W/9w7RVAet71yznTE8UHgQtgiQPVLBRZi2KY3nYmXDsR2BcEXW+
        TF8ZKsPtliGkokLPcozyUT554Uxfy95NSh4cI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F24A87541A;
        Thu,  2 Jul 2020 21:50:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B97A75419;
        Thu,  2 Jul 2020 21:50:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        Lin Sun <lin.sun@zoom.us>
Subject: Re: [PATCH v6] Support auto-merge for meld to follow the vim-diff behavior
References: <pull.781.v5.git.git.1593587206520.gitgitgadget@gmail.com>
        <pull.781.v6.git.git.1593650687697.gitgitgadget@gmail.com>
Date:   Thu, 02 Jul 2020 18:50:15 -0700
In-Reply-To: <pull.781.v6.git.git.1593650687697.gitgitgadget@gmail.com>
        (sunlin via GitGitGadget's message of "Thu, 02 Jul 2020 00:44:47
        +0000")
Message-ID: <xmqqv9j5bc4o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8B0119F0-BCCF-11EA-A5B2-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"sunlin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lin Sun <lin.sun@zoom.us>
>
> Make the mergetool used with "meld" backend behave similarly to how
> "vimdiff" behavior by telling it to auto-merge parts without conflicts
> and highlight the parts with conflicts when configuring
> `mergetool.meld.useAutoMerge` with `true`, or `auto` for automatically
> detecting the option.
>
> Helped-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail=
.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: David Aguilar <davvid@gmail.com>
> Signed-off-by: Lin Sun <lin.sun@zoom.us>
> ---

Thanks.

> +mergetool.meld.useAutoMerge::
> +	Older versions of `meld` do not support the `--auto-merge` option.

I do not mind the above text at all, but I do not think it is the
most important point about this configuration option.  Are the
readers of this manual page, at least the subset of them who are
interested in using the meld backend, expected to know what 'meld'
would do when given (and not given) the `--auto-merge` option?

At least, what meld does with and without `--auto-merge` briefly is
more important, especially if your belief is that it is plausible
that most users would prefer to use it.  Something like (I am not a
`meld` user, so everything I wrote after the first comma ',' in
these two paragraphs may be total rubbish---I am just writing these
as an illustration to show the level of details necessary to help
readers decide if the option is for them)...

    When meld is given `--auto-merge`, a part of the conflicted file
    that was modified only by one side is automatically resolved to
    take that change, and a part that was touched by both sides are
    highlighted for manual conflict resolution.

    Without `--auto-merge` option given, the automatic resolution
    does not happen---all changes in the conflicted file are
    highlighted for manual conflict resolution.

Only after that, telling them "(even though you may want to use the
option all the time) Older versions of `meld` do not support it"
becomes relevant---for users with ancient versions of `meld`, the
option, even if it is desirable, may not be available to them so it
is worth warning them that they should not set it to 'true' blindly
without checking with their version of `meld` first.

> diff --git a/mergetools/meld b/mergetools/meld
> index 7a08470f88..5bc03f564a 100644
> --- a/mergetools/meld
> +++ b/mergetools/meld
> @@ -3,34 +3,82 @@ diff_cmd () {
>  }
> =20
>  merge_cmd () {
> +	check_meld_for_features
> +
> +	option_auto_merge=3D
> +	if test "$meld_use_auto_merge_option" =3D true
>  	then
> +		option_auto_merge=3D"--auto-merge"
>  	fi
> =20
>  	if test "$meld_has_output_option" =3D true
>  	then
> +		"$merge_tool_path" $option_auto_merge --output=3D"$MERGED" \
>  			"$LOCAL" "$BASE" "$REMOTE"
>  	else
> +		"$merge_tool_path" $option_auto_merge "$LOCAL" "$MERGED" "$REMOTE"
>  	fi
>  }

That's straight-forward to follow.  Good.

> +# Get meld help message
> +init_meld_help_msg () {
> +	if test -z "${meld_help_msg:+set}"

I suspect that you copied the pattern=20

    if test -z "${var:+set}"

from the original, but it looks rather strange.  "${var:+set}" means
"if $var is set to a non-empty string, give me 'set'; otherwise give
me $var".  And checking if that result is an empty string with "-z"
would mean you can safely write

    if test -z "$var"

no?  If you are "set -u" proofing, you might write "${var-}" instead
of "$var" there, but that does not change the story all that much.

> +	then
> +		meld_path=3D"$(git config mergetool.meld.path || echo meld)"
> +		meld_help_msg=3D$($meld_path --help 2>&1)
> +	fi
> +}

In any case, the if/then/fi makes sure we'll ask `meld` only once,
which is good.

> +# Check the features and set flags
> +check_meld_for_features () {
> +	# Check whether we should use 'meld --output <file>'
> +	if test -z "${meld_has_output_option:+set}"

Likewise about "test -z ${var:+set}".

So, if we do not know yet, then...

>  	then
> +		meld_has_output_option=3D$(git config --bool mergetool.meld.hasOutpu=
t)

We ask "config --bool" and are prepared to see two primary cases, i.e.

> +		case "$meld_has_output_option" in
> +		true|false)
> +			: use configured value

In this case, the user may have configured, so the variable already
has the right value.  Good.

> +			;;
> +		*)
> +			: treat meld_has_output_option as "auto"
> +			init_meld_help_msg

Otherwise, we ask `meld`.

> +			case "$meld_help_msg" in
> +			*"--output=3D"* | *'[OPTION...]'*)
> +				# All version that has [OPTION...] supports --output

Very good comment.

> +				meld_has_output_option=3Dtrue
> +				;;
> +			*)
> +				meld_has_output_option=3Dfalse
> +				;;
> +			esac
> +			;;
> +		esac
> +	fi

Nicely done up to this point.

> +	# Check whether we should use 'meld --auto-merge ...'
> +	if test -z "${meld_use_auto_merge_option:+set}"

Likewise about "test -z ${var:+set}".

So, if we do not know yet, then...

>  	then
> +		meld_use_auto_merge_option=3D$(git config mergetool.meld.useAutoMerg=
e)
> +		case "$meld_use_auto_merge_option" in
> +		[Tt]rue|[Yy]es|[Oo]n|1)
> +			meld_use_auto_merge_option=3Dtrue

This is sloppy.  TRUE is also a valid way to spell 'yes'.

    if o=3D$(git config --bool 2>/dev/null mergetool.meld.useautomerge)
    then
    	meld_use_auto_merge_option=3D$o
    elif test auto =3D "$(git config mergetool.meld.useautomerge)"
    then
	... auto detect ...
    else
	meld_use_auto_merge_option=3Dfalse
    fi

Maybe somebody else has a clever idea to reduce the two calls into
one without breaking correctness, but unfortunately I do not offhand
think of a way to do this with just a single "git config" call.

> +			;;
> +		auto)
> +			# testing the "--auto-merge" option only if config is "auto"
> +			init_meld_help_msg
> +
> +			case "$meld_help_msg" in
> +			*"--auto-merge"*)
> +				meld_use_auto_merge_option=3Dtrue
> +				;;
> +			*)
> +				meld_use_auto_merge_option=3Dfalse
> +				;;
> +			esac
> +			;;
> +		*)
> +			meld_use_auto_merge_option=3Dfalse
> +			;;
> +		esac
>  	fi
>  }

Thanks.
