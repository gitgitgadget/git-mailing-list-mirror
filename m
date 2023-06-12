Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C5AC7EE2F
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 21:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbjFLVZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 17:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbjFLVYx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 17:24:53 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E282230ED
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:21:58 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 0D1B25A215;
        Mon, 12 Jun 2023 21:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1686604918;
        bh=4ZAjNdYjG8TY4kzw/0dBw44oy1KpUmDuBouR+wjc02o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qhDCsB8uqYXCV6uVXb7dpyrXBOPSLpnPYqeJxX/Spn17zUvuEWv/1axJ+UhRol56k
         TTf6spNJZcC8Y47hA6YogUobgGH+SBHMZRKsKaq9KWDu+Xwl06z57UwSWbb87lUVwL
         JQ9D0RdxRsG+nyArCs883zqL3xKcysUa7pf2VmqL4F+dNWc09LiPw1EsCNCYK7xk66
         fjH8m7jpHHbDMmHOq+099HlcJ8rtKverM8h1LiEj9uMqVT7Rjan1OZC3WA8li5zfLk
         5fUbqJpY5tS2AzMEsiN7FkAjgBFBmb7fN1xCjY/Hu7YS6jPMYLt8tzVAURZdRoFaoA
         8oAOvnFyzyrQ3DwTmFvpd4RC8lGFq+8dEry/TxpQqv9hS5xuUZE+xN6Vxp/9SyJ975
         GBwCCd4cnW70UGCtYNxtco4rCUHjDY2ZsLEd9gXvjjio22kAm5hYYGPcUK15vE976R
         6E1M7tsU/2g8YZY56buDbgvD0CvHuAf/LSAL0IXqmgUak1Bmlng
Date:   Mon, 12 Jun 2023 21:21:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: Remembering which http remotes require authentication
Message-ID: <ZIeMcyloOiyAJ8ak@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Hickford <mirth.hickford@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <CAGJzqsnkH_dtv-CGsSFJ8K0kXKBf1+QQqy=MEw-Vq9XaEqr=AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5HgVrgmrWydYsWP4"
Content-Disposition: inline
In-Reply-To: <CAGJzqsnkH_dtv-CGsSFJ8K0kXKBf1+QQqy=MEw-Vq9XaEqr=AQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5HgVrgmrWydYsWP4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-06-12 at 06:47:19, M Hickford wrote:
> Most http remotes require authentication to push. Private repositories
> also require authentication to fetch.
>=20
> If I understand correctly, http_request_reauth [1] first makes an
> unauthenticated http request. If this fails with error 401
> Unauthorized, then Git retries with authentication. This avoids
> potentially expensive `credential fill` unless necessary. (`credential
> fill` may be fast, slow or even require user input)
>=20
> Could Git remember which remotes require authentication for which
> operations? On high-latency networks such as 3G or satellite
> connections [2], skipping a doomed unauthenticated request could
> potentially halve the time taken for some commands.
>=20
> A complication: if a repository changed from private to public, Git
> would continue to authenticate when no longer necessary. A solution
> could be to remember to skip the unauthenticated request for a limited
> amount of time, or a maximum number of requests, before rechecking.

What I would rather see instead is a way to indicate to Git that it
should always authenticate via a config option (probably something like
`http.*.alwaysAuth`).  I think this would work for your use case, but it
would also work for things like giving authenticated users higher rate
limits for public repositories.

I intend to add this feature at some point relatively soon, but I need
to sneak in a feature first to specify the authentication scheme as part
of the credential protocol, since we won't have it as part of the HTTP
401 response.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--5HgVrgmrWydYsWP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZIeMcwAKCRB8DEliiIei
gaiNAPwPJroXudp8rRH4TNW+1hKbZfTp+xSX1f3aYw/3eH8xWAD/eFydaKKBiUEn
YYWK7UF/XPaYQzv38fNq2Bd60PrORgo=
=Zdwn
-----END PGP SIGNATURE-----

--5HgVrgmrWydYsWP4--
