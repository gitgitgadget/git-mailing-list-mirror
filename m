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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902A2C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65CE120723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjlPcBWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgE2Ivl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgE2Ivc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6173C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e1so2572888wrt.5
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bmrij8QsJAHFw41Cp840lVkMmesXohpmVoiWgCWgeao=;
        b=HjlPcBWxmW+veH4Icl1Fspe4bwuHQJZUz27zUXA4YLjDgsT+kdWxViVBaWwb66hBB/
         YGC7mUxlM0LNUjXx0vW4167jTdAFYTfZHe83d+ChnmKZ3ooMpaQLb8wJ3Icl8665CB6u
         btzIZSE0elVRpi16qAIlNF9AgWdVJLcF4ymRD1R1GOO6rkchAZJI0LlKL/ag3QLygDHn
         7MIi6xC68jLw1/RgpsABMCLni0W/2Q5BOvDblaxx1IHRItmzOxxdMz7JUHw3CAohdKa6
         JaWqjBpxjWGyaBp2UsKU+i1hTLngOM+og6okt4V5QkhJQQfHA8Qmu8ULWyJXqqtIK3MV
         hLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bmrij8QsJAHFw41Cp840lVkMmesXohpmVoiWgCWgeao=;
        b=s11JJcvyBVSehLTQnP6TZSXBc/8aB7+/AH/cNrtQXVJHQkmvPxaAxI1ZO2TYMkP1ue
         1iJRN7Tq50w0NeHY56wUFnrCF3r+LXwazN4zXozKDeTTX7kyPpMruR/xDgSfOsFrJaHD
         hX6Eyu7Ti2+STMMNPmq7aWRhtEHvOGH7sEA25oWGpVa3dCywPLW4BwEHOCc/llsQ8iIL
         osZoZGEtBr7giLdkDVAB3V+BZi2u9o5hiaTcJSOPNTLLtoImQX3rsq9dFPsFlJtr6bZQ
         sw+DXJ/ICwMcdorMUE91WuNoHewmaFgoj/qzm0O+QuD8p1quwKJ2DZak8kMooiqr2MxE
         utVw==
X-Gm-Message-State: AOAM532gtvYTfaSvMxU9q8ID31NzT/j5fDkr24kmnlZGbyvA719Hhtoj
        rhd7S5IXM+uDMPl7qzFpzhLLcsVH
X-Google-Smtp-Source: ABdhPJyRQBkAx38fSxkd65wViqRe1yS52yutdik9Nm6SMg18qxeIIOF1DO8iOI/Vx8EfNIvIudQH8g==
X-Received: by 2002:a5d:6550:: with SMTP id z16mr8211619wrv.392.1590742289715;
        Fri, 29 May 2020 01:51:29 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:28 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 21/34] commit-graph: load and use the Modified Path Bloom Filter Index chunk
Date:   Fri, 29 May 2020 10:50:25 +0200
Message-Id: <20200529085038.26008-22-szeder.dev@gmail.com>
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

Load the Modified Path Bloom Filter Index (MPBI) chunk and check the
embedded modified path Bloom filters within to speed up
pathspec-limited revison walks.

Extend 'struct pathspec_item' to hold the hashes of each path for
modified path Bloom filters.  Pathspecs are used by many Git commands,
and a lot of them doesn't do any revision walk at all, so don't
initialize those fields in parse_pathspec(), but only when we are
about to start a pathspec-limited revision walk, i.e. in
prepare_revision_walk().  Initialize these fields only in the
revs->pruning.pathspec instance, because that's the one used to limit
the revision walk.  Note that some revision walks re-parse the
pathspecs, notably 'git log --follow' and the line-level log, but they
don't use this pathspec instance.

The table below shows the average runtime and speedup of

  git rev-list HEAD -- "$path"

for 5000+ randomly selected paths from each repository with and
without modified path Bloom filters:

                   Average runtime
                  without      with
                    MPBI       MPBI
  --------------------------------------------
  android-base    0.8780s      n/a
  cmssw           0.3143s    0.2104s    -33.1%
  cpython         0.7453s    0.3410s    -54.2%
  gcc             7.1852s    3.3633s    -53.2%
  gecko-dev       4.6113s      n/a
  git             0.6180s    0.2184s    -64.7%
  glibc           0.5618s    0.3245s    -42.2%
  jdk             0.0482s    0.0395s    -18.0%
  linux           0.7043s    0.4810s    -31.6%
  llvm-project    2.6844s      n/a
  rails           0.2784s    0.1792s    -35.6%
  rust            0.7757s    0.6073s    -21.7%
  webkit          1.9137s    1.4832s    -22.5%

