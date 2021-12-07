Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E48CC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbhLGS1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:27:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58892 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbhLGS1G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:27:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FA1010A044;
        Tue,  7 Dec 2021 13:23:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FYUar/KGNq2a
        5a5lSLnoW0YljICw7MSqFLsXlCxdn3c=; b=BU+UPk2JqShaGDsU3gcjiFt3CF2X
        /jG+QBIhpQ0OrPr83S5Bw5Zo7ydx1TRfS+IOTMYDJIUAg3SbDDnRukRhKDZuUtP+
        DtB4tr0aH435st7zNS7zqxJtQSYS46NblDl+RdYt4u1BWM3QFZhWcv6jzkyqMW/l
        JykSYW/2U+sL174=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 620CE10A043;
        Tue,  7 Dec 2021 13:23:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7B2B10A042;
        Tue,  7 Dec 2021 13:23:34 -0500 (EST)
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
Subject: Re: [PATCH v17 3/3] am: support --allow-empty to record specific
 empty patches
References: <pull.1076.v16.git.1638853295.gitgitgadget@gmail.com>
        <pull.1076.v17.git.1638865913.gitgitgadget@gmail.com>
        <ea2dc088b37670cd7969a57777798b8f5bdd94e4.1638865913.git.gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 10:23:33 -0800
