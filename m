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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF60C433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3015C233EB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391544AbhATQ5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403908AbhATQyo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:54:44 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41450C0613C1
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:04 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id y187so3442638wmd.3
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=11GVRZ1uX92OrDukLEJw+fr6Pd0hb/0vgREeqfoK+sw=;
        b=a91G3NAezRC2Qy8gcxJeWTJrmJXouRLbdxvooMUaKSVD5owYmcUq7G3UwklIK7RMIU
         PrBzaxo3KaUmSzvN6o19sj/NylNhXnr5kq1j88bjj0oybDYpPTDh17llmAlduivzTKwu
         DjByrGFDGWCKLdpP5+qyJpgGYP8/M2Kxwm0irgmZx+nkCnEEp45MKLWSrzARIzG2cFgC
         3FBqJh2+/dQfUfEI343oejkgf/W8H1V56lZU8Lf9I35fbGVnrmUmXwlu/gmWOslJytg0
         lyKu1qtFSdDRljlebG6lAirpxdzyQyIbdqGnMbDV08lAv1C6oA61SlOHy3eDpKAoDWIO
         e7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=11GVRZ1uX92OrDukLEJw+fr6Pd0hb/0vgREeqfoK+sw=;
        b=RdHOh/osrMfpx68wWWvxICuaaQzv0gdMa1k7O8AcC4llk+33k8Eo0RZ70eYXZYnC8k
         T5v1n2/JLwmmfdpiZojftAqUtBLfC5yK9YaBggSuPGgNLuJLD3GiZZHULq9p5ZipL4Nn
         dHpSrN4I0M28JX6sPjrFRX6iJuXRvdEXkkPe+1fasoSUd5dCJdTZ8uGvejOAbw1jqWhN
         GziW1/HYyU98HgMAhf97deVBZITjJhojIuEyDYd1qbOdx1Tx/aTJ5pAXftl70H9oO7e0
         suizEqmLTKjg196nUqW41QD1Nyro6Fz412xqcztCldLwmkEYZl77e/qP/Gayb6c5dh3H
         NsIw==
X-Gm-Message-State: AOAM533yeINNgEcEZO+ocOlY3Rvlmygc9EqXq4b7asSYOnzlEAFQrIPZ
        gYIZuN7So/bfvli7vlMY5Iig29s6jJ0=
X-Google-Smtp-Source: ABdhPJwniv2h5kWpvqtKIduC4m+nfOLEMmdlcenr9KKzrx9sE7GRLtxqlH83i2qC0GNPant3cFFqUQ==
X-Received: by 2002:a1c:620a:: with SMTP id w10mr5042058wmb.167.1611161642809;
        Wed, 20 Jan 2021 08:54:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j59sm5362771wrj.13.2021.01.20.08.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:54:02 -0800 (PST)
Message-Id: <a6f2406a79512f517a1bc2700f806c546bbe9ed6.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.git.1611161639.gitgitgadget@gmail.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jan 2021 16:53:52 +0000
Subject: [PATCH 2/9] cache-tree: extract subtree_pos()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This method will be helpful to use outside of cache-tree.c in a later
feature. The implementation is subtle due to subtree_name_cmp() sorting
by length and then lexicographically.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c | 6 +++---
 cache-tree.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index c1e49901c17..2b130dd5e19 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -45,7 +45,7 @@ static int subtree_name_cmp(const char *one, int onelen,
 	return memcmp(one, two, onelen);
 }
 
-static int subtree_pos(struct cache_tree *it, const char *path, int pathlen)
+int cache_tree_subtree_pos(struct cache_tree *it, const char *path, int pathlen)
 {
 	struct cache_tree_sub **down = it->down;
 	int lo, hi;
@@ -72,7 +72,7 @@ static struct cache_tree_sub *find_subtree(struct cache_tree *it,
 					   int create)
 {
 	struct cache_tree_sub *down;
-	int pos = subtree_pos(it, path, pathlen);
+	int pos = cache_tree_subtree_pos(it, path, pathlen);
 	if (0 <= pos)
 		return it->down[pos];
 	if (!create)
@@ -123,7 +123,7 @@ static int do_invalidate_path(struct cache_tree *it, const char *path)
 	it->entry_count = -1;
 	if (!*slash) {
 		int pos;
-		pos = subtree_pos(it, path, namelen);
+		pos = cache_tree_subtree_pos(it, path, namelen);
 		if (0 <= pos) {
 			cache_tree_free(&it->down[pos]->cache_tree);
 			free(it->down[pos]);
diff --git a/cache-tree.h b/cache-tree.h
index 639bfa5340e..8efeccebfc9 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -27,6 +27,8 @@ void cache_tree_free(struct cache_tree **);
 void cache_tree_invalidate_path(struct index_state *, const char *);
 struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
 
+int cache_tree_subtree_pos(struct cache_tree *it, const char *path, int pathlen);
+
 void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
-- 
gitgitgadget

