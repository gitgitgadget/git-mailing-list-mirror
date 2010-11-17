From: Norbert Nemec <Norbert@Nemec-online.de>
Subject: patch for AIX system
Date: Wed, 17 Nov 2010 08:29:54 +0100
Message-ID: <4CE38472.8070206@Nemec-online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020301040702050002030001"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 17 08:30:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIcT3-0001Nj-8h
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 08:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934441Ab0KQHaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 02:30:02 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33241 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933423Ab0KQHaB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 02:30:01 -0500
Received: by ewy8 with SMTP id 8so949134ewy.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 23:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:subject:content-type;
        bh=EovZdASGpgBvJLNbr1xIb/FKRFxlwXxZY0fvlo9RWfQ=;
        b=g9IM3p0lMHzeq4rFVTZEEIDV7W1J4zQ0y+AA2BxFv3ZRFbwSeTfKdt6bLIXk+7CLs4
         rKRdKC+OGG37nVcpR1anafxWh+91tq1/IqHCqvL5cUkre9Q58Hhag7iRuznsZRn3seSq
         bqifubTPAA/EuAM2O3zIdOgnIB9e5zczblyZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type;
        b=gTP7ZfZ9OdvOeF2jC7ZQ/1554JPJ3K1BSDym7Brn/CmvhEITrrVHZQW+WBXW0mkEvP
         hD2tGgTK/qlQGeVEL633d+wrPd2Xj9u8b6AaG9DWEfvR56W9U9o15SXwmOF97NFQOTp7
         ez1GGvznFpEePGySmU/iusFdQkCYkbLTzoC0I=
Received: by 10.213.104.135 with SMTP id p7mr197941ebo.92.1289978999814;
        Tue, 16 Nov 2010 23:29:59 -0800 (PST)
Received: from [141.14.151.101] (marble.rz-berlin.mpg.de [141.14.151.101])
        by mx.google.com with ESMTPS id q58sm2009575eeh.15.2010.11.16.23.29.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 23:29:58 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161602>

This is a multi-part message in MIME format.
--------------020301040702050002030001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Find attached a small patch to make git install cleanly on an AIX system

-- 
_______________________________________________Norbert Nemec
   Lilienstr. 5a ... 12203 Berlin-Lichterfelde ... Germany
       Tel: +49-30-5483 3143 Mobile: +49-176-5502 5643
           eMail:<Norbert@Nemec-online.de>


--------------020301040702050002030001
Content-Type: text/x-diff;
 name="0001-Fix-for-installation-on-AIX.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Fix-for-installation-on-AIX.patch"

>From def4428ad827d1e6550634a2fe1f035c1b148426 Mon Sep 17 00:00:00 2001
From: Norbert Nemec <Norbert@Nemec-online.de>
Date: Wed, 17 Nov 2010 08:25:44 +0100
Subject: [PATCH] Fix for installation on AIX

The BSD style 'install' command is call 'installbsd' and does not support the -d option.
Therefore '$(INSTALL) -d' is replaced by a new variable '$(INSTALLDIR)' in all Makefiles
which can be changed independently of $(INSTALL).
---
 Documentation/Makefile |   10 +++++-----
 Makefile               |    7 +++++--
 git-gui/Makefile       |    4 ++--
 gitk-git/Makefile      |    2 +-
 gitweb/Makefile        |    4 ++--
 templates/Makefile     |    2 +-
 6 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e117bc4..c2db8db 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -180,15 +180,15 @@ pdf: user-manual.pdf
 install: install-man
 
 install-man: man
-	$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
-	$(INSTALL) -d -m 755 $(DESTDIR)$(man5dir)
-	$(INSTALL) -d -m 755 $(DESTDIR)$(man7dir)
+	$(INSTALLDIR) -m 755 $(DESTDIR)$(man1dir)
+	$(INSTALLDIR) -m 755 $(DESTDIR)$(man5dir)
+	$(INSTALLDIR) -m 755 $(DESTDIR)$(man7dir)
 	$(INSTALL) -m 644 $(DOC_MAN1) $(DESTDIR)$(man1dir)
 	$(INSTALL) -m 644 $(DOC_MAN5) $(DESTDIR)$(man5dir)
 	$(INSTALL) -m 644 $(DOC_MAN7) $(DESTDIR)$(man7dir)
 
 install-info: info
