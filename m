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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324EDC07E9A
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D086120A
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhGLR7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbhGLR6z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:58:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FB0C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g16so16901732wrw.5
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IX4iFOSyGCMqp4f79yJ4MnYs1wd2+RwP9RtTHQgSjwg=;
        b=LlzaNPlqb/pX4KNSVLaZLvYT4f2LF0ejvfRDeGPg5W5RSNbfTVYRDdNhduaMdEp2zL
         a8ZX5PIn9+rCwXXuRoa9FgIeWpAMvNYi8ise786TS7jNiRYw7T4IMOYG7afhLt06JZf4
         g4v6+riXAq0nkqd6DtG3zZQ6p2kddMGevMf00Mn3ypTQwbPs/YgN6NYgEnMi/D42Eh/U
         GX/dWXhcFPmNA1xP8lKkrNE8audcwr1kWYfSz/nd6z6XNkAyTr5crHkxVtlmsvczlBkZ
         8lcIUVANg/5yoD/3YtkgWgAo68YRMwhn/6bQHOFlfUG6q44e3AxIkO80as5M3YKsYyG2
         eFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IX4iFOSyGCMqp4f79yJ4MnYs1wd2+RwP9RtTHQgSjwg=;
        b=Lt/Kky8lBw8PFuHUyI9X0+/vZgQlQvsUx00Y9p05gKX7Hvgu2dNar3pSSwTDEyQL+u
         lS+/IWz1QiNOtBgo4+ayHfv5yYaduBRXP85CKg3/g9vZi8Ow8ucWvBazc2trMr2W5evZ
         ZjF+R4BAd5RNhgiJHIwyxDoJx5sZw45HP4fuba2G1AxmbFBqbQ5Zdgky0K2Km1Hifzeb
         qocwR+AA8blnvlsrv07iLA9Ox4Jdf2GuzEFYCbj6D2/cQMcG9Og+B3eRl1zMgd9nOXHz
         9umKsbyLQUQZaW6MmiwhrwDmlsHw1XZZaDMKvXcsRSapgXp6ownRJcIQhtXUmynMgoSs
         zyqA==
X-Gm-Message-State: AOAM531P4itVtT6rwRcqvmEVumMVzo7C6f3O7ONUYP+toLuuLWcH4j4W
        a0tdmnJug9zIELCIvn/8HUwAD6+lNp8=
X-Google-Smtp-Source: ABdhPJyOg55V24y4i6RVcGP+z4drLp4Y/0Tn79qT5zyhUDVUdtmy0qyCsAGVJA2J2mrJa2Yofgy0vQ==
X-Received: by 2002:a5d:4449:: with SMTP id x9mr277092wrr.52.1626112565047;
        Mon, 12 Jul 2021 10:56:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm15293991wrx.40.2021.07.12.10.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:56:04 -0700 (PDT)
Message-Id: <d875a7f8585107591e1811ad744601bebb3df9bc.1626112556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
References: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
        <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 17:55:52 +0000
Subject: [PATCH v8 11/15] diff-lib: handle index diffs with sparse dirs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

While comparing an index to a tree, we may see a sparse directory entry.
In this case, we should compare that portion of the tree to the tree
represented by that entry. This could include a new tree which needs to
be expanded to a full list of added files. It could also include an
existing tree, in which case all of the changes inside are important to
describe, including the modifications, additions, and deletions. Note
that the case where the tree has a path and the index does not remains
identical to before: the lack of a cache entry is the same with a sparse
index.

Use diff_tree_oid() appropriately to compute the diff.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 diff-lib.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index c2ac9250fe9..f9eadc4fc1a 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -325,6 +325,11 @@ static void show_new_file(struct rev_info *revs,
 	unsigned dirty_submodule = 0;
 	struct index_state *istate = revs->diffopt.repo->index;
 
+	if (new_file && S_ISSPARSEDIR(new_file->ce_mode)) {
+		diff_tree_oid(NULL, &new_file->oid, new_file->name, &revs->diffopt);
+		return;
+	}
+
 	/*
 	 * New file in the index: it might actually be different in
 	 * the working tree.
@@ -347,6 +352,20 @@ static int show_modified(struct rev_info *revs,
 	unsigned dirty_submodule = 0;
 	struct index_state *istate = revs->diffopt.repo->index;
 
+	assert(S_ISSPARSEDIR(old_entry->ce_mode) ==
+	       S_ISSPARSEDIR(new_entry->ce_mode));
+
+	/*
+	 * If both are sparse directory entries, then expand the
+	 * modifications to the file level. If only one was a sparse
+	 * directory, then they appear as an add and delete instead of
+	 * a modification.
+	 */
+	if (S_ISSPARSEDIR(new_entry->ce_mode)) {
+		diff_tree_oid(&old_entry->oid, &new_entry->oid, new_entry->name, &revs->diffopt);
+		return 0;
+	}
+
 	if (get_stat_data(istate, new_entry, &oid, &mode, cached, match_missing,
 			  &dirty_submodule, &revs->diffopt) < 0) {
 		if (report_missing)
-- 
gitgitgadget

