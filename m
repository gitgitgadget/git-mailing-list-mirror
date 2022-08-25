Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D009AC28D13
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 14:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242207AbiHYOgm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 10:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241756AbiHYOgc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 10:36:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA0AAB41B
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 07:36:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u14so24875973wrq.9
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=iNx9qDpUivbgZzWrle8/Z/64ZS7TKvnxLiw3/bKo2Bs=;
        b=aTbxXea9hPWH1tfYoo3DoAWvAW0NgOwfbENSsl/6LPZCeNMQiMAIXgzXj51Z58nWwa
         CYy5bBCV/NcQ5C0hKzNYpSUv6HFBUTdAyGpoKaEoKT9r02pnA4tuE4875T1p8+aqx/n3
         OnaA5x2GAsqWr8aH/9DELB36D0SSYsOaVJQq4a9i5kG5syz2u9zI+pSYg8I4+m30nog8
         YK56DY8DCA07KGBIY/fC3jd99mxskccm7iGz3EKANe180XgBa78KhLN+bAppG+CQRbXu
         YWuB/Tz/fVzbDE72uWbvzN8msJ00tCUkwG5GrBDr6Hy0ptC/+7UeLtwV8/kTrqqMCIK4
         pFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=iNx9qDpUivbgZzWrle8/Z/64ZS7TKvnxLiw3/bKo2Bs=;
        b=B3siJxfeHXm4ZniJ0J2IwnqE3XlaMFPOIewPp/kBize2QZOnjU47LOf0WrSHxtDhgG
         MtDiV3g+SqCg2ZFU+KMP8Vk+dVIUsz6l37CnCGfo1Dat9D7enrC9OLRA/WyAeeDSM3pA
         vuxWU/GL4gNwLRtp/31aFFaa2kWtfBRFEMurucg+/cXjYt5nNhpS9NSfMX5Nty8ji4cT
         bTZicB1oQAKXeEhnwK+vLijfXsMgHMc689uhSm/uy8jrd7x7oCDkh4Fvbjpq+dvc2lXD
         B8zyhyjnCXitmG7C/cyfuLm7kVJaT5wMJ9PKHidQR2/yZ6eKCdf2XR/uwiixqqfoMxdv
         GFcg==
X-Gm-Message-State: ACgBeo1FeJZMZH6ObANV5wRzOk2pMOdzlKAR9U1qErZZyINvuZbqLr0v
        8cjXtDNyI12g2uNRF+bhdeGyVv6xAjHeJg==
X-Google-Smtp-Source: AA6agR6LFqgVQAltolOX+ZBfx/IRaN+/e7hI0vDByOuHE7QyDqNVIsmKmgwF6DTu7RnZ0/+LCp4bXw==
X-Received: by 2002:adf:fb8d:0:b0:225:4d57:17a6 with SMTP id a13-20020adffb8d000000b002254d5717a6mr2517527wrr.251.1661438184082;
        Thu, 25 Aug 2022 07:36:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m27-20020a056000181b00b0022549ac786asm14418027wrh.47.2022.08.25.07.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 07:36:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] cocci: make "coccicheck" rule incremental
Date:   Thu, 25 Aug 2022 16:36:15 +0200
Message-Id: <patch-3.5-6fa83695f1f-20220825T141212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Optimize the very slow "coccicheck" target to take advantage of
incremental rebuilding, and fix outstanding bugs and dependency
problems with the existing rule.

The rule is now faster both on the initial run as we can make better
use of GNU make's parallelism than the old ad-hoc combination of
make's parallelism combined with $(SPATCH_BATCH_SIZE) and "xargs -n".

It also makes us *much* faster when incrementally building, it's now
viable to "make coccicheck" as topic branches are merged down.

The rule didn't use FORCE (or its equivalents) before, so a:

	make coccicheck
	make coccicheck

Would report nothing to do on the second iteration. But all of our
patch output depended on all $(COCCI_SOURCES) files, therefore e.g.:

    make -W grep.c coccicheck

Would be the same as doing a full re-run. A change in a single file
would force us to do a full re-run.

The reason for this (not the initial rationale, but my analysis) is:

* Since we create a single "*.cocci.patch+" we don't know where to
  pick up where we left off. Note that (per [1]) we've had a race
  condition since 960154b9c17 (coccicheck: optionally batch spatch
  invocations, 2019-05-06) which might result in us producing corrupt
  patches to to the concurrent appending to "$@+" in the pre-image.

  That bug is now fixed.

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

   See 1cc0425a27c (Makefile: have "make pot" not "reset --hard",
   2022-05-26) for another recent rule that used that technique.

 * We depend on a .build/<RULE>.ok file, which in turn depends on our
   <RULE>. This emulates the previous "test -s" test, but in a more
   Makefile-native way (e.g. -k works as expected).

