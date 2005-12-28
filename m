From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] fix skipping merge-order test with NO_OPENSSL=1.
Date: Wed, 28 Dec 2005 12:25:38 +0100
Message-ID: <20051228112538.20197.qmail@0e359e924d9d3e.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 28 12:25:30 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErZQp-0001UC-HR
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 12:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVL1LZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Dec 2005 06:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVL1LZU
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Dec 2005 06:25:20 -0500
Received: from a.mx.smarden.org ([212.21.76.77]:45490 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S964788AbVL1LZT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Dec 2005 06:25:19 -0500
Received: (qmail 20198 invoked by uid 1000); 28 Dec 2005 11:25:38 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14097>

Hi, when building git with NO_OPENSSL=1, the rev-list-merge-order
selftests fail.  Moving the check for 'OpenSSL not linked' in the usage
output to after test no 1 and fixing the syntax works for me.

Regards, Gerrit.


* move git-rev-list --merge-order usage check for 'OpenSSL not linked' after
  test 1.

Signed-off-by: Gerrit Pape <pape@smarden.org>

---

 t/t6001-rev-list-merge-order.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

635cc4875b6bd8b6afb80742c7927ef4233ec562
diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
index 8ec9ebb..2f3c6f8 100755
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -8,13 +8,6 @@ test_description='Tests git-rev-list --m
 . ./test-lib.sh
 . ../t6000lib.sh # t6xxx specific functions
 
-if git-rev-list --merge-order 2>&1 | grep 'OpenSSL not linked' >/dev/null
-then
-    test_expect_success 'skipping merge-order test' :
-    test_done
-    exit
-fi    
-
 # test-case specific test function
 check_adjacency()
 {
@@ -114,6 +107,13 @@ test_expect_success 'rev-list has correc
 19
 EOF
 
+if git-rev-list --merge-order HEAD 2>&1 | grep 'OpenSSL not linked' >/dev/null
+then
+    test_expect_success 'skipping merge-order test' :
+    test_done
+    exit
+fi
+
 normal_adjacency_count=$(git-rev-list HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
 merge_order_adjacency_count=$(git-rev-list --merge-order HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
 test_expect_success '--merge-order produces as many or fewer discontinuities' '[ $merge_order_adjacency_count -le $normal_adjacency_count ]'
-- 
1.0.3
