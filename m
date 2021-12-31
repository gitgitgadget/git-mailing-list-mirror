Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5786C433F5
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 05:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhLaFET (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 00:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhLaFEL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 00:04:11 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F6DC061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:04:11 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so14272500wmd.5
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yyx5E/EoX+z0wxqxgJYz0SAd+OfUcOzRqWnkfXXei3s=;
        b=FdXl69ZfS2OXX/anCk9Gn2osrALtcFeBqgbHFX0s/lYUSgfBRewaQD15PsSMYqYgHA
         wS6heyK1GPB6IcpQ/uu5H50uwtU1TT6c9fLjyn6K6/tIDu+99dnD7H/0g8qB6ZVB/cGc
         Oaro928vN7lYW88qnFL+Df2JVfToSc5G6/aPKnk8e7CuamoPqRG28S6qjkd8ZbEiZYIG
         kQHyfixRzjQp+tS1Gxn4crRMqG6haRgag+IllnV/1l5ZQs7z0y45QPacyGsWVFyk2Oc8
         Qc6wkaHbO/hhNH0SQ9hOo5K+qrBGnH1WcJiRvhg7zSs/H4RqexKdKzeJn02RHKHcY6C9
         MOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yyx5E/EoX+z0wxqxgJYz0SAd+OfUcOzRqWnkfXXei3s=;
        b=P1+PYC/JwnaEhDc62FUQ2RxoL50dRPFfVBw9F0yKbFC/Wg9rZ4OouUdYRDT0ccWyw5
         2Yxwf9DxrFT8ZCTnb1Car6gyQ4pgvZWhF815gaTZbJf3xmHgu3O/zLSDLDiIa1M3ZHyp
         tWeNKB6pAiRUXgjz18Fk7Pf6YOemNWvWwrsBDxBkbu0/XW5b4jA+V7uH2h+eDvPj/20t
         6UzksKUNDOXLba7QhLfpXdHBO8Y6Qo12TVFL2y7bdKpR5bzT6sIZPNvl8B4RfWugGmhH
         Tk0QHqPt1Vw65SBzNqYr/wX65ANL8m2Puh/HgwbxC/OoYtja7/hFzfEcFcv5u4G4RrL4
         kKBw==
X-Gm-Message-State: AOAM531fRi5jGkPbWxwgoKtcPuhXtQ8+IqhMYyXkAjMsdnSuifwVB14C
        3G0/jqJfXffmN4b80xNHoP5pDialSzw=
X-Google-Smtp-Source: ABdhPJykDCW4j7pgLMcLMb7mP8h5WcapCT4RRSPrgFnyT3d/z9KgEoS/LmXvJreDp7j74C2Wmrh1xg==
X-Received: by 2002:a05:600c:4e08:: with SMTP id b8mr28557238wmq.31.1640927049187;
        Thu, 30 Dec 2021 21:04:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm26340072wri.115.2021.12.30.21.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 21:04:08 -0800 (PST)
Message-Id: <aa816e766e9eb747be466bba3b74439aadc3332b.1640927044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Dec 2021 05:04:01 +0000
Subject: [PATCH 5/8] merge-ort: split out a separate display_update_messages()
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

No functional changes included in this patch; it's just a preparatory
step in anticipation of wanting to handle the printed messages
differently in `git merge-tree --real`.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 69 ++++++++++++++++++++++++++++-------------------------
 merge-ort.h |  8 +++++++
 2 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 0342f104836..6237e2fb7fe 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4197,6 +4197,42 @@ static int record_conflicted_index_entries(struct merge_options *opt)
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
@@ -4235,39 +4271,6 @@ void merge_switch_to_result(struct merge_options *opt,
 		trace2_region_leave("merge", "write_auto_merge", opt->repo);
 	}
 
-	if (display_update_msgs) {
-		struct merge_options_internal *opti = result->priv;
-		struct hashmap_iter iter;
-		struct strmap_entry *e;
-		struct string_list olist = STRING_LIST_INIT_NODUP;
-		int i;
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
 
 	merge_finalize(opt, result);
 }
diff --git a/merge-ort.h b/merge-ort.h
index c011864ffeb..1b93555a60b 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -70,6 +70,14 @@ void merge_switch_to_result(struct merge_options *opt,
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

