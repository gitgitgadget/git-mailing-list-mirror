From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Looking for pre-commit hook to check whitespace errors but not for
 all files
Date: Sat, 14 Dec 2013 16:28:14 +0100
Message-ID: <1387034894.4636.9.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-mtSoHcCNUlnNlmqGAqP7"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 17:12:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrrpT-00008a-Uc
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 17:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858Ab3LNQMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Dec 2013 11:12:24 -0500
Received: from mail.gw90.de ([188.40.100.199]:44387 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753758Ab3LNQMX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 11:12:23 -0500
X-Greylist: delayed 2625 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Dec 2013 11:12:22 EST
Received: from [185.9.224.23] (helo=[192.168.1.8])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1Vrr8s-0004nI-E4
	for git@vger.kernel.org; Sat, 14 Dec 2013 15:28:34 +0000
X-Mailer: Evolution 3.4.4-4+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239310>


--=-mtSoHcCNUlnNlmqGAqP7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear git folks,


in coreboot we try to check for whitespace errors before committing. Of
course a pre-commit hook is the way to go, but unfortunately it is not
so simple (at least for me) as the following requirements exist.

1. Only the files actually committed should be checked. That means
running `git commit -a`, abort that and then running `git commit
some/file` should only check `some/file` for whitespace errors.

2. There are certain files that are allowed to have whitespace errors.
In our case these are `*.patch` and `*.diff` files which by design seem
to contain whitespace error.

Currently the whole tree is checked, which takes a lot of time [1].

I tried to come up with a patch [2], but failed so far. Best would be to
have

    $ git diff --check --only-committed-files --exclude "*patch$"

where I could not find a way for the last to switches.

Currently, I would use

    $ git diff-index --cached --name-only $against -- | grep -v patch$

and pass that list to some whitespace check program. Unfortunately that
still does not fulfill the first requirement.

What am I missing to solve this elegantly?


Thanks,

Paul


[1] http://review.coreboot.org/gitweb?p=3Dcoreboot.git;a=3Dblob;f=3Dutil/li=
nt/lint-stable-003-whitespace;h=3D1e824a1e76e37ce641b91c75f2f78e0e2abfd37f;=
hb=3DHEAD
[2] http://review.coreboot.org/#/c/3340/

--=-mtSoHcCNUlnNlmqGAqP7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iEYEABECAAYFAlKseQ4ACgkQPX1aK2wOHVg+0gCfTAc56UyTpoJ5q7b52kH+MBgk
DJgAn0BUYWBwV73hsB6xvMHy0tMlJ8iq
=uYxC
-----END PGP SIGNATURE-----

--=-mtSoHcCNUlnNlmqGAqP7--
