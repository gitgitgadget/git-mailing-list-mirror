Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F07C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 01:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67DF761212
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 01:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhIKBNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 21:13:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55916 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbhIKBNp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 21:13:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1423C925B;
        Fri, 10 Sep 2021 21:12:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=whQx4fFE5h5DIGIfUC7PvQKoo
        3gt2SPdXk/72WvkXeA=; b=cVW/SpC5CMRNMn35Aqk8lNBbQ5aHTf7tTbaMT5E6q
        zUT28w27OEf4Z3vrdzMgBUnEfopAA9XPVbehON0PSopzCbI4UUVmw2Awzxi8V/i1
        Uy/E/9dfy4L5118Rh0EJRaV+3U5TWgOu1KVaC42TZVupwjQr83dBqDBKIcMyi2oD
        S4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95B8BC925A;
        Fri, 10 Sep 2021 21:12:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4DEFC9259;
        Fri, 10 Sep 2021 21:12:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/5] help: correct the usage string in -h and
 documentation
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
        <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
        <patch-v2-1.5-b10bfd21f14-20210910T112545Z-avarab@gmail.com>
Date:   Fri, 10 Sep 2021 18:12:31 -0700
Message-ID: <xmqqr1dvoqyo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 56E31F4A-129D-11EC-8CFB-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
> index 44fe8860b3f..568a0b606f3 100644
> --- a/Documentation/git-help.txt
> +++ b/Documentation/git-help.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git help' [-a|--all [--[no-]verbose]] [-g|--guides]
> -	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
> +	   [[-i|--info] [-m|--man] [-w|--web]] [COMMAND|GUIDE]

This one is good, but ...

> diff --git a/builtin/help.c b/builtin/help.c
> index b7eec06c3de..44ea2798cda 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -59,7 +59,8 @@ static struct option builtin_help_options[] =3D {
>  };
> =20
>  static const char * const builtin_help_usage[] =3D {
> -	N_("git help [--all] [--guides] [--man | --web | --info] [<command>]"=
),
> +	N_("git help [-a|--all] [-g|--guides] [--[no-]verbose]]\n"
> +	   "         [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),

Aside from the addition of so-far-missing "verbose", which is
obviously a good change, I am not sure if the other change is a good
idea.

This is because *_usage[] is designed to be always shown together
with the list of options built from the option table the
parse_options() uses, and the readers will see the correspondence
between long and short options even more clear there.

    $ git help -h
    usage: git help [--all] [--guides] [--man | --web | --info] [<command=
>]

        -a, --all             print all available commands
        -g, --guides          print list of useful guides
        -c, --config          print all configuration variable names
        -m, --man             show man page
        -w, --web             show manual in web browser
        -i, --info            show info page
        -v, --verbose         print command description

If you look at output from=20

    $ git grep -A4 -e '_usage\[' builtin/\*.c

you'll notice that many of them do not even spell out each option
and instead have a single [<options>] placeholder unless the command
has only very small number of options.  With the number of options
that "git help" takes, it might even be warranted to switch to the
more generic "git help [<option>...] [<command>]".

Not a strict veto, but just making sure if the over-cluttering of
the early lines in "help -h" output has been considered as a
possible downside before suggesting this change.

Thanks.
