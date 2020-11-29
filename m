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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED09C71156
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979CB2080C
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWXp//2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgK2How (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgK2Hou (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:44:50 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E57C061A4C
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:35 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d3so9022695wmb.4
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vc5zshdJXJ5K2pdJI4ibeIgV2YdLAdDIL4aCX2GIXEA=;
        b=vWXp//2wV1VXqBKzJ/wXQ5dM2yL9ZEU/RT9eTygYxw2GZYEsXkTGr1H76Mc73He7n7
         fzb/sSgMLkpswAQRveZ9Kn1nc+J/HZhSRHnFRv1noSqvJINKA96B07IKVPl5QcOm4vMf
         GcLxhhe8nNx3h3Z3Y+HNMBLeARhnqXfvZPYrKohlEMUgh5OewT9m789fw37HSnNjk+zC
         iMpvF6okfUCdxwhyoeyP3Q+HPDBT1Lo3ubgQc/8sBdxx8sL+i/8sbdbKAXMz7R5MHl5g
         VGsBRFS+vnn+cY9KRRPR8CsWcELU5KKxzLQCugq6qXvT14wqIQMRr3vySwwIV7xYIerf
         Jcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vc5zshdJXJ5K2pdJI4ibeIgV2YdLAdDIL4aCX2GIXEA=;
        b=h9DxDN9TVGKy6t/fEimMSkQccsKlUb9AmbWJh6RFIxW1Hguq2k/GXG1r0CqtUSuFO8
         1Z1ahjyxAAhA432m8ufyjVUHsTNrQYvpLuILaGFs31Wunc+bKG8jXYsoi+lehq0uof3K
         eTqRwd2H847YcI+L1KKrfRBZvjfRzopAmLxXBXeH6qAQacfJJwjl1otp36k+vvH4xJAE
         PNJ3Z93BhZ7VcxOKPmJrwriOTnqzYg6YYiK8JvzXKOnYsoGJGCBOzD5LwqiKc8Po3Bj8
         RygXmoSyS8w5CX0TyL25OG2SMQqN6A/Jkv9RxqJinuEeNrZQnaixBlLOWPC3SzyMTbv5
         JQhQ==
X-Gm-Message-State: AOAM531M5cMfXeOxyIx8ybYUDrVAw+PRLqunEgDH6znMTF/CgVB2Frk8
        jtObv7YyeNpiqN1w8Bs0h8RutMSWcB0=
X-Google-Smtp-Source: ABdhPJwEmPxBFo8LqyLXJUEhX2S2mCh34dp+mOCGPNu57S0Ztx3O12MdY5bOTGzJjYCkQB7fCGKGnw==
X-Received: by 2002:a1c:32c6:: with SMTP id y189mr17616754wmy.133.1606635814462;
        Sat, 28 Nov 2020 23:43:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm3769685wrp.3.2020.11.28.23.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 23:43:34 -0800 (PST)
Message-Id: <0c89cee34e5055dcd08013684acbe5d292e1a2dd.1606635803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 07:43:14 +0000
Subject: [PATCH 11/20] merge-ort: add a preliminary simple process_entries()
 implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add a process_entries() implementation that just loops over the paths
and processes each one individually with an auxiliary process_entry()
call.  Add a basic process_entry() as well, which handles several cases
but leaves a few of the more involved ones with die-not-implemented
messages.  Also, although process_entries() is supposed to create a
tree, it does not yet have code to do so -- except in the special case
of merging completely empty trees.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 0789816ae9..04127a32f8 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -465,10 +465,111 @@ static int detect_and_process_renames(struct merge_options *opt,
 	return clean;
 }
 
+/* Per entry merge function */
+static void process_entry(struct merge_options *opt,
+			  const char *path,
+			  struct conflict_info *ci)
+{
+	VERIFY_CI(ci);
+	assert(ci->filemask >= 0 && ci->filemask <= 7);
+	/* ci->match_mask == 7 was handled in collect_merge_info_callback() */
+	assert(ci->match_mask == 0 || ci->match_mask == 3 ||
+	       ci->match_mask == 5 || ci->match_mask == 6);
+
+	if (ci->df_conflict) {
+		die("Not yet implemented.");
+	}
+
+	/*
+	 * NOTE: Below there is a long switch-like if-elseif-elseif... block
+	 *       which the code goes through even for the df_conflict cases
+	 *       above.  Well, it will once we don't die-not-implemented above.
+	 */
+	if (ci->match_mask) {
+		ci->merged.clean = 1;
+		if (ci->match_mask == 6) {
+			/* stages[1] == stages[2] */
+			ci->merged.result.mode = ci->stages[1].mode;
+			oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
+		} else {
+			/* determine the mask of the side that didn't match */
+			unsigned int othermask = 7 & ~ci->match_mask;
+			int side = (othermask == 4) ? 2 : 1;
+
+			ci->merged.result.mode = ci->stages[side].mode;
+			ci->merged.is_null = !ci->merged.result.mode;
+			oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
+
+			assert(othermask == 2 || othermask == 4);
+			assert(ci->merged.is_null ==
+			       (ci->filemask == ci->match_mask));
+		}
+	} else if (ci->filemask >= 6 &&
+		   (S_IFMT & ci->stages[1].mode) !=
+		   (S_IFMT & ci->stages[2].mode)) {
+		/*
+		 * Two different items from (file/submodule/symlink)
+		 */
+		die("Not yet implemented.");
+	} else if (ci->filemask >= 6) {
+		/*
+		 * TODO: Needs a two-way or three-way content merge, but we're
+		 * just being lazy and copying the version from HEAD and
+		 * leaving it as conflicted.
+		 */
+		ci->merged.clean = 0;
+		ci->merged.result.mode = ci->stages[1].mode;
+		oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
+	} else if (ci->filemask == 3 || ci->filemask == 5) {
+		/* Modify/delete */
+		die("Not yet implemented.");
+	} else if (ci->filemask == 2 || ci->filemask == 4) {
+		/* Added on one side */
+		int side = (ci->filemask == 4) ? 2 : 1;
+		ci->merged.result.mode = ci->stages[side].mode;
+		oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
+		ci->merged.clean = !ci->df_conflict;
+	} else if (ci->filemask == 1) {
+		/* Deleted on both sides */
+		ci->merged.is_null = 1;
+		ci->merged.result.mode = 0;
+		oidcpy(&ci->merged.result.oid, &null_oid);
+		ci->merged.clean = 1;
+	}
+
+	/*
+	 * If still conflicted, record it separately.  This allows us to later
+	 * iterate over just conflicted entries when updating the index instead
+	 * of iterating over all entries.
+	 */
+	if (!ci->merged.clean)
+		strmap_put(&opt->priv->conflicted, path, ci);
+}
+
 static void process_entries(struct merge_options *opt,
 			    struct object_id *result_oid)
 {
-	die("Not yet implemented.");
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+
+	if (strmap_empty(&opt->priv->paths)) {
+		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
+		return;
+	}
+
+	strmap_for_each_entry(&opt->priv->paths, &iter, e) {
+		/*
+		 * NOTE: mi may actually be a pointer to a conflict_info, but
+		 * we have to check mi->clean first to see if it's safe to
+		 * reassign to such a pointer type.
+		 */
+		struct merged_info *mi = e->value;
+
+		if (!mi->clean)
+			process_entry(opt, e->key, e->value);
+	}
+
+	die("Tree creation not yet implemented");
 }
 
 void merge_switch_to_result(struct merge_options *opt,
-- 
gitgitgadget

