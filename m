Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4E1C433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 17:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346666AbiEaRqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 13:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346653AbiEaRqe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 13:46:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48512986C3
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:46:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q7so8719395wrg.5
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v5cl2frGzOtkUFfdJXe1/bOgFFbKquJHtL649ws7LuA=;
        b=lzs/4vW4Oz1LedEUAQ/0i4PJ6xs0uq2jfILonHR+RpbB0Ryg0KHlbjm34nc2nj45Bx
         FdV99Cy4lvdEloaZw4cRdsxlaNeCrlWsJG+S7fvMXgCLi3/kMiPvsq9FSvs8C5lLcnRL
         uWEEBRp91npAHvm+8oM1FLSFcu+cgmzmr+Mihu3qqwa2WX6nRGxYTDuTmoq6y0NrFIcp
         sFdXIk8HvBtfiBNkNyajQtrj8HjTCAUKFwHnOwnMTyAHsYGfVdqC6hcqj+cKxz2ZaADs
         p+8EQfdN4WLJ0Qp7opNFIViLeji6MQB9+2hJMo06+o8FtS0gHeB9DskDzjzhlR2UtYYu
         o/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v5cl2frGzOtkUFfdJXe1/bOgFFbKquJHtL649ws7LuA=;
        b=l+OQPRQA51di7ebmNCCzmsyRrozAYEe3xQeMaFlO5WZmBUNUEaKJt1fN4jm3gSzIHs
         9dOmxmN8SSz1+U2rhaxWGWquE1x9GD87v+inkSZF5VVvNAVabOaF0VPssAUONwPDwq9J
         JAQ56lw3+JjumzHbTFxTaTWeHG9Chdz7NqNHmvi72FnX9+tfWegq42+oELNFUvBhIl9u
         hIgCrho8T0lPGN0yTB/padGAQOb3RbHQ4Y67Q9BT+18XLqDEYX7MPyq3cYdadyiCp8Eb
         BWalDAv+8za/pDJujntwplJZICmanVM5SLiT+ne64CilHQAU6hsQ7Kg6jLfKPeif3Pim
         x3wQ==
X-Gm-Message-State: AOAM532MmWoJ+SCVY7U5p7xFvv8+sHq56YKCxPgosfRqbQmGIAugnNz6
        LwFWLX4zIze+mrinaUzZ5J02Qkln7XPuWg==
X-Google-Smtp-Source: ABdhPJyOGlg3RluY7j4Hh0QAKlQWxP0ftrRU0eshU0rJQTXZcuEfoupOkPJYP56YabNVA74JsAvq4A==
X-Received: by 2002:a5d:4c86:0:b0:210:2e6e:3a93 with SMTP id z6-20020a5d4c86000000b002102e6e3a93mr11710048wrs.185.1654019184444;
        Tue, 31 May 2022 10:46:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j26-20020a05600c1c1a00b003973e27b789sm3826656wms.27.2022.05.31.10.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:46:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/7] gitweb/Makefile: include in top-level Makefile
Date:   Tue, 31 May 2022 19:45:59 +0200
Message-Id: <patch-v2-6.7-b423cd58f6b-20220531T173805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.g036c05811b0
In-Reply-To: <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
References: <220527.861qwf489s.gmgdl@evledraar.gmail.com> <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Include the gitweb/Makefile in the top-level Makefile rather than
calling it as a sub-Makefile. As noted in the thread starting at at
[1] (in particular [2]) we'll pay a high cost on NOOP runs of "make"
just to figure out that we have nothing to do for "make gitweb".

The "gitweb" script also isn't maintained out-of-tree, unlike
"gitk-git" or "git-gui", which both have their own "Makefile". Other
parts of it are already integrated into our main Makefiles, e.g. the
documentation is built by Documentation/Makefile since
07ea4df2780 (gitweb: Add gitweb(1) manpage for gitweb itself,
2011-10-16).

1. https://lore.kernel.org/git/20220525205651.825669-1-szeder.dev@gmail.com/
2. https://lore.kernel.org/git/220526.86k0a96sv2.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Perhaps a better solution is to simply move all of this code to the
top-level gitweb/Makefile, but on the other hand being able to include
the gitweb/Makefile to fold it into the top-level one without a larger
diff makes this sort of change much easier to review.

And, as shown here we'll have "make -C gitweb" now $(error) out, so
there's no chance of confusion in practice.

 Makefile        | 23 +++++++------
 gitweb/Makefile | 91 +++++++++----------------------------------------
 2 files changed, 29 insertions(+), 85 deletions(-)

