Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB514F8BE
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 23:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DaP/5Rc9"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 8BEFF5A39F;
	Wed, 10 Jan 2024 23:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1704930020;
	bh=QkCYxmNQp+Duk7o4dVA3I9fm0d0MpmQz40bT7f08SV4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=DaP/5Rc9mpNuzeEccqi+DcfvHJhtDNGDeWMlvBtqNhVSR2U9G7/KACQflDZMIbHXI
	 pvsGWF1PI5smXtgljDVbncH4O9alLyGVac9M+cm7acFi0P+AFPJEY+47jNuwdCCLoK
	 r57cUjuJA9kdXuL5zUnEQFm4bQw0+SEfxTyZrGHwz4gbgCB04odfH0mAqkgBi7pctv
	 YKjbrolbeNSusDN08nzmaKtdJig54SwqTVrnOF0nqGE+icCc6yopSbNwDJFT4izR2v
	 4S9gVPdojD20uPMqtPq+kUhiIX6XQ4PMpax7cn5zzjqYjaCSeZg9HmLHABKuxaenvW
	 K+Oo+gBEunHCTQZ0iS3n/0949orVx6cfyLvmEP77YOqN7a1QurvHVH6cn2jfEZFWXE
	 vyTcl0pAb4JZ0BEnywPYdFYp3i5bTuNmY2OUR5GyFL2hV5wJBQYkb+TY8HPJmzlTbi
	 /q5XVnBR4c2hkXq+fdzRT5TLTYlHS/nFafef050oO4ZAVjlV7eB
Date: Wed, 10 Jan 2024 23:40:19 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org
Subject: Re: [DISCUSS] Introducing Rust into the Git project
Message-ID: <ZZ8q40OdPy0v-ZxQ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org
References: <ZZ77NQkSuiRxRDwt@nand.local>
 <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
 <xmqqjzog96uh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T++AxKnsbDdcmmdE"
Content-Disposition: inline
In-Reply-To: <xmqqjzog96uh.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--T++AxKnsbDdcmmdE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-01-10 at 22:11:34, Junio C Hamano wrote:
> A few obvious ones that come to my mind are that you should be able
> to write a new merge strategy and link the resulting binary into Git
> without much hassle.  You might even want to make that a dynamically
> loaded object.  The interface into a merge strategy is fairly narrow
> IIRC.  Or possibly a new remote helper.
>=20
> Adding a new refs backend may need to wait for the work Patrick is
> doing to add reftable support, but once the abstraction gets to the
> point to sufficiently hide the differences between files and reftables
> backends, I do not see a reason why you cannot add the third one.
>=20
> And more into the future, we might want to have an object DB
> abstraction, similar to how we abstracted refs API over time, at
> which time you might be writing code that stores objects to and
> retrieves objects from persistent redis and whatnot in your favorite
> language.

This is definitely a thing people will want to do.  I think Microsoft
had some code for Azure DevOps that stored their code in the cloud and
the refs database in a real database.  I can imagine that being a
valuable set of features people would want to implement in a variety of
environments, with all of the benefits of basing on upstream Git.

I also feel that I would absolutely not want to write those things in C.
Rust is much more ergonomic when writing these things because freeing
resources (freeing memory, rolling back transactions, closing files,
etc.) becomes as easy as implementing the Drop trait and you write less
boilerplate.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--T++AxKnsbDdcmmdE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZZ8q4wAKCRB8DEliiIei
gaetAQCeYg287MeCq5VFGfEP/TyL3wl8ebC/rMWNxDPWhFS0uwD/U9dS4XMHqNNK
oa/MUpQLSax9JmbcskxuqHbniAHc5w0=
=XiyW
-----END PGP SIGNATURE-----

--T++AxKnsbDdcmmdE--
