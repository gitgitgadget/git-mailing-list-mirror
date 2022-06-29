Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AFFC433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 15:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbiF2PZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 11:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbiF2PZn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 11:25:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73F933EB1
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 08:25:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u12-20020a05600c210c00b003a02b16d2b8so9827932wml.2
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 08:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pyTDyHG/r3HDiqTRrfYUdwnY/9t53YoZ0wyo4fJc38E=;
        b=d59wmDersz7cJj8+hJRDJ6MctaLC/6QG6uXJOE1QCqkQex9eTfsKIqN22+CTDjkX+t
         7uixH72x+3rla+eNBVQm0aSJflhSrKsHRppmYP9k2bxdXA4TZUnmzu4G8kKeDJauUwZG
         swo5CtA8J1qtgGeWzt/1W1WV7FCAzoDw87vr+ej7AXcxzIpUQI+2y0yzX+ZZ0jBk76Zf
         O7IqR9qVOCvwKmx7fczah/bs7cwTnrwdbWzq7f2qY1k7taEKDr30nvIzca2Ya75IC6Eq
         veqN/8FuAYd9VmWNv3x52JoMD1dNZua5tPnmDEZoBYXABsy//1EvT7iseUKMwuSuO6jO
         A2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pyTDyHG/r3HDiqTRrfYUdwnY/9t53YoZ0wyo4fJc38E=;
        b=RqIT7qO7pCHwCIAZyjA4CzQmouaPq1KtjSi5t2+rR2mU/bMUeaGwHccRIbK3GC9Rgy
         RWQtduo7p5z/qHXN102AzsG+kYpjhEG6hFLmaVhAIubsi+hsYQ6WpPJZU555vuADtJki
         9qpEDrxODqGMUl0hpoVH48PR10I71iHTAJ2VL2jAihTGupgeg2jueM0sH7WZbznAnwDM
         p5iv2vQasH8GLFAE03X9o/cGhYxOIhdwofmkR31glg/WykGsHieKJjLx7ou3u5fnvQOR
         4HFghuakkgJBozF/BJsbn2ZMrjoQ9Pa20AlG1d7uAhqiacS+p1x44wkEHWYt2uY22M1E
         0GOA==
X-Gm-Message-State: AJIora+pplE2eeGtEF0dm5bj8Ieg4VK8FQ1qOEkrntKwHtKOEJf16XB2
        IryMw4qLurC4waO3t+IC2ct33byPuWQMTA==
X-Google-Smtp-Source: AGRyM1teCKdSr5BxShE+Y7JWuP+nb40EHCFVKfGSYzcAjYH8K/zNQz1jR9ZjF+YaxRnua/41+hz2qA==
X-Received: by 2002:a1c:f305:0:b0:39c:4840:ab42 with SMTP id q5-20020a1cf305000000b0039c4840ab42mr6122714wmq.148.1656516336624;
        Wed, 29 Jun 2022 08:25:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13-20020a05600c190d00b003973ea7e725sm5104525wmq.0.2022.06.29.08.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:25:35 -0700 (PDT)
Message-Id: <55fd62dc27d2bccfdb8ac300be23fc33d1795366.1656516334.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jun 2022 15:25:32 +0000
Subject: [PATCH 1/3] xdiff: introduce XDL_ALLOC_ARRAY()
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

Add a helper to allocate an array that automatically calculates the
allocation size. This is analogous to ALLOC_ARRAY() in the rest of the
codebase but returns NULL if the allocation fails to accommodate other
users of libxdiff such as libgit2. The helper will also return NULL if
the multiplication in the allocation calculation overflows.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xdiffi.c    | 2 +-
 xdiff/xmacros.h   | 5 +++++
 xdiff/xpatience.c | 4 ++--
 xdiff/xprepare.c  | 8 ++++----
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 758410c11ac..53e803e6bcb 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -337,7 +337,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	 * One is to store the forward path and one to store the backward path.
 	 */
 	ndiags = xe->xdf1.nreff + xe->xdf2.nreff + 3;
-	if (!(kvd = (long *) xdl_malloc((2 * ndiags + 2) * sizeof(long)))) {
+	if (!XDL_ALLOC_ARRAY(kvd, 2 * ndiags + 2)) {
 
 		xdl_free_env(xe);
 		return -1;
diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index ae4636c2477..9fd3c5da91a 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -49,5 +49,10 @@ do { \
 		((unsigned long) __p[2]) << 16 | ((unsigned long) __p[3]) << 24; \
 } while (0)
 
+/* Allocate an array of nr elements, returns NULL on failure */
+#define XDL_ALLOC_ARRAY(p, nr)				\
+	((p) = SIZE_MAX / sizeof(*(p)) >= (size_t)(nr)	\
+		? xdl_malloc((nr) * sizeof(*(p)))	\
+		: NULL)
 
 #endif /* #if !defined(XMACROS_H) */
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 1a21c6a74b3..ce87b9084ca 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -200,7 +200,7 @@ static int binary_search(struct entry **sequence, int longest,
  */
 static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
 {
-	struct entry **sequence = xdl_malloc(map->nr * sizeof(struct entry *));
+	struct entry **sequence;
 	int longest = 0, i;
 	struct entry *entry;
 
@@ -211,7 +211,7 @@ static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
 	 */
 	int anchor_i = -1;
 
-	if (!sequence)
+	if (!XDL_ALLOC_ARRAY(sequence, map->nr))
 		return -1;
 
 	for (entry = map->first; entry; entry = entry->next) {
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 105752758f2..25866a1667a 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -86,7 +86,7 @@ static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
 	memset(cf->rchash, 0, cf->hsize * sizeof(xdlclass_t *));
 
 	cf->alloc = size;
-	if (!(cf->rcrecs = (xdlclass_t **) xdl_malloc(cf->alloc * sizeof(xdlclass_t *)))) {
+	if (!XDL_ALLOC_ARRAY(cf->rcrecs, cf->alloc)) {
 
 		xdl_free(cf->rchash);
 		xdl_cha_free(&cf->ncha);
@@ -178,7 +178,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
 		goto abort;
-	if (!(recs = (xrecord_t **) xdl_malloc(narec * sizeof(xrecord_t *))))
+	if (!XDL_ALLOC_ARRAY(recs, narec))
 		goto abort;
 
 	hbits = xdl_hashbits((unsigned int) narec);
@@ -215,9 +215,9 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
-		if (!(rindex = xdl_malloc((nrec + 1) * sizeof(*rindex))))
+		if (!XDL_ALLOC_ARRAY(rindex, nrec + 1))
 			goto abort;
-		if (!(ha = xdl_malloc((nrec + 1) * sizeof(*ha))))
+		if (!XDL_ALLOC_ARRAY(ha, nrec + 1))
 			goto abort;
 	}
 
-- 
gitgitgadget

