Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426FEC43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 22:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352635AbiFNWh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 18:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352721AbiFNWh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 18:37:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B496DEC9
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 15:37:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j11-20020a05690212cb00b006454988d225so8695923ybu.10
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 15:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e++JLH4XuEUCbYolIKAqVfYNaeimO5GAMfC8F8/EbDs=;
        b=Thou/2LDXJNdncjWj4sGEnHnr7Bqt0Sw+zSAhdHeRjEWHxoyYQLHf2xTZuIje4aL4P
         pcIphljmeGeQ7oDtCWGbqqF1QxnFsNM2mz/tfuwoWarZbFpV7hJ8sUb7Oo920E6n1yox
         upMxmals1j5viWxrtOOaS3CkHaorq72B0LuFZyFjjyrPsNQsXy0jIKtr6XEnJuxC+ROY
         8pZ4Eq3yZY6rVnrMYdjMxDwoAypw6C0Wk2SeI/xDxwGmCc1zJMREJ41fykKY+BGoUJS6
         jAALhHee4/TnIvZnxazt88H2/3rM7HcbXO2gBjzAkfVHFPkheXiblWkJGnZQVCqLFiTx
         Bhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e++JLH4XuEUCbYolIKAqVfYNaeimO5GAMfC8F8/EbDs=;
        b=lb35Gpns14chA7bbmspHrahz44t28g+xhCJ85uozFySYCJQUxPd+5rILjCDfH4NjBq
         0OqLF2QES0S6VU18NZmFJmP/OxK2xcu+lGMIjD/MWFKEuODL+fsnBzdLXgwbi4IDD5jm
         n8Ljd8t+yTAf4SCkcM7uTscI0mw940nDlaUIAefVDszdFF34ojjy2+Ie3irjKQGLEROj
         TZvTTtLl6O8VaCd8Blddv72KXuvrEAA/lQQCUmaaBHis3GVxWmgelUDbHyN5G5weE+sM
         MCr26QPkQvPqGxcSWd6IDiv0IAIko+/1LyFRhRoK6U90jY6jgijPLMb2RraErR0/I/b3
         mU+Q==
X-Gm-Message-State: AJIora/CaWBd5cdmKoDCW5LTnN8l+ZOqyvRBgZrq2715yg1SLzUkPMGa
        4iXXa0PXt0IL0PIFCW5fq8fAZtx7VADx9BkFcz7wXhwT3kOmxKY6F1jOnfmzcTDYvNS9COmvtRv
        fwolFmQlsGZJiSKLkaMNFKw+bczQNRGTRsn0rxPY7Ggxw626AnQl+J8P8246cb9c=
X-Google-Smtp-Source: AGRyM1tDrjhnDVDomo2COHz2f93IDz52lkwEqj63qc6u4BXDpb44CNbAnQKvWRKX1hDMuJONONafSt5lPBy7NQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:2875:8d7a:3bc6:3cab])
 (user=steadmon job=sendgmr) by 2002:a81:8414:0:b0:30c:33bf:6558 with SMTP id
 u20-20020a818414000000b0030c33bf6558mr8107542ywf.75.1655246244212; Tue, 14
 Jun 2022 15:37:24 -0700 (PDT)
Date:   Tue, 14 Jun 2022 15:37:21 -0700
In-Reply-To: <Yjt6mLIfw0V3aVTO@nand.local>
Message-Id: <9b56496b0809cc8a25af877ea97042e2cb7f2af6.1655246092.git.steadmon@google.com>
Mime-Version: 1.0
References: <Yjt6mLIfw0V3aVTO@nand.local>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v3] commit-graph: refactor to avoid prepare_repo_settings
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, derrickstolee@github.com,
        lessleydennington@gmail.com, gitster@pobox.com, vdye@github.com,
        avarab@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <me@ttaylorr.com>

Prior to ab14d0676c (commit-graph: pass a 'struct repository *' in more
places, 2020-09-09), parsing a commit-graph was a pure function
depending only on the contents of the commit-graph itself. Commit
ab14d0676c introduced a dependency on a `struct repository` pointer, and
later commits such as b66d84756f (commit-graph: respect
'commitGraph.readChangedPaths', 2020-09-09) added dependencies on config
settings, which were accessed through the `settings` field of the
repository pointer. This field was initialized via a call to
`prepare_repo_settings()`.

In 44c7e62 (2021-12-06, repo-settings:prepare_repo_settings only in git
repos), prepare_repo_settings was changed to issue a BUG() if it is
called by a process whose CWD is not a Git repository.

This series of changes broke fuzz-commit-graph, which attempts to parse
arbitrary fuzzing-engine-provided bytes as a commit graph file.
commit-graph.c:parse_commit_graph() calls prepare_repo_settings(), but
since we run the fuzz tests without a valid repository, we are hitting
the BUG() from 44c7e62 for every test case.

Fix this by moving the majority of the implementaiton of
`parse_commit_graph()` into a new function,
`parse_commit_graph_settings()` that accepts a repo_settings pointer.
This allows fuzz-commit-graph to continue to test the commit-graph
parser implementation without relying on prepare_repo_settings().

