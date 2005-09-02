From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH 1/4] Fix txt installation
Date: Fri, 02 Sep 2005 12:31:25 +0200
Message-ID: <20050902103125.24918.905.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 12:36:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EB8tP-00024D-TC
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 12:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbVIBKfX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 06:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbVIBKfW
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 06:35:22 -0400
Received: from [151.97.230.9] ([151.97.230.9]:45538 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1030240AbVIBKfS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Sep 2005 06:35:18 -0400
Received: (qmail 12160 invoked by uid 508); 2 Sep 2005 12:35:17 +0200
Received: from unknown (HELO ssc.unict.it) (151.97.230.9)
  by ssc.unict.it with SMTP; 2 Sep 2005 12:35:17 +0200
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 8946D21D941;
	Fri,  2 Sep 2005 12:31:26 +0200 (CEST)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8017>

Avoid make removing the txt files. They are removed because there's no
explicit dependance on them, thus they are intermediate files and thus get
removed by make.

Also, while at this, avoid listing all those build-generated files in
cg-status (i.e. edit .gitignore).
---

 .gitignore             |    2 ++
 Documentation/Makefile |    7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
--- a/.gitignore
+++ b/.gitignore
@@ -1 +1,3 @@
 cg-version
+Documentation/*.[17]
+Documentation/*.txt
diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -29,16 +29,19 @@ INSTALL=install
 # yourself - yes, all 6 characters of it!
 #
 
-all: html man
+all: html txt man
 
 html: $(DOC_HTML)
 
+txt: txt1 txt7
+txt1: $(MAN1_TXT)
+txt7: $(MAN7_TXT)
 
 man: man1 man7
 man1: $(DOC_MAN1)
 man7: $(DOC_MAN7)
 
-install: man
+install: man txt
 	$(INSTALL) -m755 -d $(DESTDIR)/$(txtdir)
 	$(INSTALL) $(MAN1_TXT) $(MAN7_TXT) $(DESTDIR)/$(txtdir)
 	$(INSTALL) -m755 -d $(DESTDIR)/$(man1) $(DESTDIR)/$(man7)
