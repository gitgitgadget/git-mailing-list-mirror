From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 04/15] t3400: use test_config to set/unset git config variables
Date: Sun, 24 Mar 2013 22:06:03 +0100
Message-ID: <00788763fe791a5b2bc181f4dfae9247f57f3cb4.1364158574.git.ydroneaud@opteya.com>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <cover.1364158574.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:07:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJs8Q-0007mr-QZ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732Ab3CXVGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:06:53 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:51907 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754654Ab3CXVGw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:06:52 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 00F4B9401C1;
	Sun, 24 Mar 2013 22:06:43 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2OL6flu007279;
	Sun, 24 Mar 2013 22:06:41 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2OL6fpa007278;
	Sun, 24 Mar 2013 22:06:41 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
References: <cover.1364158574.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218983>

Instead of using construct such as:
    test_when_finished "git config --unset <key>"
    git config <key> <value>
uses
    test_config <key> <value>
The latter takes care of removing <key> at the end of the test.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 t/t3400-rebase.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 1de0ebd..f6cc102 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -138,8 +138,7 @@ test_expect_success 'rebase a single mode change' '
 '
 
 test_expect_success 'rebase is not broken by diff.renames' '
-	git config diff.renames copies &&
-	test_when_finished "git config --unset diff.renames" &&
+	test_config diff.renames copies &&
 	git checkout filemove &&
 	GIT_TRACE=1 git rebase force-3way
 '
-- 
1.7.11.7
