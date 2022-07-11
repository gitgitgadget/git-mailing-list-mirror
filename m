Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F152FC43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 11:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiGKLnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiGKLmx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 07:42:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86697F0B
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 04:37:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r129-20020a1c4487000000b003a2d053adcbso4817985wma.4
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 04:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7UtlV98ccYnhuaBSt+reyH4IFRW5Xu49/TCCsGTgrRY=;
        b=Lsept8lUXTUBqhEJaWxT9olx6nIrKp8UR6aqk/mHUpa9VJ9hHnwqiVYctCbThq010G
         l+vx6CzHVLw7m0rQ0VsDGLXwQEWo15MAUcQeOyoQqXQCumB1fO1Dg9OcXyRPh2oCTaHW
         rBGzaCVbfqYbVavb3zK4mV7qmO5DJVSyjjPP0LcVBK7ZQcSFxPGryY2Jb0Pr89ynfHkr
         rqP77z4clnCOUSlaMIQGCDgTrcPH1SQGhMhG++fHU1daHxm4YMj0ZjH3l46lLOr7L/0E
         6fYWxnrZu+K76wJNbu7EV4tmYqTMHvxcihYrue3ZQiwm3eL0aMe14mIzdv/R/tstCQH+
         /ZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7UtlV98ccYnhuaBSt+reyH4IFRW5Xu49/TCCsGTgrRY=;
        b=L+vdX4exJb+TkyvDZN9NHXs4YE4F3Pw5Iw/CXOnyWMEah41N0P7h1Cx9IQAtVibncv
         5ZcmWUR+2BmLiLx9ox2YNDO6IWUQD3nIxrNgdf4WOSqaO+sUm+GEnGflpJNM42YNsjHL
         xdG5UvWZ6BowMHDNkJalKIA9TSabMw6RMucr6lnOLGLPxOVkff8HCoe8BwPxunr+cXX3
         APaYcKtCJc/Cuqezyatsq+1yN4Um3/I9v9wWppvz0v0+9YzQaRZFg48kik6BV3jF7yqG
         FeGPQVZpex0zUQJ3PTLIOC5ainOvdJlpLPeFmc85gH9hCCJUjl791AV+QSICxHFMZZJn
         A/Lw==
X-Gm-Message-State: AJIora8yBt24rYODHa8bExga+t/96nJYaXRdx/9wiOugjljtfN5fdtWE
        8pF2P6gpVyRbTWxyWB6JYYRaOUw1lgg=
X-Google-Smtp-Source: AGRyM1vc95WVjdMA3J2w4ObnlUbTEmJsB85OXPoceBvUhHfgjO/xNqvYrbRFZLQGaBRCOgn8Rp6iMg==
X-Received: by 2002:a05:600c:19d2:b0:3a2:b7c1:861c with SMTP id u18-20020a05600c19d200b003a2b7c1861cmr15500888wmq.37.1657539458641;
        Mon, 11 Jul 2022 04:37:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b17-20020adff911000000b0021d819c8f6dsm5562463wrr.39.2022.07.11.04.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 04:37:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 1/4] Makefile: add a style-all targets for .clang-format testing
