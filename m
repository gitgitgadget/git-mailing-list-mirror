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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A8AC43460
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79CC961186
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhETGLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 02:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhETGLK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 02:11:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D9EC061761
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c14so14507095wrx.3
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QxaomOQWmRs1WCVoiFKoy5ggkzdp2hH9m5ncuclAiCI=;
        b=l0vyV//167f6xei/M8Riz6lpGcyCxf5Z3/Kj2oPzaFV2cpz9OprnSLIuaMZR9QeOo3
         ZDA7FIYiJ2LfcVgbcudsaqZx1WKol6gOobCVFMluD7xGCJuHiTSf/AfRhOOBNCdTOULF
         v6VwQ95ckWUqNOoSxy5sPfG5/a4S8V9nb+uujMXeWAkxw1Tw79W3O3FqIOZXzB3LwRIM
         gKoPyM3XtA+4DYwOk86fSsJSaCroD5is2FnZ5tbOmvUasZC6tzEQDXrlgw9xWjxGYqHj
         otZFuKKPazw5u9ymUfBBneEjdd4Q9ody2alP29LuzhMv/1WaGG379unhXeLy+Ph0K/wX
         OiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QxaomOQWmRs1WCVoiFKoy5ggkzdp2hH9m5ncuclAiCI=;
        b=c7kw6bg7WmkHmQpgL93ukBK/eBnfR/TfHpTn5qbH4mUWV7k/rBQzRoVxLazhAzZtmK
         tcNgut56bY7/S2z+OAS6znZURp/Lnu1TpiSJ+NQ+sylMKgPNI50iiUkUgy1Yf0rL6SdK
         haJ0Aif7fGV31tF0RkIZOx2jSl0KKh9WjMPJv3NikuyJEQ930FmWqgxQOyqk6YIGZlwz
         /rKIsun7SegQLXm1f2WLS0sVGG4EXxAELtoFd7KpyA+4PhTOXzTy9k+uBfwzo2NSEGHU
         of+LvoXYjNuftUQISaFch8s7zPH0dKsfp+zp0hRZSxnCfAsaP4bAVczW7VI+7yVBGjCo
         rPIg==
X-Gm-Message-State: AOAM531u0QLbs59kNNJzKwAL1dmXZnKoHJmfi59Swkyhc4s27nsIub/A
        chVlgD1b5sbnsnsIACANYlckhVOPt6c=
X-Google-Smtp-Source: ABdhPJxUfpOe0vwCahI1pC+DxmQBC/g7tpZp3NxVlCMhFXDzYerQ0U+q57ztV2kGw4Mdg2ZE/x+/gQ==
X-Received: by 2002:a5d:4744:: with SMTP id o4mr2037041wrs.86.1621490988079;
        Wed, 19 May 2021 23:09:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s1sm8463970wmj.8.2021.05.19.23.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 23:09:47 -0700 (PDT)
Message-Id: <5a2f3b7b86722c088a2da660f08ce51688e44769.1621490982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
References: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
        <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 May 2021 06:09:35 +0000
Subject: [PATCH v3 07/13] merge-ort: populate caches of rename detection
 results
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Fill in cache_pairs, cached_target_names, and cached_irrelevant based on
rename detection results.  Future commits will make use of these values.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 709445e817ad..da9026524aa5 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2344,6 +2344,67 @@ static void resolve_diffpair_statuses(struct diff_queue_struct *q)
 	}
 }
 
+static void cache_new_pair(struct rename_info *renames,
+			   int side,
+			   char *old_path,
+			   char *new_path,
+			   int free_old_value)
+{
+	char *old_value;
+	new_path = xstrdup(new_path);
+	old_value = strmap_put(&renames->cached_pairs[side],
+			       old_path, new_path);
+	strset_add(&renames->cached_target_names[side], new_path);
+	if (free_old_value)
+		free(old_value);
+	else
+		assert(!old_value);
+}
+
+static void possibly_cache_new_pair(struct rename_info *renames,
+				    struct diff_filepair *p,
+				    unsigned side,
+				    char *new_path)
+{
+	int dir_renamed_side = 0;
+
+	if (new_path) {
+		/*
+		 * Directory renames happen on the other side of history from
+		 * the side that adds new files to the old directory.
+		 */
+		dir_renamed_side = 3 - side;
+	} else {
+		int val = strintmap_get(&renames->relevant_sources[side],
+					p->one->path);
+		if (val == RELEVANT_NO_MORE) {
+			assert(p->status == 'D');
+			strset_add(&renames->cached_irrelevant[side],
+				   p->one->path);
+		}
+		if (val <= 0)
+			return;
+	}
+
+	if (p->status == 'D') {
+		/*
+		 * If we already had this delete, we'll just set it's value
+		 * to NULL again, so no harm.
+		 */
+		strmap_put(&renames->cached_pairs[side], p->one->path, NULL);
+	} else if (p->status == 'R') {
+		if (!new_path)
+			new_path = p->two->path;
+		else
+			cache_new_pair(renames, dir_renamed_side,
+				       p->two->path, new_path, 0);
+		cache_new_pair(renames, side, p->one->path, new_path, 1);
+	} else if (p->status == 'A' && new_path) {
+		cache_new_pair(renames, dir_renamed_side,
+			       p->two->path, new_path, 0);
+	}
+}
+
 static int compare_pairs(const void *a_, const void *b_)
 {
 	const struct diff_filepair *a = *((const struct diff_filepair **)a_);
@@ -2426,6 +2487,7 @@ static int collect_renames(struct merge_options *opt,
 		char *new_path; /* non-NULL only with directory renames */
 
 		if (p->status != 'A' && p->status != 'R') {
+			possibly_cache_new_pair(renames, p, side_index, NULL);
 			diff_free_filepair(p);
 			continue;
 		}
@@ -2437,6 +2499,7 @@ static int collect_renames(struct merge_options *opt,
 						      &collisions,
 						      &clean);
 
+		possibly_cache_new_pair(renames, p, side_index, new_path);
 		if (p->status != 'R' && !new_path) {
 			diff_free_filepair(p);
 			continue;
@@ -3712,8 +3775,16 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 					 NULL, 1);
 		strmap_init_with_options(&renames->dir_renames[i],
 					 NULL, 0);
+		/*
+		 * relevant_sources uses -1 for the default, because we need
+		 * to be able to distinguish not-in-strintmap from valid
+		 * relevant_source values from enum file_rename_relevance.
+		 * In particular, possibly_cache_new_pair() expects a negative
+		 * value for not-found entries.
+		 */
 		strintmap_init_with_options(&renames->relevant_sources[i],
-					    0, NULL, 0);
+					    -1 /* explicitly invalid */,
+					    NULL, 0);
 		strmap_init_with_options(&renames->cached_pairs[i],
 					 NULL, 1);
 		strset_init_with_options(&renames->cached_irrelevant[i],
-- 
gitgitgadget

