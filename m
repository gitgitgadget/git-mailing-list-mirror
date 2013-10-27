From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH] Change sed i\ usage to something Solaris' sed can handle
Date: Sun, 27 Oct 2013 21:26:48 +0000
Message-ID: <1382909208-7716-1-git-send-email-bdwalton@gmail.com>
Cc: git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Oct 27 23:23:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaYkQ-0006dW-1B
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 23:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab3J0WXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 18:23:42 -0400
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:48715 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab3J0WXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 18:23:42 -0400
X-Greylist: delayed 3391 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Oct 2013 18:23:41 EDT
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:56605 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1VaXrZ-0008EJ-7g ; Sun, 27 Oct 2013 17:27:09 -0400
Received: from 86-42-140-29-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.140.29]:34167 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1VaXrW-0007wz-Cv ; Sun, 27 Oct 2013 17:27:06 -0400
Received: from bwalton by neilyoung with local (Exim 4.80)
	(envelope-from <bwalton@benandwen.net>)
	id 1VaXrS-000210-9g; Sun, 27 Oct 2013 21:27:02 +0000
X-Mailer: git-send-email 1.8.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236813>

Solaris' sed was choking on the i\ commands used in
t4015-diff-whitespace as it couldn't parse the program properly.
Modify two uses of sed that worked in GNU sed but not Solaris'
(/usr/bin or /usr/xpg4/bin) to an equivalent form that is handled
properly by both.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 t/t4015-diff-whitespace.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 3fb4b97..0126154 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -145,7 +145,8 @@ test_expect_success 'another test, with --ignore-space-at-eol' 'test_cmp expect
 test_expect_success 'ignore-blank-lines: only new lines' '
 	test_seq 5 >x &&
 	git update-index x &&
-	test_seq 5 | sed "/3/i \\
+	test_seq 5 | sed "/3/i\\
+\
 " >x &&
 	git diff --ignore-blank-lines >out &&
 	>expect &&
@@ -155,7 +156,8 @@ test_expect_success 'ignore-blank-lines: only new lines' '
 test_expect_success 'ignore-blank-lines: only new lines with space' '
 	test_seq 5 >x &&
 	git update-index x &&
-	test_seq 5 | sed "/3/i \ " >x &&
+	test_seq 5 | sed "/3/i\\
+ " >x &&
 	git diff -w --ignore-blank-lines >out &&
 	>expect &&
 	test_cmp out expect
-- 
1.8.1.2
