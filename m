Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4A9C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CB861B39
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbhKPMHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbhKPMFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:05:25 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA51EC0797B5
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:51 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a9so10851908wrr.8
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FV1QtdN8Z1ZpecyngUgYpHXhT9Ht/Sv+3/E2cLt8Vts=;
        b=SB1J49BaJorVAqXOdABpGEXo4dAwLvkMcmI4fvVL5d+GZ4gsRDys9Ij4BkBLoHiZhx
         uA01+LjPVPSV/YMxLILHe7Db5uEIRZods1M7BvVxaaOiu5SJkVqf4JcDr8ymMcjNfbhS
         VnmtFqjyDCyT5dJCEyACnDMoWvE7M6Ql1IUbtJIn3YoGWMaqctqRuvhSfqzKclpUxih9
         BJQVRq8C2hI/n2fTXfd0GTtgQwMJTEKMrVF/A8RLXHRRO0oMdwzznyxGFrYf9Czhrbdj
         1NvLHHGv8mUldtUBCuQ4XJhpwTZlb0XkfimK9oDebHrfe2zYS+a7QK/Wpumg/FfjeXpT
         dEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FV1QtdN8Z1ZpecyngUgYpHXhT9Ht/Sv+3/E2cLt8Vts=;
        b=SaJJvhQCfFZ4IDs0rCY2YIk2nLgwPY5a8avKNg3SmiJ3dVO2IvUrS6NafAxqhzU9GN
         qv+qO/rcqhPrHfXZM2KZh6u52pzUUZmzCrwjLFbMHQsqiGfg7tM/xajn1dO9+wQepu6k
         g93+k0krDcqydANEp61q90rMQx/WfefcIguwssH1qN9vDjOCZtBTleLeCeIFq8GoaKMe
         gC9bF3BMF81RqcWl+ALEBPXPcZRGoY6KywOvzV3GDufZFCRkBAWjDJTvGh2iB6BN+jQ2
         9L4MMWF/95FkIv8FT6mmGdl4N49eIpYColVjcSY3+pWIBsLtx8mM1V4xwuAG8JZQuvyh
         V3Eg==
X-Gm-Message-State: AOAM532l8EPnki4IRQ0yyrhhwStnI+gHpo2CowGytoSPYvCBR8lfwgOo
        RIVFkxCx9RPL/IpqCNbeTGJGiWXCN9CN6w==
X-Google-Smtp-Source: ABdhPJyci8FDJasl8QfrY8xN1bUO2JNb5Vd2M8cKjvbmzWKZJ6s1/KRgA1xv5crOQBSTLybHtQ94sA==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr8662513wrm.79.1637064049954;
        Tue, 16 Nov 2021 04:00:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:49 -0800 (PST)
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
Subject: [PATCH v3 18/23] Makefiles: add and use wildcard "mkdir -p" template
Date:   Tue, 16 Nov 2021 13:00:18 +0100
Message-Id: <patch-v3-18.23-d61e2b44f68-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
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
of a performance test similar to thatnoted downthread of [1] in [2]
shows that this is faster, in addition to being less verbose and more
reliable (this uses my "git-hyperfine" thin wrapper for "hyperfine"[3]):

    $ git hyperfine -L rev HEAD~0,HEAD~1 -b 'make -C Documentation lint-docs' -p 'rm -rf Documentation/.build' 'make -C Documentation lint-docs'
    Benchmark 1: make -C Documentation lint-docs' in 'HEAD~0
      Time (mean ± σ):      2.129 s ±  0.011 s    [User: 1.840 s, System: 0.321 s]
      Range (min … max):    2.121 s …  2.158 s    10 runs

    Benchmark 2: make -C Documentation lint-docs' in 'HEAD~1
      Time (mean ± σ):      2.659 s ±  0.002 s    [User: 2.306 s, System: 0.397 s]
      Range (min … max):    2.657 s …  2.662 s    10 runs

    Summary
      'make -C Documentation lint-docs' in 'HEAD~0' ran
        1.25 ± 0.01 times faster than 'make -C Documentation lint-docs' in 'HEAD~1'

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
index c437aea9e4a..0a3f292bf82 100644
--- a/Makefile
+++ b/Makefile
@@ -2632,7 +2632,8 @@ all:: $(MOFILES)
 endif
 
 po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
-	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
+	$(call mkdir_p_parent_template)
+	$(QUIET_MSGFMT)$(MSGFMT) -o $@ $<
 
 ifndef NO_PERL
 LIB_PERL = $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
@@ -2641,7 +2642,8 @@ LIB_CPAN = $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
 LIB_CPAN_GEN = $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_CPAN))
 
 perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
-	$(QUIET_GEN)mkdir -p $(dir $@) && \
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN) \
 	sed -e 's|@@LOCALEDIR@@|$(perl_localedir_SQ)|g' \
 	    -e 's|@@NO_GETTEXT@@|$(NO_GETTEXT_SQ)|g' \
 	    -e 's|@@NO_PERL_CPAN_FALLBACKS@@|$(call shq,$(NO_PERL_CPAN_FALLBACKS))|g' \
@@ -2655,8 +2657,8 @@ endif
 
 # install-man depends on Git.3pm even with NO_PERL=Y
 perl/build/man/man3/Git.3pm: perl/Git.pm
-	$(QUIET_GEN)mkdir -p $(dir $@) && \
-	pod2man $< $@
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN)pod2man $< $@
 
 FIND_SOURCE_FILES = ( \
 	git ls-files \
@@ -2780,7 +2782,7 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
 
 bin-wrappers/%: wrap-for-bin.sh
-	@mkdir -p bin-wrappers
+	$(call mkdir_p_parent_template)
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
 	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
diff --git a/shared.mak b/shared.mak
index a1b62b272f8..363138a5577 100644
--- a/shared.mak
+++ b/shared.mak
@@ -56,6 +56,8 @@ ifndef V
 	QUIET          = @
 	QUIET_GEN      = @echo $(wspfx_sq) GEN $@;
 
+	QUIET_MKDIR_P_PARENT  = @echo $(wspfx_sq) MKDIR -p $(@D);
+
 ## Used in "Makefile"
 	QUIET_CC       = @echo $(wspfx_sq) CC $@;
 	QUIET_AR       = @echo $(wspfx_sq) AR $@;
@@ -88,6 +90,11 @@ ifndef V
 endif
 endif
 
+## Helpers
+define mkdir_p_parent_template
+$(if $(wildcard $(@D)),,$(QUIET_MKDIR_P_PARENT)$(shell mkdir -p $(@D)))
+endef
+
 ### Templates
 
 ## Template for making a GIT-SOMETHING, which changes if a
-- 
2.34.0.795.g1e9501ab396

