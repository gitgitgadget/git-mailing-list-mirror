From: "Jeffrey C. Ollie" <jeff@ocjtech.us>
Subject: [PATCH (tig)] Supply explicit permission bits to 'install'.
Date: Thu, 31 May 2007 14:20:32 -0500
Message-ID: <11806392321132-git-send-email-jeff@ocjtech.us>
Cc: git@vger.kernel.org, "Jeffrey C. Ollie" <jeff@ocjtech.us>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu May 31 21:19:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtqBS-0005Hb-PA
	for gcvg-git@gmane.org; Thu, 31 May 2007 21:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509AbXEaTTe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 15:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756411AbXEaTTe
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 15:19:34 -0400
Received: from homer.isunet.net ([63.175.164.9]:56727 "EHLO homer.isunet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756187AbXEaTTd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 15:19:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by homer.isunet.net (Postfix) with ESMTP id 9E4963880C9;
	Thu, 31 May 2007 13:26:19 -0500 (CDT)
Received: from homer.isunet.net ([63.175.164.9])
 by localhost (homer [63.175.164.9]) (amavisd-new, port 10024) with ESMTP
 id 10330-09; Thu, 31 May 2007 13:26:17 -0500 (CDT)
Received: from max1.ocjtech.us (dsl-ppp239.isunet.net [63.175.164.239])
	by homer.isunet.net (Postfix) with ESMTP id 562D53880CC;
	Thu, 31 May 2007 13:26:17 -0500 (CDT)
Received: from [161.210.6.122] (helo=lt21223.campus.dmacc.edu)
	by max1.ocjtech.us with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.62)
	(envelope-from <jeff@ocjtech.us>)
	id 1HtqBN-00042o-07; Thu, 31 May 2007 14:19:37 -0500
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by lt21223.campus.dmacc.edu with esmtp (Exim 4.63)
	(envelope-from <jeff@ocjtech.us>)
	id 1HtqCH-0004oP-0r; Thu, 31 May 2007 14:20:33 -0500
X-Mailer: git-send-email 1.5.2.GIT
X-Virus-Scanned: by amavisd-new at isunet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48816>

'install' will install files with permissions set to '0755' if the
permissions are not specified on the command line.  Having the execute
bits set on non-executable content is not desireable.  Specify mode
0644 for non-executable content as well as specify mode 0755 for
executable content (in case the defaults change or are different on
different systems).  Also tell 'install' to preserve timestamps.

Signed-off-by: Jeffrey C. Ollie <jeff@ocjtech.us>
---
 Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 57196b0..f9adecb 100644
--- a/Makefile
+++ b/Makefile
@@ -38,7 +38,7 @@ doc-html: $(HTMLDOC)
 install: all
 	mkdir -p $(DESTDIR)$(bindir) && \
 	for prog in $(PROGS); do \
-		install $$prog $(DESTDIR)$(bindir); \
+		install -p -m 0755 $$prog $(DESTDIR)$(bindir); \
 	done
 
 install-doc-man: doc-man
@@ -46,8 +46,8 @@ install-doc-man: doc-man
 		 $(DESTDIR)$(mandir)/man5
 	for doc in $(MANDOC); do \
 		case "$$doc" in \
-		*.1) install $$doc $(DESTDIR)$(mandir)/man1 ;; \
-		*.5) install $$doc $(DESTDIR)$(mandir)/man5 ;; \
+		*.1) install -p -m 0644 $$doc $(DESTDIR)$(mandir)/man1 ;; \
+		*.5) install -p -m 0644 $$doc $(DESTDIR)$(mandir)/man5 ;; \
 		esac \
 	done
 
-- 
1.5.2.GIT
