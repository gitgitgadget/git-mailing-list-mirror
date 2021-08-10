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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBABCC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D16E860ED8
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhHJTun (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 15:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbhHJTul (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 15:50:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE29C0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:50:18 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g138so245039wmg.4
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1hHIMQenL0YY07ojegpV/bWS0DueNnK3juz9ucy/bVk=;
        b=QVgdGHPCvzMmM/zg2hPEhtfQ1fLRTM1tqjOeOaC6coIFmIvEzTIJzjvb12cEjAyORd
         OchNEF09fyiDNNMPNTOL1Ul8A41OmABk4LaTyNXeKmqLG8lyZrPg1nN8XPz5f8cv4pwH
         hPEC822CyuxPFM0qIDDftgw7hJx7vXi5f3xtlFWb9Bf1j5s+uCs7+sN2v6bdBp9kkWZW
         t8WQW3wY4zlw131AVv4HhPG7b0adRWiS95iZvu61yYMEK0AywatN2j8jUvE0/mUSZMtW
         PNyt9QJlk5iW8lriEx+t9IJ37sNn9VKtY84ULjnNG9XPX6vveqmAV6GT66j4vIjqojf6
         g70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1hHIMQenL0YY07ojegpV/bWS0DueNnK3juz9ucy/bVk=;
        b=W+pGQVb242DG/mySa8Z8C10Dd6kvBfhtKjT1R0Nus4ySB0VsQVzbnmwGZteCIXKcbV
         94s8J8Ns/YcBgW/e8xoIgY8tTjtKdlTVemPioAEggiTJzYrZaRZhrEA7dT0H5c7TOusB
         h6P06sQdGYIyBxtwuF+dMXWrix2sPEerUSBJEfzuU3XlX8EC9NxDItaz4OPk8T7yi46h
         KfSzdojhe+qY3pl+27DYfm7dQDZqY2Q8tctglGSBil6VZfQF8MT5+Wjwicf72GD9xqBU
         I9mLgu2Mn5e6I8wV3vog4j90siTelYy3gSjs2OVeKkQj+uBtX60zwFfMEn09md6WP0OZ
         1mWw==
X-Gm-Message-State: AOAM531NjibWMNXA+ocjmXCeZb8r2Mhpar8Ew/+A4DooQ+KGd9ZkRmZM
        8VUbwEy9qaJ7TMkpHIpVMM6CaIBcvKo=
X-Google-Smtp-Source: ABdhPJzzbHq8IsMBJMxLTbY0mmDOUPgi2n1rqX+rMOm9ZpRM4tU0c+RHjRN/zNflqN8tNybuyOA2/g==
X-Received: by 2002:a7b:cd86:: with SMTP id y6mr6222821wmj.181.1628625017093;
        Tue, 10 Aug 2021 12:50:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm10261897wrm.43.2021.08.10.12.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 12:50:16 -0700 (PDT)
Message-Id: <371985352680a767dfacb5477aa77e92e04008ee.1628625013.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
        <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Aug 2021 19:50:08 +0000
Subject: [PATCH v2 3/8] sparse-index: silently return when cache tree fails
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If cache_tree_update() returns a non-zero value, then it could not
create the cache tree. This is likely due to a path having a merge
conflict. Since we are already returning early, let's return silently to
avoid making it seem like we failed to write the index at all.

If we remove our dependence on the cache tree within
convert_to_sparse(), then we could still recover from this scenario and
have a sparse index.

When constructing the cache-tree extension in convert_to_sparse(), it is
possible that we construct a tree object that is new to the object
database. Without the WRITE_TREE_MISSING_OK flag, this results in an
error that halts our conversion to a sparse index. Add this flag to
remove this limitation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index bc5900eae35..b6e90417556 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -179,10 +179,15 @@ int convert_to_sparse(struct index_state *istate)
 
 	/* Clear and recompute the cache-tree */
 	cache_tree_free(&istate->cache_tree);
-	if (cache_tree_update(istate, 0)) {
-		warning(_("unable to update cache-tree, staying full"));
-		return -1;
-	}
+	/*
+	 * Silently return if there is a problem with the cache tree update,
+	 * which might just be due to a conflict state in some entry.
+	 *
+	 * This might create new tree objects, so be sure to use
+	 * WRITE_TREE_MISSING_OK.
+	 */
+	if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
+		return 0;
 
 	remove_fsmonitor(istate);
 
-- 
gitgitgadget

