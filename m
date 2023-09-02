Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254D8CA0FFC
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 06:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjIBGUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 02:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjIBGUm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 02:20:42 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138A710FA
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 23:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1693635629; x=1694240429; i=l.s.r@web.de;
 bh=JIIyufxDmJafVq2fHd64LGPTmDII4/k5zBms3N/Gh+E=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=X/0MU1n/z860lcH20j9p9kh3Ge/WBZ1VUhtl0W2bV830lz/jTnFZh11GcUwRkwbZbtxmY6H
 wn5F+ws1UHa746o4C7TuCKkXiZ2z28xKlK2KC2Kr07J0U8q8zGJ2/CbO/3Wirvu6+r7BjppoC
 utdboUEto50zgLKC4gCoXpsy3HwmKDQxcjPrjRQgjmiIJSUciGle6sZvXjColiws9/PL0N1z+
 n1GH51vtyv3rhphD6+goNNId1RxFoukVRccte9Z8tjQBJ8ftPt5OAQMge4xWufs0G/LztVwnr
 JqUWtxWUOfi+JYixk1KBEkta2haH1JdoxEeq/MBSR/imNfRcqjzQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.152.246]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N79RG-1pbRQn3Pe0-017Tnd; Sat, 02
 Sep 2023 08:20:29 +0200
Message-ID: <75100a68-78d1-b22c-0497-36548c518b7b@web.de>
Date:   Sat, 2 Sep 2023 08:20:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 02/10] merge: simplify parsing of "-n" option
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20230831211637.GA949188@coredump.intra.peff.net>
 <20230831211716.GB949469@coredump.intra.peff.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230831211716.GB949469@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PvD+iP2VRYZNGD/8lmkLrEsHxV326UaUaZBpPuL+NnLKL/an0xu
 LUEhKEEd9q9FR6tDInsIEu3Cw5mK4pYsCruH9UBWLx8Y8O70a2dCRnkRqjQ9kmGjIX0kFjH
 /lNf0ceKGTVuRLf3HVXhLjl/vbXdRP7gbjTei0yOtpbwoTzA6NDOzB4eXqa0UIfisPfp1un
 VT0PzFaJVLFrErjDpAILg==
UI-OutboundReport: notjunk:1;M01:P0:L3fci6iYnyU=;SB7G66lVqXldy3GbmClOYVXGvM9
 qJSg8N0Fr30s14XNrgv85kOp8eWwup7gmWsrR84vrJLaTuRLIkzv/2vsTzyQj3kxMcmJgOoLQ
 28M3tLn0OzgCmWNuSgXB/nip0LXWifPG54qPU5ZZ5kTtN+2avXKcFQ1yDNtF+JkKflb5cazM4
 Y7KWRNrSVMEG7BnbxCcckPVo3ucYoyxAqbFZkTLXP15OA9t+kRPV96A2tos9F32alz1gqjIbx
 wRzNwqlaFSV3VJTAgGXu9am6ZshJTeSY4LfXHLtAmh2bNtBiP5o98kBLw4aTH55i0DycF5AqQ
 ldNkZzMV6HvORduYJ5bSVoBGOJMEOrMIVSdTEj2FfEcm9kIAddBGoamjrUuHKqoJwHbIDHeiN
 XARHtUm8gmHo+usPyFOHPTf7LptBNn0HMVJAsNcvh2vlJqG0Tj3KATnMTSRdSisRH5zctVeEY
 A+sxjWqNcJkWzZITlrBDke4E5I0tehxFbntgI1jeNqZkLuzEpEgRuScfw3o4ZLv+9B5uXuYbL
 TAbXh2xOL7sG+KeILy7rwafp095b/6EPXLX7yW40d2lMsnPKlsNLcvXRfQTnek14AAxV2+1PY
 uE0zl1Ia4YLPvFzqEodTmcXZIL4qxVswcbyee3kWY+zoHYfHaSUbCUeS5JAsQ2WtsFGCOzLFQ
 1xN+o2rTPonIMKzmjjcVgezjcdFvOSDO3itHtl8942ElbImDdaEVeEnzlkmRCNyt3Vb3WgKMr
 NLdV8ShleF372uHLXSI/o3E+pAGpCipSZFI57sUhtX4uXGVdHcJ9XiigEF2dXRKnuYp5x1lSB
 ji/9rGayIqmp2eE4f3Tu/yX2ALsGb5m0tI1yebp87i7brXIbIEsesQduED8l1xr1Q6wAPgwDH
 X3p6j25mJMZOe9ATc4wDpBuw021Vr1gmzgRs0BWZ1FMW9ZTW874wHR2S5lZhgZFwWnHrXDTR4
 lBKmi+YdOnH5V2erIxcDq1xWvNQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.08.23 um 23:17 schrieb Jeff King:
> The "-n" option is implemented by an option callback, as it is really a
> "reverse bool". If given, it sets show_diffstat to 0. In theory, when
> negated, it would set the same flag to 1. But it's not possible to
> trigger that, since short options cannot be negated.
>
> So in practice this is really just a SET_INT to 0. Let's use that
> instead, which shortens the code.
>
> Note that negation here would do the wrong thing (as with any SET_INT
> with a value of "0"). We could specify PARSE_OPT_NONEG to future-proof
> ourselves against somebody adding a long option name (which would make
> it possible to negate). But there's not much point:
>
>   1. Nobody is going to do that, because the negated form already
>      exists, and is called "--stat" (which is defined separately so that
>      "--no-stat" works).
>
>   2. If they did, the BUG() check added by 3284b93862 (parse-options:
>      disallow negating OPTION_SET_INT 0, 2023-08-08) will catch it (and
>      that check is smart enough to realize that our short-only option is
>      OK).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/merge.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 53e9fe70d9..21363b7985 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -241,18 +241,9 @@ static int option_parse_strategy(const struct optio=
n *opt,
>  	return 0;
>  }
>
> -static int option_parse_n(const struct option *opt,
> -			  const char *arg, int unset)
> -{
> -	BUG_ON_OPT_ARG(arg);
> -	show_diffstat =3D unset;
> -	return 0;
> -}

Great -- the less custom callbacks, the better.

> -
>  static struct option builtin_merge_options[] =3D {
> -	OPT_CALLBACK_F('n', NULL, NULL, NULL,
> -		N_("do not show a diffstat at the end of the merge"),
> -		PARSE_OPT_NOARG, option_parse_n),
> +	OPT_SET_INT('n', NULL, &show_diffstat,
> +		N_("do not show a diffstat at the end of the merge"), 0),
>  	OPT_BOOL(0, "stat", &show_diffstat,
>  		N_("show a diffstat at the end of the merge")),

Makes it easier to see that we can replace the two complementary
definitions with a single one:

	OPT_NEGBIT('n', "no-stat",
		N_("do not show a diffstat at the end of the merge"), 1),

Which is a separate topic, of course.  And if we did that, however, ...

>  	OPT_BOOL(0, "summary", &show_diffstat, N_("(synonym to --stat)")),

... we wouldn't be able to use OPT_ALIAS here anymore (which we arguably
should) because it doesn't allow referencing the negated (or
"positivated") form -- but that is yet another separate topic.

Ren=C3=A9
