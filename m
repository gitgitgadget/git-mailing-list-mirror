Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3F6C433E2
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2E020723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaY3DwvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgE2Ivc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgE2Iva (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:30 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2520C08C5C6
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x6so2471964wrm.13
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GpLDdL2b7e0wU0xNiePpZD93QK43SHlYK9zMg82PJXk=;
        b=BaY3DwvH1S00lz4xfuSa03DmPMyvKR0ERL3mChdfQjTVBm+1CKY2zzWbh3k1TRRKYe
         +lC8XdTWxuAh6l97HVJwAQJjt9kJDdeeJejLGSmFV6IK0XocGYIP42WLeq1mYhuTcZ4n
         ILxErlbrp52z8r29fErKsPrdfqr4k9OyFXOUvUnqq9FwGcrTVmzIv3ql9TzsRxvZkEgY
         yvv646g8JDnFVjqcz9JvNZPSS4/o1jJQ+0BSsc+pP7Hv9slfw1GuqEbuhPUGhCQOPslR
         mOFQCkc2OLdP6l53Hss3zQ6gbwx0q8DqDHt5pXbRCMaIeGZF7rBCH4EW5s3mUJjb3wGJ
         wJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GpLDdL2b7e0wU0xNiePpZD93QK43SHlYK9zMg82PJXk=;
        b=CInM12YxhYgQcoVS2l6HLxxo+KRfbUdDnmtOKKMxiO5CUM2mv4WEjCzzPBL099ZyXh
         NVzEjncmWhWSGImKd2IFRbeyUDR+cpoSNgJAEdcEJ6HoxOF2JB+xc6ZjS/lpFKspp3z/
         cysIgA8ghc4ooQAql5jocSlCOje9+UIOmibmEDUaekNt6ySG33Oe8KUzDduGRilcWBse
         8b81Olwp0jm3L6oES0xCuGMew86oYm4DagTatFITNtIjcOT9T0jYSLVgSeJp/1IZxPhR
         qoXOASJtVNv64KPW/4txuPS8A/XEe2YKz5RJfKzz6oRwIku1j1BuAuhIYH6pgtRVUr0z
         //OQ==
X-Gm-Message-State: AOAM533RKK3g0cy01phNbQJYHsmaQEp7HK/90uA+WGWbITKm1ohAso7x
        9k6ACDDWcR/SvLCSggKIzz7qMYAg
X-Google-Smtp-Source: ABdhPJyvqgYnpHa3JxKuHFpbXEBYz1hjvoX5O0yNs8bfMLJYlqyBAb8IGUD6c9WGFq5zvgWwS5tn2Q==
X-Received: by 2002:a05:6000:12c4:: with SMTP id l4mr8188626wrx.128.1590742287823;
        Fri, 29 May 2020 01:51:27 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:27 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 20/34] commit-graph: fill the Modified Path Bloom Filter Index chunk
Date:   Fri, 29 May 2020 10:50:24 +0200
Message-Id: <20200529085038.26008-21-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Collect all paths modified by all commits, and write embedded modified
path Bloom filters for those commits that modify few enough paths to
fit into a 63 bit array using 7 hashes per path, i.e. 6 or less.

For now all modified path Bloom filters are created from scratch,
re-using filters from the existing commit-graph file will be done in a
later patch in this series.

Plug this into the custom revision walking loop in close_reachable(),
so the iteration is at least somewhat friendly to the delta base
cache, and we won't have yet another loop iterating over all commits.
Take care care that this loop might encounter the same commits
multiple times (e.g. because more than one refs point to the same
commit, or a commit is present in more than one pack file), and skip
creating a modified path Bloom filter for already processed commits.
We wouldn't need to be careful about this if we were to create
modified path Bloom filters a bit later on, after the list of commits
have been deduplicated, but at that point the commits are in SHA-1
order, i.e. effectively random, which is downright hostile to the
caches.

Perhaps processing the modified paths returned by the tree-diff
machinery turned out to be more complicated than strictly necessary,
but...

So, my initial approach was to first let diff_tree_oid() and
diffcore_std() do their thing and put all modified files into a diff
queue, then iterate over that queue and add all paths (i.e. leading
directories as well) to a hashmap with a suitable comparison function
for deduplication, use the number of elements in that hashmap to
properly size the Bloom filter's bit array, and finally iterate over
all paths in the hashmap and add them to the Bloom filter.  Simple,
short, straightforward, almost idiomatic even, without subtle corner
cases.

