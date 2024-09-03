Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9E35894
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725326565; cv=none; b=PlacYIlpjjRNqCepet8kcXUaddjt+zERQngpw9a6zpmcY9y81fzxP3x9TKkhcaDlGKBR/P3vkT89ej8+B/JzaVMMGrcwfDZQrTTa7LZ12bhwsi9uKFbQCjgy5SqhfYrmFsi/APX5Mhy8c6/8K51d+27LkI6r3u5maf/aDZUONTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725326565; c=relaxed/simple;
	bh=s4Ae4ZVmNSH5yAic1xpkhvjzgJgmDUh27PLupJoNbFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ec6KhJetmhUwvmIH1TNErsvq92p4U2frzUr7PkcJJUmLGrkERTKlj3MglgcZiw/0Ylj+vjjEFaHsgxizsH25yWZM1AJuk3vIdY0GNo7Lnhrk9mQTNfx1DoyL+QHjKz0TiBXDkxm3FplgA9wjYPKxEluK89jGwztluuRBgkf7Lbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=DvJ3Pycd; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DvJ3Pycd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1725326560;
	bh=s4Ae4ZVmNSH5yAic1xpkhvjzgJgmDUh27PLupJoNbFw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=DvJ3PycdjV1P7YfVgQhff1waHbu5xsN1NnQ1GGmG52kg5p1Q1SSq6d4VX48xt6vSz
	 4WDs4GjM3KAE8KHQEkRE518F0OQcvrsEYazpxw+fVmMLlJ62bqPqh1cd3Ul/xddveE
	 ucjiGHIazqAGCcmnbRP+FhvlY7oMwBSFEpSILKWq5uUmPmihG7U8NIHEDS/GIn9/GN
	 WE10lO/78U41mIfC0X1XNUjdcDhKiTcBAIouF7ilsIuBHmMauJt/gFRdBijJe1WUF+
	 zcQMYwGJvBu9xct9yDm8YL3gqJKEYhzZCBHUECbRQFALuRBKoUJg+AMRfLflxrHfAG
	 6yPsFAD6NcRWQIYIwgaXhiJcdE8bj24YfkInUhAuZE4ffQpJ319xanFAqONwRvAyEs
	 3IEBBAgs9Kkm4XxhUA9VOQmpqLKhDb17+9JgXHoLA2tdtplQbCkrc4clzS0VgD9RcT
	 e2fijGxnnhTwcYNO22ZyzbeVoxkatj7UW1Ubf2Un8himNR5KO1A
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7427D209AF;
	Tue,  3 Sep 2024 01:22:40 +0000 (UTC)
Date: Tue, 3 Sep 2024 01:22:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] csum-file.c: use fast SHA-1 implementation when
 available
Message-ID: <ZtZk3hUnd8hS2V0C@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <e8f5cbd280cc07f68014bd4024d55a740374b349.1725206584.git.me@ttaylorr.com>
 <ZtXAi9KYOKejJmOS@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gEqOQ6ryZFGCh9WR"
Content-Disposition: inline
In-Reply-To: <ZtXAi9KYOKejJmOS@tanuki>
User-Agent: Mutt/2.2.13 (2024-03-09)


--gEqOQ6ryZFGCh9WR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-02 at 13:41:31, Patrick Steinhardt wrote:
> Neat. I knew that SHA1DC was slower, but I certainly didn't expect it to
> make such a huge difference.
>=20
> I of course wish that we just moved on and switched the default to
> SHA256, which should provide similar speedups. But that of course
> wouldn't help all the projects out there that will use SHA1 for the next
> couple decades.

I actually think that not adopting this approach would be a big
incentive to get people to switch, honestly.  We can say, "Need better
performance?  Use SHA-256."  SHA-1 is faster than SHA-256 both when both
are in software or both in hardware (because it does less work per
round, which is part of why it's insecure), and thus this series
actually disincentivizes people from switching because it makes SHA-256
slower by comparison.

We know many people don't care about the security because they're still
using MD5 because it's fast and "it's good enough."  That, by the way,
is absolutely not the opinion of any reputable security or cryptographic
organization.  Similarly, those organizations would say that SHA-1
should also no longer be used, which is a position I would also endorse.

SHA-1 is not going to last another couple decades.  As I mentioned
elsewhere in the thread, someone has already built DES (2^56 work) brute
force hardware for USD 250,000 and is farming it out for as low as USD
20 per crack.  SHA-1 offers 2^61 collision resistance, so a brute force
attack is only 32 times harder (if the operations were completely
equivalent). That means that if someone built a similar machine for
SHA-1 and rented it out, it would probably only cost USD 640 to wreak
havoc on any hosting provider still using SHA-1.[0]  That assumes the
attack doesn't get better, which it probably will.  Note that it took
only 7 years from the first MD5 collision to an attack which runs in
less than a second on a modern computer.

This series also means we have to continue to maintain non-DC versions
of SHA-1, which I had hoped to get rid of.

For those reasons, I'm in general opposed to this series.

> The only exception are of course packfiles, which get generated by the
> remote. Is it possible to generate packfiles with colliding trailer
> hashes? And if so, how would the client behave if it was served a
> packfile with such a collision?

Yes, under the same conditions as colliding any other body text, as I
mentioned elsewhere in the thread.  It would overwrite any existing data
with the same pack hash because we use rename(2).  We would have to use
link(2) and die if the file already existed.

[0] Remember, we die on collisions, so for a push with a colliding
object or pack over HTTP the user would get a 500 error.  Repeat that
push a couple thousand times at 2 a.m. and it'll page the on call
engineer, who I assure you will not be delighted.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--gEqOQ6ryZFGCh9WR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZtZk3gAKCRB8DEliiIei
gfCmAP9rkMPfVvBj3FyoEubvVObeBNINFAesW0zRGdmmXh/O/gD+Mkab4tisLbFO
yICophYdxblWhRAbbCBDDEjW/wLZSQU=
=gqdo
-----END PGP SIGNATURE-----

--gEqOQ6ryZFGCh9WR--
