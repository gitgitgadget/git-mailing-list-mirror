Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C35CECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 22:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJaW2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 18:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJaW2l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 18:28:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D296F3F
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 15:28:39 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q9so33049951ejd.0
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 15:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/ZbTOsMY7dk2EtvvoYT6nXK3sjzCn4Zq0CV2l/qkoU=;
        b=qB8jXYidV0sjVIOyngYM9i13Tbui5FE74v0yu11V3O2M9oT57TLYnWjog49mQIMTjE
         NQpV3b3ru8GQmREo5GyimnxF0iGc5RsBzOMVuAx0AvcUiv0T+Q5x741/fFic7C8HYja2
         NXGKmdtsjWTj/Uzzg26GwY/+1qhRLmlzn/lpo8lY53CXvZk1BdpU4Tjhcb6DCFMWs2Ta
         qanvg+B9sXAxXaiJHMkUigJX06OSjjgAdcJdGhyUkresAyThmD9dwkDfjiehZJ+EBSfD
         lLB1ltSPmjQw8HZd+4B7K6KHqQnxcCMzY6VVP2bPrLc4LojvTa9irMPZdFCGBVnOuY29
         lCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/ZbTOsMY7dk2EtvvoYT6nXK3sjzCn4Zq0CV2l/qkoU=;
        b=Kh8h2WHQpTQpCGiFuNvlblu2Qo2z77oVibJFeqaHrXEAzZOs/XPlqH3MK2tsHzrxwI
         kJiygjBxkBeztHki0BKtW/akXJMAA63TpyLtzGtTwTBeUgoIPIOaZ+J1LH158xVg59kz
         taur3Y5+rnpjt1+PSA/74jn5CRG06pX8Z0lYcNLXz9xUiIp82YbujgQh2kipwEHlg9Cp
         A19XqY4px70k1iAejUBe6Jpzey+7aIKFWvRk1TVtmhoRV7nYLSxmn72OYWldhKL8/VEX
         n7xd25+rLi6j8xiAh8uwb4P98EjrOq/9q2MLMeVc4P4HFEwi/oG0dJP9zW8n8z2ZpjUs
         MqOg==
X-Gm-Message-State: ACrzQf3zhnN4wOd2UrcKOZdreRVX94ADRHJzprWk1CzKlpIzN+eqeNK/
        rXwSTB6oie1MHnc9iG5PdSvL6PjbPbyz3g==
X-Google-Smtp-Source: AMsMyM4QKbqbgTHbcRW5LOiVmOYIQsD0ucrwDJ+/Bz4XjAYJngIU9334efLzNUoHFhAPn08jWoT0IA==
X-Received: by 2002:a17:906:9f1b:b0:7ad:c66e:ad7d with SMTP id fy27-20020a1709069f1b00b007adc66ead7dmr9435050ejc.432.1667255317631;
        Mon, 31 Oct 2022 15:28:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a14-20020a1709066d4e00b00781e7d364ebsm3503668ejt.144.2022.10.31.15.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 15:28:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/4] Makefile: untangle bin-wrappers/% rule complexity
Date:   Mon, 31 Oct 2022 23:28:05 +0100
Message-Id: <cover-v3-0.4-00000000000-20221031T222249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series untangles the gnarly rule we use to generate
bin-wrappers/%.

It's now complex because we generate it from 3x separate variables,
and then end up having to do inline pattern matching to decide which
value comes from where.

Instead, we can avoid squashing those values together, so we don't
have to guess.

See[1] for the v2. This hopefully addresses all outstanding
issues/points that were raised. An added 3/4 here makes the eventual
4/4 smaler.

1. https://lore.kernel.org/git/cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (4):
  Makefile: factor sed-powered '#!/bin/sh' munging into a variable
  Makefile: define "TEST_{PROGRAM,OBJS}" variables earlier
  Makefile: rename "test_bindir_programs" variable, pre-declare
  Makefile: simplify $(test_bindir_programs) rule by splitting it up

 Makefile | 70 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 19 deletions(-)

Range-diff against v2:
1:  fc6c5a6a8df = 1:  c9ce5b78a3a Makefile: factor sed-powered '#!/bin/sh' munging into a variable
2:  6dcb49f25c4 = 2:  b95c296b6de Makefile: define "TEST_{PROGRAM,OBJS}" variables earlier
-:  ----------- > 3:  fea93c45898 Makefile: rename "test_bindir_programs" variable, pre-declare
3:  400f487e30d ! 4:  0ff09495476 Makefile: simplify $(test_bindir_programs) rule by splitting it up
    @@ Commit message
         Which will show an empty diff, i.e. we've correctly dealt with the
         combination of $(SHELL_PATH), $(X) and these three variables here.
     
    -    This also fixes an issue with the "bin-wrappers/" scripts have never had properly declared
    -    dependency information, i.e. this has never worked:
    +    This also fixes an issue with the "bin-wrappers/" scripts have never
    +    had properly declared dependency information, i.e. this has never
    +    worked:
     
                 make clean &&
                 make bin-wrappers/git &&
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    -@@ Makefile: export TCL_PATH TCLTK_PATH
    - PTHREAD_LIBS = -lpthread
    - 
    - # Guard against environment variables
    -+BIN_WRAPPERS =
    - BUILTIN_OBJS =
    - BUILT_INS =
    - COMPAT_CFLAGS =
     @@ Makefile: GIT-PYTHON-VARS: FORCE
                  fi
      endif
      
    --test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
    +-BIN_WRAPPERS = $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
     +define cmd_munge_bin_wrappers_script
     +sed \
     +	-e $(call cmd_munge_script_sed_shell_path_arg) \
    @@ Makefile: GIT-PYTHON-VARS: FORCE
     +	chmod +x $@
     +endef
      
    --all:: $(test_bindir_programs)
    +-all:: $(BIN_WRAPPERS)
     +define bin_wrappers_template
     +
    -+## bin_wrappers_template
    -+# 1 = $(1)
    -+# 2 = $(2)
    -+# 3 = $(3)
    -+# 4 = $(4)
    ++### bin_wrappers_template; Parameters:
    ++## E.g. "BINDIR_PROGRAMS_NEED_X": Variable reference
    ++# 1='$(1)'
    ++## E.g. "$(@F)": Passed as $$(1)) to "cmd_munge_bin_wrappers_script"
    ++# 2='$(2)'
    ++## E.g. "" or "t/helper": Directory prefix for the wrapped binary
    ++# 3='$(3)'
    ++## E.g. "" or "$$X": If $$X: wrapped binary needs X=.exe (for Windows)
    ++# 4='$(4)'
     +BW_$(1) = $$($(1):%=bin-wrappers/%)
     +BIN_WRAPPERS += $$(BW_$(1))
    -+all:: $$(BW_$(1))
     +$$(BW_$(1)): bin-wrappers/% : $(3)%$(4)
     +$$(BW_$(1)): wrap-for-bin.sh
     +	$$(call mkdir_p_parent_template)
    @@ Makefile: GIT-PYTHON-VARS: FORCE
      
      # GNU make supports exporting all variables by "export" without parameters.
      # However, the environment gets quite big, and some programs have problems
    -@@ Makefile: OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll)
    - endif
    - 
    - artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
    --		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
    -+		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(BIN_WRAPPERS) \
    - 		$(MOFILES)
    - 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
    - 		SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
-- 
2.38.0.1280.g8136eb6fab2

