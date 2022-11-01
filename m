Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D45C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiKAWhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiKAWgp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:36:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8231E3D4
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:36:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id f27so40783319eje.1
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3vZr7n5XXkRoy11pMjNo2PlAotPPHJIuwh/129yPus=;
        b=RUPZyFj8eSTmqrsSdfH5MilUCvXKIepoYjDEQjiNlxX/sSmqYjlbWRePSNeT8CD0ZH
         xMs1CKeArndDgffMfE2Y2WhhBaTtJ9c6Xzhx0bzOECjRyPophZZmGKtFdc30JFrc4dsE
         o5hIfmn+pLCp4qZp1JR8OiRKMZFdNeC8cyImjAb/9buMT++m3E3f/9c52/lChk1erDRB
         KMDQUoXRAfIVL11f3JTlYMsebTZm8GdKDx30MGNnl88IB9OnSgbourhIL6QurSsWsRYw
         avZmHvfqpTWLS1z4yCVjLJ02PMktRx2Gm4RJgpi4nHWQbPbb20cYAssSa8ksj7EceULS
         z6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3vZr7n5XXkRoy11pMjNo2PlAotPPHJIuwh/129yPus=;
        b=XsegMxVxXJyIVRRGGlXzlWCqRTM3td9mNhn2bZ8sVH9nvaXjB8+pp1GQ00OXC0ltYv
         oUe1tnuVQg9BsrRtLwr/Ej53pxQwixw5QF6Z2th3np6Sh3h6CAaK7Z56Yrr8hQ5G/hiW
         KtS+oYSOlPxDG4pvPCKxAMACLES3no0PzRlZjwM/FuLCC9QSRINgSL/BWmXIr+Y8T+5K
         PA+7QncWLrJYFl56vnzhorPqd7Jdav/c43hxGHt7nvL7w7TlchV5moXTifoJ6o2lBVn5
         8pkr4mW8ODSmcp2mwSX5X1aG+kiSf7rJcnMgTZV/329iYLzOXJSQGB8Fk5QllUxIpddz
         j26A==
X-Gm-Message-State: ACrzQf1gKRq5AuWNbhyk8McEvrNVGPf+i59z3az+dphCpzTQ4gCT8U0n
        6BFOyT5+xkIiljf+R0aP1ThkyElyDyVSFQ==
X-Google-Smtp-Source: AMsMyM6UHTwfaRE6H2dm/orTBIvI+LOdO8ASZ7GwIai291IuRY0fI/xVkjzEJxGC6o0M2bYG/iQHxA==
X-Received: by 2002:a17:907:2be9:b0:7a1:11a9:1334 with SMTP id gv41-20020a1709072be900b007a111a91334mr19916154ejc.131.1667342172340;
        Tue, 01 Nov 2022 15:36:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id rp7-20020a170906d96700b0078dd4c89781sm4693845ejb.35.2022.11.01.15.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:36:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 12/13] cocci: run against a generated ALL.cocci
Date:   Tue,  1 Nov 2022 23:35:54 +0100
Message-Id: <patch-v5-12.13-55d2f638359-20221101T222616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
References: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The preceding commits to make the "coccicheck" target incremental made
it slower in some cases. As an optimization let's not have the
many=many mapping of <*.cocci>=<*.[ch]>, but instead concat the
<*.cocci> into an ALL.cocci, and then run one-to-many
ALL.cocci=<*.[ch]>.

