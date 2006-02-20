From: Paul Jakma <paul@clubi.ie>
Subject: [PATCH] Makefile tweaks: Solaris 9+ dont need iconv / move up uname
 variables
Date: Mon, 20 Feb 2006 23:36:28 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0602202335020.31425@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 21 00:35:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBKZ5-0007DL-Lm
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 00:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161202AbWBTXfa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 18:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161201AbWBTXfa
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 18:35:30 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:38044 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1161199AbWBTXf2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 18:35:28 -0500
Received: from sheen.jakma.org (IDENT:U2FsdGVkX1+NchryQA7g0I98FYpbCGwbPhBPw/cs8Cg@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id k1KNZ5w5011705;
	Mon, 20 Feb 2006 23:35:17 GMT
X-X-Sender: paul@sheen.jakma.org
To: git list <git@vger.kernel.org>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16509>

- Solaris 9 and up do not need -liconv, so NEEDS_LIBICONV should be set
   only for S8.
- Move the declaration of the uname variables to early in the Makefile
   so they can be referenced by prefix and gitexecdir variables.
- gitexecdir defaults to being same as bindir, it might as well reference
   that variable.

Signed-off-by: Paul Jakma <paul@quagga.net>

---

  Makefile |   15 ++++++++-------
  1 files changed, 8 insertions(+), 7 deletions(-)

6ee3566e9b5408b7bfedbb6ffcdbac1be6bafbbb
diff --git a/Makefile b/Makefile
index 317be3c..a225e9c 100644
--- a/Makefile
+++ b/Makefile
@@ -70,7 +70,12 @@ all:

  GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
  	@$(SHELL_PATH) ./GIT-VERSION-GEN
--include GIT-VERSION-FILE
+
+uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
+uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
+uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
+uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
+uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')

  # CFLAGS and LDFLAGS are for the users to override from the command line.

@@ -82,7 +87,7 @@ STRIP ?= strip

  prefix = $(HOME)
  bindir = $(prefix)/bin
-gitexecdir = $(prefix)/bin
+gitexecdir = $(bindir)
  template_dir = $(prefix)/share/git-core/templates/
  GIT_PYTHON_DIR = $(prefix)/share/git-core/python
  # DESTDIR=
@@ -212,10 +217,6 @@ shellquote = '$(call shq,$(1))'
  # We choose to avoid "if .. else if .. else .. endif endif"
  # because maintaining the nesting to match is a pain.  If
  # we had "elif" things would have been much nicer...
-uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
-uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
-uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
-uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')

  ifeq ($(uname_S),Darwin)
  	NEEDS_SSL_WITH_CRYPTO = YesPlease
@@ -230,10 +231,10 @@ endif
  ifeq ($(uname_S),SunOS)
  	NEEDS_SOCKET = YesPlease
  	NEEDS_NSL = YesPlease
-	NEEDS_LIBICONV = YesPlease
  	SHELL_PATH = /bin/bash
  	NO_STRCASESTR = YesPlease
  	ifeq ($(uname_R),5.8)
+		NEEDS_LIBICONV = YesPlease
  		NO_UNSETENV = YesPlease
  		NO_SETENV = YesPlease
  	endif
-- 
1.2.1
