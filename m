Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59B2C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJNPcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiJNPbi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:31:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B7D1277F
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bv10so8124816wrb.4
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CF/+nhihMlhICwAO+MQpeYlwCDFjJMrRLMe6njsufE=;
        b=NhkwfivbHetbgiRyi0ci9vv/JbU6G7pW/8m8C6gTQfsNBjgUdOtkBL1QvIgVwvkmty
         0Z+jB93/tA3hPPYzrZzF+DwkfqS2GpHFjMPstdY+6kupXVwS4P3D2Yd6ze7QDiujj+D+
         659cQxT7t/GSKyvxXfB8nWnaVze/XEpmFaFedqAlB9a4NhuF0Q2rRQuMR9s3Xc8KkXt+
         ab8a8Gst2AogFE+JWWWuQj11u2iTGATjx/D9gBPbfe0qY0Sz2Uj+RzJuhJgvYLKSChYm
         cbhNidcbFbB3+6yu8aByStsXcZvvt86h9fE73FEJcQoBr3nzxN2lKy+OFE+VcvYmhgpr
         gbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CF/+nhihMlhICwAO+MQpeYlwCDFjJMrRLMe6njsufE=;
        b=RumYJWNIJ0AVm2j2v3be8DPiE5rPugihqvcvs2DN/SCnGWjiMkUioznMogyN48U+Zg
         Ayt6Qh3nnfLXeP1cWR0dtlqkrHgrXomSHeJn7ZH/FKUrMfAe+zmBSpVVXPK2H7efja/t
         Fa3TjbmbT8lD9uAdWAh3HgL1V7YRchQN8/xR48Sm4skI/WUqF5+xPZLSZfe46k9MEb/f
         iL+yt712OqL5c2OdYc/c9XdGbAQdqW7GL7F5xn5yN4SWyvRVSthMUp6udvtgt/9/JlEQ
         JFJn20AuajrZZTMHdcMkpNB7EXO8SHava6v8Z/kdbsTTUtuAxJbkEQLLddicUGYUzEVE
         3yew==
X-Gm-Message-State: ACrzQf0X0R+5R7WgskcI9byxGrG8uIAWvKobey1xUzXM2lBaL1ADtUgX
        lM3rfCyOqTFOrTN6chy0qULsPGKEr2OC5A==
X-Google-Smtp-Source: AMsMyM4gkUSYmSgF/kUa3XF80pKUhxk+2IIqXYTzgln4pJlz4yquBlkjRlSD2obJ2DiExKnmY43+8g==
X-Received: by 2002:a5d:6488:0:b0:22b:3b0b:5e72 with SMTP id o8-20020a5d6488000000b0022b3b0b5e72mr3890712wri.138.1665761490783;
        Fri, 14 Oct 2022 08:31:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b003b47ff307e1sm2219053wmb.31.2022.10.14.08.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:31:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/11] cocci: make "incremental" possible + a ccache-like tool
Date:   Fri, 14 Oct 2022 17:31:16 +0200
Message-Id: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of the series to have "make coccicheck" run
incrementally. For the v1 see:
https://lore.kernel.org/git/cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com/

The big change in this belated v3 is that we now run against a
concatenated version of all our *.cocci files. This is something I
discussed with Jeff King at Git Merge, after having confirmed the
viability of that approach on the cocci mailing list.

The result is that even with a from-scratch run of "make coccicheck"
this is faster than on "master", while of course adding the ability to
run incrementally, so a subsequent "coccicheck" is only run against
what we'd recompile.

The churn here is because I had to move/change some variables around
early in the series to make the eventual 08/11 smaller.