diff --git a/Makefile b/Makefile
index 18ca6744a50..d251838c554 100644
--- a/Makefile
+++ b/Makefile
@@ -538,6 +538,7 @@ gitexecdir = libexec/git-core
 mergetoolsdir = $(gitexecdir)/mergetools
 sharedir = $(prefix)/share
 gitwebdir = $(sharedir)/gitweb
+gitwebstaticdir = $(gitwebdir)/static
 perllibdir = $(sharedir)/perl5
 localedir = $(sharedir)/locale
 template_dir = share/git-core/templates
@@ -556,7 +557,7 @@ localedir_relative = $(patsubst $(prefix)/%,%,$(localedir))
 htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
 perllibdir_relative = $(patsubst $(prefix)/%,%,$(perllibdir))
 
-export prefix bindir sharedir sysconfdir gitwebdir perllibdir localedir
+export prefix bindir sharedir sysconfdir perllibdir localedir
 
 # Set our default programs
 CC = cc
@@ -2071,6 +2072,7 @@ htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
 prefix_SQ = $(subst ','\'',$(prefix))
 perllibdir_relative_SQ = $(subst ','\'',$(perllibdir_relative))
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
+gitwebstaticdir_SQ = $(subst ','\'',$(gitwebstaticdir))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 TEST_SHELL_PATH_SQ = $(subst ','\'',$(TEST_SHELL_PATH))
@@ -2399,10 +2401,6 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
 perllibdir:
 	@echo '$(perllibdir_SQ)'
 
-.PHONY: gitweb
-gitweb:
-	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
-
 git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	chmod +x $@+ && \
@@ -3036,6 +3034,15 @@ coccicheck-pending: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.pending.c
 
 .PHONY: coccicheck coccicheck-pending
 
+# "Sub"-Makefiles, not really because they can't be run stand-alone,
+# only there to contain directory-specific rules and variables
+## gitweb/Makefile inclusion:
+MAK_DIR_GITWEB = gitweb/
+include gitweb/Makefile
+
+.PHONY: gitweb
+gitweb: $(MAK_DIR_GITWEB_ALL)
+
 ### Installation rules
 
 ifneq ($(filter /%,$(firstword $(template_dir))),)
@@ -3108,7 +3115,6 @@ ifndef NO_PERL
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perllibdir_SQ)'
 	(cd perl/build/lib && $(TAR) cf - .) | \
 	(cd '$(DESTDIR_SQ)$(perllibdir_SQ)' && umask 022 && $(TAR) xof -)
-	$(MAKE) -C gitweb install
 endif
 ifndef NO_TCLTK
 	$(MAKE) -C gitk-git install
@@ -3163,10 +3169,8 @@ endif
 		  cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; } \
 	done
 
-.PHONY: install-gitweb install-doc install-man install-man-perl install-html install-info install-pdf
+.PHONY: install-doc install-man install-man-perl install-html install-info install-pdf
 .PHONY: quick-install-doc quick-install-man quick-install-html
-install-gitweb:
-	$(MAKE) -C gitweb install
 
 install-doc: install-man-perl
 	$(MAKE) -C Documentation install
@@ -3310,7 +3314,6 @@ clean: profile-clean coverage-clean cocciclean
 	$(MAKE) -C Documentation/ clean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
 ifndef NO_PERL
-	$(MAKE) -C gitweb clean
 	$(RM) -r perl/build/
 endif
 	$(MAKE) -C templates/ clean
diff --git a/gitweb/Makefile b/gitweb/Makefile
index eaf0cfcf80e..66fceb9e94f 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -1,11 +1,8 @@
-# The default target of this Makefile is...
-all::
-.PHONY: all
-
-MAK_DIR_GITWEB =
+ifndef MAK_DIR_GITWEB
+$(error do not run gitweb/Makefile stand-alone anymore. The "gitweb" and \
+"install-gitweb" targets now live in the top-level Makefile)
+endif
 
-# Define V=1 to have a more verbose compile.
-#
 # Define JSMIN to point to JavaScript minifier that functions as
 # a filter to have static/gitweb.js minified.
 #
@@ -13,13 +10,6 @@ MAK_DIR_GITWEB =
 # version of static/gitweb.css
 #
 
-prefix ?= $(HOME)
-bindir ?= $(prefix)/bin
-gitwebdir ?= /var/www/cgi-bin
-
-RM ?= rm -f
-INSTALL ?= install
-
 # default configuration for gitweb
 GITWEB_CONFIG = gitweb_config.perl
 GITWEB_CONFIG_SYSTEM = /etc/gitweb.conf
