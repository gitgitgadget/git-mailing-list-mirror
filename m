Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7326C433F5
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 20:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiBLUfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 15:35:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiBLUfE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 15:35:04 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68874606E6
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:35:00 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n8so2558192wms.3
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hBf1L3DAgwM6lVnjfgVq6LC6AtXTGHUlM38V8n4wdp8=;
        b=Zt5YSo8T8BEc/GQsguQJwWgiwWOoPkOz9+NK4ImCFDbZGBrg40r6UoFSXZn70hsmVH
         VJuqikyByFChMMb7GVYkqLkNhptrUMbgsGRJzpRA7lMk+OYtO5o4fcRqnLIVQdPyzBHS
         B8JGrSP4dzf7ny6jjyrEEAVhp7hHVOysisZiPRdv9RMa7pzxU0MNXySKH80X0Lx1aIL4
         Eia4yQJATrBYU/uAGdhkhXqSEhp6/1y5Px/5uXhIp/VDPNfukk0E5pmV7i7J2NkVzAUR
         ByPrco/GzyoiFuR3/vW3RgDN/AiTKJ+FjZVx3Ms7LA22B2/oNtoLSa+dgZuUY4k4gGOr
         wwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hBf1L3DAgwM6lVnjfgVq6LC6AtXTGHUlM38V8n4wdp8=;
        b=SIwhgIutcnRpVdq/8L+i4KxrRjHr7fvF05QwK97Gz/WCIMDoUA9Eqa4uJ4rU8aj6CX
         ymtAmotBhZzQ5FH43zcHXsJlr2o/hRLHOSIEX5u+I97xyHxgCohG7uZ/+cNv7DkL6yC6
         WUek6ggAiWUFOosVC3m3Vsxw6UstFbkZIlh3MYbsA2H8A38qKfO0cGqoIKbKk+i1gAKi
         +9cKaD6fIgfCRVNy4a/w+sJ7oWm6pRgflWFDaCq21oJWXHgGLhxF7nC8NIKeqhbhIlyP
         nNcXi7ARDp5ocdlhOni5C/nc/pIJMpJyg8VK69tYtKUv7GlNjPkCXYsdWUQQnM9PoU20
         VAjA==
X-Gm-Message-State: AOAM532k5vmOJ13GTswFOUIL08wxRIBo2ewgQDVbg1kZpPGCyUIANG9J
        e9fMlsi2vslIaE+7XJF2kgZi8jzIgRI=
X-Google-Smtp-Source: ABdhPJysQ8itZZsiypzL5N5v0xFcpKXgQzsc6pVRhyPrFg5gpnP+bgaXltNKLh7RNfVgE0f36u14Ig==
X-Received: by 2002:a05:600c:2551:: with SMTP id e17mr5207153wma.128.1644698098735;
        Sat, 12 Feb 2022 12:34:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11sm27965907wry.68.2022.02.12.12.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 12:34:58 -0800 (PST)
Message-Id: <58a5594aeb6e04e21409835e00c721a7417569df.1644698093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
References: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Feb 2022 20:34:46 +0000
Subject: [PATCH v4 05/12] merge-ort: split out a separate
 display_update_messages() function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This patch includes no new code; it simply moves a bunch of lines into a
new function.  As such, there are no functional changes.  This is just a
preparatory step to allow the printed messages to be handled differently
by other callers, such as in `git merge-tree --write-tree`.

(Patch best viewed with
     --color-moved --color-moved-ws=allow-indentation-change
 to see that it is a simple code movement.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 78 ++++++++++++++++++++++++++++-------------------------
 merge-ort.h |  8 ++++++
 2 files changed, 49 insertions(+), 37 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 9bf15a01db8..ebaed98d53a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4235,6 +4235,45 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 	return errs;
 }
 
+void merge_display_update_messages(struct merge_options *opt,
+				   struct merge_result *result)
+{
+	struct merge_options_internal *opti = result->priv;
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+	struct string_list olist = STRING_LIST_INIT_NODUP;
+	int i;
+
+	if (opt->record_conflict_msgs_as_headers)
+		BUG("Either display conflict messages or record them as headers, not both");
+
+	trace2_region_enter("merge", "display messages", opt->repo);
+
+	/* Hack to pre-allocate olist to the desired size */
+	ALLOC_GROW(olist.items, strmap_get_size(&opti->output),
+		   olist.alloc);
+
+	/* Put every entry from output into olist, then sort */
+	strmap_for_each_entry(&opti->output, &iter, e) {
+		string_list_append(&olist, e->key)->util = e->value;
+	}
+	string_list_sort(&olist);
+
+	/* Iterate over the items, printing them */
+	for (i = 0; i < olist.nr; ++i) {
+		struct strbuf *sb = olist.items[i].util;
+
+		printf("%s", sb->buf);
+	}
+	string_list_clear(&olist, 0);
+
+	/* Also include needed rename limit adjustment now */
+	diff_warn_rename_limit("merge.renamelimit",
+			       opti->renames.needed_limit, 0);
+
+	trace2_region_leave("merge", "display messages", opt->repo);
+}
+
 void merge_switch_to_result(struct merge_options *opt,
 			    struct tree *head,
 			    struct merge_result *result,
@@ -4272,43 +4311,8 @@ void merge_switch_to_result(struct merge_options *opt,
 		fclose(fp);
 		trace2_region_leave("merge", "write_auto_merge", opt->repo);
 	}
-
-	if (display_update_msgs) {
-		struct merge_options_internal *opti = result->priv;
-		struct hashmap_iter iter;
-		struct strmap_entry *e;
-		struct string_list olist = STRING_LIST_INIT_NODUP;
-		int i;
-
-		if (opt->record_conflict_msgs_as_headers)
-			BUG("Either display conflict messages or record them as headers, not both");
-
-		trace2_region_enter("merge", "display messages", opt->repo);
-
-		/* Hack to pre-allocate olist to the desired size */
-		ALLOC_GROW(olist.items, strmap_get_size(&opti->output),
-			   olist.alloc);
-
-		/* Put every entry from output into olist, then sort */
-		strmap_for_each_entry(&opti->output, &iter, e) {
-			string_list_append(&olist, e->key)->util = e->value;
-		}
-		string_list_sort(&olist);
-
-		/* Iterate over the items, printing them */
-		for (i = 0; i < olist.nr; ++i) {
-			struct strbuf *sb = olist.items[i].util;
-
-			printf("%s", sb->buf);
-		}
-		string_list_clear(&olist, 0);
-
-		/* Also include needed rename limit adjustment now */
-		diff_warn_rename_limit("merge.renamelimit",
-				       opti->renames.needed_limit, 0);
-
-		trace2_region_leave("merge", "display messages", opt->repo);
-	}
+	if (display_update_msgs)
+		merge_display_update_messages(opt, result);
 
 	merge_finalize(opt, result);
 }
diff --git a/merge-ort.h b/merge-ort.h
index fe599b87868..e5aec45b18f 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -80,6 +80,14 @@ void merge_switch_to_result(struct merge_options *opt,
 			    int update_worktree_and_index,
 			    int display_update_msgs);
 
+/*
+ * Display messages about conflicts and which files were 3-way merged.
+ * Automatically called by merge_switch_to_result() with stream == stdout,
+ * so only call this when bypassing merge_switch_to_result().
+ */
+void merge_display_update_messages(struct merge_options *opt,
+				   struct merge_result *result);
+
 /* Do needed cleanup when not calling merge_switch_to_result() */
 void merge_finalize(struct merge_options *opt,
 		    struct merge_result *result);
-- 
gitgitgadget

