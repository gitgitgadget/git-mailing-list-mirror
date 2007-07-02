From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH/amend] Test that git add removes stages 1,2,3.
Date: Mon,  2 Jul 2007 13:23:51 +0200
Message-ID: <1183375431711-git-send-email-johannes.sixt@telecom.at>
References: <11833750863127-git-send-email-johannes.sixt@telecom.at>
Cc: j.sixt@eudaptics.com, Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 13:23:57 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5K0a-00049D-2y
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 13:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbXGBLXy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 07:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbXGBLXx
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 07:23:53 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:54347 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbXGBLXx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 07:23:53 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1I5K0W-0002fn-0g; Mon, 02 Jul 2007 13:23:52 +0200
Received: from srv.linz.eudaptics (srv.linz.eudaptics [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id EA50C6D9; Mon,  2 Jul 2007 13:23:51 +0200 (CEST)
Received: by srv.linz.eudaptics (Postfix, from userid 503)
	id BB5D0102; Mon,  2 Jul 2007 13:23:51 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.2.555.g24e57
In-Reply-To: <11833750863127-git-send-email-johannes.sixt@telecom.at>
X-Spam-Score: 3.1 (+++)
X-Spam-Report: BAYES_95=3, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51355>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---

HMPF!

The test in the original post failed for the wrong reason. :-/

-- Hannes


 t/t3700-add.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index ad8cc7d..06fc2bf 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -110,4 +110,16 @@ test_expect_success 'check correct prefix detection' '
 	git add 1/2/a 1/3/b 1/2/c
 '
 
+test_expect_success 'git add removes unmerged entries' '
+	git rm --cached -f file || : ignore failure &&
+	for s in 0 1 2 3
+	do
+		echo "100644 0123456789012345678901234567890123456789 $s	file"
+	done | git update-index --index-info &&
+	echo new > file &&
+	git add file &&
+	git ls-files --stage | grep "^100644 .* 0	file$" &&
+	! git ls-files --stage | grep "^100644 .* [^0]	file$"
+'
+
 test_done
-- 
1.5.2.2.555.g24e57