@@ -44,71 +34,19 @@ GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 HIGHLIGHT_BIN = highlight
 
-# include user config
--include ../config.mak.autogen
--include ../config.mak
--include config.mak
-
-# determine version
-.PHONY: .FORCE-GIT-VERSION-FILE
-../GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
-	$(QUIET_SUBDIR0)../ $(QUIET_SUBDIR1) GIT-VERSION-FILE
-
-ifneq ($(MAKECMDGOALS),clean)
--include ../GIT-VERSION-FILE
-endif
-
 # What targets we'll add to 'all' for "make gitweb"
 GITWEB_ALL =
 GITWEB_ALL += gitweb.cgi
 GITWEB_ALL += $(GITWEB_JS)
 
-### Build rules
-
-SHELL_PATH ?= $(SHELL)
-PERL_PATH  ?= /usr/bin/perl
-
-# Shell quote;
-bindir_SQ = $(subst ','\'',$(bindir))#'
-gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
-gitwebstaticdir_SQ = $(subst ','\'',$(gitwebdir)/static)#'
-SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))#'
-PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
-DESTDIR_SQ    = $(subst ','\'',$(DESTDIR))#'
-
-# Quiet generation (unless V=1)
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
-	QUIET          = @
-	QUIET_GEN      = $(QUIET)echo '   ' GEN $@;
-	QUIET_SUBDIR0  = +@subdir=
-	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
-	                 $(MAKE) $(PRINT_DIR) -C $$subdir
-	export V
-	export QUIET
-	export QUIET_GEN
-	export QUIET_SUBDIR0
-	export QUIET_SUBDIR1
-endif
-endif
-
-all:: $(GITWEB_ALL)
+MAK_DIR_GITWEB_ALL = $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_ALL))
 
 GITWEB_PROGRAMS = gitweb.cgi
 
 GITWEB_JS_MIN = static/gitweb.min.js
 ifdef JSMIN
 GITWEB_JS = $(GITWEB_JS_MIN)
-all:: $(MAK_DIR_GITWEB)$(GITWEB_JS_MIN)
+GITWEB_ALL += $(MAK_DIR_GITWEB)$(GITWEB_JS_MIN)
 $(MAK_DIR_GITWEB)$(GITWEB_JS_MIN): $(MAK_DIR_GITWEB)GITWEB-BUILD-OPTIONS
 $(MAK_DIR_GITWEB)$(GITWEB_JS_MIN): $(MAK_DIR_GITWEB)$(GITWEB_JS_IN)
 	$(QUIET_GEN)$(JSMIN) <$< >$@
@@ -118,7 +56,7 @@ GITWEB_FILES += $(GITWEB_JS)
 GITWEB_CSS_MIN = static/gitweb.min.css
 ifdef CSSMIN
 GITWEB_CSS = $(GITWEB_CSS_MIN)
-all:: $(MAK_DIR_GITWEB)$(GITWEB_CSS_MIN)
+GITWEB_ALL += $(MAK_DIR_GITWEB)$(GITWEB_CSS_MIN)
 $(MAK_DIR_GITWEB)$(GITWEB_CSS_MIN): $(MAK_DIR_GITWEB)GITWEB-BUILD-OPTIONS
 $(MAK_DIR_GITWEB)$(GITWEB_CSS_MIN): $(MAK_DIR_GITWEB)$(GITWEB_CSS_IN)
 	$(QUIET_GEN)$(CSSMIN) <$< >$@
@@ -185,19 +123,22 @@ $(MAK_DIR_GITWEB)static/gitweb.js: $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_
 
 ### Installation rules
 
-.PHONY: install
-install: all
+.PHONY: install-gitweb
+install-gitweb: $(MAK_DIR_GITWEB_ALL)
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
-	$(INSTALL) -m 755 $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_PROGRAMS)) \
-		'$(DESTDIR_SQ)$(gitwebdir_SQ)'
+	$(INSTALL) -m 755 $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_PROGRAMS)) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 	$(INSTALL) -m 644 $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_FILES)) \
 		'$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
+ifndef NO_PERL
+install: install-gitweb
+endif
 
 ### Cleaning rules
 
-.PHONY: clean
-clean:
+.PHONY: gitweb-clean
+gitweb-clean:
 	$(RM) $(addprefix $(MAK_DIR_GITWEB),gitweb.cgi $(GITWEB_JS_IN) \
 		$(GITWEB_JS_MIN) $(GITWEB_CSS_MIN) \
 		GITWEB-BUILD-OPTIONS)
+clean: gitweb-clean
-- 
2.36.1.1103.g036c05811b0

