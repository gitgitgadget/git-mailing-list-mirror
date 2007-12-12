From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 4/4] Add tests for "git diff --check" with core.whitespace options
Date: Wed, 12 Dec 2007 17:23:02 +0100
Message-ID: <1197476582-18956-5-git-send-email-win@wincent.com>
References: <1197476582-18956-1-git-send-email-win@wincent.com>
 <1197476582-18956-2-git-send-email-win@wincent.com>
 <1197476582-18956-3-git-send-email-win@wincent.com>
 <1197476582-18956-4-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 17:24:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2UND-0002Qk-U3
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 17:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926AbXLLQX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 11:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753071AbXLLQX1
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 11:23:27 -0500
Received: from wincent.com ([72.3.236.74]:44668 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835AbXLLQX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 11:23:27 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBCGN3CK026521;
	Wed, 12 Dec 2007 10:23:11 -0600
X-Mailer: git-send-email 1.5.3.7.1159.g2f071-dirty
In-Reply-To: <1197476582-18956-4-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68067>

Make sure that "git diff --check" does the right thing when the
core.whitespace options are set.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 t/t4015-diff-whitespace.sh |   48 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index ff77a16..8d980af 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -256,4 +256,52 @@ test_expect_failure 'check mixed spaces and tabs in indent' '
 
 '
 
+test_expect_success 'check trailing whitespace (trailing-space: off)' '
+
+	git config core.whitespace "-trailing-space" &&
+	echo "foo ();   " > x &&
+	git diff --check
+
+'
+
+test_expect_failure 'check trailing whitespace (trailing-space: on)' '
+
+	git config core.whitespace "trailing-space" &&
+	echo "foo ();   " > x &&
+	git diff --check
+
+'
+
+test_expect_success 'check space before tab in indent (space-before-tab: off)' '
+
+	git config core.whitespace "-space-before-tab" &&
+	echo " 	foo ();" > x &&
+	git diff --check
+
+'
+
+test_expect_failure 'check space before tab in indent (space-before-tab: on)' '
+
+	git config core.whitespace "space-before-tab" &&
+	echo " 	foo ();   " > x &&
+	git diff --check
+
+'
+
+test_expect_success 'check spaces as indentation (indent-with-non-tab: off)' '
+
+	git config core.whitespace "-indent-with-non-tab"
+	echo "                foo ();" > x &&
+	git diff --check
+
+'
+
+test_expect_failure 'check spaces as indentation (indent-with-non-tab: on)' '
+
+	git config core.whitespace "indent-with-non-tab" &&
+	echo "                foo ();" > x &&
+	git diff --check
+
+'
+
 test_done
-- 
1.5.3.7.1159.g2f071-dirty
