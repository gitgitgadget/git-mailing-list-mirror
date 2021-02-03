Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72685C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 14:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 152CB64F6C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 14:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhBCO1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 09:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbhBCO1g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 09:27:36 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BCFC0613D6
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 06:26:56 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id w2so1708450ejk.13
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 06:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hcAt/F1YC5WM6OAs2awTAsv2kBouXDQp39dthhWgMRY=;
        b=O08egbqyvx4YxCvv+4hIO7RWm2BW4X4FQD16JGv2MjDZuebIoUdGhcccyas7eTlJ9s
         AYNbbN4kneLz5UwZg5+dxWo15lhPhoyA+K1QjXyKsvRpDHLwrwn0CI88RHDXhQ3S9Dj7
         GVgelUe3QyloMe+JkLNprE/bIe8kQ8az5QJB8IqZmAqwHUbaFrt0C81jzHsoVvHlNypf
         wXFUy9FWeQA4B8YCyfVuQWWArE5EEaU78+n3fzYSqCi32hVwQzy1fxRyIf88nU87Ah7G
         Kp/xmh8wsrTqjojul56MafQ83FtPDl/9C0RSFsGPhQCGft7G2NURxRZPSCyuPSxvGE7B
         5oTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=hcAt/F1YC5WM6OAs2awTAsv2kBouXDQp39dthhWgMRY=;
        b=X8IG8DJAV6pha89U8jkncyaLKCT+h8PMyo1892mUj6tv1V6NnGbw36jm88PgAzICE9
         UOO6U3jODzWeSB1XwL40QRhVM4U6rhqQFCerBLPsCSbAP9SKY18oS5WPnBMDQPqzJPZt
         ecXm6dzzURwcUoA31GnB0/ACnZOKtLTsy622SEif3A8ssu2Y9rDc88nV6UbEKnEScghj
         uWUhz9+0u/foa/+fv4cYbEc3nTwx6MTflmzyHb6WgLdywQ7nK+x/z2YmXloL1iuw6E/R
         A2k9bdcWX3fkrnBsboEaL4TRk1sZ1X+CiCXoGObIaotuKQeQuiEyl5uu7xuT1rSLnEmI
         ODEw==
X-Gm-Message-State: AOAM530gq5eg9tMjBp4/6JsKJNldd+wgtJRsjlSPXcQbs0RD6uH1n/LG
        vp06SIpne3W5egVVETsVVNqspNu5TKviPQ==
X-Google-Smtp-Source: ABdhPJzk5vBMLSgPMLZnDsLjPhPBfrqUAe3pjJY1PdiJfcfVWHgDbD3o/G47KpH1EHJoCv736K7kVA==
X-Received: by 2002:a17:907:20d6:: with SMTP id qq22mr3417937ejb.517.1612362414344;
        Wed, 03 Feb 2021 06:26:54 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id m10sm941721edi.54.2021.02.03.06.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:26:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?B?= =?utf-8?Q?el=C3=B3n?= 
        <carenas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 19/25] pickaxe -G: set -U0 for diff generation
References: <20210203032811.14979-1-avarab@gmail.com>
 <20210203032811.14979-20-avarab@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210203032811.14979-20-avarab@gmail.com>
