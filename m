From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH] Fix false positives in t3404 due to SHELL=/bin/false
Date: Mon, 27 Dec 2010 02:50:43 +0000
Message-ID: <robbat2-20101227T024837-537032076Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 27 03:57:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PX3HG-0001Dn-Ch
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 03:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995Ab0L0C51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 21:57:27 -0500
Received: from mail.as30085.net ([208.95.172.20]:37636 "EHLO mail.as30085.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535Ab0L0C50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 21:57:26 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Dec 2010 21:57:26 EST
Received: (qmail 6832 invoked from network); 27 Dec 2010 02:50:44 -0000
Received: from tsi-static.orbis-terrarum.net (HELO grubbs.orbis-terrarum.net) (76.10.188.108)
    by mail.as30085.net (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPS; Mon, 27 Dec 2010 02:50:44 +0000
Received: (qmail 9598 invoked by uid 10000); 27 Dec 2010 02:50:43 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164209>


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If the user's shell in NSS passwd is /bin/false (eg as found during Gentoo's
package building), the git-rebase exec tests will fail, because they call
$SHELL around the command, and in the existing testcase, $SHELL was not bei=
ng
cleared sufficently.

This lead to false positive failures of t3404 on systems where the package
build user was locked down as noted above.

Signed-off-by: "Robin H. Johnson" <robbat2@gentoo.org>
X-Gentoo-Bug: 349083
X-Gentoo-Bug-URL: http://bugs.gentoo.org/show_bug.cgi?id=3D349083

diff -Nuar git-1.7.3.4.orig/t/t3404-rebase-interactive.sh git-1.7.3.4/t/t34=
04-rebase-interactive.sh
--- git-1.7.3.4.orig/t/t3404-rebase-interactive.sh	2010-12-16 02:52:11.0000=
00000 +0000
+++ git-1.7.3.4/t/t3404-rebase-interactive.sh	2010-12-26 22:30:47.826421313=
 +0000
@@ -67,8 +67,8 @@
 # "exec" commands are ran with the user shell by default, but this may
 # be non-POSIX. For example, if SHELL=3Dzsh then ">file" doesn't work
 # to create a file. Unseting SHELL avoids such non-portable behavior
-# in tests.
-SHELL=3D
+# in tests. It must be exported for it to take effect where needed.
+export SHELL=3D
=20
 test_expect_success 'rebase -i with the exec command' '
 	git checkout master &&

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAk0X/wMACgkQPpIsIjIzwiwr2gCdEjxAXxEL8UYmZGH1vgliRo7g
kpUAnA+4ayZG/laQayxGBR6AeNw+LAvI
=mG+X
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
