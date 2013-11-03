From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH] Change sed i\ usage to something Solaris' sed can handle
Date: Sun,  3 Nov 2013 13:08:29 +0000
Message-ID: <1383484109-30838-1-git-send-email-bdwalton@gmail.com>
References: <xmqqeh72blpt.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, schwab@linux-m68k.org,
	Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 03 14:09:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcxQV-00031r-I9
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 14:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab3KCNIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 08:08:51 -0500
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:45723 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab3KCNIv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 08:08:51 -0500
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:51991 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1VcxQA-0004K7-9H ; Sun, 03 Nov 2013 08:08:50 -0500
Received: from 86-42-140-29-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.140.29]:38074 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1VcxQ5-0004uI-2V ; Sun, 03 Nov 2013 08:08:45 -0500
Received: from bwalton by neilyoung with local (Exim 4.80)
	(envelope-from <bwalton@benandwen.net>)
	id 1VcxPy-00081w-S7; Sun, 03 Nov 2013 13:08:38 +0000
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <xmqqeh72blpt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237259>

Solaris' sed was choking on the i\ commands used in
t4015-diff-whitespace as it couldn't parse the program properly.
Modify two uses of sed that worked in GNU sed but not Solaris'
(/usr/bin or /usr/xpg4/bin) to an equivalent form that is handled
properly by both.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
This addresses Andreas' comment about the extraneous \<nl>.
Sorry, I misunderstood the original comment.

 t/t4015-diff-whitespace.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 3fb4b97..604a838 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -145,7 +145,7 @@ test_expect_success 'another test, with --ignore-space-at-eol' 'test_cmp expect
 test_expect_success 'ignore-blank-lines: only new lines' '
 	test_seq 5 >x &&
 	git update-index x &&
-	test_seq 5 | sed "/3/i \\
+	test_seq 5 | sed "/3/i\\
 " >x &&
 	git diff --ignore-blank-lines >out &&
 	>expect &&
@@ -155,7 +155,8 @@ test_expect_success 'ignore-blank-lines: only new lines' '
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
1.8.3.2
