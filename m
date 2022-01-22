Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA02C433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 21:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbiAVV4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 16:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbiAVV4K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 16:56:10 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D248C06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:10 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r132-20020a1c448a000000b0034e043aaac7so7693907wma.5
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tCi4MTvYjABxVi5b+7LScRWbnauYgvfL3kKR3ndeo4s=;
        b=eVgU92zL62b9D1Q7pOpic/eRHr6SmVjnqS1Z7EeeV+e4KnTYErvBaZ7/ifpufaQ6l8
         GJbFlxF8tpbSQc2E0TwSO9cXTuMfTlABy1OF0/u5XUsfdbU5ncBRTFK4U9bxOZQ0yq4+
         dBxaTh27Nsft7SvvoVx9qQ2Czftv+HjnM0R6dde0XD+dNtc8fb/tAikyhm4/LMwhOu4f
         AAVTc3O3CPQS4VYJutuG2iFgZTLC+tTXquImaDJBCxvVQPv7oYEbJUMUDvgW6fBeHHcW
         7Eu39wnnfoLutsWdcbhvXoemZkoE4YoPF6U/gkM/N3b5kG4K5vO5ymXxlhrCnp4pxcNS
         +pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tCi4MTvYjABxVi5b+7LScRWbnauYgvfL3kKR3ndeo4s=;
        b=0hcb29DhFIkGky2uMLUpk/7QWw1mG4qFUGD+Z4FHupIgaQY43Lig6EfPOnfAWboRmT
         buXwILaFzoI0U491lJU9aPeyMPh/MJ0kMsqXxRf/38CAEIfNlst2hN00XUMm5lApc76Z
         IHKCtKvbu6wtoaR8Cov9yP2kzrhxeqgXsWhL08bu0H8spSDgFm3umMAwhauCLYySoU+7
         E5Os9iLFHxCHRaW0Li/phqayu9KuqhIcbz8IGC4HgTaQxXP/unL8EK44ZIsroHVJKTue
         L7KiagwsfAtMQ/bwa1Q70NpUZbEerIX+EJhPyPI7792OUsf0c9KVM8Kdi+ehiaZmDvFl
         ujbw==
X-Gm-Message-State: AOAM532ho82dSqcN9snkR2W4FQSnwqJVPCUceaG1ovfpuXYrPWR4AuIB
        EPetLhfdh5jfaTD8rYYX2JEQFDVmc8A=
X-Google-Smtp-Source: ABdhPJxtJnPlnBZlJ4ZYu5+6q2E2DdNwzS2MtOX9WUBXLY1NecXVwYr7xMZ3mHXpxnGro9hfgQD8PQ==
X-Received: by 2002:a1c:4e1a:: with SMTP id g26mr5649023wmh.146.1642888568754;
        Sat, 22 Jan 2022 13:56:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm9453216wrs.93.2022.01.22.13.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 13:56:08 -0800 (PST)
Message-Id: <095aa266c2bfdda47ed722fbc5a0d9c94132fbf1.1642888562.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 21:55:55 +0000
Subject: [PATCH 05/12] merge-ort: split out a separate
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
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

No functional changes included in this patch; it's just a preparatory
step to allow the printed messages to be handled differently by other
callers, such as in `git merge-tree --write-tree`.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 77 ++++++++++++++++++++++++++++-------------------------
 merge-ort.h |  8 ++++++
 2 files changed, 49 insertions(+), 36 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 9bf15a01db8..f9e35b0f96b 100644
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
@@ -4273,42 +4312,8 @@ void merge_switch_to_result(struct merge_options *opt,
 		trace2_region_leave("merge", "write_auto_merge", opt->repo);
 	}
 
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

