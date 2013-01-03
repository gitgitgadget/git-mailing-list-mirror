From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: [RFH] NetBSD 6?
Date: Wed, 02 Jan 2013 19:25:25 -0500
Message-ID: <rmiy5gbun7u.fsf@fnord.ir.bbn.com>
References: <7vd2xn18p5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 01:25:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqYcz-0002fg-A4
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 01:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025Ab3ACAZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 19:25:27 -0500
Received: from fnord.ir.bbn.com ([192.1.100.210]:64852 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853Ab3ACAZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 19:25:26 -0500
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 971BCA7B8; Wed,  2 Jan 2013 19:25:25 -0500 (EST)
OpenPGP: id=32611E25
X-Hashcash: 1:20:130102:git@vger.kernel.org::hBTk7JRwN/k/Zgy9:0000000000000000000000000000000000000000000Mfs
X-Hashcash: 1:20:130102:gitster@pobox.com::hBTk7JRwN/k/Zgy9:000000000000000000000000000000000000000000001cun
In-Reply-To: <7vd2xn18p5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 02 Jan 2013 15:11:50 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212564>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Junio C Hamano <gitster@pobox.com> writes:

> [query about NetBSD-6]=20

> The "2.7" bit certainly looks fishy, as users should be able to
> choose between "2.6" and "2.7" (and possibly "3.0"), IIUC.
>
> +	PYTHON_PATH =3D /usr/pkg/bin/python2.7
> +	PERL_PATH =3D /usr/pkg/bin/perl

(I am one of the people who maintain the git package in pkgsrc.)

(Strictly, this is not really about NetBSD, but about all systems where
the standard approach to get python is via pkgsrc.  So that include
DragonflyBSD as well.  (pkgsrc runs on many other systems, but it isn't
the standard approach, so from the git viewpoint that's irrelevant.))

You are entirely right that on e.g. NetBSD 6 the view is that users
should be able to choose the python version.

pkgsrc can install multiple versions of python at the same time, to cope
with python-using packages that need different versions.  pkgsrc chooses
not to have a 'python' program, because that would result in installed
packages changing their binding of which python version to use when the
default was changed.  The default python version is currently 2.7, so
/usr/pkg/bin/python2.7 is the best guess for finding python on a NetBSD
system, if you're only allowed one guess.  A user can set a
PYTHON_VERSION_DEFAULT variable to choose the version they want; each
package expresses which versions will work.

This isn't relevant for git, not being a pure python library, but pkgsrc
supports installing multiple versions of some packages, so one can have
two versions installed at once:
  py27-expat-0nb6     Python interface to expat
  py26-expat-0nb6     Python interface to expat
The git package just depends on one version; by default the git package
depends on python (but one can tell it not to).

The python.m4 macro that comes with automake seems to find one of the
various pythonX.Y binaries in $PATH just fine.

pkgsrc has an entry for git (at 1.8.0.1).
The key line for handling python is:
  MAKE_FLAGS+=3D	PYTHON_PATH=3D${PYTHONBIN}
and there PYTHONBIN is set up by pkgsrc infrastructure for the right
prefix (99.9% but not always /usr/pkg) and version.  After this,
everything seems to come out right:

  > head -1 /usr/pkg/libexec/git-core/git-p4
  #!/usr/pkg/bin/python2.7

So I'd say that if PYTHON_PATH is set in the environment to configure,
it should behave as it does now.  And if not, it would be nice if the
highest pythonX.Y found (that is known to work with git) is used.

> +	PYTHON_PATH =3D /usr/pkg/bin/python2.7
> +	PERL_PATH =3D /usr/pkg/bin/perl

So it would be nice to make these work as ?=3D, letting an environment
variable win if set.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iEYEARECAAYFAlDkz/UACgkQ+vesoDJhHiUy8gCeNotFuC4OVvvn62xvw1J16tJP
y1wAnAizMaIyzlfV59kmgw/9Gy9T8CL9
=sLg6
-----END PGP SIGNATURE-----
--=-=-=--
