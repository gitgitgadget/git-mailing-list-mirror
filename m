Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49887C433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 17:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26AE5611BF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 17:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbhKISBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 13:01:15 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60472 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241149AbhKISBO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 13:01:14 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6213D1505B6;
        Tue,  9 Nov 2021 12:58:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eqy4bzcb2vHP
        LYqcssJX+8kxUsK9dDCrdOGpdClSN5U=; b=TQuETBk9fCkNR3gsZEb0p+yhsPYf
        2o+SwTtV+We/WSSckcXTOM3RlkQ7dzbKMuLrkO5tQAQGarmUCUD+RN4OGxukggqt
        Sx6hZCx5JYVAPl8W1vHRxQeE64IEA8huEWqBXcYC6Zvdt511eWP3u3NRqiHu5VIu
        s9CBSNU/GRpO+bo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5BDB41505B5;
        Tue,  9 Nov 2021 12:58:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BA7741505B3;
        Tue,  9 Nov 2021 12:58:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 2/2] parse-options.c: use "enum parse_opt_result" for
 parse_nodash_opt()
References: <211106.86lf21ezqx.gmgdl@evledraar.gmail.com>
        <cover-0.2-00000000000-20211109T110113Z-avarab@gmail.com>
        <patch-2.2-aa6224b10f8-20211109T110113Z-avarab@gmail.com>
Date:   Tue, 09 Nov 2021 09:58:18 -0800
In-Reply-To: <patch-2.2-aa6224b10f8-20211109T110113Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 9 Nov
 2021 12:04:44 +0100")
Message-ID: <xmqqo86t2oud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A300BAD2-4186-11EC-8DD8-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the parse_nodash_opt() function to use "enum
> parse_opt_result". In 352e761388b (parse-options.[ch]: consistently
> use "enum parse_opt_result", 2021-10-08) its only caller
> parse_options_step() started using that return type, and the
> get_value() which will be called and return from it uses the same
> enum.
>
> Let's do the same here so that this function always returns an "enum
> parse_opt_result" value.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  parse-options.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index fc5b43ff0b2..629e7963497 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -404,8 +404,9 @@ static enum parse_opt_result parse_long_opt(
>  	return PARSE_OPT_UNKNOWN;
>  }
> =20
> -static int parse_nodash_opt(struct parse_opt_ctx_t *p, const char *arg=
,
> -			    const struct option *options)
> +static enum parse_opt_result parse_nodash_opt(struct parse_opt_ctx_t *=
p,
> +					      const char *arg,
> +					      const struct option *options)
>  {
>  	const struct option *all_opts =3D options;
> =20
> @@ -415,7 +416,7 @@ static int parse_nodash_opt(struct parse_opt_ctx_t =
*p, const char *arg,
>  		if (options->short_name =3D=3D arg[0] && arg[1] =3D=3D '\0')
>  			return get_value(p, options, all_opts, OPT_SHORT);
>  	}
> -	return -2;
> +	return PARSE_OPT_ERROR;
>  }

The current caller only checks to skip a token that yields 0 (aka
PARSE_OPT_DONE) and does not distinguish between other values, so
this won't change the behaviour of the current code, but it is=20
not clear if returning -1 (aka PARSE_OPT_ERROR) is better than -2
(aka PARSE_OPT_HELP).

