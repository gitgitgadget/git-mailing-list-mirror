Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A252C4167B
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 20:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiL1Ubb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 15:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiL1Ub3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 15:31:29 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5EDBF7F
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 12:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672259482; bh=L8jT4NWkmxEsQ+3v8TfP7a7dVQjGyUzJEm0xHHcmDDA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Tk8MF0jrE/3N9lh4u77njyqO0/bNzJljMa61px5mbEEwNBi6OHezIAOgmTSUhnzop
         xwXwmVvzwVla1Ea1WmDfydGy8L/CWufQ+fkh64aKY10MvEt9vr3xN8ERoxKFrDyTg1
         Rc97t3cDycM79lPPcqS+DQrjZtCqBAStUEYA9jaS3H+3GWNhtJWc3lEyGSgF6+IEtJ
         Y7hFL+AkpHpVcsTdWwhmg6PfKCsrq4v8yugO9mNFdlogOr3aqH+Fmya3c8XayLSqNP
         Gl0h6t7c+0spit1BsrszaE5AIhdp8xnnmrKCjS7DTXF4jkTiRhTIdPa391Z/ipek3Z
         VAC4wGUhNr9dw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MidHZ-1ofQar0hOR-00fMXU; Wed, 28
 Dec 2022 21:31:22 +0100
Message-ID: <dbc7c55d-d546-d004-ef44-62bd7349d5c9@web.de>
Date:   Wed, 28 Dec 2022 21:31:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 09/20] name-rev: don't xstrdup() an already dup'd string
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
 <patch-09.20-77fcdeb9284-20221228T175512Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-09.20-77fcdeb9284-20221228T175512Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:as0PNyeTY26G/9jldrKMs9IDb/pWSn1DzirfGHvGkyS7OgpVKhx
 A9SjRSqALjmT4y/an4i7nq5fcOwOwPVHj6vueRVr2AXm9eisUxE09v31eMt+nfJKgjorBIO
 D1TrzRDMoav0dpueyNpwiPa1vLhDEenz5zr+xzamNV+Z443TvIOIqzEFJJh9SF7rbgJVod3
 lbRBx96fYCvgU6p9fO0kQ==
UI-OutboundReport: notjunk:1;M01:P0:NV7a/9bKHkQ=;/i8YKGNwBwC7Zu+aLeaD4vTg2fD
 c6jYeSRBeC7lDEnQR4kvnXKRUjd2gnLIlxPS8FMwysZQG2J7eMZ3yLHPA/ViE6lycsME/9GU5
 cTKHqzbTJCejH0l0aLUbLGcFQ114ar/zj0fmNqx0zWfQFcZET4Z3t7eEk3eKgn9/lLVVRZJkb
 gGL4D5PtBbVH1RAh8phlmaeD4ot8Pkabr1GBIqpphGvEZe2kRXsLCe5YZtBJlgZAH2gGLxyWD
 PrcmKF+M/Xjztqoh32H8xFPuMMlziV25aanyOPecmmh/YNt+UmtXEXZZxCLM4IGo5YU0NsJk9
 7DjV3cCcOIoSVormUlb7vXE8A9bTpJqu8dNjt7sqDjW6NMNYQIbcqqxc7BWgG5xEmD3zpJ3jW
 2keWZCMdaaZfRWTGrvAa0qhbjT37nqBHY8NadB/7R69ruEmT4gV9vf2BusWR7xfFTDs7j2Av4
 4YpQweZjsQbomhmduvhieNdOzbFDUzHGLad3BoVyE7R131j/EM0BAn+YY3jOFr3m9w6fCjcD/
 jsllsXR0NKhH9gkVU9LwN3r/FtkVJVq3GdCYJNHcHTwqTyT+sItlE/tJryH1/b0NmdRrXk2Yg
 zMXFnaJCBjf15cSn9zrt0nln4OM0ODRn9JdLIvHwjQrqjS8ebYqyWIxfJNlVed59UMUZdN8Uo
 Yyc4CYLR2v/BSM+15dBhiOTP97LhhJNmlX53josyA7eb0rLoi3nWMLSfo134p2Rrx0ExTAVE+
 XSJijLzbh1op0mzGWeqfShYTnB/kyn/Pzc/WMVH1UAYgRYakPLY2Q5g4Nys16WDimLP7rRtFc
 bKGt6dlVdXuv9va+3S4iC0FuISwZee0ed3fughGfmDxHOlXylDln9ClwBrrQeQY+tLpYOc3wl
 pHjohOT21k07NIq0HXZJaADy29dExzzs/LHD8aQuNVQWCgwJilN5Ir8va2c5c5XPpFxm1Bs15
 HZbVINz8cuF+dO90RmKtTQbP+kw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.22 um 19:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> When "add_to_tip_table()" is called with a non-zero
> "shorten_unambiguous" we always return an xstrdup()'d string, which
> we'd then xstrdup() again, leaking memory. See [1] and [2] for how
> this leak came about.
>
> 1. 98c5c4ad015 (name-rev: allow to specify a subpath for --refs
>    option, 2013-06-18)
> 2. b23e0b9353e (name-rev: allow converting the exact object name at
>    the tip of a ref, 2013-07-07)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/name-rev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 15535e914a6..24f4438eb01 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -313,7 +313,8 @@ static void add_to_tip_table(const struct object_id =
*oid, const char *refname,
>
>  	ALLOC_GROW(tip_table.table, tip_table.nr + 1, tip_table.alloc);
>  	oidcpy(&tip_table.table[tip_table.nr].oid, oid);
> -	tip_table.table[tip_table.nr].refname =3D xstrdup(refname);
> +	tip_table.table[tip_table.nr].refname =3D shorten_unambiguous ? refnam=
e :
> +		xstrdup(refname);

Hmm, this works based on knowledge about the inner workings of
name_ref_abbrev(), which provides the refname.  Could be cleaned up by
inlining that short function, or by moving the xstrdup() call there.

>  	tip_table.table[tip_table.nr].commit =3D commit;
>  	tip_table.table[tip_table.nr].taggerdate =3D taggerdate;
>  	tip_table.table[tip_table.nr].from_tag =3D from_tag;
