From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 12/13] Basic build infrastructure for Python scripts
Date: Wed,  4 Nov 2009 20:48:17 +0100
Message-ID: <1257364098-1685-13-git-send-email-srabbelier@gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Cc: Johan Herland <johan@herland.net>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:50:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lrj-0000NL-GR
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758108AbZKDTtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758098AbZKDTtV
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:49:21 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:55343 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758088AbZKDTtR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:49:17 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3490482ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 11:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=p6INgX0BPSVPkbdHB/qAPwTigg8ZOSJ3mSFpND0fmdg=;
        b=kckiXmRQ9tw/ouY5Ttk1SvR652G97jD6sjQqrKvvHY0u3JAKCooP9Ci42OfSquxBjQ
         iBSqiF4FjNoXHitVf86czsiTlF64Tm3uGiAPKoPuG4SnV71JCJPQRM2kzpu0KyKkK3ZR
         Gpq3NkUwau0LAyk29a8RGyfZYUnDOdQbtYtMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mJllvZeUXlZrEJK+yLE9ibFW/ZCSp8ILq56IfGpKA9yLCRxR6A9H2t9S1Le7Ar/JSi
         T/940rZDxe1twDtt2AX6x3UgTdz0iYOqPZUccw4Pyuds7nJjqmIwTsGXxeN98i11tZo4
         Qq0Bc5B8TR5/c/+g4MVRkFJiAcVa1Z9s26/L0=
Received: by 10.213.50.139 with SMTP id z11mr2228837ebf.36.1257364162923;
        Wed, 04 Nov 2009 11:49:22 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 5sm4314489eyh.2.2009.11.04.11.49.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 11:49:22 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.295.g0d105
In-Reply-To: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132132>

From: Johan Herland <johan@herland.net>

This patch adds basic boilerplate support (based on corresponding Perl
sections) for enabling the building and installation Python scripts.

There are currently no Python scripts being built, and when Python
scripts are added in future patches, their building and installation
can be disabled by defining NO_PYTHON.

Signed-off-by: Johan Herland <johan@herland.net>
---

	Unchanged.

 Makefile      |   13 +++++++++++++
 configure.ac  |    3 +++
 t/test-lib.sh |    1 +
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 5d5976f..6d1593f 100644
--- a/Makefile
+++ b/Makefile
@@ -168,6 +168,8 @@ all::
 #
 # Define NO_PERL if you do not want Perl scripts or libraries at all.
 #
+# Define NO_PYTHON if you do not want Python scripts or libraries at all.
+#
 # Define NO_TCLTK if you do not want Tcl/Tk GUI.
 #
 # The TCL_PATH variable governs the location of the Tcl interpreter
@@ -312,6 +314,7 @@ LIB_H =
 LIB_OBJS =
 PROGRAMS =
 SCRIPT_PERL =
+SCRIPT_PYTHON =
 SCRIPT_SH =
 TEST_PROGRAMS =
 
@@ -349,6 +352,7 @@ SCRIPT_PERL += git-svn.perl
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
+	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
 	  git-instaweb
 
 # Empty...
@@ -402,8 +406,12 @@ endif
 ifndef PERL_PATH
 	PERL_PATH = /usr/bin/perl
 endif
+ifndef PYTHON_PATH
+	PYTHON_PATH = /usr/bin/python
+endif
 
 export PERL_PATH
+export PYTHON_PATH
 
 LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a
@@ -1315,6 +1323,10 @@ ifeq ($(PERL_PATH),)
 NO_PERL=NoThanks
 endif
 
+ifeq ($(PYTHON_PATH),)
+NO_PYTHON=NoThanks
+endif
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
@@ -1362,6 +1374,7 @@ prefix_SQ = $(subst ','\'',$(prefix))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
+PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 
 LIBS = $(GITLIBS) $(EXTLIBS)
diff --git a/configure.ac b/configure.ac
index b09b8e4..84b6cf4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -233,6 +233,9 @@ GIT_ARG_SET_PATH(shell)
 # Define PERL_PATH to provide path to Perl.
 GIT_ARG_SET_PATH(perl)
 #
+# Define PYTHON_PATH to provide path to Python.
+GIT_ARG_SET_PATH(python)
+#
 # Define ZLIB_PATH to provide path to zlib.
 GIT_ARG_SET_PATH(zlib)
 #
diff --git a/t/test-lib.sh b/t/test-lib.sh
index f2ca536..0b991db 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -729,6 +729,7 @@ case $(uname -s) in
 esac
 
 test -z "$NO_PERL" && test_set_prereq PERL
+test -z "$NO_PYTHON" && test_set_prereq PYTHON
 
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYMLINKS
-- 
1.6.5.2.295.g0d105
