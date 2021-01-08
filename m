Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1945C433E6
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06A723A01
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbhAHUEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbhAHUEW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:04:22 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38519C06129F
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:03:06 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id y23so9419012wmi.1
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jO10ZIWybl1T7dDcsv1BvC3cxOd3MoOlPtprl9OSFoE=;
        b=AOCq7RElOa46POxXyK64f9ccC/c0K8/iAb8nvVNOvFEcBXNa1KyH2SJ8LflpcZG+kf
         hJIj3oq2SSMwW7DLOKU2xYtzzZC1r9BJ9Iyzhw4iDR+BuFwQxirZf3p/9pRw3K4YyypF
         KaLagjxm2BC6pro7q4m2f2anFCdgUtpaFxuB15tMPyGj+eNlsOcn7xGbpGVAp946l8ep
         bMyX0XjY8qkGC5eIqXUuyv2OOieX/G9vwyyNJH9s2t2BbHG4N2k2/HVEoXsF8tCn9GTk
         mFKDvCp1S7k+L9d9BVd5VQdHDc4OtmCpKopiHuBNcBFTYhvFAsPOjifK8K2/N4cyHwxf
         RSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jO10ZIWybl1T7dDcsv1BvC3cxOd3MoOlPtprl9OSFoE=;
        b=N8NxJGXxvfWYy/SZOBtGv7vbOj9RhCyyaOk+Q4moa+KAeHPTYhGCS7PWSRyD0inyxx
         8e+IkfFbKOiutlnyYRRnjOAzCvcoW+vj9MNNCZoo/Ekl6eK7sk/hvxocregN7JB11POk
         ocqJeJIpqvISxvyRuEcxZryx5UWdINyQ8Es/7maLsIquS1gX7wT0HSpqdt9kbgUnogVh
         Gl7VyLbqeRYJ3Nq2pbW2WnFGZDxQ3sZhIAw8mDa355wOUvoBcTUtjg9VBcSNiBNanefJ
         XD8oR2G5gWuEIYfBAi39ULI9aZWw1w83XpT8rHfOHFTqjOF+6qKaZzDYmRsO0heVVF39
         HWSw==
X-Gm-Message-State: AOAM530gHbLZG9moClqmcMmaxGYNgW7qucLf6TIuiR6dByHVjri5AhZg
        5SrqpbFigtoKvwkY5KUjUfWb5ioeNAk=
X-Google-Smtp-Source: ABdhPJzd4vMXl/WnyFEUXhHadquQiJS6dkC4rXkF9d2FfxiuUW2rPJNSKj4+7JoOsG3PYbBnaSSV5g==
X-Received: by 2002:a7b:ce14:: with SMTP id m20mr4496430wmc.149.1610136184765;
        Fri, 08 Jan 2021 12:03:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u205sm13901116wme.42.2021.01.08.12.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:03:04 -0800 (PST)
Message-Id: <f450f43cd0dc837622ada37d45b35f465ef902c8.1610136177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
        <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 20:02:49 +0000
Subject: [PATCH v3 06/14] update-index: use istate->cache_changed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This is a mechanical replacement of active_cache_changed.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 2b03b29261b..70ca47e712c 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -241,7 +241,7 @@ static int mark_ce_flags(const char *path, int flag, int mark)
 			istate->cache[pos]->ce_flags &= ~flag;
 		istate->cache[pos]->ce_flags |= CE_UPDATE_IN_BASE;
 		cache_tree_invalidate_path(istate, path);
-		active_cache_changed |= CE_ENTRY_CHANGED;
+		istate->cache_changed |= CE_ENTRY_CHANGED;
 		return 0;
 	}
 	return -1;
@@ -915,7 +915,7 @@ static enum parse_opt_result unresolve_callback(
 	*has_errors = do_unresolve(ctx->argc, ctx->argv,
 				prefix, prefix ? strlen(prefix) : 0);
 	if (*has_errors)
-		active_cache_changed = 0;
+		repo->index->cache_changed = 0;
 
 	ctx->argv += ctx->argc - 1;
 	ctx->argc = 1;
@@ -936,7 +936,7 @@ static enum parse_opt_result reupdate_callback(
 	setup_work_tree();
 	*has_errors = do_reupdate(ctx->argc, ctx->argv, prefix);
 	if (*has_errors)
-		active_cache_changed = 0;
+		repo->index->cache_changed = 0;
 
 	ctx->argv += ctx->argc - 1;
 	ctx->argc = 1;
@@ -1135,7 +1135,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
 
 		if (repo->index->version != preferred_index_format)
-			active_cache_changed |= SOMETHING_CHANGED;
+			repo->index->cache_changed |= SOMETHING_CHANGED;
 		repo->index->version = preferred_index_format;
 	}
 
@@ -1223,7 +1223,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		report(_("fsmonitor disabled"));
 	}
 
-	if (active_cache_changed || force_write) {
+	if (repo->index->cache_changed || force_write) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
-- 
gitgitgadget

