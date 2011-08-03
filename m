From: martin f krafft <madduck@madduck.net>
Subject: TopGit with rebased branches, problems with publishing (was: Branch
 dependencies)
Date: Wed, 3 Aug 2011 12:01:56 +0200
Message-ID: <20110803100156.GB27996@fishbowl.rw.madduck.net>
References: <20110801121946.GA575@fishbowl.rw.madduck.net>
 <CAKPyHN0kAJ-MVsrXam5NjsOYkta4nsSrZUvKoMSi-FeRUSuLEw@mail.gmail.com>
 <20110802190806.GA16674@fishbowl.rw.madduck.net>
 <CAKPyHN0EsXMKQ2g7ONaO4yw2ioPbMhg8XCsmB20je=O1DDeE5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
To: Bert Wesarg <bert.wesarg@googlemail.com>,
	git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Aug 03 12:02:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoYHL-0007kc-8d
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 12:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351Ab1HCKCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 06:02:14 -0400
Received: from seamus.madduck.net ([213.203.238.82]:52068 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab1HCKCM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 06:02:12 -0400
Received: from fishbowl.rw.madduck.net (129-204.79-83.cust.bluewin.ch [83.79.204.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id 76377407D3C;
	Wed,  3 Aug 2011 12:01:57 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id 40F4A1FE4C; Wed,  3 Aug 2011 12:01:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAKPyHN0EsXMKQ2g7ONaO4yw2ioPbMhg8XCsmB20je=O1DDeE5Q@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux wheezy/sid kernel 3.0.0-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97.2 at seamus
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178554>


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2011.08.03.0125 +0200=
]:
> >> For my first mentioned problem, I think a new 'system' needs to be
> >> 'rebase' based, not merge based like TopGit.
> >
> > The problem with rebasing is that you cannot publish the branches.
>=20
> That doesn't hold you back to publish them. But the other side need to
> know how to deal with them.
>=20
> Saying that doesn't mean I know a good way to deal with them. I mostly
> end up using plumbing commands to deal with this.

Let me address this in terms of patch queue branches. Obviously, you
are talking topic branches, but wrt rebase-publish, the two are
identical. Patch queue branches are essentially quilt imports, e.g.
one-commit-one-patch, usually edited with git rebase -i (which some
people consider to be the better quilt).

The problem that led me away from patch queue branches is that
=E2=80=94 albeit unlikely in our context (distro packaging) =E2=80=94 it is=
 possible
that you and I both rewrite the patch queue at the same time. The
first one to push will then have his changes overwritten by the
second push =E2=80=94 in order to push the rebased ref,
receive.denyNonFastForwards needs to be off.

Unfortunately, I can't see a remedy to this, apart from tagging each
and every patch queue branch, but that does not solve the problem of
having to merge changes made simultaneously. It could go something
like this:

  1. ensure that noone has pushed an updated ref since you last
     fetched.

  2. if a new ref is found, download it and rebase your own patch
     queue on top of it, consolidating the changes.

  3. tag and push your new ref.

But there's a race condition in this, and so we're back to square
one.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
u=CA=8Dop =C7=9Dp=C4=B1sdn s=C4=B1 =C9=B9o=CA=87=C4=B1uo=C9=AF =C9=B9no=CA=
=8E
=20
spamtraps: madduck.bogus@madduck.net

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJOORyTwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xNaS
D/9k/d6Xkq1isrOpHzvouxZ3oj/Pb2+iZr/Pg8cXo0mwQxAfQszn6HwPaY0D4jcp
iMJGikse3eTCv1SDrM7fU7+pHt3+eUYM0UD06Jb5IBU1sdUXi+d7oblzYQnHUR16
ZbaA0pZjAMdiTQGQLs3QVdgYw75Igfgf48BK8fqgdnIHd3GVDh07H10g1zfI8Zr7
4BwuwhHL20h801n1c/0vExz4YHJLDkJ2Refu/OB+WuEfL6yOLJK7a6oZo7qx+vKZ
o2rb/OE5Rh5tKynziXvNFL5yivG80HUAYTNBtbVVUrLvWz/+Lps9T+YDvF9af55w
iq6HZ96MR0HcKZH2WPXkpRP7YZYefhz8hZkvDVFhug+iVFdWpCXFo1YZX900Zq3H
vRObLHaCyxusBCf2XVbKN9s0E/8IuxbzsHnP5ntDL7QhcTelP+lKKNIx+pU/Joy/
06B8DAA1XUSIshk+SupbGxFUMSLnJb1/mpltEA5J81pWUyZodKZm0YCFdMk9Uz0T
778R8hpmmvXpeh776+n5n7e3mVXSSOt1mX3H22Y0IO4fMw7EyarZyB6h0WowQM+b
+2NXG3Uzdlj4OShcm1CBJMORT8pwdPFNtkXSYDXL1K6DfoM0igriIOsjV12T2o5N
6dNKO9ubGgAYtJA934xMdWXBL/4BBXCpgPCi3Uufjnh6fw==
=BoAh
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
