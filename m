From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] git-submodule: add test for the subcommand parser fix
Date: Tue, 15 Jan 2008 03:20:10 -0800
Message-ID: <7vtzlfe3o5.fsf_-_@gitster.siamese.dyndns.org>
References: <1200280956-19920-1-git-send-email-imyousuf@gmail.com>
	<7vzlv7flb5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 15 12:20:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEjqa-0005yu-Pd
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 12:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbYAOLUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 06:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbYAOLUU
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 06:20:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58707 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbYAOLUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 06:20:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 963F01930;
	Tue, 15 Jan 2008 06:20:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A200F192E;
	Tue, 15 Jan 2008 06:20:13 -0500 (EST)
In-Reply-To: <7vzlv7flb5.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 15 Jan 2008 02:13:50 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70514>

This modifies the existing t7400 test to use 'init' as the
pathname that a submodule is bound to.  Without the earlier
subcommand parser fix, this fails.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7400-submodule-basic.sh |   56 ++++++++++++++++++++++----------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 4fe3a41..2ef85a8 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -13,11 +13,11 @@ subcommands of git-submodule.
 
 #
 # Test setup:
-#  -create a repository in directory lib
+#  -create a repository in directory init
 #  -add a couple of files
-#  -add directory lib to 'superproject', this creates a DIRLINK entry
+#  -add directory init to 'superproject', this creates a DIRLINK entry
 #  -add a couple of regular files to enable testing of submodule filtering
-#  -mv lib subrepo
+#  -mv init subrepo
 #  -add an entry to .gitmodules for submodule 'example'
 #
 test_expect_success 'Prepare submodule testing' '
@@ -25,8 +25,8 @@ test_expect_success 'Prepare submodule testing' '
 	git-add t &&
 	git-commit -m "initial commit" &&
 	git branch initial HEAD &&
-	mkdir lib &&
-	cd lib &&
+	mkdir init &&
+	cd init &&
 	git init &&
 	echo a >a &&
 	git add a &&
@@ -41,10 +41,10 @@ test_expect_success 'Prepare submodule testing' '
 	cd .. &&
 	echo a >a &&
 	echo z >z &&
-	git add a lib z &&
+	git add a init z &&
 	git-commit -m "super commit 1" &&
-	mv lib .subrepo &&
-	GIT_CONFIG=.gitmodules git config submodule.example.url git://example.com/lib.git
+	mv init .subrepo &&
+	GIT_CONFIG=.gitmodules git config submodule.example.url git://example.com/init.git
 '
 
 test_expect_success 'status should fail for unmapped paths' '
@@ -52,7 +52,7 @@ test_expect_success 'status should fail for unmapped paths' '
 	then
 		echo "[OOPS] submodule status succeeded"
 		false
-	elif ! GIT_CONFIG=.gitmodules git config submodule.example.path lib
+	elif ! GIT_CONFIG=.gitmodules git config submodule.example.path init
 	then
 		echo "[OOPS] git config failed to update .gitmodules"
 		false
@@ -71,7 +71,7 @@ test_expect_success 'status should initially be "missing"' '
 test_expect_success 'init should register submodule url in .git/config' '
 	git-submodule init &&
 	url=$(git config submodule.example.url) &&
-	if test "$url" != "git://example.com/lib.git"
+	if test "$url" != "git://example.com/init.git"
 	then
 		echo "[OOPS] init succeeded but submodule url is wrong"
 		false
@@ -83,41 +83,41 @@ test_expect_success 'init should register submodule url in .git/config' '
 '
 
 test_expect_success 'update should fail when path is used by a file' '
-	echo "hello" >lib &&
+	echo "hello" >init &&
 	if git-submodule update
 	then
 		echo "[OOPS] update should have failed"
 		false
-	elif test "$(cat lib)" != "hello"
+	elif test "$(cat init)" != "hello"
 	then
-		echo "[OOPS] update failed but lib file was molested"
+		echo "[OOPS] update failed but init file was molested"
 		false
 	else
-		rm lib
+		rm init
 	fi
 '
 
 test_expect_success 'update should fail when path is used by a nonempty directory' '
-	mkdir lib &&
-	echo "hello" >lib/a &&
+	mkdir init &&
+	echo "hello" >init/a &&
 	if git-submodule update
 	then
 		echo "[OOPS] update should have failed"
 		false
-	elif test "$(cat lib/a)" != "hello"
+	elif test "$(cat init/a)" != "hello"
 	then
-		echo "[OOPS] update failed but lib/a was molested"
+		echo "[OOPS] update failed but init/a was molested"
 		false
 	else
-		rm lib/a
+		rm init/a
 	fi
 '
 
 test_expect_success 'update should work when path is an empty dir' '
-	rm -rf lib &&
-	mkdir lib &&
+	rm -rf init &&
+	mkdir init &&
 	git-submodule update &&
-	head=$(cd lib && git rev-parse HEAD) &&
+	head=$(cd init && git rev-parse HEAD) &&
 	if test -z "$head"
 	then
 		echo "[OOPS] Failed to obtain submodule head"
@@ -134,7 +134,7 @@ test_expect_success 'status should be "up-to-date" after update' '
 '
 
 test_expect_success 'status should be "modified" after submodule commit' '
-	cd lib &&
+	cd init &&
 	echo b >b &&
 	git add b &&
 	git-commit -m "submodule commit 2" &&
@@ -157,8 +157,8 @@ test_expect_success 'git diff should report the SHA1 of the new submodule commit
 '
 
 test_expect_success 'update should checkout rev1' '
-	git-submodule update &&
-	head=$(cd lib && git rev-parse HEAD) &&
+	git-submodule update init &&
+	head=$(cd init && git rev-parse HEAD) &&
 	if test -z "$head"
 	then
 		echo "[OOPS] submodule git rev-parse returned nothing"
@@ -182,13 +182,13 @@ test_expect_success 'checkout superproject with subproject already present' '
 test_expect_success 'apply submodule diff' '
 	git branch second &&
 	(
-		cd lib &&
+		cd init &&
 		echo s >s &&
 		git add s &&
 		git commit -m "change subproject"
 	) &&
-	git update-index --add lib &&
-	git-commit -m "change lib" &&
+	git update-index --add init &&
+	git-commit -m "change init" &&
 	git-format-patch -1 --stdout >P.diff &&
 	git checkout second &&
 	git apply --index P.diff &&
-- 
1.5.4.rc3.11.g4e67
