Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E01DECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 22:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJaW2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 18:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJaW2n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 18:28:43 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BED51093
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 15:28:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f7so13763812edc.6
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 15:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp8LNHtK6ECRC+itXEipWDjDGnB6C5m4j2BS6dEmZLQ=;
        b=g54EX7rbUZY/PMze3XOF6bBHXQkMKOBwEzaxyJEe5cc82dh9llnUfuPbJWvGCuX1aH
         Mq4puPle/S7sDXcPdQdteleZqzYEX9p4nhxk/iCaCrC8NL0voDAUJlaqib4jLFdW971a
         777DhQG/cHG9ypfiKWD0zbT4BgJ/Fd4ZS0Cv63YRrrdFOIPU8E2ZMQT+0xmMsknFeJ90
         3A9jdL7IpjXJrrV5ZDnVm1VAS7aKN1MeOeE2HRcmLQEELkbfivvCzpUgJAgA8/TFFFGf
         PUdMRLwepMSNWRfsPhfoS3xHGgk0CPu1Lk8Pu4KhbLzoC9Zj8r2ba4AQmwSxVt0knuuz
         w6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fp8LNHtK6ECRC+itXEipWDjDGnB6C5m4j2BS6dEmZLQ=;
        b=O7KBDFQYh5Vgt/gIVfThJD8kasgfPVW8MEm659fg84yrJvT6EJM6klC50TSMiuYS3/
         H4LCARKltn6u36nBAjGItupv0rcih3WdpJoQ8V6Tfs52uw2bRUbCk+TgB/WI2ubbPtqk
         f0G+8Kx/yk2Yn4/xCg36e2o3cRNj2VvhHwwYkRhZLXlUCMr5bynDEcX3C26qrL1A9kDr
         V7mtnD6NczkQdM22CcG0chFBiJGxAwpeS9J6jGMSLipPOJa+IdKxX4MW9XQFBMbRO9IU
         dk4mN/MaL/3ipShry+0TJUZIHE5aRGAi3fUDGAkrmr7X0IFzs6bo+vamU35gFRvEHVbx
         o5ZA==
X-Gm-Message-State: ACrzQf1KWfwQXXdIyCUzbV25pnlWeKN+eRo7/AD2k9P2yK6A9LHdh2JA
        OOUpRTCgu6obLdLEeC1bgYuFGsH9uUOQ+Q==
X-Google-Smtp-Source: AMsMyM7ElGhogoAcmY5FNswYXgNv/yRSSNjWpPPvLqDppjT+5+heXGpp0vVuF+AypM6Yer39BgAHTw==
X-Received: by 2002:a05:6402:26ca:b0:462:7f27:a0dd with SMTP id x10-20020a05640226ca00b004627f27a0ddmr15871629edd.132.1667255320732;
        Mon, 31 Oct 2022 15:28:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a14-20020a1709066d4e00b00781e7d364ebsm3503668ejt.144.2022.10.31.15.28.39
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
Subject: [PATCH v3 3/4] Makefile: rename "test_bindir_programs" variable, pre-declare
Date:   Mon, 31 Oct 2022 23:28:08 +0100
Message-Id: <patch-v3-3.4-fea93c45898-20221031T222249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v3-0.4-00000000000-20221031T222249Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com> <cover-v3-0.4-00000000000-20221031T222249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pre-declare the "BIN-WRAPPERS" variable, renamed from
"test_bindir_programs", which is more in line with our usual naming
conventions in the Makefile.

There's also no reason to use a "simply expanded variable" here, so
let's use a normal "=" assignment. It doesn't make a difference in the
end as we're about to use to to define a rule, so it'll have
"IMMEDIATE" expansion here.

See ea925196f1b (build dashless "bin-wrappers" directory similar to
installed bindir, 2009-12-02) for the introduction of
"test_bindir_programs".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 911cce6d487..032654640c5 100644
--- a/Makefile
+++ b/Makefile
@@ -595,6 +595,7 @@ export TCL_PATH TCLTK_PATH
 PTHREAD_LIBS = -lpthread
 
 # Guard against environment variables
+BIN_WRAPPERS =
 BUILTIN_OBJS =
 BUILT_INS =
 COMPAT_CFLAGS =
@@ -3066,9 +3067,9 @@ GIT-PYTHON-VARS: FORCE
             fi
 endif
 
-test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
+BIN_WRAPPERS = $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
-all:: $(test_bindir_programs)
+all:: $(BIN_WRAPPERS)
 
 bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
@@ -3408,7 +3409,7 @@ OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll)
 endif
 
 artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
-		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
+		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(BIN_WRAPPERS) \
 		$(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
 		SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
-- 
2.38.0.1280.g8136eb6fab2

