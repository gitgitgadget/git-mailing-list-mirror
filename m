Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6409C433FE
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 17:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353345AbhLXRiE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 12:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353337AbhLXRiB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 12:38:01 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C997C06175A
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:38:01 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q16so18664491wrg.7
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yLAAlX8dpOAXS86Dd39CZZj9eacgY4TuADv7Zkk0daQ=;
        b=kYUs8RK+qq84tAz6cc3XMg6nWclA/SSWBvYAlQffDMIB4HGUhl885ZxZ/9SXd5M8ly
         fKKQbZhVkMevoIugb7UPlz2ELTwdAvEF4AWrCAts1bQpexsCfYbAnmqAxLhq4NtuRR/D
         d8rtYaR8YvpKz1Hr8FMw6JBw/i1Q/2PMuMlYFCA6FlkpVkgkNEoZ1JfQL8xQIS10fzRU
         wYUZnhpG8kx36vUKVlKJbBMYGAvmplK6Ah4M8UnO4W0rK4lTjdrxohII49X41ZOXMALi
         KCQ2jFScRXT8ZOJuvAgIcafY7jw/lyzmoxR546feLtUK56OQZ49bEvjY35nK5aXIJAX0
         XeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yLAAlX8dpOAXS86Dd39CZZj9eacgY4TuADv7Zkk0daQ=;
        b=7OrCTbYBvDBYtzQ4k2RjTlylJCAHv86K6sI+MIQN0DLPYewRVe+3jE7yO86rmmBzz5
         zDWcOyuC8FhM83ZAv7s6mPXVaLvcekBLRfnjMIOutHQdOnXe5g2/XeDW4YzeQ1vbKTqM
         3GyQENreU9To2laTHcB1ySbc4D+lIgszMrMqcfJxIOGPwfgikJqDiMV8QVCC+RccWU1q
         SCl0qZo1Smlrr6YkJBN/c3rJGfOCBRN27/DwgxQnO9rUesBjx3kwh+3lQ9vXeUIlBKsZ
         kCnnUOkj1U20d37Pq7AubmiUZ7KQZq0r0iQfEgfzSq+42aSQeav0zjhgRtDKyGLAZrcM
         eelA==
X-Gm-Message-State: AOAM530xrWKU2H56BDvBMmeURuoMu8QVauohWBMssYhxdyG/SxucKPtH
        w5PtsMxLlvisFnPwwbThx47cAPqtAiZ8ZL9n
X-Google-Smtp-Source: ABdhPJxk3SlI+DEgnI0bmegCWe+KeZ8vE+jih76YYZGYYsxrXXVmQ8U2vv6y/finS3c4QT9p/riLxQ==
X-Received: by 2002:a05:6000:1843:: with SMTP id c3mr5419478wri.316.1640367479630;
        Fri, 24 Dec 2021 09:37:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j3sm8033518wro.22.2021.12.24.09.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 09:37:59 -0800 (PST)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/8] Makefile: add "$(QUIET)" boilerplate to shared.mak
Date:   Fri, 24 Dec 2021 18:37:45 +0100
Message-Id: <patch-v2-6.8-fb877060d6b-20211224T173558Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1215.g6e154b84c77
In-Reply-To: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
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
index 85f99e66b07..d8051278519 100644
--- a/Makefile
+++ b/Makefile
@@ -1971,39 +1971,6 @@ ifndef PAGER_ENV
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
2.34.1.1215.g6e154b84c77

