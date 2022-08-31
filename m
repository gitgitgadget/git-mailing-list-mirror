Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF3AECAAD5
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiHaU6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiHaU6O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:58:14 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605B1D398C
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:12 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r204-20020a1c44d5000000b003a84b160addso248527wma.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=c4Glt1x6uv6Q9oNnGTYdqOAoPRMxxmYs1A14yd4Pntc=;
        b=V9PbZnOynAYMVXnVsRtzxBpXraPg+3yhfKY+ZkskEUBFumAl9CxhVo4iX7q4D5GTMW
         fZNQBhr3VTiI42fVsdofBZFAyr5rmsW+AfMTVkSq6WSlZHC3x8YFV6k7Q2pE20B1ZEMg
         cOtj5XdZA70Zy8v/JucN1TYpMc+Es52N142h0feI4PQ8P53JjM8CSot7Rc4CBdkTeM6s
         xECp/X02XiAv5A4oYvhIVy31KrjAfEUHo1Nxwyd9JP5wTSPqZywOg7ta57a5CmpWdCJr
         mZvLzYIjdfPu5nmaTe3+ZylrN9KNbFEaltz9i8/6PZ1Nfrw4t/csF0C03QjMpnC25OmB
         rFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=c4Glt1x6uv6Q9oNnGTYdqOAoPRMxxmYs1A14yd4Pntc=;
        b=IaikSFUdktVFv3k17p+PLT+GLMfW9AyuRE9c79p4ecffTsmIifqHBeiQKyMlnBZwgB
         m0wPRLINaqg8gSBG2Ju9akHsgQzmAk09AX0gA4ANZ3p4QjVeWWly7iTx8YxcAw1UP5uz
         A0Ct4OyRmCqelLLclA3gG8fzn701X2ibeEK+2AQn8UrhoW0Gbco5Z2NzouPcv/GzIxlM
         Hyz2f+y1EwihWhU435bjRjY/0wRHs6ijtzsZ3hTd+2UUNoqSx5efPRcwim0Pzb249IeT
         rNGo/zpZves4PcEQ4UldO4vL84QveX4HYXvpIQD40zRAa4AosylkrKt6hW51z4Mbl+4x
         Sbcw==
X-Gm-Message-State: ACgBeo3rGJApsgyLi351htNd+0o7WdHphwhCMciR42RHl/qmoSbfXYco
        UFF1P3qq0uF/E3eMh588c7TJl0rAjMpEBQ==
X-Google-Smtp-Source: AA6agR7fkM6gxQ+8M3dxjbJN21U4WflU6k5IU6UMWUUynXapa1D0QK2LbFaubyiizJNopqPZFiinlw==
X-Received: by 2002:a05:600c:502c:b0:3a8:41e9:cd32 with SMTP id n44-20020a05600c502c00b003a841e9cd32mr3017403wmr.177.1661979490230;
        Wed, 31 Aug 2022 13:58:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i16-20020adffc10000000b002253af82fa7sm15766955wrr.9.2022.08.31.13.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:58:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/9] cocci: make "coccicheck" rule incremental
Date:   Wed, 31 Aug 2022 22:57:54 +0200
Message-Id: <patch-v2-7.9-120607b5da6-20220831T205130Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Optimize the very slow "coccicheck" target to take advantage of
incremental rebuilding, and fix outstanding dependency problems with
the existing rule.

The rule is now faster both on the initial run as we can make better
use of GNU make's parallelism than the old ad-hoc combination of
make's parallelism combined with $(SPATCH_BATCH_SIZE) and/or the
"--jobs" argument to "spatch(1)".

It also makes us *much* faster when incrementally building, it's now
viable to "make coccicheck" as topic branches are merged down.

The rule didn't use FORCE (or its equivalents) before, so a:

	make coccicheck
	make coccicheck

Would report nothing to do on the second iteration. But all of our
patch output depended on all $(COCCI_SOURCES) files, therefore e.g.:

    make -W grep.c coccicheck

Would do a full re-run, i.e. a a change in a single file would force
us to do a full re-run.

The reason for this (not the initial rationale, but my analysis) is:

* Since we create a single "*.cocci.patch+" we don't know where to
  pick up where we left off, or how to incrementally merge e.g. a
  "grep.c" change with an existing *.cocci.patch.

* We've been carrying forward the dependency on the *.c files since
  63f0a758a06 (add coccicheck make target, 2016-09-15) the rule was
  initially added as a sort of poor man's dependency discovery.

  As we don't include other *.c files depending on other *.c files
  has always been broken, as could be trivially demonstrated
  e.g. with:

       make coccicheck
       make -W strbuf.h coccicheck

  However, depending on the corresponding *.c files has been doing
  something, namely that *if* an API change modified both *.c and *.h
  files we'd catch the change to the *.h we care about via the *.c
  being changed.

  For API changes that happened only via *.h files we'd do the wrong
  thing before this change, but e.g. for function additions (not
  "static inline" ones) catch the *.h change by proxy.

