From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 05/15] t4304: use test_config to set/unset git config variables
Date: Sun, 24 Mar 2013 22:06:04 +0100
Message-ID: <46b1dba5f3e4aeec0023bc796a5967b8e5399c00.1364158574.git.ydroneaud@opteya.com>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <cover.1364158574.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:26:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJsQp-0007SL-9D
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944Ab3CXVZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:25:55 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:46919 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754929Ab3CXVZy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:25:54 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 1BDE994012F;
	Sun, 24 Mar 2013 22:25:44 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2OL6irX007283;
	Sun, 24 Mar 2013 22:06:44 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2OL6hRu007282;
	Sun, 24 Mar 2013 22:06:43 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
References: <cover.1364158574.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218992>

Instead of using construct such as:
    test_when_finished "git config --unset <key>"
    git config <key> <value>
uses
    test_config <key> <value>
The latter takes care of removing <key> at the end of the test.

Tests are modified to assume correct (default) configuration at entry,
and to reset the modified configuration variables at the end.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 t/t3404-rebase-interactive.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 15dcbd4..a58406d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -937,8 +937,7 @@ test_expect_success 'rebase --edit-todo can be used to modify todo' '
 test_expect_success 'rebase -i respects core.commentchar' '
 	git reset --hard &&
 	git checkout E^0 &&
-	git config core.commentchar "\\" &&
-	test_when_finished "git config --unset core.commentchar" &&
+	test_config core.commentchar "\\" &&
 	write_script remove-all-but-first.sh <<-\EOF &&
 	sed -e "2,\$s/^/\\\\/" "$1" >"$1.tmp" &&
 	mv "$1.tmp" "$1"
-- 
1.7.11.7
