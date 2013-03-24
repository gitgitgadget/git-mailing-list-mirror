From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 15/15] t7502: remove clear_config
Date: Sun, 24 Mar 2013 22:06:14 +0100
Message-ID: <25d62be2c030306929dd11f92a7ac4be8b227ea1.1364158574.git.ydroneaud@opteya.com>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <cover.1364158574.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:27:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJsRP-0007yv-Sn
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021Ab3CXV0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:26:31 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:43445 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755015Ab3CXV0b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:26:31 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 83E7F94022F;
	Sun, 24 Mar 2013 22:26:21 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2OL6pxl007323;
	Sun, 24 Mar 2013 22:06:51 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2OL6pvT007322;
	Sun, 24 Mar 2013 22:06:51 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
References: <cover.1364158574.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218997>

Using test_config ensure the configuration variable are removed
at the end of the test, there's no need to remove variable
at the beginning of the test.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 t/t7502-commit.sh | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 619d438..256137f 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -434,16 +434,6 @@ EOF
 
 echo '## Custom template' >template
 
-clear_config () {
-	(
-		git config --unset-all "$1"
-		case $? in
-		0|5)	exit 0 ;;
-		*)	exit 1 ;;
-		esac
-	)
-}
-
 try_commit () {
 	git reset --hard &&
 	echo >>negative &&
@@ -459,67 +449,57 @@ try_commit () {
 try_commit_status_combo () {
 
 	test_expect_success 'commit' '
-		clear_config commit.status &&
 		try_commit "" &&
 		test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
 	test_expect_success 'commit' '
-		clear_config commit.status &&
 		try_commit "" &&
 		test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
 	test_expect_success 'commit --status' '
-		clear_config commit.status &&
 		try_commit --status &&
 		test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
 	test_expect_success 'commit --no-status' '
-		clear_config commit.status &&
 		try_commit --no-status &&
 		test_i18ngrep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
 	test_expect_success 'commit with commit.status = yes' '
-		clear_config commit.status &&
-		git config commit.status yes &&
+		test_config commit.status yes &&
 		try_commit "" &&
 		test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
 	test_expect_success 'commit with commit.status = no' '
-		clear_config commit.status &&
-		git config commit.status no &&
+		test_config commit.status no &&
 		try_commit "" &&
 		test_i18ngrep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
 	test_expect_success 'commit --status with commit.status = yes' '
-		clear_config commit.status &&
-		git config commit.status yes &&
+		test_config commit.status yes &&
 		try_commit --status &&
 		test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
 	test_expect_success 'commit --no-status with commit.status = yes' '
-		clear_config commit.status &&
-		git config commit.status yes &&
+		test_config commit.status yes &&
 		try_commit --no-status &&
 		test_i18ngrep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
 	test_expect_success 'commit --status with commit.status = no' '
-		clear_config commit.status &&
-		git config commit.status no &&
+		test_config commit.status no &&
 		try_commit --status &&
 		test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
 	test_expect_success 'commit --no-status with commit.status = no' '
-		clear_config commit.status &&
-		git config commit.status no &&
+		test_config commit.status no &&
 		try_commit --no-status &&
 		test_i18ngrep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
-- 
1.7.11.7
