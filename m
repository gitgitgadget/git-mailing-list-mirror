Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3B7C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiCCQF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiCCQFs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:05:48 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A227E1986FD
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:04:50 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so5101744wmj.2
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 08:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T9pBIHMQlku2xowPuIJ28h+oqti7KhK+YEMs7gQe5/k=;
        b=JYnkj3epLc2oyknsiSwIEvk6BdWb6HqlG/KX46JPpB4PjWLoX2Fe7l57p6Q+KQ+pNF
         /qjwxP11BvDaEOewwKRp2yUhJEGfJb74eQDvT4/B4vzMtYeYwcnHWqK3kT/evYIBJf59
         EgIQuF7p3uRazkRT7FnwX8EXOZzRxMSnMScdQ+dfuncxbqhHfsX0CdJjHWXSzIimaXyV
         nbd1bnyxGNA0ba4XQg47vscJS0HxVIMjCLgR5lD6kUSZf/tf2yLcie53dgjYxtjGHbb5
         yXbomnJjkU0jRrRfNSnS3oQykdjFbwfkmUmvF+OBqW/KzJ6kkuFMsbm7KLfeSQjWRl5i
         HDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T9pBIHMQlku2xowPuIJ28h+oqti7KhK+YEMs7gQe5/k=;
        b=hGTgi49aYC7otzZrt9g0opUfTHgGOUfyoyV/scq5LiQUtB2ycRMstrYPV7FcQw+5ZI
         w997/OSg33qcTGmjxnbkwyw8jiU+VUMi5aUvplUzpirU45ad5XMs4Zyv1pxHvmJNVvs/
         IwSLAE1XncefUttoHXuLOoTnw7KmW9eSVIhreMOfGAZRjEEH75qXLtvQHpVTLi+7g9kq
         t+CM9l6HFiCH2RbrNJuFb+QgdkYlPFl1hx6IJvvPB87cpuczQVJLLe0UqcHw0vXxtgle
         wruElmt1yy810IcX2Tr+ff2J7Y5k5rl0kfe8rzSe5sCPropevcPtUJTA4pZ3wjSZhvlP
         ueMQ==
X-Gm-Message-State: AOAM533SofIqLHgZS56NjOREzs/CLXBm8SU9BPrfZiK7o7bNvhn35W67
        r2qmgFVEksQFRta7hEBwPTyeMMwXI+wK6g==
X-Google-Smtp-Source: ABdhPJz1RmYGsqG7OwSKWdbgtG8HRDZKAw4MEBxVwrevL4OYhX49fjZRhxnmbNkrcJI2ATOJvdt1EA==
X-Received: by 2002:a05:600c:3d13:b0:37b:b8e5:ed80 with SMTP id bh19-20020a05600c3d1300b0037bb8e5ed80mr4202493wmb.183.1646323488753;
        Thu, 03 Mar 2022 08:04:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b00386744cb31bsm4040667wmq.35.2022.03.03.08.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:04:47 -0800 (PST)
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
Subject: [PATCH v5 8/8] Makefiles: add and use wildcard "mkdir -p" template
Date:   Thu,  3 Mar 2022 17:04:19 +0100
Message-Id: <patch-v5-8.8-e6a93cae81d-20220303T160155Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1230.ga6e6579e98c
In-Reply-To: <cover-v5-0.8-00000000000-20220303T160155Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com> <cover-v5-0.8-00000000000-20220303T160155Z-avarab@gmail.com>
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
index c45b2812eb6..4e1b62ee99e 100644
--- a/shared.mak
+++ b/shared.mak
@@ -53,6 +53,8 @@ ifndef V
 	QUIET          = @
 	QUIET_GEN      = @echo '   ' GEN $@;
 
+	QUIET_MKDIR_P_PARENT  = @echo $(wspfx_SQ) MKDIR -p $(@D);
+
 ## Used in "Makefile"
 	QUIET_CC       = @echo '   ' CC $@;
 	QUIET_AR       = @echo '   ' AR $@;
@@ -84,3 +86,18 @@ ifndef V
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
2.35.1.1230.ga6e6579e98c

