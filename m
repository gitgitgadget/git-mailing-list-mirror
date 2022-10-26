Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839D3C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiJZOVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiJZOV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:21:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EF1112AB2
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:21:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a5so28634092edb.11
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFRaYg9GIuJTTecMMvOt4fqt5FZy4G9Im1NMbkkaxe4=;
        b=l002m99TrCs5wX4bd7M+oA8uwbnXkLu+JDoRWplT3pYon2Bk9klXqhIHbuHjpAhAGd
         o5FFlTuRiWMab66c3h/o6VvnfsFjul/d5gR/ivpkLTp0x7WmcwJ8sXZgJWWModM18lGh
         KgqIFmRkifrcCIQVvmoNbRjHMsx5xhIju8g80mt3c74Uo4EEjUYphf4Xm50fGEUL2i4P
         kRmj2KPa2XZkzOgZMjy0Q3hFcaoNKc1yW0pkRspXCXrJvIDVeIIa3/1lXEld1H3xyxkx
         foptlYPz6mZt4zptED5XpHRxxgc/tphWQYGL51fmUagjcpV2D0x5KHBDw28Fn0YdS/6Y
         PFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFRaYg9GIuJTTecMMvOt4fqt5FZy4G9Im1NMbkkaxe4=;
        b=Hm6C9/zafObcidRnHytSC5qqkR1nrdTx5bUnfdfSGYtC+uo3vW/JEhXbU2YopkthW6
         u5BbASMB+Ao0txj+JDigoRMWq2v2nw4URlTqAKEOlfsVwaC7fupPjKkguLbRbEHWfNrW
         YHCUWNIaWtQhIwWnaTWvsas4xnrgRsb2ge4NxnZ8z8zvdWdMCSsrvepBme0Sr+MMbU21
         SUzWub8Z2LYhf7ulOwQEJIFTq2N2aam5vrQz0LknTQ0YOQP2B4ScEDP9c3e2g2emrpS0
         8OabbokoPIJk79DoDmSeGoBKtS63LZahJsVXblPLmM6j/55umgzgNSmbN9g6yomGANSw
         HM2A==
X-Gm-Message-State: ACrzQf0yhb8k7U7JkBKNN1UXCK/z9Q1+9Zbxv8jv5VuinPkFwZ3NV4AG
        gkh62imf0TRr6ZAPDB8gRg0ajm/hdqVCCA==
X-Google-Smtp-Source: AMsMyM45TK+VJCBsW/5dfmMTuxQTv+yATTojjpCKmlwNFxMq8QPrZVCIl6qmHB1Nk7k5MGZs3EUGaw==
X-Received: by 2002:a05:6402:2550:b0:462:38d7:a6e1 with SMTP id l16-20020a056402255000b0046238d7a6e1mr6200875edb.337.1666794066970;
        Wed, 26 Oct 2022 07:21:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11-20020a50ea8b000000b004619f024864sm3605565edo.81.2022.10.26.07.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:21:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 11/12] cocci: run against a generated ALL.cocci
Date:   Wed, 26 Oct 2022 16:20:38 +0200
Message-Id: <patch-v4-11.12-a848d09527f-20221026T141005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
References: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
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
 Makefile                      | 40 ++++++++++++++++++++++++++++++++---
 contrib/coccinelle/.gitignore |  1 +
 contrib/coccinelle/README     | 13 ++++++++++++
 shared.mak                    |  1 +
 4 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 531077031d8..0d65c09ad5a 100644
--- a/Makefile
+++ b/Makefile
@@ -1311,6 +1311,25 @@ SPATCH_TEST_FLAGS =
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
+#   e.g. strbuf.cocci.
+SPATCH_CONCAT_COCCI = YesPlease
+
 # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
 TRACK_SPATCH_DEFINES =
 TRACK_SPATCH_DEFINES += $(SPATCH)
@@ -3159,9 +3178,10 @@ check: $(GENERATED_H)
 		exit 1; \
 	fi
 
