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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88703C4332D
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 576CB64FD2
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCKAiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhCKAig (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:38:36 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E5FC061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:38:36 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso12149289wmi.3
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ijB+6Mdz6kINhfvqDLL7RglzBui/VGymAbp4nuQDrWc=;
        b=TWhDMG6scPGAGR/GMgxU5JymLAwCPxDLodleRB8LxnG4qWxU4y6ZarBY51TOUF5hA+
         M24dK/CSY+NDUyU6B+luhYJSgP8ZrwTJxyPC3z/ieE4XAYnEQHpDKc67GF/GsHxlvLNE
         8V3mWDvjgudogfCmhcOVnqvGNrocha2feqAxmznaA9BTzMCi//NjtjR1r7V/Z/9RVMmW
         p3qF7T1UazMmF/1R011qq+sS6HiA6MVdFfj3FZFkjb7c1lyAWwqJJadczl9ZJTecza4o
         dB48KaUhoyvlFPV5wUBz1ocKgPEe7eXXtu3fPeM1dtW/XU5Iij16QhmofgQwjYJ5o/l0
         Ji7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ijB+6Mdz6kINhfvqDLL7RglzBui/VGymAbp4nuQDrWc=;
        b=WkmkQZc24w77qF554rjqIRydcoUGN7ZUXv7OqVh6VqvKpwS/baUMfl+99h43/6Blq2
         /jA8uakcENXem+XtYivZvseambVam7SrooZvbO+qw3VTtfxPIVeJ4YkL05XN/9aFFRkm
         xLNfQ5C9pACb3p0AXO8J5FlWa51OgxeJTjLocZtkt8Z3a8Gi8TXV2TExztTeMMRFTTdC
         nxIJBP8g33kQjcdeLvKe+0KxAXZiKI5ikk5y9mdQROdq2cW0AhbFeyyPzRaOIFAWjb3T
         gSrL5K+l9eSCYH6SHF7Bz7ngaPk9X0UZAZfMS6opAfvQ19ntt9DAtlWCwkGhbjOxDV7M
         s3Ag==
X-Gm-Message-State: AOAM533jktotJ/Ug4bod3sjMhLHzvxSoxGOxM8XDSW5+p/37tk1WPVN5
        VOOJ/Mw2a8pboIXyu2ELEeo0o/t655o=
X-Google-Smtp-Source: ABdhPJxIOugkWnRs2F2NdXnqVfslWpkspc5BMg7Jon5zC9qMdq4lZIC8b5rmJIhDOpiQ/a3sUOdWfA==
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr5676257wmd.78.1615423115255;
        Wed, 10 Mar 2021 16:38:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16sm980853wrx.79.2021.03.10.16.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:38:34 -0800 (PST)
Message-Id: <b595245fe9020c06601c6a6c6c8d98b09af4a400.1615423112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.v3.git.1615423111.gitgitgadget@gmail.com>
References: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
        <pull.845.v3.git.1615423111.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Mar 2021 00:38:27 +0000
Subject: [PATCH v3 4/8] merge-ort: introduce wrappers for alternate tree
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
        Derrick Stolee <stolee@gmail.com>,
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
 merge-ort.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index d49cfa8b030b..f8f7d06d481a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -512,6 +512,77 @@ static char *unique_path(struct strmap *existing_paths,
 
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

