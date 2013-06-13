From: benoit.person@ensimag.fr
Subject: [PATCH] git-remote-mediawiki: remove hardcoded version number in the test suite
Date: Thu, 13 Jun 2013 13:30:08 +0200
Message-ID: <1371123008-28068-1-git-send-email-benoit.person@ensimag.fr>
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Benoit Person <benoit.person@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 13 13:30:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un5jm-00022A-5J
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 13:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674Ab3FMLai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 07:30:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44746 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab3FMLah (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 07:30:37 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5DBUY77003691
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Jun 2013 13:30:34 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5DBUaJZ011897;
	Thu, 13 Jun 2013 13:30:36 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5DBUZS2004968;
	Thu, 13 Jun 2013 13:30:35 +0200
X-Mailer: git-send-email 1.8.3.GIT
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 13 Jun 2013 13:30:34 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227719>

From: Benoit Person <benoit.person@ensimag.fr>

Updates the code to make it more easy to switch mediawiki version when
testing. Before that, the version number was partly hardcoded, partly
in a var.

Maybe I should add a warning that the installation procedure may not work 
in the future ? It seems to work for the range 1.19.X - 1.21.X though :) ?
Should I also update the version number to the latest one (1.21.1) ?

Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>

---
 contrib/mw-to-git/t/test-gitmw-lib.sh | 19 ++++++++++---------
 contrib/mw-to-git/t/test.config       |  3 ++-
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/t/test-gitmw-lib.sh
index 3b2cfac..bb76cee 100755
--- a/contrib/mw-to-git/t/test-gitmw-lib.sh
+++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
@@ -336,20 +336,21 @@ wiki_install () {
 	fi
 
 	# Fetch MediaWiki's archive if not already present in the TMP directory
+	MW_FILENAME="mediawiki-$MW_VERSION_MAJOR.$MW_VERSION_MINOR.tar.gz"
 	cd "$TMP"
-	if [ ! -f "$MW_VERSION.tar.gz" ] ; then
-		echo "Downloading $MW_VERSION sources ..."
-		wget "http://download.wikimedia.org/mediawiki/1.19/mediawiki-1.19.0.tar.gz" ||
+	if [ ! -f $MW_FILENAME ] ; then
+		echo "Downloading $MW_VERSION_MAJOR.$MW_VERSION_MINOR sources ..."
+		wget "http://download.wikimedia.org/mediawiki/$MW_VERSION_MAJOR/$MW_FILENAME" ||
 			error "Unable to download "\
-			"http://download.wikimedia.org/mediawiki/1.19/"\
-			"mediawiki-1.19.0.tar.gz. "\
+			"http://download.wikimedia.org/mediawiki/$MW_VERSION_MAJOR/"\
+			"$MW_FILENAME. "\
 			"Please fix your connection and launch the script again."
-		echo "$MW_VERSION.tar.gz downloaded in `pwd`. "\
+		echo "$MW_FILENAME downloaded in `pwd`. "\
 			"You can delete it later if you want."
 	else
-		echo "Reusing existing $MW_VERSION.tar.gz downloaded in `pwd`."
+		echo "Reusing existing $MW_FILENAME downloaded in `pwd`."
 	fi
-	archive_abs_path=$(pwd)/"$MW_VERSION.tar.gz"
+	archive_abs_path=$(pwd)/$MW_FILENAME
 	cd "$WIKI_DIR_INST/$WIKI_DIR_NAME/" ||
 		error "can't cd to $WIKI_DIR_INST/$WIKI_DIR_NAME/"
 	tar xzf "$archive_abs_path" --strip-components=1 ||
@@ -431,5 +432,5 @@ wiki_delete () {
 	# Delete the wiki's SQLite database
 	rm -f "$TMP/$DB_FILE" || error "Database $TMP/$DB_FILE could not be deleted."
 	rm -f "$FILES_FOLDER/$DB_FILE"
-	rm -rf "$TMP/$MW_VERSION"
+	rm -rf "$TMP/mediawiki-$MW_VERSION_MAJOR.$MW_VERSION_MINOR.tar.gz"
 }
diff --git a/contrib/mw-to-git/t/test.config b/contrib/mw-to-git/t/test.config
index 958b37b..f835dcc 100644
--- a/contrib/mw-to-git/t/test.config
+++ b/contrib/mw-to-git/t/test.config
@@ -30,6 +30,7 @@ WEB_WWW=$WEB/www
 
 # The variables below are used by the script to install a wiki.
 # You should not modify these unless you are modifying the script itself.
-MW_VERSION=mediawiki-1.19.0
+MW_VERSION_MAJOR=1.20
+MW_VERSION_MINOR=0
 FILES_FOLDER=install-wiki
 DB_INSTALL_SCRIPT=db_install.php
-- 
1.8.3.GIT
