Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979FFC433FE
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEA961A7D
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbhKPMHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbhKPMEn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:04:43 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9E6C06122F
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:49 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u1so37056035wru.13
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RslYP/bFBNufLqifQGzjMCRo5PCwulHM513xwWFpLSk=;
        b=PThn51o1W0lpXHHvRzfvzpbSVP7Tiha/P6vb9eDr2rOXF0b/2oGAQwuRMhXOdl/KUk
         00U4ZUmQtkR4t5KMoRJ+8rJV0IkGS0+J+dy1KzQGbJGzjLweYPRhOjpm0wNW4d6yFAjL
         z6ihk0XCn3bmWFK6vveLh5H+zZvqxAbDPXLsCcm2TBRK+zfLtzonou0olfDVM/CW1YSp
         ugEXFp6TY2bNfK8rE+ciI9sgMAj9DWhBV4V4nJs5FvVnq7SVrpvX4vwvWvSjDFlP0eis
         rb5r4sAnZsDqX5wQhv2GFY1f77Z2Vmt6akDAQbJPcV54TXZPWqo5X5rBdUJIBxXA5Hec
         2i+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RslYP/bFBNufLqifQGzjMCRo5PCwulHM513xwWFpLSk=;
        b=3xElI0ot8bNUENPIndLnwpXNzCzsoknRKEbuwzwwvdKUTgfDIhsWuoQ71FyaM7u3aq
         +N2PlS40IcyaPK/7lu4x27abT+s29g1+VWmhCCfJzoTiRmt8nQp5Fw/V17M4Pwgj56PA
         GEJCkyjlvrqfkangDyuf/H4wPpMbdIP53QLYOpe4S6DH2ijHxVIUFjV02Ya0RyF06jiG
         cjLK7dK3b/0ZA0JcZuipUg5eusMnreRIcgJ/onZpusX9cXESyaNELA1sfq48C94++Mbk
         kqutkjYPLis/dL4MVH3B5Li93xmVO86s3T2YtbJY2dzF9+2YOa6LeuMaYGtLsd05Klt1
         iyNw==
X-Gm-Message-State: AOAM531fI2H9Sf3ecmzqzNnsdv65lVN8GRMoTrID1VG6j0SNcLTtsq/p
        nmidXVugce3FOTf5UJE75vro5Uvf5+Ebvg==
X-Google-Smtp-Source: ABdhPJw4TMLHCogahYJfyEtJUrUyDpMMI7mIaEmRvOHETWIJaqy1oUP36E2vjcM5nyDN/ZQ1DEVvQg==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr8517113wrt.88.1637064048214;
        Tue, 16 Nov 2021 04:00:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 16/23] Makefile: add "$(QUIET)" boilerplate to shared.mak
Date:   Tue, 16 Nov 2021 13:00:16 +0100
Message-Id: <patch-v3-16.23-a3e3acea82d-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
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
2.34.0.795.g1e9501ab396

