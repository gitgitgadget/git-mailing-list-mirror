Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BBCC433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD6661090
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbhJOMmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238958AbhJOMlj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 08:41:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2283CC06176D
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:39:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v17so26212470wrv.9
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sWQdpMOrCQC4WOSt7WaxL5ftYQ1hlTMLy43dDref8l4=;
        b=K/nO1OxvtMMjnwGvvCE6Do4QNHI5k1sSV9mO7/NZDwWB+Behb1cbwmEWZEs0G1d2By
         ijnEwuCLkZfwFz5Okes7MdJ4mLBf6aMuqnLJXg6K3ecr+FV1HBYhyUY177LZi7bSR1GL
         M50WNv95sYr8equvuYio1GbUX/HaVNVeZK73FYN5ElV1SH4eLcoGPQoTYpLGNR/FMes3
         YBpJNA3wX7A7ExcOALDwZGIzcrEhnn6PhP1U3Ok4BRuW2VwQ0OmBgpBeAupOWhk7qeyt
         OaymWeO4pWb8TSfbaZg8Reh7NDw3jqHyShIJyuLzNVl1rhxv/DWJaEBlVlCyUZ6FWnuM
         h7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWQdpMOrCQC4WOSt7WaxL5ftYQ1hlTMLy43dDref8l4=;
        b=Hs2SC5TLRD4KqHfLogr9pQVkmRvu7vFeIqt72PQh3B0ggAeyyFgpayCm7PN6MOpEc7
         ROvGBjk2eslWuR9soynkDVHTg1ab2FoPIvezWon0/8CGrCbyn6QnRsaTb444WJlz3hJ+
         Ej3cOM2lXASSuK81ZxGH1XaDH6kzfkUOydLMw35AfHq6MVWg0/M525a4DgNasGRN1UNH
         qMdtbTtLPdSq6dmbHXujhSs3Ht41QGw/lCUxVdxYHLAJpLPtYVb/Cj3OU70AA9aKMKiP
         v9MEKd+Uc4X38KEkgB13ZAAjB47tQcYYvUb8v7v20zvoapOomfoJSKfsAXfeyQZUfEGV
         6EKQ==
X-Gm-Message-State: AOAM530dMomTV2XZnriyuq/V3oRW4WQQ8SbhTv09Iwiq3iJRPqYJIBXB
        55nfVnfqewQURnEj0kfbvLBc0hhZFiJpUA==
X-Google-Smtp-Source: ABdhPJygEnjNwhA0LXxlw08OoavbP0sXN8sTVG9wvZKg90nOUAtG9dYyQSBmj9m3arj78y4EfQxFNw==
X-Received: by 2002:a05:6000:18aa:: with SMTP id b10mr13879241wri.270.1634301559451;
        Fri, 15 Oct 2021 05:39:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d1sm5388824wrr.72.2021.10.15.05.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:39:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/4] doc lint: make "lint-docs" non-.PHONY
Date:   Fri, 15 Oct 2021 14:39:14 +0200
Message-Id: <patch-4.4-800d7d81d42-20211015T123619Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.4-00000000000-20211015T123619Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20211015T123619Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Speed up the "lint-docs" target by making it non-.PHONY. Similar to my
c234e8a0ecf (Makefile: make the "sparse" target non-.PHONY,
2021-09-23). We'll now create empty files corresponding to a
dependency graph for each of these lint scripts.

This speeds things up a bit[1], and makes the output correspond to any
in-tree changes we have:

    $ touch git-add.txt; make lint-docs; make lint-docs
        GEN cmd-list.made
        GEN doc.dep
        LINT GITLINK git-add.txt
        LINT MAN END git-add.txt
        LINT MAN SEC git-add.txt
    make: Nothing to be done for 'lint-docs'.

As with the "sparse" target changes this has a hard dependency on the
use of ".DELETE_ON_ERROR" in the Makefile, added here in
db10fc6c09f (doc: simplify Makefile using .DELETE_ON_ERROR,
2021-05-21). This method also depends on the output for us emitting
any errors on STDERR (fixed in a preceding commit), as well us these
scripts exiting with non-zero on any errors (which they were already
doing).