Date:   Wed, 03 Feb 2021 15:26:52 +0100
Message-ID: <874kitdy6r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 03 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Set the equivalent of -U0 when generating diffs for "git log -G". As
> seen in diffgrep_consume() we ignore any lines that aren't the "+" and
> "-" lines, so the rest of the output wasn't being used.
>
> It turns out that we spent quite a bit of CPU just on this[1]:
>
>     Test                                             HEAD~             HE=
AD
>     ---------------------------------------------------------------------=
--------------------
>     4209.2: git log -G'a' <limit-rev>..              0.60(0.54+0.06)   0.=
52(0.46+0.05) -13.3%
>     4209.8: git log -G'uncommon' <limit-rev>..       0.61(0.54+0.07)   0.=
53(0.47+0.06) -13.1%
>     4209.14: git log -G'[=C3=BE=C3=A6=C3=B6]' <limit-rev>..         0.60(=
0.55+0.04)   0.56(0.48+0.04) -6.7%
>     4209.21: git log -i -G'a' <limit-rev>..          0.63(0.56+0.03)   0.=
54(0.48+0.05) -14.3%
>     4209.27: git log -i -G'uncommon' <limit-rev>..   0.61(0.55+0.05)   0.=
53(0.47+0.06) -13.1%
>     4209.33: git log -i -G'[=C3=BE=C3=A6=C3=B6]' <limit-rev>..      0.61(=
0.53+0.07)   0.53(0.47+0.05) -13.1%
>
> I also experimented with setting diff.interHunkContext to 10, 100
> etc. As noted above it's useless for -G to have non-"+" and non-"-"
> lines for the matching itself, but there's going to be some sweet spot
> where if we can be handed bigger hunks at a time our matching might be
> faster.
>
> But alas, the results of that were:
>
>     Test                                             HEAD~2            HE=
AD~                    HEAD
>     ---------------------------------------------------------------------=
---------------------------------------------
>     4209.2: git log -G'a' <limit-rev>..              0.61(0.53+0.07)   0.=
51(0.46+0.05) -16.4%   0.51(0.46+0.05) -16.4%
>     4209.8: git log -G'uncommon' <limit-rev>..       0.66(0.55+0.05)   0.=
53(0.48+0.04) -19.7%   0.52(0.49+0.03) -21.2%
>     4209.14: git log -G'[=C3=BE=C3=A6=C3=B6]' <limit-rev>..         0.63(=
0.54+0.06)   0.51(0.44+0.07) -19.0%   0.52(0.46+0.06) -17.5%
>     4209.21: git log -i -G'a' <limit-rev>..          0.62(0.54+0.07)   0.=
51(0.46+0.04) -17.7%   0.53(0.45+0.07) -14.5%
>     4209.27: git log -i -G'uncommon' <limit-rev>..   0.62(0.56+0.06)   0.=
53(0.48+0.05) -14.5%   0.53(0.46+0.07) -14.5%
>     4209.33: git log -i -G'[=C3=BE=C3=A6=C3=B6]' <limit-rev>..      0.63(=
0.57+0.03)   0.58(0.46+0.06) -7.9%    0.53(0.46+0.06) -15.9%
>
> I.e. maybe it's faster in some cases, but probably slower in general.
>
> Those results are going to be crappy because we're matching a line at
> a time, as opposed to some version of /m matching across the whole
> diff (if possible). So that approach might be worth revisiting in the
> future.
>
> 1. GIT_SKIP_TESTS=3D"p4209.[1379] p4209.15 p4209.2[028] p4209.34" GIT_PER=
F_EXTRA=3D GIT_PERF_REPO=3D~/g/git/ GIT_PERF_REPEAT_COUNT=3D5 GIT_PERF_MAKE=
_OPTS=3D'-j8 USE_LIBPCRE=3DY CFLAGS=3D-O3 LIBPCREDIR=3D/home/avar/g/pcre2/i=
nst' ./run HEAD~ HEAD -- p4209-pickaxe.sh
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  diffcore-pickaxe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index cb865c8b29..5161c81057 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -60,7 +60,7 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
>  	memset(&xecfg, 0, sizeof(xecfg));
>  	ecbdata.regexp =3D regexp;
>  	ecbdata.hit =3D 0;
> -	xecfg.ctxlen =3D o->context;
> +	xecfg.ctxlen =3D 0;
>  	xecfg.interhunkctxlen =3D o->interhunkcontext;
>  	if (xdi_diff_outf(one, two, discard_hunk_line, diffgrep_consume,
>  			  &ecbdata, &xpp, &xecfg))

I since discovered Junio's f01cae918f (diff: teach --stat/--numstat to
honor -U$num, 2011-09-22) (as an aside we have no test for that
behavior).

I haven't looked carefully, but I don't think we'll have the same issue
here, as pickaxe currently doesn't care about whether something is on
the + or - line, when briefly looking at the diffstat edge cases it
seems that's what differs based on -U<n> for the diffstat.
