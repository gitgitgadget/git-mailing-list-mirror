From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Add doc and install-doc targets to the Makefile
Date: Thu, 14 Jul 2005 19:21:57 -0600
Message-ID: <m1u0iwx3re.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 03:23:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtEvH-0004h1-AJ
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 03:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbVGOBWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 21:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbVGOBWT
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 21:22:19 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37309 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263059AbVGOBWO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 21:22:14 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6F1LvW1021937;
	Thu, 14 Jul 2005 19:21:57 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6F1LvUp021936;
	Thu, 14 Jul 2005 19:21:57 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This makes it straight forward for people wanting to build
and install the git man pages and the rest of the documentation
to do so.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 Documentation/Makefile |   13 +++++++++++++
 Makefile               |    6 ++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

81c744189071d241dbb43b55b8694365a769e08d
diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -6,6 +6,14 @@ DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_
 DOC_MAN1=$(patsubst %.txt,%.1,$(MAN1_TXT))
 DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT))
 
+prefix=$(HOME)
+bin=$(prefix)/bin
+mandir=$(prefix)/man
+man1=$(mandir)/man1
+man7=$(mandir)/man7
+
+INSTALL=install
+
 #
 # Please note that there is a minor bug in asciidoc.
 # The version after 6.0.3 _will_ include the patch found here:
@@ -24,6 +32,11 @@ man: man1 man7
 man1: $(DOC_MAN1)
 man7: $(DOC_MAN7)
 
+install:
+	$(INSTALL) -m755 -d $(dest)/$(man1) $(dest)/$(man7)
+	$(INSTALL) $(DOC_MAN1) $(dest)/$(man1)
+	$(INSTALL) $(DOC_MAN7) $(dest)/$(man7)
+
 # 'include' dependencies
 git-diff-%.txt: diff-format.txt diff-options.txt
 	touch $@
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -191,6 +191,12 @@ rpm: dist
 test: all
 	$(MAKE) -C t/ all
 
+doc:
+	$(MAKE) -C Documentation all
+
+install-doc:
+	$(MAKE) -C Documentation install
+
 clean:
 	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE)
 	rm -f git-core-*.tar.gz git-core.spec
