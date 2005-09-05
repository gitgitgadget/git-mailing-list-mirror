From: Martin Atukunda <matlads@ds.co.ug>
Subject: [PATCH] Add the git-version-script.
Date: Mon, 5 Sep 2005 21:38:48 +0300
Message-ID: <11259455282831-git-send-email-matlads@ds.co.ug>
Reply-To: Martin Atukunda <matlads@ds.co.ug>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Atukunda <matlads@ds.co.ug>
X-From: git-owner@vger.kernel.org Mon Sep 05 20:40:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECLtM-00076Y-Hg
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 20:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVIESkA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 14:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVIESj7
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 14:39:59 -0400
Received: from mail1.infocom.co.ug ([217.113.72.31]:26373 "EHLO
	mail1.infocom.co.ug") by vger.kernel.org with ESMTP id S932393AbVIESj7
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 14:39:59 -0400
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Mon, 05 Sep 2005 21:39:45 +0300
  id 000E5CAF.431C90F1.00006B2F
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP
	id C2E73140F; Mon,  5 Sep 2005 21:41:12 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=igloo)
	by igloo.ds.co.ug with smtp (Exim 4.50)
	id 1ECLrl-0004xa-0t; Mon, 05 Sep 2005 21:38:49 +0300
In-Reply-To: 
X-Mailer: git-send-email-script
To: git@vger.kernel.org
X-Mime-Autoconverted: from 8bit to 7bit by courier 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8108>

This script simply reports the version of git you have installed.

Signed-off-by: Martin Atukunda <matlads@ds.co.ug>

---

 Documentation/git-version-script.txt |   36 ++++++++++++++++++++++++++++++++++
 Makefile                             |    9 +++++++--
 git-version-script.in                |    9 +++++++++
 3 files changed, 52 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/git-version-script.txt
 create mode 100644 git-version-script.in

c0ef77fa3fdf8edcce51f3ed32f5ec5b96f6db63
diff --git a/Documentation/git-version-script.txt b/Documentation/git-version-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-version-script.txt
@@ -0,0 +1,36 @@
+git-version-script(1)
+===================
+v0.99.5, Aug 2005
+
+NAME
+----
+git-version-script - Prints the current version of git
+
+
+SYNOPSIS
+--------
+'git-version-script'
+
+DESCRIPTION
+-----------
+
+This simple script simply prints the version of git you are currently
+running. The version is generated at release time, and stored in the script
+for later use.
+
+OPTIONS
+-------
+This program takes no options
+
+Author
+------
+Written by Martin Atukunda <matlads@dsmagic.com>
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -66,7 +66,7 @@ SCRIPTS=git git-merge-one-file-script gi
 	git-format-patch-script git-sh-setup-script git-push-script \
 	git-branch-script git-parse-remote-script git-verify-tag-script \
 	git-ls-remote-script git-clone-dumb-http git-rename-script \
-	git-request-pull-script git-bisect-script
+	git-request-pull-script git-bisect-script git-version-script
 
 SCRIPTS += git-count-objects-script
 SCRIPTS += git-revert-script
@@ -230,8 +230,12 @@ install-doc:
 git-core.spec: git-core.spec.in Makefile
 	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@
 
+git-version-script: git-version-script.in Makefile
+	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@
+	chmod +x $@
+
 GIT_TARNAME=git-core-$(GIT_VERSION)
-dist: git-core.spec git-tar-tree
+dist: git-core.spec git-version-script git-tar-tree
 	./git-tar-tree HEAD $(GIT_TARNAME) > $(GIT_TARNAME).tar
 	@mkdir -p $(GIT_TARNAME)
 	@cp git-core.spec $(GIT_TARNAME)
@@ -253,6 +257,7 @@ deb: dist
 clean:
 	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE)
 	rm -f git-core.spec
+	rm -f git-version-script
 	rm -rf $(GIT_TARNAME)
 	rm -f $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	rm -f git-core_$(GIT_VERSION)-*.deb git-core_$(GIT_VERSION)-*.dsc
diff --git a/git-version-script.in b/git-version-script.in
new file mode 100644
--- /dev/null
+++ b/git-version-script.in
@@ -0,0 +1,9 @@
+#!/bin/sh
+
+. git-sh-setup-script || die "Not a git archive"
+
+dryrun=
+echo=
+
+echo git version @@VERSION@@
+
