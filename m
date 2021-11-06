Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7875BC433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638E260F5A
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbhKFVGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbhKFVGX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:06:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6C9C061228
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:03:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so8907994wmz.2
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0oLtRbmeAbzwW/NHriUw6XWWxS2XDAo1qaHEBkhPdqI=;
        b=fEVXfT8um2LDDpl7WfGHtmPi9ME3jKfAgfi31H76dR1VIb0GQQ116DdlK5QpdA/j2E
         Z6e0qN/P4YZ6SfbuBGjjoCTL2s0sKOeHTnyGOqXf3fcFTIB2ZR3exTyd0dc2BEH010wd
         z3pnhGk8iDzpB116xy14EwvSP67g8pC9WDPOUQOR90SWbJBffY9JNVjvirX4Cpmfh1D9
         sfI4vXAIAb68nNDDDC5yw5Z20/U+Y2nGUPG1zt4g0LhwkV1C3a+8kLm30cARFRdWbkWd
         gORyDofJfdyX8HnNfodnQSUZdrR04XtV7VqHw8e/YdqL+GAtA/XU0pO3Ugn+EWpojYnO
         pBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0oLtRbmeAbzwW/NHriUw6XWWxS2XDAo1qaHEBkhPdqI=;
        b=k/MlogobdEagZ3C/z8xwJsx67FPfLFA02aS9GYk+lZfuXUTo1Eg6VJgZjoUa8pVynz
         30qzC/ZSVYzOGufJxS2U/AMjSar3m02ecT/IUXRuOiN3GsBBN2H64w67/Xxk9Rc4W1RK
         dPFUDXDyh2+s76tkkSGlJfJMRfzmspGsuiazSMIjMmtMPPksMvSk2GpjC3qymW3n2C9p
         w9Vx9j0JB926Oz27o9JYJux1nXJFSd8e5eRqmjhHvVhTcnJavqF3iTq/anSC8IbVbUMq
         SzfULdZVCceNzhVWy7J3W0+Um5tfc+UkTnhegZe2cwRkticEwGmCDm71ldTSWK2/8pat
         Cxuw==
X-Gm-Message-State: AOAM533kQKg09tn1TgRRmTez1spcxT06aK+9yGuOrr98JrfHamzhdOVw
        WYfsWVHjfKBab7Hc/RasVcG40y/AP1PcEw==
X-Google-Smtp-Source: ABdhPJxEPlG4S9YdCfb/XK0l2n4TD0Kfkcz9eEPh2rllg4/b3Ea7yraBKRe719TDLvtOzhGuXeuzwg==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr41083314wma.30.1636232609767;
        Sat, 06 Nov 2021 14:03:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u16sm14108433wmc.21.2021.11.06.14.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:03:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/16] Makefile: add a "TRACK_template" for GIT-*{FLAGS,DEFINES,...}
Date:   Sat,  6 Nov 2021 22:03:13 +0100
Message-Id: <patch-12.16-5930a08cb4e-20211106T205717Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
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
index baf815c48b4..c1ad99a5399 100644
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
@@ -2346,13 +2338,7 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
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
 
 # Under NO_PERL=Y we'll still make GIT-PERL-DEFINES. We need to depend
 # on NO_PERL=Y itself for creating "unimplemented.sh" scripts.
@@ -2380,12 +2366,7 @@ $(SCRIPT_PYTHON_GEN): % : %.py
 	mv $@+ $@
 endif # PYTHON
 
-GIT-PYTHON-DEFINES: FORCE
-	@FLAGS='$(PYTHON_DEFINES)'; \
-	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
-		echo >&2 "    * new python-specific parameters"; \
-		echo "$$FLAGS" >$@; \
-	    fi
+$(eval $(call TRACK_template,GIT-PYTHON-DEFINES,PYTHON_DEFINES))
 
 CONFIGURE_RECIPE = sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 			configure.ac >configure.ac+ && \
@@ -2741,31 +2722,13 @@ cscope: cscope.out
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
2.34.0.rc1.741.gab7bfd97031

