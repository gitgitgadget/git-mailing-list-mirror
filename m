Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD18BC433EF
	for <git@archiver.kernel.org>; Sun, 19 Dec 2021 19:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbhLSTjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Dec 2021 14:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbhLSTjF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Dec 2021 14:39:05 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53993C061574
        for <git@vger.kernel.org>; Sun, 19 Dec 2021 11:39:04 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j6so9403636edw.12
        for <git@vger.kernel.org>; Sun, 19 Dec 2021 11:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Fd0s/nFKmkTqRlUZMYo1Jc6V7cIFWtItk1E25Pt6kgc=;
        b=lCBx5Qqs2XjLjrW0Ws4aCQuHNXZ6h83qWlPfqhiuSDOP4eSh+j3fGZMxvDYj2g7bQC
         NNIro9aPL5NhsSHFZIR+ibkgkv17tvs/iYyDIdj7BDqTCIWDzSr/IMKrXovfMNYsKw8j
         ZIhwyCz8H+fAuosIAN/8bIhMrLAFeNKG5sFybsQMkfWgy9bZK/nbIzLEKGYjpOAXYP2+
         RtGxP/Nxg0/KwzQJzwdssIjXnz1oG6kDqU8s/Z6W5BQ3TY5p985w20fFtRoM5lV2Ouqb
         THYOxmMcZTN+g0IT0P+pgmBYyoCFQsevs5WMmbKDPKuQobr4+XNSzT05H+/ig692BNLJ
         1mCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Fd0s/nFKmkTqRlUZMYo1Jc6V7cIFWtItk1E25Pt6kgc=;
        b=iXx9TDYoJ8iTh8g8LMKrxn+wtSm9KYioHSRbAJ7BMkFES2OjhRCB81QY1/CUW1t2pi
         uHyG4PH0wJDJBzZoJUIn5aOipcGTWtb1OlEZauTAXS7djAsCDdWac4XmwMHsYfiFgja4
         lJCyCjgVKsxbixgwAVbgukTcseENbjYTjqFfPf44UNtU8GGx3TdF3MK68MC5Z1vL/MU3
         EM80mCK7ihFCKI6lzp+Kpa/IqWk7rp5BIJSUtc5Mof3TXZ2n2pnZrHJFqYE4WiuXJVyh
         Qmag2u1Em/1d6t7sVx3lTjiLlsn9KKjP8V0tDN76NmEdHUOY1d4Xhgh6QjkdCPS/pnhr
         pNfg==
X-Gm-Message-State: AOAM531HhodQBTxTl+iESS9/TVyqED4O/FORjBgEY73CelEwWaYoFWuR
        oRvyLvPNGvYy+9tFtGJJtDo=
X-Google-Smtp-Source: ABdhPJwOmpP4NdwtM/FQeCJ6GEQFJGHxTOl3Q+FxPvM2iNl6Ert17P+E3/xlv066oQSM5Is8ka4/YA==
X-Received: by 2002:aa7:c550:: with SMTP id s16mr12728240edr.320.1639942742753;
        Sun, 19 Dec 2021 11:39:02 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hr36sm266524ejc.28.2021.12.19.11.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 11:39:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mz21N-000KNc-E1;
        Sun, 19 Dec 2021 20:39:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/2] grep/pcre2: factor out literal variable
Date:   Sun, 19 Dec 2021 20:37:37 +0100
References: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
 <ba503995-866d-fc80-4e38-b4dfd0e5c5bc@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <ba503995-866d-fc80-4e38-b4dfd0e5c5bc@web.de>
Message-ID: <211219.86o85cwfje.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 18 2021, Ren=C3=A9 Scharfe wrote:

> Patterns that contain no wildcards and don't have to be case-folded are
> literal.  Give this condition a name to increase the readability of the
> boolean expression for enabling the option PCRE2_UTF.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  grep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 5badb6d851..2b6ac3205d 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -362,6 +362,7 @@ static void compile_pcre2_pattern(struct grep_pat *p,=
 const struct grep_opt *opt
>  	int jitret;
>  	int patinforet;
>  	size_t jitsizearg;
> +	int literal =3D !opt->ignore_case && (p->fixed || p->is_fixed);
>
>  	/*
>  	 * Call pcre2_general_context_create() before calling any
> @@ -382,8 +383,7 @@ static void compile_pcre2_pattern(struct grep_pat *p,=
 const struct grep_opt *opt
>  		}
>  		options |=3D PCRE2_CASELESS;
>  	}
> -	if (!opt->ignore_locale && is_utf8_locale() &&
> -	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
> +	if (!opt->ignore_locale && is_utf8_locale() && !literal)
>  		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>
>  #ifdef GIT_PCRE2_VERSION_10_36_OR_HIGHER

I think for this and 1/2 it would be really nice to pick up a version of
Hamza's CI changes:
https://lore.kernel.org/git/20211118084143.279174-2-someguy@effective-light=
.com/

Aside: Not needed for this change, but I wonder if we could benefit minutely
from:

    #ifdef PCRE2_LITERAL
    options |=3D PCRE2_LITERAL;
    #endif

It'll save PCRE2 the small effort of finding that we've got no metacharacte=
rs.