-	$(INSTALL) -d -m 755 $(DESTDIR)$(infodir)
+	$(INSTALLDIR) -m 755 $(DESTDIR)$(infodir)
 	$(INSTALL) -m 644 git.info gitman.info $(DESTDIR)$(infodir)
 	if test -r $(DESTDIR)$(infodir)/dir; then \
 	  $(INSTALL_INFO) --info-dir=$(DESTDIR)$(infodir) git.info ;\
@@ -198,7 +198,7 @@ install-info: info
 	fi
 
 install-pdf: pdf
-	$(INSTALL) -d -m 755 $(DESTDIR)$(pdfdir)
+	$(INSTALLDIR) -m 755 $(DESTDIR)$(pdfdir)
 	$(INSTALL) -m 644 user-manual.pdf $(DESTDIR)$(pdfdir)
 
 install-html: html
diff --git a/Makefile b/Makefile
index 1f1ce04..2664d7c 100644
--- a/Makefile
+++ b/Makefile
@@ -308,6 +308,7 @@ DIFF = diff
 TAR = tar
 FIND = find
 INSTALL = install
+INSTALLDIR = install -d
 RPMBUILD = rpmbuild
 TCL_PATH = tclsh
 TCLTK_PATH = wish
@@ -953,6 +954,8 @@ ifeq ($(uname_S),AIX)
 	NO_MKSTEMPS = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_NSEC = YesPlease
+	INSTALL = installbsd
+	INSTALLDIR = mkdir -p
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	INTERNAL_QSORT = UnfortunatelyYes
 	NEEDS_LIBICONV=YesPlease
@@ -2103,8 +2106,8 @@ export gitexec_instdir
 install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
 
 install: all
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALLDIR) -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALLDIR) -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
diff --git a/git-gui/Makefile b/git-gui/Makefile
index e22ba5c..b96b3df 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -48,7 +48,7 @@ endif
 RM_RF     ?= rm -rf
 RMDIR     ?= rmdir
 
-INSTALL_D0 = $(INSTALL) -d -m 755 # space is required here
+INSTALL_D0 = $(INSTALLDIR) -m 755 # space is required here
 INSTALL_D1 =
 INSTALL_R0 = $(INSTALL) -m 644 # space is required here
 INSTALL_R1 =
@@ -76,7 +76,7 @@ ifndef V
 	QUIET_2DEVNULL = 2>/dev/null
 
 	INSTALL_D0 = dir=
-	INSTALL_D1 = && echo ' ' DEST $$dir && $(INSTALL) -d -m 755 "$$dir"
+	INSTALL_D1 = && echo ' ' DEST $$dir && $(INSTALLDIR) -m 755 "$$dir"
 	INSTALL_R0 = src=
 	INSTALL_R1 = && echo '   ' INSTALL 644 `basename $$src` && $(INSTALL) -m 644 $$src
 	INSTALL_X0 = src=
diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index e1b6045..b838d87 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -41,7 +41,7 @@ all:: gitk-wish $(ALL_MSGFILES)
 
 install:: all
 	$(INSTALL) -m 755 gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(msgsdir_SQ)'
+	$(INSTALLDIR) -m 755 '$(DESTDIR_SQ)$(msgsdir_SQ)'
 	$(foreach p,$(ALL_MSGFILES), $(INSTALL) -m 644 $p '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true
 
 uninstall::
diff --git a/gitweb/Makefile b/gitweb/Makefile
index e32ee76..3f1ac82 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -148,9 +148,9 @@ gitweb.cgi: gitweb.perl GITWEB-BUILD-OPTIONS
 ### Installation rules
 
 install: all
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
+	$(INSTALLDIR) -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
+	$(INSTALLDIR) -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 
 ### Cleaning rules
diff --git a/templates/Makefile b/templates/Makefile
index d22a71a..3808b04 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -61,6 +61,6 @@ clean:
 	$(RM) -r blt boilerplates.made
 
 install: all
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
+	$(INSTALLDIR) -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
 	(cd blt && $(TAR) cf - .) | \
 	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xof -)
-- 
1.7.1


--------------020301040702050002030001--
