Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB71DC433FE
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9860560FE7
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbhKLVw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbhKLVwO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:52:14 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B086C061208
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:23 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 133so8927271wme.0
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XQ5xeBHjZa60yUgfC8O4gIeHCN7/iJAwfCfoJ/ENCTw=;
        b=J52YuoQ5f8ks7arMi4iMMqy61kkO4hVMaYbrSzUm7LsZy0+lt49ihO64SaDImtrZSc
         vJtYX7wkaGl5+bmWOLIjekJZJMKuGu29dB/L0QFGis7smpLbEJWNWi+fCFc9bciG20Aq
         08PHpiwc3WRlMnzYnk91UlontxYPO1rNPGJ5I9wjwz4uLjdQtS+SgLUC4dJGPgD9vL46
         nKHhs8dbc/SgCW7In9zWFf/p5pfj4cNojK/72I658VO4j6/vL9jox5V0aD/PaVnOx7LJ
         Pm00M6T6wbG5fAECUPhPBQyQKi6CJXW7r+aMePjAhYE8hnGD2cAGJDk4B49vqxy+StOb
         QnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQ5xeBHjZa60yUgfC8O4gIeHCN7/iJAwfCfoJ/ENCTw=;
        b=ALe5YNMK2Wq0SHMOV1uD6csQh9vkjtNQLktxtVuU9z19apvhxFJYybLeaOOgbAgzog
         oFC7YaqWZxZaVQrHTQlQuarLS8U3OocMTGmMCd5AdpZQXN5nvtHEeBYg1YMJfJ8deNRm
         0vh7TiNcZ+hy/MDMW8UqQp7HJbwmGrpsmf09crvkYZOmTtRUiCqJb0ETy360+3w8sAMj
         0C8iQtWpJB5qwsv1zqLmbCHchgAFVj+vIO2Adz/0VfjTQLtJpgmlpi9Horccbql3Ejku
         t4jcZn5An+QG+iuPdCRui15Sc0yaj8ojhcXwCYStTwRsEbOVMjOrm9tFvHta3rNq+Jrg
         HV6g==
X-Gm-Message-State: AOAM530hxZNTVfJqq6OZNGnYI6ZGk2uiDXjaCSOw93ZmeMD6wYWqBSpB
        JIdAomIq8mr4SMmktUqLghK0Mv9n7AHqZw==
X-Google-Smtp-Source: ABdhPJz3ShPx+nZG7hZuC+8jVf+fs5boUjAYrspIr2g+qWCTqSS2uLmJQjafZdT+YIr6766lduASMw==
X-Received: by 2002:a05:600c:1990:: with SMTP id t16mr20403668wmq.48.1636753761771;
        Fri, 12 Nov 2021 13:49:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm14117189wmc.43.2021.11.12.13.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:49:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 16/18] Makefile: add "$(QUIET)" boilerplate to shared.mak
Date:   Fri, 12 Nov 2021 22:49:00 +0100
Message-Id: <patch-v2-16.18-0a348b54491-20211112T214150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The $(QUIET) variables we define are largely duplicated between our
various Makefiles, let's define them in the new "shared.mak" instead.

Since we're not using the environment to pass these around we don't
need to export the "QUIET_GEN" and "QUIET_BUILT_IN" variables
anymore. The "QUIET_GEN" variable is used in "git-gui/Makefile" and
"gitweb/Makefile", but they've got their own definition for those. The
"QUIET_BUILT_IN" variable is only used in the top-level "Makefile". We
still need to export the "V" variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile | 32 -------------------------
 Makefile               | 33 --------------------------
 config.mak.uname       |  1 -
 shared.mak             | 53 ++++++++++++++++++++++++++++++++++++++++++
 templates/Makefile     |  5 ----
 5 files changed, 53 insertions(+), 71 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 4a939cc2c25..69a9af35397 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -218,38 +218,6 @@ DEFAULT_EDITOR_SQ = $(subst ','\'',$(DEFAULT_EDITOR))
 ASCIIDOC_EXTRA += -a 'git-default-editor=$(DEFAULT_EDITOR_SQ)'
 endif
 
-QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
-QUIET_SUBDIR1  =
-
-ifneq ($(findstring $(MAKEFLAGS),w),w)
-PRINT_DIR = --no-print-directory
-else # "make -w"
-NO_SUBDIR = :
-endif
-
-ifneq ($(findstring $(MAKEFLAGS),s),s)
-ifndef V
-	QUIET		= @
-	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
-	QUIET_XMLTO	= @echo '   ' XMLTO $@;
-	QUIET_DB2TEXI	= @echo '   ' DB2TEXI $@;
-	QUIET_MAKEINFO	= @echo '   ' MAKEINFO $@;
-	QUIET_DBLATEX	= @echo '   ' DBLATEX $@;
-	QUIET_XSLTPROC	= @echo '   ' XSLTPROC $@;
-	QUIET_GEN	= @echo '   ' GEN $@;
-	QUIET_STDERR	= 2> /dev/null
-	QUIET_SUBDIR0	= +@subdir=
-	QUIET_SUBDIR1	= ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
-			  $(MAKE) $(PRINT_DIR) -C $$subdir
-
-	QUIET_LINT_GITLINK	= @echo '   ' LINT GITLINK $<;
-	QUIET_LINT_MANSEC	= @echo '   ' LINT MAN SEC $<;
-	QUIET_LINT_MANEND	= @echo '   ' LINT MAN END $<;
-
-	export V
-endif
-endif
-
 all: html man
 
 html: $(DOC_HTML)
