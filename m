Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27EDC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 12:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241963AbiCBMus (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241968AbiCBMui (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 07:50:38 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5791C3332
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 04:49:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j17so2686482wrc.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 04:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qgfOeFMytbEcQH/8El/0BG1Oi4lc050GqasdfiJMmo=;
        b=Ff1sky1CAmUVBExflwSLZHCNH8kWpz6PYRpOMTkSJAQdXxzWIDHsCTu293APGQF3fc
         WARX+KhpcAZmz7lYmDBUwWG0kX1wQLrMWS+B4SoRs8wurn1vrv0nEl+PVOdk3o/F+ush
         r4R/pPk8kV4U+Wf85nJnnfk5pP1o9nxapm1u4eNXN30H7ELzDPMqIbfV7bjThT1F7s8/
         oHsONrLxNvLPJV2B/5zRS6kdZYKl5ZYvGnaCsHVuWWHbcgkxRBoVZmjCN5DIUbQ6R0yy
         PhxJkBrWRM8OS4iH+LOL0Tv9f6zWCG5bUBFDC5bZkr+sz2gk7j5x62VURWI9siqGLhIg
         6OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qgfOeFMytbEcQH/8El/0BG1Oi4lc050GqasdfiJMmo=;
        b=oQ2HboEm1/I/4Hay6IMjBcCoJj87ODfyNTKX+RrC8cU/ntoVTQ0UTBiOV9G4azMxIp
         c3H87J2/155+dy2aIs3F6LG1aqfVkXWi04Am161H7YzkceusazvgzAPeCe1YAyJaWXo9
         6jPybC9Lx0m4/xjkCbMZCPnwmAvoxYRgOolznQuYnd60GiIIEnsXCZ3uQRWgEOLFXKLz
         i9Hid3vecQ+N8m8mEOfJWXRZ/uJ4AHnVd4NCcr2FBu84Y+YEesnCQVkbVL0+S+TRbvsT
         P0bHwzjlhIJxZ85SZztmTJ8M4NyKx4Qex0A6jvc9xm/nkUffYMrf5rgJpMkKLqj/qM6C
         QB8A==
X-Gm-Message-State: AOAM531IG8LATPy7ZvqJKsNV1kGOhEcNL/9IMttpGmuXqsClLlYUP7Y2
        HK8oiRUIyiuLsNqkpile11uKkuct+IieUw==
X-Google-Smtp-Source: ABdhPJxH6wju4vwclWU9TtF+e9LVSJ8i62lF21K20Y/uxKvr4OSc0BNkgMb10LNNMo8E1mMuN6QXBg==
X-Received: by 2002:adf:fbd0:0:b0:1e6:8ec3:570 with SMTP id d16-20020adffbd0000000b001e68ec30570mr24334374wrs.396.1646225387771;
        Wed, 02 Mar 2022 04:49:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003811f9102c0sm8210107wmi.32.2022.03.02.04.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:49:46 -0800 (PST)
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
Subject: [PATCH v4 9/9] Makefiles: add and use wildcard "mkdir -p" template
Date:   Wed,  2 Mar 2022 13:49:17 +0100
Message-Id: <patch-v4-9.9-4cc4aeabb20-20220302T124320Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a template to do the "mkdir -p" of $(@D) (the parent dir of $@)
for us, and use it for the "make lint-docs" targets I added in
8650c6298c1 (doc lint: make "lint-docs" non-.PHONY, 2021-10-15).

As seen in 4c64fb5aad9 (Documentation/Makefile: fix lint-docs mkdir
dependency, 2021-10-26) maintaining these manual lists of parent
directory dependencies is fragile, in addition to being obviously
verbose.

I used this pattern at the time because I couldn't find another method
than "order-only" prerequisites to avoid doing a "mkdir -p $(@D)" for
every file being created, which as noted in [1] would be significantly
slower.

But as it turns out we can use this neat trick of only doing a "mkdir
-p" if the $(wildcard) macro tells us the path doesn't exist. A re-run
of a performance test similar to that noted downthread of [1] in [2]
shows that this is faster, in addition to being less verbose and more
reliable (this uses my "git-hyperfine" thin wrapper for "hyperfine"[3]):

    $ git -c hyperfine.hook.setup= hyperfine -L rev HEAD~1,HEAD~0 -s 'make -C Documentation lint-docs' -p 'rm -rf Documentation/.build' 'make -C Documentation -j1 lint-docs'
    Benchmark 1: make -C Documentation -j1 lint-docs' in 'HEAD~1
      Time (mean ± σ):      2.914 s ±  0.062 s    [User: 2.449 s, System: 0.489 s]
      Range (min … max):    2.834 s …  3.020 s    10 runs

    Benchmark 2: make -C Documentation -j1 lint-docs' in 'HEAD~0
      Time (mean ± σ):      2.315 s ±  0.062 s    [User: 1.950 s, System: 0.386 s]
      Range (min … max):    2.229 s …  2.397 s    10 runs

    Summary
      'make -C Documentation -j1 lint-docs' in 'HEAD~0' ran
        1.26 ± 0.04 times faster than 'make -C Documentation -j1 lint-docs' in 'HEAD~1'

So let's use that pattern both for the "lint-docs" target, and a few
miscellaneous other targets.

This method of creating parent directories is explicitly racy in that
we don't know if we're going to say always create a "foo" followed by
a "foo/bar" under parallelism, or skip the "foo" because we created
"foo/bar" first. In this case it doesn't matter for anything except
that we aren't guaranteed to get the same number of rules firing when
running make in parallel.

1. https://lore.kernel.org/git/211028.861r45y3pt.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/211028.86o879vvtp.gmgdl@evledraar.gmail.com/
3. https://gitlab.com/avar/git-hyperfine/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile | 25 +++----------------------
 Makefile               | 12 +++++++-----
 shared.mak             | 17 +++++++++++++++++
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 0f4ebdeda8a..1eb9192dae8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -434,25 +434,11 @@ quick-install-html: require-htmlrepo
 print-man1:
 	@for i in $(MAN1_TXT); do echo $$i; done
 
-## Lint: Common
-.build:
-	$(QUIET)mkdir $@
-.build/lint-docs: | .build
-	$(QUIET)mkdir $@
-
 ## Lint: gitlink
-.build/lint-docs/gitlink: | .build/lint-docs
-	$(QUIET)mkdir $@
-.build/lint-docs/gitlink/howto: | .build/lint-docs/gitlink
-	$(QUIET)mkdir $@
-.build/lint-docs/gitlink/config: | .build/lint-docs/gitlink
-	$(QUIET)mkdir $@
 LINT_DOCS_GITLINK = $(patsubst %.txt,.build/lint-docs/gitlink/%.ok,$(HOWTO_TXT) $(DOC_DEP_TXT))
-$(LINT_DOCS_GITLINK): | .build/lint-docs/gitlink
-$(LINT_DOCS_GITLINK): | .build/lint-docs/gitlink/howto
-$(LINT_DOCS_GITLINK): | .build/lint-docs/gitlink/config
 $(LINT_DOCS_GITLINK): lint-gitlink.perl
 $(LINT_DOCS_GITLINK): .build/lint-docs/gitlink/%.ok: %.txt
+	$(call mkdir_p_parent_template)
 	$(QUIET_LINT_GITLINK)$(PERL_PATH) lint-gitlink.perl \
 		$< \
 		$(HOWTO_TXT) $(DOC_DEP_TXT) \
@@ -463,23 +449,18 @@ $(LINT_DOCS_GITLINK): .build/lint-docs/gitlink/%.ok: %.txt
 lint-docs-gitlink: $(LINT_DOCS_GITLINK)
 
 ## Lint: man-end-blurb
-.build/lint-docs/man-end-blurb: | .build/lint-docs
-	$(QUIET)mkdir $@
 LINT_DOCS_MAN_END_BLURB = $(patsubst %.txt,.build/lint-docs/man-end-blurb/%.ok,$(MAN_TXT))
-$(LINT_DOCS_MAN_END_BLURB): | .build/lint-docs/man-end-blurb
 $(LINT_DOCS_MAN_END_BLURB): lint-man-end-blurb.perl
 $(LINT_DOCS_MAN_END_BLURB): .build/lint-docs/man-end-blurb/%.ok: %.txt
+	$(call mkdir_p_parent_template)
 	$(QUIET_LINT_MANEND)$(PERL_PATH) lint-man-end-blurb.perl $< >$@
 .PHONY: lint-docs-man-end-blurb
-lint-docs-man-end-blurb: $(LINT_DOCS_MAN_END_BLURB)
 
 ## Lint: man-section-order
-.build/lint-docs/man-section-order: | .build/lint-docs
-	$(QUIET)mkdir $@
 LINT_DOCS_MAN_SECTION_ORDER = $(patsubst %.txt,.build/lint-docs/man-section-order/%.ok,$(MAN_TXT))
-$(LINT_DOCS_MAN_SECTION_ORDER): | .build/lint-docs/man-section-order
 $(LINT_DOCS_MAN_SECTION_ORDER): lint-man-section-order.perl
 $(LINT_DOCS_MAN_SECTION_ORDER): .build/lint-docs/man-section-order/%.ok: %.txt
+	$(call mkdir_p_parent_template)
 	$(QUIET_LINT_MANSEC)$(PERL_PATH) lint-man-section-order.perl $< >$@
 .PHONY: lint-docs-man-section-order
 lint-docs-man-section-order: $(LINT_DOCS_MAN_SECTION_ORDER)
diff --git a/Makefile b/Makefile
index d4c0f4ca7b8..12f08411d2d 100644
--- a/Makefile
+++ b/Makefile
@@ -2745,7 +2745,8 @@ all:: $(MOFILES)
 endif
 
 po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
-	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
+	$(call mkdir_p_parent_template)
+	$(QUIET_MSGFMT)$(MSGFMT) -o $@ $<
 
 LIB_PERL := $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
 LIB_PERL_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
@@ -2761,15 +2762,16 @@ NO_PERL_CPAN_FALLBACKS_SQ = $(subst ','\'',$(NO_PERL_CPAN_FALLBACKS))
 endif
 
 perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
-	$(QUIET_GEN)mkdir -p $(dir $@) && \
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN) \
 	sed -e 's|@@LOCALEDIR@@|$(perl_localedir_SQ)|g' \
 	    -e 's|@@NO_GETTEXT@@|$(NO_GETTEXT_SQ)|g' \
 	    -e 's|@@NO_PERL_CPAN_FALLBACKS@@|$(NO_PERL_CPAN_FALLBACKS_SQ)|g' \
 	< $< > $@
 
 perl/build/man/man3/Git.3pm: perl/Git.pm
-	$(QUIET_GEN)mkdir -p $(dir $@) && \
-	pod2man $< $@
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN)pod2man $< $@
 
 $(ETAGS_TARGET): $(FOUND_SOURCE_FILES)
 	$(QUIET_GEN)$(RM) $@+ && \
