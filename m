Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52941C433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 344766103B
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbhKFVGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbhKFVGb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:06:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA7DC079782
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:03:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t30so19490630wra.10
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wXFGjLLAT1sS4eVzlvP+au7IjOMaeMphD8AAPnf7p6c=;
        b=QiGccxAu+uw13f5DjbvabPiRlmbFsWz/3ISFKWh/yU17eELEBF7szq5+J43IHH2GYv
         PRIzm8KIByIVscYPLdDYko0RC8Cn5PaU5p/H61h/gBHVWmw2HmI7olkbxbwKmp5uIiDV
         UKAbpI8eZSL8DUYnUT+E6fNj1eVzjHzpkajL4GbFD+aLT2bf2jURVHSY05OSuusvt9wt
         R47zDLPthPSU06iOpq9fzRQozIv/xZumcKlHLDVQvTBF92Xd06l+mKgOPko6zLuweUXI
         CUEht64BMPqRwYwNQUIS8ToekdQFngCVk80Ujoan+62NZ7oVur3VyvYi37/GrREKwxg5
         5t8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wXFGjLLAT1sS4eVzlvP+au7IjOMaeMphD8AAPnf7p6c=;
        b=eZsdEOyeFhGcWCY8Gj5qeXCMLQQoeAgTb9AD8NJkHhnjt73oNkfDAJHTMzPmrlkL9F
         DIsxx1e1goJxUVNQ5N7y+utFwv2zL9AxToFBF0LRnPM/TzQRpvKNgfnS9pcDQNmyxsIb
         bgLqN1dHJ/92JpGI+aQKU+bNpx9mUkMj2dUjqwHpmSpwzGcci0IPW5YbVS+S7gPxvPRX
         sjVSEq5/yb99xhzZ6QsiP44Dc5E1uovBxxu6kmjkDILZd+KdaWGuDqRHBznVLthuaDHb
         7SkDjbNWHYSYyor+t5N+wuL0gcLCSLxy0PCQ0vIuUiio7/z0nJSI9XjLDtF3kO5lCjJ1
         1Epg==
X-Gm-Message-State: AOAM5324BoA/I5jw7XBmUI9OF2ER4MLRSQ14wKTSAz9Ob/pE9kRLNuzD
        k58FhycLmkQWP9PD75nKZMn8Fk93P6e64w==
X-Google-Smtp-Source: ABdhPJxURWm4qX4rcxrY5UldCWiwpe/s4lShXdUIg4k1Ygd9WdrqlMla0a3BrZLRhdfVrMh8mVP1rQ==
X-Received: by 2002:a5d:5144:: with SMTP id u4mr77410948wrt.91.1636232612318;
        Sat, 06 Nov 2021 14:03:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u16sm14108433wmc.21.2021.11.06.14.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:03:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/16] Makefiles: add and use wildcard "mkdir -p" template
Date:   Sat,  6 Nov 2021 22:03:16 +0100
Message-Id: <patch-15.16-412a11f63a3-20211106T205717Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
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
of the performance test I noted downthread of [1] in [2] shows that
this is faster, in addition to being less verbose and more reliable:

    $ hyperfine --warmup 5 -m 30 -L s ",~" -p 'git checkout HEAD{s} -- Makefile; rm -rf .build' 'make -j8 lint-docs R={s}'
     -c 'git checkout HEAD -- Makefile'
    Benchmark #1: make -j8 lint-docs R=
      Time (mean ± σ):     537.5 ms ±   7.1 ms    [User: 2.412 s, System: 0.460 s]
      Range (min … max):   530.2 ms … 564.9 ms    30 runs

    Benchmark #2: make -j8 lint-docs R=~
      Time (mean ± σ):     645.7 ms ±   7.1 ms    [User: 3.083 s, System: 0.630 s]
      Range (min … max):   637.4 ms … 675.2 ms    30 runs

    Summary
      'make -j8 lint-docs R=' ran
        1.20 ± 0.02 times faster than 'make -j8 lint-docs R=~'

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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile | 25 +++----------------------
 Makefile               | 12 +++++++-----
 shared.mak             |  7 +++++++
 3 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 69a9af35397..d16b653394c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -428,25 +428,11 @@ quick-install-html: require-htmlrepo
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
@@ -457,23 +443,18 @@ $(LINT_DOCS_GITLINK): .build/lint-docs/gitlink/%.ok: %.txt
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
index cd7727ebe39..141a87371fe 100644
--- a/Makefile
+++ b/Makefile
@@ -2622,7 +2622,8 @@ all:: $(MOFILES)
 endif
 
 po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
-	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
+	$(call mkdir_p_parent_template)
+	$(QUIET_MSGFMT)$(MSGFMT) -o $@ $<
 
 ifndef NO_PERL
 LIB_PERL := $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
@@ -2631,7 +2632,8 @@ LIB_CPAN := $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
 LIB_CPAN_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_CPAN))
 
 perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
-	$(QUIET_GEN)mkdir -p $(dir $@) && \
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN) \
 	sed -e 's|@@LOCALEDIR@@|$(perl_localedir_SQ)|g' \
 	    -e 's|@@NO_GETTEXT@@|$(NO_GETTEXT_SQ)|g' \
 	    -e 's|@@NO_PERL_CPAN_FALLBACKS@@|$(call shq,$(NO_PERL_CPAN_FALLBACKS))|g' \
@@ -2645,8 +2647,8 @@ endif
 
 # install-man depends on Git.3pm even with NO_PERL=Y
 perl/build/man/man3/Git.3pm: perl/Git.pm
-	$(QUIET_GEN)mkdir -p $(dir $@) && \
-	pod2man $< $@
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN)pod2man $< $@
 
 FIND_SOURCE_FILES = ( \
 	git ls-files \
@@ -2770,7 +2772,7 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
 
 bin-wrappers/%: wrap-for-bin.sh
-	@mkdir -p bin-wrappers
+	$(call mkdir_p_parent_template)
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
 	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
diff --git a/shared.mak b/shared.mak
index 566eb70cf2a..ced88924ea3 100644
--- a/shared.mak
+++ b/shared.mak
@@ -73,6 +73,8 @@ ifndef V
 	QUIET          = @
 	QUIET_GEN      = @echo $(wspfx_sq) GEN $@;
 
+	QUIET_MKDIR_P_PARENT  = @echo $(wspfx_sq) MKDIR -p $(@D);
+
 ## Used in "Makefile"
 	QUIET_CC       = @echo $(wspfx_sq) CC $@;
 	QUIET_AR       = @echo $(wspfx_sq) AR $@;
@@ -104,3 +106,8 @@ ifndef V
 	export V
 endif
 endif
+
+## Helpers
+define mkdir_p_parent_template
+$(if $(wildcard $(@D)),,$(QUIET_MKDIR_P_PARENT)$(shell mkdir -p $(@D)))
+endef
-- 
2.34.0.rc1.741.gab7bfd97031