The results in the homebrew-core repository can be spectacular, though
that repository looks like as if it was specifically designed to show
off the benefits of this patch: over 98% of its almost 164k commits in
its linear history modify one file within the 'Formula' directory, and
that directory contains almost 5000 files.  Consequently, almost all
commits will have a 63 bit "embedded" modified path Bloom filter
containing only 2 paths, resulting in a false positive rate less than
0.1%, and they can spare a lot of expensive tree entry scanning to the
end of that directory.  So looking at the history of the first and
last files in that directory:

                         Runtime                       Max RSS
                   without     with              without      with
                     MPBI      MPBI   Speedup      MPBI       MPBI
  -----------------------------------------------------------------
  Formula/a2ps.rb   8.390s    0.218s    38.5x    422884k    129212k
  Formula/zzz.rb   80.495s    0.176s   450.4x    423744k     68364k

('Formula/a2ps.rb' is modified 32 times and has two false positives,
while 'zzz.rb' is modified only twice and happens to have only a
single false positive; that's why querying the history of the former
is slower, even though it's at the beginning of the directory).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 146 +++++++++++++++++++++++++++++++++++++++++++++++++
 commit-graph.h |  13 +++++
 pathspec.c     |   9 +++
 pathspec.h     |  12 ++++
 revision.c     |  18 ++++++
 5 files changed, 198 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 413605a29c..fb24600bb3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -26,6 +26,7 @@
 #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
 #define GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTER_INDEX 0x4d504249 /* "MPBI" */
+#define GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTER_EXCLUDES 0x4d504258 /* "MPBX" */
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
@@ -308,6 +309,23 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 				chunk_repeated = 1;
 			else
 				graph->chunk_base_graphs = data + chunk_offset;
+			break;
+
+		case GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTER_INDEX:
+			if (graph->chunk_mpbf_index)
+				chunk_repeated = 1;
+			else {
+				graph->chunk_mpbf_index = data + chunk_offset;
+				graph->chunk_mpbf_index_size = next_chunk_offset - chunk_offset;
+			}
+			break;
+
+		case GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTER_EXCLUDES:
+			if (graph->chunk_mpbf_excludes)
+				chunk_repeated = 1;
+			else
+				graph->chunk_mpbf_excludes = data + chunk_offset;
+			break;
 		}
 
 		if (chunk_repeated) {
@@ -324,6 +342,29 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 		return NULL;
 	}
 
+	if (graph->chunk_mpbf_index) {
+		int res = 0;
+		git_config_get_bool("core.modifiedPathBloomFilters", &res);
+		if (res) {
+			uint64_t expected_size = sizeof(uint8_t) +
+						 graph->num_commits * sizeof(uint64_t);
+			if (graph->chunk_mpbf_index_size != expected_size)
+				BUG(_("for %u commits the Modified Path Bloom Filter Index chunk should be %ld bytes, but it's %ld"),
+				    graph->num_commits, expected_size,
+				    graph->chunk_mpbf_index_size);
+			graph->num_modified_path_bloom_hashes = *graph->chunk_mpbf_index;
+			if (!graph->num_modified_path_bloom_hashes)
+				BUG(_("Modified Path Bloom Filter Index chunk using 0 hashes"));
+			if (graph->chunk_mpbf_excludes)
+				/*
+				 * Modified Path Bloom Filter Excludes are
+				 * not supported yet.
+				 */
+				graph->chunk_mpbf_index = NULL;
+		} else
+			graph->chunk_mpbf_index = NULL;
+	}
+
 	return graph;
 }
 
@@ -777,6 +818,68 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
 	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
 }
 
