From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add option USE_INPLACE to Makefile
Date: Wed, 16 Nov 2005 03:35:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511160333460.15130@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Nov 16 03:37:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcD9r-0005f2-Pu
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 03:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbVKPCfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 21:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbVKPCfv
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 21:35:51 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:7827 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965189AbVKPCfu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 21:35:50 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7A5CD13F726; Wed, 16 Nov 2005 03:35:49 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5D18BB51F8; Wed, 16 Nov 2005 03:35:49 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E50E859124; Wed, 16 Nov 2005 03:35:48 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D1CEB13F726; Wed, 16 Nov 2005 03:35:48 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11992>


If you plan on adding your current working directory to your PATH, you
can do

	USE_INPLACE=1 make

and you no longer need to worry about setting variables like
GIT_EXEC_PATH and GIT_PYTHON_PATH.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Makefile |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

applies-to: 66be81f4755380a7c9da56aa5fbc600565ff78a8
07f60591a5e881b2a46885ac9b6ba61a4931ac86
diff --git a/Makefile b/Makefile
index 55f4c6b..63c524d 100644
--- a/Makefile
+++ b/Makefile
@@ -50,6 +50,9 @@
 # Define USE_STDEV below if you want git to care about the underlying device
 # change being considered an inode change from the update-cache perspective.
 
+# Define USE_INPLACE if you do not plan to install git anywhere, but rather
+# want to add the working directory to your PATH.
+
 GIT_VERSION = 0.99.9.GIT
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
@@ -60,10 +63,16 @@ ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 
 prefix = $(HOME)
+ifdef USE_INPLACE
+bindir = `pwd`
+template_dir = `pwd`/templates
+GIT_PYTHON_DIR = `pwd`/compat
+else
 bindir = $(prefix)/bin
 template_dir = $(prefix)/share/git-core/templates/
 GIT_PYTHON_DIR = $(prefix)/share/git-core/python
 # DESTDIR=
+endif
 
 CC = gcc
 AR = ar
@@ -432,6 +441,8 @@ check:
 
 ### Installation rules
 
+ifndef USE_INPLACE
+
 install: $(PROGRAMS) $(SCRIPTS) git
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(bindir))
 	$(INSTALL) git $(PROGRAMS) $(SCRIPTS) $(call shellquote,$(DESTDIR)$(bindir))
@@ -468,6 +479,8 @@ deb: dist
 	dpkg-source -b $(GIT_TARNAME)
 	cd $(GIT_TARNAME) && fakeroot debian/rules binary
 
+endif
+
 ### Cleaning rules
 
 clean:
---
0.99.9.GIT
