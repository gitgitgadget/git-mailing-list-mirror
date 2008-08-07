From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: On PPC64, the parsing of integers on the commandline is bitshifted.
Date: Thu, 7 Aug 2008 13:31:22 -0700
Message-ID: <20080807203122.GR22707@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mhOzvPhkurUs4vA9"
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 07 22:39:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRCGM-0006w4-C7
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 22:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543AbYHGUiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 16:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754346AbYHGUiH
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 16:38:07 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:38411 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754143AbYHGUiG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 16:38:06 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Aug 2008 16:38:06 EDT
Received: (qmail 5920 invoked from network); 7 Aug 2008 20:31:24 -0000
Received: from S010600022af11287.vc.shawcable.net (HELO curie.orbis-terrarum.net) (24.84.179.214)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Thu, 07 Aug 2008 20:31:24 +0000
Received: (qmail 5529 invoked by uid 10000); 7 Aug 2008 13:31:22 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91605>


--mhOzvPhkurUs4vA9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In a 64-bit userland, big-endian environment, the parser gets integers
wrong.

# ./test-parse-options --set23 |grep integer
integer: 98784247808
# patch ...
# ./test-parse-options --set23 |grep integer
integer: 23

Full failures from the testcases
-integer: 1729
+integer: 7425998454784
-integer: 13
+integer: 55834574848
-integer: 2
+integer: 8589934592
-integer: 23
+integer: 98784247808

All the values are shifted up 32 bits.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>

---
Please CC me in replies, I'm not on git@vger.

Fix against 1.5.6.4:
--- parse-options.c.orig	2008-08-07 14:51:17.000000000 -0500
+++ parse-options.c	2008-08-07 14:51:25.000000000 -0500
@@ -78,7 +78,7 @@
 		return 0;
=20
 	case OPTION_SET_INT:
-		*(int *)opt->value =3D unset ? 0 : opt->defval;
+		*(long int *)opt->value =3D unset ? 0 : opt->defval;
 		return 0;
=20
 	case OPTION_SET_PTR:

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--mhOzvPhkurUs4vA9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkibW5oACgkQPpIsIjIzwizHqgCg8qSkaz91tEiN8NtVUhZ/iWno
FC8AoMC4hNPnDz6zyntky628o5Nhe3hp
=BwEp
-----END PGP SIGNATURE-----

--mhOzvPhkurUs4vA9--
