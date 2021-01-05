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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BF1C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A23C227BF
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbhAEEoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 23:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbhAEEoa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 23:44:30 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811C3C06179E
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 20:43:11 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y17so34879718wrr.10
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 20:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HjKFPw9an+6lpJcV7qb9eYBOfFSo/2RlHH7d+jhmTdk=;
        b=bk1EYf0K+973BtYxA0fMUaHlwyH2i9fQWcTn3eeHmTViOSBFaW7qtfYKHHHE9KxzDP
         ziBmJ20pHuavGKbiMYuqKB3Q3xOAL5r4S7GpC1AtsQ6a1mKq2mFGH2fSvtcx5kzCyAel
         HJMZ4veNhOwuKmJ7QhP252ZiiZgQz+a97bwR96Czk8HFR+cUjoj0cOrhbxSOqya8zBt0
         h+HzPhBvK+3pVq/4nFyYy7RQOiUZ7fiGup6o1Q8Dvyubvps6JcUacCwNL4J5DnA1Upuo
         yBc/DwhkVqzGRe03iux8R+Awple56+SNELQHqn0fidRmIxaqRKjFC5yfGi9EO2luNBa6
         PlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HjKFPw9an+6lpJcV7qb9eYBOfFSo/2RlHH7d+jhmTdk=;
        b=N5Pjs0mtzmAxPygm1kKEcgTcs7z2eSYamSfdYmdJyZoVYD3GI+K5uPsG9B1PWjRc4T
         pXWefcxrHxyeOxMWwPI8gSwKySeHLXd+Sdks54ftUcMzx/zZ9qJYAiouFFH69c0h/qCJ
         1ozqqsI2aHMkBWUB4YPSuaVuAl17shnOlNNoMFQ4pLPFmAWpzdEeJK5K94/A8MYoY0XN
         KaFDZXEMllTZLsaEWV3O0CGHWrFAXUK9Vv1WlgbejumpvWf8PzG+d+X2/S40ZF6fU0UO
         ecDFj//zCfasqfWkKIYIKe8t7129KS+oQm78bEqCk4Z3ei9YE5BJcnK80Rd9pgYWeOgv
         iYnw==
X-Gm-Message-State: AOAM533K6z2y2uGFDIFWS1KyCFNoLcDYjUrq2hwpgJz5xj5ecibP+ZDz
        8nE0TRgfpuJEYq7X77We40f9ePvw7lA=
X-Google-Smtp-Source: ABdhPJyk8DFahNmF8FG4D9NrSO5oLADKEb4yx40aityHLIpbBqwkvmk35lp+QjGqIBtbJvtTu3ltHw==
X-Received: by 2002:a5d:56c3:: with SMTP id m3mr83173505wrw.419.1609821790111;
        Mon, 04 Jan 2021 20:43:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g184sm2475665wma.16.2021.01.04.20.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 20:43:09 -0800 (PST)
Message-Id: <5091e2661d1a38a24883a8e366a07d92be95c9e6.1609821783.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
        <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 04:42:55 +0000
Subject: [PATCH v2 06/14] update-index: use istate->cache_changed
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
index 106bfdab78e..346d798c60b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -242,7 +242,7 @@ static int mark_ce_flags(const char *path, int flag, int mark)
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
+		istate->cache_changed = 0;
 
 	ctx->argv += ctx->argc - 1;
 	ctx->argc = 1;
@@ -936,7 +936,7 @@ static enum parse_opt_result reupdate_callback(
 	setup_work_tree();
 	*has_errors = do_reupdate(ctx->argc, ctx->argv, prefix);
 	if (*has_errors)
-		active_cache_changed = 0;
+		istate->cache_changed = 0;
 
 	ctx->argv += ctx->argc - 1;
 	ctx->argc = 1;
@@ -1135,7 +1135,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
 
 		if (istate->version != preferred_index_format)
-			active_cache_changed |= SOMETHING_CHANGED;
+			istate->cache_changed |= SOMETHING_CHANGED;
 		istate->version = preferred_index_format;
 	}
 
@@ -1223,7 +1223,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		report(_("fsmonitor disabled"));
 	}
 
-	if (active_cache_changed || force_write) {
+	if (istate->cache_changed || force_write) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
-- 
gitgitgadget

