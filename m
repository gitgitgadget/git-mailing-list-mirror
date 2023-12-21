Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090526E5B6
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="foFsN+ds"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 09EE35B166;
	Thu, 21 Dec 2023 12:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1703161348;
	bh=0GlkImtSegBYmIjNqd6EKxkZ0lUhSPiNMehRMHFW3F4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=foFsN+dsfGofrF/oIFnOpcJ53cQcARyug4dBWN9c6t1fqEjiWMGZ7yQmNtMvw58U4
	 bjuTyvMlwIhWIfWJNeuOmFnOMOMYx3dxVu1eyczZEXKhfBymiD/I2C70fpcaMjt855
	 W0wzEfwhDumJsPbZEEJx/+474zn/PGurLJjDOLn4XH3Ba3Op7BUjRL6Trjg5gOGLir
	 SVwhGWt8r5fKp9U1dhE6hNvjOSK3aP0MqboH3QnfM5I4mC84NZhjo7GD5yzh2nDX9K
	 HB09F7swIGGGpVTTDFo0istrZkYLUoSqpqzl6P0RRPUCapXfaom7rQiVqu1xTZOu//
	 cASS8XhXnC3hgvFIR5HCrciwPeUXsThntjNnk6azuHYd4MOgJRroyi5Fh5V360CN35
	 KCXycv4Wdk8E7Cw4UgdmWJ74QAmU1QVqifS9uxgZMsbw4p6y6rvGgEqxpQ0JzARB40
	 4a6FxAkmL/NaE3QRHs2ZdTVsMV3cB6qZet2jsLF+ejkZ8P4yOTN
Date: Thu, 21 Dec 2023 12:22:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Devste Devste <devstemail@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git bisect stuck - --force flag required for checkout
Message-ID: <ZYQuAjNjCzSy4X6Z@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Devste Devste <devstemail@gmail.com>, git@vger.kernel.org
References: <CANM0SV3SEF28QJ2V0Q9ydp8yDbL8TDc1m871oxOB=UtwF1TtxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bVG1L6RzGAV/wKxm"
Content-Disposition: inline
In-Reply-To: <CANM0SV3SEF28QJ2V0Q9ydp8yDbL8TDc1m871oxOB=UtwF1TtxQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--bVG1L6RzGAV/wKxm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-12-21 at 10:47:57, Devste Devste wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
> add file Foo.txt to .git and commit
> add some commits with any changes to other files, as this is needed
> for reproduction
> run: git config core.ignorecase false

`core.ignorecase` is specifically designed for this case.  It's set
internally by Git when the repository is created, and it's not supposed
to be changed by the user.

If you want a repository where there's no case sensitivity, then I'd
recommend WSL.  It's also possible to make some directories case
sensitive in Windows 10 and newer and allegedly that works recursively,
so you could use `fsutil` to do that, then run `git init`, then add
data.

> rename Foo.txt to foo.txt and commit
> add some commits with any changes to other files, as this is needed
> for reproduction
> run: git bisect start && git bisect bad
> eventually, when running "git bisect good" (or bad) you will get an error:
> >error: The following untracked working tree files would be overwritten b=
y checkout:
> >Foo.php
>=20
> Anything else you want to add:
> git bisect good/bad needs to have support for a "--force" flag, which
> is passed to the git checkout it runs internally
> At the moment git bisect cannot be used on Windows, as there is no way
> to continue the bisect from here.
> Changing the "git config core.ignorecase true" temporarily is not an
> option, as this will introduce a variety of other bugs,
> which, on Windows, eventually will require you to completely delete
> and reclone the repo, as Windows file paths are case-insensitive

Could you share what those problems are?  `core.ignorecase` is
specifically designed to deal with case-insensitive file systems, and
that's why Git sets it to true.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--bVG1L6RzGAV/wKxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZYQuAgAKCRB8DEliiIei
gSGxAQCobxwQOWIEkC4CsA2UJiVXAodUZk1Kb8mSc0+krOHiuAEAsCN9yUfxCc8O
9s+mdu3fMi2aFKlV75FjPwkYikkQ9AY=
=ERml
-----END PGP SIGNATURE-----

--bVG1L6RzGAV/wKxm--
