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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A57C433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD7560F6B
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbhISIFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 04:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbhISIFa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 04:05:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0AEC061757
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:04:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u18so21095296wrg.5
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UmfaJNSmci79/WSANC9Fzd2DpGjfWml8a2d92qlzkTk=;
        b=QEtan+2dPsK6+5XGiOzBUJOQeJPrWg3CQGLFS/7HL2I9WKSX3c5JtvTeJ+2u61lvvK
         toocEOGBFY8gMb6CYOBRF1cjnWvbmotzwftyfn3cYkGXphcgRuhM57lO6d2haE8BTDFI
         nZiE6k38+BZBBKJJKVkRjRtLANbJS+06MRbAZGxVkWylzxBTHXt7E3dRyAfiTMh9LZD2
         Wrk+nGR3lVmwUZmPcylNjJN2W9gM6ku02CORxFbCa8ovKsQovP+ARxGiTDX4FCbltozp
         SQmdXc4eNzDtEXbGDDhQnC/V+xyO/t43ZTiesgHqpQd9urlnSOEJRNMJJtQ5yydlXynb
         CQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UmfaJNSmci79/WSANC9Fzd2DpGjfWml8a2d92qlzkTk=;
        b=5Ox8fA34mMog3XI5Nw+sV35/dNollAB5gYRuwhGFHQ/J9pOVjLYBbpMe2vsiz1oVb7
         ySmOsXmaVJaCeRTMXQK34UUDkGH1/J5LFaJDtCe9DjQp0XLozdbd3lHZlqGfftRCGGuO
         Ur4jKZCYldhp/FCBRfOMil0pL+eTMsckOfChyoxf3f76ZQkmJ0SNwWA5ab0r0aX6oEfm
         EbGeVatezVlPB5bcfoRBwElrhJDSzBs7laWh01qfoQTQFKS8HY9Pg2TG9djZgQItB9ya
         e9dif5SzEssemiBrYAC0JjQDOeirncPwlC7L1jxY46td2kAoMP88MNNAhiNQCrb0J22T
         UIBw==
X-Gm-Message-State: AOAM530WaLVzj+SrrtmDcywCppOKX2ymITg3hZ4PCf+HQzBsGHY7DTOB
        W1bPvWI5mmcIuCWGL9lKMxAP8UACSMnUqg==
X-Google-Smtp-Source: ABdhPJwRaF5jK3O6ASgedjAZLevyv/HBwqqYtlU1KrXHLX49rOnCEAaIK144mpu10X7+OwwXi3JMkg==
X-Received: by 2002:a5d:6590:: with SMTP id q16mr22194397wru.52.1632038639061;
        Sun, 19 Sep 2021 01:03:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u23sm14887692wmc.24.2021.09.19.01.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 01:03:58 -0700 (PDT)
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
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 1/2] Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
Date:   Sun, 19 Sep 2021 10:03:53 +0200
Message-Id: <patch-v7-1.2-fc7ba4cb1c3-20210919T075619Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1092.g44c994ea1be
In-Reply-To: <cover-v7-0.2-00000000000-20210919T075619Z-avarab@gmail.com>
References: <cover-v6-0.2-00000000000-20210916T085311Z-avarab@gmail.com> <cover-v7-0.2-00000000000-20210919T075619Z-avarab@gmail.com>
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
index b90af71a7a2..b4ad91743b5 100644
--- a/Makefile
+++ b/Makefile
@@ -1224,6 +1224,9 @@ PTHREAD_CFLAGS =
 SPARSE_FLAGS ?=
 SP_EXTRA_FLAGS = -Wno-universal-initializer
 
+# For informing GIT-BUILD-OPTIONS of the SANITIZE=leak target
+SANITIZE_LEAK =
+
 # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
@@ -1268,6 +1271,7 @@ BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
 endif
 ifneq ($(filter leak,$(SANITIZERS)),)
 BASIC_CFLAGS += -DSUPPRESS_ANNOTATED_LEAKS
+SANITIZE_LEAK = YesCompiledWithIt
 endif
 ifneq ($(filter address,$(SANITIZERS)),)
 NO_REGEX = NeededForASAN
@@ -2815,6 +2819,7 @@ GIT-BUILD-OPTIONS: FORCE
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
index d5ee9642548..06831086060 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1536,6 +1536,7 @@ test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -n "$USE_LIBPCRE2" && test_set_prereq PCRE
 test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
+test -n "$SANITIZE_LEAK" && test_set_prereq SANITIZE_LEAK
 
 if test -z "$GIT_TEST_CHECK_CACHE_TREE"
 then
-- 
2.33.0.1092.g44c994ea1be

