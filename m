From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] git-remote-mediawiki: allow stop/start-ing the test server
Date: Wed, 23 Apr 2014 16:34:28 +0200
Message-ID: <1398263669-16594-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 23 16:35:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcyGF-0007XZ-EQ
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 16:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756556AbaDWOet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 10:34:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43513 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753179AbaDWOep (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 10:34:45 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3NEYbCN007994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Apr 2014 16:34:37 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3NEYdJa029108;
	Wed, 23 Apr 2014 16:34:39 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1WcyFz-0004KM-8U; Wed, 23 Apr 2014 16:34:39 +0200
X-Mailer: git-send-email 1.9.2.667.ge5b74e1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 23 Apr 2014 16:34:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3NEYbCN007994
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1398868479.94592@iXZjqn8GiLa7sdkQ4bdbCw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246843>

Previously, the user had to launch a complete re-install after a lighttpd
stop (e.g. a reboot).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/t/install-wiki.sh   | 10 ++++++++++
 contrib/mw-to-git/t/test-gitmw-lib.sh |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/t/install-wiki.sh b/contrib/mw-to-git/t/install-wiki.sh
index 70a53f6..c215213 100755
--- a/contrib/mw-to-git/t/install-wiki.sh
+++ b/contrib/mw-to-git/t/install-wiki.sh
@@ -20,6 +20,8 @@ usage () {
 	echo "		install | -i :	Install a wiki on your computer."
 	echo "		delete | -d : Delete the wiki and all its pages and "
 	echo "			content."
+	echo "		start  | -s : Start the previously configured lighttpd daemon"
+	echo "		stop        : Stop lighttpd daemon."
 }
 
 
@@ -33,6 +35,14 @@ case "$1" in
 		wiki_delete
 		exit 0
 		;;
+	"start" | "-s")
+		start_lighttpd
+		exit
+		;;
+	"stop")
+		stop_lighttpd
+		exit
+		;;
 	"--help" | "-h")
 		usage
 		exit 0
diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/t/test-gitmw-lib.sh
index 3372b2a..d9a1149 100755
--- a/contrib/mw-to-git/t/test-gitmw-lib.sh
+++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
@@ -289,7 +289,6 @@ start_lighttpd () {
 # Kill daemon lighttpd and removes files and folders associated.
 stop_lighttpd () {
 	test -f "$WEB_TMP/pid" && kill $(cat "$WEB_TMP/pid")
-	rm -rf "$WEB"
 }
 
 # Create the SQLite database of the MediaWiki. If the database file already
@@ -415,6 +414,7 @@ wiki_reset () {
 wiki_delete () {
 	if test $LIGHTTPD = "true"; then
 		stop_lighttpd
+		rm -fr "$WEB"
 	else
 		# Delete the wiki's directory.
 		rm -rf "$WIKI_DIR_INST/$WIKI_DIR_NAME" ||
-- 
1.9.2.667.ge5b74e1
