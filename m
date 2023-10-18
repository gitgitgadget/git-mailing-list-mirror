Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06037143
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 22:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uEOnKXOk"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBB2121
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 15:26:53 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 082CC5B088;
	Wed, 18 Oct 2023 22:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1697668013;
	bh=1uLYNIuu978EXVUgnxPSiSTuUyNHleYNpolbY2Q7AE0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uEOnKXOkX0v2Zb+x2cwBwLFE4jOQVQ5t0hjHPDuaFbpeeOOX7QVjjZbUG4cPvsWHw
	 PxQHB70cHlaOrt04uInvxKyKhWIooQyCaIq0BE9Oyw+3PzvFC8R1q3v09aeitShdp8
	 xuDUxtQ4ton+5gUB6z12y+CZVtIYCz2eCtQYu88pjyZ2CeDOXHexkqkQSG4zwzKD3b
	 bfogYM7d5la3rygajHwYYwYh5ue52OPh09hEQtm+fCrWGsU3v9b+jqmN+UP/wlXG2K
	 y/ncU3W8GpF+/HIQjyav8kC05SsxryrwnUzwEywvzj6ivvK9jzUSzGxoEiJLPkJjs4
	 2V99Q4Ym7bokZ8jP0FZY342DyKZ6k4hCBPNyPqgmuXbqY3ujZ8tWk7agAaoYy2jOX6
	 KvcHxUzs0/cX5CtKoMygOi4GD4U+Rf+s9UE2UtVTy4mrbS2Z6rfThiBK6kPE4sJXGI
	 AftGB5JC2xy28hOx+ZqRPJPzNfdftrHO6doHs9/5fXxKdlHd6px
Date: Wed, 18 Oct 2023 22:26:50 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Matthew McClain <mmcclain@noprivs.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-p4 shouldn't attempt to store symlinks in LFS
Message-ID: <ZTBbqobbqQpxHPI2@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Matthew McClain <mmcclain@noprivs.com>, git@vger.kernel.org
References: <20231018185854.857674-1-mmcclain@noprivs.com>
 <xmqqil73sp8l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UaXToLXBQ0mr80wZ"
Content-Disposition: inline
In-Reply-To: <xmqqil73sp8l.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--UaXToLXBQ0mr80wZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-18 at 19:30:02, Junio C Hamano wrote:
> Matthew McClain <mmcclain@noprivs.com> writes:
>=20
> > If a symlink in your Perforce repository matches
> > git-p4.largeFileExtensions, git-p4.py will attempt to put the symlink in
> > LFS but will blow up when it passes a string to generateTempFile.
> >
> > Git LFS normal behavior does not stash symlinks in LFS.
>=20
> I am not a "git p4" (or "git lfs") user, but if nobody uses LFS to
> store symbolic links (which is very much understandable given what
> it was invented for), then that alone is a good enough reason to
> avoid the regular blob codepath, and that is true even if
> generateTempFile accepted a str and silently converted it to bytes
> to help callers, no?

Git LFS doesn't store symlinks because smudge/clean filters don't handle
symlinks.  They never get passed to the filter process nor the
smudge/clean filters, nor could that occur without a change to the
protocol or command-line interface.  Unless Git learned how to send them
to the filters, Git LFS would have a hard time using them in any useful
way.

Also, for Git LFS, whose goal is to move large files out of the
repository history, symlinks are typically not an interesting thing to
process because they are functionally limited to 4 KiB or a similar size
on most systems.

> So "but will blow up ..." and the stacktrace below are more or less
> irrelevant details and do not help convince readers why this change
> is desirable.  I'd suggest removing it (and perhaps place more stress
> on explaining why storing symbolic links in LFS is a bad practice
> nobody uses, but if it is so obvious perhaps the single sentence
> explanation you have above would be sufficient).

Hopefully my explanation above can be part of that commit message.

> I know I can ask brian to take a look at this change from LFS angle,
> but who's authoritatively reviewing "git p4" related changes these
> days (Matthew, this is not a question for you, but to the list)?

It looks fine to me from an LFS angle, but I know nothing about Perforce
or git-p4.

Also, as a minor request, it would be great if you could continue to
email me at my personal address, since that's the address with which I
read the list.  My work address appearing on series is more of a
reflection that I'm more frequently finding time to work on things on
work time (hence the work address) versus personal time (where I'd be
using my personal email for patches).  I've fixed it up above.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--UaXToLXBQ0mr80wZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZTBbqQAKCRB8DEliiIei
gYgBAP90DKfdDOBENFhD6gFDt/l/YKTmgiAcS/9bzbN/IuGXmgD+Jzgozc4AQKet
hsUyaJLHFG5z+29lHvGWaIQ5tJYQ0w4=
=RT6L
-----END PGP SIGNATURE-----

--UaXToLXBQ0mr80wZ--
