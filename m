Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5584928DC5
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Icz5+7QV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF08C433C7
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 14:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700834425;
	bh=fOYxC33aCl20nncVO1N3FxwQnjn2fXFAbp4nc8ZEsdQ=;
	h=Date:From:To:Subject:From;
	b=Icz5+7QVYcgcNKVlxZvbDUKLJGSJ+Wz3ssaNvaU8vGFeAYYvKENXdG0tjINEjfBLB
	 /wU5R4sVHVWSvAGJtFDqM/oQQMUEctsxraOpgsmNehhPrM5YytDYoIfQdwiNGDo3K6
	 QdRONQgo3Xn1EdK9cp7fVQV9iOoaTHyaQItsCHgvKhytAxhiPQbDQWVaT8Suo9G5zE
	 AkjhB1wyPclb8fbpbuOM6gR77qabEbkqR2whZwIVGElqhs3ld4s8IuhtUEBMe5PL9v
	 UFOIDcPQJkHLE5ke7tZQ2T7zjThSurC9H8l11Xh9l4SxrIlmLXeetnHtNbdJMC4X3R
	 m1yQ/4sMnVRlg==
Date: Fri, 24 Nov 2023 15:00:22 +0100
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: Running git(1) from within hooks/post-update
Message-ID: <ZWCsd3cJZ3LAqOwg@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U6JUlIdAL/10pCma"
Content-Disposition: inline


--U6JUlIdAL/10pCma
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Nov 2023 15:00:22 +0100
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: Running git(1) from within hooks/post-update

Hi,

I'm trying to set up a post-update hook to produce a build of the Linux
man-pages PDF book after every push to my personal server to the 'main'
branch, so that I can serve man-pages-HEAD.pdf at some URL, for users to
be able to easily check the manual at git HEAD without having to clone
the repo.

I thought of having a git non-bare repo where I build it, so the script
would be the following (the paths are tmp, because I'm still testing).

	$ cat post-update=20
	#!/bin/sh

	test "$1" =3D "refs/heads/main" || exit 0;

	cd ~/tmp/man-pages/;

	whoami; pwd; ls -ld .git/;  # This is for debugging.

	git fetch srv			#>/dev/null 2>&1;
	git reset srv/main --hard	#>/dev/null 2>&1;
	git clean -dffx			#>/dev/null 2>&1;
	scripts/LinuxManBook/build.sh	>~/tmp/LMB-HEAD.pdf &

But it's not working.  The git(1) calls are failing, saying it's not a
git repo, but it clearly is, and I have permissions, so I don't
understand what's going wrong.  Here's the 'remote:' output of a push to
that testing server:

	remote: alx
	remote: /home/alx/tmp/man-pages
	remote: drwxr-xr-x 8 alx alx 4096 Nov 24 14:41 .git/
	remote: fatal: not a git repository: '.'
	remote: fatal: not a git repository: '.'
	remote: fatal: not a git repository: '.'
	remote: hooks/post-update: 12: ./scripts/LinuxManBook/build.sh: not found

Can you please help?  :)

Thanks,
Alex

--=20
<https://www.alejandro-colomar.es/>

--U6JUlIdAL/10pCma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmVgrHYACgkQnowa+77/
2zL1DxAAjG/sLtbTO6QwzDXiRE99FqTEEMsZTUkXxDMDjjtcokAQC1sY2iSgpdwM
GAw3x+8gZh6Nrjh95AE9Bm7ONVIUDhVZq89GByIdnJr9ki2U9jEbi6BHcXS0UABj
xYbEPx1Wm5kqRzPTkrV5etx/1/Pci/HkRjWN3cucDECRCZeH9cF8D4eCht154Lkv
UtXeMxHhHqGw6UKVmGs5VHMvr09ODQ2WoVWUCyGoJK+mRorZ77V8d+RtdS7RWz3b
oj7/tRTwungakuA/ABVqlkBKXKE0gCCve0pnLRiYzf0G7gzrhbDHnONPUIy/M3o0
gVZcDJFT01UcnoBnAV+IEMQlOZiFUueFGhH5QaxXJhsyux8x8gNZ9yv1GfZRNuv/
quWJBgQ0R06jYDEEOGFKOGZXJdh5juZe0UjIdnzlv0Do5YIjJpEbSfUfCGaA9Hc0
2vQjMBnxCqsmiVYzD0D1ClKwpL14GWZP4pO+Xh0Y08ryCui2RzxqjHWCN37BXxDf
6kzMbWIzoc7dtRrHmcQr1I7CM5ID3YaX8ncDlO10YrkTP/kq7SiX6+KDaRaTq1+G
2NRyF1w2/8Z03IvCioOB/XqUvMbiM7X5S3oiRmavWi4OqWmGwStZB0x6i7qtFhBA
+nOeXFTjzdt6hwywJF+tsLv9X4jDke/HqX7YWLqN8qTWUiX3GLA=
=dBbE
-----END PGP SIGNATURE-----

--U6JUlIdAL/10pCma--