This approach, however, involved lot of memory allocations: three
allocations for each entry in the diff queue (IOW for each modified
file), and one allocation for each hashmap entry (IOW for each
modified path), not counting allocations for the hashmap's internals.
All these memory allocations caused considerable overhead.

This patch implements a more efficient, but more complex, approach:
register callback functions in 'struct diff_options' for add/removal
and modification, which process, deduplicate, and hash modified paths
_while_ the tree-diff machinery scans and compares the two trees.
Tree-diff calls these callback functions with the filenames in order
[1], so the deduplication of modified paths basically boils down to
skipping the common prefix with the previously processed path (and
some subtlety in case of dir-file replacement, as explained in an
in-code comment).  This way we don't do any memory allocations for
each modified file or path while processing the diff output, and the
memory allocations that are still left are amortized over the whole
commit-graph writing process.

[1] The tree-diff machinery would call its callbacks with out of order
    filenames if it encountered a bogus tree object with unsorted
    entries.  This doesn't affect the correctness of modified
    path Bloom filters only their sizes: the worst thing that can
    happen is that this approach would count and hash some paths more
    than once, thus Bloom filters containing paths modified compared
    to such a bogus tree object would end up bigger than expected.
    And bogus unsorted tree object cause all kinds of weird diff
    issues anyway...

[TODO: The pathchange callback is no good.]

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 243 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 238 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 3a38f25ce9..413605a29c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -16,6 +16,8 @@
 #include "progress.h"
 #include "bloom-filter.h"
 #include "commit-slab.h"
+#include "diff.h"
+#include "compat/PMurHash.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -37,8 +39,10 @@
 #define GRAPH_LAST_EDGE 0x80000000
 
 #define GRAPH_MODIFIED_PATH_BLOOM_FILTER_NONE 0xffffffffffffffff
+#define GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS 63
 
 #define GRAPH_MODIFIED_PATH_BLOOM_FILTER_DEFAULT_NR_HASHES 7
+#define GRAPH_MODIFIED_PATH_BLOOM_FILTER_DEFAULT_EMBEDDED_LIMIT 6
 
 #define GRAPH_HEADER_SIZE 8
 #define GRAPH_FANOUT_SIZE (4 * 256)
@@ -773,6 +777,36 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
 	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
 }
 
+static uint32_t modified_path_bloom_seeds[] = {
+	0xe83c5163U,
+	0x3b376b0cU,
+	0x72441af7U,
+	0x433860f3U,
+	0x6d9617f4U,
+	0x22705334U,
+	0xc8af66abU,
+	0x43b44ccfU,
+	0xb84f767cU,
+	0x1da177e4U
+};
+
+static void compute_modified_path_bloom_hashes_for_path(const char *path,
+		size_t len, unsigned int num_hashes, uint32_t *hashes)
+{
+	uint32_t h1, h2, i;
+
+	h1 = PMurHash32(modified_path_bloom_seeds[0], path, len);
+	h2 = PMurHash32(modified_path_bloom_seeds[1], path, len);
+
+	/* Equivalent to hashes[i] = h1 + i * h2 + (i * i * i - i) / 6 */
+	hashes[0] = h1;
+	for (i = 1; i < num_hashes; i++) {
+		h1 += h2;
+		h2 += i;
+		hashes[i] = h1;
+	}
+}
+
 struct packed_commit_list {
 	struct commit **list;
 	int nr;
@@ -816,6 +850,29 @@ struct write_commit_graph_context {
 	struct modified_path_bloom_filter_context {
 		unsigned use_modified_path_bloom_filters:1;
 		unsigned int num_hashes;
+		/*
+		 * Number of paths to be added to "embedded" modified path
+		 * Bloom filters.
+		 */
+		int embedded_limit;
+
+		struct diff_options diffopt;
+
+		/*
+		 * Used to deduplicate paths modified by the currenly
+		 * processed commit.
+		 */
+		struct strbuf prev_path;
+		size_t *hashed_prefix_lengths;
+		int hashed_prefix_lengths_nr, hashed_prefix_lengths_alloc;
+
+		/*
+		 * The tree-diff callbacks will fill this array with
+		 * 'num_hashes' hash values for each path modified by the
+		 * currently processed commit.
+		 */
+		uint32_t *hashes;
+		int hashes_nr, hashes_alloc;
 	} mpbfctx;
 };
 
@@ -1032,10 +1089,20 @@ static int write_graph_chunk_modified_path_bloom_index(struct hashfile *f,
 		bfi = modified_path_bloom_filters_peek(
 				&modified_path_bloom_filters, commit);
 
-		if (!bfi || !bfi->filter.nr_bits)
+		if (!bfi || !bfi->filter.nr_bits) {
 			hashwrite(f, &no_bloom_filter, sizeof(no_bloom_filter));
-		else
-			BUG("writing proper Bloom filters is not implemented yet");
+		} else if (bfi->filter.nr_bits == GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS) {
+			uint8_t filterdata[sizeof(uint64_t)];
+			memcpy(filterdata, bfi->filter.bits,
+			       sizeof(filterdata));
+			/*
+			 * Set the most significant bit of the first byte to
+			 * indicate embedded modified path Bloom Filter.
+			 */
+			filterdata[0] |= 1 << 7;
+			hashwrite(f, filterdata, sizeof(filterdata));
+		} else
+			BUG("writing non-embedded Bloom filters is not implemented yet");
 	}
 	return 0;
 }
