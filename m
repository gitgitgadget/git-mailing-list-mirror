From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 2/2] winworddiff: Check the path to winword.exe during the installation.
Date: Thu, 27 Sep 2007 13:45:59 +0200
Message-ID: <11908935604108-git-send-email-johannes.sixt@telecom.at>
References: <11908935593618-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Sep 27 13:46:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iaror-0004wU-Mc
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 13:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbXI0LqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 07:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbXI0LqE
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 07:46:04 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:31910 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbXI0LqD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 07:46:03 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1Iarof-0006Q4-Cb; Thu, 27 Sep 2007 13:46:01 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B352BB662; Thu, 27 Sep 2007 13:46:00 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 6EDAAFA43; Thu, 27 Sep 2007 13:46:00 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.gcc9e
In-Reply-To: <11908935593618-git-send-email-johannes.sixt@telecom.at>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59289>

Since we do not find the path to winword.exe automatically, but rely on
what the user has told us, we better check the path for plausibility.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 contrib/winword/diff/Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/contrib/winword/diff/Makefile b/contrib/winword/diff/Makefile
index 61de940..91b9328 100644
--- a/contrib/winword/diff/Makefile
+++ b/contrib/winword/diff/Makefile
@@ -1,3 +1,4 @@
+# You can override any of these from ../../../config.mak
 prefix = $(HOME)
 bindir = $(prefix)/bin
 datadir = $(prefix)/share/winworddiff
@@ -8,6 +9,9 @@ INSTALL = install
 all: winworddiff winworddiff.dot
 
 winworddiff: winworddiff.sh
+ifndef FORCE
+	exec < "$(WINWORDEXE)"	# check existence; override with 'make FORCE=1'
+endif
 	sed	-e 's|@@WINWORDEXE@@|$(WINWORDEXE)|' \
 		-e 's|@@PREFIX@@|$(prefix)|' \
 		< $@.sh > $@
-- 
1.5.3.3.gcc9e
