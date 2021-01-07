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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E49AC433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D900923447
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbhAGUCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbhAGUCN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:13 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A13C0612F8
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:32 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q18so6861138wrn.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MX2aW2g13Yn3qC4kR0lcJp3Y9xbONhy3MIMIOrlLn+A=;
        b=f/MTUUxEWVyrtnzPt97vtD+FPPhkdjmxXQEska/VTS3zn5GH96BhrCAa0+wShhoeZW
         ILDHk1ux4MDyE6UcYxYWLPY/kIGz1Z2zIv2dzqRlSr/+H1Z2F7bEEBibVAaDCfLzQTP/
         AQJYfK4Ag3Bk6PuVauUvNQKIdAx4QvwBZYQwdYbcHngXbL8TKPJGz3qr5T4qzKrOQ4xx
         Kkh3S+oTbczKPJEH9oZuIeVEXfnKj8T6Aha+As/n4d9OgiWRskMY9YIEHdW/VpXLiLnI
         WrnlDk4RIsDzm9hrQpY+c+OzICxSqRRAOvpbQO7iKBTFGdYmppJSOniS0qCBGVUDM+om
         t+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MX2aW2g13Yn3qC4kR0lcJp3Y9xbONhy3MIMIOrlLn+A=;
        b=t+1yumuK07wO7rycU3RjFVlofkdIL+QdUmNOVioPpyTm5pGyUKw3F7GzT3rLZRhf+r
         zZWmFowz42Cxj0NSRJ/sYiaZCmTLOslpxxDGjYIzEASNu6QMkv8knKy1pZI89AKQNn2P
         A019yZaGKtQyYm5BJ4l2PlKIds0svGVqoy/N5yDmGou2e9JPDhwzhK6lgbyKufiret/J
         q6vqoCbcbY/7w2DPXmdmcCnO+I81h5nWL714/Xltxk3TL9XjYN+U3Gi+EGDm0Ib1lHCv
         DT0eyp/g63huHYdZrIYws1RgmfijiRCtDNVRUwIJEMaG/OvR/PEyTX3idNemJGdp1QvU
         U5Fg==
X-Gm-Message-State: AOAM530qqy/cuTD0l5aWuvDeQ8J76RIzesmI8XLpjQOS/yz6uCmF8czU
        X5+tHcl7Fq0lfkW3yaOS+0mILQq018g=
X-Google-Smtp-Source: ABdhPJzOFxtjDXDdUbYawbx/ZX9rxcz8ZVXAcNaX5kNIwovVprjAk5kx/UrUcQwSG3QA2Un3tTu1bg==
X-Received: by 2002:adf:a1d5:: with SMTP id v21mr304155wrv.24.1610049691093;
        Thu, 07 Jan 2021 12:01:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c20sm9013447wmb.38.2021.01.07.12.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:30 -0800 (PST)
Message-Id: <762151802be53fbe0269bad721bb93ed84fd8f8b.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:11 +0000
Subject: [PATCH 02/18] merge-ort: initialize and free new directory rename
 data structures
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 652ff730afa..2e6d41b0a0f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -308,8 +308,12 @@ static void free_strmap_strings(struct strmap *map)
 static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 					  int reinitialize)
 {
+	struct rename_info *renames = &opti->renames;
+	int i;
 	void (*strmap_func)(struct strmap *, int) =
 		reinitialize ? strmap_partial_clear : strmap_clear;
+	void (*strset_func)(struct strset *) =
+		reinitialize ? strset_partial_clear : strset_clear;
 
 	/*
 	 * We marked opti->paths with strdup_strings = 0, so that we
@@ -339,6 +343,23 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	string_list_clear(&opti->paths_to_free, 0);
 	opti->paths_to_free.strdup_strings = 0;
 
+	/* Free memory used by various renames maps */
+	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; ++i) {
+		struct hashmap_iter iter;
+		struct strmap_entry *entry;
+
+		strset_func(&renames->dirs_removed[i]);
+
+		strmap_for_each_entry(&renames->dir_rename_count[i],
+				      &iter, entry) {
+			struct strintmap *counts = entry->value;
+			strintmap_clear(counts);
+		}
+		strmap_func(&renames->dir_rename_count[i], 1);
+
+		strmap_func(&renames->dir_renames[i], 0);
+	}
+
 	if (!reinitialize) {
 		struct hashmap_iter iter;
 		struct strmap_entry *e;
@@ -1812,6 +1833,9 @@ static struct commit *make_virtual_commit(struct repository *repo,
 
 static void merge_start(struct merge_options *opt, struct merge_result *result)
 {
+	struct rename_info *renames;
+	int i;
+
 	/* Sanity checks on opt */
 	assert(opt->repo);
 
@@ -1846,6 +1870,17 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	/* Initialization of opt->priv, our internal merge data */
 	opt->priv = xcalloc(1, sizeof(*opt->priv));
 
+	/* Initialization of various renames fields */
+	renames = &opt->priv->renames;
+	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
+		strset_init_with_options(&renames->dirs_removed[i],
+					 NULL, 0);
+		strmap_init_with_options(&renames->dir_rename_count[i],
+					 NULL, 1);
+		strmap_init_with_options(&renames->dir_renames[i],
+					 NULL, 0);
+	}
+
 	/*
 	 * Although we initialize opt->priv->paths with strdup_strings=0,
 	 * that's just to avoid making yet another copy of an allocated
-- 
gitgitgadget

