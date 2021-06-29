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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3F9C11F65
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2D761C99
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhF2CHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhF2CHa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:07:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61908C061768
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:05:03 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m41-20020a05600c3b29b02901dcd3733f24so719918wms.1
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=749a8m/Pb2tHSZcl9clKK1mNX+ACw8NI8sZI+4jwZZo=;
        b=SDzTupqWBpJiCXl62C6IHnOaoiBHK2QN77aqVcNolJHj/G0Roxb9ELpijVB5/0xZ+3
         6rBZwdxIc9qIzGmMBLqxHid0Xf0agL4rnqFT9/Ep2NkY2HCC9h2w60Tti/44g4ZM7Sa8
         09BmWbBefucdZgovT7VxJ/bs8xLIDBkip/GierkyCsfBtE5ryDHCXZdD31wGQ7NGMc+w
         JJaq38WeuwC8LcsT2mptWv8yoJ7JAE0rfUEyoqR86QdZ+NkXADUEV8rEWINSJ9LPNLLi
         nqeGu3rFM6jEyxF+S5vB4IlUq16cwCZQwatdMyTymYv8+Vmddn51M0K/JXUcFVH1Ihxd
         AS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=749a8m/Pb2tHSZcl9clKK1mNX+ACw8NI8sZI+4jwZZo=;
        b=TGsIClfUx4H5A/sn5yg6AFc4n/xMR03Rc1V2WMqMV5/gBzKwOM2LZZfqu6+S3X3vhZ
         PRpDryRTsLYvEePrgpURbAgX8q5pesjmQURzTctM1nZWZA0+NzbK+jU768klJXzgR4EJ
         4E1Qus+0cQGqk6B7nSrZQZDLy0bwVYXQtQ3VfTFxUyUNSz6otJdYxLCq8sJzIdBYKpdN
         WrbYgldpq5u5DZ48lKUgDDmUjzO6i941h/GE5upHA8lv3sEz8rStjdyvSmnvopaWp+ma
         KQA7eXTgb6ZFEifZQcy9TeY6c53yXGTbQbAJFzL9QxdphyOVVlNWZcO50ThehuJ9UZVz
         G3hg==
X-Gm-Message-State: AOAM530I1TmaeFz2gzj8NXdTpmdrduErgnhVG3jXwanvOq7S/TK71UPd
        xV/jgWwNErSAWRQESHiWxmB4TYkRI9k=
X-Google-Smtp-Source: ABdhPJz9rWQzatpTYOAcwrGUAIwfQygXdh2hwIvpNU0v+UPipPhadlEWLC+vlMc0aoHMBy8cpK6D2Q==
X-Received: by 2002:a7b:c110:: with SMTP id w16mr13836678wmi.178.1624932302015;
        Mon, 28 Jun 2021 19:05:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm9089771wrs.30.2021.06.28.19.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:05:01 -0700 (PDT)
Message-Id: <f83aa08ff6b0fd18d6f9f3ce5ee993523a7f1759.1624932294.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
        <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:04:49 +0000
Subject: [PATCH v7 12/16] diff-lib: handle index diffs with sparse dirs
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
 diff-lib.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index c2ac9250fe9..3f32f038371 100644
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
@@ -347,6 +352,17 @@ static int show_modified(struct rev_info *revs,
 	unsigned dirty_submodule = 0;
 	struct index_state *istate = revs->diffopt.repo->index;
 
+	/*
+	 * If both are sparse directory entries, then expand the
+	 * modifications to the file level.
+	 */
+	if (old_entry && new_entry &&
+	    S_ISSPARSEDIR(old_entry->ce_mode) &&
+	    S_ISSPARSEDIR(new_entry->ce_mode)) {
+		diff_tree_oid(&old_entry->oid, &new_entry->oid, new_entry->name, &revs->diffopt);
+		return 0;
+	}
+
 	if (get_stat_data(istate, new_entry, &oid, &mode, cached, match_missing,
 			  &dirty_submodule, &revs->diffopt) < 0) {
 		if (report_missing)
-- 
gitgitgadget

