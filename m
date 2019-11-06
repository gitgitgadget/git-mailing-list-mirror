Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04C221F454
	for <e@80x24.org>; Wed,  6 Nov 2019 04:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfKFEky (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 23:40:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62045 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfKFEkx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 23:40:53 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6395A5ABB;
        Tue,  5 Nov 2019 23:40:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2JnV1D48huI/vO8ceOUTLPE/M18=; b=BrnvyD
        ZKZVdc8mOSkgD5An1EWc3S/bYsI1K6rHfoehVV1VZI4Qng40v3odEUWBuZOJnEFS
        miBDtNBRkYKP1+VkawXbeIRTIGn2hYydbMWuN7zNy74MTA8QpDl9+Yw3WFxChUXY
        pjUk5KXK7ePRBKR32kUuyjkjp0S70qYw04KIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VoGZsRgmdcDxOK8L6Ew8ofW4HXbrOqI9
        kpR5CVK+zcC/7jZZhoPqBYK8XqbR4PTGF3Bx96wL6aLmAIpJq/Ycj9CVWo8TVRd+
        jChffKehg18g1/QjKh2HZ6AGVP/VQ6DIOf4kQtO7w5X77LZnRgR21bzCf72vnVBi
        s04S5ULPq2c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CE0F9A5ABA;
        Tue,  5 Nov 2019 23:40:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 056F2A5AB8;
        Tue,  5 Nov 2019 23:40:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 3/5] reset: support the --pathspec-from-file option
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <8d9f1fbc18346144a0c866a59891b652dcfe9b7f.1572895605.git.gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 13:40:46 +0900
In-Reply-To: <8d9f1fbc18346144a0c866a59891b652dcfe9b7f.1572895605.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Mon, 04 Nov 2019
        19:26:43 +0000")
Message-ID: <xmqqd0e5vcq9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9AF4E6D0-004F-11EA-BC33-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>
> This option solves the problem of commandline length limit for UI's
> built on top of git. Plumbing commands are not always a good fit, for
> two major reasons:
> 1) Some UI's serve as assistants that help user run git commands. In
>    this case, replacing familiar commands with plumbing commands will
>    confuse most users.

"UI's that serve as assistants that help user run git commands" does
not have to avoid plumbing commands at all.  Only the ones that "show"
the commands that are run on behalf of the users (perhaps so that the
users can learn from such examples?) do, and I think I learned that
it was your motivating use case from an earlier discussion.  Perhaps

	UIs that help users to formulate git commands to run need to
	present Porcelain commands to be used, as it is not reasonable
	to demonstrate arcane combination of plumbing commands as an
	example for their interactive use.

would probably be more readable without bending what you wanted to
say too much?

> 2) Some UI's have started and grown with porcelain commands. Replacing
>    existing logic with plumbing commands could be cumbersome and prone
>    to various new problems.

There is not a lot of sympathy for such argument ;-)

> 2) It is not allowed to pass some refspecs in args and others in file.

Did you mean refspec, not pathspec?

> 3) New options do not have shorthands to avoid shorthand conflicts.
>
> Also add new '--pathspec-file-null' switch that mirrors '-z' used in
> various places. Some porcelain commands, such as `git commit`, already
> use '-z', therefore it needed a new unambiguous name.

I do not understand this part.  Wouldn't it natural to expect that
"-z", when used with "--pathspec-from-file", tell us that the named
file is NUL delimited collection of records?  What's different about
"--pathspec-file-null" that it is confusing to all it "-z"?

I actually do not mind not having "-z" and using only
"--pathspec-file-null".  A new option with long name that feels
similar to existing "-z" but does sufficiently different things so
that it needs a different name, however, feels counter-productive
for the purpose of using it in the UI that produces commands to be
learned by end-users.

> +--pathspec-from-file=<file>::
> +	Read `<pathspec>` from `<file>` instead. If `<file>` is exactly `-`
> +	then read from standard input. Pathspecs are separated by LF or
> +	CR/LF. Pathspecs can be quoted as explained for the configuration