1.
$ git show HEAD~:Documentation/Makefile >Makefile.old
$ hyperfine --warmup 2 -L f ",.old" 'make -j1 -f Makefile{f} lint-docs'
Benchmark #1: make -j1 -f Makefile lint-docs
  Time (mean ± σ):      60.8 ms ±   1.4 ms    [User: 58.7 ms, System: 2.5 ms]
  Range (min … max):    58.9 ms …  64.0 ms    48 runs

Benchmark #2: make -j1 -f Makefile.old lint-docs
  Time (mean ± σ):      84.0 ms ±   1.5 ms    [User: 78.6 ms, System: 5.7 ms]
  Range (min … max):    81.8 ms …  87.8 ms    35 runs

Summary
  'make -j1 -f Makefile lint-docs' ran
    1.38 ± 0.04 times faster than 'make -j1 -f Makefile.old lint-docs'

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/.gitignore        |  1 +
 Documentation/Makefile          | 65 ++++++++++++++++++++++++++++++---
 Documentation/lint-gitlink.perl |  6 ++-
 3 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index 9022d483554..1c3771e7d72 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -14,4 +14,5 @@ manpage-base-url.xsl
 SubmittingPatches.txt
 tmp-doc-diff/
 GIT-ASCIIDOCFLAGS
+/.build/
 /GIT-EXCLUDED-PROGRAMS
diff --git a/Documentation/Makefile b/Documentation/Makefile
index e8e54e053a6..46c91f32566 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -225,6 +225,7 @@ endif
 
 ifneq ($(findstring $(MAKEFLAGS),s),s)
 ifndef V
+	QUIET		= @
 	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
 	QUIET_XMLTO	= @echo '   ' XMLTO $@;
 	QUIET_DB2TEXI	= @echo '   ' DB2TEXI $@;
@@ -232,11 +233,15 @@ ifndef V
 	QUIET_DBLATEX	= @echo '   ' DBLATEX $@;
 	QUIET_XSLTPROC	= @echo '   ' XSLTPROC $@;
 	QUIET_GEN	= @echo '   ' GEN $@;
-	QUIET_LINT	= @echo '   ' LINT $@;
 	QUIET_STDERR	= 2> /dev/null
 	QUIET_SUBDIR0	= +@subdir=
 	QUIET_SUBDIR1	= ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			  $(MAKE) $(PRINT_DIR) -C $$subdir
+
+	QUIET_LINT_GITLINK	= @echo '   ' LINT GITLINK $<;
+	QUIET_LINT_MANSEC	= @echo '   ' LINT MAN SEC $<;
+	QUIET_LINT_MANEND	= @echo '   ' LINT MAN END $<;
+
 	export V
 endif
 endif
@@ -343,6 +348,7 @@ GIT-ASCIIDOCFLAGS: FORCE
             fi
 
 clean:
+	$(RM) -rf .build/
 	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7
 	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
 	$(RM) *.pdf
@@ -456,14 +462,61 @@ quick-install-html: require-htmlrepo
 print-man1:
 	@for i in $(MAN1_TXT); do echo $$i; done
 
-lint-docs::
-	$(QUIET_LINT)$(PERL_PATH) lint-gitlink.perl \
+## Lint: Common
+.build:
+	$(QUIET)mkdir $@
+.build/lint-docs: | .build
+	$(QUIET)mkdir $@
+
+## Lint: gitlink
+.build/lint-docs/gitlink: | .build/lint-docs
+	$(QUIET)mkdir $@
+.build/lint-docs/gitlink/howto: | .build/lint-docs
+	$(QUIET)mkdir $@
+.build/lint-docs/gitlink/config: | .build/lint-docs
+	$(QUIET)mkdir $@
+LINT_DOCS_GITLINK = $(patsubst %.txt,.build/lint-docs/gitlink/%.ok,$(HOWTO_TXT) $(DOC_DEP_TXT))
+$(LINT_DOCS_GITLINK): | .build/lint-docs/gitlink
+$(LINT_DOCS_GITLINK): | .build/lint-docs/gitlink/howto
+$(LINT_DOCS_GITLINK): | .build/lint-docs/gitlink/config
+$(LINT_DOCS_GITLINK): lint-gitlink.perl
+$(LINT_DOCS_GITLINK): .build/lint-docs/gitlink/%.ok: %.txt
+	$(QUIET_LINT_GITLINK)$(PERL_PATH) lint-gitlink.perl \
+		$< \
 		$(HOWTO_TXT) $(DOC_DEP_TXT) \
 		--section=1 $(MAN1_TXT) \
 		--section=5 $(MAN5_TXT) \
