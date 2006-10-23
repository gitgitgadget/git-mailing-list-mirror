From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Fix regression tests on Cygwin
Date: Mon, 23 Oct 2006 21:34:33 +0200
Message-ID: <11616320733093-git-send-email-hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 23 21:35:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc5ZL-0001yh-R7
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 21:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbWJWTek (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 15:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbWJWTek
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 15:34:40 -0400
Received: from mail42.e.nsc.no ([193.213.115.42]:57599 "EHLO mail42.e.nsc.no")
	by vger.kernel.org with ESMTP id S1751851AbWJWTek (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 15:34:40 -0400
Received: from localhost.localdomain (ti231210a080-7372.bb.online.no [80.213.28.208])
	by mail42.nsc.no (8.13.8/8.13.5) with ESMTP id k9NJYa5P023581
	for <git@vger.kernel.org>; Mon, 23 Oct 2006 21:34:38 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.3.1.g1688
Date: Mon, 23 Oct 2006 21:01:50 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29868>

On Cygwin, "make test" failes due to missing ".exe" a couple of places.

This fixes it, in a somewhat ugly way....

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 t/t0000-basic.sh |    9 ++++++++-
 t/test-lib.sh    |   10 +++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 2c9bbb5..41d53be 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -25,7 +25,14 @@ # or have too old python without subproc
 # out before running any tests.  Also catch the bogosity of trying
 # to run tests without building while we are at it.
 
-../git >/dev/null
+X=
+uname=$(uname -o)
+if test "$uname" = "Cygwin"
+then
+	X=".exe"
+fi
+
+../git$X >/dev/null
 if test $? != 1
 then
 	echo >&2 'You do not seem to have built git yet.'
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2488e6e..8a64f6e 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -43,6 +43,14 @@ case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z
 		;;
 esac
 
+X=
+uname=$(uname -o)
+if test "$uname" = "Cygwin"
+then
+	X=".exe"
+fi
+
+
 # Each test should start with something like this, after copyright notices:
 #
 # test_description='Description of this test...
@@ -175,7 +183,7 @@ test_create_repo () {
 	repo="$1"
 	mkdir "$repo"
 	cd "$repo" || error "Cannot setup test environment"
-	"$GIT_EXEC_PATH/git" init-db --template=$GIT_EXEC_PATH/templates/blt/ 2>/dev/null ||
+	"$GIT_EXEC_PATH/git$X" init-db --template=$GIT_EXEC_PATH/templates/blt/ 2>/dev/null ||
 	error "cannot run git init-db -- have you built things yet?"
 	mv .git/hooks .git/hooks-disabled
 	cd "$owd"
-- 
1.4.3.1.g1688