A "make coccicheck" is now around 2x as fast as it was on "master",
and around 1.5x as fast as the preceding change to make the run
incremental:

	$ git hyperfine -L rev origin/master,HEAD~,HEAD -p 'make clean' 'make coccicheck SPATCH=spatch COCCI_SOURCES="$(echo $(ls o*.c builtin/h*.c))"' -r 3
	Benchmark 1: make coccicheck SPATCH=spatch COCCI_SOURCES="$(echo $(ls o*.c builtin/h*.c))"' in 'origin/master
	  Time (mean ± σ):      4.258 s ±  0.015 s    [User: 27.432 s, System: 1.532 s]
	  Range (min … max):    4.241 s …  4.268 s    3 runs

	Benchmark 2: make coccicheck SPATCH=spatch COCCI_SOURCES="$(echo $(ls o*.c builtin/h*.c))"' in 'HEAD~
	  Time (mean ± σ):      5.365 s ±  0.079 s    [User: 36.899 s, System: 1.810 s]
	  Range (min … max):    5.281 s …  5.436 s    3 runs

	Benchmark 3: make coccicheck SPATCH=spatch COCCI_SOURCES="$(echo $(ls o*.c builtin/h*.c))"' in 'HEAD
	  Time (mean ± σ):      2.725 s ±  0.063 s    [User: 14.796 s, System: 0.233 s]
	  Range (min … max):    2.667 s …  2.792 s    3 runs

	Summary
	  'make coccicheck SPATCH=spatch COCCI_SOURCES="$(echo $(ls o*.c builtin/h*.c))"' in 'HEAD' ran
	    1.56 ± 0.04 times faster than 'make coccicheck SPATCH=spatch COCCI_SOURCES="$(echo $(ls o*.c builtin/h*.c))"' in 'origin/master'
	    1.97 ± 0.05 times faster than 'make coccicheck SPATCH=spatch COCCI_SOURCES="$(echo $(ls o*.c builtin/h*.c))"' in 'HEAD~'

This can be turned off with SPATCH_CONCAT_COCCI, but as the
beneficiaries of "SPATCH_CONCAT_COCCI=" would mainly be those
developing the *.cocci rules themselves, let's leave this optimization
on by default.

For more information see my "Optimizing *.cocci rules by concat'ing
them" (<220901.8635dbjfko.gmgdl@evledraar.gmail.com>) on the
cocci@inria.fr mailing list.

This potentially changes the results of our *.cocci rules, but as
noted in that discussion it should be safe for our use. We don't name
rules, or if we do their names don't conflict across our *.cocci
files.

To the extent that we'd have any inter-dependencies between rules this
doesn't make that worse, as we'd have them now if we ran "make
coccicheck", applied the results, and would then have (due to
hypothetical interdependencies) suggested changes on the subsequent
"make coccicheck".

Our "coccicheck-test" target makes use of the ALL.cocci when running
tests, e.g. when testing unused.{c,out} we test it against ALL.cocci,
not unused.cocci. We thus assert (to the extent that we have test
coverage) that this concatenation doesn't change the expected results
of running these rules.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                  | 38 ++++++++++++++++++++++++++++++++++++++
 contrib/coccinelle/README | 13 +++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/Makefile b/Makefile
index 44c906b65d5..36cefe3b1d6 100644
--- a/Makefile
+++ b/Makefile
@@ -1314,6 +1314,29 @@ SPATCH_TEST_FLAGS =
 # COMPUTE_HEADER_DEPENDENCIES=no this will be unset too.
 SPATCH_USE_O_DEPENDENCIES = YesPlease
 
+# Set SPATCH_CONCAT_COCCI to concatenate the contrib/cocci/*.cocci
+# files into a single contrib/cocci/ALL.cocci before running
+# "coccicheck".
+#
+# Pros:
+#
+# - Speeds up a one-shot run of "make coccicheck", as we won't have to
+#   parse *.[ch] files N times for the N *.cocci rules
+#
+# Cons:
+#
+# - Will make incremental development of *.cocci slower, as
+#   e.g. changing strbuf.cocci will re-run all *.cocci.
+#
+# - Makes error and performance analysis harder, as rules will be
+#   applied from a monolithic ALL.cocci, rather than
+#   e.g. strbuf.cocci. To work around this either undefine this, or
+#   generate a specific patch, e.g. this will always use strbuf.cocci,
+#   not ALL.cocci:
+#
+#	make contrib/coccinelle/strbuf.cocci.patch
+SPATCH_CONCAT_COCCI = YesPlease
+
 # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
 TRACK_SPATCH_DEFINES =
 TRACK_SPATCH_DEFINES += $(SPATCH)
