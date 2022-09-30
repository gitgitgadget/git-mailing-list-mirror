Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C49C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 21:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiI3VBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 17:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiI3VBS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 17:01:18 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B18F10EDBA
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 14:01:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BC3F144CD5;
        Fri, 30 Sep 2022 17:01:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=88NnmTF4OBGFOFUgtzPOT+iyX
        P1O239fNsCIlXCwwo8=; b=rYU8TaUXzO6rsXvVWI3TuAG2kZom/wExBQKFP3atU
        pfAfzNL/y1WTeslg5O0TFXSvmRPPazrkqzsS0n9msJb+hTI7tz/cD39q3al2A9Jk
        6iw9kTA0tyWSiEwzcgKaNzdR1XrSxkFwcgG7mIJArJEC05yaaEK9GNd6aoWxPwFF
        6A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F7AE144CD4;
        Fri, 30 Sep 2022 17:01:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 618A1144CD3;
        Fri, 30 Sep 2022 17:01:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 03/36] bundle: define subcommand -h in terms of
 command -h
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-03.36-953a72abee1-20220930T180415Z-avarab@gmail.com>
Date:   Fri, 30 Sep 2022 14:01:14 -0700
Message-ID: <xmqqo7uwa86d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 05AD1DAC-4103-11ED-ADE5-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Avoid repeating the "-h" output for the "git bundle" command, and
> instead define the usage of each subcommand with macros, so that the
> "-h" output for the command itself can re-use those definitions. See
> [1], [2] and [3] for prior art using the same pattern.
>
> 1. b25b727494f (builtin/multi-pack-index.c: define common usage with a
>    macro, 2021-03-30)
> 2. 8757b35d443 (commit-graph: define common usage with a macro,
>    2021-08-23)
> 3. 1e91d3faf6c (reflog: move "usage" variables and use macros,
>    2022-03-17)

This of course is an improvement, but makes me wonder if we need to
device even more concise ways to simplify all these commands with
subcommands. =20

Unlike the simplest case like this one, where no subcommand take any
option, a more general mechanism needs to allow some subcommands to
take their own options, so it will probably not an easy thing to do,
and a more general one that allows us to write each string only once
would probably need its own "mark-up" language, so it would probably
not be a good direction to go.  So let's declare that the pattern
used in the result of applying this patch is the optimal one and
stop there.

Thanks.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/bundle.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/bundle.c b/builtin/bundle.c
> index 5c78894afd5..1b08700bf9e 100644
> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c
> @@ -11,31 +11,40 @@
>   * bundle supporting "fetch", "pull", and "ls-remote".
>   */
> =20
> -static const char * const builtin_bundle_usage[] =3D {
> -	N_("git bundle create [<options>] <file> <git-rev-list args>"),
> -	N_("git bundle verify [<options>] <file>"),
> -	N_("git bundle list-heads <file> [<refname>...]"),
> -	N_("git bundle unbundle <file> [<refname>...]"),
> -	NULL
> +#define BUILTIN_BUNDLE_CREATE_USAGE \
> +	N_("git bundle create [<options>] <file> <git-rev-list args>")
> +#define BUILTIN_BUNDLE_VERIFY_USAGE \
> +	N_("git bundle verify [<options>] <file>")
> +#define BUILTIN_BUNDLE_LIST_HEADS_USAGE \
> +	N_("git bundle list-heads <file> [<refname>...]")
> +#define BUILTIN_BUNDLE_UNBUNDLE_USAGE \
> +	N_("git bundle unbundle <file> [<refname>...]")
> +
> +static char const * const builtin_bundle_usage[] =3D {
> +	BUILTIN_BUNDLE_CREATE_USAGE,
> +	BUILTIN_BUNDLE_VERIFY_USAGE,
> +	BUILTIN_BUNDLE_LIST_HEADS_USAGE,
> +	BUILTIN_BUNDLE_UNBUNDLE_USAGE,
> +	NULL,
>  };
> =20
>  static const char * const builtin_bundle_create_usage[] =3D {
> -	N_("git bundle create [<options>] <file> <git-rev-list args>"),
> +	BUILTIN_BUNDLE_CREATE_USAGE,
>  	NULL
>  };
> =20
>  static const char * const builtin_bundle_verify_usage[] =3D {
> -	N_("git bundle verify [<options>] <file>"),
> +	BUILTIN_BUNDLE_VERIFY_USAGE,
>  	NULL
>  };
> =20
>  static const char * const builtin_bundle_list_heads_usage[] =3D {
> -	N_("git bundle list-heads <file> [<refname>...]"),
> +	BUILTIN_BUNDLE_LIST_HEADS_USAGE,
>  	NULL
>  };
> =20
>  static const char * const builtin_bundle_unbundle_usage[] =3D {
> -	N_("git bundle unbundle <file> [<refname>...]"),
> +	BUILTIN_BUNDLE_UNBUNDLE_USAGE,
>  	NULL
>  };
