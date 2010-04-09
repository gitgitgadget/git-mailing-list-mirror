From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] Makefile: Remove excess backslashes from sed
Date: Thu,  8 Apr 2010 23:22:10 -0400
Message-ID: <1270783330-35215-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 05:22:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O04nS-00074l-LR
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 05:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab0DIDWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 23:22:13 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:39708 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab0DIDWM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 23:22:12 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 794E01FFC058; Fri,  9 Apr 2010 03:22:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	by silverinsanity.com (Postfix) with ESMTPA id 86ADC1FFC056;
	Fri,  9 Apr 2010 03:22:00 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.rc0.210.ge6da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144392>

The sed script that was intended to add lines altering the sys.path
had extra backslashes in them.  Instead resulting in

  import sys;  import os;  sys.path.insert( ... )

It output

  import sys; \ import os; \ sys.path.insert( ... )

Unfortunately this caused python (2.6.1 on OS X 10.6.3) to error

  SyntaxError: unexpected character after line continuation character

Removing two of the backslashes solves this problem.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

 I'm not sure if this is a result of OS X's python or sed, but t5800
 won't work for me without this change.

 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index f0fe351..b9eb1ca 100644
--- a/Makefile
+++ b/Makefile
@@ -1632,8 +1632,8 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
 	sed -e '1{' \
 	    -e '	s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
 	    -e '}' \
-	    -e 's|^import sys.*|&; \\\
-	           import os; \\\
+	    -e 's|^import sys.*|&; \
+	           import os; \
 	           sys.path.insert(0, os.getenv("GITPYTHONLIB",\
 	                                        "@@INSTLIBDIR@@"));|' \
 	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
-- 
1.7.1.rc0.210.ge6da
