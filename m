From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 5/7] git-submodule: Extract module_add from cmd_add
Date: Fri, 14 Mar 2008 01:56:39 +0800
Message-ID: <1205431001-18590-6-git-send-email-pkufranky@gmail.com>
References: <1205431001-18590-1-git-send-email-pkufranky@gmail.com>
 <1205431001-18590-2-git-send-email-pkufranky@gmail.com>
 <1205431001-18590-3-git-send-email-pkufranky@gmail.com>
 <1205431001-18590-4-git-send-email-pkufranky@gmail.com>
 <1205431001-18590-5-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 18:58:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZrhE-0002de-3f
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 18:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341AbYCMR45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 13:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754469AbYCMR44
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 13:56:56 -0400
Received: from mail.qikoo.org ([60.28.205.235]:43776 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757126AbYCMR4r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 13:56:47 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 53664470B2; Fri, 14 Mar 2008 01:56:41 +0800 (CST)
X-Mailer: git-send-email 1.5.4.4.653.g7cf1e
In-Reply-To: <1205431001-18590-5-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77116>

cmd_add will later handle the case adding multiple modules, so extract
module_add to add a single module.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   67 +++++++++++++++++++++++++++++++----------------------
 1 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bd2934a..dacd99a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -155,34 +155,7 @@ module_clone()
 #
 # optional branch is stored in global branch variable
 #
-cmd_add()
-{
-	# parse $args after "submodule ... add".
-	while test $# -ne 0
-	do
-		case "$1" in
-		-b | --branch)
-			case "$2" in '') usage ;; esac
-			branch=$2
-			shift
-			;;
-		-q|--quiet)
-			quiet=1
-			;;
-		--)
-			shift
-			break
-			;;
-		-*)
-			usage
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
+module_add() {
 	repo=$1
 	path=$2
 
@@ -226,6 +199,44 @@ cmd_add()
 }
 
 #
+# Add a new submodule to the working tree, .gitmodules and the index
+#
+# $@ = repo [path]
+#
+# optional branch is stored in global branch variable
+#
+cmd_add()
+{
+	# parse $args after "submodule ... add".
+	while test $# -ne 0
+	do
+		case "$1" in
+		-b | --branch)
+			case "$2" in '') usage ;; esac
+			branch=$2
+			shift
+			;;
+		-q|--quiet)
+			quiet=1
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
+	module_add "$1" "$2"
+}
+
+#
 # Register submodules in .git/config
 #
 # $@ = requested paths (default to all)
-- 
1.5.4.4.653.g7cf1e
