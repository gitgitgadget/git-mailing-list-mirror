Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FEFC43217
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F30160F36
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbhKLVw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbhKLVwO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:52:14 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C288C061203
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:22 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso10950307wml.1
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1OWx/7MXzps6T+zd+fvgE814+eutIhqIUB2lfB+MtN4=;
        b=Ss57UoO/ox3b1lb871WBlak7vuvSJuhk+28HktYW3FG0HWYvDsBhrefF6vHBOIXfmx
         wSCMFNFzAQaYonDHcmmJeWuhdqtj3lNETEY5zCo+mI+uc1bWqVXTDrcabRG+nTOk5myb
         1gakXMdgoztwHjQyb9p3mJd14s+Bx7noR1D60mtZ9atbYA7UD1Ka+a4KUZq5SmmVu2qE
         z02TuDbmatB3/ANIe/dTg9SUD9eGUQubzoIww6MqzuL9ZnMnY20YDi2bu6dTIyLx3b6o
         iQGNTEC8eGPlaQbNkagSOEOak0nyDGFdhibukFa3AL1wHmrR2t5rl1k7nsBN0V4a9d+K
         y9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1OWx/7MXzps6T+zd+fvgE814+eutIhqIUB2lfB+MtN4=;
        b=T5u1388ankHTYqjCnfhYEPqpdLIG5yB4yp6w0evwHw+mXeL023Cf9eLVotA+n88a3i
         sKqojmPaDrQ3pdS1Y7xFRTXLUnw2AusEUIfLAk+1jwjv+XuQX4DCAqW+rz49ptfaJOsR
         0R4YQoyQy+LEH5W9ZL9dcHklkRZ+FIYxHEwJPR0VbjRWqnY2SUTyt66CQe3ObXm3qGzZ
         BA9l54ZZmQYRgkalCDZYwl5js5xC/oNdT5l8WWiN82Yh8Mk+mDwPA26fyZf2x0OcPMhG
         qdgaDC1rlW7DIEXNyn/IH8dXNsZ0P1X9DobwCxrBYeQ4llzJYCG/IV6egVGojldzQEld
         1QyQ==
X-Gm-Message-State: AOAM530u0ds83dQBg5H2wO9sTmqm6hMHCNuSFNkPiCVkqbJCv719zOiH
        Hsc9+8WJCh0LqeLn2WKVdTzXeGPX6IU0Bw==
X-Google-Smtp-Source: ABdhPJydAaE99/YOsKDJZf0kK4oXDDpZBoJMPxecQlgg5kNd18pxTr/aTquAglXjfRGvK2n+O9ewww==
X-Received: by 2002:a1c:7e41:: with SMTP id z62mr8636688wmc.62.1636753760653;
        Fri, 12 Nov 2021 13:49:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm14117189wmc.43.2021.11.12.13.49.19
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
Subject: [PATCH v2 15/18] Makefile: add a "TRACK_template" for GIT-*{FLAGS,DEFINES,...}
Date:   Fri, 12 Nov 2021 22:48:59 +0100
Message-Id: <patch-v2-15.18-5654d7f7f29-20211112T214150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the mostly copy/pasted code in the "Makefile" and
"Documentation/Makefile" which FORCE-generates a file based on a
variable in play in the Makefile to use a template.

This will make it easier later on to move these to rules that aren't
FORCE-run using optional gmake 4.2+ features, but for now just getting
rid of the repetition is worth it.

The message for the new generated rule will say whether or not we're
generating the file for the first time, as opposed to the old messages
saying "new" whether we had flag modifications, or were building for
the first time.

Example output before:

    $ make clean
    [...]
    $ make
    GIT_VERSION = 2.34.0-rc1-dev
        * new build flags
        CC grep.o
    $ make CFLAGS=-I$RANDOM grep.o
        * new build flags
        CC grep.o

After:

    $ make clean
    [...]
    $ make grep.o
    GIT_VERSION = 2.34.0-rc1-dev
        GIT-CFLAGS PARAMETERS (new)
        CC grep.o
    $ make CFLAGS=-I$RANDOM grep.o
        GIT-CFLAGS PARAMETERS (changed)
        CC grep.o

