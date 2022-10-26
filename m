Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF876C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbiJZOmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiJZOmm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:42:42 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D52D10043D
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:42:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so1739924wmq.4
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=An4+CAvgLQfNQMBhYk+Fp3+6gtJzwv5lPiP54wa8t3o=;
        b=CFrvqcOIVT4ZGmnD+H6gbJnddtkiNdhOnP2BxYrORObgGV45OQ4J/UPRGscBsNyo84
         HvfQqPGlziH64fBve3G4SEennjtKh8jqwQA2aBR/IeepcTWx5MLdOuKSmX2CxNwqfreN
         0SW4xAacv7dfkR4ATAnEPZaJYNkb4nMEpRQ9bPknNQt2VcEdpu2os6dWxc4CR5UcLD0n
         FON+pom6clZZ71329Jdd0kc8JEnE0Ny1E1lKfaaV6cmwnG4oyZszmJxi/0KApUa1Pz6f
         1aUBc8pdBrfp9axLUi/QAThjrYnbTFvXq9FgSklKa66ZYSppfq/luV7GP3yuAVC5U0tX
         00jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=An4+CAvgLQfNQMBhYk+Fp3+6gtJzwv5lPiP54wa8t3o=;
        b=sVkqGGxhR3ynsy62076QOk9cLUmSMODm4Xvr0uaAJELd3CPgQbCiQcq6nQVDVXHHSw
         6FgzN0aH+xybL+F5MxzpiAITj1i+w06MV7Dw3fuW4wq/2L6L2AB2Wlgyyi8CiFMEmwdJ
         Fm3PGF7SmP1BWftJFz38qyo94vZ0yAy4nDuRePUAKeV3cwqFr0v5p9B+ypzUlS/tF6vY
         AQ3LsilQkHuJkrjMmImSjEc0F1Gv4DbP/O0fKOEBNqrlnx3cfA9UW6zDClTu5MLRzV9E
         NdOAGcUiL73bv7pV5+EaqyRNENmMoZ79VFCDYwSJGd3PGRYx58M20CIpm1zLy4dgwWia
         cLWg==
X-Gm-Message-State: ACrzQf1QL3bAKv5yaSeogVemT8byf61FzJ9uscVPP23axbXLMpscPI+h
        wFrzfS7t5OnaBBkJKwYEknhTKITprGf/qw==
X-Google-Smtp-Source: AMsMyM5tyiM2Bu4iQaKHvtuqLCeU2vQGELrB5FmOGEVtyqY1OFpuGHLo7+Yu/1MQiUfqcOpp3dQ8zA==
X-Received: by 2002:a05:600c:198d:b0:3c9:a5e8:add6 with SMTP id t13-20020a05600c198d00b003c9a5e8add6mr2788318wmq.110.1666795359686;
        Wed, 26 Oct 2022 07:42:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c304500b003a84375d0d1sm1934367wmh.44.2022.10.26.07.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:42:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] Makefile: fix issues with bin-wrappers/% rule
Date:   Wed, 26 Oct 2022 16:42:34 +0200
Message-Id: <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This simple topic fixes issues with the bin-wrappers/% rules, as seen
in the range-diff below this never worked properly:

	make bin-wrappers/git

I.e. we'd make the scirpt, but not "git".

I originally sent this as [1] in response to a topic that's since
landed, i.e. that topic needed to add more conditions to the "match
this, but not that" part of the current rule.

As 3/3 notes that's because we were previously squashing 3 Makefile
variables into one, and then having to heurisitcally match their
contents to figure out which item originally came from which variable.

The 3/3 here simply avoids squashing all that data together, so we
don't need to guess after the fact.

For the v2 I squashed the previous 3 commits together, they were
incrementally improving the rule, now we do it all at once.

1. https://lore.kernel.org/git/cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (3):
  Makefile: factor sed-powered '#!/bin/sh' munging into a variable
  Makefile: define "TEST_{PROGRAM,OBJS}" variables earlier
  Makefile: simplify $(test_bindir_programs) rule by splitting it up

 Makefile | 67 ++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 19 deletions(-)

