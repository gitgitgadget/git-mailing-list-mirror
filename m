From: Ed Schouten <ed@fxq.nl>
Subject: Patch for Makefile - LIBMD_SHA1: -lmd on FreeBSD
Date: Tue, 10 Jul 2007 15:19:06 +0200
Message-ID: <20070710131906.GC55449@hoeg.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 15:29:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8FmO-0006mT-Rp
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 15:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbXGJN3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 09:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbXGJN3W
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 09:29:22 -0400
Received: from mx0.hoeg.nl ([83.98.131.211]:50069 "EHLO palm.hoeg.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750929AbXGJN3V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 09:29:21 -0400
X-Greylist: delayed 612 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Jul 2007 09:29:21 EDT
Received: by palm.hoeg.nl (Postfix, from userid 1000)
	id D60741CD03; Tue, 10 Jul 2007 15:19:06 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52065>


--Km1U/tdNT/EmXiR1
Content-Type: multipart/mixed; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Once in a while I send in some patches to the FreeBSD folks for the
devel/git port. I just wrote a patch for Git that makes it possible to
link it against the FreeBSD Message Digest library (libmd), removing the
dependency on OpenSSL.

The patch adds the switch LIBMD_SHA1. When set, it just uses sha.h and
-lmd. I've also added proper documentation to the top of the Makefile.

Yours,
--=20
 Ed Schouten <ed@fxq.nl>
 WWW: http://g-rave.nl/

--qjNfmADvan18RZcF
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="git-libmd.diff"
Content-Transfer-Encoding: quoted-printable

--- Makefile	2007-07-10 15:16:03.000000000 +0200
+++ Makefile	2007-07-10 15:17:31.000000000 +0200
@@ -55,6 +55,9 @@
 # specify your own (or DarwinPort's) include directories and
 # library directories by defining CFLAGS and LDFLAGS appropriately.
 #
+# Define LIBMD_SHA1 environment variable when running make to make use
+# of FreeBSD's libmd SHA1 routines.
+#
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
@@ -637,6 +640,10 @@
 	BASIC_CFLAGS +=3D -DOLD_ICONV
 endif
=20
+ifdef LIBMD_SHA1
+	SHA1_HEADER =3D "sha.h"
+	EXTLIBS +=3D -lmd
+else
 ifdef PPC_SHA1
 	SHA1_HEADER =3D "ppc/sha1.h"
 	LIB_OBJS +=3D ppc/sha1.o ppc/sha1ppc.o
@@ -654,6 +661,7 @@
 endif
 endif
 endif
+endif
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif

--qjNfmADvan18RZcF--

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (FreeBSD)

iD8DBQFGk4dK52SDGA2eCwURAuBcAJ4vfU6jpHNMprsLNq659MUF3nSEFACfRYBn
wIljohSzNtc7sIE/l7JumRc=
=/QGA
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--
