From: Max Kirillov <max@max630.net>
Subject: [PATCH v2 1/2] t6023-merge-file.sh: fix and mark as broken invalid tests
Date: Sun, 29 Jun 2014 01:04:45 +0300
Message-ID: <1403993086-15625-2-git-send-email-max@max630.net>
References: <1403993086-15625-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 29 00:13:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X10sC-0002rm-9i
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 00:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbaF1WNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 18:13:24 -0400
Received: from p3plsmtpa06-07.prod.phx3.secureserver.net ([173.201.192.108]:38291
	"EHLO p3plsmtpa06-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750944AbaF1WNY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jun 2014 18:13:24 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Jun 2014 18:13:06 EDT
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa06-07.prod.phx3.secureserver.net with 
	id Ky521o00K3gsSd601y5CdC; Sat, 28 Jun 2014 15:05:14 -0700
X-Mailer: git-send-email 2.0.0.526.g5318336
In-Reply-To: <1403993086-15625-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252621>

Tests "merge without conflict (missing LF at EOF" and "merge result
added missing LF" are meaningless - the first one is identical to
"merge without conflict" and the second compares results of those
identical tests, which are always same.

This has been so since their addition in ba1f5f3537. Probably "new4.txt"
was meant to be used instead of "new2.txt". Unfortunately, the current
merge-file breaks with new4 - conflict is reported. They also fail at
that revision if fixed.

Fix the file reference to "new4.txt" and mark the tests as failing -
they look like legitimate expectations, just not satisfied at time
being.

Signed-off-by: Max Kirillov <max@max630.net>
---
 t/t6023-merge-file.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index d9f3439..6da921c 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -77,10 +77,10 @@ test_expect_success "merge without conflict (--quiet)" \
 	"git merge-file --quiet test.txt orig.txt new2.txt"
 
 cp new1.txt test2.txt
-test_expect_success "merge without conflict (missing LF at EOF)" \
-	"git merge-file test2.txt orig.txt new2.txt"
+test_expect_failure "merge without conflict (missing LF at EOF)" \
+	"git merge-file test2.txt orig.txt new4.txt"
 
-test_expect_success "merge result added missing LF" \
+test_expect_failure "merge result added missing LF" \
 	"test_cmp test.txt test2.txt"
 
 cp test.txt backup.txt
-- 
2.0.0.526.g5318336
