Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439D22FC3A
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psa70Yvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398A9C433C8
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 15:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700840539;
	bh=o/sq1eKxrXiNlz7+6umq857Dt48nkFA2XbVcFJ/dXbk=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=psa70YvquxaMwLba1fCQafX9T8bkpiRW065+rgNE0BHvYssKN5IHl32Oqyv/zG7Jx
	 WLowEMLrMxfpB623pRnwAjunBN5F/var1Ud51ObyB+U8L1VlyYJ4o2sX+Qgi9FYuHN
	 tM8DoDxY8jetF3I9qtH+iNhE7DqGVOqzdLMzYuSR57wQuiJI4UilIhLWoNAtZsJ56J
	 so6uHU0X+z+CXPjB2WzapqNMoyLu118VK5l0KazqCmP8DlSWzkvU4gHEEdiY7WE4Kp
	 tDPfH3Ji04AkvMgtZzBdJC7+D0kyd0g3vSKTkNMgQzymm4Rsv4ny5wqdH7EGO6fAJJ
	 ZNyMyDOJOxaLQ==
Date: Fri, 24 Nov 2023 16:42:16 +0100
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: Re: Running git(1) from within hooks/post-update
Message-ID: <ZWDEWDTtiFYAYp2P@debian>
References: <ZWCsd3cJZ3LAqOwg@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q09JBTuGhH3D3r/m"
Content-Disposition: inline
In-Reply-To: <ZWCsd3cJZ3LAqOwg@debian>


--Q09JBTuGhH3D3r/m
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Nov 2023 16:42:16 +0100
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: Re: Running git(1) from within hooks/post-update

On Fri, Nov 24, 2023 at 03:00:22PM +0100, Alejandro Colomar wrote:
> Hi,
>=20
> I'm trying to set up a post-update hook to produce a build of the Linux
> man-pages PDF book after every push to my personal server to the 'main'
> branch, so that I can serve man-pages-HEAD.pdf at some URL, for users to
> be able to easily check the manual at git HEAD without having to clone
> the repo.
>=20
> I thought of having a git non-bare repo where I build it, so the script
> would be the following (the paths are tmp, because I'm still testing).
>=20
> 	$ cat post-update=20
> 	#!/bin/sh
>=20
> 	test "$1" =3D "refs/heads/main" || exit 0;
>=20
> 	cd ~/tmp/man-pages/;
>=20
> 	whoami; pwd; ls -ld .git/;  # This is for debugging.
>=20
> 	git fetch srv			#>/dev/null 2>&1;
> 	git reset srv/main --hard	#>/dev/null 2>&1;
> 	git clean -dffx			#>/dev/null 2>&1;
> 	scripts/LinuxManBook/build.sh	>~/tmp/LMB-HEAD.pdf &

The script works fine when called manually.  It seems it's calling it
as a hook that fails.  It seems it's running git(1) from within a
post-update hook that is problematic.  Is that expected, or is it a bug,
and can it be fixed?

>=20
> But it's not working.  The git(1) calls are failing, saying it's not a
> git repo, but it clearly is, and I have permissions, so I don't
> understand what's going wrong.  Here's the 'remote:' output of a push to
> that testing server:
>=20
> 	remote: alx
> 	remote: /home/alx/tmp/man-pages
> 	remote: drwxr-xr-x 8 alx alx 4096 Nov 24 14:41 .git/
> 	remote: fatal: not a git repository: '.'
> 	remote: fatal: not a git repository: '.'
> 	remote: fatal: not a git repository: '.'
> 	remote: hooks/post-update: 12: ./scripts/LinuxManBook/build.sh: not found
>=20
> Can you please help?  :)
>=20
> Thanks,
> Alex
>=20
> --=20
> <https://www.alejandro-colomar.es/>



--=20
<https://www.alejandro-colomar.es/>

--Q09JBTuGhH3D3r/m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmVgxFgACgkQnowa+77/
2zIOqw/+N8berwOkekIUdwLIUC8GLafp+4XV7ahk0iiR8zBvA+4p7giCqHyVL+4o
2YRpTaOEmUi3SbwS8uj9pRzEJtl9Q8k52aGgXebcNEdTE4B0AdoHr2acnwsKtGtz
Az7ubjS5zByDuS06h7Co8xt/4TBckm705BulK/cbsVcSEA3wmexeG3UKgMKGL5pQ
UtTbA2Yh6q0v/y0dtOBpcNvmLSnuSpl/+Zpe/r4dLV62v0Q2JYw23Nkp7omm587k
+qckPGvr3Q3QDerYO9Pg8b14UxdLpxLCQtXBulHTKPOcpNZzcpwHsL0663sD/T8+
D9E2gFpNhheyl8UC8VTYoaktgfQK0sf0t5lxhd+Ok/aHS1spwjE3unhYm00RskqT
IDA2F6KNwRRC80gao/bdSqY0zOtH/xdm3JSES137+DluDRrXsHIDGmoKJPx5cuVD
CwIUqw9P18cKF/Kt04neRSxKK9Fhx/UwuCNBLWagsmngr1lJQZnYuytQgKUgg/wV
xw4KGRO2MWjGh6iyzRzH7PmNhvHXscE2Zq5wNcxlZr3kCKfV9SCUfOAYUHbVKG1k
awsP0Jah4+OwIJzzfHIVlvjatgSFTQhcW/4oDQVj+/jKNQcFzQsVbrZ+WbAuHwdw
ZuS2zXzd3AxINF8BLXnQM008PJYymKCTf35sKPcr5BGdPzoLCzQ=
=2RXV
-----END PGP SIGNATURE-----

--Q09JBTuGhH3D3r/m--