diff --git a/Makefile b/Makefile
index c8a0a1586ca..c437aea9e4a 100644
--- a/Makefile
+++ b/Makefile
@@ -1939,39 +1939,6 @@ ifndef PAGER_ENV
 PAGER_ENV = LESS=FRX LV=-c
 endif
 
-QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
-QUIET_SUBDIR1  =
-
-ifneq ($(findstring w,$(MAKEFLAGS)),w)
-PRINT_DIR = --no-print-directory
-else # "make -w"
-NO_SUBDIR = :
-endif
-
-ifneq ($(findstring s,$(MAKEFLAGS)),s)
-ifndef V
-	QUIET_CC       = @echo '   ' CC $@;
-	QUIET_AR       = @echo '   ' AR $@;
-	QUIET_LINK     = @echo '   ' LINK $@;
-	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
-	QUIET_GEN      = @echo '   ' GEN $@;
-	QUIET_LNCP     = @echo '   ' LN/CP $@;
-	QUIET_XGETTEXT = @echo '   ' XGETTEXT $@;
-	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
-	QUIET_GCOV     = @echo '   ' GCOV $@;
-	QUIET_SP       = @echo '   ' SP $<;
-	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
-	QUIET_RC       = @echo '   ' RC $@;
-	QUIET_SPATCH   = @echo '   ' SPATCH $<;
-	QUIET_SUBDIR0  = +@subdir=
-	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
-			 $(MAKE) $(PRINT_DIR) -C $$subdir
-	export V
-	export QUIET_GEN
-	export QUIET_BUILT_IN
-endif
-endif
-
 ifdef NO_INSTALL_HARDLINKS
 	export NO_INSTALL_HARDLINKS
 endif
diff --git a/config.mak.uname b/config.mak.uname
index d0701f9beb0..1a12d8c635f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -715,7 +715,6 @@ vcxproj:
 	git diff-index --cached --quiet HEAD --
 
 	# Make .vcxproj files and add them
-	unset QUIET_GEN QUIET_BUILT_IN; \
 	perl contrib/buildsystems/generate -g Vcxproj
 	git add -f git.sln {*,*/lib,t/helper/*}/*.vcxproj
 
diff --git a/shared.mak b/shared.mak
index 3b4163e652a..80176f705fc 100644
--- a/shared.mak
+++ b/shared.mak
@@ -35,6 +35,59 @@ space = $(empty) $(empty)
 wspfx = $(space)$(space)$(space)
 wspfx_sq = $(call shellquote,$(wspfx))
 
+### Quieting
+## common
+QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
+QUIET_SUBDIR1  =
+
+ifneq ($(findstring w,$(MAKEFLAGS)),w)
+PRINT_DIR = --no-print-directory
+else # "make -w"
+NO_SUBDIR = :
+endif
+
+ifneq ($(findstring s,$(MAKEFLAGS)),s)
+ifndef V
+## common
+	QUIET_SUBDIR0  = +@subdir=
+	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
+			 $(MAKE) $(PRINT_DIR) -C $$subdir
+
+	QUIET          = @
+	QUIET_GEN      = @echo '   ' GEN $@;
+
+## Used in "Makefile"
+	QUIET_CC       = @echo '   ' CC $@;
+	QUIET_AR       = @echo '   ' AR $@;
+	QUIET_LINK     = @echo '   ' LINK $@;
+	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
+	QUIET_LNCP     = @echo '   ' LN/CP $@;
+	QUIET_XGETTEXT = @echo '   ' XGETTEXT $@;
+	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
+	QUIET_GCOV     = @echo '   ' GCOV $@;
+	QUIET_SP       = @echo '   ' SP $<;
+	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
+	QUIET_RC       = @echo '   ' RC $@;
+	QUIET_SPATCH   = @echo '   ' SPATCH $<;
+
+## Used in "Documentation/Makefile"
+	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
+	QUIET_XMLTO	= @echo '   ' XMLTO $@;
+	QUIET_DB2TEXI	= @echo '   ' DB2TEXI $@;
+	QUIET_MAKEINFO	= @echo '   ' MAKEINFO $@;
+	QUIET_DBLATEX	= @echo '   ' DBLATEX $@;
+	QUIET_XSLTPROC	= @echo '   ' XSLTPROC $@;
+	QUIET_GEN	= @echo '   ' GEN $@;
+	QUIET_STDERR	= 2> /dev/null
+
+	QUIET_LINT_GITLINK	= @echo '   ' LINT GITLINK $<;
+	QUIET_LINT_MANSEC	= @echo '   ' LINT MAN SEC $<;
+	QUIET_LINT_MANEND	= @echo '   ' LINT MAN END $<;
+
+	export V
+endif
+endif
+
 ### Templates
 
 ## Template for making a GIT-SOMETHING, which changes if a
diff --git a/templates/Makefile b/templates/Makefile
index c9251a96622..b056e710b7e 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -2,11 +2,6 @@
 include ../shared.mak
 
 # make and install sample templates
-
-ifndef V
-	QUIET = @
-endif
-
 INSTALL ?= install
 TAR ?= tar
 RM ?= rm -f
-- 
2.34.0.rc2.795.g926201d1cc8

