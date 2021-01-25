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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D144C433E9
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E26932255F
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbhAYSDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731338AbhAYRzx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:55:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D018EC061352
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:23 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id g10so13836180wrx.1
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eHAMjNv/BeGtNrvMBA7TfpjsHOcFjXTnK0ibqxh84Uk=;
        b=sAR+4HWiy/Fu9ubqDsufC9EYPTgvDCSKW4BWp6fDXjVzPq/zVJDnqTadSbRyRkCuM9
         Sv2klBIF8/V4DkZMhRxaDxT3IkpgR8wsraSNcAGYKu+KmeTd8myT7iribZCHO/g0hYmX
         YrMuhPGALVEKxX+Hk/fN/mMVDbuJRf0bdEm6ms4xB58de5joyOhqqWrNehF0RQQ/DW4i
         Exp8joT+jsGtbTlZDYWryOTa2baSx4XiLVBAJSLddvxVObuVdJQ3FU66FsgDUFdk7rLl
         xyndeJoENGtlyVaW4f7JPaDgHo37nE6JitvW0TyK+tOgY2uwFPCvGF5VxANCqLsjdf60
         klwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eHAMjNv/BeGtNrvMBA7TfpjsHOcFjXTnK0ibqxh84Uk=;
        b=VFBLNVUvB6KIViNf+nZNrdZEFxbE9sfx966LPSA0Evc93PK43ewlk7Kfo2LxLa9dqT
         AJVzQ7KMYdUjqhG2aO56NGAx/TB2Buw2eIbjsTryfoZH9fhUhbnkNuAPJuAAvjnPLfWT
         MG34j8MNV/uRufGu0ydHE1A88d0fslr6s5hL4OHMkJ2KF78kyrqm9U1N4CYFJ4krQhM4
         vZHBtzPxBkRbctj7bkzPOGryjmJdzDtr5bsYZpecLEmc4HacS26owTdqt9ghgduhH+Ra
         pK3yORELn/+sj9yjAwnDauMgahgnGk9LVitL2fgc7uiIBbUv6GBFesuSox8QZ5KnwdYk
         lfBA==
X-Gm-Message-State: AOAM531JAAxIWZNekKxqZYyWWhBHkkaf7eheGKmnsDDM1jQ//XopCjuR
        dm6sOEbjUSeJew0AQR+3qZz4eaArvYQ=
X-Google-Smtp-Source: ABdhPJyOHHbLovGQGvXZruTFxxWeiv2sMHZ2GeImcIiNC5KIGELrH38d7fIYAwX5SyMcqZgeu5kUtA==
X-Received: by 2002:a5d:4d84:: with SMTP id b4mr2269344wru.361.1611596542435;
        Mon, 25 Jan 2021 09:42:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17sm2872026wrm.52.2021.01.25.09.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:21 -0800 (PST)
Message-Id: <175c3c62543f89144b03b3bdff750ad29d17ba03.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:41:53 +0000
Subject: [PATCH 07/27] unpack-trees: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The next change will translate full indexes into sparse indexes at write
time. The existing logic provides a way for every sparse index to be
expanded to a full index at read time. However, there are cases where an
index is written and then continues to be used in-memory to perform
further updates.

unpack_trees() is frequently called after such a write. In particular,
commands like 'git reset' do this double-update of the index.

Ensure that we have a full index when entering unpack_trees(), but only
when command_requires_full_index is true. This is always true at the
moment, but we will later relax that after unpack_trees() is updated to
handle sparse directory entries.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index f5f668f532d..4dd99219073 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1567,6 +1567,7 @@ static int verify_absent(const struct cache_entry *,
  */
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
 {
+	struct repository *repo = the_repository;
 	int i, ret;
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
@@ -1578,6 +1579,12 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	trace_performance_enter();
 	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
 
+	prepare_repo_settings(repo);
+	if (repo->settings.command_requires_full_index) {
+		ensure_full_index(o->src_index);
+		ensure_full_index(o->dst_index);
+	}
+
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout && !o->pl) {
-- 
gitgitgadget

