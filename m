Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84F7B1F428
	for <e@80x24.org>; Sun, 12 Aug 2018 08:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeHLKxM (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 06:53:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37303 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeHLKxL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 06:53:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id j8-v6so9258069lfb.4
        for <git@vger.kernel.org>; Sun, 12 Aug 2018 01:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNxwkGjIEUD4oUboAqKqgcl3S6ddNV3d0TvpfYzdmKY=;
        b=FfbAknepvTp5vz+y8d6jkG9kD9p2uEibVxBPRqkGtjW+tRdyvcLqXNVi7mdrf6Yca5
         h6PLaWgtZx6mH3/j+YeGND85sizCeqwDjDcrTdCenR0GDT3WOChxV/hGE7NojZZTcmII
         0tOVN5yb7A2IzBKl4XWeh+lrwZgzSsTtK+fQLXn6ss1dW3OUWUs44LY2kBDTUuQcodq/
         NMkD5iev4NSA1bKXdth+42i3UtLz2UUiPBbm+OquspfSyCjm7+xuvmhImYOomihxfjk5
         NfxAiRkY7bNgkrayP6QykTwT2TsYFRA+sg4UseOAGC5lzAbfyeLJqVgZFFIZH/hoI+5+
         1Wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNxwkGjIEUD4oUboAqKqgcl3S6ddNV3d0TvpfYzdmKY=;
        b=aP7AvXSXTc8L+E7fTfqFun7lb4atfMb6ch17nKiTgcYTBH4IEsdH6zVxvBYyULlVtq
         pX3eu6CvlBt5jYtyYPkRJooNj6rv2czWDIaSi0JaqsPHvl3KynQdqSxkamn9aGxTnyRG
         f09G+POBL5JzB/xeDn7l0aPwVO+wUiOCY/9CJhw8efoIsszmZ2FLCmv+SAGwqDGzmA3J
         oagRPbhDoso5uMhI/p0X8jS1TNwOG0RR7ORiAdOgs26Y/lpwwoY92MeARubYhNnbrgOS
         QvF7pF8pelvojElc7Yx01o45j6VicNV9ivQIZDcwSNe/w3roNT/Arlxol/kd/GmOv8rD
         kaDg==
X-Gm-Message-State: AOUpUlG10FdC5JvK7XMfghw+BeX/H6tzQXR0DPzbLYxAugW59eRdMOPr
        I3ZWT6wwJHwYjkGm7hp6BT8=
X-Google-Smtp-Source: AA+uWPzlNzBVM0xj7TZY7LmkttemcuvSt3xGv7Mph8VeF5u8WSnKyL+Kgw5wi9gwAOreia/a0TV5RQ==
X-Received: by 2002:a19:14dc:: with SMTP id 89-v6mr8036447lfu.45.1534061758947;
        Sun, 12 Aug 2018 01:15:58 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id w73-v6sm2769576lfd.57.2018.08.12.01.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 01:15:58 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peartben@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 3/5] unpack-trees: optimize walking same trees with cache-tree
Date:   Sun, 12 Aug 2018 10:15:49 +0200
Message-Id: <20180812081551.27927-4-pclouds@gmail.com>
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

In order to merge one or many trees with the index, unpack-trees code
walks multiple trees in parallel with the index and performs n-way
merge. If we find out at start of a directory that all trees are the
same (by comparing OID) and cache-tree happens to be available for
that directory as well, we could avoid walking the trees because we
already know what these trees contain: it's flattened in what's called
"the index".

The upside is of course a lot less I/O since we can potentially skip
lots of trees (think subtrees). We also save CPU because we don't have
to inflate and apply the deltas. The downside is of course more
fragile code since the logic in some functions are now duplicated
elsewhere.

"checkout -" with this patch on webkit.git (275k files):

    baseline      new
  --------------------------------------------------------------------
    0.056651714   0.080394752 s:  read cache .git/index
    0.183101080   0.216010838 s:  preload index
    0.008584433   0.008534301 s:  refresh index
    0.633767589   0.251992198 s:   traverse_trees
    0.340265448   0.377031383 s:   check_updates
    0.381884638   0.372768105 s:   cache_tree_update
    1.401562947   1.045887251 s:  unpack_trees
    0.338687914   0.314983512 s:  write index, changed mask = 2e
    0.411927922   0.062572653 s:    traverse_trees
    0.000023335   0.000022544 s:    check_updates
    0.423697246   0.073795585 s:   unpack_trees
    0.423708360   0.073807557 s:  diff-index
    2.559524127   1.938191592 s: git command: git checkout -

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

PS. A note about cache-tree invalidation and the use of it in this
code.

We do invalidate cache-tree in _source_ index when we add new entries
to the (temporary) "result" index. But we also use the cache-tree from
source index in this optimization. Does this mean we end up having no
cache-tree in the source index to activate this optimization?

The answer is twisted: the order of finding a good cache-tree and
invalidating it matters. In this case we check for a good cache-tree
first in all_trees_same_as_cache_tree(), then we start to merge things
and potentially invalidate that same cache-tree in the process. Since
cache-tree invalidation happens after the optimization kicks in, we're
still good. But we may lose that cache-tree at the very first
call_unpack_fn() call in traverse_by_cache_tree().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index b237eaa0f2..07456d0fb2 100644
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
+	 * D/F conflicts and higher stage entries are not a concern
+	 * because cache-tree would be invalidated and we would never
+	 * get here in the first place.
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
@@ -655,6 +751,27 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
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
+
+		/*
+		 * All entries up to 'pos' must have been processed
+		 * (i.e. marked CE_UNPACKED) at this point. But to be safe,
+		 * save and restore cache_bottom anyway to not miss
+		 * unprocessed entries before 'pos'.
+		 */
+		bottom = o->cache_bottom;
+		ret = traverse_by_cache_tree(pos, nr_entries, n, names, info);
+		o->cache_bottom = bottom;
+		return ret;
+	}
 
 	p = names;
 	while (!p->mode)
@@ -814,6 +931,11 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info, con
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
@@ -998,6 +1120,11 @@ static void debug_unpack_callback(int n,
 		debug_name_entry(i, names + i);
 }
 
+/*
+ * Note that traverse_by_cache_tree() duplicates some logic in this function
+ * without actually calling it. If you change the logic here you may need to
+ * check and change there as well.
+ */
 static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
 {
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
-- 
2.18.0.1004.g6639190530

