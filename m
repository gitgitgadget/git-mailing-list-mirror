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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B38C433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF329233E2
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391387AbhATQ4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404076AbhATQz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:55:27 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9319BC061786
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:08 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 7so16513968wrz.0
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nNuAXab2vPlq3R+IaBIQjsjYiHa8LdjqA99dbgGHa1g=;
        b=Ljx3q2wyCnYRvha0sINwvfScRgherWCcDB+tSOmsnRigCWvEbE0iV9zd68PcxegLY4
         2FG8TJT6HSnSv53eHCTB3h+CDYClmY6IUMP3nUNh0bwSVU5WvZ62LonlebRzpENjxhnc
         al0QdF+EmqkbuQBM6GgDQlsqvo5iTS5WTBDukL37hCoD4H05ASLUf5uaWUF2Ods31VE1
         5Iz5gwEj2A5BhshyAgZnWuWlXuVRbrb5uFGxNNzri3Xevqt1SG3o8M910tML88RrtY6Z
         JzsPivyVJQ79kaLttBWTOMl0jNAihoIsgJlwsRsytInXgDdEWf6vjkuLpCfjTofAjae7
         01Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nNuAXab2vPlq3R+IaBIQjsjYiHa8LdjqA99dbgGHa1g=;
        b=RYcM6LWUZgCVqGyzghEibymRCGZpXC+TiWYYtNNE/yxBz1aZW119v2NuoJCB85KDYs
         rpli3Dn9Kc4dpnwgnvz274/T2Xqu362KqHK3VZ3U2SRMaKgsBZox4esdtVoyka7I/7QY
         JIj9Flwbv/UWDVwe8MQvyMDPSxvXg6y5reRa01iXnSIYJkAC1Ay8310TTR//2qgAGPYt
         XgquBSMzbblSXbjmcsA3Mc/PARlzOEc8AEu7BB0ZzpyYCUtW6vaVPEByMXniY3LNpSrY
         nUY/tUOJzaLFmVNpuIF5IgwqKQZd2lcg1Abb9yeYULNWqygyYyIhwSoWEl/FI0F9YQbU
         nTqQ==
X-Gm-Message-State: AOAM530wz3/0y/cUjP5La9W+T7kpBPvCmNdE8bzeyWqDYLVvEv9sc+hx
        lla2efVhFeWgV9fNLWAlBA2S+Tu93nE=
X-Google-Smtp-Source: ABdhPJzlyFJqlnyqQImnsmylu5vPMOla+N7A4or3ox/X2gZ3IxupumUYyjWyueQuDTAAHA1tHEZYeg==
X-Received: by 2002:adf:fbd2:: with SMTP id d18mr10414272wrs.222.1611161647232;
        Wed, 20 Jan 2021 08:54:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a24sm4591339wmj.17.2021.01.20.08.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:54:06 -0800 (PST)
Message-Id: <91344f5108c835a48b2460b9de75c489045b9cce.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.git.1611161639.gitgitgadget@gmail.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jan 2021 16:53:57 +0000
Subject: [PATCH 7/9] sparse-checkout: hold pattern list in index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As we modify the sparse-checkout definition, we perform index operations
on a pattern_list that only exists in-memory. This allows easy backing
out in case the index update fails.

However, if the index write itself cares about the sparse-checkout
pattern set, we need access to that in-memory copy. Place a pointer to
a 'struct pattern_list' in the index so we can access this on-demand.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c | 17 ++++++++++-------
 cache.h                   |  2 ++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 2306a9ad98e..e00b82af727 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -110,6 +110,8 @@ static int update_working_directory(struct pattern_list *pl)
 	if (is_index_unborn(r->index))
 		return UPDATE_SPARSITY_SUCCESS;
 
+	r->index->sparse_checkout_patterns = pl;
+
 	memset(&o, 0, sizeof(o));
 	o.verbose_update = isatty(2);
 	o.update = 1;
@@ -138,6 +140,7 @@ static int update_working_directory(struct pattern_list *pl)
 	else
 		rollback_lock_file(&lock_file);
 
+	r->index->sparse_checkout_patterns = NULL;
 	return result;
 }
 
@@ -517,19 +520,18 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
 {
 	int result;
 	int changed_config = 0;
-	struct pattern_list pl;
-	memset(&pl, 0, sizeof(pl));
+	struct pattern_list *pl = xcalloc(1, sizeof(*pl));
 
 	switch (m) {
 	case ADD:
 		if (core_sparse_checkout_cone)
-			add_patterns_cone_mode(argc, argv, &pl);
+			add_patterns_cone_mode(argc, argv, pl);
 		else
-			add_patterns_literal(argc, argv, &pl);
+			add_patterns_literal(argc, argv, pl);
 		break;
 
 	case REPLACE:
-		add_patterns_from_input(&pl, argc, argv);
+		add_patterns_from_input(pl, argc, argv);
 		break;
 	}
 
@@ -539,12 +541,13 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
 		changed_config = 1;
 	}
 
-	result = write_patterns_and_update(&pl);
+	result = write_patterns_and_update(pl);
 
 	if (result && changed_config)
 		set_config(MODE_NO_PATTERNS);
 
-	clear_pattern_list(&pl);
+	clear_pattern_list(pl);
+	free(pl);
 	return result;
 }
 
diff --git a/cache.h b/cache.h
index f9c7a603841..bf4ec3de4b0 100644
--- a/cache.h
+++ b/cache.h
@@ -305,6 +305,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 struct split_index;
 struct untracked_cache;
 struct progress;
+struct pattern_list;
 
 struct index_state {
 	struct cache_entry **cache;
@@ -329,6 +330,7 @@ struct index_state {
 	struct mem_pool *ce_mem_pool;
 	struct progress *progress;
 	struct repository *repo;
+	struct pattern_list *sparse_checkout_patterns;
 };
 
 /* Name hashing */
-- 
gitgitgadget

