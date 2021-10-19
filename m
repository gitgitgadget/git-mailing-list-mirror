Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEECC433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C55286115A
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhJSXYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhJSXX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 19:23:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3B2C06174E
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l38-20020a05600c1d2600b0030d80c3667aso6136054wms.5
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D/U+BFDW9z5vUtc6ShiHg2+qWUKxNYZGW8R5GfgLyWE=;
        b=W7KOU3livL04BWyC8VNmmlH96VTO5cSN7s62tTC6bIl9sXy6qUfbNhiTWFWJDCt7LH
         NHfdRHJYYYaoSRsn4JU/7uQFdYuyMWuwtGnYxbkxIW96cQnG+y/GYPKWfRMBkpvdJNhd
         DqbnKWKgtVTfkI57oUlcnRaEs1fe8OjKv8z/Fh/Rtdai8g5zLCDkcnvixJiIysBm8PZV
         KDTv4h8EyWCzHEW7s3rfx7vX/iLIyJwB9mqhZq2on187Nmpwr+48bcPcdB+DSERIdDTq
         AFVIY7ebiYr3Ni8HWpvoGjAP5IRl8T0DrNeWIoX3nMSMIwgHpBgZ9JeXlmXjqSQU+701
         tRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/U+BFDW9z5vUtc6ShiHg2+qWUKxNYZGW8R5GfgLyWE=;
        b=5gpj+VMZwEFScnNeVZtO1xJlYATOM2ErogqWnQJGWSyGbxopj/kO5tnE1at/B3+Cma
         QzmhHvXlc3wk9HDoUZG+bNg+VqFToT7OhSOkzKNyckX3RTHCGMjUkOLktOJjuUbaffyg
         TMfhh5cz/UzSa0YMn2abzkaRUHEUWVF21z5y/o8XTbKirS61L+21dOC3u656yDuCoFrG
         CTK3h2JhqpIy3lbTwWUgkvinZskYhaw6pPeQlsqwdmH/1lHvMo9mDdtm3ySUPxw/trax
         YGUZ4XMQhYPFMUizz4+EeF+HoTBctGALZkXQ70P9YWcLy0PAqF5zlCyBv6lzVa4P3hKX
         GpxQ==
X-Gm-Message-State: AOAM530s6xb93wG5G/qLhCNorhvRX+MN6bqdKmjk3+H9OBp7k891H4G5
        BOeoNXRHrT7+5fOY6/GKyZuL0joEmlMyLQ==
X-Google-Smtp-Source: ABdhPJyXvf1fWWqZkv/mNRSsRbwDXNhGj3n5ecXdmymj3sRUnot4ePqfZmt/gFNtWboTuLbBwByUBQ==
X-Received: by 2002:adf:ee8a:: with SMTP id b10mr48668041wro.335.1634685702058;
        Tue, 19 Oct 2021 16:21:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g25sm304644wrc.88.2021.10.19.16.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:21:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/13] commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
Date:   Wed, 20 Oct 2021 01:20:48 +0200
Message-Id: <patch-v3-10.13-706426c8a79-20211019T231647Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
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
index 551de4903c1..4e7cbd7585d 100644
--- a/commit.c
+++ b/commit.c
@@ -21,6 +21,7 @@
 #include "commit-reach.h"
 #include "run-command.h"
 #include "shallow.h"
+#include "hook.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1700,22 +1701,22 @@ size_t ignore_non_trailer(const char *buf, size_t len)
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
2.33.1.1338.g20da966911a