@@ -2903,7 +2905,7 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
 
 bin-wrappers/%: wrap-for-bin.sh
-	@mkdir -p bin-wrappers
+	$(call mkdir_p_parent_template)
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
 	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
diff --git a/shared.mak b/shared.mak
index bb910273538..83c22d5e7b3 100644
--- a/shared.mak
+++ b/shared.mak
@@ -59,6 +59,8 @@ ifndef V
 	QUIET          = @
 	QUIET_GEN      = @echo $(wspfx_SQ) GEN $@;
 
+	QUIET_MKDIR_P_PARENT  = @echo $(wspfx_SQ) MKDIR -p $(@D);
+
 ## Used in "Makefile"
 	QUIET_CC       = @echo $(wspfx_SQ) CC $@;
 	QUIET_AR       = @echo $(wspfx_SQ) AR $@;
@@ -90,3 +92,18 @@ ifndef V
 	export V
 endif
 endif
+
+### Templates
+
+## mkdir_p_parent: lazily "mkdir -p" the path needed for a $@
+## file. Uses $(wildcard) to avoid the "mkdir -p" if it's not
+## needed.
+##
+## Is racy, but in a good way; we might redundantly (and safely)
+## "mkdir -p" when running in parallel, but won't need to exhaustively create
+## individual rules for "a" -> "prefix" -> "dir" -> "file" if given a
+## "a/prefix/dir/file". This can instead be inserted at the start of
+## the "a/prefix/dir/file" rule.
+define mkdir_p_parent_template
+$(if $(wildcard $(@D)),,$(QUIET_MKDIR_P_PARENT)$(shell mkdir -p $(@D)))
+endef
-- 
2.35.1.1228.g56895c6ee86

