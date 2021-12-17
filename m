Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B36C433FE
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 01:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhLQBjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 20:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhLQBjj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 20:39:39 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88BDC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:38 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o29so616273wms.2
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyVBH3sZQepEVI6dEFZrH40mf+gCCnzro3wu2dkszU8=;
        b=ig10vj0YZfWeF3Yow4ckKSN1idgsBieHdlUb5hyB0jd9808kpltc6TxNDn5Neg+WhV
         ON8zU5mUMC3GN96pUVcxDENn61jT3O8AziTpKt3K+uMtEVxv2JmE7QJxY+0oQjLyxg+Q
         ufheMYQ0bKY1UOd67vPkuOoG/D7SvnNkUx2wG4bFRZWIuWN9gG4MLxFPFoZ+SwMpl6Lm
         KR034UYUSIKrKnC5o+UIPgT+Hn89rnIezdwOA2VmPx/PQl4JjtjSbJuo/4e028+R3D9H
         CLnTSlXTa0v/dOP8BA3TypP/j+iKaxwsg7lQMFq1Ycw+0zj6WZxlhJZw8+yEdHZnG2nG
         dLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyVBH3sZQepEVI6dEFZrH40mf+gCCnzro3wu2dkszU8=;
        b=yk7qZOAGpAUFHYdAZd/IrhKHKj2oHFl87EMY8VvsKWPrC+32XGnCSpjeZd02qkucrb
         w4agy6+dpn0nnxJ2WXfUSiukPreODzZkdbWeU7AcuxCOvhtfwS5b4vDmWdmP2xWQeVRc
         HDadR1bEHARGYMFQhwVaMztwdKsl3PzGHWawk9B7Xg0JBSALOXCbr3vIJ8D5NVv2erI5
         xST4shj3O7IZbPDtNfsjakOrWDcWUuC/lEShb1URooOx2RxJCi/TzBXpzDQTotU0yXAM
         B3Stq0JT0Y+w7wmWnG3d60T5JzWd6AKSGsdkjoRjIY6+6vhGOv1JTdNWuPe1uTnh4wEu
         GQXA==
X-Gm-Message-State: AOAM531azUzcgtiZeTRN9SaS3iVIFW2fYtHNmWoR27VXObWVDkNECfsE
        IuYt/S8q7HOK/wL1T67XcX5jCZSYSQhUeA==
X-Google-Smtp-Source: ABdhPJxzglCcC6MvAVO6NpD8aWoCI4ZitCa/MJcgU/PymDAdJZRXqJf0xHlYKpa3+TZsi//tI1zaYQ==
X-Received: by 2002:a05:600c:3ac6:: with SMTP id d6mr510562wms.191.1639705177151;
        Thu, 16 Dec 2021 17:39:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c4sm5843869wrr.37.2021.12.16.17.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 17:39:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/8] Makefile: add "$(QUIET)" boilerplate to shared.mak
Date:   Fri, 17 Dec 2021 02:39:24 +0100
Message-Id: <patch-6.8-c25284b24cf-20211217T012902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
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
index ba27456c86a..0f4ebdeda8a 100644
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
index 4dfb88ccb3f..9f27fc77e5a 100644
--- a/Makefile
+++ b/Makefile
@@ -1970,39 +1970,6 @@ ifndef PAGER_ENV
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
index a3a779327f8..cfc2416c935 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -720,7 +720,6 @@ vcxproj:
 	git diff-index --cached --quiet HEAD --
 
 	# Make .vcxproj files and add them
-	unset QUIET_GEN QUIET_BUILT_IN; \
 	perl contrib/buildsystems/generate -g Vcxproj
 	git add -f git.sln {*,*/lib,t/helper/*}/*.vcxproj
 
diff --git a/shared.mak b/shared.mak
index b34fb948c0f..d6f70f3d6c9 100644
--- a/shared.mak
+++ b/shared.mak
@@ -31,3 +31,56 @@
 comma = ,
 empty =
 space = $(empty) $(empty)
+
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
diff --git a/templates/Makefile b/templates/Makefile
index 636cee52f51..367ad00c24c 100644
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
2.34.1.1119.g7a3fc8778ee

