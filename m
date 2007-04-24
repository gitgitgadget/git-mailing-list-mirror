From: Josh Triplett <josh@freedesktop.org>
Subject: [PATCH] Create a sysconfdir variable, and use it for ETC_GITCONFIG
Date: Tue, 24 Apr 2007 00:51:35 -0700
Message-ID: <462DB707.4000008@freedesktop.org>
References: <462D673A.1010805@freedesktop.org>	<7vhcr6bdmk.fsf@assigned-by-dhcp.cox.net>	<462D9938.8020206@freedesktop.org> <7vlkgi9utk.fsf@assigned-by-dhcp.cox.net> <462DB07C.5060500@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF0BFA40FEED8E833DAB0FA17"
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 24 09:52:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgFoy-0005FV-IY
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 09:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161702AbXDXHwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 03:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161703AbXDXHwR
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 03:52:17 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:56583 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161702AbXDXHwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 03:52:16 -0400
Received: (qmail 15467 invoked from network); 24 Apr 2007 07:52:15 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <junkio@cox.net>; 24 Apr 2007 07:52:15 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <462DB07C.5060500@freedesktop.org>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45425>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF0BFA40FEED8E833DAB0FA17
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

ETC_GITCONFIG defaults to $(prefix)/etc/gitconfig, so if you just set
prefix=3D/usr, you end up with a git that looks in /usr/etc/gitconfig, ra=
ther
than /etc/gitconfig as specified by the FHS.  Furthermore, setting
ETC_GITCONFIG does not fix the paths to any future system-wide configurat=
ion
files.

Factor out the path to the system-wide configuration directory into a var=
iable
sysconfdir, normally set to $(prefix)/etc, but set to /etc when prefix=3D=
/usr .
This fixes the prefix=3D/usr problem for ETC_GITCONFIG, and allows centra=
lized
configuration of any future system-wide configuration files without requi=
ring
further action from package maintainers or other people building and
installing git.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 Makefile |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 65bd2db..60c41fd 100644
--- a/Makefile
+++ b/Makefile
@@ -141,7 +141,12 @@ prefix =3D $(HOME)
 bindir =3D $(prefix)/bin
 gitexecdir =3D $(bindir)
 template_dir =3D $(prefix)/share/git-core/templates/
-ETC_GITCONFIG =3D $(prefix)/etc/gitconfig
+ifeq ($(prefix),/usr)
+sysconfdir =3D /etc
+else
+sysconfdir =3D $(prefix)/etc
+endif
+ETC_GITCONFIG =3D $(sysconfdir)/gitconfig
 # DESTDIR=3D
=20
 # default configuration for gitweb
@@ -160,7 +165,7 @@ GITWEB_FAVICON =3D git-favicon.png
 GITWEB_SITE_HEADER =3D
 GITWEB_SITE_FOOTER =3D
=20
-export prefix bindir gitexecdir template_dir
+export prefix bindir gitexecdir template_dir sysconfdir
=20
 CC =3D gcc
 AR =3D ar
--=20
1.5.1.1



--------------enigF0BFA40FEED8E833DAB0FA17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLbcHGJuZRtD+evsRAhgAAKCKfgHC7W6tC2Mk2SR8yS3QeoHTsACfTc1r
KHyH8M7O0hHmvQr/iZEcGNY=
=KVoc
-----END PGP SIGNATURE-----

--------------enigF0BFA40FEED8E833DAB0FA17--
