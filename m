Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0228AC433FE
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D173261214
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhIPKuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 06:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbhIPKuh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 06:50:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C394C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:49:16 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t18so8810927wrb.0
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ap/GyYviefcf8UmqpSa7PPdqRMBF1mNBElWIe/qVQSM=;
        b=euP+7cTXR03wyklGJnDYtZB65sxUVbJ8crAgB74zGrXhr8YhbyvxIh33UMiZY7uIlA
         Pr1ndgvd5OqBgUFqIw+HVYgfdmV67/eDAd7WbYKPS2DAEsS3UYfiTOOa6gYNGdMB1ARa
         01CT2ligZw9lxL28JLsb7hauAwTZSEgC0QV4MNvrlOZe6lY1eMKvn7X7VH9dxFrbwxBT
         ixoMx+4/e6V8jwK4AJIny44dlabRoLi+E/oTnyKggf4SWLsultveRuY1BxQVCsykr8HY
         SXJLddAeKS9i3GljeevW3q7nQWzhihOOydH/BlYhOgzaazPIbo3M1tUdUjTw8TinUj3V
         WTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ap/GyYviefcf8UmqpSa7PPdqRMBF1mNBElWIe/qVQSM=;
        b=7W2T+LGWuK9MNCmK+0Dr0TajwnLbz2mRtYdyzVEu0avJkDFNDxeCps+6AW1Nbp1Xs2
         5O3qQr2waD2X5a4qXU9OxJMoNA+IqFh4LtVnKEdMkZ8etOOAd5A/0lO4hec6LPe7rgSu
         mqCm+Ml4U8yJ5g5Rx3JYvti11gSUlfLOulNe7PwzIM0Vy4ZNxKgMnoKJSmuAa/2TT/a6
         zXx+WXgQTyHG9SvVagVXF4E+mYGPpZ7Czo+urr4+0UgS1PF0yYMnP61SYVJwrWrdLw1+
         PZR3NPCEa80sPsdNtQwg7sNGKTDv8kdIQFutrP4mPAXO4g7EI/OtQhPdyzqlEBoDC3JE
         6bug==
X-Gm-Message-State: AOAM533hpr/+mVlmxMrtTuKwp3dVY+B2xb9trw0oD5EN7dmMRXIoU3wy
        9cKqrBoFyoTrktmpAWapkXd7F2zGh4YhVg==
X-Google-Smtp-Source: ABdhPJzWAb6Vc5luvBsb9s+1+QoHUnyWCZLj7yuqpDHD3byj6/vtEMW2SdDszFe0Zqs8ZcFBS7bROA==
X-Received: by 2002:adf:b741:: with SMTP id n1mr5404998wre.354.1631789354630;
        Thu, 16 Sep 2021 03:49:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e25sm3216908wrc.23.2021.09.16.03.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 03:49:14 -0700 (PDT)
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
Subject: [PATCH v6 1/2] Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
Date:   Thu, 16 Sep 2021 12:48:52 +0200
Message-Id: <patch-v6-1.2-fc7ba4cb1c3-20210916T085311Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1056.gb2c8c79e36d
In-Reply-To: <cover-v6-0.2-00000000000-20210916T085311Z-avarab@gmail.com>
References: <cover-v5-0.3-00000000000-20210907T212626Z-avarab@gmail.com> <cover-v6-0.2-00000000000-20210916T085311Z-avarab@gmail.com>
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
2.33.0.1056.gb2c8c79e36d

