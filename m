From: David Greaves <david@dgreaves.com>
Subject: [PATCH 1/5] Docs - Makefile update
Date: Sun, 22 May 2005 18:44:15 +0100
Message-ID: <E1DZuUp-0008AH-Li@ash.dgreaves.com>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 19:43:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZuTt-0003m8-EQ
	for gcvg-git@gmane.org; Sun, 22 May 2005 19:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVEVRo1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 13:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVEVRo1
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 13:44:27 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:34534 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261196AbVEVRoS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2005 13:44:18 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id D7FB9E6DB3; Sun, 22 May 2005 18:43:31 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12606-01; Sun, 22 May 2005 18:43:31 +0100 (BST)
Received: from oak.dgreaves.com (modem-1750.lemur.dialup.pol.co.uk [217.135.134.214])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 1CE29E6DA9; Sun, 22 May 2005 18:43:31 +0100 (BST)
Received: from [10.0.0.90] (helo=ash.dgreaves.com)
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DZuUu-000168-6A; Sun, 22 May 2005 18:44:20 +0100
Received: from david by ash.dgreaves.com with local (Exim 4.50)
	id 1DZuUp-0008AH-Li; Sun, 22 May 2005 18:44:15 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A Makefile that works just fine when the 6 character patch is applied
to asciidoc

Signed-off-by: David Greaves <david@dgreaves.com>

---
commit 4a137fb4f4d7e04ae0fb72b3f4910dc487f39c8a
tree 72336a9478877b0708833f0e61cfd27574f24417
parent e002a16ba54096666c2d1768daa122e29fba11ee
author David Greaves <david@dgreaves.com> Sat, 21 May 2005 21:15:18 +0100
committer David Greaves <david@dgreaves.com> Sat, 21 May 2005 21:15:18 +0100

 Documentation/Makefile |   28 +++++++++++++++++++++-------
 1 files changed, 21 insertions(+), 7 deletions(-)

Index: Documentation/Makefile
===================================================================
--- 58741c69570705801db4b785681790d636475695/Documentation/Makefile  (mode:100644)
+++ 72336a9478877b0708833f0e61cfd27574f24417/Documentation/Makefile  (mode:100644)
@@ -1,12 +1,28 @@
-DOC_SRC=$(wildcard git*.txt)
-DOC_HTML=$(patsubst %.txt,%.html,$(DOC_SRC))
-DOC_MAN=$(patsubst %.txt,%.1,$(wildcard git-*.txt)) git.7
+MAN1_TXT=$(wildcard git-*.txt)
+MAN7_TXT=git.txt
 
-all: $(DOC_HTML) $(DOC_MAN)
+DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT))
+
+DOC_MAN1=$(patsubst %.txt,%.1,$(MAN1_TXT))
+DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT))
+
+#
+# Please note that there is a minor bug in asciidoc.
+# The version after 6.0.3 _will_ include the patch found here:
+#   http://marc.theaimsgroup.com/?l=git&m=111558757202243&w=2
+#
+# Until that version is released you may have to apply the patch
+# yourself - yes, all 6 characters of it!
+#
+
+all: html man
 
 html: $(DOC_HTML)
 
-man: $(DOC_MAN)
+
+man: man1 man7
+man1: $(DOC_MAN1)
+man7: $(DOC_MAN7)
 
 # 'include' dependencies
 git-diff-%.txt: diff-format.txt
@@ -20,8 +36,6 @@
 
 %.1 %.7 : %.xml
 	xmlto man $<
-	# FIXME: this next line works around an output filename bug in asciidoc 6.0.3
-	[ "$@" = "git.7" ] || mv git.1 $@
 
 %.xml : %.txt
 	asciidoc -b docbook -d manpage $<
