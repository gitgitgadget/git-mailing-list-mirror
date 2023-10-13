Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D121A0A
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="M02M4FaX"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FC5BB
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 14:05:28 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 207F55B07E;
	Fri, 13 Oct 2023 21:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1697231128;
	bh=6eqowXrQxM38HU9l3iAuUYqKVEnKAEB0GdT81h4fT+I=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=M02M4FaXyLIgCgW9RuVsy1RFk0BQ5dgTs6fiw7N0LVLudF2+UH2N78gSmN2KewI+a
	 MzzFoG6n0WwFew7Ebpg8KwlD2MvnCjZ3uP+LgubenNa7z9lq8e0p+GJX15/gMs1pGe
	 AXOqq1DLvPzo9TdrM/BAvd8oWiVctE+npTxtRBzgh+06ZaV/xYkuv0Zfi83/+QxWTh
	 BW0uCrLktUJKWB29gmENIyIuAhlCvr8Cz5traZ103soKZldMxfmcDtslTquEK5w3mA
	 +t+Pr+P4lV78xmTPACmk6nhE8ZA5CE8tJ7Qtq9BtXljqk6bzmO2d1DvXvBb3Fcvb8z
	 omf6VtyXI0Fq1KE+P1AEExqkVWgAYErh7ni0h+rfxQemt5+nMtxTWKxcyradL8FhBi
	 am0X7FO6yB30yXRmbCcdqbAkiI6VAER5cLcJtG3w2P+8Sim7ErnWnDBFBKgil/64Go
	 1lNwMXm7pHcbLGvAMUFBgUOvo/Yr/C3MtqNkxLiGpm8DcI5L6QB
Date: Fri, 13 Oct 2023 21:05:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Feiyang Xue <hi@fxue.dev>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Add x64 SHA-NI implementation to sha1 and sha256 in git ?
Message-ID: <ZSmxFopwJyBGmZY-@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Feiyang Xue <hi@fxue.dev>, git@vger.kernel.org
References: <20231012200447.3553757-1-hi@fxue.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z0BCUltcSBVIcG9E"
Content-Disposition: inline
In-Reply-To: <20231012200447.3553757-1-hi@fxue.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,RCVD_IN_SBL_CSS,
	RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--Z0BCUltcSBVIcG9E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-12 at 20:04:47, Feiyang Xue wrote:
> Looking for comments on if this is a good idea to add SHA-NI option to gi=
t,
> And if so, what'd be a good implementation.
>=20
> The attached patch is more of a proof of concept,  using a sha-ni example
> found on internet and have it tapped into git's "hash-ll.h" when it sees =
make
> flags "SHA1_SHANI=3D1" and/or "SHA256_SHANI=3D1" for sha1/sha256 respecti=
vely.
>=20
> "git hash-object" is about 3-ish times faster for me

You almost certainly don't want to use SHA-1 using native instructions
because it doesn't detect collisions, unlike the default implementation
(SHA-1-DC).  Since SHA-1 collisions are relatively cheap (less than USD
45,000) to make, not detecting collisions would be a security issue
worthy of a CVE.

It's fine for SHA-256, but see below.

> There are few topics that i'm uncertain about.
>=20
> 1. Is it good idea to have machine-specific asm codes in git. I read ther=
e was
> commit fd1ec82547 which removed assembly implementation for PPC_SHA1. Doe=
s that
> imply maintainers doesn't want machine-specific assembly in source?

I'd prefer we didn't.

Nettle has SHA-NI extensions on systems that support it, and so does
OpenSSL.  OpenSSL can't be used by distros for licensing reasons, but
Nettle can, and both of those libraries automatically detect the best
code to use based on the chip.  One of those libraries is almost always
going to be linked into Git at some point because of libcurl anyway.

If we ship the code, then someone has to maintain it, and I don't know
if we have any assembly experts.  We might also have a bug that produced
incorrect results, which would be pretty disastrous for the affected
users.  It's much better for maintainability if we push that off onto
the cryptographic library maintainers who are much more competent in
that regard than I am (I will not speak for others) and let distro
maintainers simply link the appropriate library, which, as I said above,
they're already effectively doing.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Z0BCUltcSBVIcG9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZSmxFgAKCRB8DEliiIei
gQMHAQCxSQ9K8JS5uLdOUZsoZsNegNPvgDQTBE30Hee99FdTKwEAioKe/8v1o7ID
WtON0+6tfEriZgx9nRBCXwhmzZ7tUA4=
=V2+S
-----END PGP SIGNATURE-----

--Z0BCUltcSBVIcG9E--