@@ -1074,9 +1141,162 @@ static int add_packed_commits(const struct object_id *oid,
 	return 0;
 }
 
+static void handle_modified_file(
+		struct modified_path_bloom_filter_context *mpbfctx,
+		const char *path)
+{
+	const char *prev = mpbfctx->prev_path.buf;
+	const char *p = path;
+	size_t common_prefix_len, already_hashed_prefix_len = 0;
+	int i;
+
+	/*
+	 * We want to hash each modified path only once, i.e. if a commit
+	 * modifies both 'dir/foo' and 'dir/bar', then we want to hash
+	 * 'dir' only once.
+	 */
+
+	/*
+	 * Skip common prefix with the previously handled path, so we
+	 * hash any common leading directories only once.
+	 */
+	while (*prev && *p && *prev == *p) {
+		prev++;
+		p++;
+	}
+	common_prefix_len = p - path;
+
+	/*
+	 * However, merely skipping the common prefix is not enough.
+	 *
+	 * If a commit removes a file (symlink, or submodule) and adds a
+	 * directory with the same name (or vice versa), e.g. removes
+	 * 'foo' and adds 'foo/bar', and adds/modifies/removes 'foo.c',
+	 * then the tree-diff machinery will call this function with
+	 * those paths in the following order:
+	 *
+	 *   foo
+	 *   foo.c
+	 *   foo/bar
+	 *
+	 * So the first call hashes 'foo', the second hashes 'foo.c', so
+	 * far so good.  In the third call the common prefix of 'foo.c'
+	 * and 'foo/bar' is 'foo', and then an immediate strchrnul(p, '/')
+	 * would find the subsequent '/' and would hash 'foo' _again_.
+	 * Not so good.
+	 *
+	 * To avoid this we maintain the length of already hashed common
+	 * prefixes and skip one more character (i.e. the '/') if
+	 * necessary.
+	 */
+	for (i = 0; i < mpbfctx->hashed_prefix_lengths_nr; i++) {
+		if (common_prefix_len < mpbfctx->hashed_prefix_lengths[i]) {
+			mpbfctx->hashed_prefix_lengths_nr = i;
+			break;
+		}
+
+		already_hashed_prefix_len = mpbfctx->hashed_prefix_lengths[i];
+	}
+	if (common_prefix_len == already_hashed_prefix_len)
+		p = path + already_hashed_prefix_len + 1;
+
+	do {
+		unsigned int new_hashes_nr = mpbfctx->hashes_nr + mpbfctx->num_hashes;
+
+		p = strchrnul(p, '/');
+
+		ALLOC_GROW(mpbfctx->hashes, new_hashes_nr,
+			   mpbfctx->hashes_alloc);
+		compute_modified_path_bloom_hashes_for_path(path, p - path,
+				mpbfctx->num_hashes,
+				mpbfctx->hashes + mpbfctx->hashes_nr);
+		mpbfctx->hashes_nr = new_hashes_nr;
+
+		ALLOC_GROW(mpbfctx->hashed_prefix_lengths,
+			   mpbfctx->hashed_prefix_lengths_nr + 1,
+			   mpbfctx->hashed_prefix_lengths_alloc);
+		mpbfctx->hashed_prefix_lengths[mpbfctx->hashed_prefix_lengths_nr] = p - path;
+		mpbfctx->hashed_prefix_lengths_nr++;
+	} while (*p && p++);
+
+	/*
+	 * Update the previous path for the next iteration, copying only
+	 * as many characters as necessary.
+	 */
+	strbuf_setlen(&mpbfctx->prev_path, common_prefix_len);
+	strbuf_add(&mpbfctx->prev_path, path + common_prefix_len,
+		   p - (path + common_prefix_len));
+}
+
+static void file_add_remove_cb(struct diff_options *options,
+			       int addremove, unsigned mode,
+			       const struct object_id *oid,
+			       int oid_valid, const char *fullpath,
+			       unsigned dirty_submodule)
+{
+	handle_modified_file(options->change_fn_data, fullpath);
+}
+
+static void file_change_cb(struct diff_options *options,
+			   unsigned old_mode, unsigned new_mode,
+			   const struct object_id *old_oid,
+			   const struct object_id *new_oid,
+			   int old_oid_valid, int new_oid_valid,
+			   const char *fullpath,
+			   unsigned old_dirty_submodule,
+			   unsigned new_dirty_submodule)
+{
+	handle_modified_file(options->change_fn_data, fullpath);
+}
+
+static void create_modified_path_bloom_filter(
+		struct modified_path_bloom_filter_context *mpbfctx,
+		struct commit *commit)
+{
+	struct modified_path_bloom_filter_info *bfi;
+	struct object_id *parent_oid;
+	uintmax_t path_component_count;
+
+	if (!mpbfctx->use_modified_path_bloom_filters)
+		return;
+
+	/*
+	 * This function can be called multiple times for the same commit
+	 * (a commit can be present in multiple pack files, or multiple
+	 * refs can point to the same commit) so check first whether we have
+	 * already created a modified path Bloom filter for it.
+	 */
+	bfi = modified_path_bloom_filters_peek(&modified_path_bloom_filters,
+					       commit);
+	if (bfi && bfi->filter.nr_bits)
+		return;
+
+	parent_oid = commit->parents ? &commit->parents->item->object.oid :
+				       NULL;
+	mpbfctx->hashes_nr = 0;
+	strbuf_reset(&mpbfctx->prev_path);
+	diff_tree_oid(parent_oid, &commit->object.oid, "", &mpbfctx->diffopt);
+	path_component_count = mpbfctx->hashes_nr / mpbfctx->num_hashes;
+
+	if (path_component_count > mpbfctx->embedded_limit) {
+		/* Not implemented yet. */
+	} else {
+		bfi = modified_path_bloom_filters_at(
+				&modified_path_bloom_filters, commit);
+
+		bloom_filter_init_with_size(&bfi->filter,
+				GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS);
+		bloom_filter_set_bits(&bfi->filter, mpbfctx->hashes,
+				      mpbfctx->hashes_nr);
+	}
+}
+
 static void add_missing_parents(struct write_commit_graph_context *ctx, struct commit *commit)
 {
 	struct commit_list *parent;
+
+	create_modified_path_bloom_filter(&ctx->mpbfctx, commit);
+
 	for (parent = commit->parents; parent; parent = parent->next) {
 		if (!(parent->item->object.flags & REACHABLE)) {
 			ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
@@ -1888,9 +2108,18 @@ int write_commit_graph(const char *obj_dir,
 	} else if (res) {
 		ctx->mpbfctx.use_modified_path_bloom_filters = 1;
 		ctx->mpbfctx.num_hashes = GRAPH_MODIFIED_PATH_BLOOM_FILTER_DEFAULT_NR_HASHES;
-	}
+		ctx->mpbfctx.embedded_limit = GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS / (ctx->mpbfctx.num_hashes * 10 / 7);
 
 		init_modified_path_bloom_filters(&modified_path_bloom_filters);
+
+		repo_diff_setup(ctx->r, &ctx->mpbfctx.diffopt);
+		ctx->mpbfctx.diffopt.flags.recursive = 1;
+		ctx->mpbfctx.diffopt.add_remove = file_add_remove_cb;
+		ctx->mpbfctx.diffopt.change = file_change_cb;
+		ctx->mpbfctx.diffopt.change_fn_data = &ctx->mpbfctx;
+		diff_setup_done(&ctx->mpbfctx.diffopt);
+
+		strbuf_init(&ctx->mpbfctx.prev_path, PATH_MAX);
 	}
 
 	if (ctx->split) {
@@ -2013,10 +2242,14 @@ int write_commit_graph(const char *obj_dir,
 		free(ctx->commit_graph_hash_after);
 	}
 
-	if (ctx->mpbfctx.use_modified_path_bloom_filters)
+	if (ctx->mpbfctx.use_modified_path_bloom_filters) {
 		deep_clear_modified_path_bloom_filters(
 				&modified_path_bloom_filters,
 				free_modified_path_bloom_filter_info_in_slab);
+		strbuf_release(&ctx->mpbfctx.prev_path);
+		free(ctx->mpbfctx.hashed_prefix_lengths);
+		free(ctx->mpbfctx.hashes);
+	}
 
 	free(ctx);
 
-- 
2.27.0.rc1.431.g5c813f95dc