Date:   Mon, 11 Jul 2022 13:37:25 +0200
Message-Id: <RFC-patch-1.4-3f7c2275e19-20220711T110019Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g189dca38629
In-Reply-To: <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net> <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend "style" rule added in 2118805b929 (Makefile: add style build
rule, 2017-08-14) with a set of "style-all" rules. These rules all
apply our ".clang-format" added in 6134de6ac18 (clang-format: outline
the git project's coding style, 2017-08-14) to all our tracked files,
rather than using "git-clang-format", which only applies the rules to
files that differ from those that are tracked.

This allows for testing and improving the .clang-format itself, as it
should as closely as possible mirror out stated
Documentation/CodingGuidelines, or in cases where we don't have
explicit guidelines it should match the prevailing preferred style in
the project.

Let's apply one such change, in 6134de6ac18 the "AlignEscapedNewlines"
configuration was set to "Left", but as setting it to "DontAlign"
shows our more common pattern is to not align "\"'s across newlines in
macro definitions.

Before & after the .clang-format change, running:

	git checkout -f '*.[ch]' && make -k style-all-diff-ok -k; make style-all-diff-apply

Will yield, respectively:

	578 files changed, 32191 insertions(+), 29944 deletions(-)
	579 files changed, 32065 insertions(+), 29818 deletions(-)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .clang-format |  8 +++---
 Makefile      | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/.clang-format b/.clang-format
index c592dda681f..3f536c49f24 100644
--- a/.clang-format
+++ b/.clang-format
@@ -32,12 +32,12 @@ AlignConsecutiveAssignments: false
 # double b = 3.14;
 AlignConsecutiveDeclarations: false
 
-# Align escaped newlines as far left as possible
-# #define A   \
+# Do not align escaped newlines in macro definitions
+# #define A \
 #   int aaaa; \
-#   int b;    \
+#   int b; \
 #   int cccccccc;
-AlignEscapedNewlines: Left
+AlignEscapedNewlines: DontAlign
 
 # Align operands of binary and ternary expressions
 # int aaa = bbbbbbbbbbb +
diff --git a/Makefile b/Makefile
index 04d0fd1fe60..67306820002 100644
--- a/Makefile
+++ b/Makefile
@@ -3108,10 +3108,77 @@ $(HCO): %.hco: %.hcc FORCE
 .PHONY: hdr-check $(HCO)
 hdr-check: $(HCO)
 
+##
+## clang-format targets
+##
+
+### style: apply a clang-format "diff" based on the changes in the
+### working tree
 .PHONY: style
 style:
 	git clang-format --style file --diff --extensions c,h
 
+#### style: common variables
+STYLE_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES) $(EXCEPT_HDRS),\
+	$(FOUND_C_SOURCES) $(FOUND_H_SOURCES))
+
+#### style-all: generate clang-format output for everything. Copying
+#### the file to */in/* is so we can apply it with "git apply" (so one
+#### side won't have a .build/style-all/* prefix). If only "git apply"
+#### had a "-p" that applied only to one of "a/" or "b/" ...
+STYLE_SOURCES_IN = $(addprefix .build/style-all/in/,$(STYLE_SOURCES))
+$(STYLE_SOURCES_IN): .build/style-all/in/% : %
+	$(call mkdir_p_parent_template)
+	$(QUIET_LNCP)cp $< $@
+
+STYLE_SOURCES_OUT = $(addprefix .build/style-all/out/,$(STYLE_SOURCES))
+$(STYLE_SOURCES_OUT): .clang-format
+$(STYLE_SOURCES_OUT): .build/style-all/out/%: .build/style-all/in/%
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN)clang-format $< >$@
+.PHONY: style-all
+style-all: $(STYLE_SOURCES_GEN)
+
+#### style-all-diff: generate diffs of clang-format output
+#### v.s. checked-in files
+STYLE_SOURCES_DIFF = $(addprefix .build/style-all/diff/,$(STYLE_SOURCES))
+$(STYLE_SOURCES_DIFF): .build/style-all/diff/%: .build/style-all/out/%
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN)git \
+		-P \
+		diff --no-index \
+		$(<:.build/style-all/out/%=.build/style-all/in/%) $< >$@ || \
+	test -s $@
+
+.PHONY: style-all-diff
+style-all-diff: $(STYLE_SOURCES_DIFF)
+
+#### style-all-diff-ok: fail on files that have pending clang-format
+#### changes
+STYLE_SOURCES_DIFF_OK = $(addsuffix .ok,$(STYLE_SOURCES_DIFF))
+$(STYLE_SOURCES_DIFF_OK): %.ok: %
+	$(QUIET_GEN)! test -s $< && \
+	>$@
+.PHONY: style-all-diff-ok
+style-all-diff-ok: $(STYLE_SOURCES_DIFF_OK)
+
+.build/style-all.diff: $(STYLE_SOURCES_DIFF)
+	$(QUIET_GEN)cat $^ >$@
+
+#### style-all-diff-apply: apply the proposed clang-format changes. We
+#### need to have no local changes here, and use FORCE as the
+#### dependency graph of this rule is circular. I.e. we'll modify
+#### git.c, but eventually depend on it as well.
+STYLE_ALL_DIFF_APPLY_EXCLUDE =
+STYLE_ALL_DIFF_APPLY_EXCLUDE += ':!/Makefile'
+STYLE_ALL_DIFF_APPLY_EXCLUDE += ':!/.clang-format'
+style-all-diff-apply: FORCE
+style-all-diff-apply: .build/style-all.diff
+	git diff --quiet HEAD -- $(STYLE_ALL_DIFF_APPLY_EXCLUDE) && \
+	git diff --quiet --cached -- $(STYLE_ALL_DIFF_APPLY_EXCLUDE) && \
+	git apply -p4 $< && \
+	git -P diff --shortstat -- $(STYLE_ALL_DIFF_APPLY_EXCLUDE)
+
 .PHONY: check
 check: $(GENERATED_H)
 	@if sparse; \
-- 
2.37.0.913.g189dca38629

