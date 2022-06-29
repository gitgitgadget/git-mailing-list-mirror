Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0E7C43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 15:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbiF2PZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbiF2PZv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 11:25:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FF9344EF
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 08:25:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q9so23019199wrd.8
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J1UhH9HhQtWzjHtCaczDyQe98YD3U/bG5Y7eiJJmwdc=;
        b=nrPLFVI0yOB0dNshqadXE39kl/Ij3OVBycwjmc37wI+tUVP7Uz5vsfPFs5RTreXW+u
         zuQ8E6I1NUmbjNzIps6cVcRw8BJa74evAGXg5gCYgyWCSNryGmqE6JktSl8hEqFrbDEV
         Qrt2ijXnvgf0K/N2kXS84GF7DrgbwoeoomvUhrolwwIyAXD6JnbL/5g0V1dbsESkPfc9
         PRDdCH/LxBJSIRsYFNDsACAjAsHQG/MXA8fF0Dbc3Vu0GGX/Me/6mBhEdycjKbA2aXa/
         fsKe4r8ixBlPEPJejd6RN91FfMeTWFkJyquTYNmqgbNTdQ19P35RhddI8+JPRqkHkS3Y
         BklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J1UhH9HhQtWzjHtCaczDyQe98YD3U/bG5Y7eiJJmwdc=;
        b=a+N7Dig7q0BUIshAOiTU/fWPjw8ymL0ctZh8hRIhIMj42q6ft416uAv+rMvlDuhRPl
         ubCUrc71UzNeQxZQSlgLdOymMv8579VpxbFAAPuZBcooCs/lrIBcYfGFa2Eih5HmgxNv
         B5nl5WYPoxvAKZO62wrUH9F+8PJaul0TOdkZrJ1FI2kcdkIk9UZdM0VmJJI+zCqH9KgQ
         0D/BFRfqDeoMW+pveTkcujkyYM0WSq5uZ99NqQtbwaWeBvaUtswEY34CexIVrxQ6Kyu1
         U+ehY/CT6rJPBZpEMDFKKJEu+U59otMQoNYqWSSv+JJbU46aP9RhZ1DONSjYAn1CTkCx
         Edmg==
X-Gm-Message-State: AJIora/N/RCqe/G3MslWDcOpR0Vi5+XagwakzDP8d+OzEuIM6JgF7yJo
        U4J9+kX1gDpP28zfDGWDNCEePvwhdsXYsA==
X-Google-Smtp-Source: AGRyM1s/vMNmW+LiVpCJg+Li0W27PldJvQNMZhDf8lK0UF6fMn5uXEObe2p9/pgv1jQ7klldTZl3UA==
X-Received: by 2002:a05:6000:1446:b0:21d:27ea:5a01 with SMTP id v6-20020a056000144600b0021d27ea5a01mr3770509wrx.314.1656516337722;
        Wed, 29 Jun 2022 08:25:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t3-20020a0560001a4300b0021b9cc87aa9sm17198887wry.111.2022.06.29.08.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:25:36 -0700 (PDT)
