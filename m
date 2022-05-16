Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AEEC433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 18:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbiEPSMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 14:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344602AbiEPSLo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 14:11:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C43D4B3
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:11:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w4so21568736wrg.12
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mgKy/wmfp+WZHTlBuoJS32yn4kSi0zwmpGFlL0Vsrn0=;
        b=NbGDUL8iz8xboVfUwx9v/3gUFXTAEsT6gasbCq3KlOljNTZC96l2tXz5CpFzTPc3WF
         M2u3Anb547L0X2eBRoCtFYZvcS1V6uTs8gsRpeSBdpW/KKeGsjQ8IxCz78M/+aQ03hGP
         8plmkUT41GgeOPLH1TaYAAhIpBA7qTjwkaGxbfJ9TMDF8JJknTx9yZB+gSbPFUjogQiu
         4r4mwuKN4jtTvkNBg7v4YFtsALQ6w2jAaEU5mLCPCzTTltkxhFLraI7XMfa6P3GozciQ
         n3cGQzHAtLyojtMNSOcr3+GqOh1nFY+xHgoORT8oGqQAblY2ol/JRbbQrCQxMVOQGmYK
         9uTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mgKy/wmfp+WZHTlBuoJS32yn4kSi0zwmpGFlL0Vsrn0=;
        b=lIczRpTQ4HcQlNDsqg5MylTCApC/IiUf45oTL1s0MC/jWt4zYTrZOXAs1I5z8DB9xZ
         AtoG6N0fmKAfpZuDFVtS6xMnK+8FOl0tX1iPIuJFmMPEAk/KxEJ9R0f95C7OMsLAoQyF
         A19LR3Y8FnB8sQmItxHLgiGKyF9VRt4rdFsUPeOdWxjh//a4jsVpZIWixTZCCbHb9L48
         Kz6XVFusuDHzy7ByrkpNAVnbiSjml9Bgv/vwODFK4syBOa0//cZmZa49j/X9Ch7YOSch
         UnWjaz2d7uZm5xq4k1s05zPX4mGlKK6lVgCfvZfe96YRVsv3CL43a/3H7Q1DI6JiAOcp
         rZxA==
X-Gm-Message-State: AOAM531VDqQIWq2j0G3bUhEgGCey8mihBubUdGUKepueSrCzgVg4lnMf
        Azw1sfvKKPPFONH3Y7lguCINZkK9JKE=
X-Google-Smtp-Source: ABdhPJw6/eYp29fsdAr4XwAKpIEPAcLfBNjYSeUZugpDNV6tfOMTnRxnqK1Eysu8hFyk4bpgHHdyWA==
X-Received: by 2002:a05:6000:1815:b0:20a:deee:3cf0 with SMTP id m21-20020a056000181500b0020adeee3cf0mr14980478wrh.210.1652724698690;
        Mon, 16 May 2022 11:11:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e15-20020adfa74f000000b0020c5253d8e5sm9754430wrd.49.2022.05.16.11.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:11:38 -0700 (PDT)
Message-Id: <c0e81be97aa50c808ebf44d1833e915e19901d60.1652724693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 18:11:28 +0000
Subject: [PATCH 3/8] cache-tree: implement cache_tree_find_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Given a 'struct cache_tree', it may be beneficial to navigate directly
to a node within that corresponds to a given path name. Create
cache_tree_find_path() for this function. It returns NULL when no such
path exists.

The implementation is adapted from do_invalidate_path() which does a
similar search but also modifies the nodes it finds along the way.

This new method is not currently used, but will be in an upcoming
change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 cache-tree.c | 24 ++++++++++++++++++++++++
 cache-tree.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index 6752f69d515..23893a7b113 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -100,6 +100,30 @@ struct cache_tree_sub *cache_tree_sub(struct cache_tree *it, const char *path)
 	return find_subtree(it, path, pathlen, 1);
 }
 
+struct cache_tree *cache_tree_find_path(struct cache_tree *it, const char *path)
+{
+	const char *slash;
+	int namelen;
+	struct cache_tree_sub *down;
+
+	if (!it)
+		return NULL;
+	slash = strchrnul(path, '/');
+	namelen = slash - path;
+	it->entry_count = -1;
+	if (!*slash) {
+		int pos;
+		pos = cache_tree_subtree_pos(it, path, namelen);
+		if (0 <= pos)
+			return it->down[pos]->cache_tree;
+		return NULL;
+	}
+	down = find_subtree(it, path, namelen, 0);
+	if (down)
+		return cache_tree_find_path(down->cache_tree, slash + 1);
+	return NULL;
+}
+
 static int do_invalidate_path(struct cache_tree *it, const char *path)
 {
 	/* a/b/c
diff --git a/cache-tree.h b/cache-tree.h
index 8efeccebfc9..f75f8e74dcd 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -29,6 +29,8 @@ struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
 
 int cache_tree_subtree_pos(struct cache_tree *it, const char *path, int pathlen);
 
+struct cache_tree *cache_tree_find_path(struct cache_tree *it, const char *path);
+
 void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
-- 
gitgitgadget

