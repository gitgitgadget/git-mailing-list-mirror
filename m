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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDD7C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B583361037
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbhHCTj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240184AbhHCTjk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E5FC061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b11so21164204wrx.6
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMB46S1NimLSkKJUhrBbN1mXbK87ERJkBZi02PZv9/E=;
        b=W76UJ6zU3RL7V97yQMRF9J2HHIKUEhycTYVbSKjLfEuT/sSlPl16NKGDXvqEYQsJV8
         dQJ18YSQHN2+zdbv4TwG36qPjWx1sCDyFpEeLlTyQHd8mMHnFp1HGJEtrSZ3qWfzFmaQ
         T/CIf7Ws9wyDXTVplqgWsRhWrYxp9VkznSbc2eB/sHjH5m9FV28BJcXrkyvMARscEHro
         S8aaqP0RTmLqlulrmAHca9REgPHzkDJ5HLenkUd0yZU5W/g9yPS/BjJXJiGPsfQWqz3n
         9EiAD0PA8movDAL5elaAmjslMQhEj56og5aN+NgMMa1sJL/a3hGj9X1VHlakXjfFYcbR
         /rbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMB46S1NimLSkKJUhrBbN1mXbK87ERJkBZi02PZv9/E=;
        b=TduzqZ+nJQlM1wkQksVL+muLqL6FmZofMKeqZDe3a7LmvNYMlG2L0NlNNFxZG9zf1t
         o7deEAozvatkXGdjpOIVJs/k0wxNMAM8z/ZkgzuyoHPeDBaKCjy9tYWbjILH9QGfkf+3
         yYsx6gRwJ+nnKMQW5Iz/DMT0U+jin1fLHKG3G+mqVIgbQ3Qn54EMQk02U8LvskEFw8Vy
         KsST2PcgQfVSaFoDN5/m63LU3bPYitqKOa9+HktoU+Z+RSABvxnFaFe3K8o2vauLtBVI
         rBOhC0x+YU19zXLYy13YBFYXS9K8fsdrypAxtMWYWdzYZOAeUFl5vyJEDunPprEGv7wI
         BV/A==
X-Gm-Message-State: AOAM532iXtCzp9Cq4JHiesf3rxRI6HTyjazCRXwOHI5yLwk5Xt+n6+Tr
        moQUY8reC3d8Fdi/3ziNvETKsa2tIK8C+A==
X-Google-Smtp-Source: ABdhPJxwgpZBQQ40IHtaVvSYTVGzl+GYDhqtcKH+yOeMKrnepxTRjNACe8Qx+9YSTl5m9SRNP7Rsqw==
X-Received: by 2002:a05:6000:248:: with SMTP id m8mr25230075wrz.145.1628019567427;
        Tue, 03 Aug 2021 12:39:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:26 -0700 (PDT)
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
Subject: [PATCH v4 17/36] commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
Date:   Tue,  3 Aug 2021 21:38:43 +0200
Message-Id: <patch-v4-17.36-ad5d0e0e7de-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move these hooks hook away from run-command.h to and over to the new
hook.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index 143f472c0f2..63d7943a86d 100644
--- a/commit.c
+++ b/commit.c
@@ -21,6 +21,7 @@
 #include "commit-reach.h"
 #include "run-command.h"
 #include "shallow.h"
+#include "hook.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1698,22 +1699,22 @@ size_t ignore_non_trailer(const char *buf, size_t len)
 int run_commit_hook(int editor_is_used, const char *index_file,
 		    const char *name, ...)
 {
-	struct strvec hook_env = STRVEC_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	va_list args;
-	int ret;
+	const char *arg;
 
-	strvec_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
+	strvec_pushf(&opt.env, "GIT_INDEX_FILE=%s", index_file);
 
 	/*
 	 * Let the hook know that no editor will be launched.
 	 */
 	if (!editor_is_used)
-		strvec_push(&hook_env, "GIT_EDITOR=:");
+		strvec_push(&opt.env, "GIT_EDITOR=:");
 
 	va_start(args, name);
-	ret = run_hook_ve(hook_env.v, name, args);
+	while ((arg = va_arg(args, const char *)))
+		strvec_push(&opt.args, arg);
 	va_end(args);
-	strvec_clear(&hook_env);
 
-	return ret;
+	return run_hooks_oneshot(name, &opt);
 }
-- 
2.33.0.rc0.595.ge31e012651d

