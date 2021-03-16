Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21B6C4332D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC6B365120
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbhCPQoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238911AbhCPQnV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361A4C061762
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j7so7785218wrd.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UI+eRyRGiD8kv9ARhAds+wlgsXLrX8hcYHQH8XYkEp8=;
        b=vT9xSflsdfhmlYebwruVUCX504dtE+qcEOpcayVwqMMD82PieErY1z6HSEDRGMU32X
         AmkZhdx0omkzYs2WSXvlbD16ohCCvfxNX2pMpynfIT2T9mO9J6YA7z5zwVbrzfPpBRtn
         Wpy9F2d32rR/5WLyatgmYwXBdAS5aMscF8jDEKniHQ1/87Xr7mEnpsi8tkOPoeDTPzAy
         Id9bTl2t1dBkj2EFeTKUDQ3IuWPqAk1ZqCBwlfRgXjKOHlYGgZysXxpkd4C8rYnGc4KY
         0LQmmvwellbt6tapI9UDTRu/ByYjXVjtcB3rUtstF2wJvstJBBjUvodtfE1igfdq4DlY
         t9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UI+eRyRGiD8kv9ARhAds+wlgsXLrX8hcYHQH8XYkEp8=;
        b=PtIoYtNpm+lX6Ss1nron2xNYVmKaLmxeMLry8meuErLML/GjYib87zjO1AgUwYe33y
         OaUmRBuCWWRTszfy0E5zBDjoe/lzoP4c6oSNjGvXThkYxQG3oXaMCJabkJbBdf9jg1di
         nIDxB9VP0DfdpIhBBqT5YebDeml2IEFkBqehdLRadfx1dyXe0z/ufpt27t2EKa1wsWHL
         zCOLowh3iuZINUUajH14FuTVmfBDC3siwZeJxdEIuU/pt1y3dH8I1iK0t8xrqIcHw91T
         SMYICtf/3s+BlRc5kurQTLgd2UClFqIgndMWESkSbX85tbG7cqd8WZxV3AceUjVn9dLO
         M0nA==
X-Gm-Message-State: AOAM530y3MItTnJ55ZbHzi7YCvFS3ypudqHeMZnKdtkL4MKm0f9zgAgi
        EKfvQ3YHy/4McBNJMy/NFU4Idi3Ag0w=
X-Google-Smtp-Source: ABdhPJzkwg3mOZa4OnAslK9HHtiAz5/oByK5/vaRrQFbwE0b/EFz7TtNuF5EHus6bQs2bDnkhUWHpA==
X-Received: by 2002:a5d:55c4:: with SMTP id i4mr5944425wrw.84.1615912998760;
        Tue, 16 Mar 2021 09:43:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s11sm32355wme.22.2021.03.16.09.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:43:18 -0700 (PDT)
Message-Id: <6fdd9323c14ea42f805eaa1ace525d268fc3438c.1615912983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 16:43:02 +0000
Subject: [PATCH v3 19/20] sparse-index: loose integration with
 cache_tree_verify()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The cache_tree_verify() method is run when GIT_TEST_CHECK_CACHE_TREE
is enabled, which it is by default in the test suite. The logic must
be adjusted for the presence of these directory entries.

For now, leave the test as a simple check for whether the directory
entry is sparse. Do not go any further until needed.

This allows us to re-enable GIT_TEST_CHECK_CACHE_TREE in
t1092-sparse-checkout-compatibility.sh. Further,
p2000-sparse-operations.sh uses the test suite and hence this is enabled
for all tests. We need to integrate with it before we run our
performance tests with a sparse-index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c                             | 19 +++++++++++++++++++
 t/t1092-sparse-checkout-compatibility.sh |  3 ---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 950a9615db8f..11bf1fcae6e1 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -808,6 +808,19 @@ int cache_tree_matches_traversal(struct cache_tree *root,
 	return 0;
 }
 
+static void verify_one_sparse(struct repository *r,
+			      struct index_state *istate,
+			      struct cache_tree *it,
+			      struct strbuf *path,
+			      int pos)
+{
+	struct cache_entry *ce = istate->cache[pos];
+
+	if (!S_ISSPARSEDIR(ce->ce_mode))
+		BUG("directory '%s' is present in index, but not sparse",
+		    path->buf);
+}
+
 static void verify_one(struct repository *r,
 		       struct index_state *istate,
 		       struct cache_tree *it,
@@ -830,6 +843,12 @@ static void verify_one(struct repository *r,
 
 	if (path->len) {
 		pos = index_name_pos(istate, path->buf, path->len);
+
+		if (pos >= 0) {
+			verify_one_sparse(r, istate, it, path, pos);
+			return;
+		}
+
 		pos = -pos - 1;
 	} else {
 		pos = 0;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index f14dc48924d2..d97bf9b64527 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2,9 +2,6 @@
 
 test_description='compare full workdir to sparse workdir'
 
-# The verify_cache_tree() check is not sparse-aware (yet).
-# So, disable the check until that integration is complete.
-GIT_TEST_CHECK_CACHE_TREE=0
 GIT_TEST_SPLIT_INDEX=0
 GIT_TEST_SPARSE_INDEX=
 
-- 
gitgitgadget

