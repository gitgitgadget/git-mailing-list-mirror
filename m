Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AB8C433FE
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 12:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbiCBMuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241951AbiCBMuf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 07:50:35 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06110C24B9
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 04:49:47 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m6so2601505wrr.10
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 04:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ot72xHLajZFyD3Lec7UB0aANHG04dZpu4xXkTRN+Ao8=;
        b=lfsom3x3yde6ZPVow+ZjLX9HGZG6Ri5jDCHoi/86vfuEd9VfQSgfwsfAYBmHk1L6YW
         XeRzfWqweC9PxaT+vKNse6urq1O1Wm9GnOd/C+hE9eRKXBf16EqXwM8RgBhBrvunfnvU
         n1+VTQE7iMeSjJcZJyS4gJnsFvmvglaDuB4NIr8vdQUmf7q69htqndfDPvajHVSiQyfd
         hqtJEqQbPuJ1s0YrodJ/ovDmZ7S/6DSaFWBrBTpYFE8E/EX+HeVjDTC7XP4M1skk0d/N
         mu6LyyARZLCHPm2QrulEshwBSDEfOxyrmrNl0JFhE7ikP7l3Ok65YfAUoWPLblawTrDJ
         723g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ot72xHLajZFyD3Lec7UB0aANHG04dZpu4xXkTRN+Ao8=;
        b=Xrp0fy/GrHcpeY1pnB2NYtODNtgIxO8VtwI54I15Qg5K7JglWq7+dLEXgEb7jbcPd1
         jcg/YApy2UbIdyC4KXd4m1UzpXhLKpNhKWu6aRugLWs/BWA7rdJ1FiBcw3x+MNTVl1fM
         GonQnZ2FffgDIbAok8LYEWRgIAxK0DFxk6Ah8biuydgJfmC0yOg9Q4CPMUoqUD0DPizg
         k1FQ8UhSmwJUlsfXEmgd29Ois4LYi3854F4xjJ8AkYyqfWidm1/4IYbu1LVAu9g9fHsu
         5cZBFfh4NAg1Iiih4m0IrXa2u+GpxBmuKWnFkaRneCfS90eROKWE2vySmQw3dK5LjXVg
         KvKA==
X-Gm-Message-State: AOAM530peEOaf7wx13kDYdnUPuBSCij19JowjRNNQK/qYQasQ8qZfg0R
        Mfeq/edkVq9rFMxfIyYFCkjU0LcxVPzA0w==
X-Google-Smtp-Source: ABdhPJz0PkODnwHBfXjUJ0gFYihcPYXIeDo3AFPabjnk9nhEmTaiFcFwIe0cvyHjQZpz3fuu1bfMng==
X-Received: by 2002:adf:f00e:0:b0:1ed:e1d2:f10c with SMTP id j14-20020adff00e000000b001ede1d2f10cmr23167082wro.181.1646225385269;
        Wed, 02 Mar 2022 04:49:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003811f9102c0sm8210107wmi.32.2022.03.02.04.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:49:44 -0800 (PST)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 7/9] Makefile: add "$(QUIET)" boilerplate to shared.mak
Date:   Wed,  2 Mar 2022 13:49:15 +0100
Message-Id: <patch-v4-7.9-a723cbce270-20220302T124320Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
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
 Documentation/Makefile  | 32 -------------------------
 Makefile                | 33 -------------------------
 config.mak.uname        |  1 -
 contrib/scalar/Makefile | 14 -----------
 shared.mak              | 53 +++++++++++++++++++++++++++++++++++++++++
 templates/Makefile      |  5 ----
 6 files changed, 53 insertions(+), 85 deletions(-)

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
index 1e7a1277ce9..d4c0f4ca7b8 100644
--- a/Makefile
+++ b/Makefile
@@ -2001,39 +2001,6 @@ ifndef PAGER_ENV
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
index 4352ea39e9b..7727b707b74 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -727,7 +727,6 @@ vcxproj:
 	git diff-index --cached --quiet HEAD --
 
 	# Make .vcxproj files and add them
-	unset QUIET_GEN QUIET_BUILT_IN; \
 	perl contrib/buildsystems/generate -g Vcxproj
 	git add -f git.sln {*,*/lib,t/helper/*}/*.vcxproj
 
diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
index d585b319edc..5e86d78e19b 100644
--- a/contrib/scalar/Makefile
+++ b/contrib/scalar/Makefile
@@ -8,20 +8,6 @@ include ../../config.mak.uname
 -include ../../config.mak.autogen
 -include ../../config.mak
 
-QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
-QUIET_SUBDIR1  =
-
-ifneq ($(findstring s,$(MAKEFLAGS)),s)
-ifndef V
-	QUIET_GEN      = @echo '   ' GEN $@;
-	QUIET_SUBDIR0  = +@subdir=
-	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
-			 $(MAKE) $(PRINT_DIR) -C $$subdir
-else
-	export V
-endif
-endif
-
 TARGETS = scalar$(X) scalar.o
 GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
 
diff --git a/shared.mak b/shared.mak
index 934bf428936..c45b2812eb6 100644
--- a/shared.mak
+++ b/shared.mak
@@ -31,3 +31,56 @@
 comma := ,
 empty :=
 space := $(empty) $(empty)
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
2.35.1.1228.g56895c6ee86

