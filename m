Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835ACC433FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68611610E9
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347167AbhIGVby (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244484AbhIGVbx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:31:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF81C061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:30:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so326507wms.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+o/dSLeUuLnPpyUgetinV376x2mUNqO11nNn6UeuBHs=;
        b=c6BawEUk7Lktm7Ib1R+RDblYqLu8o02ct7CkVcnxSIEj4JC/P0pBopaFl7RKE150Yj
         uB60AXDBKzebR2O1pkqf2bp0ZNtgMRNU0VN7mhyNn9zm/FmrWJDKe49N9WhIjazZOyko
         1TLuPfTBwHDsg3hu6t8B27+VzjKDN1LPRn56AIAjNQ5g9oezlCXuZVUWNKwfnaW+/yRp
         b73UvMLaudTM3wlXUL1poPe5i+ftHMIQDqRlRfreIbqQmnBXcHZrttxhmuJEOjUXvP7Z
         QAPdv/zqhgXgKfwLI57X7tuOAwR8/agyGapcdjkG3UeSTH5YyQx3p1+rRjX8SZaDEF5Z
         5efA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+o/dSLeUuLnPpyUgetinV376x2mUNqO11nNn6UeuBHs=;
        b=Gid24XwA7laFMR4bhCGcwsuOxK4Wyycxt+NRewJZXjmpHHDz3eShF/Uwfmat+5kGc0
         UmLOfBWEDkaYaRxGG4mWSJ8Y7YP6qQDFF/Qv99H7HBJWgu+GouFgDF95kyW2S4yVjbi7
         +LGaAM8B5QHDCFrTHkDXS4Q+kXqG/ItJ4COPZagcOQSJXM7kBkK2MawP5bGeB4nVAa0W
         Fr4pmf5OEQlBrGaGuSQ4v0Vvs11079G5Cv998Yv6JI783Gk9btOkRlJFoHWbFntt+2WM
         ju8ODLmYVtube3H5U8WfguJ1W3+uKJrXqAu1P5/BoyX3DFEcrvuFNlMfHxaNCC6UQczS
         M9nQ==
X-Gm-Message-State: AOAM530sYuMHWSHqs5blbL5ylYcj+nNQrN2nPfWnFAYWOq7QnuDimPdW
        7PWy3vaw/nNi211/SyBO6NCCQYyHKU9YqQ==
X-Google-Smtp-Source: ABdhPJyXj1TYNCp+SCsci92uInh+MQ2OMoH92N30U5Bu+mAi3KOeezvNq5GsvoRPuAZ2VudSajxK6A==
X-Received: by 2002:a05:600c:898:: with SMTP id l24mr257868wmp.90.1631050244392;
        Tue, 07 Sep 2021 14:30:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g11sm155734wrx.30.2021.09.07.14.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:30:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 1/3] Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
Date:   Tue,  7 Sep 2021 23:30:37 +0200
Message-Id: <patch-v5-1.3-bdfe2279271-20210907T212626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.819.g59feb45f5e0
In-Reply-To: <cover-v5-0.3-00000000000-20210907T212626Z-avarab@gmail.com>
References: <cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com> <cover-v5-0.3-00000000000-20210907T212626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When SANITIZE=leak is specified we'll now add a SANITIZE_LEAK flag to
GIT-BUILD-OPTIONS, this can then be picked up by the test-lib.sh,
which sets a SANITIZE_LEAK prerequisite.

We can then skip specific tests that are known to fail under
SANITIZE=leak, add one such annotation to t0004-unwritable.sh, which
now passes under SANITIZE=leak.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile              | 5 +++++
 t/t0004-unwritable.sh | 2 +-
 t/test-lib.sh         | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 429c276058d..34c12ea6e6f 100644
--- a/Makefile
+++ b/Makefile
@@ -1221,6 +1221,9 @@ PTHREAD_CFLAGS =
 SPARSE_FLAGS ?=
 SP_EXTRA_FLAGS = -Wno-universal-initializer
 
+# For informing GIT-BUILD-OPTIONS of the SANITIZE=leak target
+SANITIZE_LEAK =
+
 # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
@@ -1265,6 +1268,7 @@ BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
 endif
 ifneq ($(filter leak,$(SANITIZERS)),)
 BASIC_CFLAGS += -DSUPPRESS_ANNOTATED_LEAKS
+SANITIZE_LEAK = YesCompiledWithIt
 endif
 ifneq ($(filter address,$(SANITIZERS)),)
 NO_REGEX = NeededForASAN
@@ -2812,6 +2816,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
 	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
 	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
+	@echo SANITIZE_LEAK=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_LEAK)))'\' >>$@+
 	@echo X=\'$(X)\' >>$@+
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index e3137d638ee..fbdcb926b3a 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -21,7 +21,7 @@ test_expect_success POSIXPERM,SANITY 'write-tree should notice unwritable reposi
 	test_must_fail git write-tree
 '
 
-test_expect_success POSIXPERM,SANITY 'commit should notice unwritable repository' '
+test_expect_success POSIXPERM,SANITY,!SANITIZE_LEAK 'commit should notice unwritable repository' '
 	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
 	chmod a-w .git/objects .git/objects/?? &&
 	test_must_fail git commit -m second
diff --git a/t/test-lib.sh b/t/test-lib.sh
index abcfbed6d61..4ab18914a3d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1533,6 +1533,7 @@ test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -n "$USE_LIBPCRE2" && test_set_prereq PCRE
 test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
+test -n "$SANITIZE_LEAK" && test_set_prereq SANITIZE_LEAK
 
 if test -z "$GIT_TEST_CHECK_CACHE_TREE"
 then
-- 
2.33.0.819.g59feb45f5e0