@@ -3163,9 +3186,12 @@ check: $(GENERATED_H)
 		exit 1; \
 	fi
 
+COCCI_GEN_ALL = .build/contrib/coccinelle/ALL.cocci
 COCCI_GLOB = $(wildcard contrib/coccinelle/*.cocci)
 COCCI_RULES_TRACKED = $(COCCI_GLOB:%=.build/%)
+COCCI_RULES_TRACKED_NO_PENDING = $(filter-out %.pending.cocci,$(COCCI_RULES_TRACKED))
 COCCI_RULES =
+COCCI_RULES += $(COCCI_GEN_ALL)
 COCCI_RULES += $(COCCI_RULES_TRACKED)
 COCCI_NAMES =
 COCCI_NAMES += $(COCCI_RULES:.build/contrib/coccinelle/%.cocci=%)
@@ -3200,6 +3226,10 @@ $(COCCI_RULES_TRACKED): .build/% : %
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN) >$@
 
+$(COCCI_GEN_ALL): $(COCCI_RULES_TRACKED_NO_PENDING)
+	$(call mkdir_p_parent_template)
+	$(QUIET_SPATCH_CAT)cat $^ >$@
+
 ifeq ($(COMPUTE_HEADER_DEPENDENCIES),no)
 SPATCH_USE_O_DEPENDENCIES =
 endif
@@ -3256,7 +3286,11 @@ COCCI_TEST_RES_GEN = $(addprefix .build/,$(COCCI_TEST_RES))
 $(COCCI_TEST_RES_GEN): GIT-SPATCH-DEFINES
 $(COCCI_TEST_RES_GEN): .build/%.res : %.c
 $(COCCI_TEST_RES_GEN): .build/%.res : %.res
+ifdef SPATCH_CONCAT_COCCI
+$(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : $(COCCI_GEN_ALL)
+else
 $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinelle/%.cocci
+endif
 	$(call mkdir_p_parent_template)
 	$(QUIET_SPATCH_TEST)$(SPATCH) $(SPATCH_TEST_FLAGS) \
 		--very-quiet --no-show-diff \
@@ -3269,7 +3303,11 @@ $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinell
 coccicheck-test: $(COCCI_TEST_RES_GEN)
 
 coccicheck: coccicheck-test
+ifdef SPATCH_CONCAT_COCCI
+coccicheck: contrib/coccinelle/ALL.cocci.patch
+else
 coccicheck: $(COCCICHECK_PATCHES_INTREE)
+endif
 
 # See contrib/coccinelle/README
 coccicheck-pending: coccicheck-test
diff --git a/contrib/coccinelle/README b/contrib/coccinelle/README
index 09ea8298e19..09b72bfd4e7 100644
--- a/contrib/coccinelle/README
+++ b/contrib/coccinelle/README
@@ -57,3 +57,16 @@ Git-specific tips & things to know about how we run "spatch":
 
    To disable this behavior use the "SPATCH_USE_O_DEPENDENCIES=NoThanks"
    flag.
+
+ * To speed up our rules the "make coccicheck" target will by default
+   concatenate all of the *.cocci files here into an "ALL.cocci", and
+   apply it to each source file.
+
+   This makes the run faster, as we don't need to run each rule
+   against each source file. See the Makefile for further discussion,
+   this behavior can be disabled with "SPATCH_CONCAT_COCCI=".
+
+   But since they're concatenated any <id> in the <rulname> (e.g. "@
+   my_name", v.s. anonymous "@@") needs to be unique across all our
+   *.cocci files. You should only need to name rules if other rules
+   depend on them (currently only one rule is named).
-- 
2.38.0.1280.g8136eb6fab2