Now we'll instead:

 * Create a <RULE>/<FILE> pair in the .build directory, E.g. for
   swap.cocci and grep.c we'll create
   .build/contrib/coccinelle/swap.cocci.patch/grep.c.

   That file is the diff we'll apply for that <RULE>-<FILE>
   combination, if there's no changes to me made (the common case)
   it'll be an empty file.

 * Our generated *.patch
   file (e.g. contrib/coccinelle/swap.cocci.patch) is now a simple "cat
   $^" of all of all of the <RULE>/<FILE> files for a given <RULE>.

   In the case discussed above of "grep.c" being changed we'll do the
   full "cat" every time, so they resulting *.cocci.patch will always
   be correct and up-to-date, even if it's "incrementally updated".

   See 1cc0425a27c (Makefile: have "make pot" not "reset --hard",
   2022-05-26) for another recent rule that used that technique.

As before we'll:

 * End up generating a contrib/coccinelle/swap.cocci.patch, if we
   "fail" by creating a non-empty patch we'll still exit with a zero
   exit code.

   Arguably we should move to a more Makefile-native way of doing
   this, i.e. fail early, and if we want all of the "failed" changes
   we can use "make -k", but as the current
   "ci/run-static-analysis.sh" expects us to behave this way let's
   keep the existing behavior of exhaustively discovering all cocci
   changes, and only failing if spatch itself errors out.

