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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48B5C4332B
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919E1652BB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhCIAK3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 19:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhCIAKE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 19:10:04 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2BCC06175F
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 16:10:04 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id f12so13301193wrx.8
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 16:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qzZe6EEUXndnEwCz4cXC0NUftpDdVBGzVehx3WE1KBs=;
        b=QDyR+i7eGkucWGFrfc5cmJ/+7edb87sP2Y7YZ0Fk5M0OwVisYRAdW8034G8KrkuIkj
         c+NDE+2Ulo4Pb5710Ab8Ex2EPHmiyLxK4mXHdNrQTweE4Myrxvw+0Q1nf8IURJQdBK6Y
         ud39YsObsGactyp0lfskgx/vl7vy9NF+JrRJ4OyXe31QUHTy7xLO5slKRx8yBUsSnkJD
         +ZVJSM/leAEcm9hdoE5ncace9t4i33xbEI0gzAxY5e8/kmEZ3YDjlkrHDfAxjGDgnStB
         RuZm0r9/SwWsIUACMUsuFTJovwTQviNx/KORnTfLwDxPOKQjOcdGMubC3vrdC4kMBr00
         +wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qzZe6EEUXndnEwCz4cXC0NUftpDdVBGzVehx3WE1KBs=;
        b=R9bOlFVM2ab6ayfKSkMc2363xaWWupcn0j9lNViLoMTTX6nAdc2jWl+NnQ1jJHhxAu
         l4BhkCuZeyr2UD1e2KaTFM7yt5LMq6JvbrHeszM71ySV9VwdrCv56H9Zusv4eU9Tdauq
         8VPNz/9en7YBeK+d/bsFdEKihf+ux1J1LVF/YOr/AD9lbA93VkYTFAtLuBaI2TVwrPUX
         65aFI9lrlmYRwM6MhqaUf1qPBPMxcREjuO1uQWcCl+RzGSEdS3EQBdn7QVz+vdPdyTSN
         9Wkz2KwvPrA6s5HvSe/eXBvlfVWqtzhkl0xEp2tU0y50rjgJNiYrWLNEpGvSH1nO2NCs
         1JMg==
X-Gm-Message-State: AOAM5309Laz6/xNGivSmBVbz4uxj7tKmWQfR4CrDjPj8ssfwozOZMUPO
        8G7iCHlCnJBY3BJdfX5CzgrNAcmWFx8=
X-Google-Smtp-Source: ABdhPJwEDwUJ6o9gRoswQmQUrujTKk0BHjp6qTY0VikHa3ZbXFts9NVj6QNLjSuCZlCNzOz2Q/l52w==
X-Received: by 2002:adf:ce0a:: with SMTP id p10mr25381445wrn.255.1615248603220;
        Mon, 08 Mar 2021 16:10:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u63sm1218785wmg.24.2021.03.08.16.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 16:10:02 -0800 (PST)
Message-Id: <6497050c00126bdeff6880e5a2a52cd7b8457513.1615248599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
        <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 00:09:55 +0000
Subject: [PATCH v2 4/8] merge-ort: introduce wrappers for alternate tree
 traversal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
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

