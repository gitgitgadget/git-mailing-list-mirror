Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3D3D1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 01:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403759AbfIWBmg (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Sep 2019 21:42:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58814 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391378AbfIWBmg (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Sep 2019 21:42:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A161B60459;
        Mon, 23 Sep 2019 01:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1569202955;
        bh=PULLl4E1A18cbZgFrDtma4o7C3gC3PtljAg6zEkZeG0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cEGxVLn52esfY6GM9aAinTZsPH5OX1+3Jis/Aj8z3Ls4iYDFJmlgsCzyp4QIZrixU
         S8tf+snZPXt5Pd2g+56TwgfDP8NscixmfCXpzxFlEiHi/h9K2FVrqBUJkS/jYVtIDD
         bUMdAx7ET1szf9s18MW5vR74Rue+14OjPTfLqsAucBNsOyMf5ZXneFqqBFx3CD5WgX
         qti0zeeQDXIjlYY14YBlXiBRuOXadfNqCBjq+G5Hdao370SXzTOAqw1nOUP7xuhCmy
         KrMSPsy1z/VQli/X4iHfP/wBSxon0S1S/p4NHsOqL4FrTWlOJ7wBlbnMJNFkFcPRVo
         tDKDhJrftBIqx5YhKW5WHM+cXOG54D+XS3Umnszgs6qTv2tjj/cl5+TsrlqjX+sHqx
         JBxMea/Jm3pwwT6xyNzABro0QIaJqm9+sbcaqQysaxqapbmkQyrFIKoFCoNTmiJ49U
         9W/ED/h7z+IvE+RLF4kjEbhiG10C1aMPmSHdFUkc/qp7qX5L73g
Date:   Mon, 23 Sep 2019 01:42:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] name-rev: avoid cutoff timestamp underflow
Message-ID: <20190923012838.3hzai6ho7vjjhkpb@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190922180143.25026-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fjwzwdu27pubaxem"
Content-Disposition: inline
In-Reply-To: <20190922180143.25026-1-szeder.dev@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-rc5-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fjwzwdu27pubaxem
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-22 at 18:01:43, SZEDER G=C3=A1bor wrote:
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index c785fe16ba..a4d8d312ab 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -9,7 +9,11 @@
>  #include "sha1-lookup.h"
>  #include "commit-slab.h"
> =20
> -#define CUTOFF_DATE_SLOP 86400 /* one day */
> +/*
> + * One day.  See the 'name a rev close to epoch' test in t6120 when

This piece of code says "close to"=E2=80=A6

> +test_expect_success 'name-rev a rev shortly after epoch' '

=E2=80=A6but this says "shortly after."

Overall, I think the idea is definitely sane, though.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--fjwzwdu27pubaxem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2IIwYACgkQv1NdgR9S
9ovQ4xAAmRNGScaNXJpa8F+/yaVrIEUVxPNcPtAn3GxK0dJLzGZA2rZNQMZNoZpw
babbSLEHd5FwC8VSNlSyfNLRzXpAupZrWpYQOIXFc1Z1Ki93pJAmpSWHhSB6zQK0
E8x6MK8rY49NWkVGWE9igMUQZ0yPg5dZEyiKb6IZ39kKdyAs4zzL6mWULMaMLMmb
NPDTpQdIUNLo6GNpcFQp4WA7rlsaWjEOJ1hpVIt0PTH29PzvekBypnigV710uBLo
dfI5l+0oq9LXY5cBDJ5hg4SMW9y2ZOJW7lZzfUZZPyOOlDbCTaPXtAhTzeelAN7Y
1pIF2JP7ZCIgWIc22qCzg+tyzhSEy2MCoaT10DBh8wg8HXvI8QSjuUycxVTXoroP
XK+NsH5MWO1mLrl0Z0Q5p6aap2660RhVdcDREQNsZ/UkkHm48eo80AzRfsAcW7kS
Pk5lmyc61ccjxP8V+XT3NGO95YfgwqXHUbsOwK/UhUBVaE2nGvG2iekvGvPhWtBu
aI6SI+X/rV/7yN5XofxtUqZEEkKMmEzEP1B5tCS6PPfHa6DjVAENduZKPuP9ZUDv
C4Tud8L1ToZkAHGwEUclGqjS+QLijJ9x3q0X/vU9QG6JykXVCi+KM63gg7Fc8olk
4QO5ym4Fp7XT07bYSrZkzigVC7OHH7KJaMi3SdruPCKUnnwdJnk=
=6IXm
-----END PGP SIGNATURE-----

--fjwzwdu27pubaxem--
