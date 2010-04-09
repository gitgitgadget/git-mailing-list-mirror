From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] Makefile: Remove excess backslashes from sed
Date: Fri,  9 Apr 2010 10:41:47 -0400
Message-ID: <1270824107-26604-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 16:42:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0FPm-0003rD-Tc
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 16:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599Ab0DIOl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 10:41:59 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:32828 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab0DIOlt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 10:41:49 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 35E411FFC058; Fri,  9 Apr 2010 14:41:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from Hermes.local.net (unknown [64.134.102.129])
	by silverinsanity.com (Postfix) with ESMTPA id 1C4471FFC056;
	Fri,  9 Apr 2010 14:41:44 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.rc0.243.g2ce66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144436>

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
1.7.1.rc0.243.g2ce66
