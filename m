From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 09/15] t5541: use test_config to set/unset git config variables
Date: Sun, 24 Mar 2013 22:06:08 +0100
Message-ID: <587db999963cfa775a94b5bf3107b2ba7176a80f.1364158574.git.ydroneaud@opteya.com>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <cover.1364158574.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:26:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJsQb-0007FV-6l
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924Ab3CXVZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:25:40 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:46041 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754903Ab3CXVZk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:25:40 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 8EEEC940051;
	Sun, 24 Mar 2013 22:25:30 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2OL6l8J007299;
	Sun, 24 Mar 2013 22:06:47 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2OL6l7Z007298;
	Sun, 24 Mar 2013 22:06:47 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
References: <cover.1364158574.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218990>

Instead of using construct such as:
    test_when_finished "git config --unset <key>"
    git config <key> <value>
uses
    test_config <key> <value>
The latter takes care of removing <key> at the end of the test.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 t/t5541-http-push.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 4b4b4a6..4086f02 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -181,8 +181,7 @@ test_expect_success 'push (chunked)' '
 	git checkout master &&
 	test_commit commit path3 &&
 	HEAD=$(git rev-parse --verify HEAD) &&
-	git config http.postbuffer 4 &&
-	test_when_finished "git config --unset http.postbuffer" &&
+	test_config http.postbuffer 4 &&
 	git push -v -v origin $BRANCH 2>err &&
 	grep "POST git-receive-pack (chunked)" err &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
-- 
1.7.11.7
