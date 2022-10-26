Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C11C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiJZOnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbiJZOnH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:43:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8B11187A5
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:42:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a14so23927547wru.5
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUxGTWd1Un545/fc70fTUCDt1ggCym8VabP5HOMKLmk=;
        b=lL2NN5gsxWXGXMNjA/NbV1kT9RyeIRgN7uHcMj+JnlHtTG8U0raOHJYWOyRwrcj5Sp
         yhRBMhQfiWKEVZQaB788cIV583gppvewZIfqXmqRXmTdMz1voUAxdVzvwA2zohCsZTwH
         kvDxmgVac//f0tSc+4fakckvQqtqtAuh5dTvGy2HcgwlEOkOYgxfG75K6o5zK5zh9sdl
         u8uIBIL9MjK50EGaWy8EWEDpbVQEGE9it7YB6lEwdzm8vKEdHkW9+fpweZIfwKb4AN4A
         z+Mf6IvATwn0+4jpaQI2Bc1z2/thYf+ZKI7lFKQy1Wg0YABAHaQixIIVsTEGnsvYhb7v
         kMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUxGTWd1Un545/fc70fTUCDt1ggCym8VabP5HOMKLmk=;
        b=5FbppANqwQs5Nga8wH/CIAh4XQIcApLfatXPRVXMLOrfSckIIuYGczWQMYI7P0/Q2t
         HXnPUWkazB3zQU5pNGShQ0I8AeFR3w31Vi7hYqM+JwAJ48x7CUskwdUgfZjs6b0rOn+C
         DqHp/5CT1+atwhOv3Xg907R5ijMh56egeFdgjQmlkPx3F6/qa8Upg7aYCbIokJpbNKTX
         vKzdzX4+kxVio2UjdcQOec8tIDJY7uhGayi9/u9NsqI7DNiVaSrpaJKK77ixlL8zAmDv
         ca9ZnnoGPF/30h/qeAMI6IfAEv/uiGI2rFsDmjFqN0cQZujA+kevo/7qbxOvKPwk97is
         EDow==
X-Gm-Message-State: ACrzQf0tKI4UkIcW1o0zJgkQhODKqu+5ass+0SjpSk5WGHb2GVY0WLPW
        BK+LOlA3HxaFxfS5RJ4cBI50zgsY8xdx1Q==
X-Google-Smtp-Source: AMsMyM7cJ5c8oM+jn8g+/dSb/KBuI7LgCTV8ddbUaLdd8cAdIH8+XWBzKUQ4LJexuqdyXfvpbcxkNA==
X-Received: by 2002:a05:6000:18a5:b0:230:a3b:bc16 with SMTP id b5-20020a05600018a500b002300a3bbc16mr29226061wri.627.1666795363562;
        Wed, 26 Oct 2022 07:42:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c304500b003a84375d0d1sm1934367wmh.44.2022.10.26.07.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:42:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] Makefile: define "TEST_{PROGRAM,OBJS}" variables earlier
Date:   Wed, 26 Oct 2022 16:42:36 +0200
Message-Id: <patch-v2-2.3-6dcb49f25c4-20221026T143534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
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
index 45b22d33513..a8cfa096dc1 100644
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
 
@@ -795,6 +796,7 @@ TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-windows-named-pipe.o
 TEST_BUILTINS_OBJS += test-write-cache.o
 TEST_BUILTINS_OBJS += test-xml-encode.o
+TEST_PROGRAM_OBJS += $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
 # Do not add more tests here unless they have extra dependencies. Add
 # them in TEST_BUILTINS_OBJS above.
@@ -802,6 +804,9 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-tool
 
 TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
+all:: $(TEST_PROGRAMS)
+TEST_PROGRAM_OBJS += $(patsubst %,t/helper/%.o,$(TEST_PROGRAMS_NEED_X))
+.PRECIOUS: $(TEST_PROGRAM_OBJS)
 
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin/$C.o but is linked in as part of some other command.
@@ -2543,10 +2548,8 @@ REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
 REFTABLE_TEST_OBJS += reftable/tree_test.o
 
-TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
-
 .PHONY: test-objs
-test-objs: $(TEST_OBJS)
+test-objs: $(TEST_PROGRAM_OBJS)
 
 GIT_OBJS += $(LIB_OBJS)
 GIT_OBJS += $(BUILTIN_OBJS)
@@ -2562,7 +2565,7 @@ scalar-objs: $(SCALAR_OBJS)
 OBJECTS += $(GIT_OBJS)
 OBJECTS += $(SCALAR_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
-OBJECTS += $(TEST_OBJS)
+OBJECTS += $(TEST_PROGRAM_OBJS)
 OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
@@ -3061,7 +3064,7 @@ endif
 
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
-all:: $(TEST_PROGRAMS) $(test_bindir_programs)
+all:: $(test_bindir_programs)
 
 bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
@@ -3087,8 +3090,6 @@ perf: all
 
 .PHONY: test perf
 
-.PRECIOUS: $(TEST_OBJS)
-
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
 t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
-- 
2.38.0.1251.g3eefdfb5e7a

