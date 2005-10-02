From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH Cogito] Copyright and document the cg script
Date: Sun, 2 Oct 2005 12:13:22 +0200
Message-ID: <20051002101322.GC9219@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 02 12:14:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EM0qU-0004p8-P3
	for gcvg-git@gmane.org; Sun, 02 Oct 2005 12:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbVJBKNY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Oct 2005 06:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbVJBKNY
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Oct 2005 06:13:24 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:7649 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1751059AbVJBKNX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Oct 2005 06:13:23 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 782B06E18D9; Sun,  2 Oct 2005 12:13:19 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 298A16E010A; Sun,  2 Oct 2005 12:13:19 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 9845260EF6; Sun,  2 Oct 2005 12:13:22 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9612>

Some distributions require all programs to be documented with a manpage so
add a small script header and generate cg(1).

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit 9356837de630644323c800e2accad2618d7393f9
tree bdd4c673b6086cee5d5b51ecdb8e2968212afcac
parent 5e15803563ef00720541e89ae16a633ac8dfb7d7
author Jonas Fonseca <fonseca@diku.dk> Thu, 29 Sep 2005 15:13:02 +0200
committer Jonas Fonseca <fonseca@stud1-9.itu.dk> Thu, 29 Sep 2005 15:13:02 +0200

 Documentation/Makefile |   12 ++++++++----
 cg                     |   24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,7 +1,7 @@
 CG_IGNORE=$(wildcard ../cg-X* ../cg-*.orig ../cg-*.rej)
-CG_SRC=$(filter-out $(CG_IGNORE), $(wildcard ../cg-*))
+CG_SRC=$(filter-out $(CG_IGNORE), $(wildcard ../cg*))
 
-MAN1_TXT=$(patsubst ../cg-%,cg-%.txt,$(CG_SRC))
+MAN1_TXT=$(patsubst ../cg%,cg%.txt,$(CG_SRC))
 MAN7_TXT=cogito.txt
 
 DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT)) introduction.html
@@ -54,9 +54,9 @@ install-html: html
 	$(INSTALL) $(DOC_HTML) $(DESTDIR)/$(htmldir)
 
 clean:
-	rm -f *.xml *.html *.1 *.7 cg-*.txt cogito.txt
+	rm -f *.xml *.html *.1 *.7 cg*.txt cogito.txt
 
-.PRECIOUS: cg-%.txt
+.PRECIOUS: cg%.txt
 
 introduction.html: ../README
 	asciidoc -b xhtml11 -d article -f asciidoc.conf -o $@ $<
@@ -73,5 +73,9 @@ introduction.html: ../README
 cogito.txt : make-cogito-asciidoc
 	./make-cogito-asciidoc > $@
 
+# It seems that cg%.txt won't match this so use an explicit rule
+cg.txt : ../cg make-cg-asciidoc
+	./make-cg-asciidoc $< > $@
+
 cg-%.txt : ../cg-% make-cg-asciidoc
 	./make-cg-asciidoc $< > $@
diff --git a/cg b/cg
--- a/cg
+++ b/cg
@@ -1,4 +1,28 @@
 #!/usr/bin/env bash
+#
+# Wrapper for running Cogito commands.
+# Copyright (c) Petr Baudis, 2005
+#
+# Takes a variable number of arguments where the first argument should
+# either be a Cogito command or one of the supported options. If no
+# arguments are specified an overview of all the Cogito commands will be
+# shown.
+#
+# Enables all Cogito commands to be accessed as subcommands, for example
+# is:
+#
+#	cg help
+#	cg-help
+#
+# equivalent.
+#
+# OPTIONS
+# -------
+# --version::
+#	Show the version of the Cogito toolkit. Equivalent to the output
+#	of `cg-version`.
+
+USAGE="cg [--version | COMMAND [ARGS]...]"
 
 cmd="$1"; shift
 case "$cmd" in

-- 
Jonas Fonseca
