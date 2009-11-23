From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] t4014-format-patch: do not assume 'test' is available as
 non-builtin
Date: Mon, 23 Nov 2009 10:35:53 +0100
Message-ID: <4B0A5779.4050401@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 10:36:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCVLS-0002bY-73
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 10:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756512AbZKWJgC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 04:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756422AbZKWJgA
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 04:36:00 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:6851 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756145AbZKWJgA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 04:36:00 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NCVKs-0005wc-6w; Mon, 23 Nov 2009 10:36:02 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 87F114E4; Mon, 23 Nov 2009 10:35:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133492>

From: Johannes Sixt <j6t@kdbg.org>

One test case used 'xargs test', which assumes that 'test' is available
as external program. At least on MinGW it is not.

Moreover, 'git format-patch' was invoked in a pipeline, but not as the
last command. Rewrite the test case to catch breakage in 'git format-patch'
as well.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4014-format-patch.sh |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 5689d59..7f267f9 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -549,9 +549,7 @@ test_expect_success 'options no longer allowed for format-patch' '
 	test_cmp expect.check output'

 test_expect_success 'format-patch --numstat should produce a patch' '
-	git format-patch --numstat --stdout master..side |
-	grep "^diff --git a/" |
-	wc -l |
-	xargs test 6 = '
+	git format-patch --numstat --stdout master..side > output &&
+	test 6 = $(grep "^diff --git a/" output | wc -l)'

 test_done
-- 
1.6.6.rc0.1059.gdce25
