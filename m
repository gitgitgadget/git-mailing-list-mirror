From: Josh Triplett <josh@freedesktop.org>
Subject: [PATCH] git-mergetool: Make default smarter by considering user's
 desktop environment and editor
Date: Tue, 05 Jun 2007 21:28:18 -0700
Message-ID: <466637E2.5040303@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1B4ECCEAEB9B42A54EEAFD5B"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 06:29:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvn8t-0005qc-Cb
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 06:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbXFFE3E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 00:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754053AbXFFE3E
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 00:29:04 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:44047 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbXFFE3B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 00:29:01 -0400
Received: (qmail 9744 invoked from network); 6 Jun 2007 04:29:00 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail4.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 6 Jun 2007 04:29:00 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49243>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1B4ECCEAEB9B42A54EEAFD5B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Make git-mergetool prefer meld under GNOME, and kdiff3 under KDE.  When
considering emerge and vimdiff, check $VISUAL and $EDITOR to see which th=
e
user might prefer.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---

Arguably, kdiff3 should now move down next to meld, below the other
non-graphical tools, so that if the user doesn't run KDE or GNOME they ge=
t a
non-KDE, non-GNOME tool.  This patch doesn't do that, though.

 git-mergetool.sh |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index bb21b03..2053d43 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -304,7 +304,13 @@ if test -z "$merge_tool"; then
 fi
=20
 if test -z "$merge_tool" ; then
-    if type kdiff3 >/dev/null 2>&1 && test -n "$DISPLAY"; then
+    # Try tools that match the user's desktop environment
+    if test x"$KDE_FULL_SESSION" =3D x"true" && type kdiff3 >/dev/null 2=
>&1 && test -n "$DISPLAY"; then
+        merge_tool=3D"kdiff3";
+    elif test x"$GNOME_DESKTOP_SESSION_ID" !=3D x"" && type meld >/dev/n=
ull 2>&1 && test -n "$DISPLAY"; then
+        merge_tool=3Dmeld
+    # Try any graphical tool
+    elif type kdiff3 >/dev/null 2>&1 && test -n "$DISPLAY"; then
 	merge_tool=3D"kdiff3";
     elif type tkdiff >/dev/null 2>&1 && test -n "$DISPLAY"; then
 	merge_tool=3Dtkdiff
@@ -312,6 +318,12 @@ if test -z "$merge_tool" ; then
 	merge_tool=3Dxxdiff
     elif type meld >/dev/null 2>&1 && test -n "$DISPLAY"; then
 	merge_tool=3Dmeld
+    # Try tools specific to the user's editor
+    elif echo "${VISUAL:-$EDITOR}" | grep '^emacs' > /dev/null 2>&1 && t=
ype emacs >/dev/null 2>&1; then
+	merge_tool=3Demerge
+    elif echo "${VISUAL:-$EDITOR}" | grep '^vim' > /dev/null 2>&1 && typ=
e vimdiff >/dev/null 2>&1; then
+	merge_tool=3Dvimdiff
+    # Try other tools
     elif type opendiff >/dev/null 2>&1; then
 	merge_tool=3Dopendiff
     elif type emacs >/dev/null 2>&1; then
--=20
1.5.2.1



--------------enig1B4ECCEAEB9B42A54EEAFD5B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZjfiGJuZRtD+evsRAgZhAJ9f5Eqc8gAHiMaQKibqN1SMOTKK/ACcCd88
HCDfZUxiUxa+IL50FSE2fb8=
=+cxy
-----END PGP SIGNATURE-----

--------------enig1B4ECCEAEB9B42A54EEAFD5B--
