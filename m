From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH 10/18] Put long code into a submodule
Date: Thu,  6 Jun 2013 21:34:15 +0200
Message-ID: <1370547263-13558-11-git-send-email-celestin.matte@ensimag.fr>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 21:35:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukfxw-00015n-ER
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 21:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab3FFTfK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 15:35:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44529 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753561Ab3FFTfB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 15:35:01 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r56JYsuV031915
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Jun 2013 21:34:56 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r56JYvmV021421;
	Thu, 6 Jun 2013 21:34:57 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r56JYTox023108;
	Thu, 6 Jun 2013 21:34:56 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 06 Jun 2013 21:34:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r56JYsuV031915
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371152097.21816@vvKE/1QiwN2T1jnBVSGEDw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226540>

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |   44 ++++++++++++++++---=
--------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 1c34ada..1271527 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -133,24 +133,7 @@ while (<STDIN>) {
 	@cmd =3D split(/ /);
 	if (defined($cmd[0])) {
 		# Line not blank
-		if ($cmd[0] eq "capabilities") {
-			die("Too many arguments for capabilities\n") if (defined($cmd[1]));
-			mw_capabilities();
-		} elsif ($cmd[0] eq "list") {
-			die("Too many arguments for list\n") if (defined($cmd[2]));
-			mw_list($cmd[1]);
-		} elsif ($cmd[0] eq "import") {
-			die("Invalid arguments for import\n") if ($cmd[1] eq "" || defined(=
$cmd[2]));
-			mw_import($cmd[1]);
-		} elsif ($cmd[0] eq "option") {
-			die("Too many arguments for option\n") if ($cmd[1] eq "" || $cmd[2]=
 eq "" || defined($cmd[3]));
-			mw_option($cmd[1],$cmd[2]);
-		} elsif ($cmd[0] eq "push") {
-			mw_push($cmd[1]);
-		} else {
-			print STDERR "Unknown command. Aborting...\n";
-			last;
-		}
+		parse_commands();
 	} else {
 		# blank line: we should terminate
 		last;
@@ -168,6 +151,31 @@ sub exit_error_usage {
     die "ERROR: git-remote-mediawiki module was not called with a corr=
ect number of parameters\n";
 }
=20
+sub parse_commands {
+	if ($cmd[0] eq "capabilities") {
+		die("Too many arguments for capabilities\n")
+		    if (defined($cmd[1]));
+		mw_capabilities();
+	} elsif ($cmd[0] eq "list") {
+		die("Too many arguments for list\n") if (defined($cmd[2]));
+		mw_list($cmd[1]);
+	} elsif ($cmd[0] eq "import") {
+		die("Invalid arguments for import\n")
+		    if ($cmd[1] eq "" || defined($cmd[2]));
+		mw_import($cmd[1]);
+	} elsif ($cmd[0] eq "option") {
+		die("Too many arguments for option\n")
+		    if ($cmd[1] eq "" || $cmd[2] eq "" || defined($cmd[3]));
+		mw_option($cmd[1],$cmd[2]);
+	} elsif ($cmd[0] eq "push") {
+		mw_push($cmd[1]);
+	} else {
+		print STDERR "Unknown command. Aborting...\n";
+		last;
+	}
+	return;
+}
+
 # MediaWiki API instance, created lazily.
 my $mediawiki;
=20
--=20
1.7.9.5
