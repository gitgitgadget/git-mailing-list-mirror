Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA211D1F5B
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354896; cv=none; b=NLYD+9kpBwUmeBE0JucAwLgYM3VTATXGvXooyLUr/m+kSnAuklof4TMeuV6m2p7zxg72DKhr9vevcaeSuI2bLEmBPZz3mVkq3yA6JEOJARTCXMXTG3i7m2nuefZMRk9hiLzzefnXe8tEGUijce9fohZ8SyTmpQBtamFmLdntvM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354896; c=relaxed/simple;
	bh=rTMpMZgx6zf6lOZWPpOaMcxs8vm0P1LVBcYVZk0s8MY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KV3JLRpjJ01JF1XFERiO2epp01jnLP/KTlfjE9yI+eAtTSUWPSseY9rCuTUNGBOnrE99B8aq/JKkzE2e9K/V+Q4CtSJ5BOCTeULyUqfwyQ60lYVe5ngV5t+nxOtQ/jiJoD8Olb0cZ/AcfmgqOJS7fjHbIFlJF4lQ9KZxRoEa9Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ncts@debian.org>)
	id 1shDTa-002rdR-14; Thu, 22 Aug 2024 21:28:06 +0200
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ncts@debian.org>)
	id 1shDTZ-0005bX-IP; Thu, 22 Aug 2024 21:28:05 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1415192)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1shDTA-00H1WV-Ay; Thu, 22 Aug 2024 21:27:40 +0200
Date: Fri, 23 Aug 2024 03:27:31 +0800
From: Blair Noctis <ncts@debian.org>
To: Simon Richter <sjr@debian.org>
Cc: git@vger.kernel.org, debian-devel@lists.debian.org
Subject: Re: Representing Debian Metadata in Git
Message-ID: <5b59d9f0-74a2-418c-acd7-ff1ecbfea467@sail.ng>
In-Reply-To: <eb963843-9e2c-49f2-911f-fa36f33f9bfd@debian.org>
References: <eb963843-9e2c-49f2-911f-fa36f33f9bfd@debian.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0bcZ22_YkbXenx30LmTK5aF";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/0bcZ22_YkbXenx30LmTK5aF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2024-08-20 15:10, Simon Richter wrote:
(...)
> Right now, git is used mainly as a network file system, and only tagged=20
> releases are expected to be consistent enough to compile, because often=20
> going from one consistent state to another as an atomic operation would=20
> require multiple changes to be applied in the same commit.
>=20
> The imported archive is represented either directly as a tree (which may=
=20
> be imported from the upstream project if no files are undistributable=20
> for Debian), or via a mechanism that can reproduce a compressed archive=20
> that is bitwise identical to the upstream release, from a tree and some=20
> additional patch data.
>=20
> The patch stack is stored as a set of patches inside a directory, and=20
> rebased using quilt.
>=20
> An alternate representation stores the patch stack as a branch that is=20
> rebased using git, and then exported to single files.
>=20
> The Debian changelog is stored as a file inside Git, but some automation=
=20
> exists to update this from Git commit messages.
>=20
> Debian changelog entries refer to bugs in the Debian Bug Tracking=20
> system. There is a desire to also incorporate forges (currently, GitLab)=
=20
> and refer to the forges' issue tracker from commit messages (where the=20
> issue tracker is used for team collaboration, while the Debian BTS is=20
> used for user-visible bugs).
>=20
> All of this is very silly, because we're essentially storing metadata as=
=20
> data because we cannot express in Git what we're actually doing, and the=
=20
> conflicting priorities people have have led to conflicting solutions.
>=20
> I'd like to xkcd 927 this now, and find a common mapping.

Here's my very likely very naive 2 cents: we are basically maintaining a=20
fork for each non-native package.

Being a fork, a "Debianized" package can also live like other "upstream"=20
forks: with its own branch based on the original, make necessary changes
and record them as commits; merge original onto its own branch, dealing
with conflicts; maintain its own changelog; rinse and repeat.

Debian-specific metadata can be represented structurally in commit=20
messages, or if necessary, (still) in a plain debian/ subdirectory that
won't conflict with upstream.

Then,

>  From a requirements perspective, I'd like to be able to
>=20
>  =C2=A0- express patches as commits:
>  =C2=A0=C2=A0 - allow cherry-picking upstream commits as Debian patches
>  =C2=A0=C2=A0 - allow cherry-picking Debian patches for upstream submissi=
on
>  =C2=A0- generate the Debian changelog from changes committed to Git
>  =C2=A0- express filter steps for generating the upstream archive(s) from=
 a=20
> tree=E2=80=91ish and some metadata
>  =C2=A0- store upstream signatures inside Git
>  =C2=A0- keep a history of patches, including patches applied to previous=
ly=20
> released packages

these are naturally met; and

(...)
> Changes to packaging would still be represented as commit objects=20
> containing a tree, but that tree would contain a special entry for the=20
> "debian" subdirectory that points to the last packaging change.

no more needed.

> This is very high-level so far, because I'd like to get some feedback=20
> first on whether it makes sense to pursue this further.This would use=20
> up the last unused three-bit object type in Git, so it will have to be=20
> very generic on this side to not block future development -- and it=20
> would require a lot of design effort on the Debian side as well to=20
> hammer out the details.

Even less thought out, but probably easier to implement once the design=20
is finished. ;)

--=20
Sdrager,
Blair Noctis


--Sig_/0bcZ22_YkbXenx30LmTK5aF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQScTWEJ927Sl0a/hB7sV97Kb1Pv6QUCZseRJAAKCRDsV97Kb1Pv
6bxqAQCF6gpaGD2XdPUp63vA0VsAH1/9VgUOxtexgVtx7WznlAD/U4sJBltfuJah
onBfOcv8IfAn/J2pe7bRAJsYRhvJ9Qo=
=NCuz
-----END PGP SIGNATURE-----

--Sig_/0bcZ22_YkbXenx30LmTK5aF--
