From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v2 10/10] Rename the test trash directory to contain shell metacharacters.
Date: Thu, 10 Apr 2008 02:50:16 -0400
Message-ID: <1207810216-27871-11-git-send-email-bdonlan@fushizen.net>
References: <cover.1207702130.git.bdonlan@fushizen.net>
 <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-2-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-3-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-4-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-5-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-6-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-7-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-8-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-9-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-10-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 08:51:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjqdB-0002xF-C1
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 08:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbYDJGus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 02:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbYDJGus
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 02:50:48 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:34033 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbYDJGus (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 02:50:48 -0400
Received: from [130.111.236.232] (helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1Jjqbz-0003wI-LC; Thu, 10 Apr 2008 06:50:19 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1Jjqbx-0007G9-C2; Thu, 10 Apr 2008 02:50:17 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1207810216-27871-10-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79174>

In order to help prevent regressions in the future, rename the trash directory
for all tests to contain an assortment of shell metacharacters. This patch
also corrects two failures that were caused or exposed by this change.

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 t/.gitignore                         |    2 +-
 t/t6200-fmt-merge-msg.sh             |    6 +++---
 t/t9121-git-svn-fetch-renamed-dir.sh |   12 ++++++------
 t/test-lib.sh                        |    4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/.gitignore b/t/.gitignore
index fad67c0..fd07343 100644
--- a/t/.gitignore
+++ b/t/.gitignore
@@ -1 +1 @@
-trash
+/trash directory with characters like $ and " and ' in its name
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 526d7d1..9c0b926 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -82,14 +82,14 @@ test_expect_success 'merge-msg test #1' '
 	git diff actual expected
 '
 
-cat >expected <<\EOF
-Merge branch 'left' of ../trash
+cat >expected <<EOF
+Merge branch 'left' of ../$test
 EOF
 
 test_expect_success 'merge-msg test #2' '
 
 	git checkout master &&
-	git fetch ../trash left &&
+	git fetch ../"$test" left &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	git diff actual expected
diff --git a/t/t9121-git-svn-fetch-renamed-dir.sh b/t/t9121-git-svn-fetch-renamed-dir.sh
index 5143ed6..99230b0 100755
--- a/t/t9121-git-svn-fetch-renamed-dir.sh
+++ b/t/t9121-git-svn-fetch-renamed-dir.sh
@@ -7,14 +7,14 @@ test_description='git-svn can fetch renamed directories'
 
 . ./lib-git-svn.sh
 
-test_expect_success 'load repository with renamed directory' "
-	svnadmin load -q $rawsvnrepo < ../t9121/renamed-dir.dump
-	"
+test_expect_success 'load repository with renamed directory' '
+	svnadmin load -q "$rawsvnrepo" < ../t9121/renamed-dir.dump
+	'
 
-test_expect_success 'init and fetch repository' "
-	git svn init $svnrepo/newname &&
+test_expect_success 'init and fetch repository' '
+	git svn init "$svnrepo/newname" &&
 	git svn fetch
-	"
+	'
 
 test_done
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 04e098b..f6b2954 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -411,14 +411,14 @@ fi
 . ../GIT-BUILD-OPTIONS
 
 # Test repository
-test=trash
+test="trash directory with characters like \$ and \" and ' in its name"
 rm -fr "$test" || {
 	trap - exit
 	echo >&5 "FATAL: Cannot prepare test area"
 	exit 1
 }
 
-test_create_repo $test
+test_create_repo "$test"
 cd "$test"
 
 this_test=$(expr "./$0" : '.*/\(t[0-9]*\)-[^/]*$')
-- 
1.5.5.33.gc0a39.dirty
