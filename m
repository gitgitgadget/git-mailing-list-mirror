Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402E1C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 20:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241163AbiCaUJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 16:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiCaUJc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 16:09:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7F823586B
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 13:07:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED895125398;
        Thu, 31 Mar 2022 16:07:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8AqXmtLBDM4X
        9W0t4J2YY3GchmhxoFtGjOtCYzzbw70=; b=QMCehhkZXbijEyvqHZxd3IbwJfwm
        Vf97yc45iaKi6N71xQkiKImV3eI+8D1gVjtEny8b/athacuPXXW6xloEwyrp2V0k
        tKHlq1IlAKUCshToqStDfnIQKwnGSHNzXPplEgTkZr6JXpXHd+12Xmdi8nAwgmrw
        mXspJjgj2VPme7k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5788125397;
        Thu, 31 Mar 2022 16:07:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 52BC7125396;
        Thu, 31 Mar 2022 16:07:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Garrit Franke <garrit@slashdev.space>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <ttaylorr@github.com>
Subject: Re: [PATCH v2] cli: add -v and -h shorthands
References: <20220330190956.21447-1-garrit@slashdev.space>
        <xmqq5ynv6rb4.fsf@gitster.g>
        <fb915b91-ead2-ac35-4431-ad35674da463@slashdev.space>
        <220331.86tubfrngz.gmgdl@evledraar.gmail.com>
        <f3935840-e2a0-953e-0e7c-ac921d414ddc@slashdev.space>
Date:   Thu, 31 Mar 2022 13:07:40 -0700
In-Reply-To: <f3935840-e2a0-953e-0e7c-ac921d414ddc@slashdev.space> (Garrit
        Franke's message of "Thu, 31 Mar 2022 15:08:12 +0200")
Message-ID: <xmqqsfqx28dv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 38584D4A-B12E-11EC-8EA7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garrit Franke <garrit@slashdev.space> writes:

> On 31.03.22 02:07, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> I think this is a good trade-off in this case. I.e. -v and -h are
>> commonly understood.
>
> An interesting observation I just made is that curl [0] uses both
> "--verbose" and "--version" on the top level [1][2] including
> shorthands. "-v" corresponds to "verbose", "-V" corresponds to
> "version.
>
> Not that I'm a fan of this clutter, but it's a possible path to go
> down if we actually needed a second shorthand using this letter.

Do you mean you want to use "-V" for version, instead of the "-v"
used in the patch, so that "-v" can be left for "--verbose"?

I am not sure consistency with whom we are aiming for anymore with
that mixed to the proposal X-<.

>  const char git_usage_string[] =3D
> -	N_("git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
> +	N_("git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<valu=
e>]\n"
>  	   "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [-=
-info-path]\n"
>  	   "           [-p | --paginate | -P | --no-pager] [--no-replace-obje=
cts] [--bare]\n"
>  	   "           [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespa=
ce=3D<name>]\n"

This is an improvement in that the first line that used to be
unusually shorter now becomes comparable length to other lines ;-)

> @@ -146,7 +146,8 @@ static int handle_options(const char ***argv, int *=
argc, int *envchanged)
>  		 * commands can be written with "--" prepended
>  		 * to make them look like flags.
>  		 */
> -		if (!strcmp(cmd, "--help") || !strcmp(cmd, "--version"))
> +		if (!strcmp(cmd, "--help") || !strcmp(cmd, "--version") ||
> +		    !strcmp(cmd, "-h") || !strcmp(cmd, "-v"))
>  			break;

OK.

> @@ -893,7 +894,12 @@ int cmd_main(int argc, const char **argv)
>  	handle_options(&argv, &argc, NULL);
>  	if (argc > 0) {
>  		/* translate --help and --version into commands */
> -		skip_prefix(argv[0], "--", &argv[0]);
> +		if (!strcmp("-v", argv[0]))
> +			argv[0] =3D "version";
> +		else if (!strcmp("-h", argv[0]))
> +			argv[0] =3D "help";
> +		else
> +			skip_prefix(argv[0], "--", &argv[0]);

I find this unnecessarily hard to read.

    (Side note) A tip for reviewers.  Be suspicious of any change
    that adds new things _in front_ of existing sequence.  Question
    if there is a good justification for it.  If there isn't, see if
    it makes it better if you instead append the new stuff to
    existing sequence.  If neither results in satisfying code,
    perhaps it is good time to totally rewrite it to make both
    existing and new stuff fit in the flow.

The original was in a sense a bit sloppy to strip "--" from anything
that begins with "--", when we only care about "--verbose" and
"--help" and nothing else (granted, handle_options() would barf when
argv[0] begins with "--" and is not one of these two, so the
sloppiness does not make a difference in practice).

If we accept the same kind of sloppiness, perhaps

		if (skip_prefix(argv[0], "--", &argv[0]))
                	; /* removed "--" from "--help" and "--version" */
		else if (argv[0][0] =3D=3D '-')
                	argv[0] =3D argv[0][1] =3D=3D 'v' ? "version" : "help";
                =09
would make the new side match the existing one better, but I would
not necessarily recommend it.

We may want to be a bit more explicit and readable, by spelling out
the expectation, i.e.

		if (!strcmp("--version", argv[0]) || !strcmp("-v", argv[0]))
			argv[0] =3D "version";
		else if (!strcmp("--help", argv[0]) || !strcmp("-h", argv[0]))
			argv[0] =3D "help";=20

This makes it clear that these two pseudo-commands, spelled with a
dash in front and stand for other commands, are the only thing we
care about and what their accepted spelling are.

Hmm?
