Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72EA61F597
	for <e@80x24.org>; Sat,  4 Aug 2018 05:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeHDHg6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 03:36:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37783 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeHDHg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 03:36:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id j8-v6so5539863lfb.4
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 22:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Jiew399me2UNpo3EBFUxUIOHsIqFQnJSQokVY5OHgE=;
        b=Xz6j4rDX1q0pzNskD06caB9pb+wP89W9Rjv8gpEOwjxCmvUze7TSevZBnEaMu80vDr
         wbF1xV2BJ5MJEtT5XLHadhOKc40Gv6zyfZmBH5XE09Aj970CkBxA45YCq3VvlrNT4N3z
         Xpm0BkBQ8/xecSB+VMXPrmdWocTkwRbxF6+Q4ZYTkn8Ib7MQ0Jz1CU0rwAwnSZf1vOib
         bBz3yKo23HI7yO0qGumrtTN3iysJHSvn6JEli1TnuB5/ADRlc7t9rfH2XJPF2WEJeELe
         eeht+46TRHsP9iYJdYRXq4Zf4eD/YxjI9GfNBTwCUECSnvqDlgocI+UM7f2JisbcEyOT
         oeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Jiew399me2UNpo3EBFUxUIOHsIqFQnJSQokVY5OHgE=;
        b=afmYEdalXspazr18CTkm4b/wCW76u+4HMNm79Knihw42fWY1vCQ5PgvviBmdE07oao
         LZmkorc7PF4da87TxWVE/PGug1qzW/2HvqhEl2CRUbl9k3S+xLg93VCWqbMS3k4+fYLC
         DHkIToYkN0ZpJZgRTWyWqkibuGhIGI7h3WZYvBCnyX+GLIae56c2WHl3JTPkyK/nRMic
         vgPIj0VgTIvkQXBwcS1jO3vGdR3T/4NNEPWA58avH4tW6sFVqaIabb7DDONJ+mVul1aU
         GD5n8BOLxohh3sZCiFqoRWlvDWG9pNND7YPsRK69pW2GiZz5zmKTzUXNJa7+aD3sXF2g
         jxkQ==
X-Gm-Message-State: AOUpUlE+NuFQLBMnaHhbzNoyPPw0qsBXBPmcqDL/wGocBDHU2L7fdpTP
        B/7gqxWtZy8FJBtwbi2cXgo=
X-Google-Smtp-Source: AAOMgpfdhwxog8b77ALK2/g4foAlLeDsFEI/g9z/8iOIAW8x/W60Lbq6aH61pOmoiSSZouThNh8DxQ==
X-Received: by 2002:a19:d8e8:: with SMTP id r101-v6mr177864lfi.121.1533361053573;
        Fri, 03 Aug 2018 22:37:33 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id 85-v6sm1044021lft.76.2018.08.03.22.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 22:37:32 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peartben@gmail.com, peff@peff.net
Subject: [PATCH v3 2/4] unpack-trees: optimize walking same trees with cache-tree
Date:   Sat,  4 Aug 2018 07:37:21 +0200
Message-Id: <20180804053723.4695-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180804053723.4695-1-pclouds@gmail.com>
References: <20180729103306.16403-1-pclouds@gmail.com>
 <20180804053723.4695-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Duy Nguyen <pclouds@gmail.com>

In order to merge one or many trees with the index, unpack-trees code
walks multiple trees in parallel with the index and performs n-way
merge. If we find out at start of a directory that all trees are the
same (by comparing OID) and cache-tree happens to be available for
that directory as well, we could avoid walking the trees because we
already know what these trees contain: it's flattened in what's called
"the index".

The upside is of course a lot less I/O since we can potentially skip
lots of trees (think subtrees). We also save CPU because we don't have
to inflate and the apply deltas. The downside is of course more
fragile code since the logic in some functions are now duplicated
elsewhere.

"checkout -" with this patch on gcc.git:

    baseline      new
  --------------------------------------------------------------------
    0.018239226   0.019365414 s: read cache .git/index
    0.052541655   0.049605548 s: preload index
    0.001537598   0.001571695 s: refresh index
    0.168167768   0.049677212 s: unpack trees
    0.002897186   0.002845256 s: update worktree after a merge
    0.131661745   0.136597522 s: repair cache-tree
    0.075389117   0.075422517 s: write index, changed mask = 2a
    0.111702023   0.032813253 s: unpack trees
    0.000023245   0.000022002 s: update worktree after a merge
    0.111793866   0.032933140 s: diff-index
    0.587933288   0.398924370 s: git command: /home/pclouds/w/git/git

Another measurement from Ben's running "git checkout" with over 500k
trees (on the whole series):

    baseline        new
  ----------------------------------------------------------------------
    0.535510167     0.556558733     s: read cache .git/index
    0.3057373       0.3147105       s: initialize name hash
    0.0184082       0.023558433     s: preload index
    0.086910967     0.089085967     s: refresh index
    7.889590767     2.191554433     s: unpack trees
    0.120760833     0.131941267     s: update worktree after a merge
    2.2583504       2.572663167     s: repair cache-tree
    0.8916137       0.959495233     s: write index, changed mask = 28
    3.405199233     0.2710663       s: unpack trees
    0.000999667     0.0021554       s: update worktree after a merge
    3.4063306       0.273318333     s: diff-index
    16.9524923      9.462943133     s: git command: git.exe checkout

