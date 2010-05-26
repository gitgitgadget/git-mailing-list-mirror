From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 076/104] t7604-merge-custom-message: shift expected output creation
Date: Wed, 26 May 2010 18:00:46 +1200
Message-ID: <1274853674-18521-76-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:07:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9ld-0004ff-0b
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934001Ab0EZGGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:06:33 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49306 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933755Ab0EZGGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:25 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2010 02:06:22 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 5AF37338D2;
	Wed, 26 May 2010 18:02:05 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dzb1QB6qAWJV; Wed, 26 May 2010 18:01:54 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 0CC99338A4;
	Wed, 26 May 2010 18:01:33 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147754>

From: Tay Ray Chuan <rctay89@gmail.com>

Squash in a minor rename too.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7604-merge-custom-message.sh |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index 269cfdf..d79542d 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -6,6 +6,10 @@ Testing merge when using a custom message for the merge commit.'
 
 . ./test-lib.sh
 
+create_merge_msgs() {
+	echo >exp.subject "custom message"
+}
+
 test_expect_success 'setup' '
 	echo c0 > c0.c &&
 	git add c0.c &&
@@ -19,16 +23,16 @@ test_expect_success 'setup' '
 	echo c2 > c2.c &&
 	git add c2.c &&
 	git commit -m c2 &&
-	git tag c2
+	git tag c2 &&
+	create_merge_msgs
 '
 
 
 test_expect_success 'merge c2 with a custom message' '
 	git reset --hard c1 &&
-	echo >expected "custom message" &&
-	git merge -m "custom message" c2 &&
+	git merge -m "$(cat exp.subject)" c2 &&
 	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
-	test_cmp expected actual
+	test_cmp exp.subject actual
 '
 
 test_done
-- 
1.7.1.rc2.333.gb2668
