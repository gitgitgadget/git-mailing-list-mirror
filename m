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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31F8C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA7C2310D
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391807AbhASTyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729609AbhASTyi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:54:38 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223F2C061757
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:53:58 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m187so884937wme.2
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MX2aW2g13Yn3qC4kR0lcJp3Y9xbONhy3MIMIOrlLn+A=;
        b=ItIQfI+f5vMNPDap+5SgJ/p+V6BIdWWnLQRv7SNecpKe9/s6ZSKqUwB1b3gcyJt1vV
         V0WlbSABSA5zr7oJ9P0k+yUyCXDY5cgarwIv8RAtx8dLDIm8HHP30NcHNEr1aJe9R4u9
         78dJCb4NH2Nw/1f2Frl/o0zfOC5QngLd/NNqtvWEBIM+wKOuzEhVMdJga40nNY8FncY/
         9/K9eQO/0ld/5Z2SVjdqwtFUZLOS6b4GtCxhYcZ6Bz81gWbT4jAft3Lq8jiSKzJ4PKHa
         48RzUYdiIiUOoVU79ti5yxoxuTTz8BTMmGgy2409ZbfgqEcq889NWQepLuIFWMB0MGCv
         jMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MX2aW2g13Yn3qC4kR0lcJp3Y9xbONhy3MIMIOrlLn+A=;
        b=o1XWrQzQ5UaoBVQqHo3pO4POf0n1Qs8C+KyUZBYJ706C1rY2CL4C4fefL2z34CZyJ6
         ebj4mCUuA5BicpEQNy01vhrmsZRR1ezsRBZKHXTikW7D7SfcQ51i+hzkCBqtdzvTtEEe
         IUbSZoQd9jdyByeMMytKAIXeJYFdiQSRCYoxtzU2iMM9tMUFEHuJOJ14WNQPYu2fjZwg
         oWDF1jGuLp91lTVCTi3pgcF5qU15HhcmN6b58d0d26+dj1Pp1rM8loHr5ykY4AfG3gIs
         FHspkNOLX8l7KgAv7iG8fdlFuU74AbeWHiTcqZtWyp9hWWso0sulCk7hkoQSkq+6lwpL
         8Btw==
X-Gm-Message-State: AOAM5328KbHLNI47Rgo5ACKQjiqGSIuy00Yc/vSpSPRHaIUKCKEv/1sR
        07h5zHhGsjerlkGp+a60IGZUKbc1QNc=
X-Google-Smtp-Source: ABdhPJzT3T1dzhqWOUV6UCKp9/ZddVA3axsikttmGtKIRizbM3McAiAupygQeF2UuAQxTRA1DpUdbw==
X-Received: by 2002:a1c:9dd5:: with SMTP id g204mr1101642wme.37.1611086036717;
        Tue, 19 Jan 2021 11:53:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm5491726wmc.13.2021.01.19.11.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:53:56 -0800 (PST)
Message-Id: <9da04816c3b712242d111b98ddc2558c91f44f2a.1611086033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
References: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
        <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 19:53:38 +0000
Subject: [PATCH v3 02/17] merge-ort: initialize and free new directory rename
 data structures
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
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

