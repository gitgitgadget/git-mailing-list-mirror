From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] Allow INSTALL, bindir, mandir to be set in main Makefile
Date: Thu, 29 Jun 2006 22:11:25 +0200
Message-ID: <200606292211.28352.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 29 22:11:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw2rO-0001KS-AF
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 22:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWF2UL3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 16:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWF2UL3
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 16:11:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:4047 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932400AbWF2UL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 16:11:27 -0400
Received: by ug-out-1314.google.com with SMTP id a2so548498ugf
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 13:11:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uu9MrKka/6xQEy/URG1LwUl0/iowRjeixSGIlycotaJhSVe+TadPpzaCkmZO0dAQXrodmvDcUrB+ZMOldjI+yikLRiwWGWrwt+9vOWfdllAd2YcGU9kRpQ1XYxF4mjzPz6/al8fDyVORWvR92ESHE9iFBoeL+gwSK6f70TiheXo=
Received: by 10.66.220.17 with SMTP id s17mr2313986ugg;
        Thu, 29 Jun 2006 13:11:26 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id y7sm438608ugc.2006.06.29.13.11.25;
        Thu, 29 Jun 2006 13:11:25 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22897>

Makefiles in subdirectories now use existing value of INSTALL, bindir,
mandir if it is set, allowing those to be set in main Makefile or in
included config.mak.  Main Makefile exports variables which it sets.

Accidentally it renames bin to bindir in Documentation/Makefile
(should be bindir from start, but is unused, perhaps to be removed).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Series only because second patch in series depends textually on first,
even though changes are independent.

 Documentation/Makefile   |    4 ++--
 Makefile                 |    2 ++
 contrib/emacs/Makefile   |    4 ++--
 contrib/git-svn/Makefile |    4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2b0efe7..ca6b77d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -25,8 +25,8 @@ DOC_MAN1=$(patsubst %.txt,%.1,$(MAN1_TXT
 DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT))
 
 prefix?=$(HOME)
-bin=$(prefix)/bin
-mandir=$(prefix)/man
+bindir?=$(prefix)/bin
+mandir?=$(prefix)/man
 man1=$(mandir)/man1
 man7=$(mandir)/man7
 # DESTDIR=
diff --git a/Makefile b/Makefile
index cde619c..b8fe669 100644
--- a/Makefile
+++ b/Makefile
@@ -100,6 +100,8 @@ template_dir = $(prefix)/share/git-core/
 GIT_PYTHON_DIR = $(prefix)/share/git-core/python
 # DESTDIR=
 
+export prefix bindir gitexecdir template_dir GIT_PYTHON_DIR
+
 CC = gcc
 AR = ar
 TAR = tar
diff --git a/contrib/emacs/Makefile b/contrib/emacs/Makefile
index d3619db..350846d 100644
--- a/contrib/emacs/Makefile
+++ b/contrib/emacs/Makefile
@@ -3,9 +3,9 @@ ## Build and install stuff
 EMACS = emacs
 
 ELC = git.elc vc-git.elc
-INSTALL = install
+INSTALL ?= install
 INSTALL_ELC = $(INSTALL) -m 644
-prefix = $(HOME)
+prefix ?= $(HOME)
 emacsdir = $(prefix)/share/emacs/site-lisp
 
 all: $(ELC)
diff --git a/contrib/git-svn/Makefile b/contrib/git-svn/Makefile
index 7c20946..1a6585e 100644
--- a/contrib/git-svn/Makefile
+++ b/contrib/git-svn/Makefile
@@ -1,8 +1,8 @@
 all: git-svn
 
 prefix?=$(HOME)
-bindir=$(prefix)/bin
-mandir=$(prefix)/man
+bindir?=$(prefix)/bin
+mandir?=$(prefix)/man
 man1=$(mandir)/man1
 INSTALL?=install
 doc_conf=../../Documentation/asciidoc.conf
-- 
1.4.0
