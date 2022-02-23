Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AFFC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 22:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240691AbiBWWND (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 17:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiBWWND (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 17:13:03 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34783E0D8
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 14:12:34 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A281318B8FA;
        Wed, 23 Feb 2022 17:12:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eUOjRuCWFt9a
        FVcQ/8QDGhQK0AVqBKbOY/Xl75+BDzw=; b=sO+ryYABmrp0iHwd8sJ3berWirwm
        S18pmUYrCVB6QxuBaKM3sbDS/fQ2PMADAzivZA1a9i+a71iKQHQjlC1IrYmYjRkg
        leplc/RRspbyh11shiOzJFJV7jTaetebQmDheGrbM+FDeMuEw8x0OWPkDCa8+eIk
        +EutkIFNDS1KmDc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9943118B8F9;
        Wed, 23 Feb 2022 17:12:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D0EC918B8F8;
        Wed, 23 Feb 2022 17:12:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 6/9] help: correct usage & behavior of "git help --all"
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
        <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
        <patch-v2-6.9-868e8a6cf83-20220221T193708Z-avarab@gmail.com>
Date:   Wed, 23 Feb 2022 14:12:30 -0800
In-Reply-To: <patch-v2-6.9-868e8a6cf83-20220221T193708Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 21 Feb
 2022 20:38:49
        +0100")
Message-ID: <xmqq1qzts04x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B22B45B4-94F5-11EC-AFD3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
> index cf1d53e9499..d07590c8ff7 100644
> --- a/Documentation/git-help.txt
> +++ b/Documentation/git-help.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git help' [-a|--all] [--[no-]verbose]
> -	   [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
> +'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]

Hmph, OK.  The earlier one made it appear that when -a is given to
"git help" it would also accept command or guide, which is no longer
true.

>  'git help' [-g|--guides]
>  'git help' [-c|--config]

This is not new, but don't we need to fix the mark-up of [-a|--all]
and [-g|--guides] and [-c|--config]?  It's not like "We can give 0
or more of i/-m/-w".  These are "we have to give either -a or --all
to trigger this mode".

> diff --git a/builtin/help.c b/builtin/help.c
> index 1c1581ef850..b682446bbf5 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -75,8 +75,8 @@ static struct option builtin_help_options[] =3D {
>  };
> =20
>  static const char * const builtin_help_usage[] =3D {
> -	N_("git help [-a|--all] [--[no-]verbose]]\n"
> -	   "         [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
> +	N_("git help [-a|--all] [--[no-]verbose]]"),
> +	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
>  	N_("git help [-g|--guides]"),
>  	N_("git help [-c|--config]"),
>  	NULL
> @@ -594,6 +594,7 @@ int cmd_help(int argc, const char **argv, const cha=
r *prefix)
> =20
>  	switch (cmd_mode) {
>  	case HELP_ACTION_ALL:
> +		opt_mode_usage(argc, "--all");

OK.

>  		if (verbose) {
>  			setup_pager();
>  			list_all_cmds_help();
> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> index 9ac3f5d3c4b..c87730aa920 100755
> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -35,6 +35,9 @@ test_expect_success 'basic help commands' '
>  '
> =20
>  test_expect_success 'invalid usage' '
> +	test_expect_code 129 git help -a add &&
> +	test_expect_code 129 git help --all add &&
> +
>  	test_expect_code 129 git help -g add &&
>  	test_expect_code 129 git help -a -c &&
