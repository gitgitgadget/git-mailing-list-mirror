From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 10/15] t7500: use test_config to set/unset git config variables
Date: Sun, 24 Mar 2013 22:06:09 +0100
Message-ID: <74151b665c2e3ddbb99818ef20e95a0e7a849ee9.1364158574.git.ydroneaud@opteya.com>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <cover.1364158574.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:26:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJsR5-0007e8-5M
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976Ab3CXV0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:26:10 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:42106 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754971Ab3CXV0J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:26:09 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id A357994017A;
	Sun, 24 Mar 2013 22:25:59 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2OL6msF007303;
	Sun, 24 Mar 2013 22:06:48 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2OL6luI007302;
	Sun, 24 Mar 2013 22:06:47 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
References: <cover.1364158574.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218994>

Instead of using construct such as:
    test_when_finished "git config --unset <key>"
    git config <key> <value>
uses
    test_config <key> <value>
The latter takes care of removing <key> at the end of the test.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 t/t7500-commit.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 1c908f4..436b7b6 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -36,8 +36,7 @@ test_expect_success 'nonexistent template file should return error' '
 '
 
 test_expect_success 'nonexistent template file in config should return error' '
-	git config commit.template "$PWD"/notexist &&
-	test_when_finished "git config --unset commit.template" &&
+	test_config commit.template "$PWD"/notexist &&
 	(
 		GIT_EDITOR="echo hello >\"\$1\"" &&
 		export GIT_EDITOR &&
@@ -93,14 +92,13 @@ test_expect_success '-t option should be short for --template' '
 
 test_expect_success 'config-specified template should commit' '
 	echo "new template" > "$TEMPLATE" &&
-	git config commit.template "$TEMPLATE" &&
+	test_config commit.template "$TEMPLATE" &&
 	echo "more content" >> foo &&
 	git add foo &&
 	(
 		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
 		git commit
 	) &&
-	git config --unset commit.template &&
 	commit_msg_is "new templatecommit message"
 '
 
-- 
1.7.11.7
