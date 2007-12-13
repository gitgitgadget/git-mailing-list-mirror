From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 5/5] Add tests for "git diff --check" with core.whitespace options
Date: Thu, 13 Dec 2007 14:32:31 +0100
Message-ID: <1197552751-53480-6-git-send-email-win@wincent.com>
References: <1197552751-53480-1-git-send-email-win@wincent.com>
 <1197552751-53480-2-git-send-email-win@wincent.com>
 <1197552751-53480-3-git-send-email-win@wincent.com>
 <1197552751-53480-4-git-send-email-win@wincent.com>
 <1197552751-53480-5-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 14:33:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2oC9-0003vl-OD
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 14:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbXLMNdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 08:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbXLMNdF
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 08:33:05 -0500
Received: from wincent.com ([72.3.236.74]:47242 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752889AbXLMNdA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 08:33:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBDDWZ4c019847;
	Thu, 13 Dec 2007 07:32:43 -0600
X-Mailer: git-send-email 1.5.4.rc0.4.g50348
In-Reply-To: <1197552751-53480-5-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68146>

Make sure that "git diff --check" does the right thing when the
core.whitespace options are set.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 t/t4015-diff-whitespace.sh |   50 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index a0a47dd..cb90ee7 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -261,4 +261,54 @@ test_expect_failure 'check with space before tab in indent (diff-tree)' '
 
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
+	# indent contains space followed by HT
+	git config core.whitespace "-space-before-tab" &&
+	echo " 	foo ();" > x &&
+	git diff --check
+
+'
+
+test_expect_failure 'check space before tab in indent (space-before-tab: on)' '
+
+	# indent contains space followed by HT
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
1.5.4.rc0.4.g50348
