Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB245ECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiHaU6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiHaU6J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:58:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAC1D398C
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id ay12so7976748wmb.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=z9NP175oZsXDmfdEoMlQCp63HKd+IrLel0Q4G1IWekg=;
        b=c+m1RS394pLo1HqEiqmwH3kA+6c3EEt9dN4t/rREyCW1fjnqnoz63fI/Pbay3TLfCJ
         T+zG9WFHUkWX3F7X8TVZ/cWcTtfDcueK332bqsSWNxqX2G15jN9j6KD5mR5KUSXucKrw
         nj0iXpDjrt/21gg0Ze7pb5KPU2G8dMp0ZeDZnxw71Bjmpb/RonQWS28trW28WqbKM4hR
         psXg26efaZEa1uE/qZO7kyk2Xo3Mlmq4Z0j8a/wvVXFM2sde80qSD8r3hxGAc5KPKGBq
         P8aor0eP0JdaHTu78DIMWG3Ce8kcUrJLzqPtJgmQsyDmZD0nr7QtaYN50COixC5+pa0B
         5iKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=z9NP175oZsXDmfdEoMlQCp63HKd+IrLel0Q4G1IWekg=;
        b=Rno6qlWqfXui3sta7akNoQth96T31xOkpTaye8kgTD+pT+owMMs/cRa6bEwaGYVF8V
         cYMolX4iPIEeF2MPmDgW11EtOFfCgUK2T1VL9KJzE9wDFn1wLai3k/SSnGTABgA3hOdE
         KZu1KHQ0xJVm8E/+9mkbk9hDJnokttmznaSJEheAT66aS9me4ixeBQz1seKKFNWfKuzy
         tug7GfJH9Pp0WhBWh3C8jAQZLELsuwBti5oF4GnL61UxubYgJWlyjzzFu1+welhYyAMM
         W49HpIzazDvaB7k8b3B8B+jr80uAVGX1EJQY7L+x5GYMxaejPE3HvfohLJ/5RLD01Sxr
         TquQ==
X-Gm-Message-State: ACgBeo3NMcVPCw6TzzSlwnbYc8iNDpt5pmJIcDgkcgX4USTwgn8hgUqc
        4GGN66rjyFfBG4RoWYN2Q/Y0zR+XUOpICw==
X-Google-Smtp-Source: AA6agR6s6PkJSzeUwURfqaVK/zLp10Yeqc4srZNVMJc/np/nhLX+vzjidyUPevVFfip6B8+y2jrg8A==
X-Received: by 2002:a05:600c:a4d:b0:3a6:6dd3:1857 with SMTP id c13-20020a05600c0a4d00b003a66dd31857mr3152783wmq.110.1661979482379;
        Wed, 31 Aug 2022 13:58:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i16-20020adffc10000000b002253af82fa7sm15766955wrr.9.2022.08.31.13.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:58:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/9] cocci: make "incremental" possible + a ccache-like tool
Date:   Wed, 31 Aug 2022 22:57:47 +0200
Message-Id: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of the series to have "make coccicheck" run
incrementally. For the v1 see:
https://lore.kernel.org/git/cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com/

