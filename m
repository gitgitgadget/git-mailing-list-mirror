Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39FEC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 17:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242204AbiAER1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242207AbiAER1m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 12:27:42 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07F7C061201
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 09:27:41 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l10so3134899wrh.7
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 09:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DqeyVr+nI1KAiXNxyyhFxkZcB/WDtjcchYITzz1UKpY=;
        b=l6FfncQjex7bB2ZWtw6DWiPcQb4PP1bjqHl/Ft75+8tLeMmYGSGR+g9el+GAvmGQf1
         uuRayV2aasxuLn9KIa+OzCF++lnFDcttPLEA/SrXmj58fdIVIO8b46kn65x2jVOmRuae
         uRM7+3WQpTHMUe6SWRp3sJzxZZacUgAsAHGQlJgNUBISvWsVDDU8ncIpwB/tlRYL7An9
         1tc6YSUCGJmINz7UeaibZSmxOfWP2G5tp+4lImTSDQzNM/IyFo3trmm2OdHWL2+ThsC3
         cvP+xEgUMWCwI0Bm5mJTDqG1yW8W/AlvWLo1d9z5WuCcGgPfVO0jn3xcF8fud2uOVUBd
         IWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DqeyVr+nI1KAiXNxyyhFxkZcB/WDtjcchYITzz1UKpY=;
        b=L7n8fB8eV9rMwUnWSfcXb7MqXJcs6UfyxUiZ1spmVD4G2lWP72wXugpyFqS0pS4nce
         qsfzqIA1nKMuIQ26oyXqeT04O8esvElt/5llY3Jq42Xsf3/Y4/IJLQ6VnDEJPhMPgWP3
         /rP3ZBsZYlPyMtC/BMeAdLWT4EOp0CUarktWpqOoXkSTgPOrShHvCBe046NNhkHhX0+z
         +PvoK5CRvFNLizKGOaRNI5OngKsd7VpMKf0Zozf3+erMRCG0n1SriXrrjgJj+csFOnBQ
         uZCmOherzuSnfZRR+GOcRePUnDSw+40HnaZetO/9MNRgyhDUsIBnPGsr4UAb7KmriHp5
         f+TQ==
X-Gm-Message-State: AOAM530xs6WWSxMuxH9lZZ3fQF5f6eY+81sUcLG3OPuoF4/FjESYdLjI
        4bGT728tyNg3AD5pH5fjPIVHzGgHcRw=
X-Google-Smtp-Source: ABdhPJxg1Okj2a4FjJhfEgXKlVgAsNx41niBnPAWhocNNoTOqCk4FCBi69JtjUbhLXonswEns8UP3A==
X-Received: by 2002:a05:6000:1843:: with SMTP id c3mr48335423wri.316.1641403660176;
        Wed, 05 Jan 2022 09:27:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z22sm3601294wmp.40.2022.01.05.09.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:27:39 -0800 (PST)
Message-Id: <bc6d01f1a0e735dcf23e7ca3ed0672bd3c4d7993.1641403655.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
        <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 17:27:32 +0000
Subject: [PATCH v2 5/8] merge-ort: split out a separate
 display_update_messages() function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
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
 merge-ort.c | 71 ++++++++++++++++++++++++++++-------------------------
 merge-ort.h |  8 ++++++
 2 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 0342f104836..3cdef173cd7 100644
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
@@ -4235,39 +4271,8 @@ void merge_switch_to_result(struct merge_options *opt,
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
+	if (display_update_msgs)
+		merge_display_update_messages(opt, result);
 
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

