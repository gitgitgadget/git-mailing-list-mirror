Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33016C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352949AbiA2SHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353008AbiA2SHV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:07:21 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A585C061714
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:21 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c23so17159314wrb.5
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j6pXtRrQ5I7U6AZABoGpx0sRmJ81EY6GY7ESSrFm0DM=;
        b=gLtUqYP98r3jRp8dYTlUwj0+OGzdun5KRyTplfaCM/Go4BYGGbJ2ynIf313mnvZCy+
         /bPT7zWCad2a6jDuslqvANriSRKjd/90uH7OeaftvF8/ybBXiQg+oQmSDSCwbdBd435t
         e2ysuL2f0wQ0k65UyJhEkJfC85+ClV7su4lWDCnGRk+95Kgz9Se2ETYDNxU8RFUYWfAo
         jQOzGgUmy1YzV3Jowq3mEN0AmNWY0KoxDDibKIBwnN1qJuq9Nawjxg4cpq8gRAMgDKHW
         Kx87FE4fWfNp+SV/Xa+V6t3blEb9nFaOsQraGQYIE3ZGBWDTZrwTeE3kqdLHKEO6n22+
         VWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j6pXtRrQ5I7U6AZABoGpx0sRmJ81EY6GY7ESSrFm0DM=;
        b=WCSG81/I4e8WWEmbHeVwZF2w+HqVRuUBvNo4l5Xpejiol7yd37MrCZtP9lxDunS4sa
         7tRJuN3O82P98JFOw5juMTFLRARu3Ht9zN2Oyqljfw/MBS+LsxfbSKO5NUQvTGkGo2hG
         0qPHpByg7ccJmNDGOy+Ky+oxxvLyIViZwM2uoCC3tj6x3xuf7+F8Y5pf8BU9ExvSHlDL
         VW1e/G1M9TIV5cMqUUStoNSPpiws5LDa421GLHwjBvl/Y8AzOZNbtS0+a1+eWQQJkL+9
         d75v0XT2NS05t4JBn5UcBSh2SSGpw1FjcPfJN50uBUl7rjfJAcSGfp7VFrvzZ8Wai/4Y
         nWRA==
X-Gm-Message-State: AOAM533vwSWu0NsD3s/RcmNeS8nZ1tM5b4T0C4kBRkyFRLjP3bW6SSOV
        c6Jj2305oWHzS6aLSsbsy0pPMZwNO10=
X-Google-Smtp-Source: ABdhPJxM9QjAlZbnuUWbbpg6QVtsjD4PSJZEAQY51B23USx3nKTRwkz72hy6A4QCZ56hJFwRVKZW5g==
X-Received: by 2002:a5d:6d05:: with SMTP id e5mr10999423wrq.398.1643479639839;
        Sat, 29 Jan 2022 10:07:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e10sm9062296wrq.53.2022.01.29.10.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 10:07:19 -0800 (PST)
Message-Id: <28368c03898047e2e5d3d3c4ad7ffef517ff2450.1643479633.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Jan 2022 18:07:06 +0000
Subject: [PATCH v2 06/13] merge-ort: split out a separate
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
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
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
 merge-ort.c | 77 ++++++++++++++++++++++++++++-------------------------
 merge-ort.h |  8 ++++++
 2 files changed, 49 insertions(+), 36 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 65618048b59..1ada3198390 100644
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
+			       opti->renames.needed_limit, 0, stdout);
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
-				       opti->renames.needed_limit, 0, stdout);
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

