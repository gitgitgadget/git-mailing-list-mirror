From: Niels Basjes <Niels@basjes.nl>
Subject: [PATCH] Build RPMs locally unless overruled in ~/.rpmmacros
Date: Mon, 30 Mar 2009 17:10:39 +0200
Message-ID: <1238425839-6337-1-git-send-email-Niels@Basjes.nl>
Cc: Niels Basjes <niels@basjes.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 17:13:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoJ9o-0001AU-Tf
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 17:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbZC3PKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 11:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbZC3PKl
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 11:10:41 -0400
Received: from smtpq2.gn.mail.iss.as9143.net ([212.54.34.165]:58514 "EHLO
	smtpq2.gn.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750998AbZC3PKl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 11:10:41 -0400
Received: from [212.54.34.140] (helo=smtp9.gn.mail.iss.as9143.net)
	by smtpq2.gn.mail.iss.as9143.net with esmtp (Exim 4.69)
	(envelope-from <niels@hobby.basjes.nl>)
	id 1LoJ8H-0004FO-Us; Mon, 30 Mar 2009 17:10:37 +0200
Received: from 53512e70.cable.casema.nl ([83.81.46.112] helo=hobby.basjes.nl)
	by smtp9.gn.mail.iss.as9143.net with esmtp (Exim 4.69)
	(envelope-from <niels@hobby.basjes.nl>)
	id 1LoJ8F-0002oA-Sv; Mon, 30 Mar 2009 17:10:35 +0200
Received: from hobby.basjes.nl (hobby.basjes.nl [127.0.0.1])
	by hobby.basjes.nl (8.13.8/8.13.8) with ESMTP id n2UFAdtE006368;
	Mon, 30 Mar 2009 17:10:39 +0200
Received: (from niels@localhost)
	by hobby.basjes.nl (8.13.8/8.13.8/Submit) id n2UFAdpZ006367;
	Mon, 30 Mar 2009 17:10:39 +0200
X-Mailer: git-send-email 1.6.2
X-ZiggoSMTP-MailScanner-Information: Please contact the ISP for more information
X-ZiggoSMTP-MailScanner-ID: 1LoJ8F-0002oA-Sv
X-ZiggoSMTP-MailScanner: Found to be clean
X-ZiggoSMTP-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-4.322, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -2.60, TW_PM 0.08)
X-ZiggoSMTP-MailScanner-From: niels@hobby.basjes.nl
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115162>

From: Niels Basjes <niels@basjes.nl>

Signed-off-by: Niels Basjes <niels@basjes.nl>
---
 .gitignore |    1 +
 Makefile   |    8 +++++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index 1c57d4c..2f2554b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -173,3 +173,4 @@ configure
 tags
 TAGS
 cscope*
+RPM_BUILDING
diff --git a/Makefile b/Makefile
index 7867eac..ad5a1f7 100644
--- a/Makefile
+++ b/Makefile
@@ -242,7 +242,13 @@ RM = rm -f
 TAR = tar
 FIND = find
 INSTALL = install
-RPMBUILD = rpmbuild
+RPMBUILDOPTS = $(shell if [ "`grep '^%_topdir' $(HOME)/.rpmmacros`" == "" ];        \
+                       then                                                         \
+                           mkdir -p RPM_BUILDING/{BUILD,RPMS,SOURCES,SPECS,SRPMS};  \
+                           echo '--define="_topdir `pwd`/RPM_BUILDING"' ;           \
+                       fi                                                           \
+                )
+RPMBUILD = rpmbuild $(RPMBUILDOPTS)
 TCL_PATH = tclsh
 TCLTK_PATH = wish
 PTHREAD_LIBS = -lpthread
-- 
1.6.1.3
