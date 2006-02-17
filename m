From: Carl Worth <cworth@cworth.org>
Subject: [PATCH 2/3] Abstract test_create_repo out for use in tests.
Date: Fri, 17 Feb 2006 13:33:26 -0800
Message-ID: <1140212006127-git-send-email-cworth@cworth.org>
References: <11402120042011-git-send-email-cworth@cworth.org>
Reply-To: Carl Worth <cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Fri Feb 17 22:34:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FADFF-0002yM-57
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 22:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030651AbWBQVeZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 16:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWBQVeZ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 16:34:25 -0500
Received: from theworths.org ([217.160.253.102]:31702 "EHLO theworths.org")
	by vger.kernel.org with ESMTP id S1751437AbWBQVeY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2006 16:34:24 -0500
Received: (qmail 15648 invoked from network); 17 Feb 2006 16:34:23 -0500
Received: from localhost (HELO raht) (127.0.0.1)
  by localhost with SMTP; 17 Feb 2006 16:34:23 -0500
In-Reply-To: <11402120042011-git-send-email-cworth@cworth.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16369>

Signed-off-by: Carl Worth <cworth@cworth.org>


---

 t/test-lib.sh |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

6110a439c2b1962c6f128cdaac3a2ee8450ac22c
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7a58a86..66f62b9 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -149,6 +149,21 @@ test_expect_code () {
 	fi
 }
 
+# Most tests can use the created repository, but some amy need to create more.
+# Usage: test_create_repo <directory>
+test_create_repo () {
+	test "$#" = 1 ||
+	error "bug in the test script: not 1 parameter to test-create-repo"
+	owd=`pwd`
+	repo="$1"
+	mkdir "$repo"
+	cd "$repo" || error "Cannot setup test environment"
+	"$GIT_EXEC_PATH/git" init-db --template=$GIT_EXEC_PATH/templates/blt/ 2>/dev/null ||
+	error "cannot run git init-db -- have you built things yet?"
+	mv .git/hooks .git/hooks-disabled
+	cd "$owd"
+}
+	
 test_done () {
 	trap - exit
 	case "$test_failure" in
@@ -196,9 +211,5 @@ test -d ../templates/blt || {
 # Test repository
 test=trash
 rm -fr "$test"
-mkdir "$test"
-cd "$test" || error "Cannot setup test environment"
-"$GIT_EXEC_PATH/git" init-db --template=../../templates/blt/ 2>/dev/null ||
-error "cannot run git init-db -- have you built things yet?"
-
-mv .git/hooks .git/hooks-disabled
+test_create_repo $test
+cd "$test"
-- 
1.2.0.gf6e8
