From: Sascha Peilicke <saschpe@gmx.de>
Subject: [PATCH] No color diff when redirecting to file
Date: Sun, 23 Jan 2011 14:10:35 +0100
Message-ID: <201101231410.48528.saschpe@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2224792.9T0aNWUUSr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 23 14:11:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgzjE-0007y7-SX
	for gcvg-git-2@lo.gmane.org; Sun, 23 Jan 2011 14:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289Ab1AWNLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jan 2011 08:11:31 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:54031 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751092Ab1AWNLb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jan 2011 08:11:31 -0500
Received: (qmail invoked by alias); 23 Jan 2011 13:11:29 -0000
Received: from 77-22-178-49-dynip.superkabel.de (EHLO festor.localnet) [77.22.178.49]
  by mail.gmx.net (mp007) with SMTP; 23 Jan 2011 14:11:29 +0100
X-Authenticated: #30943063
X-Provags-ID: V01U2FsdGVkX18mVhtulOEm9ifwvs9GaD2Qj4u/TLPhDdwy3kFD55
	M8Tpw//4TOmuqG
User-Agent: KMail/1.13.5 (Linux/2.6.37-18-desktop; KDE/4.5.95; x86_64; ; )
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165424>

--nextPart2224792.9T0aNWUUSr
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Previously, when having color diffs enabled and redirecting 'git diff'
into a file, one ends up with a messed up file containing termcap color
stuff. This change disables color when diff output is redirected into a
file.

Signed-off-by: Sascha Peilicke <saschpe@gmx.de>
=2D--
 diff.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 5422c43..cd1ecb0 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -2854,6 +2854,11 @@ void diff_setup(struct diff_options *options)
 		DIFF_OPT_SET(options, COLOR_DIFF);
 	options->detect_rename =3D diff_detect_rename_default;
=20
+	struct stat buf;
+	if (fstat(fileno(options->file), &buf) !=3D -1 && S_ISREG(buf.st_mode)) {
+		DIFF_OPT_CLR(options, COLOR_DIFF);
+	}
+
 	if (diff_no_prefix) {
 		options->a_prefix =3D options->b_prefix =3D "";
 	} else if (!diff_mnemonic_prefix) {
=2D-=20
1.7.3.4

=2D-=20
Mit freundlichen Gr=FC=DFen,
Sascha Peilicke
http://saschpe.wordpress.com

--nextPart2224792.9T0aNWUUSr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAk08KNgACgkQDq/ykSrZt1WXlACgyd9j2zeog/wIkIEunCwKhDl9
J4wAn1JdPv6xPjQV21/Xsg39Ph/2GaBD
=ZhWu
-----END PGP SIGNATURE-----

--nextPart2224792.9T0aNWUUSr--
