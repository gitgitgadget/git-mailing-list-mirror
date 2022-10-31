Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50D8FA3744
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 22:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJaW2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 18:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJaW2n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 18:28:43 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8D51088
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 15:28:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id f5so11418703ejc.5
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 15:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXcGFeeALGqfOQbBxQbL1ElWCEfY5nfsUVD0emqRqZI=;
        b=EhYkt/kTc06sP5kzvAPpuex69m7GxKGtml4phk3qRt2UXtouawFts8aqNMpv3zldHB
         R+w4Yy0WQEUMd/cH1FyNkPSPmRxRrvJAUMoxwrP+N0F4ToG8dsdhevS/W/+C5CfNndwS
         CwnmpQbSqKiCwx2+2hESm0ALbDmN5K3RpqzQfpD+4gqnS5GwCMRDI5AAcCT4RP+GEvNX
         Yhi7On5M0JVqo0EyMUmaI4GMPc6KREVLxbN1UCfNiWNxfBWbBTjvZ/cgYLMsQyaVrvZS
         3fxtdcleERgoR3tq4X4nF5cAS3T6L75wFwPQ7YQPwAJUafhQz2zu19+807ntZdrebsTX
         3UYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXcGFeeALGqfOQbBxQbL1ElWCEfY5nfsUVD0emqRqZI=;
        b=zVB3w42O3NgM2EWyYn2nWvixGdp6sy7gyqdLR10YXz91BKfD+vcvmL+2qKgjGiAMTJ
         bSSjPXxI6Lx/Bj+P65jT0s+ELvRm7iXqKygJCMDhMCmIqo+pdZ7Q/6Sewl85mI8r+0CL
         /l3uLwAcbxexhh8nSKVdq/0oXjGu0jlnxQCwo2EJAwvNXlxOGg2TvUNr+HDDQ/YPm8cs
         Od0oTuIyHLZSwWfToj2lTNcRmQr/lcihhkcYg4tK/8avQSn4jewYw9r05LvcFSrHgIvM
         Z6zMfJ/DyZxEMs/1dt+rhsHgxBMaXMsQkPvwDuMDZD4JVJBeCdtW/99nm8PgA3FYDdyM
         FFOQ==
X-Gm-Message-State: ACrzQf35ZH3dlAoRqvE0vdvagSEV/MN7zJUP4Jc5fAZTiMvfZcPDYO0x
        p9/jo54WE4uumWpQdinWl/21S3eGCuNjcg==
X-Google-Smtp-Source: AMsMyM43YjYBS1p581tgSK7aPQVJ7mvDT1oZ0+eUyxZQlf9+9uQ6Qg3eZ0foNU1ZPc/kKyZ9vizf7w==
X-Received: by 2002:a17:907:72d3:b0:791:a4fa:c4ac with SMTP id du19-20020a17090772d300b00791a4fac4acmr15242593ejc.391.1667255319693;
        Mon, 31 Oct 2022 15:28:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a14-20020a1709066d4e00b00781e7d364ebsm3503668ejt.144.2022.10.31.15.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 15:28:39 -0700 (PDT)
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
Subject: [PATCH v3 2/4] Makefile: define "TEST_{PROGRAM,OBJS}" variables earlier
Date:   Mon, 31 Oct 2022 23:28:07 +0100
Message-Id: <patch-v3-2.4-b95c296b6de-20221031T222249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v3-0.4-00000000000-20221031T222249Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com> <cover-v3-0.4-00000000000-20221031T222249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Define the variables that make up TEST_OBJS earlier, and don't go back
& forth in their definition. Before we'd first append $X to
$(TEST_PROGRAMS), and then substitute $X back out of it to define
$(TEST_OBJS). Let's instead add a new $(TEST_PROGRAM_OBJS) variable,
which avoids this needless back & forth substitution.

See daa99a91729 (Makefile: make sure test helpers are rebuilt when
headers change, 2010-01-26) for how we ended up with the original
$(TEST_OBJS).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 679c24377f4..911cce6d487 100644
--- a/Makefile
+++ b/Makefile
@@ -617,7 +617,8 @@ SCRIPT_PYTHON =
 SCRIPT_SH =
 SCRIPT_LIB =
 TEST_BUILTINS_OBJS =
-TEST_OBJS =
+TEST_PROGRAMS =
+TEST_PROGRAM_OBJS =
 TEST_PROGRAMS_NEED_X =
 THIRD_PARTY_SOURCES =
 
@@ -796,6 +797,7 @@ TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-windows-named-pipe.o
 TEST_BUILTINS_OBJS += test-write-cache.o
 TEST_BUILTINS_OBJS += test-xml-encode.o
+TEST_PROGRAM_OBJS += $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
 # Do not add more tests here unless they have extra dependencies. Add
 # them in TEST_BUILTINS_OBJS above.
@@ -803,6 +805,9 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-tool
 
 TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
+all:: $(TEST_PROGRAMS)
+TEST_PROGRAM_OBJS += $(patsubst %,t/helper/%.o,$(TEST_PROGRAMS_NEED_X))
+.PRECIOUS: $(TEST_PROGRAM_OBJS)
 
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin/$C.o but is linked in as part of some other command.
@@ -2546,10 +2551,8 @@ REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
 REFTABLE_TEST_OBJS += reftable/tree_test.o
 
-TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
-
 .PHONY: test-objs
-test-objs: $(TEST_OBJS)
+test-objs: $(TEST_PROGRAM_OBJS)
 
 GIT_OBJS += $(LIB_OBJS)
 GIT_OBJS += $(BUILTIN_OBJS)
@@ -2565,7 +2568,7 @@ scalar-objs: $(SCALAR_OBJS)
 OBJECTS += $(GIT_OBJS)
 OBJECTS += $(SCALAR_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
-OBJECTS += $(TEST_OBJS)
+OBJECTS += $(TEST_PROGRAM_OBJS)
 OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
@@ -3065,7 +3068,7 @@ endif
 
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
-all:: $(TEST_PROGRAMS) $(test_bindir_programs)
+all:: $(test_bindir_programs)
 
 bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
@@ -3091,8 +3094,6 @@ perf: all
 
 .PHONY: test perf
 
-.PRECIOUS: $(TEST_OBJS)
-
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
 t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
-- 
2.38.0.1280.g8136eb6fab2

