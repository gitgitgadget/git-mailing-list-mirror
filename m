Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DEAC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 06:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A68E863218
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 06:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhKPGeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 01:34:50 -0500
Received: from woodpecker.gentoo.org ([140.211.166.183]:33370 "EHLO
        smtp.gentoo.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhKPGb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 01:31:27 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 4F0BE342E8F
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 06:28:29 +0000 (UTC)
Received: (qmail 3040 invoked by uid 10000); 16 Nov 2021 06:28:28 -0000
Date:   Tue, 16 Nov 2021 06:28:28 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [BUG] git push --mirror ignores refs outside head & tags
Message-ID: <robbat2-20211116T061554-223495439Z@orbis-terrarum.net>
Reply-To: git@vger.kernel.org, robbat2@gentoo.org
References: <robbat2-20211115T063838-612792475Z@orbis-terrarum.net>
 <YZLLUtPVQt2XtgQX@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="As+smY+wYrmGLmLX"
Content-Disposition: inline
In-Reply-To: <YZLLUtPVQt2XtgQX@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--As+smY+wYrmGLmLX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 15, 2021 at 04:04:18PM -0500, Jeff King wrote:
> On Mon, Nov 15, 2021 at 06:53:21AM +0000, Robin H. Johnson wrote:
>=20
> > TL;DR: "git push --mirror" does not in fact push all refs, despite
> > documentation stating it does. It ONLY pushes refs in refs/heads/ and
> > refs/tags/.
>=20
> Perhaps there's a bug, but it is meant to and does push all refs in a
> simple case:
=2E..
> There I used an explicit refspec naming it. But if I used "refs/*"
> (which is what --mirror is doing under the hood), then it doesn't even
> try sending it, as the client filters it out from the wildcard
> (otherwise, everyone would get server-side errors from refs/stash).
>=20
> So you probably want to choose a different refname to store your data.
>=20
> I do think the status of these single-level refs is not well documented.
> The rules in git-check-ref-format(1) imply that they are not valid:
Ok, that's great, but this single-level ref have been in existence for
many years at this point. Gitolite added the save-push-signatures hook
in 2014.

- What is a meaningful name for the push-certs ref that follows the
  2-level system?
- What's a safe migration path for Gitolite?
  - How can it atomically fix each existing repo with the problem?
- What's a safe migration path for other consumers?

>=20
>   They must contain at least one /. This enforces the presence of a
>   category like heads/, tags/ etc. but the actual names are not
>   restricted.
>=20
> but that rule is not enforced internally, as "refs/" is sufficient for
> the internal check_refname_format() to allow it. But receive-pack has,
> since 1a7141ff28 (Ignore funny refname sent from remote, 2005-10-13),
> implemented the format check after stripping refs/. And then the client
> side followed that lead in 30affa1e9a (send-pack: do not send out
> single-level refs such as refs/stash, 2008-10-29).

And the format of the ref wasn't noticed in the hook was previously
posted back in 2014 :-(.
https://www.spinics.net/lists/git/msg244053.html
https://groups.google.com/forum/#!topic/gitolite/7cSrU6JorEY

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--As+smY+wYrmGLmLX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAmGTT4tfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsTWcg//UnvOPfYLBvt+FodOONeQTE+Sm7fhxAUHpLIHMT+ninOArUZ3OhB2Ts8c
ZLaHt0zvsmrb6OezG4IQwrNOA/jquyVLY7DE4u7NUjJp4yQr69fPykfIux9+LhcB
4xUOmlWo04fLU2MbDH1UdiNYWHeMnzqKkyMzhPIqme+L928hLvQbiLUP6iRLr0W2
0Iq6X7hpk1SDBpq7jSUWd2VlzTB4JWLsYqsrugZvVf1f4xXadfIbLcgtab80FYEQ
VfL5OsdQg4PYvYH8WyrOCrr3j3DZwmqg2cUMqOsWgm4eSoPxxsln4YLdPDht+rse
yEk94DcdjVN7n7jH3MnEAEeleaz3MD4z2WnSwUcZW+JJiirktmCUH9vmzldLzAEt
gnu4xa1ABohmn1vgvj1/QWFC9+xsDYWCI/C/HoI3/74LnUriiCkRHyOpb1PM+1pl
5t5JvYG/fNzWjdDWcFQLdHq9Y72tEqNUQWgSZyhVrpzjbh6ydWck4DdJZYMSrGt0
sxAEZKOVeBIJr8FmSJ//NS7q7Ac4oCvQ/fB3pTAsIZBglaPbv7BC9ngyED6F9SuR
tXI1mKq6NR2Og1n5GOT+K7eQO5NeHpZ1TDzZqHY0vYSdhnDNine6opETz4U2KRO1
Iv9jFGHRA7OypryJVHLwNUX2t9jTcHKzUjAdjApLKx2tc3uw6Cg=
=TYZt
-----END PGP SIGNATURE-----

--As+smY+wYrmGLmLX--