Note: It's important that "@FLAGS" here be defined as '$$($(2))', and
not the eagerly expanded '$($(2))'. The latter will break if
e.g. curl-config isn't installed, since we'll end up recursively
expanding that part of the variable even if NO_CURL isn't defined,
which happens e.g. for the "check-docs" target in CI.

We're also introducing a $(wspfx) variable here to control the
whitespace prefixing. It matches the $(QUIET...) variables, who'll be
using these variables in a subsequent commit. Note that it's important
that we call the shell quote escaping macros inline (or equivalent),
because if we'd like variables to be overridable we need to support e.g.:

    $ make CFLAGS=-I$RANDOM grep.o wspfx='$(space)->'
     -> GIT-CFLAGS PARAMETERS (changed)
        CC grep.o

If we simply quoted and used $(wspfx) then the user would need to
provide us with a quoted version, so there's still some use-cases for
these $(*_sq) variables. It could also be done inline, but that's a
lot more verbose.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile |  8 +------
 Makefile               | 51 ++++++------------------------------------
 shared.mak             | 22 ++++++++++++++++++
 3 files changed, 30 insertions(+), 51 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ba27456c86a..4a939cc2c25 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -343,13 +343,7 @@ mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
 	date >$@
 
 TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK))
-
-GIT-ASCIIDOCFLAGS: FORCE
-	@FLAGS='$(TRACK_ASCIIDOCFLAGS)'; \
-	    if test x"$$FLAGS" != x"`cat GIT-ASCIIDOCFLAGS 2>/dev/null`" ; then \
-		echo >&2 "    * new asciidoc flags"; \
-		echo "$$FLAGS" >GIT-ASCIIDOCFLAGS; \
-            fi
+$(eval $(call TRACK_template,GIT-ASCIIDOCFLAGS,TRACK_ASCIIDOCFLAGS))
 
 clean:
 	$(RM) -rf .build/
diff --git a/Makefile b/Makefile
index b458c24d95e..c8a0a1586ca 100644
--- a/Makefile
+++ b/Makefile
@@ -2087,10 +2087,7 @@ endif
 GIT_USER_AGENT_SQ = $(subst ','\'',$(GIT_USER_AGENT))
 GIT_USER_AGENT_CQ = "$(subst ",\",$(subst \,\\,$(GIT_USER_AGENT)))"
 GIT_USER_AGENT_CQ_SQ = $(subst ','\'',$(GIT_USER_AGENT_CQ))
-GIT-USER-AGENT: FORCE
-	@if test x'$(GIT_USER_AGENT_SQ)' != x"`cat GIT-USER-AGENT 2>/dev/null`"; then \
-		echo '$(GIT_USER_AGENT_SQ)' >GIT-USER-AGENT; \
-	fi
+$(eval $(call TRACK_template,GIT-USER-AGENT,GIT_USER_AGENT_SQ))
 
 ifdef DEFAULT_HELP_FORMAT
 BASIC_CFLAGS += -DDEFAULT_HELP_FORMAT='"$(DEFAULT_HELP_FORMAT)"'
@@ -2238,12 +2235,7 @@ SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):\
 	$(localedir_SQ):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
 	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(PAGER_ENV):\
 	$(perllibdir_SQ)
-GIT-SCRIPT-DEFINES: FORCE
-	@FLAGS='$(SCRIPT_DEFINES)'; \
-	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
-		echo >&2 "    * new script parameters"; \
-		echo "$$FLAGS" >$@; \
-            fi
+$(eval $(call TRACK_template,GIT-SCRIPT-DEFINES,SCRIPT_DEFINES))
 
 define cmd_munge_script
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -2355,13 +2347,7 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
 	chmod +x $@+ && \
 	mv $@+ $@
 endif # NO_PERL
-
-GIT-PERL-DEFINES: FORCE
-	@FLAGS='$(PERL_DEFINES)'; \
-	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
-		echo >&2 "    * new perl-specific parameters"; \
-		echo "$$FLAGS" >$@; \
-	    fi
+$(eval $(call TRACK_template,GIT-PERL-DEFINES,PERL_DEFINES))
 
 # As with NO_PERL=Y we'll still make GIT-PYTHON-DEFINES if "NO_PYTHON"
 # is defined, for creating the "unimplemented.sh" scripts.
