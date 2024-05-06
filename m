Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D6915B11F
	for <git@vger.kernel.org>; Mon,  6 May 2024 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715037099; cv=none; b=VddDNvcsBAFylEPw7mepAlf3oIfL4fKdC6V5Cgn3xLx8Job4qjtn7PNY2GoDF86480hVaYkRiH6epj0X9UOayotBkOyLhAntASXtuHU0iJvYGLVCykrwDRELHTTJc2GE9xRUWToZIvmOahjrT86mCjUAQ50CWnLOWBwMAdstS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715037099; c=relaxed/simple;
	bh=P8yiBCtNQxiHV9Pe6ALMI9QPyAva87Pwlkg72sC2KFE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tdCNqzKgMolopoXO46uFFAUyxTrke+lsXpHoeuTY28IwQ/4ZDDD2atm2FKgcDpQbhesslDfx3wG6D/3euxwh2koqgLdEswBTeF7fs3EBzNyHz944yA66iqJxDLvJwRSb8Z41nC6rCOsenHgAvx3zFX9SNoYQ8V1m6gqqKJhSN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 0046C343170
	for <git@vger.kernel.org>; Mon,  6 May 2024 23:11:38 +0000 (UTC)
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	by grubbs.orbis-terrarum.net (Postfix) with ESMTP id 7339F260320
	for <git@vger.kernel.org>; Mon,  6 May 2024 23:11:37 +0000 (UTC)
Received: (qmail 1030725 invoked by uid 10000); 6 May 2024 23:11:37 -0000
Date: Mon, 6 May 2024 23:11:37 +0000
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: Git Mailing List <git@vger.kernel.org>
Subject: Feature request: secondary index by path fragment
Message-ID: <robbat2-20240506T225759-090424131Z@orbis-terrarum.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vIMyLQIe6KCQmex7"
Content-Disposition: inline


--vIMyLQIe6KCQmex7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Maybe this already happens in the code, but if not, please consider it
as a feature request.

Gentoo has some tooling that boils down to repeated runs of 'git log -- som=
epath/'
via cgit as well as other shell tooling.

If the path is relatively deep for the tree (e.g. to a specific file or
sub-directory), the size of history [1] makes that a very slow operation
to go all the way back to the initial repo commit: ~12 seconds per
operation on fast hardware, ~45 seconds on slower harder - even with the
packs cached.

I was wondering if Git could gain a secondary index of commits, based on
path prefixes, that would speed up the 'git log' run.

It would need to be fast to append to the secondary index, because
Gentoo gets a steady flow of commits 24/7.

[1] 825k+ commits based on GitHub stats.

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation President & Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--vIMyLQIe6KCQmex7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAmY5Y6dfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsQLxg//cviWD4aSQQ2F7BLGPQaKYuCOCyA6d7kdscithb7VG7R3+jxnwgpBiVwv
mNa+E/UHPX8cpJkALesLIehlqTgT1WJRgyyFpKOlSeZbg8s3nkM2ADzvlh0ztlLZ
TypThc95mcYMiBS2lA4UPEu8bssJmR4aP2aPg59VnGYubHOWKELJL47+7nDEQZus
+ONLcsYi9CROyM8VKWjv8wZfnmY3+Z0vzn9zNQ7yZpIRJojrx/rUo+bG6dfRhsIG
+jw1yG90uQHBSYVZB5xS/8lsPwQ79AMonHt5VAWB0LJ6GFWc2Or3mBvfyzg132S/
NajkmB+mivF45uY8J5mhbfp/Rw5+u/B1XWs0hDYEIeS+dIhRjUlqIxe0nhEIEXWW
Ti3X4XcC4loXYdm1b3boz241kSGqCx+0ZwR9oXPR9FofT79Uz7oRxGUh1pM4rOFQ
UvVoQVOGEdIsfr153h9pK+Q5dbjz3LxL14+7vSwOIz3UfMPb4atjzfK5+HtY8snj
krIT/6DlzGcSimoxDZUnhXj2nM6ARbQVVOY/bFf0fA5Nrd7tLqBjS3No+wg29sQ/
/mhwG+03q0LIBPCkspunVQnj/6ox23SS2IQW15+xzepnCrw0x5Hy1amkRBziZsm4
yyi4ARpdUWKa0h1vIDB+YCtxybMMuZj5HLO6t2gIASHY5qtprtI=
=ZhyL
-----END PGP SIGNATURE-----

--vIMyLQIe6KCQmex7--