Message-Id: <8bead9856be7b39d3d03f688f53d678832d60109.1656516334.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jun 2022 15:25:33 +0000
Subject: [PATCH 2/3] xdiff: introduce XDL_CALLOC_ARRAY()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add a helper for allocating an array and initialize the elements to
zero. This is analogous to CALLOC_ARRAY() in the rest of the codebase
but it returns NULL on allocation failures rather than dying to
accommodate other users of libxdiff such as libgit2.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xhistogram.c | 19 ++++++-------------
 xdiff/xmacros.h    |  6 ++++++
 xdiff/xpatience.c  |  5 +----
 xdiff/xprepare.c   | 14 ++++----------
 4 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 01decffc332..df909004c10 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -251,7 +251,7 @@ static int find_lcs(xpparam_t const *xpp, xdfenv_t *env,
 		    int line1, int count1, int line2, int count2)
 {
 	int b_ptr;
-	int sz, ret = -1;
+	int ret = -1;
 	struct histindex index;
 
 	memset(&index, 0, sizeof(index));
@@ -265,23 +265,16 @@ static int find_lcs(xpparam_t const *xpp, xdfenv_t *env,
 	index.rcha.head = NULL;
 
 	index.table_bits = xdl_hashbits(count1);
-	sz = index.records_size = 1 << index.table_bits;
-	sz *= sizeof(struct record *);
-	if (!(index.records = (struct record **) xdl_malloc(sz)))
+	index.records_size = 1 << index.table_bits;
+	if (!XDL_CALLOC_ARRAY(index.records, index.records_size))
 		goto cleanup;
-	memset(index.records, 0, sz);
 
-	sz = index.line_map_size = count1;
-	sz *= sizeof(struct record *);
-	if (!(index.line_map = (struct record **) xdl_malloc(sz)))
+	index.line_map_size = count1;
+	if (!XDL_CALLOC_ARRAY(index.line_map, index.line_map_size))
 		goto cleanup;
-	memset(index.line_map, 0, sz);
 
-	sz = index.line_map_size;
-	sz *= sizeof(unsigned int);
-	if (!(index.next_ptrs = (unsigned int *) xdl_malloc(sz)))
+	if (!XDL_CALLOC_ARRAY(index.next_ptrs, index.line_map_size))
 		goto cleanup;
-	memset(index.next_ptrs, 0, sz);
 
 	/* lines / 4 + 1 comes from xprepare.c:xdl_prepare_ctx() */
 	if (xdl_cha_init(&index.rcha, sizeof(struct record), count1 / 4 + 1) < 0)
diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 9fd3c5da91a..23db8e785d7 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -55,4 +55,10 @@ do { \
 		? xdl_malloc((nr) * sizeof(*(p)))	\
 		: NULL)
 
+/* Allocate an array of nr zeroed out elements, returns NULL on failure */
+#define XDL_CALLOC_ARRAY(p, nr)				\
+	(XDL_ALLOC_ARRAY((p), (nr))			\
+		? memset((p), 0, (nr) * sizeof(*(p)))	\
+		: NULL)
+
 #endif /* #if !defined(XMACROS_H) */
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index ce87b9084ca..fe39c2978cb 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -151,11 +151,8 @@ static int fill_hashmap(mmfile_t *file1, mmfile_t *file2,
 
 	/* We know exactly how large we want the hash map */
 	result->alloc = count1 * 2;
-	result->entries = (struct entry *)
-		xdl_malloc(result->alloc * sizeof(struct entry));
-	if (!result->entries)
+	if (!XDL_CALLOC_ARRAY(result->entries, result->alloc))
 		return -1;
-	memset(result->entries, 0, result->alloc * sizeof(struct entry));
 
 	/* First, fill with entries from the first file */
 	while (count1--)
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 25866a1667a..b016570c488 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -78,12 +78,11 @@ static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
 
 		return -1;
 	}
-	if (!(cf->rchash = (xdlclass_t **) xdl_malloc(cf->hsize * sizeof(xdlclass_t *)))) {
+	if (!XDL_CALLOC_ARRAY(cf->rchash, cf->hsize)) {
 
 		xdl_cha_free(&cf->ncha);
 		return -1;
 	}
-	memset(cf->rchash, 0, cf->hsize * sizeof(xdlclass_t *));
 
 	cf->alloc = size;
 	if (!XDL_ALLOC_ARRAY(cf->rcrecs, cf->alloc)) {
@@ -183,9 +182,8 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	hbits = xdl_hashbits((unsigned int) narec);
 	hsize = 1 << hbits;
-	if (!(rhash = (xrecord_t **) xdl_malloc(hsize * sizeof(xrecord_t *))))
+	if (!XDL_CALLOC_ARRAY(rhash, hsize))
 		goto abort;
-	memset(rhash, 0, hsize * sizeof(xrecord_t *));
 
 	nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
@@ -209,9 +207,8 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 		}
 	}
 
-	if (!(rchg = (char *) xdl_malloc((nrec + 2) * sizeof(char))))
+	if (!XDL_CALLOC_ARRAY(rchg, nrec + 2))
 		goto abort;
-	memset(rchg, 0, (nrec + 2) * sizeof(char));
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
@@ -383,11 +380,8 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	xdlclass_t *rcrec;
 	char *dis, *dis1, *dis2;
 
-	if (!(dis = (char *) xdl_malloc(xdf1->nrec + xdf2->nrec + 2))) {
-
+	if (!XDL_CALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2))
 		return -1;
-	}
-	memset(dis, 0, xdf1->nrec + xdf2->nrec + 2);
 	dis1 = dis;
 	dis2 = dis1 + xdf1->nrec + 1;
 
-- 
gitgitgadget

