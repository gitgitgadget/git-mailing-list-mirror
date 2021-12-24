Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D72C433F5
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 17:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353350AbhLXRiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 12:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353339AbhLXRiD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 12:38:03 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3267BC061759
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:38:03 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso5142700wmf.3
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e/NE2USe1s0q3f2npJI6i5R+q+XYZnCzOfmE1FD+f4c=;
        b=NbXhdpV1nmy97cq8elbr6N3CNMDLQsIBYnyFYNqO0+WPD7n7NZILUHPSbcspXXG/Oh
         XxiwgE9Thk6yJ7ScYm/jLGfeF0WHT/wlfqUXIXgM4OaRDKn/jS2xlFStNgi46DxJh++O
         fh2ojSnWD8t+FVzcUwIxSe6Dpdj/QBmOIy8k4SlGU7Ax7VbU12x0ZTV8EbdByMXVv+Hq
         ii2JmvBgNXltJqal4qVjOfAqfbMgNB6R3iJF0tSge73vD47CQP3Q6D//bP00fQlwFWD3
         eQyvZFAt56xFufO7SyTvO00vJxOG171s8ZgBSRtb04SBR3CY49hw/qnrmR7RVWZ0Li0M
         lpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/NE2USe1s0q3f2npJI6i5R+q+XYZnCzOfmE1FD+f4c=;
        b=IarigfLHvoOOC3bIiTH//YnELKffugRQe93KRuQQEYqOTiDkz+131itumf+MAhPfRH
         9jhlzC1tH9GiuTCuXMWGpioD1UJX4QEGBG6tRAmdhIc1EHr10PSy+yEFl7iLWcxxpw+3
         MKiwNjNx5IMO3zDzHu4SqVkfNC/L7hcP5Ovu2b+8MkRIWYn8SJxBgkA8er8OFbhwXDOs
         bIPosF3eKFaUeO24CTHtrnbPSKrK3Ni+m1rSFJi5gB4TDgcaNQPzOPAZiw4KyrMNsK7K
         8GKPUA0NBC2SJO4upRvZQAw8qQ8RZZhBL5uChMTiv3CTq9Sv/+MoSV3g02+mtnhG0w/g
         8+tQ==
X-Gm-Message-State: AOAM531wwzmMai0RPCUoMZwAdt41SP12A0GcOmeNuCXJlT/2Xasbvq63
        HF59fx6c0P4EWPeh3ZLxpwULLpglSYAEMHZB
X-Google-Smtp-Source: ABdhPJyZKjKawHB+qbaYk6/ptxEoJHL6jUnZZSQC7LEpewArzoRiqWtcmiEQ/qHfmN1xLIVZXGvsMQ==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr5648499wma.95.1640367481566;
        Fri, 24 Dec 2021 09:38:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j3sm8033518wro.22.2021.12.24.09.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 09:38:01 -0800 (PST)
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
Subject: [PATCH v2 8/8] Makefiles: add and use wildcard "mkdir -p" template
Date:   Fri, 24 Dec 2021 18:37:47 +0100
Message-Id: <patch-v2-8.8-59c1b7032db-20211224T173558Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1215.g6e154b84c77
In-Reply-To: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
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
index d8051278519..5474c27f2b1 100644
--- a/Makefile
+++ b/Makefile
@@ -2714,7 +2714,8 @@ all:: $(MOFILES)
 endif
 
 po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
-	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
+	$(call mkdir_p_parent_template)
+	$(QUIET_MSGFMT)$(MSGFMT) -o $@ $<
 
 LIB_PERL := $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
 LIB_PERL_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
@@ -2730,15 +2731,16 @@ NO_PERL_CPAN_FALLBACKS_SQ = $(subst ','\'',$(NO_PERL_CPAN_FALLBACKS))
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
@@ -2872,7 +2874,7 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
 
 bin-wrappers/%: wrap-for-bin.sh
-	@mkdir -p bin-wrappers
+	$(call mkdir_p_parent_template)
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
 	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
diff --git a/shared.mak b/shared.mak
index f8ebaf30569..7787f81856c 100644
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
2.34.1.1215.g6e154b84c77

