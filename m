From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 11/15] t7502: use test_config to set/unset git config variables
Date: Sun, 24 Mar 2013 22:06:10 +0100
Message-ID: <2f1fd34c7a69254d964778345a8cddea9e877ea4.1364158574.git.ydroneaud@opteya.com>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <cover.1364158574.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:26:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJsQy-0007bo-0n
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967Ab3CXV0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:26:03 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:41618 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754949Ab3CXV0C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:26:02 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 5DF9E9400C8;
	Sun, 24 Mar 2013 22:25:52 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2OL6m30007307;
	Sun, 24 Mar 2013 22:06:49 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2OL6m7V007306;
	Sun, 24 Mar 2013 22:06:48 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
References: <cover.1364158574.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218993>

Instead of using construct such as:
    test_when_finished "git config --unset <key>"
    git config <key> <value>
uses
    test_config <key> <value>
The latter takes care of removing <key> at the end of the test.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 t/t7502-commit.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index f9b44b7..619d438 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -171,10 +171,9 @@ test_expect_success 'verbose' '
 
 test_expect_success 'verbose respects diff config' '
 
-	git config color.diff always &&
+	test_config color.diff always &&
 	git status -v >actual &&
-	grep "\[1mdiff --git" actual &&
-	git config --unset color.diff
+	grep "\[1mdiff --git" actual
 '
 
 mesg_with_comment_and_newlines='
@@ -534,8 +533,7 @@ use_template="-t template"
 try_commit_status_combo
 
 test_expect_success 'commit --status with custom comment character' '
-	test_when_finished "git config --unset core.commentchar" &&
-	git config core.commentchar ";" &&
+	test_config core.commentchar ";" &&
 	try_commit --status &&
 	test_i18ngrep "^; Changes to be committed:" .git/COMMIT_EDITMSG
 '
-- 
1.7.11.7
