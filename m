From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 2/2] configure.ac: use GIT_CC_CHECK_FLAG_APPEND for adding --with-gcc-warnings configure option
Date: Mon,  3 Nov 2014 06:57:21 -0800
Message-ID: <1415026641-24767-3-git-send-email-gitter.spiros@gmail.com>
References: <1415026641-24767-1-git-send-email-gitter.spiros@gmail.com>
Cc: jnareb@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 15:57:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlJ4i-00049Z-TD
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 15:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbaKCO5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 09:57:41 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33708 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbaKCO5j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 09:57:39 -0500
Received: by mail-pd0-f172.google.com with SMTP id r10so11620185pdi.17
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 06:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ISZ6RRgSPAb6AK+iMFzBDz4V+VXc602q1EwwkznjwnM=;
        b=JS/qcV6KwebsRme19pv0V+N0Rs+sJowhoZZzCZ/KGnmtwK+4kE5sYMk+VzFCEH7jLa
         EE2kthFJC9wJR31pVQxjh4fl6thJiOkUG2YcGPr0DWTx2W2ImNvM6Qh22FTxa9Fp8FJ2
         pP5TbdZOqMPkfIyVd5rkb/9yDugj8fvC3tNpSSfzmHhNZpoXA4SK0QZwYmjpH9/fQLde
         gomHfKTtnlZUyK80t6uxWy0BlWULHw81e1yFwR4J4TRNltZERGCIs7vFyX/Oi7aJtdrO
         qQ9Knr61JrKCch0YL/QwG3n947g1ygPGfBLOOKNMrkVFpqCdvMIIzwppOCTeMHTq4Pn1
         oKwA==
X-Received: by 10.66.233.37 with SMTP id tt5mr44300744pac.11.1415026659108;
        Mon, 03 Nov 2014 06:57:39 -0800 (PST)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id ri9sm17409373pbc.5.2014.11.03.06.57.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Nov 2014 06:57:38 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1415026641-24767-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the GIT_CC_CHECK_FLAGS_APPEND autoconf macro
for add in a portable way the new configure option
--enable-gcc-warnings (default off).

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 Makefile     |   12 ++++++--
 configure.ac |   96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 23485f1..9db34e2 100644
--- a/Makefile
+++ b/Makefile
@@ -344,11 +344,9 @@ GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
-GIT_CFLAGS  =
-GIT_LDFLAGS =
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
-CFLAGS = -g -O2 -Wall $(GIT_CFLAGS)
+CFLAGS = -g -O2 -Wall 
 LDFLAGS = $(GIT_LDFLAGS)
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
@@ -1517,6 +1515,14 @@ ifdef DEFAULT_HELP_FORMAT
 BASIC_CFLAGS += -DDEFAULT_HELP_FORMAT='"$(DEFAULT_HELP_FORMAT)"'
 endif
 
+ifdef GIT_CFLAGS
+BASIC_CFLAGS += $(GIT_CFLAGS)
+endif
+
+ifdef GIT_LDFLAGS
+BASIC_LDFLAGS += $(GIT_LDFLAGS)
+endif
+
 ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
 
diff --git a/configure.ac b/configure.ac
index c67ca60..95d5d10 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,4 +1,4 @@
-#                                               -*- Autoconf -*-
+#                                               -*- Autoconf -*- \
 # Process this file with autoconf to produce a configure script.
 
 ## Definitions of private macros.
@@ -433,7 +433,99 @@ AS_HELP_STRING([],[ARG is the full path to the Tcl/Tk interpreter.])
 AS_HELP_STRING([],[Bare --with-tcltk will make the GUI part only if])
 AS_HELP_STRING([],[Tcl/Tk interpreter will be found in a system.]),
 GIT_PARSE_WITH(tcltk))
-#
+
+
+# Turn gcc warning
+
+AC_ARG_ENABLE([gcc-warnings],
+  [AS_HELP_STRING([--enable-gcc-warnings],
+                  [turn on GCC warnings (for developers)@<:@default=no@:>@])],
+  [case $enableval in
+     yes|no) ;;
+     *)      AC_MSG_ERROR([bad value $enableval for gcc-warnings option]) ;;
+   esac
+   git_gcc_warnings=$enableval],
+  [git_gcc_warnings=no]
+)
+
+AS_IF([test "x$git_gcc_warnings" = xyes ],[ 
+# Add/Delete as needed
+GIT_CC_CHECK_FLAGS_APPEND([with_cflags], [CFLAGS], [\
+  -Wall  \
+  -Wextra  \
+  -Wformat-y2k  \
+  -fdiagnostics-show-option \
+  -funit-at-a-time \
+  -fstrict-aliasing \
+  -Wstrict-overflow \
+  -fstrict-overflow \
+  -Wpointer-arith \
+  -Wundef \
+  -Wformat-security \
+  -Winit-self \
+  -Wmissing-include-dirs \
+  -Wunused \
+  -Wunknown-pragmas \
+  -Wstrict-aliasing \
+  -Wshadow \
+  -Wbad-function-cast \
+  -Wcast-align \
+  -Wwrite-strings \
+  -Wlogical-op \
+  -Waggregate-return \
+  -Wstrict-prototypes \
+  -Wold-style-definition \
+  -Wmissing-prototypes \
+  -Wmissing-declarations \
+  -Wmissing-noreturn \
+  -Wmissing-format-attribute \
+  -Wredundant-decls \
+  -Wnested-externs \
+  -Winline \
+  -Winvalid-pch \
+  -Wvolatile-register-var \
+  -Wdisabled-optimization \
+  -Wbuiltin-macro-redefined \
+  -Wmudflap \
+  -Wpacked-bitfield-compat \
+  -Wsync-nand \
+  -Wattributes \
+  -Wcoverage-mismatch \
+  -Wmultichar \
+  -Wcpp \
+  -Wdeprecated-declarations \
+  -Wdiv-by-zero \
+  -Wdouble-promotion \
+  -Wendif-labels \
+  -Wformat-contains-nul \
+  -Wformat-extra-args \
+  -Wformat-zero-length \
+  -Wformat=2 \
+  -Wmultichar \
+  -Wnormalized=nfc \
+  -Woverflow \
+  -Wpointer-to-int-cast \
+  -Wpragmas \
+  -Wsuggest-attribute=const \
+  -Wsuggest-attribute=noreturn \
+  -Wsuggest-attribute=pure \
+  -Wtrampolines \
+  -Wno-missing-field-initializers \
+  -Wno-sign-compare \
+  -Wjump-misses-init \
+  -Wno-format-nonliteral \
+  -fstack-protector-all \
+  -fasynchronous-unwind-tables \
+  -fdiagnostics-show-option \
+  -funit-at-a-time \
+  -fipa-pure-const \
+  -Wno-aggregate-return \
+  -Wno-redundant-decls \
+  -Wdeclaration-after-statement ])
+
+GIT_CONF_SUBST([GIT_CFLAGS],[$with_cflags])
+])
+
 
 
 ## Checks for programs.
-- 
1.7.10.4
