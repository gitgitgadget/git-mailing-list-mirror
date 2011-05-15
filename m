From: Hermann Gausterer <git-mailinglist@mrq1.org>
Subject: [PATCH] add-interactive: shortcut for add hunk and quit
Date: Sun, 15 May 2011 14:55:25 +0200
Message-ID: <20110515125525.GA3014@mrq1.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Cc: Hermann Gausterer <git-mailinglist@mrq1.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 15:02:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLaxc-00055D-LF
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 15:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759453Ab1EONCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 09:02:11 -0400
Received: from nat-warsl417-02.aon.at ([195.3.96.120]:30698 "EHLO email.aon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756445Ab1EONCK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 09:02:10 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 May 2011 09:02:10 EDT
Received: (qmail 28222 invoked from network); 15 May 2011 12:55:27 -0000
Received: from smarthub95.highway.telekom.at (HELO email.aon.at) ([172.18.5.234])
          (envelope-sender <git-mailinglist@mrq1.org>)
          by fallback44.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 15 May 2011 12:55:27 -0000
Received: (qmail 11242 invoked from network); 15 May 2011 12:55:25 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL503.highway.telekom.at
X-Spam-Level: 
Received: from 80-123-45-171.adsl.highway.telekom.at (HELO mrq1.org) ([80.123.45.171])
          (envelope-sender <git-mailinglist@mrq1.org>)
          by smarthub95.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 15 May 2011 12:55:25 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173632>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

combines the two commands "y"+"q" to one.
i use this if i know that this is the last hunk to add.

Signed-off-by: Hermann Gausterer <git-git-2011@mrq1.org>
---
 Documentation/git-add.txt |    1 +
 git-add--interactive.perl |   15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 9c1d395..76ffd45 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -280,6 +280,7 @@ patch::
        y - stage this hunk
        n - do not stage this hunk
        q - quit; do not stage this hunk nor any of the remaining ones
+       Q - quit; stage this hunk but none of the remaining ones
        a - stage this hunk and all later hunks in the file
        d - do not stage this hunk nor any of the later hunks in the file
        g - select a hunk to go to
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 4f08fe7..db79556 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1123,6 +1123,7 @@ sub help_patch_cmd {
 y - $verb this hunk$target
 n - do not $verb this hunk$target
 q - quit; do not $verb this hunk nor any of the remaining ones
+Q - quit; $verb this hunk but none of the remaining ones
 a - $verb this hunk and all later hunks in the file
 d - do not $verb this hunk nor any of the later hunks in the file
 g - select a hunk to go to
@@ -1313,7 +1314,7 @@ sub patch_update_file {
 		   $hunk[$ix]{TYPE} eq 'deletion' ? ' deletion' :
 		   ' this hunk'),
 		  $patch_mode_flavour{TARGET},
-		  " [y,n,q,a,d,/$other,?]? ";
+		  " [y,n,q,Q,a,d,/$other,?]? ";
 		my $line =3D prompt_single_character;
 		if ($line) {
 			if ($line =3D~ /^y/i) {
@@ -1365,7 +1366,17 @@ sub patch_update_file {
 				}
 				next;
 			}
-			elsif ($line =3D~ /^q/i) {
+			elsif ($line =3D~ /^q/) {
+				for ($i =3D 0; $i < $num; $i++) {
+					if (!defined $hunk[$i]{USE}) {
+						$hunk[$i]{USE} =3D 0;
+					}
+				}
+				$quit =3D 1;
+				last;
+			}
+			elsif ($line =3D~ /^Q/) {
+				$hunk[$ix]{USE} =3D 1;
 				for ($i =3D 0; $i < $num; $i++) {
 					if (!defined $hunk[$i]{USE}) {
 						$hunk[$i]{USE} =3D 0;
--=20
1.7.0.4


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFNz809AdCXZ1Xu7u4RAiyEAKCUq37MxRt5UfemxZ8VSsRICrFGqQCg5xqG
1qzXhAFMNyDGLdncE8QAC04=
=uMk6
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
