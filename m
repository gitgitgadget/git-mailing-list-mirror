Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96490ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 13:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiIANUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 09:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiIANTo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 09:19:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC20DBEE
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 06:17:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c131-20020a1c3589000000b003a84b160addso651254wma.2
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 06:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mEuL32NTD1basEnOTim73o2mXI50i6Fg0n7iS/Sgbi4=;
        b=JF7VJwdigajhvpNSD9Lwzh2YpEuDAFWRtcpr4pwdUbZgfljF3wxHGRTnvQmKES3cQX
         5llwSPxL1H7aF+DLwl06DgCsjLoiQKxO48S7wrTvfJ52kxBvcfhctm0YAkAVUZTU7CBf
         TcIOVOOKQIfufFEIEzhGveEJrXyANXuaWd35vbVcMMsAbXA8u37O77SpUkoYlS8JCgvT
         op2FyHo/vMriwvylz1+jlX9jxdAG3nVZMpgFQM2BUZPSLKu4HJMMSZ5lZ1NEqz9eUTIp
         fxUg712tIHIxusSaZa+G++HK+XIWiJ3yu7IRKLFWdHMJvfnzAnBQjRLUETJza2d+UxPW
         9cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mEuL32NTD1basEnOTim73o2mXI50i6Fg0n7iS/Sgbi4=;
        b=a1dePikqd5+8Nr9rf7lAT3uoV1AKCCVkiD2h514Ym+CLCfONEiA3L23UduXVNcXHrh
         YivnMfi2my9K001Vk2VBWozLOSyYBprJE07rGvI9lbIApCzpQv5hDTuwSMCrzL+fMgrH
         w/2KHhlwH8C/S34bAo9Sdif7mXQtki7/T0MJVlXanh2gcOA0GmjDQ3iGxRCFdqv+eVJU
         1FreQGlQrYEIDngcfJnL3k9xOorHscUSw4GApgIrvekvEDy7mXK9vDpeeLGS+tP3e2FU
         Tj/C0tITkr9zF1FN9q52yBqRLUCYbqA05P7M7ICmboXUSDwxGXweqwSUnAsgYGx2uJ+p
         ffBw==
X-Gm-Message-State: ACgBeo3FomEWlwzhh4IH9ADMKB5BaHxCvQZEgbUmp6jT7wyT8+nJwIbY
        rbLnER9+gWiLtXDqVWAnb+q5oUJr6I4vtw==
X-Google-Smtp-Source: AA6agR4BHTloN5EMP0SwzHci41A5piRXPxjISCro9HmhNeI8vAwGRpjZXg4PJElYRP2KFoJIr5NyUQ==
X-Received: by 2002:a05:600c:3514:b0:3a5:dc71:d9c4 with SMTP id h20-20020a05600c351400b003a5dc71d9c4mr5266527wmq.42.1662038253075;
        Thu, 01 Sep 2022 06:17:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b00225239d9265sm14816089wrs.74.2022.09.01.06.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 06:17:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] Makefile: define "TEST_{PROGRAM,OBJS}" variables earlier
Date:   Thu,  1 Sep 2022 15:17:25 +0200
Message-Id: <patch-2.5-eeae7ac4ddc-20220901T130817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1426.g360dd7cf8ca
In-Reply-To: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
References: <sso99so6-n28s-rq86-8q20-4456r3pn869r@tzk.qr> <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
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
index b2304aa93a3..0d6b2caa7d9 100644
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
 
@@ -794,6 +795,7 @@ TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-windows-named-pipe.o
 TEST_BUILTINS_OBJS += test-write-cache.o
 TEST_BUILTINS_OBJS += test-xml-encode.o
+TEST_PROGRAM_OBJS += $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
 # Do not add more tests here unless they have extra dependencies. Add
 # them in TEST_BUILTINS_OBJS above.
@@ -801,6 +803,9 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-tool
 
 TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
+all:: $(TEST_PROGRAMS)
+TEST_PROGRAM_OBJS += $(patsubst %,t/helper/%.o,$(TEST_PROGRAMS_NEED_X))
+.PRECIOUS: $(TEST_PROGRAM_OBJS)
 
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin/$C.o but is linked in as part of some other command.
@@ -2537,10 +2542,8 @@ REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
 REFTABLE_TEST_OBJS += reftable/tree_test.o
 
-TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
-
 .PHONY: test-objs
-test-objs: $(TEST_OBJS)
+test-objs: $(TEST_PROGRAM_OBJS)
 
 GIT_OBJS += $(LIB_OBJS)
 GIT_OBJS += $(BUILTIN_OBJS)
@@ -2551,7 +2554,7 @@ git-objs: $(GIT_OBJS)
 
 OBJECTS += $(GIT_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
-OBJECTS += $(TEST_OBJS)
+OBJECTS += $(TEST_PROGRAM_OBJS)
 OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
@@ -3060,7 +3063,7 @@ endif
 
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
-all:: $(TEST_PROGRAMS) $(test_bindir_programs)
+all:: $(test_bindir_programs)
 
 bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
@@ -3086,8 +3089,6 @@ perf: all
 
 .PHONY: test perf
 
-.PRECIOUS: $(TEST_OBJS)
-
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
 t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
-- 
2.37.3.1426.g360dd7cf8ca

