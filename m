From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH/RFC 4/7] git-submodule: Extract module_add from cmd_add
Date: Thu, 10 Apr 2008 23:50:22 +0800
Message-ID: <1207842625-9210-8-git-send-email-pkufranky@gmail.com>
References: <1207842625-9210-1-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-2-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-3-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-4-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-5-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-6-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-7-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 17:53:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjz4c-0005Y2-IL
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 17:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757595AbYDJPuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 11:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757403AbYDJPur
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 11:50:47 -0400
Received: from mail.qikoo.org ([60.28.205.235]:37790 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757595AbYDJPub (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 11:50:31 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id D2549470B8; Thu, 10 Apr 2008 23:50:25 +0800 (CST)
X-Mailer: git-send-email 1.5.5.23.g2a5f
In-Reply-To: <1207842625-9210-7-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79230>

cmd_add will later handle the case adding multiple modules, so extract
module_add to add a single module.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   67 +++++++++++++++++++++++++++++++----------------------
 1 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index d88e3c3..996bf2c 100755
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
1.5.5.23.g2a5f
