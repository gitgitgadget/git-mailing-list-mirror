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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D472C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B8A61263
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhFQKZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhFQKZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66C9C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t3so3247023edc.7
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MHlwt0RA73zXBfMOn4s+GaK7BhhC8YxCI9VDEXg5Et8=;
        b=l40UAvggmyawyZAQbYftxTONb/jXfW+F0z19cImtzdaOjjI+pWra8h0cFtPiGYQ6zP
         ZTED1exg4fAmHAB0ZOoELYRzpd++O8M2Z5ftT2LFL5QOwSUOX9u1Cs7m/2Gd+T/Oh+2V
         vM0i0vqEMovlApbuGZeNYBJwE91M+MN9pMVOLux97uwkp0cKTDkX40Sluj7MYle7uFuQ
         MvXWUq7RHmeV4RfWNTP3bSzb9rG9n0l/A+A3hft/ea6Q1rtcLhadN7xbE9i3ULx89/ZP
         tCEh0Knf3+0qQLchaR2DJd3Fxz92MCpQoh+wnd337QG93eAUzr+r8BtEg5WG5A7mUwgz
         K9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MHlwt0RA73zXBfMOn4s+GaK7BhhC8YxCI9VDEXg5Et8=;
        b=km1LixhJhUtjsD8QmBj7XyyZqJqNEovY7Tmvy7BjI/2yrrPWuNGzvP+w4Es6fKl3O8
         d73vronJys322BJQbxLAG0z5dzhboK2D7ZPuue8L4Gezq/lzqS5dF3i9K/07ehp9yn9G
         G19isKQFP9lbCzquy+xpGoWiOnS8mUBlgD76ImnoSw46WdVRYpFDEXwc43b4gvoFgH9Q
         0ewsVBUsJeb+8DHgTfJwfu9tTR69x1nxP0MOXG70e+rd1uvZnZ+N1EM8JYnw5fEKyiR9
         Q93WdgsbuvKHXuXMQSnl8DiZycia2jvY826T3+aCjuF3Z/hJwhtagbBxmwy8PUNm5jMh
         54qQ==
X-Gm-Message-State: AOAM532iqkFXEHaLd1NUC1niahXs/DS5KY9XqJCbH8BPd2jAorlYhli6
        Q2h2OCokMx2bKKxF8COEqK6Rps5QVIfafw==
X-Google-Smtp-Source: ABdhPJw3dqnSeQ6JVA3CDwll85cdcwPdLf98bz4ibbrwu0DZwTusoXGhxehTIZ5M6b5h/qZE4oBNhA==
X-Received: by 2002:a05:6402:344:: with SMTP id r4mr5428497edw.226.1623925390348;
        Thu, 17 Jun 2021 03:23:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/27] gc: use hook library for pre-auto-gc hook
Date:   Thu, 17 Jun 2021 12:22:36 +0200
Message-Id: <patch-02.27-7209f73f28-20210617T101217Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com> <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Using the hook.h library instead of the run-command.h library to run
pre-auto-gc means that those hooks can be set up in config files, as
well as in the hookdir. pre-auto-gc is called only from builtin/gc.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index f05d2f0a1a..a12641a691 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,6 +32,7 @@
 #include "remote.h"
 #include "object-store.h"
 #include "exec-cmd.h"
+#include "hook.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -348,6 +349,8 @@ static void add_repack_incremental_option(void)
 
 static int need_to_gc(void)
 {
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
+
 	/*
 	 * Setting gc.auto to 0 or negative can disable the
 	 * automatic gc.
@@ -394,8 +397,11 @@ static int need_to_gc(void)
 	else
 		return 0;
 
-	if (run_hook_le(NULL, "pre-auto-gc", NULL))
+	if (run_hooks("pre-auto-gc", &hook_opt)) {
+		run_hooks_opt_clear(&hook_opt);
 		return 0;
+	}
+	run_hooks_opt_clear(&hook_opt);
 	return 1;
 }
 
-- 
2.32.0.576.g59759b6ca7d