Further implementation details & notes:

 * Before this change running "make coccicheck" would by default end
   up pegging just one CPU at the very end for a while, usually as
   we'd finish whichever *.cocci rule was the most expensive.

   This could be mitigated by combining "make -jN" with
   SPATCH_BATCH_SIZE, see 960154b9c17 (coccicheck: optionally batch
   spatch invocations, 2019-05-06). But doing so required careful
   juggling, as e.g. setting both to 4 would yield 16 workers.

   There will be cases where getting rid of "SPATCH_BATCH_SIZE" makes
   things worse, but a from-scratch "make coccicheck" with the default
   of SPATCH_BATCH_SIZE=1 (and tweaking it doesn't make a difference)
   is faster (~3m36s v.s. ~3m56s) with this approach, as we can feed
   the CPU more work in a less staggered way.

 * Getting rid of "SPATCH_BATCH_SIZE" particularly helps in cases
   where the default of 1 yields parallelism under "make coccicheck",
   but then running e.g.:

       make -W contrib/coccinelle/swap.cocci coccicheck

   I.e. before that would use only one CPU core, until the user
   remembered to adjust "SPATCH_BATCH_SIZE" differently than the
   setting that makes sense when doing a non-incremental run of "make
   coccicheck".

Outstanding issues & future work:

 * We could get rid of "--all-includes" in favor of manually
   specifying a list of includes to give to "spatch(1)".

   As noted upthread of [1] a naïve removal of "--all-includes" will
   result in broken *.cocci patches, but if we know the exhaustive
   list of includes via COMPUTE_HEADER_DEPENDENCIES we don't need to
   re-scan for them, we could grab the headers to include from the
   .depend.d/<file>.o.d and supply them with the "--include" option to
   spatch(1).q

1. https://lore.kernel.org/git/87ft18tcog.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile   | 83 +++++++++++++++++++++++++++++++++++++-----------------
 shared.mak |  3 +-
 2 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/Makefile b/Makefile
index 662f950e075..562820301c4 100644
--- a/Makefile
+++ b/Makefile
@@ -1298,10 +1298,6 @@ SANITIZE_ADDRESS =
 SPATCH_INCLUDE_FLAGS = --all-includes
 SPATCH_FLAGS =
 SPATCH_TEST_FLAGS =
-# Setting SPATCH_BATCH_SIZE higher will
-# usually result in less CPU usage at the cost of higher peak memory.
-# Setting it to 0 will feed all files in a single spatch invocation.
-SPATCH_BATCH_SIZE = 1
 
 # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
 TRACK_SPATCH_DEFINES =
@@ -1309,7 +1305,6 @@ TRACK_SPATCH_DEFINES += $(SPATCH)
 TRACK_SPATCH_DEFINES += $(SPATCH_INCLUDE_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_TEST_FLAGS)
-TRACK_SPATCH_DEFINES += $(SPATCH_BATCH_SIZE)
 GIT-SPATCH-DEFINES: FORCE
 	@FLAGS='$(TRACK_SPATCH_DEFINES)'; \
 	    if test x"$$FLAGS" != x"`cat GIT-SPATCH-DEFINES 2>/dev/null`" ; then \
@@ -3156,36 +3151,72 @@ check: $(GENERATED_H)
 		exit 1; \
 	fi
 
+# It's expensive to compute the many=many rules below, only eval them
+# on $(MAKECMDGOALS) that match these $(COCCI_RULES)
+COCCI_RULES =
+COCCI_RULES += cocci%
+COCCI_RULES += contrib/coccinelle/%
+COCCI_RULES += .build/contrib/coccinelle/%
+
 COCCI = $(wildcard contrib/coccinelle/*.cocci)
+COCCI_NAMES = $(COCCI:contrib/coccinelle/%.cocci=%)
 COCCI_PATCHES = $(addsuffix .patch,$(COCCI))
 COCCICHECK_PENDING = $(filter %.pending.cocci.patch,$(COCCI_PATCHES))
-COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_PATCHES))
 
+COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_PATCHES))
 COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
 
-$(COCCI_PATCHES): GIT-SPATCH-DEFINES
-$(COCCI_PATCHES): $(COCCI_SOURCES)
-$(COCCI_PATCHES): %.patch: %
-	$(QUIET_SPATCH) \
-	if test $(SPATCH_BATCH_SIZE) = 0; then \
-		limit=; \
-	else \
-		limit='-n $(SPATCH_BATCH_SIZE)'; \
-	fi; \
-	if ! echo $(COCCI_SOURCES) | xargs $$limit \
-		$(SPATCH) $(SPATCH_FLAGS) \
-		$(SPATCH_INCLUDE_FLAGS) \
-		--sp-file $< --patch . \
-		>$@+ 2>$@.log; \
+.build/contrib/coccinelle/FOUND_H_SOURCES: $(FOUND_H_SOURCES)
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN) >$@
+
+define cocci-rule
+
+## Rule for .build/$(1).patch/$(2); Params:
+# $(1) = e.g. "free.cocci"
+# $(2) = e.g. "grep.c"
+COCCI_$(1:contrib/coccinelle/%.cocci=%) += .build/$(1).patch/$(2)
+.build/$(1).patch/$(2): GIT-SPATCH-DEFINES
+.build/$(1).patch/$(2): .build/contrib/coccinelle/FOUND_H_SOURCES
+.build/$(1).patch/$(2): $(1)
+.build/$(1).patch/$(2): .build/$(1).patch/% : %
+	$$(call mkdir_p_parent_template)
+	$$(QUIET_SPATCH)if ! $$(SPATCH) $$(SPATCH_FLAGS) \
+		$$(SPATCH_INCLUDE_FLAGS) \
+		--sp-file $(1) --patch . $$< \
+		>$$@ 2>$$@.log; \
 	then \
-		cat $@.log; \
+		echo "ERROR when applying '$(1)' to '$$<'; '$$@.log' follows:"; \
+		cat $$@.log; \
 		exit 1; \
-	fi; \
-	mv $@+ $@; \
-	if test -s $@; \
+	fi
+endef
+
+define cocci-matrix-2
+
+$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(c),$(s)))
+endef
+define cocci-matrix-1
+$(foreach c,$(COCCI),$(call cocci-matrix-2,$(c)))
+endef
+
+ifneq ($(filter $(COCCI_RULES),$(MAKECMDGOALS)),)
+$(eval $(call cocci-matrix-1))
+endif
+
+define spatch-rule
+
+contrib/coccinelle/$(1).cocci.patch: $$(COCCI_$(1))
+	$(QUIET_SPATCH_M)cat $$^ >$$@ && \
+	if test -s $$@; \
 	then \
-		echo '    ' SPATCH result: $@; \
+		echo '    ' SPATCH result: $$@; \
 	fi
+endef
+
+ifneq ($(filter $(COCCI_RULES),$(MAKECMDGOALS)),)
+$(eval $(foreach n,$(COCCI_NAMES),$(call spatch-rule,$(n))))
+endif
 
 COCCI_TEST_RES_GEN = $(addprefix .build/,$(COCCI_TEST_RES))
 $(COCCI_TEST_RES_GEN): GIT-SPATCH-DEFINES
@@ -3476,7 +3507,7 @@ profile-clean:
 
 cocciclean:
 	$(RM) -r .build/contrib/coccinelle
-	$(RM) $(COCCI_PATCHES)*
+	$(RM) $(COCCI_PATCHES)
 
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build
diff --git a/shared.mak b/shared.mak
index 33f43edbf9a..d9fdd6b4484 100644
--- a/shared.mak
+++ b/shared.mak
@@ -69,8 +69,9 @@ ifndef V
 	QUIET_SP       = @echo '   ' SP $<;
 	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
 	QUIET_RC       = @echo '   ' RC $@;
-	QUIET_SPATCH   = @echo '   ' SPATCH $<;
+	QUIET_SPATCH   = @echo '   ' SPATCH $@;
 	QUIET_SPATCH_T = @echo '   ' SPATCH TEST $(@:.build/%=%);
+	QUIET_SPATCH_M = @echo '   ' SPATCH MERGE $$@;
 
 ## Used in "Documentation/Makefile"
 	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
-- 
2.37.3.1420.g76f8a3d556c