Additionally, properly initialize the
repo_settings.commit_graph_generation_version field in
prepare_repo_settings(). Load the value from the config if present, and
default to version 2 otherwise.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
Range-diff against v2:
1:  2c2bfc7b43 ! 1:  9b56496b08 commit-graph: refactor to avoid prepare_repo_settings
    @@ fuzz-commit-graph.c: int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size
      	initialize_the_repository();
     -	g = parse_commit_graph(the_repository, (void *)data, size);
     +	/*
    -+	 * Manually initialize commit-graph settings, to avoid the need to run
    -+	 * in an actual repository.
    ++	 * Initialize the_repository with commit-graph settings that would
    ++	 * normally be read from the repository's gitdir. We want to avoid
    ++	 * touching the disk to keep the individual fuzz-test cases as fast as
    ++	 * possible.
     +	 */
     +	the_repository->settings.commit_graph_generation_version = 2;
     +	the_repository->settings.commit_graph_read_changed_paths = 1;

 commit-graph.c      | 22 ++++++++++------------
 commit-graph.h      |  2 ++
 fuzz-commit-graph.c | 10 +++++++++-
 repo-settings.c     | 12 +++++++++++-
 repository.h        |  1 +
 5 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 265c010122..c54a734619 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -96,13 +96,6 @@ define_commit_slab(commit_graph_data_slab, struct commit_graph_data);
 static struct commit_graph_data_slab commit_graph_data_slab =
 	COMMIT_SLAB_INIT(1, commit_graph_data_slab);
 
-static int get_configured_generation_version(struct repository *r)
-{
-	int version = 2;
-	repo_config_get_int(r, "commitgraph.generationversion", &version);
-	return version;
-}
-
 uint32_t commit_graph_position(const struct commit *c)
 {
 	struct commit_graph_data *data =
@@ -335,6 +328,13 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 
 struct commit_graph *parse_commit_graph(struct repository *r,
 					void *graph_map, size_t graph_size)
+{
+	prepare_repo_settings(r);
+	return parse_commit_graph_settings(&r->settings, graph_map, graph_size);
+}
+
+struct commit_graph *parse_commit_graph_settings(struct repo_settings *s,
+						 void *graph_map, size_t graph_size)
 {
 	const unsigned char *data;
 	struct commit_graph *graph;
@@ -371,8 +371,6 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 		return NULL;
 	}
 
-	prepare_repo_settings(r);
-
 	graph = alloc_commit_graph();
 
 	graph->hash_len = the_hash_algo->rawsz;
@@ -402,14 +400,14 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 	pair_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges);
 	pair_chunk(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs);
 
-	if (get_configured_generation_version(r) >= 2) {
+	if (s->commit_graph_generation_version >= 2) {
 		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
 			&graph->chunk_generation_data);
 		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
 			&graph->chunk_generation_data_overflow);
 	}
 
-	if (r->settings.commit_graph_read_changed_paths) {
+	if (s->commit_graph_read_changed_paths) {
 		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   &graph->chunk_bloom_indexes);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
@@ -2288,7 +2286,7 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
 	ctx->opts = opts;
 	ctx->total_bloom_filter_data_size = 0;
-	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
+	ctx->write_generation_data = (r->settings.commit_graph_generation_version == 2);
 	ctx->num_generation_data_overflows = 0;
 
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
diff --git a/commit-graph.h b/commit-graph.h
index 04a94e1830..0f0d28b129 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -95,6 +95,8 @@ struct commit_graph *read_commit_graph_one(struct repository *r,
 					   struct object_directory *odb);
 struct commit_graph *parse_commit_graph(struct repository *r,
 					void *graph_map, size_t graph_size);
+struct commit_graph *parse_commit_graph_settings(struct repo_settings *s,
+					void *graph_map, size_t graph_size);
 
 /*
  * Return 1 if and only if the repository has a commit-graph
diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
index e7cf6d5b0f..810b1a8001 100644
--- a/fuzz-commit-graph.c
+++ b/fuzz-commit-graph.c
@@ -11,7 +11,15 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	struct commit_graph *g;
 
 	initialize_the_repository();
-	g = parse_commit_graph(the_repository, (void *)data, size);
+	/*
+	 * Initialize the_repository with commit-graph settings that would
+	 * normally be read from the repository's gitdir. We want to avoid
+	 * touching the disk to keep the individual fuzz-test cases as fast as
+	 * possible.
+	 */
+	the_repository->settings.commit_graph_generation_version = 2;
+	the_repository->settings.commit_graph_read_changed_paths = 1;
+	g = parse_commit_graph_settings(&the_repository->settings, (void *)data, size);
 	repo_clear(the_repository);
 	free_commit_graph(g);
 
diff --git a/repo-settings.c b/repo-settings.c
index b4fbd16cdc..26241c1c2c 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -10,6 +10,13 @@ static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
 		*dest = def;
 }
 
+static void repo_cfg_int(struct repository *r, const char *key, int *dest,
+			 int def)
+{
+	if (repo_config_get_int(r, key, dest))
+		*dest = def;
+}
+
 void prepare_repo_settings(struct repository *r)
 {
 	int experimental;
@@ -41,11 +48,14 @@ void prepare_repo_settings(struct repository *r)
 		r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
 	}
 
-	/* Boolean config or default, does not cascade (simple)  */
+	/* Commit graph config or default, does not cascade (simple) */
 	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
+	repo_cfg_int(r, "commitgraph.generationversion", &r->settings.commit_graph_generation_version, 2);
 	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
 	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
 	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
+
+	/* Boolean config or default, does not cascade (simple)  */
 	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
 	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
 	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
diff --git a/repository.h b/repository.h
index ca837cb9e9..4f8275f97c 100644
--- a/repository.h
+++ b/repository.h
@@ -29,6 +29,7 @@ struct repo_settings {
 	int initialized;
 
 	int core_commit_graph;
+	int commit_graph_generation_version;
 	int commit_graph_read_changed_paths;
 	int gc_write_commit_graph;
 	int fetch_write_commit_graph;

base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
-- 
2.36.1.476.g0c4daa206d-goog