Changes since v1 (based on SZEDER's feedback, thanks!):

 * Corrected small bits of commit message, removed mention of a "bug"
   (which was really something in an earlier series of mine...)

 * Split up the previous "incremental" commit. Now 1/9 is an unrelated
   fix that was in it (but which was spotted by it).

 * Added some preceding patches to make tweaking spatch flags easier.

 * The part where we optionally piggy-back on the dependencies of *.o
   files is now in 8/9, the "pure" incremental coccicheck in 7/9 will
   never need a compiler.

 * The "make coccicheck" now acts as before, i.e. no "make -k" needed,
   it runs to completion. I think having it "make -k" friendly would
   optionally make sense, but that can be left for some other time.

 * The previous change dropped the cocci *.log, we now log the stderr
   we had as before.

 * The spatchcache contrib command in 9/9 has updated docs & behavior.

 * The spatchcache now requires SPATCH_FLAGS=--very-quiet, which was
   the new default in this series before. I.e. we never cache things
   that have any stderr output.

Ævar Arnfjörð Bjarmason (9):
  cocci rules: remove unused "F" metavariable from pending rule
  Makefile: add ability to TAB-complete cocci *.patch rules
  Makefile: have "coccicheck" re-run if flags change
  Makefile: split off SPATCH_BATCH_SIZE comment from "cocci" heading
  cocci: split off include-less "tests" from SPATCH_FLAGS
  cocci: split off "--all-includes" from SPATCH_FLAGS
  cocci: make "coccicheck" rule incremental
  cocci: optimistically use COMPUTE_HEADER_DEPENDENCIES
  spatchcache: add a ccache-alike for "spatch"

 .gitignore                                    |   1 +
 Makefile                                      | 113 +++++++--
 contrib/coccinelle/spatchcache                | 234 ++++++++++++++++++
 .../coccinelle/the_repository.pending.cocci   |   1 -
 shared.mak                                    |   3 +-
 5 files changed, 325 insertions(+), 27 deletions(-)
 create mode 100755 contrib/coccinelle/spatchcache

Range-diff against v1:
 -:  ----------- >  1:  72b6a8e4e0b cocci rules: remove unused "F" metavariable from pending rule
 1:  8604ac9bfbc =  2:  0998948b881 Makefile: add ability to TAB-complete cocci *.patch rules
 2:  db3b3427668 !  3:  63cf9f58d99 Makefile: have "coccicheck" re-run if flags change
    @@ Commit message
         since 63f0a758a06 (add coccicheck make target, 2016-09-15), unlike
         e.g. "make grep.o" we wouldn't re-run it when $(SPATCH) or
         $(SPATCH_FLAGS) changed. To test new flags we needed to first do a
    -    "make clean".
    +    "make cocciclean".
     
         This now uses the same (copy/pasted) pattern as other "DEFINES"
         rules. As a result we'll re-run properly. This can be demonstrated
 -:  ----------- >  4:  54d6bae3984 Makefile: split off SPATCH_BATCH_SIZE comment from "cocci" heading
 -:  ----------- >  5:  4f165bf6128 cocci: split off include-less "tests" from SPATCH_FLAGS
 -:  ----------- >  6:  c74d09f4825 cocci: split off "--all-includes" from SPATCH_FLAGS
 3:  6fa83695f1f !  7:  120607b5da6 cocci: make "coccicheck" rule incremental
    @@ Commit message
         cocci: make "coccicheck" rule incremental
     
         Optimize the very slow "coccicheck" target to take advantage of
    -    incremental rebuilding, and fix outstanding bugs and dependency
    -    problems with the existing rule.
    +    incremental rebuilding, and fix outstanding dependency problems with
    +    the existing rule.
     
         The rule is now faster both on the initial run as we can make better
         use of GNU make's parallelism than the old ad-hoc combination of
    -    make's parallelism combined with $(SPATCH_BATCH_SIZE) and "xargs -n".
    +    make's parallelism combined with $(SPATCH_BATCH_SIZE) and/or the
    +    "--jobs" argument to "spatch(1)".
     
         It also makes us *much* faster when incrementally building, it's now
         viable to "make coccicheck" as topic branches are merged down.
    @@ Commit message
     
             make -W grep.c coccicheck
     
    -    Would be the same as doing a full re-run. A change in a single file
    -    would force us to do a full re-run.
    +    Would do a full re-run, i.e. a a change in a single file would force
    +    us to do a full re-run.
     
         The reason for this (not the initial rationale, but my analysis) is:
     
         * Since we create a single "*.cocci.patch+" we don't know where to
    -      pick up where we left off. Note that (per [1]) we've had a race
    -      condition since 960154b9c17 (coccicheck: optionally batch spatch
    -      invocations, 2019-05-06) which might result in us producing corrupt
    -      patches to to the concurrent appending to "$@+" in the pre-image.
    -
    -      That bug is now fixed.
    +      pick up where we left off, or how to incrementally merge e.g. a
    +      "grep.c" change with an existing *.cocci.patch.
     
         * We've been carrying forward the dependency on the *.c files since
           63f0a758a06 (add coccicheck make target, 2016-09-15) the rule was
    @@ Commit message
            file (e.g. contrib/coccinelle/swap.cocci.patch) is now a simple "cat
            $^" of all of all of the <RULE>/<FILE> files for a given <RULE>.
     
    +       In the case discussed above of "grep.c" being changed we'll do the
    +       full "cat" every time, so they resulting *.cocci.patch will always
    +       be correct and up-to-date, even if it's "incrementally updated".
    +
            See 1cc0425a27c (Makefile: have "make pot" not "reset --hard",
            2022-05-26) for another recent rule that used that technique.
     
    -     * We depend on a .build/<RULE>.ok file, which in turn depends on our
    -       <RULE>. This emulates the previous "test -s" test, but in a more
    -       Makefile-native way (e.g. -k works as expected).
    -
    -    As noted above this change fixes existing dependency issues,
    -    e.g. changing strbuf.h will now trigger a re-build. Our default is to
    -    depend on $(FOUND_H_SOURCES). This makes incremental re-building
    -    possible, but it's still fairly slow, as modifying one header will
    -    cause a full re-build of everything.
    -
    -    Which is why we'll not depend on $(FOUND_H_SOURCES) but the *.o file
    -    corresponding to the *.c file, if it exists already. This means that
    -    we can do:
    -
    -        make all
    -        make coccicheck
    -        make -W column.h coccicheck
    -
    -    By depending on the *.o we piggy-back on
    -    COMPUTE_HEADER_DEPENDENCIES. See c234e8a0ecf (Makefile: make the
    -    "sparse" target non-.PHONY, 2021-09-23) for prior art of doing that
    -    for the *.sp files. E.g.:
    -
    -        make contrib/coccinelle/free.cocci.patch
    -        make -W column.h contrib/coccinelle/free.cocci.patch
    -
    -    Will take around 15 seconds for the second command on my 8 core box if
    -    I didn't run "make" beforehand to create the *.o files. But around 2
    -    seconds if I did and we have those "*.o" files.
    -
    -    Notes about the approach of piggy-backing on *.o for dependencies:
    -
    -    * It *is* a trade-off since we'll pay the extra cost of running the C
    -      compiler, but we're probably doing that anyway. The compiler is much
    -      faster than "spatch", so even though we need to re-compile the *.o to
    -      create the dependency info for the *.c for "spatch" it's
    -      faster (especially if using "ccache").
    +    As before we'll:
     
    -     * If that *.o file doesn't exist we'll depend on an intermediate file
    -       of ours which in turn depends on $(FOUND_H_SOURCES).
    +     * End up generating a contrib/coccinelle/swap.cocci.patch, if we
    +       "fail" by creating a non-empty patch we'll still exit with a zero
    +       exit code.
     
    -       This covers both an initial build, or where "coccicheck" is run
    -       without running "all" beforehand, and because we run "coccicheck"
    -       on e.g. files in compat/* that we don't know how to build unless
    -       the requisite flag was provided to the Makefile.
    -
    -       Most of the runtime of "incremental" runs is now spent on various
    -       compat/* files, i.e. we conditionally add files to COMPAT_OBJS, and
    -       therefore conflate whether we *can* compile an object and generate
    -       dependency information for it with whether we'd like to link it
    -       into our binary.
    -
    -       Before this change the distinction didn't matter, but now one way
    -       to make this even faster on incremental builds would be to peel
    -       those concerns apart so that we can see that e.g. compat/mmap.c
    -       doesn't depend on column.h.
    +       Arguably we should move to a more Makefile-native way of doing
    +       this, i.e. fail early, and if we want all of the "failed" changes
    +       we can use "make -k", but as the current
    +       "ci/run-static-analysis.sh" expects us to behave this way let's
    +       keep the existing behavior of exhaustively discovering all cocci
    +       changes, and only failing if spatch itself errors out.
     
         Further implementation details & notes:
     
    -     * We can take better advantage of parallelism, while making sure that
    -       we don't racily append to the contrib/coccinelle/swap.cocci.patch
    -       file from multiple workers.
    -
    -       Before this change running "make coccicheck" would by default end
    +     * Before this change running "make coccicheck" would by default end
            up pegging just one CPU at the very end for a while, usually as
            we'd finish whichever *.cocci rule was the most expensive.
     
    @@ Commit message
            setting that makes sense when doing a non-incremental run of "make
            coccicheck".
     
    -     * The change here to
    -       "contrib/coccinelle/the_repository.pending.cocci" is because we've
    -       been spewing out this warning into our $@.log since that rule was
    -       added:
    -
    -           warning: rule starting on line 21: metavariable F not used in the - or context code
    -
    -       It's being fixed here because we'll now notice on "make
    -       coccicheck-pending", since we're not redirecting all of STDERR to a
    -       log file, instead we use the "--very-quiet" option.
    -
         Outstanding issues & future work:
     
          * We could get rid of "--all-includes" in favor of manually
            specifying a list of includes to give to "spatch(1)".
     
    -       As noted upthread of [2] a naïve removal of "--all-includes" will
    +       As noted upthread of [1] a naïve removal of "--all-includes" will
            result in broken *.cocci patches, but if we know the exhaustive
            list of includes via COMPUTE_HEADER_DEPENDENCIES we don't need to
            re-scan for them, we could grab the headers to include from the
            .depend.d/<file>.o.d and supply them with the "--include" option to
            spatch(1).q
     
    -     * We can generalize COMPUTE_HEADER_DEPENDENCIES to spew out the list
    -       of *.h dependencies without making a *.o object, which is slightly
    -       faster, and would also benefit the "make sparse" target. We'd still
    -       need to run the compiler, it would just have less work to do.
    -
    -    1. https://lore.kernel.org/git/877dlwotjc.fsf@evledraar.gmail.com/
    -    2. https://lore.kernel.org/git/87ft18tcog.fsf@evledraar.gmail.com/
    +    1. https://lore.kernel.org/git/87ft18tcog.fsf@evledraar.gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    -@@ Makefile: SP_EXTRA_FLAGS = -Wno-universal-initializer
    - SANITIZE_LEAK =
    - SANITIZE_ADDRESS =
    - 
    --# For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
    +@@ Makefile: SANITIZE_ADDRESS =
    + SPATCH_INCLUDE_FLAGS = --all-includes
    + SPATCH_FLAGS =
    + SPATCH_TEST_FLAGS =
    +-# Setting SPATCH_BATCH_SIZE higher will
     -# usually result in less CPU usage at the cost of higher peak memory.
     -# Setting it to 0 will feed all files in a single spatch invocation.
    - SPATCH_FLAGS = --all-includes
     -SPATCH_BATCH_SIZE = 1
      
      # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
      TRACK_SPATCH_DEFINES =
    - TRACK_SPATCH_DEFINES += $(SPATCH)
    +@@ Makefile: TRACK_SPATCH_DEFINES += $(SPATCH)
    + TRACK_SPATCH_DEFINES += $(SPATCH_INCLUDE_FLAGS)
      TRACK_SPATCH_DEFINES += $(SPATCH_FLAGS)
    + TRACK_SPATCH_DEFINES += $(SPATCH_TEST_FLAGS)
     -TRACK_SPATCH_DEFINES += $(SPATCH_BATCH_SIZE)
      GIT-SPATCH-DEFINES: FORCE
      	@FLAGS='$(TRACK_SPATCH_DEFINES)'; \
    @@ Makefile: check: $(GENERATED_H)
      COCCI = $(wildcard contrib/coccinelle/*.cocci)
     +COCCI_NAMES = $(COCCI:contrib/coccinelle/%.cocci=%)
      COCCI_PATCHES = $(addsuffix .patch,$(COCCI))
    -+COCCI_PATCHES_OK = $(COCCI_PATCHES:%=.build/%.ok)
      COCCICHECK_PENDING = $(filter %.pending.cocci.patch,$(COCCI_PATCHES))
     -COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_PATCHES))
      
     +COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_PATCHES))
    -+COCCICHECK_OK = $(COCCICHECK:%=.build/%.ok)
    -+COCCICHECK_PENDING_OK = $(COCCICHECK_PENDING:%=.build/%.ok)
      COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
      
     -$(COCCI_PATCHES): GIT-SPATCH-DEFINES
    @@ Makefile: check: $(GENERATED_H)
     -	fi; \
     -	if ! echo $(COCCI_SOURCES) | xargs $$limit \
     -		$(SPATCH) $(SPATCH_FLAGS) \
    +-		$(SPATCH_INCLUDE_FLAGS) \
     -		--sp-file $< --patch . \
     -		>$@+ 2>$@.log; \
     +.build/contrib/coccinelle/FOUND_H_SOURCES: $(FOUND_H_SOURCES)
    @@ Makefile: check: $(GENERATED_H)
     +define cocci-rule
     +
     +## Rule for .build/$(1).patch/$(2); Params:
    -+# 1 = $(1)
    -+# 2 = $(2)
    ++# $(1) = e.g. "free.cocci"
    ++# $(2) = e.g. "grep.c"
     +COCCI_$(1:contrib/coccinelle/%.cocci=%) += .build/$(1).patch/$(2)
     +.build/$(1).patch/$(2): GIT-SPATCH-DEFINES
    -+.build/$(1).patch/$(2): $(if $(wildcard $(3)),$(3),.build/contrib/coccinelle/FOUND_H_SOURCES)
    ++.build/$(1).patch/$(2): .build/contrib/coccinelle/FOUND_H_SOURCES
     +.build/$(1).patch/$(2): $(1)
     +.build/$(1).patch/$(2): .build/$(1).patch/% : %
     +	$$(call mkdir_p_parent_template)
    -+	$$(QUIET_SPATCH)$$(SPATCH) $$(SPATCH_FLAGS) \
    -+		--very-quiet \
    -+		--sp-file $(1) --patch . \
    -+		$$(SPATCH_PATCH_FLAGS) $$< >$$@
    ++	$$(QUIET_SPATCH)if ! $$(SPATCH) $$(SPATCH_FLAGS) \
    ++		$$(SPATCH_INCLUDE_FLAGS) \
    ++		--sp-file $(1) --patch . $$< \
    ++		>$$@ 2>$$@.log; \
    + 	then \
    +-		cat $@.log; \
    ++		echo "ERROR when applying '$(1)' to '$$<'; '$$@.log' follows:"; \
    ++		cat $$@.log; \
    + 		exit 1; \
    +-	fi; \
    +-	mv $@+ $@; \
    +-	if test -s $@; \
    ++	fi
     +endef
     +
     +define cocci-matrix-2
     +
    -+$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(c),$(s),$(s:%.c=%.o)))
    ++$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(c),$(s)))
     +endef
     +define cocci-matrix-1
     +$(foreach c,$(COCCI),$(call cocci-matrix-2,$(c)))
    @@ Makefile: check: $(GENERATED_H)
     +define spatch-rule
     +
     +contrib/coccinelle/$(1).cocci.patch: $$(COCCI_$(1))
    -+	$(QUIET_SPATCH_M)cat $$^ >$$@
    -+endef
    -+
    -+$(COCCI_PATCHES_OK): .build/%.ok : %
    -+	$(QUIET_SPATCH_R)if test -s $<; \
    ++	$(QUIET_SPATCH_M)cat $$^ >$$@ && \
    ++	if test -s $$@; \
      	then \
    --		cat $@.log; \
    -+		cat $< | sed -e 's/^/	/'; \
    - 		exit 1; \
    --	fi; \
    --	mv $@+ $@; \
    --	if test -s $@; \
    --	then \
     -		echo '    ' SPATCH result: $@; \
    --	fi
    -+	fi && \
    -+	>$@
    ++		echo '    ' SPATCH result: $$@; \
    + 	fi
    ++endef
     +
     +ifneq ($(filter $(COCCI_RULES),$(MAKECMDGOALS)),)
     +$(eval $(foreach n,$(COCCI_NAMES),$(call spatch-rule,$(n))))
    @@ Makefile: check: $(GENERATED_H)
      
      COCCI_TEST_RES_GEN = $(addprefix .build/,$(COCCI_TEST_RES))
      $(COCCI_TEST_RES_GEN): GIT-SPATCH-DEFINES
    -@@ Makefile: $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinell
    - coccicheck-test: $(COCCI_TEST_RES_GEN)
    - 
    - coccicheck: coccicheck-test
    --coccicheck: $(COCCICHECK)
    -+coccicheck: $(COCCICHECK_OK)
    - 
    - # See contrib/coccinelle/README
    - coccicheck-pending: coccicheck-test
    --coccicheck-pending: $(COCCICHECK_PENDING)
    -+coccicheck-pending: $(COCCICHECK_PENDING_OK)
    - 
    - .PHONY: coccicheck coccicheck-pending
    - 
     @@ Makefile: profile-clean:
      
      cocciclean:
    @@ Makefile: profile-clean:
      clean: profile-clean coverage-clean cocciclean
      	$(RM) -r .build
     
    - ## contrib/coccinelle/the_repository.pending.cocci ##
    -@@ contrib/coccinelle/the_repository.pending.cocci: expression E;
    - 
    - @@
    - expression E;
    --expression F;
    - @@
    - - has_object_file_with_flags(
    - + repo_has_object_file_with_flags(the_repository,
    -
      ## shared.mak ##
     @@ shared.mak: ifndef V
      	QUIET_SP       = @echo '   ' SP $<;
    @@ shared.mak: ifndef V
     +	QUIET_SPATCH   = @echo '   ' SPATCH $@;
      	QUIET_SPATCH_T = @echo '   ' SPATCH TEST $(@:.build/%=%);
     +	QUIET_SPATCH_M = @echo '   ' SPATCH MERGE $$@;
    -+	QUIET_SPATCH_R = @echo '   ' SPATCH RESULT $<;
      
      ## Used in "Documentation/Makefile"
      	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
 4:  cda20790146 !  8:  536dce45eef cocci: make incremental compilation even faster
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    cocci: make incremental compilation even faster
    +    cocci: optimistically use COMPUTE_HEADER_DEPENDENCIES
     
    -    Make the incremental compilation of "make coccicheck" even faster, at
    -    the cost of losing dependency discovery for a small whitelist of *.c
    -    files which we can't create *.o files for.
    +    Improve the incremental rebuilding support of "coccicheck" by
    +    piggy-backing on the computed dependency information of the
    +    corresponding *.o file, rather than rebuilding all <RULE>/<FILE> pairs
    +    if either their corresponding file changes, or if any header changes.
     
    -    This will break obscure edge cases since e.g.:
    +    This in effect uses the same method that the "sparse" target was made
    +    to use in c234e8a0ecf (Makefile: make the "sparse" target non-.PHONY,
    +    2021-09-23), except that the dependency on the *.o file isn't a hard
    +    one, we check with $(wildcard) if the *.o file exists, and if so we'll
    +    depend on it.
     
    -        time make -W block-sha1/sha1.h coccicheck
    +    This means that the common case of:
     
    -    Would correctly re-build before, as block-sha1/sha1.c uses
    -    block-sha1/sha1.h, but as it and these other
    -    $(USE_TINY_FOUND_H_SOURCES) files depended on the union of all such
    -    headers (and more, all of $(FOUND_H_SOURCES)) the above command would
    -    take ~10 seconds before.
    +            make
    +            make coccicheck
     
    -    As noted in the preceding commit these obscure cases were broken
    -    before the preceding commit fixed them. I think it makes sense to make
    -    a correctness v.s. performance trade-off here. By doing this it
    -    becomes viable to e.g. run "make coccicheck" in the same loop that
    -    merges various topic branches down (along with "ccache" sped-up
    -    compilation).
    +    Will benefit from incremental rebuilding, now changing e.g. a header
    +    will only re-run "spatch" on those those *.c files that make use of
    +    it:
    +
    +    By depending on the *.o we piggy-back on
    +    COMPUTE_HEADER_DEPENDENCIES. See c234e8a0ecf (Makefile: make the
    +    "sparse" target non-.PHONY, 2021-09-23) for prior art of doing that
    +    for the *.sp files. E.g.:
    +
    +        make contrib/coccinelle/free.cocci.patch
    +        make -W column.h contrib/coccinelle/free.cocci.patch
    +
    +    Will take around 15 seconds for the second command on my 8 core box if
    +    I didn't run "make" beforehand to create the *.o files. But around 2
    +    seconds if I did and we have those "*.o" files.
    +
    +    Notes about the approach of piggy-backing on *.o for dependencies:
    +
    +     * It *is* a trade-off since we'll pay the extra cost of running the C
    +       compiler, but we're probably doing that anyway. The compiler is much
    +       faster than "spatch", so even though we need to re-compile the *.o to
    +       create the dependency info for the *.c for "spatch" it's
    +       faster (especially if using "ccache").
    +
    +     * There *are* use-cases where some would like to have *.o files
    +       around, but to have the "make coccicheck" ignore them. See:
    +       https://lore.kernel.org/git/20220826104312.GJ1735@szeder.dev/
    +
    +       For those users a:
    +
    +            make
    +            make coccicheck SPATCH_USE_O_DEPENDENCIES=
    +
    +       Will avoid considering the *.o files.
    +
    +     * If that *.o file doesn't exist we'll depend on an intermediate file
    +       of ours which in turn depends on $(FOUND_H_SOURCES).
    +
    +       This covers both an initial build, or where "coccicheck" is run
    +       without running "all" beforehand, and because we run "coccicheck"
    +       on e.g. files in compat/* that we don't know how to build unless
    +       the requisite flag was provided to the Makefile.
    +
    +       Most of the runtime of "incremental" runs is now spent on various
    +       compat/* files, i.e. we conditionally add files to COMPAT_OBJS, and
    +       therefore conflate whether we *can* compile an object and generate
    +       dependency information for it with whether we'd like to link it
    +       into our binary.
    +
    +       Before this change the distinction didn't matter, but now one way
    +       to make this even faster on incremental builds would be to peel
    +       those concerns apart so that we can see that e.g. compat/mmap.c
    +       doesn't depend on column.h.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    -@@ Makefile: COCCICHECK_OK = $(COCCICHECK:%=.build/%.ok)
    - COCCICHECK_PENDING_OK = $(COCCICHECK_PENDING:%=.build/%.ok)
    - COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
    - 
    -+USE_TINY_FOUND_H_SOURCES =
    -+USE_TINY_FOUND_H_SOURCES += compat/%
    -+USE_TINY_FOUND_H_SOURCES += block-sha1/%
    -+USE_TINY_FOUND_H_SOURCES += ppc/%
    -+
    -+TINY_FOUND_H_SOURCES =
    -+TINY_FOUND_H_SOURCES += cache.h
    -+TINY_FOUND_H_SOURCES += git-compat-util.h
    -+TINY_FOUND_H_SOURCES += strbuf.h
    -+
    - .build/contrib/coccinelle/FOUND_H_SOURCES: $(FOUND_H_SOURCES)
    +@@ Makefile: COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
      	$(call mkdir_p_parent_template)
      	$(QUIET_GEN) >$@
    -@@ Makefile: define cocci-rule
    - # 2 = $(2)
    + 
    ++SPATCH_USE_O_DEPENDENCIES = yes
    ++ifeq ($(COMPUTE_HEADER_DEPENDENCIES),no)
    ++SPATCH_USE_O_DEPENDENCIES =
    ++endif
    ++
    + define cocci-rule
    + 
    + ## Rule for .build/$(1).patch/$(2); Params:
    + # $(1) = e.g. "free.cocci"
    + # $(2) = e.g. "grep.c"
    ++# $(3) = e.g. "grep.o"
      COCCI_$(1:contrib/coccinelle/%.cocci=%) += .build/$(1).patch/$(2)
      .build/$(1).patch/$(2): GIT-SPATCH-DEFINES
    --.build/$(1).patch/$(2): $(if $(wildcard $(3)),$(3),.build/contrib/coccinelle/FOUND_H_SOURCES)
    -+.build/$(1).patch/$(2): $(if $(wildcard $(3)),$(3),$(if $(filter $(USE_TINY_FOUND_H_SOURCES),$(3)),$(TINY_FOUND_H_SOURCES),.build/contrib/coccinelle/FOUND_H_SOURCES))
    +-.build/$(1).patch/$(2): .build/contrib/coccinelle/FOUND_H_SOURCES
    ++.build/$(1).patch/$(2): $(if $(and $(SPATCH_USE_O_DEPENDENCIES),$(wildcard $(3))),$(3),.build/contrib/coccinelle/FOUND_H_SOURCES)
      .build/$(1).patch/$(2): $(1)
      .build/$(1).patch/$(2): .build/$(1).patch/% : %
      	$$(call mkdir_p_parent_template)
    +@@ Makefile: endef
    + 
    + define cocci-matrix-2
    + 
    +-$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(c),$(s)))
    ++$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(c),$(s),$(s:%.c=%.o)))
    + endef
    + define cocci-matrix-1
    + $(foreach c,$(COCCI),$(call cocci-matrix-2,$(c)))
 5:  ce4734e5d79 !  9:  2b978676a56 spatchcache: add a ccache-alike for "spatch"
    @@ Commit message
     
         Add a rather trivial "spatchcache", with this running e.g.:
     
    -            make clean
    -            make contrib/coccinelle/free.cocci.patch
    +            make cocciclean
    +            make contrib/coccinelle/free.cocci.patch \
    +                    SPATCH=contrib/coccicheck/spatchcache \
    +                    SPATCH_FLAGS=--very-quiet
     
    -    Is cut down from ~20s to ~3s on my system (and much of it is fixable
    -    shell overhead). This uses "redis" as a cache by default, but it's
    -    configurable. See the embedded documentation.
    +    Is cut down from ~20s to ~5s on my system. Much of that is either
    +    fixable shell overhead, or the around 40 files we "CANTCACHE" (see the
    +    implementation).
    +
    +    This uses "redis" as a cache by default, but it's configurable. See
    +    the embedded documentation.
     
         This is *not* like ccache in that we won't cache failed spatch
         invocations, or those where spatch suggests changes for us. Those
         cases are so rare that I didn't think it was worth the bother, by far
    -    the most common case is that it has no suggested changes.
    +    the most common case is that it has no suggested changes. We'll also
    +    refuse to cache any "spatch" invocation that has output on stderr,
    +    which means that "--very-quiet" must be added to "SPATCH_FLAGS".
     
         Because we narrow the cache to that we don't need to save away stdout,
         stderr & the exit code. We simply cache the cases where we had no
    @@ contrib/coccinelle/spatchcache (new)
     +# driving "spatch" in git.git, in particular if we invoke:
     +#
     +#	make
    -+#	make coccicheck
    ++#	make coccicheck SPATCH_FLAGS=--very-quiet
     +#
     +# We can with COMPUTE_HEADER_DEPENDENCIES (auto-detected as true with
     +# "gcc" and "clang") write e.g. a .depend/grep.o.d for grep.c, when we
    @@ contrib/coccinelle/spatchcache (new)
     +# "contrib/coccinelle" makes it viable to (re-)run coccicheck
     +# e.g. when merging integration branches.
     +#
    ++# Note that the "--very-quiet" flag is currently critical. The cache
    ++# will refuse to cache anything that has output on STDERR (which might
    ++# be errors from spatch). The STDERR (and exit code) could in
    ++# principle be cached (as with ccache), but then the simple structure
    ++# in the Redis cache would need to change, so just supply
    ++# "--very-quiet" for now.
    ++#
     +# To use this, simply set SPATCH to
     +# contrib/coccinelle/spatchcache. Then optionally set:
     +#
     +#	[spatchCache]
    -+#		# path to a custom spatch
    ++#		# Optional: path to a custom spatch
     +#		spatch = ~/g/coccicheck/spatch.opt
     +#
     +# As well as this trace config (debug implies trace):
    @@ contrib/coccinelle/spatchcache (new)
     +#		debug = false
     +#
     +# Setting "trace" to "true" allows for seeing when we have a cache HIT
    -+# or MISS.
    ++# or MISS. To debug whether the cache is working do that, and run e.g.:
    ++#
    ++#	redis-cli FLUSHALL
    ++#	<make && make coccicheck, as above>
    ++#	grep -hore HIT -e MISS -e SET -e NOCACHE -e CANTCACHE .build/contrib/coccinelle | sort | uniq -c
    ++#	    600 CANTCACHE
    ++#	   7365 MISS
    ++#	   7365 SET
    ++#
    ++# A subsequent "make cocciclean && make coccicheck" should then have
    ++# all "HIT"'s and "CANTCACHE"'s.
     +
     +set -e
     +
    @@ contrib/coccinelle/spatchcache (new)
     +
     +if ! test -f "$dep"
     +then
    -+	trace_it "$0: have no '$dep' for '$arg_file', can't cache!"
    ++	trace_it "$0: CANTCACHE have no '$dep' for '$arg_file'!"
     +	exec "$spatch" "$@"
     +fi
     +
    @@ contrib/coccinelle/spatchcache (new)
     +		exit 128
     +	fi
     +else
    -+	trace_it "$0: NO CACHE (have changes): for '$arg_file' with '$arg_sp'"
    ++	trace_it "$0: NOCACHE (have changes): for '$arg_file' with '$arg_sp'"
     +	cat "$out"
     +	cat "$err" >&2
     +	rm -f "$out" "$err"
-- 
2.37.3.1420.g76f8a3d556c