+static int load_modified_path_bloom_filter_from_graph(
+		struct commit_graph *graph, struct commit *commit,
+		struct commit *parent, struct bloom_filter *bf)
+{
+	const uint8_t *bloom_index;
+	int first_parent = 0;
+
+	if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
+		return 0;
+	if (!graph)
+		return 0;
+	if (!graph->chunk_mpbf_index)
+		return 0;
+
+	if (!commit->parents || commit->parents->item == parent)
+		first_parent = 1;
+
+	bloom_index = graph->chunk_mpbf_index + sizeof(uint8_t) +
+		      sizeof(uint64_t) * commit->graph_pos;
+
+	if (bloom_index[0] & (1 << 7)) {
+		uint64_t v;
+		if (!first_parent)
+			return 0;
+		memcpy(&v, bloom_index, sizeof(v));
+		if (v == GRAPH_MODIFIED_PATH_BLOOM_FILTER_NONE)
+			return 0;
+
+		/* embedded modified path Bloom filter */
+		bf->nr_bits = GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS;
+		bf->bits = (uint8_t*) bloom_index;
+		return 1;
+	}
+	/* support for non-embedded Bloom filters is not implemented yet. */
+	return 0;
+}
+
+enum bloom_result check_modified_path_bloom_filter(struct repository *r,
+		struct pathspec *pathspec, struct commit *parent,
+		struct commit *commit)
+{
+	struct bloom_filter bf;
+	int i;
+
+	if (!pathspec->can_use_modified_path_bloom_filters)
+		return BLOOM_CANT_TELL;
+	if (!load_modified_path_bloom_filter_from_graph(r->objects->commit_graph,
+							commit, parent, &bf))
+		return BLOOM_CANT_TELL;
+
+	for (i = 0; i < pathspec->nr; i++) {
+		struct pathspec_item *pi = &pathspec->items[i];
+
+		if (bloom_filter_check_bits(&bf,
+					pi->modified_path_bloom_hashes,
+					pi->modified_path_bloom_hashes_nr))
+			return BLOOM_POSSIBLY_YES;
+	}
+
+	return BLOOM_DEFINITELY_NOT;
+}
+
 static uint32_t modified_path_bloom_seeds[] = {
 	0xe83c5163U,
 	0x3b376b0cU,
@@ -807,6 +910,49 @@ static void compute_modified_path_bloom_hashes_for_path(const char *path,
 	}
 }
 
+void init_pathspec_bloom_fields(struct repository *r,
+				struct pathspec *pathspec)
+{
+	const unsigned bloom_compatible_magic = PATHSPEC_LITERAL;
+	struct commit_graph *graph = r->objects->commit_graph;
+	int i;
+
+	if (!graph)
+		return;
+	if (!graph->chunk_mpbf_index)
+		return;
+	if (!pathspec->nr)
+		return;
+	if (pathspec->has_wildcard)
+		return;
+	if (pathspec->magic & ~bloom_compatible_magic)
+		return;
+
+	for (i = 0; i < pathspec->nr; i++) {
+		struct pathspec_item *pi = &pathspec->items[i];
+		const char *path = pi->match;
+		size_t len = pi->len;
+
+		/*
+		 * Pathspec parsing has normalized away any consecutive
+		 * slashes, but a trailing slash might still be present,
+		 * "remove" it.
+		 */
+		if (path[len - 1] == '/')
+			len--;
+
+		pi->modified_path_bloom_hashes_nr = graph->num_modified_path_bloom_hashes;
+		ALLOC_ARRAY(pi->modified_path_bloom_hashes,
+			    pi->modified_path_bloom_hashes_nr);
+
+		compute_modified_path_bloom_hashes_for_path(path, len,
+				graph->num_modified_path_bloom_hashes,
+				pi->modified_path_bloom_hashes);
+	}
+
+	pathspec->can_use_modified_path_bloom_filters = 1;
+}
+
 struct packed_commit_list {
 	struct commit **list;
 	int nr;
diff --git a/commit-graph.h b/commit-graph.h
index 847cd25cfc..09dfc16932 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -11,6 +11,8 @@ struct commit;
 struct repository;
 struct raw_object_store;
 struct string_list;
+struct bloom_filter;
+struct pathspec;
 
 char *get_commit_graph_filename(const char *obj_dir);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
@@ -38,6 +40,12 @@ void load_commit_graph_info(struct repository *r, struct commit *item);
 struct tree *get_commit_tree_in_graph(struct repository *r,
 				      const struct commit *c);
 
+enum bloom_result check_modified_path_bloom_filter(struct repository *r,
+		struct pathspec *pathspec, struct commit *parent,
+		struct commit *commit);
+void init_pathspec_bloom_fields(struct repository *r,
+		struct pathspec *pathspec);
+
 struct commit_graph {
 	int graph_fd;
 
@@ -59,6 +67,11 @@ struct commit_graph {
 	const unsigned char *chunk_commit_data;
 	const unsigned char *chunk_extra_edges;
 	const unsigned char *chunk_base_graphs;
+	const unsigned char *chunk_mpbf_index;
+	uint64_t chunk_mpbf_index_size;
+	const unsigned char *chunk_mpbf_excludes;
+
+	uint8_t num_modified_path_bloom_hashes;
 };
 
 struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
diff --git a/pathspec.c b/pathspec.c
index 128f27fcb7..01e7ae6944 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -406,6 +406,8 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 	item->attr_check = NULL;
 	item->attr_match = NULL;
 	item->attr_match_nr = 0;
+	item->modified_path_bloom_hashes_nr = 0;
+	item->modified_path_bloom_hashes = NULL;
 
 	/* PATHSPEC_LITERAL_PATH ignores magic */
 	if (flags & PATHSPEC_LITERAL_PATH) {
@@ -674,6 +676,12 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 		}
 
 		d->attr_check = attr_check_dup(s->attr_check);
+
+		ALLOC_ARRAY(d->modified_path_bloom_hashes,
+			    d->modified_path_bloom_hashes_nr);
+		COPY_ARRAY(d->modified_path_bloom_hashes,
+			   s->modified_path_bloom_hashes,
+			   d->modified_path_bloom_hashes_nr);
 	}
 }
 