Range-diff against v1:
1:  40033143cdd = 1:  fc6c5a6a8df Makefile: factor sed-powered '#!/bin/sh' munging into a variable
2:  fe54dacaad2 = 2:  6dcb49f25c4 Makefile: define "TEST_{PROGRAM,OBJS}" variables earlier
3:  9d4ac628f0c ! 3:  400f487e30d Makefile: simplify $(test_bindir_programs) rule by splitting it up
    @@ Commit message
         Which will show an empty diff, i.e. we've correctly dealt with the
         combination of $(SHELL_PATH), $(X) and these three variables here.
     
    +    This also fixes an issue with the "bin-wrappers/" scripts have never had properly declared
    +    dependency information, i.e. this has never worked:
    +
    +            make clean &&
    +            make bin-wrappers/git &&
    +            # the script is there, but no "./git" is built
    +            ./bin-wrappers/git
    +
    +    There was no reason not to have that work, just as most things
    +    generated by the Makefile have proper dependency information.
    +
    +    Before this commit doing this would have been painful, but now it's
    +    easy to pass this as a parameter to our "bin_wrappers_template"
    +
         1. ea925196f1b (build dashless "bin-wrappers" directory similar to
            installed bindir, 2009-12-02)
         2. e6e7530d10b (test helpers: move test-* to t/helper/ subdirectory,
    @@ Makefile: GIT-PYTHON-VARS: FORCE
     +endef
      
     -all:: $(test_bindir_programs)
    -+BW_BINDIR_PROGRAMS_NEED_X = $(BINDIR_PROGRAMS_NEED_X:%=bin-wrappers/%)
    -+BIN_WRAPPERS += $(BW_BINDIR_PROGRAMS_NEED_X)
    -+$(BW_BINDIR_PROGRAMS_NEED_X): wrap-for-bin.sh
    -+	$(call mkdir_p_parent_template)
    -+	$(QUIET_GEN)$(call cmd_munge_bin_wrappers_script,$(@F),,$X)
    ++define bin_wrappers_template
    ++
    ++## bin_wrappers_template
    ++# 1 = $(1)
    ++# 2 = $(2)
    ++# 3 = $(3)
    ++# 4 = $(4)
    ++BW_$(1) = $$($(1):%=bin-wrappers/%)
    ++BIN_WRAPPERS += $$(BW_$(1))
    ++all:: $$(BW_$(1))
    ++$$(BW_$(1)): bin-wrappers/% : $(3)%$(4)
    ++$$(BW_$(1)): wrap-for-bin.sh
    ++	$$(call mkdir_p_parent_template)
    ++	$$(QUIET_GEN)$$(call cmd_munge_bin_wrappers_script,$(2),$(3),$(4))
    ++endef
      
     -bin-wrappers/%: wrap-for-bin.sh
    -+BW_BINDIR_PROGRAMS_NO_X = $(BINDIR_PROGRAMS_NO_X:%=bin-wrappers/%)
    -+BIN_WRAPPERS += $(BW_BINDIR_PROGRAMS_NO_X)
    -+$(BW_BINDIR_PROGRAMS_NO_X): wrap-for-bin.sh
    - 	$(call mkdir_p_parent_template)
    +-	$(call mkdir_p_parent_template)
     -	$(QUIET_GEN)sed -e $(call cmd_munge_script_sed_shell_path_arg) \
     -	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
     -	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
     -	chmod +x $@
    -+	$(QUIET_GEN)$(call cmd_munge_bin_wrappers_script,$(@F))
    -+
    -+BW_TEST_PROGRAMS_NEED_X = $(TEST_PROGRAMS_NEED_X:%=bin-wrappers/%)
    -+BIN_WRAPPERS += $(BW_TEST_PROGRAMS_NEED_X)
    -+$(BW_TEST_PROGRAMS_NEED_X): wrap-for-bin.sh
    -+	$(call mkdir_p_parent_template)
    -+	$(QUIET_GEN)$(call cmd_munge_bin_wrappers_script,$(@F),t/helper/,$X)
    ++define bin_wrappers_templates
    ++$(call bin_wrappers_template,BINDIR_PROGRAMS_NEED_X,'$$(@F)',,$$X)
    ++$(call bin_wrappers_template,BINDIR_PROGRAMS_NO_X,'$$(@F)')
    ++$(call bin_wrappers_template,TEST_PROGRAMS_NEED_X,'$$(@F)',t/helper/,$$X)
    ++endef
    ++$(eval $(call bin_wrappers_templates))
     +
     +all:: $(BIN_WRAPPERS)
      
4:  cbbf458433f < -:  ----------- Makefile: define bin-wrappers/% rules with a template
5:  560dee80b4a < -:  ----------- Makefile: fix "make clean && make bin-wrappers/$NAME" dependencies
-- 
2.38.0.1251.g3eefdfb5e7a

