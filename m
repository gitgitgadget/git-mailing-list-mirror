From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH] git-remote-mediawiki: display message when launched directly
Date: Tue, 11 Jun 2013 15:38:48 +0200
Message-ID: <1370957928-19303-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 11 15:39:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmOn5-0003tn-9m
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 15:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318Ab3FKNjJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 09:39:09 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35927 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170Ab3FKNjD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 09:39:03 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5BDd0qv019181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Jun 2013 15:39:00 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5BDd2Ug015213;
	Tue, 11 Jun 2013 15:39:02 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5BDd1V5029651;
	Tue, 11 Jun 2013 15:39:01 +0200
X-Mailer: git-send-email 1.7.9.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 11 Jun 2013 15:39:00 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227438>

Users may be confused when they run the perl script directly.
A good way to detect this is to check the number of parameters used to =
call the
script, which is never different from 2 in a normal use.
Display a proper error message to avoid any confusion.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 9c14c1f..9b71972 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -41,6 +41,10 @@ use constant NULL_SHA1 =3D> "00000000000000000000000=
00000000000000000";
 # Used on Git's side to reflect empty edit messages on the wiki
 use constant EMPTY_MESSAGE =3D> '*Empty MediaWiki Message*';
=20
+if (@ARGV !=3D 2) {
+	exit_error_usage();
+}
+
 my $remotename =3D $ARGV[0];
 my $url =3D $ARGV[1];
=20
@@ -156,6 +160,17 @@ while (<STDIN>) {
=20
 ########################## Functions ##############################
=20
+## error handling
+sub exit_error_usage {
+	die "ERROR: git-remote-mediawiki module was not called with a correct=
 number of\n" .
+	    "parameters\n" .
+	    "You may obtain this error because you attempted to run the git-r=
emote-mediawiki\n" .
+            "module directly.\n" .
+	    "This module can be used the following way:\n" .
+	    "\tgit clone mediawiki://<address of a mediawiki>\n" .
+	    "Then, use git commit, push and pull as with every normal git rep=
ository.\n";
+}
+
 ## credential API management (generic functions)
=20
 sub credential_read {
--=20
1.7.9.5
