Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C702AC433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 01:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhLQBjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 20:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhLQBjp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 20:39:45 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8CCC06175B
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:40 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so2160381wmb.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wl51eiYaOtIIpZhnljq5dLdMo4WcIHjzQynshgRbYE8=;
        b=A+dK4P/g4Mximupy79EFFElOVpFWLaanZVCn0qWYNDYuxZZwNU4OE3MfTZ+9bF0BN1
         /lqkIMjR6pk0hgWhT9daGOT2VzH9l2p01N5ZF38hNvMUk8+lbA039Oqcyb2yClUYR5Kg
         FzHvb78q7rE+YynzUpSOr4DKZ6DrumCDz+fNt11TOR1H6/WRAPFot7EdIgLnxoG1rswR
         KWsSqF9/nKY4ona4lSx4RUx5BN+si1ddlyQkv+skWDIS/xxZFI+mh5SOqtIPPsS4JwaN
         GvtnQKMr9SEdpR7P7j2JLYrwd46nyX+1DXytM6uiCw8JGW6ZcK1j0TJmlHT5B7Kt+oi2
         kSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wl51eiYaOtIIpZhnljq5dLdMo4WcIHjzQynshgRbYE8=;
        b=z9P3MLITAkun3OEoT+5xjjhraE/ivRO36gTlWG5UtYexwvAa5qtF6aBVdynxF/b6OF
         KytC8euAyc/aVJCFp9Gfhy7coNE37bTPjs9+SkhNXdQqhow1QL/jdu99n5C9KnGVN6vY
         PiediI3ZTwMwx7x1gUWpwp+Sk0HJR4NIjs/tRv5Zr8rbERXw/iMfmAt4bWKA/9Wk263g
         EYgj64EMdmiLN2ODtlnkjjszkTehYk0IQfa7Tm4+xG5Cnv0qw8uuSdndl6J0i5rVx2uP
         49pMhY6L1LLULRmavHt1Ehsns/Dca7c6gsxdR4Z0XABIjwPP3ertRQEx+FPqzvy1vs+4
         QeWg==
X-Gm-Message-State: AOAM531dUtPTibAigBtMIq45hlrmewWiwqM6BOWOzXJydnBKEJcVUszn
        NxuU4l5Cuu+82TnPX/gGVsHa+9oZgW4myA==
X-Google-Smtp-Source: ABdhPJxWqJR8WHwfFg+IGK8oLY24VqaBt9p8I9qUWpV/ojzoPcKMWaB0WlUmD3ncBCWzGcW1uekJaw==
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr7403950wmg.67.1639705178960;
        Thu, 16 Dec 2021 17:39:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c4sm5843869wrr.37.2021.12.16.17.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 17:39:38 -0800 (PST)
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
Subject: [PATCH 8/8] Makefiles: add and use wildcard "mkdir -p" template
Date:   Fri, 17 Dec 2021 02:39:26 +0100
Message-Id: <patch-8.8-aca560ca410-20211217T012902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
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
index 9f27fc77e5a..ed601534967 100644
--- a/Makefile
+++ b/Makefile
@@ -2704,7 +2704,8 @@ all:: $(MOFILES)
 endif
 
 po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
-	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
+	$(call mkdir_p_parent_template)
+	$(QUIET_MSGFMT)$(MSGFMT) -o $@ $<
 
 LIB_PERL := $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
 LIB_PERL_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
@@ -2720,15 +2721,16 @@ NO_PERL_CPAN_FALLBACKS_SQ = $(subst ','\'',$(NO_PERL_CPAN_FALLBACKS))
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
@@ -2862,7 +2864,7 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
 
 bin-wrappers/%: wrap-for-bin.sh
-	@mkdir -p bin-wrappers
+	$(call mkdir_p_parent_template)
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
 	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
diff --git a/shared.mak b/shared.mak
index f8ebaf30569..13fb5eb93bb 100644
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
+## "mkdir -p" when running in parallel, but won't need to exhaustively
+## individual rules for "a" -> "prefix" -> "dir" -> "file" if given a
+## "a/prefix/dir/file". This can instead be inserted at the start of
+## the "a/prefix/dir/file" rule.
+define mkdir_p_parent_template
+$(if $(wildcard $(@D)),,$(QUIET_MKDIR_P_PARENT)$(shell mkdir -p $(@D)))
+endef
-- 
2.34.1.1119.g7a3fc8778ee

