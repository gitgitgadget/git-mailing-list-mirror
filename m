Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3881F597
	for <e@80x24.org>; Mon, 30 Jul 2018 23:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbeGaAwR (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 20:52:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40108 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732027AbeGaAwR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Jul 2018 20:52:17 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b423:857:b27f:2f08])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 26A9C6046C;
        Mon, 30 Jul 2018 23:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532992496;
        bh=/UczbVkfim9NJdfFOeLNduNa+N7OyRLFaPYK2vjXhKg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Utu4rVopeHPDChEkIB7w9z52wPKOEVFxo/MRLJ8GzyAI07XaSIYUote+/Ap1PjTmd
         yVYW+qK2/POSsjicug+3UvG++P8+vmJYdyHThcMe4oiIoTOLlm1Ivcl5tCaZT2XMN8
         0wstnLPxGb71tepanTD3NambryrmMfZOFwjRDmY2s+Osky9HhA+6KsUqD9H6tswDH5
         VO0DEUdE78C0wV7jO8K+kazTN99OJyVU1oZmlZtbPWcIDgYCtKyD0E+R/sajWor7+I
         hfqk2CyN0ReZHXkhgSXx2nRGlsERMSruZ2u5ZePQ8SUTr4+mkI1QdS22368FIHnY54
         FkvsNcM6wQ+p04ZlE26Jb4x+A1/MwCPslFm64AMYfH2m2YspIgnFKBVpc1O3vYA459
         wScUerSj8IKuwCyRbcKIETjAWR/xIos6sZd7dlYM0LQpegae/j2tQQvkmXZwX+wFIv
         kPdQ9dVGBCDwgTP0F7AbbUPKzeAFI2ycqsOJGNtB72nOWO+KMJW
Date:   Mon, 30 Jul 2018 23:14:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] refspec: allow @ on the left-hand side of refspecs
Message-ID: <20180730231451.GG945730@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20180729192803.1047050-1-sandals@crustytoothpaste.net>
 <20180730175051.GA154732@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Content-Disposition: inline
In-Reply-To: <20180730175051.GA154732@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2018 at 10:50:51AM -0700, Brandon Williams wrote:
> On 07/29, brian m. carlson wrote:
> > The object ID parsing machinery is aware of "@" as a synonym for "HEAD"
> > and this is documented accordingly in gitrevisions(7).  The push
> > documentation describes the source portion of a refspec as "any
> > arbitrary 'SHA-1 expression'"; however, "@" is not allowed on the
> > left-hand side of a refspec, since we attempt to check for it being a
> > valid ref name and fail (since it is not).
> >=20
> > Teach the refspec machinery about this alias and silently substitute
> > "HEAD" when we see "@".  This handles the fact that HEAD is a symref and
> > preserves its special behavior.  We need not handle other arbitrary
> > object ID expressions (such as "@^") when pushing because the revision
> > machinery already handles that for us.
>=20
> So this claims that using "@^" should work despite not accounting for it
> explicitly or am I misreading?  Unless I'm mistaken, it looks like we
> don't really support arbitrary rev syntax in refspecs since "HEAD^"
> doesn't work either.

Correct, it does indeed work, at least for me:

genre ok % git push castro HEAD^:refs/heads/temp
Total 0 (delta 0), reused 0 (delta 0)
To https://git.crustytoothpaste.net/git/bmc/git.git
 * [new branch]            HEAD^ -> temp

genre ok % git push castro @^:refs/heads/temp
Total 0 (delta 0), reused 0 (delta 0)
To https://git.crustytoothpaste.net/git/bmc/git.git
 * [new branch]            @^ -> temp

Note that in this case, I had to specify a full ref since it didn't
exist on the remote and the left side wasn't a ref name.

Now it doesn't work for fetches, only pushes.  Only the left side of a
push refspec can be an arbitrary expression.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltfm+oACgkQv1NdgR9S
9ostoQ//SR4D+DPHXeJdReQeoP9RerwS5bVZ+toe/dX/XN2A2+XOALZtMotG0jKG
e1f31TKAItiovyLTI55o7xZDLZlIux6MlUdaPIxLNpmQBtT2IxDtLtNMLQ7RQ83J
4oVunoMjAQFfiVqlMppl+ydTaI79Yt8ML12PaQk4F2quSTc8AQXIlWe6wyigTzGB
RRiBrjUe4KraTTi7vF11tk8bTFnP0JSbydqFMA4j9yAKKnbgvDjIjzYjOoTPOq8a
QCHrZqsgEam9D0KkoE0hm/kZWthTCtz9RQKHLi1s8o2R4aqVoMZ80r9Yx8z6DXUx
YCKDQHgI+boPLCz0gm1cU0abTQ07Oh1JeRKRCCCrdcouTm9ifKajecJJQr2qkocH
KnQxgUEq6ka0LuTjymlqX/36mNn/IO811TlwZgfeno/s6leVZkLDP4fGYwjNjFb0
q9ZgdjxvRsVk30vH8ethm+MoS3s6dA4oxyfw5RUbjLTjDjgVyRAOQLCE5DlFHN9o
OcSCxeTSLsJaZPppqIlpcZK6O4MHIpiAVEFECTMaiJQ6gTVArD1jBzPLxyiYR9nK
N7BDw5ZqYgieTK5ZxhQANDDn+FIUpWB3a12FVlKBaOklmEVb00/DOhi+ZZGzFGkg
UjNyxk8/D9WhnbyHikRFrBoYG3FmlahPbJqKONiHFKB80gR6Rk0=
=zBay
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
