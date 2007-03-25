From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 1/2] Documentation: Replace @@GIT_VERSION@@ in documentation
Date: Sun, 25 Mar 2007 13:56:49 +0200
Message-ID: <11748238102228-git-send-email-frank@lichtenheld.de>
References: <7vircqe389.fsf@assigned-by-dhcp.cox.net>
Cc: Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 25 13:58:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVRMk-0001kF-GE
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 13:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbXCYL6U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 07:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbXCYL6T
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 07:58:19 -0400
Received: from mail.lenk.info ([217.160.134.107]:63630 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbXCYL6S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 07:58:18 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HVRMZ-00055Y-3j; Sun, 25 Mar 2007 13:58:19 +0200
Received: from p3ee3dfa5.dip.t-dialin.net ([62.227.223.165] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HVRMW-00075y-FK; Sun, 25 Mar 2007 13:58:16 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HVRL9-0005O9-11; Sun, 25 Mar 2007 13:56:51 +0200
X-Mailer: git-send-email 1.5.0.3
In-Reply-To: <7vircqe389.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43052>

Include GIT-VERSION-FILE and replace @@GIT_VERSION@@ in
the HTML and XML asciidoc output. The documentation
doesn't depend on GIT-VERSION-FILE so it will not be
automatically rebuild if nothing else changed.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/Makefile |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

 This should satisfy all of Junio's requirements.

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 7c1c9e1..64cc755 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -64,6 +64,11 @@ install: man
 	$(INSTALL) -m644 $(DOC_MAN7) $(DESTDIR)$(man7dir)
 
 
+../GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
+	$(MAKE) -C ../ GIT-VERSION-FILE
+
+-include ../GIT-VERSION-FILE
+
 #
 # Determine "include::" file references in asciidoc files.
 #
@@ -90,17 +95,21 @@ $(cmds_txt): cmd-list.perl $(MAN1_TXT)
 git.7 git.html: git.txt core-intro.txt
 
 clean:
-	rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html doc.dep
+	rm -f *.xml *.xml+ *.html *.html+ *.1 *.7 howto-index.txt howto/*.html doc.dep
 	rm -f $(cmds_txt)
 
 %.html : %.txt
 	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf $(ASCIIDOC_EXTRA) $<
+	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' $@ >$@+
+	mv $@+ $@
 
 %.1 %.7 : %.xml
 	xmlto -m callouts.xsl man $<
 
 %.xml : %.txt
 	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf $<
+	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' $@ >$@+
+	mv $@+ $@
 
 user-manual.xml: user-manual.txt user-manual.conf
 	$(ASCIIDOC) -b docbook -d book $<
@@ -136,3 +145,5 @@ install-webdoc : html
 
 quick-install:
 	sh ./install-doc-quick.sh $(DOC_REF) $(mandir)
+
+.PHONY: .FORCE-GIT-VERSION-FILE
-- 
1.5.0.3
