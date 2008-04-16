From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 4/7] git-submodule: Extract module_add from cmd_add
Date: Wed, 16 Apr 2008 22:19:34 +0800
Message-ID: <1208355577-8734-5-git-send-email-pkufranky@gmail.com>
References: <1208355577-8734-1-git-send-email-pkufranky@gmail.com>
 <1208355577-8734-2-git-send-email-pkufranky@gmail.com>
 <1208355577-8734-3-git-send-email-pkufranky@gmail.com>
 <1208355577-8734-4-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 16:31:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm8VK-00050Q-DP
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 16:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbYDPOT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 10:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755966AbYDPOTo
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 10:19:44 -0400
Received: from mail.qikoo.org ([60.28.205.235]:52423 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754435AbYDPOTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 10:19:42 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 49365470B1; Wed, 16 Apr 2008 22:19:37 +0800 (CST)
X-Mailer: git-send-email 1.5.5.70.gd68a
In-Reply-To: <1208355577-8734-4-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79707>

cmd_add will later handle the case adding multiple modules, so extract
module_add to add a single module.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   67 +++++++++++++++++++++++++++++++----------------------
 1 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2276f6b..f3a1213 100755
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
1.5.5.70.gd68a
