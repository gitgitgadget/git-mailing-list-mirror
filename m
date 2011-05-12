From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Tweak t3102-ls-tree-wildcards to run on Windows
Date: Thu, 12 May 2011 10:37:22 +0200
Message-ID: <4DCB9C42.5070806@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 10:38:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKRPQ-0001E5-GW
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 10:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab1ELIhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 04:37:39 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38490 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751476Ab1ELIhh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 04:37:37 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QKROd-0003qF-IK; Thu, 12 May 2011 10:37:36 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 32C7A1660F;
	Thu, 12 May 2011 10:37:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173451>

From: Johannes Sixt <j6t@kdbg.org>

The test case fails on Windows, because "a*" is an invalid file name.
Therefore, use "a[a]" instead.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Regarding the change from * to [], I do not know whether the result
 still tests the same thing. Please advise!

 -- Hannes

 t/t3102-ls-tree-wildcards.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t3102-ls-tree-wildcards.sh b/t/t3102-ls-tree-wildcards.sh
index f2b2a52..c286854 100755
--- a/t/t3102-ls-tree-wildcards.sh
+++ b/t/t3102-ls-tree-wildcards.sh
@@ -1,21 +1,21 @@
 #!/bin/sh
 
-test_description='ls-tree with(out) wildcards'
+test_description='ls-tree with(out) globs'
 
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	mkdir a aa "a*" &&
-	touch a/one aa/two "a*/three" &&
-	git add a/one aa/two "a*/three" &&
+	mkdir a aa "a[a]" &&
+	touch a/one aa/two "a[a]/three" &&
+	git add a/one aa/two "a[a]/three" &&
 	git commit -m test
 '
 
-test_expect_success 'ls-tree a* matches literally' '
+test_expect_success 'ls-tree a[a] matches literally' '
 	cat >expected <<EOF &&
-100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	a*/three
+100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	a[a]/three
 EOF
-	git ls-tree -r HEAD "a*" >actual &&
+	git ls-tree -r HEAD "a[a]" >actual &&
 	test_cmp expected actual
 '
 
-- 
1.7.5.1.1646.g44dd
