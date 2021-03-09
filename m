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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99155C43381
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D10564FFD
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhCIAK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 19:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhCIAKE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 19:10:04 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A6CC061760
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 16:10:03 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so4865601wmi.3
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 16:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fcQkjCw6zC06N7gSUFzG0EzW9qGvc97YSBo5+h04zSE=;
        b=Hr3m+oxI1mZ1ObFGocXO8rhD1+DcAdjx1m13AFYTC+7GKogNa3PKfGg40jIyJBikn3
         CWUyOPnE2tQt3B0S9QHhQuE9Wf1ci+nkMh961UirH33VC/lYrMqcSqk+d7E8w9HoP9dy
         fyM9pSq/cnn5s+Yrn+PLAjYJg1PtC9EkRD7BXc4AmZ/s3+fXC4yEVgmYbDdrbTUUESZK
         Z/alIv+jjRqD+iT9R8bPLrtqgrdhDHMNY7/RP6Uy97MRES8PXRNNzB635MA6q5pN033c
         Q8GQanOnMjzgZheIIig+nl/VeqApHb8JGEKh0PCZnqRVZQEXsVHluRynYyjbYZ+/MhJF
         q8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fcQkjCw6zC06N7gSUFzG0EzW9qGvc97YSBo5+h04zSE=;
        b=RrhKtWxGXhN3W6GvvGdrjpJ3ItiVgZNtof5Hl1nIpCAIpuvI6dLvxcyyCBvvqQiT7G
         d1ZtAcp5rbtaN5B8EP3t9kdo4sRFRXmIO8uby7Q6TQ/YskBUll7F+oUCnsquOrmjRUg2
         gWuoTXOAFBBvA4LLuRRj2wLIOWhiIx1ursPOfhltibyJicHpgXXwkmU4lIewluQtvYv8
         ieeY4hcFF4R6S2z1v6xAwG/Z8IPSN5VzcKdXjZ4HFfDVS7gfrWdwb2dYzml4xKctIGHT
         Kub+0AN0bCyj0qrD5f9Mdq0EwA1rpY7xqwtp2ux7Hn1aLo83Njln2bRJEKymHQtdkV6W
         6Btw==
X-Gm-Message-State: AOAM530V7Ybh2IZWan6EzLn2fcY+UN8MELYttaCmmAqA6AON6yZHcQJU
        ALe+ErR28brV4penJ4pQlM/6j+RwokQ=
X-Google-Smtp-Source: ABdhPJw1w1V7HUAk13udSdmpZez9bJqLv9xZv4UOX7YM0ni+G546xui+CplbaUrsVGlMMoqgWP7c1w==
X-Received: by 2002:a05:600c:2cb9:: with SMTP id h25mr1155038wmc.110.1615248602681;
        Mon, 08 Mar 2021 16:10:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k11sm1311563wmj.1.2021.03.08.16.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 16:10:02 -0800 (PST)
Message-Id: <89b43c9f75a03ab8cc258db8e6a1137e6e6fbb3f.1615248599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
        <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 00:09:54 +0000
Subject: [PATCH v2 3/8] merge-ort: add data structures for an alternate tree
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
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In order to determine whether directory rename detection is needed, we
as a pre-requisite need a way to traverse through all the files in a
given tree before visiting any directories within that tree.
traverse_trees() only iterates through the entries in the order they
appear, so add some data structures that will store all the entries as
we iterate through them in traverse_trees(), which will allow us to
re-traverse them in our desired order.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 83aa4c08121f..d49cfa8b030b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -51,6 +51,12 @@ enum merge_side {
 	MERGE_SIDE2 = 2
 };
 
+struct traversal_callback_data {
+	unsigned long mask;
+	unsigned long dirmask;
+	struct name_entry names[3];
+};
+
 struct rename_info {
 	/*
 	 * All variables that are arrays of size 3 correspond to data tracked
@@ -102,6 +108,22 @@ struct rename_info {
 	 */
 	struct strset relevant_sources[3];
 
+	/*
+	 * callback_data_*: supporting data structures for alternate traversal
+	 *
+	 * We sometimes need to be able to traverse through all the files
+	 * in a given tree before all immediate subdirectories within that
+	 * tree.  Since traverse_trees() doesn't do that naturally, we have
+	 * a traverse_trees_wrapper() that stores any immediate
+	 * subdirectories while traversing files, then traverses the
+	 * immediate subdirectories later.  These callback_data* variables
+	 * store the information for the subdirectories so that we can do
+	 * that traversal order.
+	 */
+	struct traversal_callback_data *callback_data;
+	int callback_data_nr, callback_data_alloc;
+	char *callback_data_traverse_path;
+
 	/*
 	 * needed_limit: value needed for inexact rename detection to run
 	 *
@@ -396,6 +418,10 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		}
 		strmap_clear(&opti->output, 0);
 	}
+
+	/* Clean out callback_data as well. */
+	FREE_AND_NULL(renames->callback_data);
+	renames->callback_data_nr = renames->callback_data_alloc = 0;
 }
 
 static int err(struct merge_options *opt, const char *err, ...)
-- 
gitgitgadget

