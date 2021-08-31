Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01DEC4320E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAD860FE6
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbhHaNgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbhHaNgo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:36:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA84EC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u16so27773733wrn.5
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=coVD9R/luMgosIRRbyMg0iC14HZfpu09sgVkGJXs0+s=;
        b=mxuX2+PPizSaw0lYIUKuEKl2HJi3pi8Uej8fauTCaYR+0twH3hty2PykUk3e/zYryn
         +WkUOVO8k14FNElKRQh77UWpY5Evvaqlu5Y4cHhnMpcdsE9eedoQJ6HMCiJnXd5ctiVw
         RUot3nHO8jvN13gUjRAJ/v9pJ9gfOzBu5n48J12yajr2DWda6bG6hiQfMk+BUFjKO0Vn
         IwalKRE+fh00xWQn7xu48td5ODpfjDhIaP5SMvKXQkJvZpVGyqwRKaObm8fIhvwvJyEP
         q0CZXptxFsC3UeDUwtvysvXYbxZSAer6VrRhQx9SG1e8n5HnKUrqfq4IXrNsySkP/DIk
         ugeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=coVD9R/luMgosIRRbyMg0iC14HZfpu09sgVkGJXs0+s=;
        b=RpFAgRjgCaRD//aA5rVIIcefDo16MYd2NfH0G39+RnNd4XQENBLKnkNbqCQ5Z5GB0/
         hCnEgO6JtdjTbv4W+o25f1P6HwIy3jgTluB3WQTpceoa5v2HY1R+IXI8geNikvh23iFI
         IR37o8ClJ0QgFv1QoUbHqf9DoeA5itz12hF1HPaUAYfqkvgeg+hZwZUDRBnrTUrls7+m
         toRqC3JSFRGgTCVNVO/EZPkLaQNQuKrONhueVapAYkwlYS9tmPxSeL2plulO3/13mMZr
         3F1nY3sk04PMlseEvFR8LtQvc+5QeM1MqnCgbKtPk+WTd61kYZBRM6CmTDKXaqcjNtuZ
         XdoQ==
X-Gm-Message-State: AOAM530gMLD0tXnPz8zEBT6ON9Z4aJN9o3rnL3DByFvbRpLIJcATbwsK
        HesQLnLzlV2rlcV7fM4oz/9a6RdQBnGUOg==
X-Google-Smtp-Source: ABdhPJxo7CtkX7AJjf2+hm8LDrNEdCxdQqPRD69f9hsxfRSBMpO9/PpD0ivt3XdNl8BJdxphMXbzZQ==
X-Received: by 2002:a5d:4591:: with SMTP id p17mr31574044wrq.57.1630416947081;
        Tue, 31 Aug 2021 06:35:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u27sm19073451wru.2.2021.08.31.06.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:35:46 -0700 (PDT)
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
Subject: [PATCH v3 1/8] Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
Date:   Tue, 31 Aug 2021 15:35:35 +0200
Message-Id: <patch-v3-1.8-85619728d41-20210831T132607Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.805.g739b16c2189
In-Reply-To: <cover-v3-0.8-00000000000-20210831T132607Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20210831T132607Z-avarab@gmail.com>
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
index d1feab008fc..005d647d46e 100644
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
2.33.0.805.g739b16c2189

