Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543701C30
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kh28qxUp"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 67ACC5A395;
	Wed, 10 Jan 2024 23:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1704929645;
	bh=CYfeqEpKHPH4TmIfHNisCK7lQKIjn5Mm0/MrnRT2EcQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=kh28qxUpy4nNZYFrlFXFygmFFsvMyMo92VOyKUcePOWhoWnq62sT9OHV261h+TtdF
	 vYdX6mCjTqnr6GJ/Kfl0Kz6XE2StD9JLk86WZ1UJtFv41g9peACG2Z1WBgXogn8YUk
	 nzahVSLZjsJurfy+X4+At/GoUoIBsrbUMCsaKx/5iACsECVnpxpbOW7jt5gro/go3N
	 8Q9MgIW6ruNlqC7UjphO/9hcrlEAVopOkKFrRAJU6waW7vYQ1mpLzevizxX1H8/23N
	 CDatBu15zGnuABNSMD0yV8Ye2N4D0owBFnIZoWlmo6jhTRwkgqB+cnRngGvbFskiXu
	 xfnRuhyjjAoIQj0SZ5h14YDIjJihevClj9K9G7wfmyjRr3DqyQUQ5wjOGYUOqU06ut
	 zI7ViG8OUfB1124BdqeYw70CCNc/M9a4zOpv9J9b/aOSZxh3NGoin4NXXEFLSZXRUb
	 K2OIPql0q93/Rq8z+/SKsHnYt4BCf7wLhAudGy/e1x7ywPlAZE1
Date: Wed, 10 Jan 2024 23:34:04 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: Limited operations in unsafe repositories
Message-ID: <ZZ8pbAMNaBDFgf3G@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
References: <ZZr-JLxubCvWe0EU@tapette.crustytoothpaste.net>
 <20240110120531.GA25541@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LX2pU4APDEEGZmxX"
Content-Disposition: inline
In-Reply-To: <20240110120531.GA25541@coredump.intra.peff.net>
User-Agent: Mutt/2.2.12 (2023-09-09)


--LX2pU4APDEEGZmxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-01-10 at 12:05:31, Jeff King wrote:
> My thinking is to flip that around: run all code, but put protection in
> the spots that do unsafe things, like loading config or examining
> hooks. I.e., a patch like this:

I think that's much what I had intended to do with not invoking binaries
at all, except that it was limited to rev-parse.  I wonder if perhaps we
could do something similar if we had the `--assume-unsafe` argument you
proposed, except that we would only allow the `git` binary and always
pass that argument to it in such a case.

I don't think reading config is intrinsically unsafe; it's more of what
we do with it, which is spawning external processes, that's the problem.
I suppose an argument could be made for injecting terminal sequences or
such, though.  Hooks, obviously, are definitely unsafe.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--LX2pU4APDEEGZmxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZZ8pbAAKCRB8DEliiIei
gUSNAPkBBm1YgRrnMGASu9x63f61vohe2qRtVPPhTUJt+u7a6AD+MUWEu9rsAPck
bThMic/X0d3S9eSzC5+tE/kNJn2Q9Ao=
=ZLQd
-----END PGP SIGNATURE-----

--LX2pU4APDEEGZmxX--