+COCCI_GEN_ALL = contrib/coccinelle/ALL.cocci
 COCCI_GLOB = $(wildcard contrib/coccinelle/*.cocci)
-COCCI_RULES = $(COCCI_GLOB)
-COCCI_NAMES = $(COCCI_RULES:contrib/coccinelle/%.cocci=%)
+COCCI_NAMES = $(sort ALL $(COCCI_GLOB:contrib/coccinelle/%.cocci=%))
+COCCI_RULES = $(filter-out $(COCCI_GEN_ALL),$(COCCI_GLOB))
 
 COCCICHECK_PENDING = $(filter %.pending.cocci,$(COCCI_RULES))
 COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
@@ -3175,6 +3195,7 @@ COCCI_RULES_GLOB += cocci%
 COCCI_RULES_GLOB += .build/contrib/coccinelle/%
 COCCI_RULES_GLOB += $(COCCICHECK_PATCHES)
 COCCI_RULES_GLOB += $(COCCICHEC_PATCHES_PENDING)
+COCCI_RULES_GLOB += $(COCCI_GEN_ALL)
 COCCI_GOALS = $(filter $(COCCI_RULES_GLOB),$(MAKECMDGOALS))
 
 COCCICHECK_PATCHES = $(COCCICHECK:%=%.patch)
@@ -3186,6 +3207,10 @@ COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN) >$@
 
+$(COCCI_GEN_ALL): $(COCCICHECK)
+	$(call mkdir_p_parent_template)
+	$(QUIET_SPATCH_CAT)cat $^ >$@
+
 ifeq ($(COMPUTE_HEADER_DEPENDENCIES),no)
 SPATCH_USE_O_DEPENDENCIES =
 endif
@@ -3218,7 +3243,7 @@ $(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(c),$(s),$(s:%.c=%.o)))
 endef
 
 ifdef COCCI_GOALS
-$(eval $(foreach c,$(COCCI_RULES),$(call cocci-matrix,$(c))))
+$(eval $(foreach c,$(COCCI_RULES) $(COCCI_GEN_ALL),$(call cocci-matrix,$(c))))
 endif
 
 define spatch-rule
@@ -3239,7 +3264,11 @@ COCCI_TEST_RES_GEN = $(addprefix .build/,$(COCCI_TEST_RES))
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
@@ -3252,7 +3281,11 @@ $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinell
 coccicheck-test: $(COCCI_TEST_RES_GEN)
 
 coccicheck: coccicheck-test
+ifdef SPATCH_CONCAT_COCCI
+coccicheck: contrib/coccinelle/ALL.cocci.patch
+else
 coccicheck: $(COCCICHECK_PATCHES)
+endif
 
 # See contrib/coccinelle/README
 coccicheck-pending: coccicheck-test
@@ -3527,6 +3560,7 @@ cocciclean:
 	$(RM) -r .build/contrib/coccinelle
 	$(RM) $(COCCICHECK_PATCHES)
 	$(RM) $(COCCICHECK_PATCHES_PENDING)
+	$(RM) $(COCCI_GEN_ALL)
 
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build
diff --git a/contrib/coccinelle/.gitignore b/contrib/coccinelle/.gitignore
index d3f29646dc3..2709d98eb91 100644
--- a/contrib/coccinelle/.gitignore
+++ b/contrib/coccinelle/.gitignore
@@ -1 +1,2 @@
+/ALL.cocci
 *.patch*
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
diff --git a/shared.mak b/shared.mak
index 5ccd6889fcb..66dcf6768db 100644
--- a/shared.mak
+++ b/shared.mak
@@ -73,6 +73,7 @@ ifndef V
 ## Used in "Makefile": SPATCH
 	QUIET_SPATCH			= @echo '   ' SPATCH $@;
 	QUIET_SPATCH_TEST		= @echo '   ' SPATCH TEST $(@:.build/%=%);
+	QUIET_SPATCH_CAT		= @echo '   ' SPATCH CAT $$^ \>$@;
 
 ## Used in "Makefile": SPATCH_*TMPL (quoted for use in "define"'s)
 	QUIET_SPATCH_CAT_TMPL		= @echo '   ' SPATCH CAT $$$$^ \>$$@;
-- 
2.38.0.1251.g3eefdfb5e7a