This command calls unpack_trees() twice, the first time on 2way merge
and the second 1way merge. In both times, "unpack trees" time is
reduced to one third. Overall time reduction is not that impressive of
course because index operations take a big chunk. And there's that
repair cache-tree line.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index a32ddee159..ba3d2e947e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -644,6 +644,102 @@ static inline int are_same_oid(struct name_entry *name_j, struct name_entry *nam
 	return name_j->oid && name_k->oid && !oidcmp(name_j->oid, name_k->oid);
 }
 
+static int all_trees_same_as_cache_tree(int n, unsigned long dirmask,
+					struct name_entry *names,
+					struct traverse_info *info)
+{
+	struct unpack_trees_options *o = info->data;
+	int i;
+
+	if (!o->merge || dirmask != ((1 << n) - 1))
+		return 0;
+
+	for (i = 1; i < n; i++)
+		if (!are_same_oid(names, names + i))
+			return 0;
+
+	return cache_tree_matches_traversal(o->src_index->cache_tree, names, info);
+}
+
+static int index_pos_by_traverse_info(struct name_entry *names,
+				      struct traverse_info *info)
+{
+	struct unpack_trees_options *o = info->data;
+	int len = traverse_path_len(info, names);
+	char *name = xmalloc(len + 1 /* slash */ + 1 /* NUL */);
+	int pos;
+
+	make_traverse_path(name, info, names);
+	name[len++] = '/';
+	name[len] = '\0';
+	pos = index_name_pos(o->src_index, name, len);
+	if (pos >= 0)
+		BUG("This is a directory and should not exist in index");
+	pos = -pos - 1;
+	if (!starts_with(o->src_index->cache[pos]->name, name) ||
+	    (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name)))
+		BUG("pos must point at the first entry in this directory");
+	free(name);
+	return pos;
+}
+
+/*
+ * Fast path if we detect that all trees are the same as cache-tree at this
+ * path. We'll walk these trees recursively using cache-tree/index instead of
+ * ODB since already know what these trees contain.
+ */
+static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
+				  struct name_entry *names,
+				  struct traverse_info *info)
+{
+	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
+	struct unpack_trees_options *o = info->data;
+	int i, d;
+
+	if (!o->merge)
+		BUG("We need cache-tree to do this optimization");
+
+	/*
+	 * Do what unpack_callback() and unpack_nondirectories() normally
+	 * do. But we walk all paths recursively in just one loop instead.
+	 *
+	 * D/F conflicts and staged entries are not a concern because
+	 * cache-tree would be invalidated and we would never get here
+	 * in the first place.
+	 */
+	for (i = 0; i < nr_entries; i++) {
+		struct cache_entry *tree_ce;
+		int len, rc;
+
+		src[0] = o->src_index->cache[pos + i];
+
+		len = ce_namelen(src[0]);
+		tree_ce = xcalloc(1, cache_entry_size(len));
+
+		tree_ce->ce_mode = src[0]->ce_mode;
+		tree_ce->ce_flags = create_ce_flags(0);
+		tree_ce->ce_namelen = len;
+		oidcpy(&tree_ce->oid, &src[0]->oid);
+		memcpy(tree_ce->name, src[0]->name, len + 1);
+
+		for (d = 1; d <= nr_names; d++)
+			src[d] = tree_ce;
+
+		rc = call_unpack_fn((const struct cache_entry * const *)src, o);
+		free(tree_ce);
+		if (rc < 0)
+			return rc;
+
+		mark_ce_used(src[0], o);
+	}
+	if (o->debug_unpack)
+		printf("Unpacked %d entries from %s to %s using cache-tree\n",
+		       nr_entries,
+		       o->src_index->cache[pos]->name,
+		       o->src_index->cache[pos + nr_entries - 1]->name);
+	return 0;
+}
+
 static int traverse_trees_recursive(int n, unsigned long dirmask,
 				    unsigned long df_conflicts,
 				    struct name_entry *names,
@@ -655,6 +751,17 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	void *buf[MAX_UNPACK_TREES];
 	struct traverse_info newinfo;
 	struct name_entry *p;
+	int nr_entries;
+
+	nr_entries = all_trees_same_as_cache_tree(n, dirmask, names, info);
+	if (nr_entries > 0) {
+		struct unpack_trees_options *o = info->data;
+		int pos = index_pos_by_traverse_info(names, info);
+
+		if (!o->merge || df_conflicts)
+			BUG("Wrong condition to get here buddy");
+		return traverse_by_cache_tree(pos, nr_entries, n, names, info);
+	}
 
 	p = names;
 	while (!p->mode)
@@ -814,6 +921,11 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info, con
 	return ce;
 }
 
+/*
+ * Note that traverse_by_cache_tree() duplicates some logic in this function
+ * without actually calling it. If you change the logic here you may need to
+ * check and change there as well.
+ */
 static int unpack_nondirectories(int n, unsigned long mask,
 				 unsigned long dirmask,
 				 struct cache_entry **src,
@@ -998,6 +1110,11 @@ static void debug_unpack_callback(int n,
 		debug_name_entry(i, names + i);
 }
 
+/*
+ * Note that traverse_by_cache_tree() duplicates some logic in this funciton
+ * without actually calling it. If you change the logic here you may need to
+ * check and change there as well.
+ */
 static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
 {
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
-- 
2.18.0.656.gda699b98b3

