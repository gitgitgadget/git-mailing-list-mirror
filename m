Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60A0C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 02:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 748BB6146D
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 02:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhA2CNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 21:13:14 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34590 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229819AbhA2CNL (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 28 Jan 2021 21:13:11 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BCC3960794;
        Fri, 29 Jan 2021 02:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1611886320;
        bh=BcPZFtEs9PcrYvIxKxyZAijXaJZFHk1UswW2nEF17AM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=G2zO09cEJtnbySfsTxSQ24DIpHEBpbJxOWIT0lQj72e9KpQNNRmIkfZaQPtTF/gI2
         tU/bSTPXglvH5zZvb1fcqzUzvvQCSMVRy6OTzJeicEZoI2OL8aompbRaoCGWp+/Oql
         DlHYvq2JDCcf99thRcAeVssAFlvYpMzSELchT3omUMAe0fcsysZShWFz4EPAxXY5bk
         0lOcg0+xdpXcqu5JB58Ic1J2m72xM3ySJWlhbeTnsH/b8iQRyK2vk2nGUycELiQaMS
         Y1pSj1mLubOs1e47F5h+Gp/oM/g7o5JiKhBVkKlWeUcOtn5pqplxTSzgWiBaqc/TFj
         lRUNedZFkR1qLtHT4kPdfcCDKtaRAirRhmGx1uQlNNRGFN9g0EjNR6MOo8DaQnP89B
         rbWOThSVrG0/pO0V4WYGYByEDl0r+leCLc5H3ud+ElGAm7jKODBy4eWGDTWIalrw7z
         1j1PrfMD/YAcCYotYuEAdgSa3cssGYmQo9o0Sg/iph7xakU34FQ
Date:   Fri, 29 Jan 2021 02:11:54 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util: always enable variadic macros
Message-ID: <YBNu6mqzfhZFpHR/@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <YBJLgY+CWtS9TeVb@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TaGd0UuKhggwCCXH"
Content-Disposition: inline
In-Reply-To: <YBJLgY+CWtS9TeVb@coredump.intra.peff.net>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TaGd0UuKhggwCCXH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-28 at 05:28:33, Jeff King wrote:
> We allow variadic macros in the code base, but only if there is fallback
> code for platforms that lack it. This leads to some annoyances:
>=20
>   - the code is more complicated because of the fallbacks (e.g.,
>     trace_printf(), etc, is implemented twice with a set of parallel
>     wrappers).
>=20
>   - some constructs are just impossible and we've had to live without
>     them (e.g., a cross between FLEX_ALLOC and xstrfmt)
>=20
> Since this feature is present in C99, we may be able to start counting
> on it being available everywhere. Let's start with a weather balloon
> patch to find out.
>=20
> This patch makes the absolute minimal change by always setting
> HAVE_VARIADIC_MACROS. If somebody runs into a platform where it's a
> problem, they can undo it by commenting out the define. Likewise, if we
> have to revert this, it would be quite unlikely to cause conflicts.
>=20
> Once we feel comfortable that this is the right direction, then we can
> start ripping out all the spots that actually look at the flag, and
> removing the dead code.
>=20
> Signed-off-by: Jeff King <peff@peff.net>

I'm in favor of this change.  In fact, as I've previously mentioned, I'm
in favor of just requiring C99 support across the board.  It has been
almost 22 years since that standard came out, after all.

Apparently, even Visual Studio supports C11 and C17 now[0], so there's
really no reason not to switch.

[0] https://docs.microsoft.com/en-us/cpp/overview/install-c17-support?view=
=3Dmsvc-160
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--TaGd0UuKhggwCCXH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYBNu6QAKCRB8DEliiIei
gYeZAP94jI3N6ysKvWoiV3jnMzIJ2ig1Ne3ftp+pmi6N2A8yeAD+JlZycgIsd1ZS
AmdAcRXBiXKxbiNn2ejmQGsigcENaAg=
=mpka
-----END PGP SIGNATURE-----

--TaGd0UuKhggwCCXH--