As noted above this change fixes existing dependency issues,
e.g. changing strbuf.h will now trigger a re-build. Our default is to
depend on $(FOUND_H_SOURCES). This makes incremental re-building
possible, but it's still fairly slow, as modifying one header will
cause a full re-build of everything.

Which is why we'll not depend on $(FOUND_H_SOURCES) but the *.o file
corresponding to the *.c file, if it exists already. This means that
we can do:

    make all
    make coccicheck
    make -W column.h coccicheck

By depending on the *.o we piggy-back on
COMPUTE_HEADER_DEPENDENCIES. See c234e8a0ecf (Makefile: make the
"sparse" target non-.PHONY, 2021-09-23) for prior art of doing that
for the *.sp files. E.g.:

    make contrib/coccinelle/free.cocci.patch
    make -W column.h contrib/coccinelle/free.cocci.patch

Will take around 15 seconds for the second command on my 8 core box if
I didn't run "make" beforehand to create the *.o files. But around 2
seconds if I did and we have those "*.o" files.

Notes about the approach of piggy-backing on *.o for dependencies:

* It *is* a trade-off since we'll pay the extra cost of running the C
  compiler, but we're probably doing that anyway. The compiler is much
  faster than "spatch", so even though we need to re-compile the *.o to
  create the dependency info for the *.c for "spatch" it's
  faster (especially if using "ccache").

 * If that *.o file doesn't exist we'll depend on an intermediate file
   of ours which in turn depends on $(FOUND_H_SOURCES).

   This covers both an initial build, or where "coccicheck" is run
   without running "all" beforehand, and because we run "coccicheck"
   on e.g. files in compat/* that we don't know how to build unless
   the requisite flag was provided to the Makefile.

   Most of the runtime of "incremental" runs is now spent on various
   compat/* files, i.e. we conditionally add files to COMPAT_OBJS, and
   therefore conflate whether we *can* compile an object and generate
   dependency information for it with whether we'd like to link it
   into our binary.

   Before this change the distinction didn't matter, but now one way
   to make this even faster on incremental builds would be to peel
   those concerns apart so that we can see that e.g. compat/mmap.c
   doesn't depend on column.h.

Further implementation details & notes:

 * We can take better advantage of parallelism, while making sure that
   we don't racily append to the contrib/coccinelle/swap.cocci.patch
   file from multiple workers.

   Before this change running "make coccicheck" would by default end
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

 * The change here to
   "contrib/coccinelle/the_repository.pending.cocci" is because we've
   been spewing out this warning into our $@.log since that rule was
   added:

       warning: rule starting on line 21: metavariable F not used in the - or context code

   It's being fixed here because we'll now notice on "make
   coccicheck-pending", since we're not redirecting all of STDERR to a
   log file, instead we use the "--very-quiet" option.

Outstanding issues & future work:

 * We could get rid of "--all-includes" in favor of manually
   specifying a list of includes to give to "spatch(1)".

   As noted upthread of [2] a naïve removal of "--all-includes" will
   result in broken *.cocci patches, but if we know the exhaustive
   list of includes via COMPUTE_HEADER_DEPENDENCIES we don't need to
   re-scan for them, we could grab the headers to include from the
   .depend.d/<file>.o.d and supply them with the "--include" option to
   spatch(1).q

 * We can generalize COMPUTE_HEADER_DEPENDENCIES to spew out the list
   of *.h dependencies without making a *.o object, which is slightly
   faster, and would also benefit the "make sparse" target. We'd still
   need to run the compiler, it would just have less work to do.

1. https://lore.kernel.org/git/877dlwotjc.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/87ft18tcog.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                                      | 92 +++++++++++++------
 .../coccinelle/the_repository.pending.cocci   |  1 -
 shared.mak                                    |  4 +-
 3 files changed, 66 insertions(+), 31 deletions(-)

diff --git a/Makefile b/Makefile
index 749eb9b25e3..a374204aaca 100644
--- a/Makefile
+++ b/Makefile
@@ -1290,17 +1290,12 @@ SP_EXTRA_FLAGS = -Wno-universal-initializer
 SANITIZE_LEAK =
 SANITIZE_ADDRESS =
 
-# For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
-# usually result in less CPU usage at the cost of higher peak memory.
-# Setting it to 0 will feed all files in a single spatch invocation.
 SPATCH_FLAGS = --all-includes
-SPATCH_BATCH_SIZE = 1
 
 # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
 TRACK_SPATCH_DEFINES =
 TRACK_SPATCH_DEFINES += $(SPATCH)
 TRACK_SPATCH_DEFINES += $(SPATCH_FLAGS)
-TRACK_SPATCH_DEFINES += $(SPATCH_BATCH_SIZE)
 GIT-SPATCH-DEFINES: FORCE
 	@FLAGS='$(TRACK_SPATCH_DEFINES)'; \
 	    if test x"$$FLAGS" != x"`cat GIT-SPATCH-DEFINES 2>/dev/null`" ; then \
@@ -3147,35 +3142,74 @@ check: $(GENERATED_H)
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
+COCCI_PATCHES_OK = $(COCCI_PATCHES:%=.build/%.ok)
 COCCICHECK_PENDING = $(filter %.pending.cocci.patch,$(COCCI_PATCHES))
-COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_PATCHES))
 
+COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_PATCHES))
+COCCICHECK_OK = $(COCCICHECK:%=.build/%.ok)
+COCCICHECK_PENDING_OK = $(COCCICHECK_PENDING:%=.build/%.ok)
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
-		--sp-file $< --patch . \
-		>$@+ 2>$@.log; \
+.build/contrib/coccinelle/FOUND_H_SOURCES: $(FOUND_H_SOURCES)
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN) >$@
+
+define cocci-rule
+
+## Rule for .build/$(1).patch/$(2); Params:
+# 1 = $(1)
+# 2 = $(2)
+COCCI_$(1:contrib/coccinelle/%.cocci=%) += .build/$(1).patch/$(2)
+.build/$(1).patch/$(2): GIT-SPATCH-DEFINES
+.build/$(1).patch/$(2): $(if $(wildcard $(3)),$(3),.build/contrib/coccinelle/FOUND_H_SOURCES)
+.build/$(1).patch/$(2): $(1)
+.build/$(1).patch/$(2): .build/$(1).patch/% : %
+	$$(call mkdir_p_parent_template)
+	$$(QUIET_SPATCH)$$(SPATCH) $$(SPATCH_FLAGS) \
+		--very-quiet \
+		--sp-file $(1) --patch . \
+		$$(SPATCH_PATCH_FLAGS) $$< >$$@
+endef
+
+define cocci-matrix-2
+
+$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(c),$(s),$(s:%.c=%.o)))
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
+	$(QUIET_SPATCH_M)cat $$^ >$$@
+endef
+
+$(COCCI_PATCHES_OK): .build/%.ok : %
+	$(QUIET_SPATCH_R)if test -s $<; \
 	then \
-		cat $@.log; \
+		cat $< | sed -e 's/^/	/'; \
 		exit 1; \
-	fi; \
-	mv $@+ $@; \
-	if test -s $@; \
-	then \
-		echo '    ' SPATCH result: $@; \
-	fi
+	fi && \
+	>$@
+
+ifneq ($(filter $(COCCI_RULES),$(MAKECMDGOALS)),)
+$(eval $(foreach n,$(COCCI_NAMES),$(call spatch-rule,$(n))))
+endif
 
 COCCI_TEST_RES_GEN = $(addprefix .build/,$(COCCI_TEST_RES))
 $(COCCI_TEST_RES_GEN): GIT-SPATCH-DEFINES
@@ -3194,11 +3228,11 @@ $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinell
 coccicheck-test: $(COCCI_TEST_RES_GEN)
 
 coccicheck: coccicheck-test
-coccicheck: $(COCCICHECK)
+coccicheck: $(COCCICHECK_OK)
 
 # See contrib/coccinelle/README
 coccicheck-pending: coccicheck-test
-coccicheck-pending: $(COCCICHECK_PENDING)
+coccicheck-pending: $(COCCICHECK_PENDING_OK)
 
 .PHONY: coccicheck coccicheck-pending
 
@@ -3466,7 +3500,7 @@ profile-clean:
 
 cocciclean:
 	$(RM) -r .build/contrib/coccinelle
-	$(RM) $(COCCI_PATCHES)*
+	$(RM) $(COCCI_PATCHES)
 
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 072ea0d9228..747d382ff5f 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -20,7 +20,6 @@ expression E;
 
 @@
 expression E;
-expression F;
 @@
 - has_object_file_with_flags(
 + repo_has_object_file_with_flags(the_repository,
diff --git a/shared.mak b/shared.mak
index 33f43edbf9a..c0e88308069 100644
--- a/shared.mak
+++ b/shared.mak
@@ -69,8 +69,10 @@ ifndef V
 	QUIET_SP       = @echo '   ' SP $<;
 	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
 	QUIET_RC       = @echo '   ' RC $@;
-	QUIET_SPATCH   = @echo '   ' SPATCH $<;
+	QUIET_SPATCH   = @echo '   ' SPATCH $@;
 	QUIET_SPATCH_T = @echo '   ' SPATCH TEST $(@:.build/%=%);
+	QUIET_SPATCH_M = @echo '   ' SPATCH MERGE $$@;
+	QUIET_SPATCH_R = @echo '   ' SPATCH RESULT $<;
 
 ## Used in "Documentation/Makefile"
 	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
-- 
2.37.2.1279.g64dec4e13cf

