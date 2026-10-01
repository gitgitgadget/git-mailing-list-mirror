Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB09033DEDF
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855933; cv=none; b=F0izFEwqLayUWWyPxdwKpKecT98KPnvNJp478tmwEAf6wpYEZP9kYPsv3D1EMF5ngZ2cusqzedZ4/D699zlAHtHBtHnDubWWQam+sHXhgocu+Hpj/zlMFqv/SMQMC5rnGm211YtCv/qATAGwXltXVelKvLWGTfI/O/gs7Y6+rHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855933; c=relaxed/simple;
	bh=hs6Dq7QQm4FaiHWAC+/kMmVARhGeG/+NeXHDoxFlwn0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b8C+cymS/Gxlapgw7IQBJScqmOmvX1Bl0m89yK2PJuP1e4Och0UK2bSmyQYy8qZml4NETEvUqpGKjAbaqdYISHNPOcV+VD6i3AQ9aHAPvYLmzxEfZAu/9yl7m+Du4/+gqEyaXAPiZD7AOK6okLeARxe/MGFVtECIpqcm3ejg0Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3MX0z99; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3MX0z99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672E81F000FF
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 11:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790855929;
	bh=uXrlQ568yxigxlmULnvzi/qH2srt2ZM00H29qkXXf9U=;
	h=Date:From:To:Subject;
	b=S3MX0z99+CXjAsjYiaGCgZ0pAYbX10tpFgLBAEWaluPSqDfwSHhZvniRWnCorcPXc
	 P7RQuxH1DdBiVHxo8c8XWCUYUhBRhGzkUXJeNS+Rv90vB6xiWPsDqjdAMy+VF2Wwjk
	 cb4TDDNxDRf/kMxQaTL4aHdxXxqhMcDlyuNvNfeADmYlph6cjNz+ldvoDbDi4RN4RV
	 2+r72H4WQOLZfiKW2GtQd6I3Wfx5QPTD04D3fHcpdLmTrSwiw9QPCHu69d47yAPgud
	 u1pHszuorml/nCBA1XsfrL9g7yYc6cz+GKYX1RoK7008igYoQSN4HtZoCDXVFEemsz
	 nW2znBgcZb8RA==
Date: Thu, 1 Oct 2026 13:58:42 +0200
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: git-rebase-walk
Message-ID: <ar5KL4_IKXYbx3Sb@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a446ufjeorwdyusv"
Content-Disposition: inline


--a446ufjeorwdyusv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: git-rebase-walk
Message-ID: <ar5KL4_IKXYbx3Sb@debian>
MIME-Version: 1.0

Hi!

I use this little command to apply iterative rebases, which are easier
to handle when there are large conflicts.  Are you interested in it?

	$ cat $(which git-rebase-walk)
	#!/bin/bash

	set -Eeufo pipefail;

	git merge-base HEAD "$1" \
	| xargs -I{} git log --oneline {}.."$1" \
	| cut -f1 -d' ' \
	| tac \
	| while read -r c; do
		git rebase "$c";
	done;

The source code is trivial, so I guess I don't need to explain much.
It behaves quite nicely, IME.

You may of course want to adapt it a little bit for merging in git(1).
I could help improve it a little bit.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--a446ufjeorwdyusv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmq+SvIACgkQ64mZXMKQ
wqn3Dg/+MFc68a6LK6j6tg6Pf21+GXFKkaWcrO2E/vecdtR3wCzaxT/Hc0Llk9rn
16RcFdafnhrOE1TbJLJQB40p0p29cgcOqEp846fol/+/O1ffwJyuSleg0GHiJOUo
0Uqp3LnghPunabLbbZ104XvIqlJRzMUw731O+pWMK160Y7dxheUVxzq8wmRjcQVJ
GAQ+U3lsj6xa72T/oDIVLa8Xrkq5YO6K3Tg+L0+zbQJh/6hd7ykG8qL8OiCr73+W
zqmCIBqb++jwHOaxZ9RV4yB4cdYesGtAEUv9+FPyYc8pUUqcUEPEZphppM93YQlV
IQKXLmguH8njktlGlvo7baC5w7nrGcbnD8JITj6N5gKq+EcqE1EGdPbXYtvCLFDa
vk0VeZeyIRznfYkWyEnqO7rwmvyDeTEnl1N8lffufhFVJkdvGXEOzYNInE4ZVZ7i
/e8tVAv9v/7hJ6lO1WgEnk19+HIwKTq2M3QPbR1Q3z+L36z3yfLY5DucZ8vfk71r
VIqtplH+dpQ/mEiBZM/bVRYS78c1aij59aMcz8jq6l7ptoPaem71TYnsSidrylP8
UZzvx1QQzr6RF2YIdyC4zyTiZKUlgI3Nt8eznxkA2s/0O1/c4LU6BKGtjgWQ9OI1
0KpetVQdAdt+jrn3AsYJTBo/T3vsGG3MA3m++ufD17k0x9X3Hc4=
=iLK1
-----END PGP SIGNATURE-----

--a446ufjeorwdyusv--
