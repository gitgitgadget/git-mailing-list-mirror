From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] t7004-tag: Skip more tests if gpg is not available.
Date: Wed, 02 Apr 2008 08:52:37 +0200
Message-ID: <47F32D35.3010407@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 08:53:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgwqb-0005yR-5c
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 08:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbYDBGwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 02:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbYDBGwm
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 02:52:42 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:61674 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbYDBGwl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 02:52:41 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jgwos-0007C5-Gm; Wed, 02 Apr 2008 08:51:41 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 26232AFCC; Wed,  2 Apr 2008 08:52:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78684>

From: Johannes Sixt <johannes.sixt@telecom.at>

This test was already careful enough to skip signed tag tests if gpg
is not available, but it must also skip all verify tests, even those
that are about non-signed tags, because they also invoke gpg.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 t/t7004-tag.sh |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 2b4c270..c4854c3 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -579,6 +579,14 @@ test_expect_success \
 	git diff expect actual
 '

+# subsequent tests require gpg; check if it is available
+gpg --version >/dev/null
+if [ $? -eq 127 ]; then
+	echo "gpg not found - skipping tag signing and verification tests"
+	test_done
+	exit
+fi
+
 # trying to verify annotated non-signed tags:

 test_expect_success \
@@ -601,13 +609,6 @@ test_expect_success \

 # creating and verifying signed tags:

-gpg --version >/dev/null
-if [ $? -eq 127 ]; then
-	echo "Skipping signed tags tests, because gpg was not found"
-	test_done
-	exit
-fi
-
 # As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
 # the gpg version 1.0.6 didn't parse trust packets correctly, so for
 # that version, creation of signed tags using the generated key fails.
-- 
1.5.5.rc2.861.g18c5b.dirty