There's also improvements here to the bundled "spatchcache", it can
now optionally interoperate with non--very-quiet output (but won't
cache stderr), which is handy for debugging it. It can also be
configured to tell it where the .depend/* files are, which is a small
change to make it posible to use it outside of git.git..

Ævar Arnfjörð Bjarmason (11):
  Makefile + shared.mak: rename and indent $(QUIET_SPATCH_T)
  cocci rules: remove unused "F" metavariable from pending rule
  Makefile: add ability to TAB-complete cocci *.patch rules
  Makefile: have "coccicheck" re-run if flags change
  Makefile: split off SPATCH_BATCH_SIZE comment from "cocci" heading
  cocci: split off include-less "tests" from SPATCH_FLAGS
  cocci: split off "--all-includes" from SPATCH_FLAGS
  cocci: make "coccicheck" rule incremental
  cocci: optimistically use COMPUTE_HEADER_DEPENDENCIES
  cocci: run against a generated ALL.cocci
  spatchcache: add a ccache-alike for "spatch"

 .gitignore                                    |   1 +
 Makefile                                      | 159 ++++++++--
 contrib/coccinelle/.gitignore                 |   1 +
 contrib/coccinelle/spatchcache                | 272 ++++++++++++++++++
 .../coccinelle/the_repository.pending.cocci   |   1 -
 shared.mak                                    |  10 +-
 6 files changed, 416 insertions(+), 28 deletions(-)
 create mode 100755 contrib/coccinelle/spatchcache

Range-diff against v2:
 -:  ----------- >  1:  4494c91df9a Makefile + shared.mak: rename and indent $(QUIET_SPATCH_T)
 1:  72b6a8e4e0b =  2:  8219b1b12f2 cocci rules: remove unused "F" metavariable from pending rule
 2:  0998948b881 !  3:  6dbfafa08fd Makefile: add ability to TAB-complete cocci *.patch rules
    @@ Makefile: check: $(GENERATED_H)
      		exit 1; \
      	fi
      
    -+COCCI = $(wildcard contrib/coccinelle/*.cocci)
    -+COCCI_PATCHES = $(addsuffix .patch,$(COCCI))
    -+COCCICHECK_PENDING = $(filter %.pending.cocci.patch,$(COCCI_PATCHES))
    -+COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_PATCHES))
    ++COCCI_GLOB = $(wildcard contrib/coccinelle/*.cocci)
    ++COCCI_RULES = $(COCCI_GLOB)
    ++
    ++COCCICHECK_PENDING = $(filter %.pending.cocci,$(COCCI_RULES))
    ++COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_RULES))
    ++
    ++COCCICHECK_PATCHES = $(COCCICHECK:%=%.patch)
    ++COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
     +
      COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
      
     -%.cocci.patch: %.cocci $(COCCI_SOURCES)
    ++COCCI_PATCHES = $(COCCI_RULES:%=%.patch)
     +$(COCCI_PATCHES): $(COCCI_SOURCES)
     +$(COCCI_PATCHES): %.patch: %
      	$(QUIET_SPATCH) \
    @@ Makefile: $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib
      
      coccicheck: coccicheck-test
     -coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard contrib/coccinelle/*.cocci)))
    -+coccicheck: $(COCCICHECK)
    ++coccicheck: $(COCCICHECK_PATCHES)
      
      # See contrib/coccinelle/README
      coccicheck-pending: coccicheck-test
     -coccicheck-pending: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.pending.cocci))
    -+coccicheck-pending: $(COCCICHECK_PENDING)
    ++coccicheck-pending: $(COCCICHECK_PATCHES_PENDING)
      
      .PHONY: coccicheck coccicheck-pending
      
    -@@ Makefile: profile-clean:
    - 
    - cocciclean:
    - 	$(RM) -r .build/contrib/coccinelle
    --	$(RM) contrib/coccinelle/*.cocci.patch*
    -+	$(RM) $(COCCI_PATCHES)*
    - 
    - clean: profile-clean coverage-clean cocciclean
    - 	$(RM) -r .build
 3:  63cf9f58d99 !  4:  f779a2d22aa Makefile: have "coccicheck" re-run if flags change
    @@ Makefile: SANITIZE_ADDRESS =
      include config.mak.uname
      -include config.mak.autogen
      -include config.mak
    -@@ Makefile: COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_PATCHES))
    - 
    +@@ Makefile: COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
      COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
      
    + COCCI_PATCHES = $(COCCI_RULES:%=%.patch)
     +$(COCCI_PATCHES): GIT-SPATCH-DEFINES
      $(COCCI_PATCHES): $(COCCI_SOURCES)
      $(COCCI_PATCHES): %.patch: %
    @@ Makefile: $(COCCI_PATCHES): %.patch: %
      $(COCCI_TEST_RES_GEN): .build/%.res : %.c
      $(COCCI_TEST_RES_GEN): .build/%.res : %.res
      $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinelle/%.cocci
    +@@ Makefile: profile-clean:
    + 	$(RM) $(addsuffix *.gcno,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
    + 
    + cocciclean:
    ++	$(RM) GIT-SPATCH-DEFINES
    + 	$(RM) -r .build/contrib/coccinelle
    + 	$(RM) contrib/coccinelle/*.cocci.patch*
    + 
 4:  54d6bae3984 =  5:  ab25b586f38 Makefile: split off SPATCH_BATCH_SIZE comment from "cocci" heading
 5:  4f165bf6128 !  6:  691be73b6fb cocci: split off include-less "tests" from SPATCH_FLAGS
    @@ Makefile: $(COCCI_TEST_RES_GEN): .build/%.res : %.c
      $(COCCI_TEST_RES_GEN): .build/%.res : %.res
      $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinelle/%.cocci
      	$(call mkdir_p_parent_template)
    --	$(QUIET_SPATCH_T)$(SPATCH) $(SPATCH_FLAGS) \
    -+	$(QUIET_SPATCH_T)$(SPATCH) $(SPATCH_TEST_FLAGS) \
    +-	$(QUIET_SPATCH_TEST)$(SPATCH) $(SPATCH_FLAGS) \
    ++	$(QUIET_SPATCH_TEST)$(SPATCH) $(SPATCH_TEST_FLAGS) \
      		--very-quiet --no-show-diff \
      		--sp-file $< -o $@ \
      		$(@:.build/%.res=%.c) && \
 6:  c74d09f4825 =  7:  2ca5ea5beca cocci: split off "--all-includes" from SPATCH_FLAGS
 7:  120607b5da6 !  8:  2072a508064 cocci: make "coccicheck" rule incremental
    @@ Commit message
     
            This could be mitigated by combining "make -jN" with
            SPATCH_BATCH_SIZE, see 960154b9c17 (coccicheck: optionally batch
    -       spatch invocations, 2019-05-06). But doing so required careful
    -       juggling, as e.g. setting both to 4 would yield 16 workers.
    +       spatch invocations, 2019-05-06).
     
            There will be cases where getting rid of "SPATCH_BATCH_SIZE" makes
            things worse, but a from-scratch "make coccicheck" with the default
    @@ Commit message
            setting that makes sense when doing a non-incremental run of "make
            coccicheck".
     
    +     * Before the "make coccicheck" rule would have to clean
    +       "contrib/coccinelle/*.cocci.patch*", since we'd create "*+" and
    +       "*.log" files there. Now those are created in
    +       .build/contrib/coccinelle/, which is covered by the "cocciclean" rule
    +       already.
    +
         Outstanding issues & future work:
     
          * We could get rid of "--all-includes" in favor of manually
    @@ Makefile: TRACK_SPATCH_DEFINES += $(SPATCH)
      	@FLAGS='$(TRACK_SPATCH_DEFINES)'; \
      	    if test x"$$FLAGS" != x"`cat GIT-SPATCH-DEFINES 2>/dev/null`" ; then \
     @@ Makefile: check: $(GENERATED_H)
    - 		exit 1; \
    - 	fi
      
    + COCCI_GLOB = $(wildcard contrib/coccinelle/*.cocci)
    + COCCI_RULES = $(COCCI_GLOB)
    ++COCCI_NAMES = $(COCCI_RULES:contrib/coccinelle/%.cocci=%)
    + 
    + COCCICHECK_PENDING = $(filter %.pending.cocci,$(COCCI_RULES))
    ++COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
    + COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_RULES))
    ++COCCICHECK_PATCHES = $(COCCICHECK:%=%.patch)
    ++
     +# It's expensive to compute the many=many rules below, only eval them
     +# on $(MAKECMDGOALS) that match these $(COCCI_RULES)
    -+COCCI_RULES =
    -+COCCI_RULES += cocci%
    -+COCCI_RULES += contrib/coccinelle/%
    -+COCCI_RULES += .build/contrib/coccinelle/%
    -+
    - COCCI = $(wildcard contrib/coccinelle/*.cocci)
    -+COCCI_NAMES = $(COCCI:contrib/coccinelle/%.cocci=%)
    - COCCI_PATCHES = $(addsuffix .patch,$(COCCI))
    - COCCICHECK_PENDING = $(filter %.pending.cocci.patch,$(COCCI_PATCHES))
    --COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_PATCHES))
    ++COCCI_RULES_GLOB =
    ++COCCI_RULES_GLOB += cocci%
    ++COCCI_RULES_GLOB += .build/contrib/coccinelle/%
    ++COCCI_RULES_GLOB += $(COCCICHECK_PATCHES)
    ++COCCI_RULES_GLOB += $(COCCICHEC_PATCHES_PENDING)
    ++COCCI_GOALS = $(filter $(COCCI_RULES_GLOB),$(MAKECMDGOALS))
    + 
    + COCCICHECK_PATCHES = $(COCCICHECK:%=%.patch)
    + COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
      
    -+COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_PATCHES))
      COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
      
    +-COCCI_PATCHES = $(COCCI_RULES:%=%.patch)
     -$(COCCI_PATCHES): GIT-SPATCH-DEFINES
     -$(COCCI_PATCHES): $(COCCI_SOURCES)
     -$(COCCI_PATCHES): %.patch: %
    @@ Makefile: check: $(GENERATED_H)
     +	fi
     +endef
     +
    -+define cocci-matrix-2
    ++define cocci-matrix
     +
    -+$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(c),$(s)))
    -+endef
    -+define cocci-matrix-1
    -+$(foreach c,$(COCCI),$(call cocci-matrix-2,$(c)))
    ++$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(1),$(s)))
     +endef
     +
    -+ifneq ($(filter $(COCCI_RULES),$(MAKECMDGOALS)),)
    -+$(eval $(call cocci-matrix-1))
    ++ifdef COCCI_GOALS
    ++$(eval $(foreach c,$(COCCI_RULES),$(call cocci-matrix,$(c))))
     +endif
     +
     +define spatch-rule
     +
     +contrib/coccinelle/$(1).cocci.patch: $$(COCCI_$(1))
    -+	$(QUIET_SPATCH_M)cat $$^ >$$@ && \
    ++	$(QUIET_SPATCH_CAT_TMPL)cat $$^ >$$@ && \
     +	if test -s $$@; \
      	then \
     -		echo '    ' SPATCH result: $@; \
    @@ Makefile: check: $(GENERATED_H)
      	fi
     +endef
     +
    -+ifneq ($(filter $(COCCI_RULES),$(MAKECMDGOALS)),)
    ++ifdef COCCI_GOALS
     +$(eval $(foreach n,$(COCCI_NAMES),$(call spatch-rule,$(n))))
     +endif
      
      COCCI_TEST_RES_GEN = $(addprefix .build/,$(COCCI_TEST_RES))
      $(COCCI_TEST_RES_GEN): GIT-SPATCH-DEFINES
     @@ Makefile: profile-clean:
    - 
      cocciclean:
    + 	$(RM) GIT-SPATCH-DEFINES
      	$(RM) -r .build/contrib/coccinelle
    --	$(RM) $(COCCI_PATCHES)*
    -+	$(RM) $(COCCI_PATCHES)
    +-	$(RM) contrib/coccinelle/*.cocci.patch*
    ++	$(RM) $(COCCICHECK_PATCHES)
    ++	$(RM) $(COCCICHECK_PATCHES_PENDING)
      
      clean: profile-clean coverage-clean cocciclean
      	$(RM) -r .build
     
      ## shared.mak ##
     @@ shared.mak: ifndef V
    - 	QUIET_SP       = @echo '   ' SP $<;
    - 	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
      	QUIET_RC       = @echo '   ' RC $@;
    --	QUIET_SPATCH   = @echo '   ' SPATCH $<;
    -+	QUIET_SPATCH   = @echo '   ' SPATCH $@;
    - 	QUIET_SPATCH_T = @echo '   ' SPATCH TEST $(@:.build/%=%);
    -+	QUIET_SPATCH_M = @echo '   ' SPATCH MERGE $$@;
      
    + ## Used in "Makefile": SPATCH
    +-	QUIET_SPATCH			= @echo '   ' SPATCH $<;
    ++	QUIET_SPATCH			= @echo '   ' SPATCH $@;
    + 	QUIET_SPATCH_TEST		= @echo '   ' SPATCH TEST $(@:.build/%=%);
    + 
    ++## Used in "Makefile": SPATCH_*TMPL (quoted for use in "define"'s)
    ++	QUIET_SPATCH_CAT_TMPL		= @echo '   ' SPATCH CAT $$$$^ \>$$@;
    ++
      ## Used in "Documentation/Makefile"
      	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
    + 	QUIET_XMLTO	= @echo '   ' XMLTO $@;
 8:  536dce45eef !  9:  739652eada9 cocci: optimistically use COMPUTE_HEADER_DEPENDENCIES
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    +@@ Makefile: SPATCH_INCLUDE_FLAGS = --all-includes
    + SPATCH_FLAGS =
    + SPATCH_TEST_FLAGS =
    + 
    ++# If *.o files are present, have "coccicheck" depend on them, with
    ++# COMPUTE_HEADER_DEPENDENCIES this will speed up the common-case of
    ++# only needing to re-generate coccicheck results for the users of a
    ++# given API if it's changed, and not all files in the project. If
    ++# COMPUTE_HEADER_DEPENDENCIES=no this will be unset too.
    ++SPATCH_USE_O_DEPENDENCIES = YesPlease
    ++
    + # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
    + TRACK_SPATCH_DEFINES =
    + TRACK_SPATCH_DEFINES += $(SPATCH)
     @@ Makefile: COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
      	$(call mkdir_p_parent_template)
      	$(QUIET_GEN) >$@
      
    -+SPATCH_USE_O_DEPENDENCIES = yes
     +ifeq ($(COMPUTE_HEADER_DEPENDENCIES),no)
     +SPATCH_USE_O_DEPENDENCIES =
     +endif
    -+
      define cocci-rule
      
      ## Rule for .build/$(1).patch/$(2); Params:
    @@ Makefile: COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
      	$$(call mkdir_p_parent_template)
     @@ Makefile: endef
      
    - define cocci-matrix-2
    + define cocci-matrix
      
    --$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(c),$(s)))
    +-$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(1),$(s)))
     +$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(c),$(s),$(s:%.c=%.o)))
      endef
    - define cocci-matrix-1
    - $(foreach c,$(COCCI),$(call cocci-matrix-2,$(c)))
    + 
    + ifdef COCCI_GOALS
 -:  ----------- > 10:  52177ea2a68 cocci: run against a generated ALL.cocci
 9:  2b978676a56 ! 11:  f7ca3f9c9af spatchcache: add a ccache-alike for "spatch"
    @@ contrib/coccinelle/spatchcache (new)
     +#
     +# Note that the "--very-quiet" flag is currently critical. The cache
     +# will refuse to cache anything that has output on STDERR (which might
    -+# be errors from spatch). The STDERR (and exit code) could in
    -+# principle be cached (as with ccache), but then the simple structure
    -+# in the Redis cache would need to change, so just supply
    -+# "--very-quiet" for now.
    ++# be errors from spatch), but see spatchCache.cacheWhenStderr below.
    ++#
    ++# The STDERR (and exit code) could in principle be cached (as with
    ++# ccache), but then the simple structure in the Redis cache would need
    ++# to change, so just supply "--very-quiet" for now.
     +#
     +# To use this, simply set SPATCH to
     +# contrib/coccinelle/spatchcache. Then optionally set:
    @@ contrib/coccinelle/spatchcache (new)
     +#
     +# As well as this trace config (debug implies trace):
     +#
    ++#		cacheWhenStderr = true
     +#		trace = false
     +#		debug = false
     +#
    ++# The ".depend/grep.o.d" can also be customized, as a string that will
    ++# be eval'd, it has access to a "$dirname" and "$basename":
    ++#
    ++#	[spatchCache]
    ++#		dependFormat = "$dirname/.depend/${basename%.c}.o.d"
    ++#
     +# Setting "trace" to "true" allows for seeing when we have a cache HIT
     +# or MISS. To debug whether the cache is working do that, and run e.g.:
     +#
    @@ contrib/coccinelle/spatchcache (new)
     +#
     +# A subsequent "make cocciclean && make coccicheck" should then have
     +# all "HIT"'s and "CANTCACHE"'s.
    ++#
    ++# The "spatchCache.cacheWhenStderr" option is critical when using
    ++# spatchCache.{trace,debug} to debug whether something is set in the
    ++# cache, as we'll write to the spatch logs in .build/* we'd otherwise
    ++# always emit a NOCACHE.
     +
     +set -e
     +
    @@ contrib/coccinelle/spatchcache (new)
     +	trace=true
     +fi
     +
    ++cacheWhenStderr=$(git config --bool "spatchCache.cacheWhenStderr")
    ++if test "$cacheWhenStderr" != "true"
    ++then
    ++	cacheWhenStderr=
    ++fi
    ++
     +trace_it () {
     +	if test -z "$trace"
     +	then
    @@ contrib/coccinelle/spatchcache (new)
     +	spatch=spatch
     +fi
     +
    ++dependFormat='$dirname/.depend/${basename%.c}.o.d'
    ++dependFormatCfg=$(git config "spatchCache.dependFormat" || :)
    ++if test -n "$dependFormatCfg"
    ++then
    ++	dependFormat="$dependFormatCfg"
    ++fi
    ++
     +set=$(git config spatchCache.setCmd || :)
     +get=$(git config spatchCache.getCmd || :)
     +
    @@ contrib/coccinelle/spatchcache (new)
     +
     +hash_for_cache() {
     +	# Parameters that should affect the cache
    -+	echo "spatch=$spatch"
     +	echo "args=$args"
    ++	echo "config spatchCache.spatch=$spatch"
    ++	echo "config spatchCache.debug=$debug"
    ++	echo "config spatchCache.trace=$trace"
    ++	echo "config spatchCache.cacheWhenStderr=$cacheWhenStderr"
     +	echo
     +
     +	# Our target file and its dependencies
    @@ contrib/coccinelle/spatchcache (new)
     +fi
     +
     +# Main logic
    -+d=$(dirname "$arg_file")
    -+b=$(basename "$arg_file")
    -+bwoext="${b%.c}"
    -+dep="$d/.depend/$bwoext.o.d"
    ++dirname=$(dirname "$arg_file")
    ++basename=$(basename "$arg_file")
    ++eval "dep=$dependFormat"
     +
     +if ! test -f "$dep"
     +then
    @@ contrib/coccinelle/spatchcache (new)
     +err="$(mktemp)"
     +
     +set +e
    -+"$spatch" "$@" >"$out" 2>"$err"
    ++"$spatch" "$@" >"$out" 2>>"$err"
     +ret=$?
    ++cat "$out"
    ++cat "$err" >&2
     +set -e
     +
    -+if test $ret = 0 && ! test -s "$out" && ! test  -s "$err"
    ++nocache=
    ++if test $ret != 0
    ++then
    ++	nocache="exited non-zero: $ret"
    ++elif test -s "$out"
    ++then
    ++	nocache="had patch output"
    ++elif test -z "$cacheWhenStderr" && test -s "$err"
    ++then
    ++	nocache="had stderr (use --very-quiet or spatchCache.cacheWhenStderr=true?)"
    ++fi
    ++
    ++if test -n "$nocache"
     +then
    -+	rm -f "$out" "$err"
    ++	trace_it "$0: NOCACHE ($nocache): for '$arg_file' with '$arg_sp'"
    ++	exit "$ret"
    ++fi
     +
    -+	trace_it "$0: SET: for '$arg_file' with '$arg_sp'"
    ++trace_it "$0: SET: for '$arg_file' with '$arg_sp'"
     +
    -+	setret=
    -+	if test -z "$set"
    ++setret=
    ++if test -z "$set"
    ++then
    ++	if test $(redis-cli SADD spatch-cache "$sum") = 1
     +	then
    -+		if test $(redis-cli SADD spatch-cache "$sum") = 1
    -+		then
    -+			setret=0
    -+		else
    -+			setret=1
    -+		fi
    ++		setret=0
     +	else
    -+		"$set" "$sum"
    -+		setret=$?
    -+	fi
    -+
    -+	if test "$setret" != 0
    -+	then
    -+		echo "FAILED to set '$sum' in cache!" >&2
    -+		exit 128
    ++		setret=1
     +	fi
     +else
    -+	trace_it "$0: NOCACHE (have changes): for '$arg_file' with '$arg_sp'"
    -+	cat "$out"
    -+	cat "$err" >&2
    -+	rm -f "$out" "$err"
    -+	exit "$ret"
    ++	"$set" "$sum"
    ++	setret=$?
     +fi
    -+rm -f "$out" "$err"
    ++
    ++if test "$setret" != 0
    ++then
    ++	echo "FAILED to set '$sum' in cache!" >&2
    ++	exit 128
    ++fi
    ++
    ++exit "$ret"
-- 
2.38.0.1092.g8c0298861b0

