From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] Fix contrib/subtree Makefile to patch #! line
Date: Sat, 19 Jul 2014 17:08:57 +0100
Message-ID: <1405786137-30019-1-git-send-email-charles@hashpling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 19 18:12:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8XEy-0005us-Do
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 18:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbaGSQLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 12:11:53 -0400
Received: from avasout05.plus.net ([84.93.230.250]:32973 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272AbaGSQLw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 12:11:52 -0400
Received: from turing.int.hashpling.org ([212.159.69.125])
	by avasout05 with smtp
	id UGBp1o0032iA9hg01GBqg5; Sat, 19 Jul 2014 17:11:50 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=DIIB4k9b c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=Ew9TdX-QAAAA:8
 a=0Bzu9jTXAAAA:8 a=rif433sJD4EA:10 a=mSBy96HJJ2wA:10 a=BHUvooL90DcA:10
 a=BNFp--SqAAAA:8 a=KRoZpjWB4WAld2UyXngA:9 a=92rhvNbd_XgA:10
Received: from charles by turing.int.hashpling.org with local (Exim 4.82)
	(envelope-from <charles@hashpling.org>)
	id 1X8XBx-0007pX-Fj; Sat, 19 Jul 2014 17:08:57 +0100
X-Mailer: git-send-email 2.0.2.611.g8c85416
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253894>

From: Charles Bailey <cbailey32@bloomberg.net>

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---
The main Git Makefile does this, but not the contrib/subtree Makefile.
SHELL_PATH should be respected if set (especially on Solaris where
/bin/sh is very legacy).

The sed command is a copy of one of the ones used for installing .sh
files by the main Git Makefile.

 contrib/subtree/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index d888d45..d9a0ce2 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -18,6 +18,11 @@ RM       ?= rm -f
 ASCIIDOC = asciidoc
 XMLTO    = xmlto
 
+ifndef SHELL_PATH
+	SHELL_PATH = /bin/sh
+endif
+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
+
 ASCIIDOC_CONF = ../../Documentation/asciidoc.conf
 MANPAGE_XSL   = ../../Documentation/manpage-normal.xsl
 
@@ -32,7 +37,8 @@ GIT_SUBTREE_HTML := git-subtree.html
 all: $(GIT_SUBTREE)
 
 $(GIT_SUBTREE): $(GIT_SUBTREE_SH)
-	cp $< $@ && chmod +x $@
+	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' $< >$@
+	chmod +x $@
 
 doc: $(GIT_SUBTREE_DOC) $(GIT_SUBTREE_HTML)
 
-- 
2.0.2.611.g8c85416
