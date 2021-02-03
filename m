Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2806DC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 20:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CDC64F5C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 20:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhBCUyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 15:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhBCUqR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 15:46:17 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271B0C061788
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 12:44:35 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id r12so1244244ejb.9
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 12:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qx/awqsmQyE7xIjh6GSwMCxOSpAd2go2zCswVC5s7rg=;
        b=FNXw9sTxkU26nbeavfnqnL+9oLrttYpdZmRemXBPzicE/i7dH+yr8sga7/q95e3ngp
         bZ3Bz8Qa1iwnCubiJzGU9tHNW2xfQdnu2epyJu87k3Vdfi7/NAs5fxlWyxzsZA73W2rN
         DyZ8VB2NJoLwLt3McX+ZGNyHJISyFC6ecmG2c8vodLLkaZZ8H/jFlrT4CFI5uok2OEEX
         OljKD+URluasRrsngr2mVAG/yv/cpahE7TxOcki9aX8KHoozSvlmZri6OaR3K6gIGhhf
         EKjl6rSsZ18WIQw1+hzVpWjjOtGNW0eybbzi8x4BhUDaoyhGpESBhdYh93QSidihYwNP
         jIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=qx/awqsmQyE7xIjh6GSwMCxOSpAd2go2zCswVC5s7rg=;
        b=auXuDsSS8XNOEV7ZQibcEmYZJyzV5wsm7kwMqIdd0pH06kaEQ/L2eT25DaAwfFK2iE
         x9lj3S2YqBt3rDkjZwIL8m096l4GKdDIi69JkNitQL39z9wF3PpV7E7mbq2hMsCIOXfV
         X89ytkyQvHQS94Lw3gQMHSakEsC3hB7e0Iwf+4F43qAbZNVNs0eubQ5mhqY3/jgLGynH
         /yHKQ0PWR2hKL2TtYZqUSPbstq6LsSfjZ3UofHQcHyywSkQAAxYMXqPSJfLnE1wASe6a
         9AWmVVIgXtw1nL9AyfhIiZ+C0mDbMrWp+lfkOhDsaJmaF5gHlseTi6KXjxSZZEtbzr6s
         uFOA==
X-Gm-Message-State: AOAM533siTVVTh1eYZ6/TtpShDZ1O+eISp5fQ6cMrKkRXbUEYFGQgmPd
        d/gGrVnzdwFP+3bYkPGYiUbvZawAR6JBdw==
X-Google-Smtp-Source: ABdhPJzdfiYDpCKVAkR8Xn0E2cDDn45WWaIpc7v0p4xn/KHMObhS79pPeHLeIZSW3LjUHnnK+psvBA==
X-Received: by 2002:a17:906:fcb1:: with SMTP id qw17mr5093662ejb.7.1612385073420;
        Wed, 03 Feb 2021 12:44:33 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id u17sm1465735ejr.59.2021.02.03.12.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 12:44:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?B?= =?utf-8?Q?el=C3=B3n?= 
        <carenas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 21/25] pickaxe: use PCREv2 for -G and -S
References: <20210203032811.14979-1-avarab@gmail.com>
 <20210203032811.14979-22-avarab@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210203032811.14979-22-avarab@gmail.com>
Date:   Wed, 03 Feb 2021 21:44:31 +0100
Message-ID: <87y2g4dgpc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 03 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>  void diffcore_pickaxe(struct diff_options *o)
>  {
>  	const char *needle =3D o->pickaxe;
>  	int opts =3D o->pickaxe_opts;
> -	regex_t regex, *regexp =3D NULL;
> -	kwset_t kws =3D NULL;
> +	struct grep_opt opt;
> +
> +	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_GS_MASK)) {
> +		grep_init(&opt, the_repository, NULL);
> +#ifdef USE_LIBPCRE2
> +		grep_commit_pattern_type(GREP_PATTERN_TYPE_PCRE, &opt);
> +#else
> +		grep_commit_pattern_type(GREP_PATTERN_TYPE_ERE, &opt);
> +#endif
>=20=20
> -	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
> -		int cflags =3D REG_EXTENDED | REG_NEWLINE;
>  		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE)
> -			cflags |=3D REG_ICASE;
> -		regcomp_or_die(&regex, needle, cflags);
> -		regexp =3D &regex;
> -	} else if (opts & DIFF_PICKAXE_KIND_S) {
> -		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE &&
> -		    has_non_ascii(needle)) {
> -			struct strbuf sb =3D STRBUF_INIT;
> -			int cflags =3D REG_NEWLINE | REG_ICASE;
> -
> -			basic_regex_quote_buf(&sb, needle);
> -			regcomp_or_die(&regex, sb.buf, cflags);
> -			strbuf_release(&sb);
> -			regexp =3D &regex;
> -		} else {
> -			kws =3D kwsalloc(o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE
> -				       ? tolower_trans_tbl : NULL);
> -			kwsincr(kws, needle, strlen(needle));
> -			kwsprep(kws);
> -		}
> +			opt.ignore_case =3D 1;
> +		if (opts & DIFF_PICKAXE_KIND_S &&
> +		    !(opts & DIFF_PICKAXE_REGEX))
> +			opt.fixed =3D 1;
> +
> +		append_grep_pattern(&opt, needle, "diffcore-pickaxe", 0, GREP_PATTERN);
> +		compile_grep_patterns(&opt);
>  	}
>=20=20
> -	pickaxe(&diff_queued_diff, o, regexp, kws,
> +	pickaxe(&diff_queued_diff, o, &opt,
>  		(opts & DIFF_PICKAXE_KIND_G) ? diff_grep : has_changes);
>=20=20
> -	if (regexp)
> -		regfree(regexp);
> -	if (kws)
> -		kwsfree(kws);
> +	if (opts & ~DIFF_PICKAXE_KIND_OBJFIND)
> +		free_grep_patterns(&opt);
> +
>  	return;
>  }


There's a bug here where now different things are dispatched to either
the -S or -G codepath wrongly, I've fixed it in my local version.

Anyway, it's interesting between this and the -U0 change that we have
little/no coverage for some/all of this. I'm trying to address that in
preceding patches in v2.