-		--section=7 $(MAN7_TXT) && \
-	$(PERL_PATH) lint-man-end-blurb.perl $(MAN_TXT) && \
-	$(PERL_PATH) lint-man-section-order.perl $(MAN_TXT)
+		--section=7 $(MAN7_TXT) >$@
+.PHONY: lint-docs-gitlink
+lint-docs-gitlink: $(LINT_DOCS_GITLINK)
+
+## Lint: man-end-blurb
+.build/lint-docs/man-end-blurb: | .build/lint-docs
+	$(QUIET)mkdir $@
+LINT_DOCS_MAN_END_BLURB = $(patsubst %.txt,.build/lint-docs/man-end-blurb/%.ok,$(MAN_TXT))
+$(LINT_DOCS_MAN_END_BLURB): | .build/lint-docs/man-end-blurb
+$(LINT_DOCS_MAN_END_BLURB): lint-man-end-blurb.perl
+$(LINT_DOCS_MAN_END_BLURB): .build/lint-docs/man-end-blurb/%.ok: %.txt
+	$(QUIET_LINT_MANEND)$(PERL_PATH) lint-man-end-blurb.perl $< >$@
+.PHONY: lint-docs-man-end-blurb
+lint-docs-man-end-blurb: $(LINT_DOCS_MAN_END_BLURB)
+
+## Lint: man-section-order
+.build/lint-docs/man-section-order: | .build/lint-docs
+	$(QUIET)mkdir $@
+LINT_DOCS_MAN_SECTION_ORDER = $(patsubst %.txt,.build/lint-docs/man-section-order/%.ok,$(MAN_TXT))
+$(LINT_DOCS_MAN_SECTION_ORDER): | .build/lint-docs/man-section-order
+$(LINT_DOCS_MAN_SECTION_ORDER): lint-man-section-order.perl
+$(LINT_DOCS_MAN_SECTION_ORDER): .build/lint-docs/man-section-order/%.ok: %.txt
+	$(QUIET_LINT_MANSEC)$(PERL_PATH) lint-man-section-order.perl $< >$@
+.PHONY: lint-docs-man-section-order
+lint-docs-man-section-order: $(LINT_DOCS_MAN_SECTION_ORDER)
+
+## Lint: list of targets above
+.PHONY: lint-docs
+lint-docs: lint-docs-gitlink
+lint-docs: lint-docs-man-end-blurb
+lint-docs: lint-docs-man-section-order
 
 ifeq ($(wildcard po/Makefile),po/Makefile)
 doc-l10n install-l10n::
diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
index 076701ccfac..1c61dd9512b 100755
--- a/Documentation/lint-gitlink.perl
+++ b/Documentation/lint-gitlink.perl
@@ -5,11 +5,12 @@
 
 # Parse arguments, a simple state machine for input like:
 #
-# howto/*.txt config/*.txt --section=1 git.txt git-add.txt [...] --to-lint git-add.txt a-file.txt [...]
+# <file-to-check.txt> <valid-files-to-link-to> --section=1 git.txt git-add.txt [...] --to-lint git-add.txt a-file.txt [...]
 my %TXT;
 my %SECTION;
 my $section;
 my $lint_these = 0;
+my $to_check = shift @ARGV;
 for my $arg (@ARGV) {
 	if (my ($sec) = $arg =~ /^--section=(\d+)$/s) {
 		$section = $sec;
@@ -36,7 +37,8 @@ sub report {
 }
 
 @ARGV = sort values %TXT;
-die "BUG: Nothing to process!" unless @ARGV;
+die "BUG: No list of valid linkgit:* files given" unless @ARGV;
+@ARGV = $to_check;
 while (<>) {
 	my $line = $_;
 	while ($line =~ m/linkgit:((.*?)\[(\d)\])/g) {
-- 
2.33.1.1338.g20da966911a

