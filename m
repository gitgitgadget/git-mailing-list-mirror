Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DD7C4332F
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 09:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B054361214
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 09:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbhIWJW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 05:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbhIWJWY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 05:22:24 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B39C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 02:20:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t8so15340835wri.1
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 02:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q3va955bLvy/O5HE+gUFx0gjlOQVoRbeRSzr6zCVK/o=;
        b=ddCqMZc38WbLBcZy5KIrrkK1kD9eBPpZee3IXuFTw2BHF3grXzwN0NOzgTwY3MGBb0
         gBGUndHB78TMHyyoYk30kgta5bPd+szDbr6JfzJwxrtNCPnCHUFarPHbErFVfSvWJHru
         srJUt2auqLIJO4pLe1l6JojmEp7Qw2n8otTEdgt38fyL73ZR1SU2qoZLPxdfwT/A7boK
         rF4lEgPiCq74M6eY0EuZKqlcrErr8dsiQMEU1ZbcwQZN+Onkt05WwOV+jTS7Eh0iJ621
         NQED+psMLjlDWabOwAIjmhLtScnADiaZUtxaqz5BtzwHXHBzJuw5t5yu9ba2Py3ixnY9
         eTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3va955bLvy/O5HE+gUFx0gjlOQVoRbeRSzr6zCVK/o=;
        b=RcZlExVRl9Ey+HjxfefJ9jIJLasAHdXZ4Q9FpMW7G58jMjJa7Kt0T/Awsr5uZ0PnTg
         tFtsK0DOTaeBYrRGrgBbAB3VtoaVAg9Nka07D4Vtissq8Z1IlIRIxSuqVOzJuxTYesKF
         LbBeGAqXtiis6wJnT9WSv8WgRFJkpbzKgfYzYrWICJhHHm1sK15n4O5I30NithyCldMn
         qUf2UXC4sAm2Ar0wOQ4jFFXYoj6kUwMCLMLL/m2nHZHKq69VDKrknepewZBB1tLhyPze
         h6DWxdWvgmlRP09aHSfoj+Ek/RKkJ7vq8ZHs5kOnxwVujD/WTQ2BBbowy7T2YhPApNNn
         aJKw==
X-Gm-Message-State: AOAM53143mTd9Y7kMBPk/mkUzOGNZmJZN5fzqnkQDfIAAzv9xGMlWg9l
        76eGCC0bi8tLQ3uObNBMN4qW4MkDlGJ8ZQ==
X-Google-Smtp-Source: ABdhPJw8kBUzBt8+RVhABnBdCRI8W0UwaoWBQQI6N1MK7Wb4B3RNpyixvJfUnCCx3/imuISZo7z2OA==
X-Received: by 2002:a7b:c767:: with SMTP id x7mr14958008wmk.62.1632388851100;
        Thu, 23 Sep 2021 02:20:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n66sm4540669wmn.2.2021.09.23.02.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 02:20:50 -0700 (PDT)
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
Subject: [PATCH v8 1/2] Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
Date:   Thu, 23 Sep 2021 11:20:45 +0200
Message-Id: <patch-v8-1.2-c68a7108dc4-20210923T091819Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1228.gdc65525c655
In-Reply-To: <cover-v8-0.2-00000000000-20210923T091819Z-avarab@gmail.com>
References: <cover-v7-0.2-00000000000-20210919T075619Z-avarab@gmail.com> <cover-v8-0.2-00000000000-20210923T091819Z-avarab@gmail.com>
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
index 9df565f27bb..d7390e6b2b5 100644
--- a/Makefile
+++ b/Makefile
@@ -1214,6 +1214,9 @@ PTHREAD_CFLAGS =
 SPARSE_FLAGS ?=
 SP_EXTRA_FLAGS = -Wno-universal-initializer
 
+# For informing GIT-BUILD-OPTIONS of the SANITIZE=leak target
+SANITIZE_LEAK =
+
 # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
@@ -1258,6 +1261,7 @@ BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
 endif
 ifneq ($(filter leak,$(SANITIZERS)),)
 BASIC_CFLAGS += -DSUPPRESS_ANNOTATED_LEAKS
+SANITIZE_LEAK = YesCompiledWithIt
 endif
 ifneq ($(filter address,$(SANITIZERS)),)
 NO_REGEX = NeededForASAN
@@ -2803,6 +2807,7 @@ GIT-BUILD-OPTIONS: FORCE
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
2.33.0.1228.gdc65525c655

