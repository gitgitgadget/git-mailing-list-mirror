Received: from kitenet.net (kitenet.net [66.228.36.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A663A1A2
	for <git@vger.kernel.org>; Fri, 24 May 2024 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.36.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716572295; cv=none; b=E2i/ZK5QXex8sHOZ3fSdIxsW7E2sJDQm+nJf2/2o9viACFU01vb+7zw/GYNFeB4GDIiiBM6UnKZ+OEoefGsd2uG9D2Sb6jt1qckeyVFqFg8XRIRcBkpZgHkP/BUbyfA4g7cAt25lvqXlkLUZwE/CJmeRe7+DIzKLdD/2iTb3pDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716572295; c=relaxed/simple;
	bh=6KEqWJD3tT+Fb+R9llMpHSrgm2nO7r7Hlordasy9mxM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrN7cKgyQqTMkdIXIHi94eTGrCsNRLuJWJUUN6WElrUzS8aV9BW29sKLAi9Xd5jqcYqyNr6YyF8dGZVRsrbeLGqy0pZ205jNyOeCB3eoDpIrM22YVaZ+evJIU6Q5XGJf15tBz8aekr0U3vqkwIEWP2m3iKusAY5DJqmgjECJdVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name; spf=pass smtp.mailfrom=kitenet.net; dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b=m4merUyS; arc=none smtp.client-ip=66.228.36.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kitenet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b="m4merUyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=joeyh.name; s=mail;
	t=1716572277; bh=6KEqWJD3tT+Fb+R9llMpHSrgm2nO7r7Hlordasy9mxM=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=m4merUySqyJ90HUUY0c9Io3TxpuHfcJRjDZOyZG0PA9lrtmeXQI6jb0ZXtCwpLPeM
	 MT2eJGa7aS5g9pYtTpDrG6gGGVM0ETflfFaWCaKLI3On7e9/gpV3ogacjsnBTQ0MXY
	 njyiRGceO8cy12bFiG9GofVUwkHamDc5CnCZ+7UY=
X-Question: 42
Date: Fri, 24 May 2024 13:37:57 -0400
From: Joey Hess <id@joeyh.name>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Revert defense-in-depth patches breaking Git LFS
Message-ID: <ZlDQdXh5i3MCjTmr@kitenet.net>
References: <20240514181641.150112-1-sandals@crustytoothpaste.net>
 <0f7597aa-6697-9a70-0405-3dcbb9649d68@gmx.de>
 <ZkO-b6Nswrn9H7Ed@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dlQ3ZEund2+lXRsk"
Content-Disposition: inline
In-Reply-To: <ZkO-b6Nswrn9H7Ed@tapette.crustytoothpaste.net>


--dlQ3ZEund2+lXRsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

brian m. carlson wrote:
> > proposal was to introduce a way to cross-check the SHA-256 of hooks that
> > _were_ written during a clone operation against a list of known-good on=
es.
> > Another alternative was to special-case Git LFS by matching the hooks'
> > contents against a regular expression that matches Git LFS' current
> > hooks'.
>=20
> I have replied to those on the security list and to the general idea.  I
> don't think we should special-case Git LFS here.  That's antithetical to
> the long-standing ethos of the project.

I was surprised today to find that git-annex also triggers the hook
problem. In particular, a git clone that uses git-remote-annex can
cause several hooks to get created.

I think the hook check is already scheduled for reversion, but in case
not, here's another data point against hard-coding known-good hooks as a
solution.

--=20
see shy jo

--dlQ3ZEund2+lXRsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAmZQ0HUACgkQ2xLbD/Bf
jzgJQRAAgqjN8rgR9gJ/3s5QAWO2PMsBBxgVKtm1IeZDaFk4PW5XpPBlhL+1sXcf
v2UeflqbWWm6Sj+tcNqwZxKN+ZkmR22V3jp/g5A9/CgYd4U8ta2R5PQrVa2Va0j7
tggX2bKRIaSxkfzsmGpOGwFjX60/m6yQTza+6aKi0WQpf5nfEhUT7pxNSu7uh58N
qBhH1pbXBISRwpX8hVcIvyQ8swXwyVSS+3KRGneypDVGDFSEWWW46dOdF8MuFj2m
7FAZTG5MZd57XaHNfN4NIAwLYFpEBHhM8c74E1fEFl7Mgp2su++2M2xhm2N0PTw+
AwgxMpj3T9Ha29u+PFxAciVVmA8YJEqie4210sq8+LPZY7DDrTmtOp2J0f9Xbw9V
Mzh7lODnohadjHgDb6VBOzi7uz5RIhsqvuQKNKz2Z/8eoR5PMy2dP+7RJW9Tpxzj
+2XuHuVFzEKF57eNHp2z9CRkbhp5aoUE5DI556SosbId0XoG9V6160x8awslEf8s
0QeiV3a+J0e8hp2UXDNuOJocams6gxuxhFmknFmO6fzhT9lon9mL/cXpUVVBQHVe
A818zh7+jAy3EZvG5ETROcvQRyfxKl+QSG0giHopYntyT9/GNSxS10gJuSxRiol0
6QNM7MIabfkQZMwOyN85f6DNBuhyoHJaihHtxOOKmEN9b+NHgGg=
=pZy/
-----END PGP SIGNATURE-----

--dlQ3ZEund2+lXRsk--