@@ -2390,12 +2376,7 @@ $(SCRIPT_PYTHON_GEN): % : %.py GIT-PYTHON-DEFINES
 	mv $@+ $@
 endif # NO_PYTHON
 
-GIT-PYTHON-DEFINES: FORCE
-	@FLAGS='$(PYTHON_DEFINES)'; \
-	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
-		echo >&2 "    * new python-specific parameters"; \
-		echo "$$FLAGS" >$@; \
-	    fi
+$(eval $(call TRACK_template,GIT-PYTHON-DEFINES,PYTHON_DEFINES))
 
 CONFIGURE_RECIPE = sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 			configure.ac >configure.ac+ && \
@@ -2751,31 +2732,13 @@ cscope: cscope.out
 ### Detect prefix changes
 TRACK_PREFIX = $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
 		$(localedir_SQ)
-
-GIT-PREFIX: FORCE
-	@FLAGS='$(TRACK_PREFIX)'; \
-	if test x"$$FLAGS" != x"`cat GIT-PREFIX 2>/dev/null`" ; then \
-		echo >&2 "    * new prefix flags"; \
-		echo "$$FLAGS" >GIT-PREFIX; \
-	fi
+$(eval $(call TRACK_template,GIT-PREFIX,TRACK_PREFIX))
 
 TRACK_CFLAGS = $(CC):$(subst ','\'',$(ALL_CFLAGS)):$(USE_GETTEXT_SCHEME)
-
-GIT-CFLAGS: FORCE
-	@FLAGS='$(TRACK_CFLAGS)'; \
-	    if test x"$$FLAGS" != x"`cat GIT-CFLAGS 2>/dev/null`" ; then \
-		echo >&2 "    * new build flags"; \
-		echo "$$FLAGS" >GIT-CFLAGS; \
-            fi
+$(eval $(call TRACK_template,GIT-CFLAGS,TRACK_CFLAGS))
 
 TRACK_LDFLAGS = $(subst ','\'',$(ALL_LDFLAGS))
-
-GIT-LDFLAGS: FORCE
-	@FLAGS='$(TRACK_LDFLAGS)'; \
-	    if test x"$$FLAGS" != x"`cat GIT-LDFLAGS 2>/dev/null`" ; then \
-		echo >&2 "    * new link flags"; \
-		echo "$$FLAGS" >GIT-LDFLAGS; \
-            fi
+$(eval $(call TRACK_template,GIT-LDFLAGS,TRACK_LDFLAGS))
 
 # We need to apply sq twice, once to protect from the shell
 # that runs GIT-BUILD-OPTIONS, and then again to protect it
diff --git a/shared.mak b/shared.mak
index ef03c2bc094..3b4163e652a 100644
--- a/shared.mak
+++ b/shared.mak
@@ -29,3 +29,25 @@ shelldquote = '"$(call shdq,$(call shq,$(1)))"'
 comma = ,
 empty =
 space = $(empty) $(empty)
+
+## wspfx: the whitespace prefix padding for $(QUIET...) and similarly
+## aligned output.
+wspfx = $(space)$(space)$(space)
+wspfx_sq = $(call shellquote,$(wspfx))
+
+### Templates
+
+## Template for making a GIT-SOMETHING, which changes if a
+## TRACK_SOMETHING variable changes.
+define TRACK_template
+.PHONY: FORCE
+$(1): FORCE
+	@FLAGS='$$($(2))'; \
+	if ! test -f $(1) ; then \
+		echo $(wspfx_sq) "$(1) PARAMETERS (new)" $@; \
+		echo "$$$$FLAGS" >$(1); \
+	elif test x"$$$$FLAGS" != x"`cat $(1) 2>/dev/null`" ; then \
+		echo $(wspfx_sq) "$(1) PARAMETERS (changed)" $@; \
+		echo "$$$$FLAGS" >$(1); \
+	fi
+endef
-- 
2.34.0.rc2.795.g926201d1cc8

