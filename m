Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F30B1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 14:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbeHRRtl (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 13:49:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44139 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeHRRtl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 13:49:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id q127-v6so8479834ljq.11
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 07:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SBYz9LnXBQ3iPy6wC9dtajBd51cyvRDeGh2gUXZRhqg=;
        b=aOAtXr0OP4qlYJg/Q3+mA6crJ9fKMWPiBazlJ8puEuxTc/qA1DAyiMB7kjRg34W8Ry
         q8dalKpR+hZraavSPz8E9Sl6lBZUfy2YcZoOCaBg3+x1xsJUa4qJadA9r3Fg5Lc64xuj
         tshV2RSm21lXVyzZ4Is8MbgbviKqlXpTfAxRePAOmZ6YhpHEEconzpEwQCvX2us1UetS
         AORsHBEed8Eq0SedO5pM7VBBVD5O9mVs3AW3ifaVv74+DLgCtOeZC/Vti6DNwSIhp8Vb
         USCd0zDMQOftEpMjV8F7vhCh/5CYtzG4n5b8Yl4ejN0m7VXDaZ9h7iRnjp49DoicWuW6
         HGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SBYz9LnXBQ3iPy6wC9dtajBd51cyvRDeGh2gUXZRhqg=;
        b=AaV0sIunm3N+esbXkzdp4pxS92hsWvDpMApf36uY2RA+0i8uWfFKJ25R6PJ8XVI/zz
         L2IMVci6fep2A78hT6UAWcvMwpmnEiSVTFAA6fbWmwoHqXFlHkt2m2mynmGctuuI9H5U
         W79KwltsVjDX/He0nPmzTgK8zi4jHKtaIyhtTFzTo3U/ytuzaAq/KYs7j8r9rTgG2NGu
         UkRi7C4df6aULXE6StS+kQApmhFEOP76Pa8p2Hkn4t4eW6jHl8UH3GsP1ac73lo9Fjl3
         jK1MTKZ+0VfyMWM8JuP8eF8eEmqiwFXR0RYRADv8XLdu7cIN13EcH+cU9oFGt3Q1QadW
         T77Q==
X-Gm-Message-State: AOUpUlHzOLZ61azWNJnNqwDmmQwVv6hVk4Uu5c0xxzlV6bVd7fNqPDH3
        hVqnxLb8OvXI0q7ZuaHjayU=
X-Google-Smtp-Source: AA+uWPzU7hNxk+CMNGzEfTww/MgCno6nNdFAh8mf5rxbkXiWtmSqGeWvCa7gWs7g6lIl6Wi406A1cA==
X-Received: by 2002:a2e:94d5:: with SMTP id r21-v6mr7531019ljh.126.1534603303782;
        Sat, 18 Aug 2018 07:41:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b76-v6sm884451lff.53.2018.08.18.07.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 07:41:43 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, peartben@gmail.com, peff@peff.net
Subject: [PATCH v5 5/7] unpack-trees: reuse (still valid) cache-tree from src_index
Date:   Sat, 18 Aug 2018 16:41:26 +0200
Message-Id: <20180818144128.19361-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180818144128.19361-1-pclouds@gmail.com>
References: <20180812081551.27927-1-pclouds@gmail.com>
 <20180818144128.19361-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do n-way merge by walking the source index and n trees at the same
time and add merge results to a new temporary index called o->result.
The merge result for any given path could be either

- keep_entry(): same old index entry in o->src_index is reused
- merged_entry(): either a new entry is added, or an existing one updated
- deleted_entry(): one entry from o->src_index is removed

For some reason [1] we keep making sure that the source index's
cache-tree is still valid if used by o->result: for all those
merged/deleted entries, we invalidate the same path in o->src_index,
so only cache-trees covering the "keep_entry" parts remain good.

Because of this, the cache-tree from o->src_index can be perfectly
reused in o->result. And in fact we already rely on this logic to
reuse untracked cache in edf3b90553 (unpack-trees: preserve index
extensions - 2017-05-08). Move the cache-tree to o->result before
doing cache_tree_update() to reduce hashing cost.

Since cache_tree_update() has risen up as one of the most expensive
parts in unpack_trees() after the last few patches. This does help
reduce unpack_trees() time significantly (on webkit.git):

    before       after
  --------------------------------------------------------------------
    0.080394752  0.051258167 s:  read cache .git/index
    0.216010838  0.212106298 s:  preload index
    0.008534301  0.280521764 s:  refresh index
    0.251992198  0.218160442 s:   traverse_trees
    0.377031383  0.374948191 s:   check_updates
    0.372768105  0.037040114 s:   cache_tree_update
    1.045887251  0.672031609 s:  unpack_trees
    0.314983512  0.317456290 s:  write index, changed mask = 2e
    0.062572653  0.038382654 s:    traverse_trees
    0.000022544  0.000042731 s:    check_updates
    0.073795585  0.050930053 s:   unpack_trees
    0.073807557  0.051099735 s:  diff-index
    1.938191592  1.614241153 s: git command: git checkout -

[1] I'm pretty sure the reason is an oversight in 34110cd4e3 (Make
    'unpack_trees()' have a separate source and destination index -
    2008-03-06). That patch aims to _not_ update the source index at
    all. The invalidation should have been done on o->result in that
    patch. But then there was no cache-tree on o->result even then so
    it's pointless to do so.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c   | 2 ++
 unpack-trees.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 1c9c88c130..5ce40f39b3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2940,6 +2940,8 @@ void move_index_extensions(struct index_state *dst, struct index_state *src)
 {
 	dst->untracked = src->untracked;
 	src->untracked = NULL;
+	dst->cache_tree = src->cache_tree;
+	src->cache_tree = NULL;
 }
 
 struct cache_entry *dup_cache_entry(const struct cache_entry *ce,
diff --git a/unpack-trees.c b/unpack-trees.c
index dbef6e1b8a..aa80b65ee1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1576,6 +1576,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	ret = check_updates(o) ? (-2) : 0;
 	if (o->dst_index) {
+		move_index_extensions(&o->result, o->src_index);
 		if (!ret) {
 			if (!o->result.cache_tree)
 				o->result.cache_tree = cache_tree();
@@ -1584,7 +1585,6 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 						  WRITE_TREE_SILENT |
 						  WRITE_TREE_REPAIR);
 		}
-		move_index_extensions(&o->result, o->src_index);
 		discard_index(o->dst_index);
 		*o->dst_index = o->result;
 	} else {
-- 
2.18.0.1004.g6639190530