@@ -684,6 +692,7 @@ void clear_pathspec(struct pathspec *pathspec)
 	for (i = 0; i < pathspec->nr; i++) {
 		free(pathspec->items[i].match);
 		free(pathspec->items[i].original);
+		free(pathspec->items[i].modified_path_bloom_hashes);
 
 		for (j = 0; j < pathspec->items[i].attr_match_nr; j++)
 			free(pathspec->items[i].attr_match[j].value);
diff --git a/pathspec.h b/pathspec.h
index 454ce364fa..0c661e1b03 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -32,6 +32,7 @@ struct pathspec {
 	unsigned int has_wildcard:1;
 	unsigned int recursive:1;
 	unsigned int recurse_submodules:1;
+	unsigned int can_use_modified_path_bloom_filters:1;
 	unsigned magic;
 	int max_depth;
 	struct pathspec_item {
@@ -52,6 +53,17 @@ struct pathspec {
 			} match_mode;
 		} *attr_match;
 		struct attr_check *attr_check;
+
+		/*
+		 * These fields are only relevant during pathspec-limited
+		 * revision walks, init_pathspec_item() leaves them
+		 * zero-initialized, but copy_pathspec() copies them,
+		 * and clear_pathspec() releases the allocated memory.
+		 * IOW: they are only valid if 'struct pathspec's
+		 * 'can_use_modified_path_bloom_filters' bit is set.
+		 */
+		uint32_t modified_path_bloom_hashes_nr;
+		uint32_t *modified_path_bloom_hashes;
 	} *items;
 };
 
diff --git a/revision.c b/revision.c
index 9dac1262ef..6ec4bc0cb1 100644
--- a/revision.c
+++ b/revision.c
@@ -29,6 +29,7 @@
 #include "prio-queue.h"
 #include "hashmap.h"
 #include "utf8.h"
+#include "bloom-filter.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -629,6 +630,7 @@ static int rev_compare_tree(struct rev_info *revs,
 {
 	struct tree *t1 = get_commit_tree(parent);
 	struct tree *t2 = get_commit_tree(commit);
+	enum bloom_result bloom_ret;
 
 	if (!t1)
 		return REV_TREE_NEW;
@@ -653,6 +655,12 @@ static int rev_compare_tree(struct rev_info *revs,
 			return REV_TREE_SAME;
 	}
 
+	bloom_ret = check_modified_path_bloom_filter(revs->repo,
+						     &revs->pruning.pathspec,
+						     parent, commit);
+	if (bloom_ret == BLOOM_DEFINITELY_NOT)
+		return REV_TREE_SAME;
+
 	tree_difference = REV_TREE_SAME;
 	revs->pruning.flags.has_changes = 0;
 	diff_tree_oid(&t1->object.oid, &t2->object.oid, "", &revs->pruning);
@@ -662,10 +670,17 @@ static int rev_compare_tree(struct rev_info *revs,
 static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 {
 	struct tree *t1 = get_commit_tree(commit);
+	enum bloom_result bloom_ret;
 
 	if (!t1)
 		return 0;
 
+	bloom_ret = check_modified_path_bloom_filter(revs->repo,
+						     &revs->pruning.pathspec,
+						     NULL, commit);
+	if (bloom_ret == BLOOM_DEFINITELY_NOT)
+		return 1;
+
 	tree_difference = REV_TREE_SAME;
 	revs->pruning.flags.has_changes = 0;
 	diff_tree_oid(NULL, &t1->object.oid, "", &revs->pruning);
@@ -3376,6 +3391,9 @@ int prepare_revision_walk(struct rev_info *revs)
 		simplify_merges(revs);
 	if (revs->children.name)
 		set_children(revs);
+
+	init_pathspec_bloom_fields(revs->repo, &revs->pruning.pathspec);
+
 	return 0;
 }
 
-- 
2.27.0.rc1.431.g5c813f95dc

