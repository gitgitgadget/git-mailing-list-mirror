Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60A4C433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 21:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiAUVMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 16:12:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60964 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiAUVMS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 16:12:18 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DE5110B01E;
        Fri, 21 Jan 2022 16:12:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pL8OWp60647A
        PJCp73q8Hac9wkSrzsJRQYO53Dx0NQw=; b=pSW2O/WV0/444qYGvcyb7ZpVdzsS
        hBeJZ02gYzBNbzjZ4ZDP33U5BYjcs4Ki0IOw57SyrC1zP2dNg7Ibf3At4+VdyJmc
        G9sc+osT7MINWbAQ6ZXRAYyum7EnkwVxhdeGbcec0fAfUuWjUD7FW3yrDSC0emUz
        xUtudjuq4GNqi1g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 940F210B01D;
        Fri, 21 Jan 2022 16:12:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 015C610B01C;
        Fri, 21 Jan 2022 16:12:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch,checkout: fix --track usage strings
References: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
        <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
        <220120.86zgnqli9v.gmgdl@evledraar.gmail.com>
        <xmqqbl06jlr6.fsf@gitster.g>
        <220121.86ee51l3jd.gmgdl@evledraar.gmail.com>
Date:   Fri, 21 Jan 2022 13:12:15 -0800
In-Reply-To: <220121.86ee51l3jd.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 21 Jan 2022 12:27:33 +0100")
Message-ID: <xmqqilucg5e8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CFEB0A14-7AFE-11EC-9D27-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Also, with the sh completion if you do "git add --chm<TAB>" it expands
> it to "git add --chmod=3D", i.e. the cursor is left after the "=3D" tha=
t's
> not shown in the "git add -h". So always including it would be
> consistent with that.
>    =20
>     diff --git a/parse-options.c b/parse-options.c
>     index a8283037be9..75c345bb738 100644
>     --- a/parse-options.c
>     +++ b/parse-options.c
>     @@ -916,7 +916,7 @@ static int usage_argh(const struct option *opts=
, FILE *outfile)
>                     else
>                             s =3D literal ? "[%s]" : "[<%s>]";
>             else
>     -               s =3D literal ? " %s" : " <%s>";
>     +               s =3D literal ? "=3D%s" : "=3D<%s>";

If the option has a long name, I think it is a good change.  I do
not offhand know if it is a good change for a short option, though.

    $ git diff -B=3D20/60
    error: break-rewrites expects <n>/<m> form
    $ git diff -B 20/60
    fatal: ambiguous argument '20/60': unknown revision or path not in th=
e working tree.
    $ git diff -B20/60

gitcli.txt has this (I didn't check with the parse-options
implementation, though):

 * when a command-line option takes an argument, use the 'stuck' form.  I=
n
   other words, write `git foo -oArg` instead of `git foo -o Arg` for sho=
rt
   options, and `git foo --long-opt=3DArg` instead of `git foo --long-opt=
 Arg`
   for long options.  An option that takes optional option-argument must =
be
   written in the 'stuck' form.

So probably you'd need the same "show differently depending on which
between short and long we will show" on this side of the if/else.

	else {
		if (opts->long_name)
			s =3D literal ? "=3D%s" : "=3D<%s>";
		else
			s =3D literal ? "%s" : "<%s>";
	}

perhaps?
