From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/5] git p4 test: move client_view() function to library
Date: Sat, 11 Aug 2012 12:55:00 -0400
Message-ID: <1344704104-17727-1-git-send-email-pw@padd.com>
References: <20120811165143.GA2004@padd.com>
Cc: Matthew Korich <matthew@korich.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 18:55:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0Ey3-0000Xu-RN
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 18:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188Ab2HKQzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Aug 2012 12:55:10 -0400
Received: from honk.padd.com ([74.3.171.149]:50669 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab2HKQzK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 12:55:10 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 63A91D27;
	Sat, 11 Aug 2012 09:55:09 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 17AAE5A90C; Sat, 11 Aug 2012 12:55:04 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.2.329.ga84ed21
In-Reply-To: <20120811165143.GA2004@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203290>

This code will be useful in --detect-branches --use-client-spec tests.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh               | 18 ++++++++++++++++++
 t/t9809-git-p4-client-view.sh | 17 -----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 2d753ab..5c952d6 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -115,3 +115,21 @@ marshal_dump() {
 	EOF
 	"$PYTHON_PATH" "$TRASH_DIRECTORY/marshal-dump.py"
 }
+
+#
+# Construct a client with this list of View lines
+#
+client_view() {
+	(
+		cat <<-EOF &&
+		Client: client
+		Description: client
+		Root: $cli
+		View:
+		EOF
+		for arg ; do
+			printf "\t$arg\n"
+		done
+	) | p4 client -i
+}
+
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index 7d993ef..281be29 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -9,23 +9,6 @@ test_expect_success 'start p4d' '
 '
 
 #
-# Construct a client with this list of View lines
-#
-client_view() {
-	(
-		cat <<-EOF &&
-		Client: client
-		Description: client
-		Root: $cli
-		View:
-		EOF
-		for arg ; do
-			printf "\t$arg\n"
-		done
-	) | p4 client -i
-}
-
-#
 # Verify these files exist, exactly.  Caller creates
 # a list of files in file "files".
 #
-- 
1.7.12.rc2.24.gc304662