In-Reply-To: <ea2dc088b37670cd7969a57777798b8f5bdd94e4.1638865913.git.gitgitgadget@gmail.com>
        (=?utf-8?B?IlwiXCLlvpDmspvmloc=?= (Aleen)\" via GitGitGadget\""'s message
 of "Tue, 07 Dec
        2021 08:31:53 +0000")
Message-ID: <xmqqpmq88eai.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C9FFDFB8-578A-11EC-BF9A-E10CCAD8090B-77302942!pb-smtp1.pobox.com
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
> of an am session. However, it is a valid resume value only when:
>
>     1. index has not changed
>     2. lacking a branch
>
> Signed-off-by: =E5=BE=90=E6=B2=9B=E6=96=87 (Aleen) <aleen42@vip.qq.com>
> ---
>  Documentation/git-am.txt |  7 +++++-
>  builtin/am.c             | 37 +++++++++++++++++++++-------
>  t/t4150-am.sh            | 53 ++++++++++++++++++++++++++++++++++++++++
>  t/t7512-status-help.sh   |  1 +
>  wt-status.c              |  3 +++
>  5 files changed, 91 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 7676bd58ae7..8d3aa552a20 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -18,7 +18,7 @@ SYNOPSIS
>  	 [--quoted-cr=3D<action>]
>  	 [--empty=3D(stop|drop|keep)]
>  	 [(<mbox> | <Maildir>)...]
> -'git am' (--continue | --skip | --abort | --quit | --show-current-patc=
h[=3D(diff|raw)])
> +'git am' (--continue | --skip | --abort | --quit | --show-current-patc=
h[=3D(diff|raw)] | --allow-empty)
> =20
>  DESCRIPTION
>  -----------
> @@ -200,6 +200,11 @@ default.   You can use `--no-utf8` to override thi=
s.
>  	the e-mail message; if `diff`, show the diff portion only.
>  	Defaults to `raw`.
> =20
> +--allow-empty::
> +	After a patch failure on an input e-mail message lacking a patch,
> +	the user can still record the empty patch as an empty commit with
> +	the contents of the e-mail message as its log.

"The user can still do X" is not technically incorrect, but this is
not merely a possiblity but does actively does X, so

	After a patch failure on an input e-mail message lacking a patch,
	create an empty commit with the contents of the e-mail
	message as its log message.

or something.

> diff --git a/builtin/am.c b/builtin/am.c
> index f45aa33366f..89a29ccac89 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1825,7 +1825,8 @@ static void am_run(struct am_state *state, int re=
sume)
>  				to_keep =3D 1;
>  				break;
>  			case STOP_ON_EMPTY_COMMIT:
> -				printf_ln(_("Patch is empty."));
> +				printf_ln(_("Patch is empty.\n"
> +					    "If you want to record it as an empty commit, run \"git am --=
allow-empty\"."));

It would be better to hide the new part of the message behind
advice_if_enabled(), and advise "--skip" first before giving
"--allow-empty" as another possibility.  It is rather a common
mistake to grab patches with the cover letter and see "am" die on
the cover letter.

If we were to add an advice message there, that is.  I am not sure
if it is necessary, especially since we give them in "git status".

> @@ -1898,21 +1899,34 @@ next:
>  /**
>   * Resume the current am session after patch application failure. The =
user did
>   * all the hard work, and we do not have to do any patch application. =
Just
> - * trust and commit what the user has in the index and working tree.
> + * trust and commit what the user has in the index and working tree. I=
f `allow_empty`
> + * is true, commit as an empty commit when index has not changed and l=
acking a patch.
>   */
> -static void am_resolve(struct am_state *state)
> +static void am_resolve(struct am_state *state, int allow_empty)
>  {
> +	int index_changed;
> +
>  	validate_resume_state(state);
> =20
>  	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->m=
sg);
> =20
> -	if (!repo_index_has_changes(the_repository, NULL, NULL)) {
> -		printf_ln(_("No changes - did you forget to use 'git add'?\n"
> -			"If there is nothing left to stage, chances are that something else=
\n"
> -			"already introduced the same changes; you might want to skip this p=
atch."));
> +	index_changed =3D repo_index_has_changes(the_repository, NULL, NULL);
> +	if (allow_empty && (index_changed || !is_empty_or_missing_file(am_pat=
h(state, "patch")))) {

Overlong line.

> +		printf_ln(_("Invalid resume value."));

It is unclear to the user what "resume value" means.  I am guessing
that this is saying that the user gave us the "--allow-empty" option,
but it is an inappropriate option for the situation.  So

	"--allow-empty is not appropriate in this situation"

would be a slight improvement, but it is not clear what makes it
inappropriate, iow, what the situation is, to the users.

Stepping back a bit, if we disect that overlong condition:

	if (allow_empty &&
	    (index_changed || !is_empty_or_missing_file(am_path(state, "patch"))=
)) {

it seems to be computing something not quite right.  What we want
with "allow" empty is (1) if we have recorded changes to the index,
that is perfectly fine.  We'll create a non-empty commit, and (2) if
we do not have any change in the index because the input did not
have a patch, it is OK to create an empty commit out of the current
index.  But the condition is there only to complain about
"--allow-empty" given when either (1) we have changes, or (2) when
the input had a patch.  These are conditions that we can internally
ignore allow_empty settings and let the existing code handle the
message as before this patch.

>  		die_user_resolve(state);

And I do not see how "when you have resolved with this problem, do one
of these things" message would help in this situation.  Perhaps we
can get rid of the above block.  We still need to compute index_changed,
and make "no changes--we will die" conditional.

> +	if (!index_changed) {
> +		if (allow_empty)
> +			printf_ln(_("No changes - record it as an empty commit."));

A command to the user to "record it as an empty commit" is not what
we want to give.  Perhaps "recorded it as ..." would work better as
a report of what we did for the user.

Also style:

		if (allow_empty) {
			printf_ln(...);
		} else {
                	... original multi-statement block come here ...
		}

That is, when one arm of if/else if/.../else cascade needs {}, put
{} to all of them.

I think there is a logic error here once we remove the way too
aggressive "you may not say --allow-empty when there is a patch"
check we saw earlier.

When we see no changes added to the index and "--allow-empty" given,
we shouldn't be blindly creating an empty commit without checking if
we didn't have any patch.  If the last failure that gave the control
back from "am" to the user was a patch that did not apply, we do not
want to create an empty commit, do we?  So something like

	if (!repo_index_has_changes(the_repository, NULL, NULL)) {
		if (allow_empty &&
		    is_empty_or_missing_file(am_path(state, "patch"))) {
			printf_ln(_("No changes - recorded an empty commit."));
		} else {
			... original block ...

perhaps?

> +		else {
> +			printf_ln(_("No changes - did you forget to use 'git add'?\n"
> +				    "If there is nothing left to stage, chances are that something=
 else\n"
> +				    "already introduced the same changes; you might want to skip t=
his patch."));
> +			die_user_resolve(state);
> +		}
> +	}

> @@ -2237,7 +2251,8 @@ enum resume_type {
>  	RESUME_SKIP,
>  	RESUME_ABORT,
>  	RESUME_QUIT,
> -	RESUME_SHOW_PATCH
> +	RESUME_SHOW_PATCH,
> +	RESUME_ALLOW_EMPTY

Advice on the trailing comma applies here equally.

>  };

> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index 7f2956d77ad..9309becfe03 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -658,6 +658,7 @@ test_expect_success 'status in an am session: empty=
 patch' '
>  On branch am_empty
>  You are in the middle of an am session.
>  The current patch is empty.
> +  (use "git am --allow-empty" to record this patch as an empty commit)
>    (use "git am --skip" to skip this patch)
>    (use "git am --abort" to restore the original branch)

You do not want to add the new one the first.  "--skip" should come
first, and perhaps this new one, and "--abort" at the end.

The general rule of thumb is to give common ones early before the
less common ones and ones, and give ones with more severe
consequence the last.

> diff --git a/wt-status.c b/wt-status.c
> index 5d215f4e4f1..d578a0e9192 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1227,6 +1227,9 @@ static void show_am_in_progress(struct wt_status =
*s,
>  		if (!s->state.am_empty_patch)
>  			status_printf_ln(s, color,
>  				_("  (fix conflicts and then run \"git am --continue\")"));
> +		else
> +			status_printf_ln(s, color,
> +				_("  (use \"git am --allow-empty\" to record this patch as an empt=
y commit)"));
>  		status_printf_ln(s, color,
>  			_("  (use \"git am --skip\" to skip this patch)"));
>  		status_printf_ln(s, color,
