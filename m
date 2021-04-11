Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9695C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 21:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DAC86108B
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 21:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbhDKVGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 17:06:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59394 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235229AbhDKVGM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Apr 2021 17:06:12 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 447676041F;
        Sun, 11 Apr 2021 21:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618175155;
        bh=aWo1rPHHUye29aFu179Eoz6qDJOut4rPpoM8LghWE5c=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=aQIcUi1wRfAOljtaTksiK0EL/RJbVt3VaJ/9ifxTyI3Y3nH8KO0ofzu5tUnak6j3R
         sr5m0RV7FlJRdaht0gayyxU5BmrgoOBpYgEVeOCBHgv4bLbHVDc+H5/xLjXpSSGNU6
         Uf5lMXaZ0g88GbN/3uSnH6akeRaH5i6Q3JaypG4f6GIZ7uiucCm8mu/BduUyfdJGA8
         enZWc96rF4UwDtDCGgUSMQWToXsL9Jfm2ziV8gEjMlNIM/2wNpxlmIQU23SfUCVu2w
         IiuqGRQ12jfXaZax9fNr9Yoqn/Z9c2mCptT6buGXXGW5w424F1GOT5ko1u7ktMcmJq
         JY7FzaTiwueG86gvNAn9JCkn+g646xbnlr4tAAsnpM8JMaPnkbHMUf7vIKughl/lsc
         52lJSxe6IbP/hBLdSfhAKbKTXNySTb4aUhfDWN1AL6t0UM2xd9AZYcpufXbe3Wuu1c
         wRIJ/EobMf2Ekuggm+K8+tZqqok9APaeOe0Je4tkzJekm5yP78d
Date:   Sun, 11 Apr 2021 21:05:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 08/15] cache: compare the entire buffer for struct
 object_id
Message-ID: <YHNkrnid7sJh5RSh@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-9-sandals@crustytoothpaste.net>
 <87pmz1f3y6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gih1sOw7fJtF0XQw"
Content-Disposition: inline
In-Reply-To: <87pmz1f3y6.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gih1sOw7fJtF0XQw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-11 at 11:36:33, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Sat, Apr 10 2021, brian m. carlson wrote:
>=20
> > Currently, when we compare two object IDs, we have to take a branch to
> > determine what the hash size is supposed to be.  The compiler can
> > optimize well for a single length, but has trouble when there are two
> > possible lengths.
>=20
> This would benefit from some performance/perf numbers. When this code
> was first changed like this in 183a638b7da (hashcmp: assert constant
> hash size, 2018-08-23) we had:
>=20
>       Test     v2.18.0             v2.19.0-rc0               HEAD
>       -------------------------------------------------------------------=
-----------
>       0001.2:  34.24(33.81+0.43)   34.83(34.42+0.40) +1.7%   33.90(33.47+=
0.42) -1.0%
>=20
> Then it was later modified in 0dab7129ab1 (cache: make hashcmp and
> hasheq work with larger hashes, 2018-11-14).

I can do some perf numbers.

> > @@ -205,7 +205,7 @@ static inline int hashcmp(const unsigned char *sha1=
, const unsigned char *sha2)
> > =20
> >  static inline int oidcmp(const struct object_id *oid1, const struct ob=
ject_id *oid2)
> >  {
> > -	return hashcmp(oid1->hash, oid2->hash);
> > +	return memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
> >  }
>=20
> hashcmp is now:
>=20
>         if (the_hash_algo->rawsz =3D=3D GIT_MAX_RAWSZ)
>                 return memcmp(sha1, sha2, GIT_MAX_RAWSZ);
>         return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
>=20
> Wouldn't it make more sense to amend it to just be a memcmp
> wrapper/macro if we're going to not make this conditional on the hash
> algorithm, or are there other callsites where we still want the old way
> of doing it?

No, we can't do that.  With oidcmp, we know the buffer is large enough.
However, in some cases, the buffer in hashcmp is not large enough.  For
example, we may be at the end of a SHA-1 tree object and we'd segfault.
I did try that and I quickly found that it was totally broken.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--gih1sOw7fJtF0XQw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHNkrQAKCRB8DEliiIei
gZUlAP4oDORM1oRd6sFo0z2J65RjUbhlcbyGG3tcvZEqM1+D3wD/WZnpnFmNDjox
6amvdPRtHiL3WhcSQd0CcUw3aRKw6QY=
=+Pyb
-----END PGP SIGNATURE-----

--gih1sOw7fJtF0XQw--
