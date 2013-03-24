From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 06/15] t4034: use test_config/test_unconfig to set/unset git config variables
Date: Sun, 24 Mar 2013 22:06:05 +0100
Message-ID: <e64177b7746115668ff6041fe163bd1f276db3de.1364158574.git.ydroneaud@opteya.com>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <cover.1364158574.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:26:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJsRC-0007oJ-31
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848Ab3CXV0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:26:17 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:42535 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754991Ab3CXV0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:26:16 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id E8D30940168;
	Sun, 24 Mar 2013 22:26:06 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2OL6iLb007287;
	Sun, 24 Mar 2013 22:06:45 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2OL6iLi007286;
	Sun, 24 Mar 2013 22:06:44 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
References: <cover.1364158574.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218995>

Instead of using construct such as:
    test_when_finished "git config --unset <key>"
    git config <key> <value>
uses
    test_config <key> <value>
The latter takes care of removing <key> at the end of the test.

Additionally, instead of
     git config <key> ""
or
     git config --unset <key>
uses
     test_unconfig <key>
The latter doesn't failed if <key> is not defined.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 t/t4034-diff-words.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 40ab333..f2f55fc 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -230,7 +230,7 @@ test_expect_success '.gitattributes override config' '
 '
 
 test_expect_success 'setup: remove diff driver regex' '
-	test_might_fail git config --unset diff.testdriver.wordRegex
+	test_unconfig diff.testdriver.wordRegex
 '
 
 test_expect_success 'use configured regex' '
@@ -335,8 +335,7 @@ test_expect_success 'word-diff with diff.sbe' '
 
 	c
 	EOF
-	test_when_finished "git config --unset diff.suppress-blank-empty" &&
-	git config diff.suppress-blank-empty true &&
+	test_config diff.suppress-blank-empty true &&
 	word_diff --word-diff=plain
 '
 
@@ -368,7 +367,7 @@ test_expect_success 'setup history with two files' '
 
 test_expect_success 'wordRegex for the first file does not apply to the second' '
 	echo "*.tex diff=tex" >.gitattributes &&
-	git config diff.tex.wordRegex "[a-z]+|." &&
+	test_config diff.tex.wordRegex "[a-z]+|." &&
 	cat >expect <<-\EOF &&
 		diff --git a/a.tex b/a.tex
 		--- a/a.tex
-- 
1.7.11.7
