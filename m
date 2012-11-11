From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Sun, 11 Nov 2012 10:00:48 -0500
Message-ID: <20121111150047.GA22608@odin.tremily.us>
References: <cover.1352431674.git.wking@tremily.us>
 <fb2d915cf60160c200b84df88c6112c1c2d4eefd.1352431674.git.wking@tremily.us>
 <7v390jqlep.fsf@alter.siamese.dyndns.org> <20121110184437.GC2739@mjolnir>
 <7vzk2oo2d2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=gBBFr7Ir9EOA20Yy
Cc: Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 16:02:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXZ3X-0007b6-Ez
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 16:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879Ab2KKPAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 10:00:53 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:60813 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535Ab2KKPAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 10:00:52 -0500
Received: from odin.tremily.us ([unknown] [72.68.100.219])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MDB00D1ZWDCQD50@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 11 Nov 2012 09:00:49 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 21A4D690B43; Sun,
 11 Nov 2012 10:00:48 -0500 (EST)
Content-disposition: inline
In-reply-to: <7vzk2oo2d2.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209390>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 11, 2012 at 02:33:45AM -0800, Junio C Hamano wrote:
> The change seems to think "branch" is the _only_ thing the user
> might want to record per submodule upon "git submodule add".

I felt that earlier floating/tracking submodule patches were biting
off more than they could chew, so I was looking for a lightweight fix
to make the tracking workflow easier.  It seems like I ended up with
something that is too lightweight ;).

> On the other hand, if this were one small part of a series to define
> the "tip following mode" where (at least)
>=20
>  (1) "git submodule update [$path]" makes sure that the checkout of
>      the submodule at $path matches the commit at the tip of the
>      branch named by submodule.$name.branch in .gitmodules of the
>      superproject, instead of the commit that is recorded in the
>      index of the superproject; and

As I mentioned earlier, I think

  $ git submodule update [$path]

should keep its current =E2=80=9Ccheckout the already-registered SHA=E2=80=
=9D
functionality, with

  $ git submodule update --pull [$path]

pulling the tracked branch.  I'll add a patch implementing this to v4.

In order to avoid losing (or creating) local-only submodule commits,
I'll probably bail (with an error) on non-fast-forward pulls.  Can
anyone else think of other safety concerns?

This means that I'll probably drop Phil's $submodule_* export in v4,
because the only explicit use we have for it is this branch tracking.
I still think it is a useful idea, but it may not be useful enough to
be worth the complexity.

>  (2) "git diff [$path]" and friends in the superproject compares the
>      HEAD of the checkout of the submodule at $path with the tip of
>      the branch named by submodule.$name.branch in .gitmodules of
>      the superproject, instead of the commit that is recorded in the
>      index of the superproject.
>=20

Hmm.  =E2=80=9Cgit diff=E2=80=9D compares the working tree with the local H=
EAD (just a
SHA for submodules), so I don't think it should care about the status
of a remote branch.  This sounds like you want something like:

  $ git submodule foreach 'git diff origin/$submodule_branch'

Perhaps this is enough motivation for keeping $submodule_* exports?

> and the option were called something like "--follow-branch=3D$branch",
> =E2=80=A6

I'll replace -r/--record with --follow-branch in v4.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQn72dAAoJEEUbTsx0l5OM9o4P/0qQ5F3tSWPHlZdkk1LdsTHj
It5xbdD34m676q1uT8hptTtzUOVDKsKvistYPEX5X4M/34K1/UEuqKbxVyU+7iv3
tKNcUx3chvqK6NSxHvrI9Z1bbDFaZYNWJuErfkoFU1UnTGrgQZtsgQe8iSlUbNV9
TWs40bnaLHJLCa+UHV3qRXyjxs4D/bhCLmaZa8PKJ6ACGvaw0eeqQ44dbV15VxM+
Ev2e/V31n3CGbupmye+0s0mMAyvIsdASDBpnq7dzSdu6pukHfHY4ZzFibIQslAnp
jXlVbUjVS609PCAtKucy8JrplzKsUlAkpSvfd6RHYAq92DVMxl4pwAfohDHWz2BT
+MkcZOHKlqvP9StSMVzS9R1mLN0wv0w2ct9gfPHi8m+bZUEsZQ9XypoASxWlBnCZ
s+xs4aVpJIGMjX/PPCXySLg7g+qDUHxzfAF40EDgp6VBpYZ1PGQE3OQs1pWd92u2
mYdaMiGJWD4QnMhZM+WZeWaTE/Ro/MAUx2+dU0Z9fzxuRwhg1aO6fmV2uCXmz+rq
GdHt3HgSxzYtkoNEguvyLV3PcjfTkjWPMxx6Q/qzz0VOzGwmJmZ2GD1Z2b9U1DTK
atKhQPnfb2X6tIuJ/NM/cGixtCMF0GBIYv6S6KCi6PCsBxnJQ3JhW1om6sH0742m
SMYw8oO4s2KqZdxmFcbL
=eJ+v
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
