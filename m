From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 01/10] t9400, t9401: Do not force hard-linked clone
Date: Wed, 18 Mar 2009 22:27:03 +0100
Message-ID: <7fd3ef1fd73dffdb9b3445893ab579723ce08e74.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:28:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk3Jk-0004j4-VB
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbZCRV11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754334AbZCRV1Y
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:27:24 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46767 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbZCRV1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:27:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 88CC52C4004;
	Wed, 18 Mar 2009 22:27:17 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 588AA60C30;
	Wed, 18 Mar 2009 22:27:17 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113673>

The tests do not depend on that the clones are hard-linked, but used
--local only as an optimization: At the time that --local was used first
in t9400 hard-linked clones were not the default, yet.

By removing --local, we help filesystems that do not support hard-links.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t9400-git-cvsserver-server.sh |    4 ++--
 t/t9401-git-cvsserver-crlf.sh   |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 6a37f71..9ccb123 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -44,7 +44,7 @@ test_expect_success 'setup' '
   git add secondrootfile &&
   git commit -m "second root") &&
   git pull secondroot master &&
-  git clone -q --local --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
+  git clone -q --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
   GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
   GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log"
 '
@@ -267,7 +267,7 @@ test_expect_success 'gitcvs.ext.dbname' \
 
 rm -fr "$SERVERDIR"
 cd "$WORKDIR" &&
-git clone -q --local --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
+git clone -q --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
 GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
 GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log" ||
 exit 1
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index e27a1c5..5d6200c 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -84,7 +84,7 @@ test_expect_success 'setup' '
     echo "subdir/file.h crlf" >> .gitattributes &&
     git add .gitattributes textfile.c binfile.bin mixedUp.c subdir/* &&
     git commit -q -m "First Commit" &&
-    git clone -q --local --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
+    git clone -q --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
     GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
     GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log"
 '
-- 
1.6.2.1.224.g2225f
