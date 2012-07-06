From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 06/12] git-remote-mediawiki: support for uploading file in test environment
Date: Fri,  6 Jul 2012 12:03:09 +0200
Message-ID: <1341568995-12467-7-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqhatl9t4a.fsf@bauges.imag.fr>
 <1341568995-12467-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>,
	Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>,
	Guillaume SASDY <Guillaume.Sasdy@ensimag.imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 06 12:04:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn5Ow-0007Qq-UA
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 12:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654Ab2GFKEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 06:04:33 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60807 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756542Ab2GFKEc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 06:04:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q66A2Wld008032
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Jul 2012 12:02:32 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sn5O6-0003Tn-8d; Fri, 06 Jul 2012 12:03:46 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sn5O6-0003HL-77; Fri, 06 Jul 2012 12:03:46 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
In-Reply-To: <1341568995-12467-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 06 Jul 2012 12:02:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q66A2Wld008032
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342173753.70311@yhZmhkd123VVJhbPw0Fp6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will be used for testing git-remote-mediawiki's import feature on a
wiki containing media files.

Signed-off-by: Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>
Signed-off-by: Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>
Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
Signed-off-by: Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>
Signed-off-by: Guillaume SASDY <Guillaume.Sasdy@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/t/install-wiki/LocalSettings.php |  3 ++-
 contrib/mw-to-git/t/test-gitmw-lib.sh              |  3 +++
 contrib/mw-to-git/t/test-gitmw.pl                  | 16 ++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/t/install-wiki/LocalSettings.php b/contrib/mw-to-git/t/install-wiki/LocalSettings.php
index aa72518..29f1251 100644
--- a/contrib/mw-to-git/t/install-wiki/LocalSettings.php
+++ b/contrib/mw-to-git/t/install-wiki/LocalSettings.php
@@ -67,9 +67,10 @@ $wgMemCachedServers = array();
 
 ## To enable image uploads, make sure the 'images' directory
 ## is writable, then set this to true:
-$wgEnableUploads  = false;
+$wgEnableUploads  = true;
 $wgUseImageMagick = true;
 $wgImageMagickConvertCommand ="@CONVERT@";
+$wgFileExtensions[] = 'txt';
 
 # InstantCommons allows wiki to use images from http://commons.wikimedia.org
 $wgUseInstantCommons  = false;
diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/t/test-gitmw-lib.sh
index 14f6577..3b2cfac 100755
--- a/contrib/mw-to-git/t/test-gitmw-lib.sh
+++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
@@ -26,6 +26,9 @@ else
 	WIKI_DIR_INST="$CURR_DIR/$WEB_WWW"
 fi
 
+wiki_upload_file () {
+	"$CURR_DIR"/test-gitmw.pl upload_file "$@"
+}
 
 wiki_getpage () {
 	"$CURR_DIR"/test-gitmw.pl get_page "$@"
diff --git a/contrib/mw-to-git/t/test-gitmw.pl b/contrib/mw-to-git/t/test-gitmw.pl
index b0117e2..0ff7625 100755
--- a/contrib/mw-to-git/t/test-gitmw.pl
+++ b/contrib/mw-to-git/t/test-gitmw.pl
@@ -193,6 +193,21 @@ sub wiki_getallpagename {
 	}
 }
 
+sub wiki_upload_file {
+	my $file_name = $_[0];
+	my $resultat = $mw->edit ( {
+		action => 'upload',
+		filename => $file_name,
+		comment => 'upload a file',
+		file => [ $file_name ],
+		ignorewarnings=>1,
+	}, {
+		skip_encoding => 1
+	} ) || die $mw->{error}->{code} . ' : ' . $mw->{error}->{details};
+}
+
+
+
 # Main part of this script: parse the command line arguments
 # and select which function to execute
 my $fct_to_call = shift;
@@ -200,6 +215,7 @@ my $fct_to_call = shift;
 wiki_login($wiki_admin, $wiki_admin_pass);
 
 my %functions_to_call = qw(
+	upload_file    wiki_upload_file
 	get_page       wiki_getpage
 	delete_page    wiki_delete_page
 	edit_page      wiki_editpage
-- 
1.7.11.1.147.g47a574d
