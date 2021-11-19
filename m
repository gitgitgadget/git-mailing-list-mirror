Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA912C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 00:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A7461AA7
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 00:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhKSA7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 19:59:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51254 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKSA7z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 19:59:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9393EA702;
        Thu, 18 Nov 2021 19:56:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qDfXycYdbbcdE+mlmuD3Oggxm+R8D6BBuPDbtL
        TDpXs=; b=jT9ZVbrQdFTX2lEE0JGPfgZT1ehmSwzmeB9YXnwPkVG60dRR7JKqYe
        /xm+yVADG2MQhcuDRHd7MQmbG8RK9BUh5zZ2cm75Y8NyxI28yDyqrmtA9JgdXAhh
        dyOvuEgtdaO2llx7rqlCcFbbn/43brLokKalgp/tjnbqV13mmg0ks=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0160EA701;
        Thu, 18 Nov 2021 19:56:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37450EA700;
        Thu, 18 Nov 2021 19:56:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v6 2/3] am: support --empty option to handle empty patches
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
        <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
        <96d8573dc808bc32990842675ca32a0d1e8a8cef.1637232636.git.gitgitgadget@gmail.com>
Date:   Thu, 18 Nov 2021 16:56:52 -0800
In-Reply-To: <96d8573dc808bc32990842675ca32a0d1e8a8cef.1637232636.git.gitgitgadget@gmail.com>
        (Aleen via GitGitGadget's message of "Thu, 18 Nov 2021 10:50:35
        +0000")
Message-ID: <xmqqwnl5rmi3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95EF6DE4-48D3-11EC-B034-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Aleen via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Aleen <aleen42@vip.qq.com>

Here is a place to explain to readers what it exactly means to
"support --empty option to handle empty patches".  You know what you
meant, I happen to know what you meant because I haven't forgotten
yet, but we are writing for developers in the future who need to fix
bugs in 6 months down the road to decide if this commit is involved
in the bug in "git am" they are hunting.

> Signed-off-by: Aleen <aleen42@vip.qq.com>
> ---
>  Documentation/git-am.txt |  9 +++++
>  builtin/am.c             | 48 +++++++++++++++++++++++---
>  t/t4150-am.sh            | 73 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 125 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 0a4a984dfde..665bc89ca9f 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -16,6 +16,7 @@ SYNOPSIS
>  	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
>  	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
>  	 [--quoted-cr=<action>]
> +	 [--empty=(die|drop|keep)]
>  	 [(<mbox> | <Maildir>)...]
>  'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)])
>  
> @@ -63,6 +64,14 @@ OPTIONS
>  --quoted-cr=<action>::
>  	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
>  
> +--empty-commit=(die|drop|keep)::
> +	The command usually errors out when seeing an input e-mail
> +	message that lacks a patch. When this option is set to
> +	'drop', skip such an e-mail message without outputting error.

"without outputting error" -> "instead".

The first sentence used "to error" as a verb to mean "stop the
operation in the middle with a message that diagnoses what is
wrong".  Saying "outputting error" to use the same word as a noun is
not a good idea, especially the use of verb "to output", as it makes
the word "error" look as if it is only the "message" part, and it
becomes unclear if the "stopping due to an error" is also skipped.

I actually think it makes sense to give a notice/info message when
"drop" skips an empty patch, unless "--quiet" is given.

> +	When this option is set to 'keep', create an empty commit,
> +	recording the contents of the e-mail message as its log.
> +	'die' is specified by default.

"is specified by default" sounds a bit strange.  Perhaps lose the
last sentence, and update the first line like so:

    By default, or when the option is set to 'die', the command
    errors out on an input e-mail message that lacks a patch.

> diff --git a/builtin/am.c b/builtin/am.c
> index 8677ea2348a..1a3ed87b445 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -87,6 +87,12 @@ enum show_patch_type {
>  	SHOW_PATCH_DIFF = 1,
>  };
>  
> +enum empty_action {
> +	DIE_EMPTY_COMMIT = 0,  /* output errors */
> +	DROP_EMPTY_COMMIT,     /* skip without outputting errors */

I think the user deserves "info:" (unless "--quiet").

> +	KEEP_EMPTY_COMMIT      /* keep recording as empty commits */
> +};
> +
>  struct am_state {
>  	/* state directory path */
>  	char *dir;
> @@ -118,6 +124,7 @@ struct am_state {
>  	int message_id;
>  	int scissors; /* enum scissors_type */
>  	int quoted_cr; /* enum quoted_cr_action */
> +	int empty_type; /* enum empty_action */
>  	struct strvec git_apply_opts;
>  	const char *resolvemsg;
>  	int committer_date_is_author_date;
> @@ -178,6 +185,23 @@ static int am_option_parse_quoted_cr(const struct option *opt,
>  	return 0;
>  }
>  
> +static int am_option_parse_empty_commit(const struct option *opt,
> +				     const char *arg, int unset)
> +{
> +	int *opt_value = opt->value;
> +
> +	if (unset || !strcmp(arg, "die"))
> +		*opt_value = DIE_EMPTY_COMMIT;
> +	else if (!strcmp(arg, "drop"))
> +		*opt_value = DROP_EMPTY_COMMIT;
> +	else if (!strcmp(arg, "keep"))
> +		*opt_value = KEEP_EMPTY_COMMIT;
> +	else
> +		return error(_("Invalid value for --empty: %s"), arg);
> +
> +	return 0;
> +}

OK.

> @@ -1792,6 +1811,20 @@ static void am_run(struct am_state *state, int resume)
>  		if (state->interactive && do_interactive(state))
>  			goto next;
>  
> +		if (is_empty_or_missing_file(am_path(state, "patch"))) {
> +			if (state->empty_type == DROP_EMPTY_COMMIT)
> +				goto next;
> +			else if (state->empty_type == KEEP_EMPTY_COMMIT) {
> +				if (run_applypatch_msg_hook(state))
> +					exit(1);
> +				else
> +					goto commit;

It probably is easier to read without "else", i.e.

			else if (state->empty_type == KEEP_EMPTY_COMMIT) {
				if (run_applypatch_msg_hook(state))
					exit(1);
				goto commit;

Running hook here and outside this if() block a bit ugly.  Can't we
instead set a flag variable or something and let the existing call
to run_applypatch_msg_hook() used?

> +			} else if (state->empty_type == DIE_EMPTY_COMMIT) {
> +				printf_ln(_("Patch is empty."));
> +				die_user_resolve(state);
> +			}

Also, if developers ever add another possible value for the
state->empty_type member (by the way, "empty" in its name is good,
but "type" is iffy), it would be a bug if they do not consider what
should happen inside this "if (is_empty_or_missing_file())" block,
no?  In such a case, instead of if/else if/... cascade, consider
using switch().  Taking them together.
 
	while (state->cur <= state->last) {
        	const char *mail = am_path(state, msgnum(state));
		int apply_status;
		int to_keep;
		...
		to_keep = 0;
		if (is_empty_or_missing_file(am_path(state, "patch"))) {
			switch (state->empty_type) {
			case DROP_EMPTY_COMMIT:
                                say(state, stdout, _("Skipping empty patch '%.*s",
					linelen(state->msg0, state->msg);
				goto next;
				break;
			case KEEP_EMPTY_COMMIT:
				to_keep = 1;
				break;
			case DIE_EMPTY_COMMIT:
				pritnf_ln(_("Patch is empty."));
				die_user_resolve(state);
				break;
			}
		}

		if (run_applypatch_msg_hook(state))
			exit(1);
		if (to_keep)
			goto commit; /* empty: just record a message */

or something like that.

> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 2aaaa0d7ded..3119556884d 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -196,6 +196,13 @@ test_expect_success setup '
>  
>  	git format-patch -M --stdout lorem^ >rename-add.patch &&
>  
> +	git checkout -b empty-commit &&
> +	git commit -m "empty commit" --allow-empty &&
> +
> +	git format-patch --stdout empty-commit^ >empty.patch &&

Unless this is a test for "format-patch" command to make sure that
the above command will not output a single byte, I would rather see
the above line written like this:

	: >empty.patch &&

> +	git format-patch --stdout --cover-letter empty-commit^ >cover-letter.patch &&

This only creates a cover letter without anything, which sort of
looks like an empty commit.

> +	git format-patch --always --stdout empty-commit^ >empty-commit.patch &&

And this gives another empty patch with only a message.

I would sort-of understand if there is

	git format-patch --stdout --always --cover-letter HEAD^ >both.patch

that has two e-mail messages in it, but what's the significance of
testing both cover-letter.patch and empty-commit.patch?

The receiving end would not care what's in the actual e-mail
message, as long as it lacks the patch part, no?  Or am I missing
some subtle reason why we want to test both?

> @@ -1152,4 +1159,70 @@ test_expect_success 'apply binary blob in partial clone' '
>  	git -C client am ../patch
>  '
>  
> +test_expect_success 'still output error with --empty when meeting empty files' '
> +	test_must_fail git am --empty=drop empty.patch 2>actual &&

Nobody will understand "still", unless they know it used to be
unconditionally a failure to feed an e-mail message that lacks a
patch.

test_expect_success 'An empty input file is error regardless of --empty option' '

or something like that?

> +	echo Patch format detection failed. >expected &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'error when meeting e-mail message that lacks a patch by default' '
> +	git checkout empty-commit^ &&
> +	test_must_fail git am empty-commit.patch >err &&
> +	test_path_is_dir .git/rebase-apply &&
> +	test_i18ngrep "Patch is empty." err &&
> +	rm -fr .git/rebase-apply &&

If any command before "rm" fails, it won't be cleaned up.

    test_expect_success 'a message without a patch is an error (default)' '
	test_when_finished "git am --abort || :" &&
	git checkout --detach empty-commit^ &&
	test_must_fail git am empty-commit.patch >err &&
	grep "Patch is empty" err
    '

or something like that.  The title says it tests the default case,
so do not test --empty=die case in the same test.  Use a separate
test to do the same for the case where an explicit "--empty=die"
is given.

As I said, I do not quite see the point of testing with both
empty-commit.patch and cover-letter.patch (unless the latter has an
empty commit and a cover letter, totally in two messages).

> +	test_must_fail git am --empty=die empty-commit.patch >err &&
> +	test_path_is_dir .git/rebase-apply &&
> +	test_i18ngrep "Patch is empty." err &&
> +	rm -fr .git/rebase-apply &&
> +
> +	test_must_fail git am --empty=die cover-letter.patch >err &&
> +	test_path_is_dir .git/rebase-apply &&
> +	test_i18ngrep "Patch is empty." err &&
> +	rm -fr .git/rebase-apply
> +'
> +
> +test_expect_success 'skip without error when meeting e-mail message that lacks a patch' '
> +	git am --empty=drop empty-commit.patch >err &&

The output 'err' is used by nobody; do not redirect it and just
leave the standard output alone.

> +	test_path_is_missing .git/rebase-apply &&

Don't test this condition when testing success or failure from
"am".  That is too much implementation detail.

> +	git rev-parse empty-commit^ >expected &&
> +	git rev-parse HEAD >actual &&
> +	test_cmp expected actual &&

OK, we make sure that HEAD does not move.

> +	git am --empty=drop cover-letter.patch >err &&
> +	test_path_is_missing .git/rebase-apply &&
> +	test_cmp_rev empty-commit^ HEAD

Lose this one?  As I said, I may be missing some subtle reason why
both need to be tested---and if it is the case, test it in a
separate test, not 2 of them in a single test like this.

> +'
> +
> +test_expect_success 'record as an empty commit when meeting e-mail message that lacks a patch' '
> +	git am --empty=keep empty-commit.patch &&
> +	test_path_is_missing .git/rebase-apply &&
> +	{
> +		git show empty-commit --format="%B" &&
> +		echo "--" &&

Did this test pass?  Without a trailing whitespace after double-dash,
I do not think this shell snippet reproduces a patch e-mail correctly

In any case, don't do this.  Imagine a future developer may want to
improve the patch output by adding other things after the "-- "
signature line, in addition to the "git version".  Or perhaps the
"git version" trailer gets removed by default for privacy concerns.

Should such changes be prevented from being made, only because this
test expects exact output we have today?  No.

Verify what we _care_, e.g. "does the title of the resulting commit
reproduce the one-liner message given to '-m' when the empty commit
was made?" is a sensible question to ask.

> +		git version | sed -e "s/^git version //" &&
> +		echo

> +	} >expected &&
> +	git show HEAD --format="%B" >actual &&
> +	test_cmp actual expected &&
> +
> +	git am --empty=keep cover-letter.patch &&
> +	test_path_is_missing .git/rebase-apply &&
> +	{
> +		echo "*** SUBJECT HERE ***" &&
> +		echo &&
> +		echo "*** BLURB HERE ***" &&
> +		echo &&
> +		echo "A U Thor (1):" &&
> +		printf "  " &&
> +		git show empty-commit --format="%B" &&
> +		echo "--" &&
> +		git version | sed -e "s/^git version //" &&
> +		echo

Don't do this.  Imagine a future developer may want to improve the
cover letter template.  Should that change be prevented from being
made, because this test expects exact output we have today?  No.

> +	} >expected &&
> +	git show HEAD --format="%B" >actual &&
> +	test_cmp actual expected
> +'
> +
>  test_done

Thanks.
