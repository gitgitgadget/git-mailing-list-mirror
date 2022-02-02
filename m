Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48546C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 07:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbiBBHfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbiBBHev (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 02:34:51 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA674C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 23:34:50 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a13so36590974wrh.9
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 23:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3b+i8wSzWUdkX2iYVL0L852mgfOFWSqFUSZSzKk1xq0=;
        b=THk0xAJlzmmZU6bg+AZs8YW9EWIWiYljE7AkJrneQVJaKw4KsfVfkpmajWRviN0htj
         BKEpACmsu56dr6jbdUEU/lfFTrWkrZ6vZ3zmBl2ocpR588erjRkJ7CukrYrFACufRBAY
         MTc1BmjlRzbVYt7ac9g+jUeFioxrFTpY7fEftVdK/orYafDgJGHSY8nluwBIWfJgJypq
         1IgbneSZHgAXCqkeHtf5kjV657oYZeJfYz4NDfMs+w7wrSYExGgV/P/HS5AZ+dGhF7lT
         zIPTVKPAkDwH0LdTdEteZjvViA31wOH4Mwjt+wbsePdQr1YLkB8YPAv3NxLbniGdipGS
         wrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3b+i8wSzWUdkX2iYVL0L852mgfOFWSqFUSZSzKk1xq0=;
        b=3AivnMqEgIdhTb9B+Z1p6Wfp8qF9O60Hrs7HX4a7UtphKsf9YnnrRWU27rwsw9yklf
         BQ5ac5ccv+5YlR66YnfqBr8av1PsRfZU8QGz9DZtSN5vxbRzMlRx/VA9F6gKK/gAS4PD
         qs4FWDuoSb2EB1DniQz0pVH2LS22Wrhrg8URMkWheNTJJVMAG1ex+FARMB0+g3mD2E7p
         D692m2zcs+7YvkofVeFrAOhDPszJwS3vwX7pgE5OYifP6vLqdACMOpm6JzJjYy5jTL/6
         VJLNfETjsxXfdcUwVa+iycZlP5ZjGKFHEeonG1+5PA9g405onpmZgzOc6N3tT8kbPzXF
         2NSg==
X-Gm-Message-State: AOAM533II72dnRZUdMZQxlQ+TLv8X2DboHC3H6IOHzFOWStPFekn+TQX
        2a3Zjjgp3Yy9ucmTgQ1u4ZAHhrCqXd0=
X-Google-Smtp-Source: ABdhPJwrfG+aloMymP6XrOMXDTgwdqRzg63tv223sSdIP9K37czdZkdK91uLr6s5vk6QbhACcLMIKw==
X-Received: by 2002:a5d:590b:: with SMTP id v11mr23814503wrd.74.1643787289095;
        Tue, 01 Feb 2022 23:34:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5sm900576wrq.31.2022.02.01.23.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:34:48 -0800 (PST)
Message-Id: <1be858e6aa64e6c04f827bf2cabe39a29283454d.1643787281.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 07:34:33 +0000
Subject: [PATCH v3 07/15] merge-ort: split out a separate
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
index 46e72b62880..82d2faf5bf9 100644
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
+			       opti->renames.needed_limit, 0, stderr);
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
-				       opti->renames.needed_limit, 0, stderr);
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

