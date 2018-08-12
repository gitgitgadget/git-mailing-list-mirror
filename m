Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F00A41F404
	for <e@80x24.org>; Sun, 12 Aug 2018 08:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeHLKxO (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 06:53:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37304 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeHLKxO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 06:53:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id j8-v6so9258096lfb.4
        for <git@vger.kernel.org>; Sun, 12 Aug 2018 01:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5kN8TpKvldwLnYC87k8BVp/J6SYQ2n/wMWnjwkNygp0=;
        b=JMpIZInUa1+FkCVLLyfJgjyCUNamrdX67us0/vXle6pIhpFn15cjbX8bFq+2DBPFET
         HFFageew9+Jhlizjm63SCesiEvUzWPoEVZn1c92spX8iroYq49PTQpKOSqYmd5WKTnxs
         /bf9s3fzBwa14+d87I9VJ/XPS4nbzO3AA8CjF+7BX01wtqdncpi3v1BJ/FJcDp5+BerN
         WIVWkKDb43+yz7yb/zVVNKuQxBMfj2cyJJdEX5P5McoXIkpM4U5vdfXgQhFQRW8HOTc1
         t2cqajT2y46aIEXWo9IFg7ewFLdwUyASihy1aPRw9o79SY9Hit6riFKRowjF3KwCcEdy
         B7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5kN8TpKvldwLnYC87k8BVp/J6SYQ2n/wMWnjwkNygp0=;
        b=iubhAnQ86G9bxRevXtu8igPTi2t2uZ7RsRZ7e7lRhxixb1teErnOFy9BFDvgiPqCyu
         pfvYALWtvlldLaO2CW2WlVStk5eG7+S7dZUCrWAVLPW9e8X8cnFX9HtZHxNcFsoCkrfR
         CFD1lIzq7gdOJ3dZlg2/zDArP/S8Aq7MAQh4cXiBgRs7i/QRi0/AO84cj1RjYssnKG6V
         f8hR6KfLOK/Re2FqjQBdx+LCKAf7sWd0SnntV83GdLtFfw6l4grS3IVog4xtq7Hu8/aw
         aswHxAx/64+SeZMNYbCaqJNs/0lKaWsh7Ap967J7zL+wRZ33rwm1FVEY3mH4WA8eXNxC
         x1xg==
X-Gm-Message-State: AOUpUlGOKuf2XM48h/lL9hm17UBb/G9R8JYCe4MbhMCk6GDjntBX1mKl
        6BPPaRR9x14fsTPV/qn9YaM=
X-Google-Smtp-Source: AA+uWPzLVRC8XnvQRS+/MRk4tWffprMBYF8oFvuuTgQ4aalT8QCJsuaNUPKF4ef1IX4HzWKG3H9iUQ==
X-Received: by 2002:a19:dd81:: with SMTP id w1-v6mr8067196lfi.114.1534061761217;
        Sun, 12 Aug 2018 01:16:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id w73-v6sm2769576lfd.57.2018.08.12.01.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 01:16:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peartben@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 5/5] unpack-trees: reuse (still valid) cache-tree from src_index
Date:   Sun, 12 Aug 2018 10:15:51 +0200
Message-Id: <20180812081551.27927-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180812081551.27927-1-pclouds@gmail.com>
References: <20180804053723.4695-1-pclouds@gmail.com>
 <20180812081551.27927-1-pclouds@gmail.com>
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
---
 read-cache.c   | 2 ++
 unpack-trees.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 4fd35f4f37..2b5646ef26 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2763,4 +2763,6 @@ void move_index_extensions(struct index_state *dst, struct index_state *src)
 {
 	dst->untracked = src->untracked;
 	src->untracked = NULL;
+	dst->cache_tree = src->cache_tree;
+	src->cache_tree = NULL;
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index 6deb04c163..d822662c75 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1570,6 +1570,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	ret = check_updates(o) ? (-2) : 0;
 	if (o->dst_index) {
+		move_index_extensions(&o->result, o->src_index);
 		if (!ret) {
 			if (!o->result.cache_tree)
 				o->result.cache_tree = cache_tree();
@@ -1578,7 +1579,6 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 						  WRITE_TREE_SILENT |
 						  WRITE_TREE_REPAIR);
 		}
-		move_index_extensions(&o->result, o->src_index);
 		discard_index(o->dst_index);
 		*o->dst_index = o->result;
 	} else {
-- 
2.18.0.1004.g6639190530

