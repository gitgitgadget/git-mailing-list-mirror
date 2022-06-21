Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8993BC43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 16:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351711AbiFUQ1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiFUQ1i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 12:27:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4022E2D1EE
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 09:27:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0220C1916E9;
        Tue, 21 Jun 2022 12:27:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=64CoLcZWFjmb
        pA2/hHtUCIqTPYBGzG+f7Bu/l1Cxutk=; b=lUp/K0nb5DSIMQYlMoqYrGUORb/L
        3PCMp+Z2ECu7kkRSpYsMIoPERF1qQtTtWThqW+w1HsauxWIKHEFa4kEye6ROVIhG
        fhKuneO7jutYviyok6zOxdwB1Tzm/MRQikLtFZ1L0z7QnRgILWpL8ck8Y43VyKxx
        iEsXO2sUtQ8gqag=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D9D6F1916E8;
        Tue, 21 Jun 2022 12:27:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6FA801916E7;
        Tue, 21 Jun 2022 12:27:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Martin_=C3=85gren_=5B_=5D?= <martin.agren@gmail.com>,
        "Paul Eggert [ ]" <eggert@cs.ucla.edu>,
        "Carlos L." <00xc@protonmail.com>
Subject: Re: [PATCH v2] grep: add --max-count command line option
References: <pull.1278.git.git.1655740174420.gitgitgadget@gmail.com>
        <pull.1278.v2.git.git.1655789777023.gitgitgadget@gmail.com>
Date:   Tue, 21 Jun 2022 09:27:30 -0700
In-Reply-To: <pull.1278.v2.git.git.1655789777023.gitgitgadget@gmail.com>
        (Carlos L. via GitGitGadget's message of "Tue, 21 Jun 2022 05:36:16
        +0000")
Message-ID: <xmqq5ykuhthp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0C83AD54-F17F-11EC-AB73-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Carlos L. via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Carlos=3D20L=3DC3=3DB3pez?=3D <00xc@protonmail.com>
>
> This patch adds a command line option analogous to that of GNU
> grep(1)'s -m / --max-count, which users might already be used to.
> This makes it possible to limit the amount of matches shown in the
> output while keeping the functionality of other options such as -C
> (show code context) or -p (show containing function), which would be
> difficult to do with a shell pipeline (e.g. head(1)).
>
> Signed-off-by: Carlos L=C3=B3pez 00xc@protonmail.com
> ---
> ...
>  Documentation/git-grep.txt | 8 ++++++++
>  builtin/grep.c             | 9 +++++++++
>  grep.c                     | 2 ++
>  grep.h                     | 2 ++
>  4 files changed, 21 insertions(+)

Tests?

> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 3d393fbac1b..19b817d5e58 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -23,6 +23,7 @@ SYNOPSIS
>  	   [--break] [--heading] [-p | --show-function]
>  	   [-A <post-context>] [-B <pre-context>] [-C <context>]
>  	   [-W | --function-context]
> +	   [(-m | --max-count) <num>]
>  	   [--threads <num>]
>  	   [-f <file>] [-e] <pattern>
>  	   [--and|--or|--not|(|)|-e <pattern>...]
> @@ -238,6 +239,13 @@ providing this option will cause it to die.
>  	`git diff` works out patch hunk headers (see 'Defining a
>  	custom hunk-header' in linkgit:gitattributes[5]).
> =20
> +-m <num>::
> +--max-count <num>::
> +	Limit the amount of matches per file. When using the `-v` or
> +	`--invert-match` option, the search stops after the specified
> +	number of non-matches. A value of -1 will return unlimited
> +	results (the default).

Hmph ...

> +	/*
> +	 * Optimize out the case where the amount of matches is limited to ze=
ro.
> +	 * We do this to keep results consistent with GNU grep(1).
> +	 */
> +	if (opt.max_count =3D=3D 0)
> +		exit(EXIT_FAILURE);
> +

OK, so "stop before seeing any match" logically leads to "we found
nothing, so exit with non-zero".

> diff --git a/grep.c b/grep.c
> index 82eb7da1022..b32ab75cb6b 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1686,6 +1686,8 @@ static int grep_source_1(struct grep_opt *opt, st=
ruct grep_source *gs, int colle
>  		bol =3D eol + 1;
>  		if (!left)
>  			break;
> +		if (opt->max_count !=3D -1 && count =3D=3D opt->max_count)
> +			break;

I would have written it "if (0 <=3D opt->max_count && ...)".  What
happens when a trickster asks you to do "git grep -m -2"?

I guess what I am getting at is if we are better off saying that
negative means unlimited, instead of special casing -1 like this.  I
didn't think it through so it may be perfectly possible that what
you wrote makes more sense than "anything negative is unlimited".

I dunno.

>  		left--;
>  		lno++;
>  	}

Thanks.

> diff --git a/grep.h b/grep.h
> index c722d25ed9d..bdcadce61b8 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -171,6 +171,7 @@ struct grep_opt {
>  	int show_hunk_mark;
>  	int file_break;
>  	int heading;
> +	int max_count;
>  	void *priv;
> =20
>  	void (*output)(struct grep_opt *opt, const void *data, size_t size);
> @@ -181,6 +182,7 @@ struct grep_opt {
>  	.relative =3D 1, \
>  	.pathname =3D 1, \
>  	.max_depth =3D -1, \
> +	.max_count =3D -1, \
>  	.pattern_type_option =3D GREP_PATTERN_TYPE_UNSPECIFIED, \
>  	.colors =3D { \
>  		[GREP_COLOR_CONTEXT] =3D "", \
>
> base-commit: 5b71c59bc3b9365075e2a175aa7b6f2b0c84ce44
