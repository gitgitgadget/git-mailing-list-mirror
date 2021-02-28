Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186DBC433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 03:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3FA964E21
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 03:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhB1D73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 22:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhB1D7L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 22:59:11 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B28C06178A
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 19:58:31 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o16so11245364wmh.0
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 19:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qzZe6EEUXndnEwCz4cXC0NUftpDdVBGzVehx3WE1KBs=;
        b=tmcdGP0E5MWU8GXtANzpgewe1Yb9TN/4rlt3Im8oyLAdOpvdFtYyIrnntuGAXwNm49
         uM4RMxbSPgXAu976UMqXfChrRfCnm5zniLrZwF4r23HO7c/uY+4tjw5JtT2HMBLirX9o
         GxPOVaV/WRZlP1qssnXFvjUM6vSlK9w4fEXCsrfCPIGwEmwk5VzlcgX1EglZppdU000m
         AGCgyZzm6zCzPt5wliHNpQVx+QFPWAvGtcfDKfuzVPgaOeh3jEpJ9rOFxQRfACGA0plq
         +mtaODyxORyVkZzYZh+u1oB2qESgLhNV7KgYQpH7mvlGjYZtb8UK6yBmyHdHqSuCrQTY
         /PNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qzZe6EEUXndnEwCz4cXC0NUftpDdVBGzVehx3WE1KBs=;
        b=C35beN9/V5esi4YuS/N0l3ZeL2Yonad4FarIZlDx5xPoqX+UF6YnlO1jmbwEz7RcJ1
         GOHGv8bEar32SL+lzNlBl7YmZxTmkrHG1+y4ahjFUNuoB7vVJSoTYQXgJ6WTiZjx3zb4
         GUNxYHhJPF5gnhOMUmgbQq/hDVV4oq7mYXnFy9pmGaf2xpKODiH+l9ZsPIlLXenCwf/+
         uQ/ZuLLcUJY79DuZQw5FAQ1sp6kZmOrI28oAFBt+Fj0UdMrQkNslg2dJ6VvflaFyrkjP
         YjFAQ6JNs3XLaqosJ2V2/BJa+zns/fbBRG3dF56diQiAIhEqIyH+fz2xACotxi+2Tv+e
         A2zQ==
X-Gm-Message-State: AOAM530Bn9C4jS51cGLlRJL6Zd18y379rrcKOqFXTYEFs97cTar9Luk4
        zDrowQRPUft/VoMhIzdtRrjzloVk2+Y=
X-Google-Smtp-Source: ABdhPJxR5NWA1D56TI9KSmqr9nRiZxwNSGisy9h2p1UBM8y131TX+akJEXhQFBgI2gCVC+LXPq0MlQ==
X-Received: by 2002:a05:600c:4fd5:: with SMTP id o21mr9389775wmq.20.1614484710323;
        Sat, 27 Feb 2021 19:58:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c62sm17536825wme.16.2021.02.27.19.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 19:58:30 -0800 (PST)
Message-Id: <7673e4c23bbb4eb1ee625467a6515ff52145e79c.1614484707.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.git.1614484707.gitgitgadget@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Feb 2021 03:58:22 +0000
Subject: [PATCH 4/8] merge-ort: introduce wrappers for alternate tree
 traversal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add traverse_trees_wrapper() and traverse_trees_wrapper_callback()
functions.  The former runs traverse_trees() with info->fn set to
traverse_trees_wrapper_callback, in order to simply save all the entries
without processing or recursing into any of them.  This step allows
extra computation to be done (e.g. checking some condition across all
files) that can be used later.  Then, after that is completed, it
iterates over all the saved entries and calls the original info->fn
callback with the saved data.

Currently, this does nothing more than marginally slowing down the tree
traversal since we do not take advantage of the opportunity to compute
anything special in traverse_trees_wrapper_callback(), and thus the real
callback will be called identically as it would have been without this
extra wrapper.  However, a subsequent commit will add some special
computation of some values that the real callback will be able to use.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index d49cfa8b030b..bd2b93a31141 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -512,6 +512,78 @@ static char *unique_path(struct strmap *existing_paths,
 
 /*** Function Grouping: functions related to collect_merge_info() ***/
 
+static int traverse_trees_wrapper_callback(int n,
+					   unsigned long mask,
+					   unsigned long dirmask,
+					   struct name_entry *names,
+					   struct traverse_info *info)
+{
+	struct merge_options *opt = info->data;
+	struct rename_info *renames = &opt->priv->renames;
+
+	assert(n==3);
+
+	if (!renames->callback_data_traverse_path)
+		renames->callback_data_traverse_path = xstrdup(info->traverse_path);
+
+	ALLOC_GROW(renames->callback_data, renames->callback_data_nr + 1,
+		   renames->callback_data_alloc);
+	renames->callback_data[renames->callback_data_nr].mask = mask;
+	renames->callback_data[renames->callback_data_nr].dirmask = dirmask;
+	COPY_ARRAY(renames->callback_data[renames->callback_data_nr].names,
+		   names, 3);
+	renames->callback_data_nr++;
+
+	return mask;
+}
+
+/*
+ * Much like traverse_trees(), BUT:
+ *   - read all the tree entries FIRST, saving them
+ *   - note that the above step provides an opportunity to compute necessary
+ *     additional details before the "real" traversal
+ *   - loop through the saved entries and call the original callback on them
+ */
+MAYBE_UNUSED
+static int traverse_trees_wrapper(struct index_state *istate,
+				  int n,
+				  struct tree_desc *t,
+				  struct traverse_info *info)
+{
+	int ret, i, old_offset;
+	traverse_callback_t old_fn;
+	char *old_callback_data_traverse_path;
+	struct merge_options *opt = info->data;
+	struct rename_info *renames = &opt->priv->renames;
+
+	old_callback_data_traverse_path = renames->callback_data_traverse_path;
+	old_fn = info->fn;
+	old_offset = renames->callback_data_nr;
+
+	renames->callback_data_traverse_path = NULL;
+	info->fn = traverse_trees_wrapper_callback;
+	ret = traverse_trees(istate, n, t, info);
+	if (ret < 0)
+		return ret;
+
+	info->traverse_path = renames->callback_data_traverse_path;
+	info->fn = old_fn;
+	for (i = old_offset; i < renames->callback_data_nr; ++i) {
+		info->fn(n,
+			 renames->callback_data[i].mask,
+			 renames->callback_data[i].dirmask,
+			 renames->callback_data[i].names,
+			 info);
+
+	}
+
+	renames->callback_data_nr = old_offset;
+	free(renames->callback_data_traverse_path);
+	renames->callback_data_traverse_path = old_callback_data_traverse_path;
+	info->traverse_path = NULL;
+	return 0;
+}
+
 static void setup_path_info(struct merge_options *opt,
 			    struct string_list_item *result,
 			    const char *current_dir_name,
-- 
gitgitgadget

