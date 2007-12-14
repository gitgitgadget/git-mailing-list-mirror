From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 3/3] Test interaction between diff --check and --exit-code
Date: Fri, 14 Dec 2007 12:23:44 +0100
Message-ID: <1197631424-52586-4-git-send-email-win@wincent.com>
References: <1197631424-52586-1-git-send-email-win@wincent.com>
 <1197631424-52586-2-git-send-email-win@wincent.com>
 <1197631424-52586-3-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 12:24:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38ec-0002cO-JC
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 12:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbXLNLYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 06:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbXLNLYH
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 06:24:07 -0500
Received: from wincent.com ([72.3.236.74]:50225 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbXLNLYG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 06:24:06 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBEBNkhZ018244;
	Fri, 14 Dec 2007 05:23:51 -0600
X-Mailer: git-send-email 1.5.4.rc0.1099.g76fa0-dirty
In-Reply-To: <1197631424-52586-3-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68294>

Make sure that it works as advertised in the man page.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 t/t4017-diff-retval.sh |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index 6873190..dc0b712 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -76,4 +76,33 @@ test_expect_success 'git diff-index --cached HEAD' '
 	}
 '
 
+test_expect_success '--check --exit-code returns 0 for no difference' '
+
+	git diff --check --exit-code
+
+'
+
+test_expect_success '--check --exit-code returns 1 for a clean difference' '
+
+	echo "good" > a &&
+	git diff --check --exit-code
+	test $? = 1
+
+'
+
+test_expect_success '--check --exit-code returns 3 for a dirty difference' '
+
+	echo "bad   " >> a &&
+	git diff --check --exit-code
+	test $? = 3
+
+'
+
+test_expect_success '--check with --no-pager returns 2 for dirty difference' '
+
+	git --no-pager diff --check
+	test $? = 2
+
+'
+
 test_done
-- 
1.5.4.rc0.1099.g76fa0-dirty
