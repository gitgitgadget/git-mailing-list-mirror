Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 033D71F453
	for <e@80x24.org>; Mon, 18 Feb 2019 21:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbfBRV3z (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 16:29:55 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34564 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726955AbfBRV3z (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 16:29:55 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 62A79603C6;
        Mon, 18 Feb 2019 21:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550525390;
        bh=f+ymTprrSupkA7ysug6jvYUkOWSRrdwsYbKnsiyc1MI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OAbTesIhYgyIGsqeWOZae0iz9U9hFF/JOyD3XoqOmgvDdWBG3xx1H0oYh3KsfgrHn
         qFVOJAIoegRvS+3Vy9kUzjkWxsryi6qZMrfjK377RIpABKCtyxDbctshDa0K3UG98E
         FN++Q5/delZVJZs9ShfoGg/7Jw1hGsRv79fDnekrFUoBULf2pMAU++ewQvFvaIWqiy
         n6iYFxHWnbm16Iqp4r++fxNeEuABbDdw6VuXqx8B9VAaXpRlOXulU9dc06Hm0j9MM/
         iMH/HHM/LJ+pe3JN0TOBF0NC/0XEydZFv81SCHs6y3xcLt2R5OdsZeggk3abbXGt5a
         F+bphyQgCqAgTiKhU3HIJwcoAd5jdp3LYSy2RNiVRFv32pXWmcheR9AO+vT/tGEuYC
         bmc40QW/5fPjB2jLLiUDV/6Pda6Pg9Pa2kS36R1jK8hNnl1ZaxWpjNlIKEjiIumruF
         M1yX6LavS1SZS+0U6Ol+frv3GCA0KtGqoa9k+AhG1wLrAUQJWxJ
Date:   Mon, 18 Feb 2019 21:29:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Marco Sirabella <marco@sirabella.org>
Cc:     git@vger.kernel.org
Subject: Re: default gpg signing key
Message-ID: <20190218212944.GM684736@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Marco Sirabella <marco@sirabella.org>, git@vger.kernel.org
References: <20190218201232.pqyy3kws75zduq7g@Ridl3y>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dzI2QqkSBOAresgT"
Content-Disposition: inline
In-Reply-To: <20190218201232.pqyy3kws75zduq7g@Ridl3y>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dzI2QqkSBOAresgT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 03:12:32PM -0500, Marco Sirabella wrote:
> Hi all,
>=20
> When signing a commit with git, the newer of two signing keys under my ma=
in
> master key is used. This is even the case when `default-key` is set in
> `gpg.conf` (`gpg --sign` uses the correct key).
>=20
> Is there any way to tell git to not use the `--local-user` flag when sign=
ing,
> and just let `gpg` decide which key to sign with? Or is `gpg.signingKey` =
in the
> config the way to go?

I typically use user.signingKey for this purpose. The benefit of using
local-user by default is that we serialize the email address in the
signature as the signer, which is valuable when a person has multiple
email addresses on their key.

We do have this functionality in the author and committer fields, but
embedding it in the signature ensures that the signature can't be
verified without it.

Also, without specifying -u, we'd pick whatever key was the default in
the keyring, even if the email address for that key was wrong for the
commit.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--dzI2QqkSBOAresgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxrI8gACgkQv1NdgR9S
9osc0Q/+J1zTfYHc3RePmLo2HxtDAey7+l+ZRqJs4rAe/xYnZE7hmdC9dBeXqWh6
OHs7+7CVcxY7xotwbYvQtWGSCPhwVs5peyr51X9KBsSwIrBXompiLi/rAoTnOdz0
pNKcRdrnKa0b7sz/BAIUaritAWyUNc6XF3OjpmEFUVP5rnHOkYc9JDnJU3oug5QA
GksbszpzqBy9HZMvEDxlOGH5NxmI9tT8UI6nnw8EOfa2RftgiXmmJPa7sodx/5B1
xZMYoaroJH59A3UQjUsP/bxO89wuo6CnyFvPEUDYeyXHP3MZ4nBiuEv8BM8uc4IN
qtBFWoSKby//5Pkr+Kk/NIspOgEVfKi7wkxNdo5xw2AtgaRo/aG26FOUbHchHWDg
werUaQ8TaNryx4ECMicCz1o6GupAC61ZOn2X74LW7tom/DGFtNLm+84V5Hl6qyfx
Q1Bn9GlPH9WfGdxSMF80r7H8tf1imWaGyQZneBswGN9mnGz4xDFedjoNmFTm/8H3
RQy4Qv7z5mgtEWzc7y1PgLo0P+wWz1gruN3Rhs8nIlQRXER8FJBHYukzjwI7eET4
3Ip68qsg7DjsP+p51j/ezskUVf/6eWivbLhsamuhaZ9biBawqUAcJVqoWi2Bb3Xv
3T8M4rTIO3drsOq3LV9IIAx6C7XoSvOjTmihIe7q5U8c5u34BaY=
=ptMf
-----END PGP SIGNATURE-----

--dzI2QqkSBOAresgT--