When I invented the terms "pathspec", "refspec", etc. for this
project, I meant them to be collective nouns.  A pathspec is a set
of pathspec elements, each of which is usually given as a separate
argument on the command line.  So "Read pathspec from file" is good
(not "Read pathspecs from file").

And "Pathspec elements" are separated by LF or CR/LF.

A tangent.  Since we do not allow NUL in a pathspec element, we do
not even need the "-z" option.  When we read pathspec from a file,
we can take any of CRLF, LF or NUL as the separator.

Ah, sorry, that would not help very much.  With "-z" we are allowing
to express pathspec elements inside which there are embedded LF or
CR/LF.  Sorry about the noise.

> +--pathspec-file-null::
> +	Only meaningful with `--pathspec-from-file`. Pathspecs are
> +	separated with NUL character and are not expected to be quoted.

OK.

> +	if (pathspec_from_file) {
> +		if (patch_mode)
> +			die(_("--pathspec-from-file is incompatible with --patch"));
> +
> +		if (pathspec.nr)
> +			die(_("--pathspec-from-file is incompatible with path arguments"));

Shouldn't the error message say pathspec arguments instead?

> diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
> new file mode 100755
> index 0000000000..cf7f085ad5
> --- /dev/null
> +++ b/t/t7107-reset-pathspec-file.sh
> @@ -0,0 +1,126 @@
> +#!/bin/sh
> +
> +test_description='reset --pathspec-from-file'
> +
> +. ./test-lib.sh
> +
> +cat > expect.a <<EOF

Style:

 - Modern test scripts strive to perform these set-up procedure
   inside (the first) test_expect_success.

 - No SP between the redirection operator and its source/destination
   filename.

 - Quote end-of-here-document (EOF in the above) if you do not rely
   on parameter interpolation inside the here document; this helps
   readers by telling them that what is presented is used verbatim.

> + D fileA.t
> +EOF
> +
> +cat > expect.ab <<EOF
> + D fileA.t
> + D fileB.t
> +EOF
> +
> +cat > expect.a_bc_d <<EOF
> +D  fileA.t
> + D fileB.t
> + D fileC.t
> +D  fileD.t
> +EOF
> +
> +test_expect_success setup '
> +	echo A >fileA.t &&
> +	echo B >fileB.t &&
> +	echo C >fileC.t &&
> +	echo D >fileD.t &&
> +	git add . &&
> +	git commit --include . -m "Commit" &&
> +	checkpoint=$(git rev-parse --verify HEAD)
> +'
> +
> +restore_checkpoint () {
> +	git reset --hard "$checkpoint"
> +}

Hmm, wouldn't it be cleaner to use a lightweight tag or something to
keep checkpoint, instead of a variable that is hard to examine when
tests break and needs debugging?

> +verify_state () {
> +	git status --porcelain -- fileA.t fileB.t fileC.t fileD.t >actual &&
> +	test_cmp "$1" actual
> +}
> +
> +test_expect_success '--pathspec-from-file from stdin' '
> +	restore_checkpoint &&
> +
> +	git rm fileA.t &&
> +	echo fileA.t | git reset --pathspec-from-file=- &&
> +	verify_state expect.a
> +'
> +
> +test_expect_success '--pathspec-from-file from file' '
> +	restore_checkpoint &&
> +
> +	git rm fileA.t &&
> +	echo fileA.t >list &&
> +	git reset --pathspec-from-file=list &&
> +
> +	verify_state expect.a
> +'
> +
> +test_expect_success 'NUL delimiters' '
> +	restore_checkpoint &&
> +
> +	git rm fileA.t fileB.t &&
> +	printf fileA.tQfileB.t | q_to_nul | git reset --pathspec-from-file=- --pathspec-file-null &&

This feeds "fileA.t<NUL>fileB.t" without <NUL> after "fileB.t" to
the command.  Intended?

Rather, perhaps

	printf "%s\0" fileA.t fileB.t

without q-to-nul, once you use printf anyway?

If you truly mean "delimiter" (as opposed to "terminator"),

	printf "fileA.t\0fileB.t"

can also lose " | q_to_nul".

Thanks.
