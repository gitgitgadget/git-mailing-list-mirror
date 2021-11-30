Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EE8C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 07:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhK3HZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 02:25:14 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60623 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhK3HZN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 02:25:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6378616473D;
        Tue, 30 Nov 2021 02:21:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6ifqNstOVZbD
        3aP2PofnNKtZ/w4MdkDPe9idSUJYs4E=; b=d3MRP+IkCxXDD1LJ/sFT7oFRIlCQ
        GFkzgW/XlyNK1kQYl2rpdqfezGrPLWpvUi6MzZfV5oiAiE+7wEqzfzE0RyTKnBkc
        nV85hwymTV3xo2GrNZ4Jijn2EgGO3BfnNSVhStzDkQ6XYTkOxkFKangFo0ylUGRs
        XfrnM87vskx544c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B26516473C;
        Tue, 30 Nov 2021 02:21:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7B2BC16473B;
        Tue, 30 Nov 2021 02:21:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?IiLlvpDmspvmloc=?= (Aleen) " via GitGitGadget" 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v12 3/3] am: support --allow-empty to record specific
 empty patches
References: <pull.1076.v11.git.1637681215.gitgitgadget@gmail.com>
        <pull.1076.v12.git.1638250645.gitgitgadget@gmail.com>
        <d44dac09c872257306d9718564820435e8a07ca2.1638250645.git.gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 23:21:48 -0800
In-Reply-To: <d44dac09c872257306d9718564820435e8a07ca2.1638250645.git.gitgitgadget@gmail.com>
        (=?utf-8?B?IlwiXCLlvpDmspvmloc=?= (Aleen)\" via GitGitGadget\""'s message
 of "Tue, 30 Nov
        2021 05:37:25 +0000")
Message-ID: <xmqq8rx62jn7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2F87565A-51AE-11EC-85DD-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

""=E5=BE=90=E6=B2=9B=E6=96=87 (Aleen)" via GitGitGadget"  <gitgitgadget@g=
mail.com>
writes:

> From: =3D?UTF-8?q?=3DE5=3DBE=3D90=3DE6=3DB2=3D9B=3DE6=3D96=3D87=3D20=3D=
28Aleen=3D29?=3D
>  <aleen42@vip.qq.com>
>
> This option helps to record specific empty patches in the middle
> of an am session.
>
> Signed-off-by: =E5=BE=90=E6=B2=9B=E6=96=87 (Aleen) <aleen42@vip.qq.com>
> ---
>  Documentation/git-am.txt |  6 +++++-
>  builtin/am.c             | 24 +++++++++++++++++++-----
>  t/t4150-am.sh            | 12 ++++++++++++
>  t/t7512-status-help.sh   |  1 +
>  wt-status.c              |  3 +++
>  5 files changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index ba17063f621..fe3af32f7f7 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -18,7 +18,7 @@ SYNOPSIS
>  	 [--quoted-cr=3D<action>]
>  	 [--empty=3D(die|drop|keep)]
>  	 [(<mbox> | <Maildir>)...]
> -'git am' (--continue | --skip | --abort | --quit | --show-current-patc=
h[=3D(diff|raw)])
> +'git am' (--continue | --skip | --abort | --quit | --show-current-patc=
h[=3D(diff|raw)] | --allow-empty)
> =20
>  DESCRIPTION
>  -----------
> @@ -199,6 +199,10 @@ default.   You can use `--no-utf8` to override thi=
s.
>  	the e-mail message; if `diff`, show the diff portion only.
>  	Defaults to `raw`.
> =20
> +--allow-empty::
> +	Keep recording the empty patch as an empty commit with
> +	the contents of the e-mail message as its log.
> +
>  DISCUSSION
>  ----------
> =20
> diff --git a/builtin/am.c b/builtin/am.c
> index cc6512275aa..2ae6fabb28a 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1825,7 +1825,8 @@ static void am_run(struct am_state *state, int re=
sume)
>  				to_keep =3D 1;
>  				break;
>  			case DIE_EMPTY_COMMIT:
> -				printf_ln(_("Patch is empty."));
> +				printf_ln(_("Patch is empty.\n"
> +							"If you want to keep recording it, run \"git am --allow-empty\"=
."));

An overly deep indentation.  Make "If" align with "Patch",
probably.  Also "to keep recording it" -> "to record it".

"If you want to record the e-mail text as the log message of an
empty commit" may be a bit too much, but just saying "record it" may
not be clear enough to explain what gets recorded how.

> @@ -1898,10 +1899,15 @@ next:
>  /**
>   * Resume the current am session after patch application failure. The =
user did
>   * all the hard work, and we do not have to do any patch application. =
Just
> - * trust and commit what the user has in the index and working tree.
> + * trust and commit what the user has in the index and working tree. I=
f `allow_empty`
> + * is true, commit as an empty commit.
>   */
> -static void am_resolve(struct am_state *state)
> +static void am_resolve(struct am_state *state, int allow_empty)
>  {
> +	if (allow_empty) {
> +		goto commit;
> +	}

Lose {} around a single statement block.

But more importantly, doesn't this break "git am" when the user
gives "--allow-empty" in cases where you are not expecting?

Like when the patch application (with or without -3) fails, either
during "git am -i" or "git am" without "-i"?

The parameter claims to be "allow empty", implying that the option
is about allowing to end up in an empty commit (and depending on the
input, the resulting commit may not be empty and that is OK).  But
what the code does is to _ignore_ the unmerged check, not recording
the manual resolution the user did for later reuse, and force a call
to do_commit() fail if the index is still unmerged.

>  	validate_resume_state(state);
> =20
>  	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->m=
sg);

I suspect that the real code that wants to be changed is below this
line, where we say "if the index does not have changes (relative to
the HEAD), then complain and die".  Perhaps it should become
something along this line:

	if (!repo_index_has_changes(...)) {
		if (allow_empty) {
			printf_ln(_("No changes - recording an empty commit.");
		} else {
			printf_ln(_("No changes - did you forget ..."
				    "..."));
			die_user_resolve(state);
		}
	}

i.e. "when the index does not have changes, tell the user that we'd
create an empty commit, if allow-empty is in effect. otherwise,
complain and die".

I suspect that the worst failure mode may be "git am" (without -3)
first fails to apply a patch (hence the index is unchanged wrt
HEAD), then "git am" that is run with "--allow-empty" ignores the
failure and creates an empty commit.  Even with the "something along
this line" change above, such a failure mode still exists.  You
really need to see if we had an input without any patch and do the
skipping only when it is the case, I think.

