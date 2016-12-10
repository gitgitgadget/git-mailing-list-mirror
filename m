Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C0661FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 15:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbcLJPXq (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 10:23:46 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:32840 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752429AbcLJPXp (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Dec 2016 10:23:45 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E3F20282B7;
        Sat, 10 Dec 2016 15:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1481383422;
        bh=snPSEyGZsthx4JREDDXwRRRgL+l2K6K9tt1TXr9KXqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zmypWmaWK5sskqJrFrOLKSt5cGEmJ+S6amzVqsq946mF6BAiDmca5yO7J0YAz2X7W
         tuTcgzq/QFW48+KF5f7OKg6hl2+wjpmrOuSZcwmm+aqhydUi0LloSnuBLd3NZONeFE
         4dSyZQ2FE6XL6N9p339cMnLmH+vTl4hVDjc5ELYNi0Ckij00I/DTeXvGqqVbAZdXag
         RgNiQuce2/PBtCbkvCdHMPBbKwXSidW495+zAg8cZZ2Eb3QVIs/JquTbASGLCWBikU
         iDPaBgqSSXnBtir/oqxjZwpLDVpxI2BFKTjYtGep/8+u5xtgjs6anChCL5qb8665ob
         R8mKKTGrMimwZydrlrDbOAVfURY4dd8Z+hcN8VtOsyQR2tOemmhlflg7+swm2IkUyM
         lMngEx2zQ/04MGRKxw9FluEr3QnL5f2Xxo4srlCcGtm7G/qKQvVqnmABQjWIN3XCOH
         L3DiWVOjlrkGUlyJfUc2nlIzhwi9BXMeLK0yJliTvol0v/jIA8N
Date:   Sat, 10 Dec 2016 15:23:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [REGRESSION 2.10.2] problematic "empty auth" changes
Message-ID: <20161210152338.vzd4w3pr7wy6p4ki@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
References: <alpine.DEB.2.20.1612081538260.23160@virtualbox>
 <1481231552.20894.20.camel@frank>
 <20161209221854.re6qf3e5225wxvge@genre.crustytoothpaste.net>
 <alpine.DEB.2.20.1612101551100.23160@virtualbox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nqbnlb5v7l7njgei"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1612101551100.23160@virtualbox>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nqbnlb5v7l7njgei
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 10, 2016 at 03:52:39PM +0100, Johannes Schindelin wrote:
> One of my colleagues offered a legitimate concern: it potentially adds
> another round-trip.
>=20
> Do you happen to know whether regular HTTPS negotiation will have an extra
> round-trip if Kerberos is attempted, but we have to fall back to
> interactively prompt for (or use stored) credentials?

With Kerberos (using tickets), you have 7 request/response pairs, and an
additional round trip for the 100 Continue if your push is larger than
http.postBuffer.  You only have 6 for Basic using Kerberos.

However, libcurl is generally going to be able to figure out whether
your Kerberos credentials can be used, so when it falls back to Basic,
it does so because it knows you have nothing to use with Negotiate (e.g.
you have no ticket), and therefore it doesn't even try.  I suppose if I
tried to push to a server that offered Negotiate and Basic, but didn't
accept my Kerberos credentials, it might fall back in such a way,
though.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--nqbnlb5v7l7njgei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.16 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlhMHfoACgkQv1NdgR9S
9ou5Ag/+J17tuOFGW9/Yq7WXr8hFpc94osdXHILC/tJkeuaKdhsnts6gWmiDaKfG
tLjWO7VAXF5g6ocWUiP5HjK3ze6uUnWP5e+JrBf/h0QAW0IsG9apjxI/nKk60l18
rWgfX9q4WXzgxofuOaUawTb2aN/JY0M82Ri1iBUViVTWcwKK39CS+tNspP8xN0tJ
5D7mqKLLVnd1h3W0E1EAphjnhKUcqH0uikiWO3z6iiLPFr++vtfBHXPe2BmhkNe+
jp9wIhK3N0alvIowqDuDnnNHJSX60VmZ40cjcoeL2iI4ypxEaZ8ybXq5VDkEpJLW
wE6k4+7ElhUpflkUSh4KXQLrj6xLx6g4wTZ6FzRNO8WI1t+cFAGuSsR7PQx9Q9CL
EuyXnB0KOKYWNQ27pRzqBk1N8mpWHws1a7qp17wU1b0K6Bm9uEwqWJU9zi1mQDow
nF7o2WkCD/vf40r22hyr9m84CJSQwUq2hFIIhzHOs+uTe0KWH3qDm1Fl5pjwGO8F
xUkDIGlfbl1tmO5aZes5DK8s9QgaqJesZx5B3hB5uqyxRiOYd72H/x+zZh5hPX79
rxzm/WkksUcGKAOJoOCgFcBiBDEWxDKnUZvwenPHdx0Y7uPbbVY+ZbL4HUi37bQn
7604DsvzKE8qeEZh8zNzXpF/NRDyTKzBt0vBSjHDGf6tqZiFigc=
=90Dv
-----END PGP SIGNATURE-----

--nqbnlb5v7l7njgei--
