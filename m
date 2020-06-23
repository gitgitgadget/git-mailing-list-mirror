Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51990C433E1
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC0F20780
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyGuk9+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733250AbgFWRrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733156AbgFWRrR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 13:47:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD1FC061795
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:16 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so2742677wmf.5
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sYeRzy3NN5UMY3/v2uT3PQdy+N59M4OW78Nyx9IeK/U=;
        b=UyGuk9+ki/Zz9Jd2psbJD7Si8WTjt7qujXhmJz9lq2mCLeTgYfFSL3J+bvSiHlno5y
         WVGWthCl3CZn4Ytj4BlJeKdV0ZD1LoMRLAxZyDnfCZK2dyCO8dQSYGDHjanhJqcCc4XB
         Sr3IJYCFJoi6gJdZzqjbQ3DbdNCkNtaLQ9aRAUiM/UMqpfSEx+QfqZeaGZFqc25h/v9F
         CKsZN4nRczGgGAX6iCAugjPFDBFpWfldlcUJn7fe+EzXFN6VLUhrOPMdkGXfhE+LXH4Q
         qS+AzINtA8o/Jejvf2BG2m2wZXYio6ZV1nhrxvkpLTzWmi24ITkt2dnybXS20yTfE816
         wIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sYeRzy3NN5UMY3/v2uT3PQdy+N59M4OW78Nyx9IeK/U=;
        b=nK6du51JNPA/sQv1UDHvzCeWbsaAbS4WD5tVHVsIx+AOuT758OlbyPXNVwIZzuKu4B
         pQiD6CFqMijLkUmDQdMkU4PGhSjQRBk0zt0g8NkzUSt0BBbXskGAcMWXdUO7sfKd2a3O
         Nd/ABunmxA+gHRztnauGPkRj0YOq5lohq8BWy504ImeFP6GOfYzOl7SkXDPXNP3If0fj
         oAfU0i/O0lO66+PqeJ+cWeTSaloqOX5emoSqQzB1Luw2if7/w9OJFGCQhnaVu+AoaHSr
         grhqM8dKGWk/t2A5R7q5IYYBu60txMMzeW4mfrfCePFb5EoRo4GUCqF2zCcwtvkJef3C
         2+fA==
X-Gm-Message-State: AOAM532t73m8NBhtPeXlrVWssLc4kVFWYJbe0VERZP6dOxAkZq5ZMCGm
        Sx6OU7+RP1ciJwA22UppYl8UyD73
X-Google-Smtp-Source: ABdhPJwGllYqp0KxkhO81M4CXn38Nb5a0A3DS9or+nVIGTlY0+QIBUxcVgsIC3LGIQ885O3CBvCMZQ==
X-Received: by 2002:a1c:2049:: with SMTP id g70mr21407032wmg.90.1592934435294;
        Tue, 23 Jun 2020 10:47:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm15467594wrt.73.2020.06.23.10.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 10:47:14 -0700 (PDT)
Message-Id: <8727b254680fdbc4f42f8b46c6ec686e7fa33fbe.1592934430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
        <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 17:47:03 +0000
Subject: [PATCH v2 04/11] commit-graph: persist existence of changed-paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The changed-path Bloom filters were released in v2.27.0, but have a
significant drawback. A user can opt-in to writing the changed-path
filters using the "--changed-paths" option to "git commit-graph write"
but the next write will drop the filters unless that option is
specified.

This becomes even more important when considering the interaction with
gc.writeCommitGraph (on by default) or fetch.writeCommitGraph (part of
features.experimental). These config options trigger commit-graph writes
that the user did not signal, and hence there is no --changed-paths
option available.

Allow a user that opts-in to the changed-path filters to persist the
property of "my commit-graph has changed-path filters" automatically. A
user can drop filters using the --no-changed-paths option.

In the process, we need to be extremely careful to match the Bloom
filter settings as specified by the commit-graph. This will allow future
versions of Git to customize these settings, and the version with this
change will persist those settings as commit-graphs are rewritten on
top.

Use the trace2 API to signal the settings used during the write, and
check that output in a test after manually adjusting the correct bytes
in the commit-graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  5 +++-
 builtin/commit-graph.c             |  5 +++-
 commit-graph.c                     | 38 ++++++++++++++++++++++++++++--
 commit-graph.h                     |  1 +
 t/t4216-log-bloom.sh               | 29 ++++++++++++++++++++++-
 5 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index f4b13c005b..369b222b08 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -60,7 +60,10 @@ existing commit-graph file.
 With the `--changed-paths` option, compute and write information about the
 paths changed between a commit and it's first parent. This operation can
 take a while on large repositories. It provides significant performance gains
-for getting history of a directory or a file with `git log -- <path>`.
+for getting history of a directory or a file with `git log -- <path>`. If
+this option is given, future commit-graph writes will automatically assume
+that this option was intended. Use `--no-changed-paths` to stop storing this
+data.
 +
 With the `--split` option, write the commit-graph as a chain of multiple
 commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 59009837dc..ff7b177c33 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -151,6 +151,7 @@ static int graph_write(int argc, const char **argv)
 	};
 
 	opts.progress = isatty(2);
+	opts.enable_changed_paths = -1;
 	split_opts.size_multiple = 2;
 	split_opts.max_commits = 0;
 	split_opts.expire_time = 0;
@@ -171,7 +172,9 @@ static int graph_write(int argc, const char **argv)
 		flags |= COMMIT_GRAPH_WRITE_SPLIT;
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
-	if (opts.enable_changed_paths ||
+	if (!opts.enable_changed_paths)
+		flags |= COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS;
+	if (opts.enable_changed_paths == 1 ||
 	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
diff --git a/commit-graph.c b/commit-graph.c
index 6a28d4a5a6..908f094271 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -16,6 +16,8 @@
 #include "progress.h"
 #include "bloom.h"
 #include "commit-slab.h"
+#include "json-writer.h"
+#include "trace2.h"
 
 void git_test_write_commit_graph_or_die(void)
 {
@@ -1107,6 +1109,21 @@ static void write_graph_chunk_bloom_indexes(struct hashfile *f,
 	stop_progress(&progress);
 }
 
+static void trace2_bloom_filter_settings(struct write_commit_graph_context *ctx)
+{
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	jw_object_intmax(&jw, "hash_version", ctx->bloom_settings->hash_version);
+	jw_object_intmax(&jw, "num_hashes", ctx->bloom_settings->num_hashes);
+	jw_object_intmax(&jw, "bits_per_entry", ctx->bloom_settings->bits_per_entry);
+	jw_end(&jw);
+
+	trace2_data_json("bloom", ctx->r, "settings", &jw);
+
+	jw_release(&jw);
+}
+
 static void write_graph_chunk_bloom_data(struct hashfile *f,
 					 struct write_commit_graph_context *ctx)
 {
@@ -1115,6 +1132,8 @@ static void write_graph_chunk_bloom_data(struct hashfile *f,
 	struct progress *progress = NULL;
 	int i = 0;
 
+	trace2_bloom_filter_settings(ctx);
+
 	if (ctx->report_progress)
 		progress = start_delayed_progress(
 			_("Writing changed paths Bloom filters data"),
@@ -1545,7 +1564,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	struct object_id file_hash;
 	const struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
-	ctx->bloom_settings = &bloom_settings;
+	if (!ctx->bloom_settings)
+		ctx->bloom_settings = &bloom_settings;
 
 	if (ctx->split) {
 		struct strbuf tmp_file = STRBUF_INIT;
@@ -1970,9 +1990,23 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
 	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
 	ctx->split_opts = split_opts;
-	ctx->changed_paths = flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;
 	ctx->total_bloom_filter_data_size = 0;
 
+	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
+		ctx->changed_paths = 1;
+	if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
+		struct commit_graph *g;
+		prepare_commit_graph_one(ctx->r, ctx->odb);
+
+		g = ctx->r->objects->commit_graph;
+
+		/* We have changed-paths already. Keep them in the next graph */
+		if (g && g->chunk_bloom_data) {
+			ctx->changed_paths = 1;
+			ctx->bloom_settings = g->bloom_filter_settings;
+		}
+	}
+
 	if (ctx->split) {
 		struct commit_graph *g;
 		prepare_commit_graph(ctx->r);
diff --git a/commit-graph.h b/commit-graph.h
index f0fb13e3f2..45b1e5bca3 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -96,6 +96,7 @@ enum commit_graph_write_flags {
 	/* Make sure that each OID in the input is a valid commit OID. */
 	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
 	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4),
+	COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS = (1 << 5),
 };
 
 struct split_commit_graph_opts {
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index c7011f33e2..426de10041 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -126,7 +126,7 @@ test_expect_success 'setup - add commit-graph to the chain without Bloom filters
 	test_commit c14 A/anotherFile2 &&
 	test_commit c15 A/B/anotherFile2 &&
 	test_commit c16 A/B/C/anotherFile2 &&
-	GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0 git commit-graph write --reachable --split &&
+	git commit-graph write --reachable --split --no-changed-paths &&
 	test_line_count = 2 .git/objects/info/commit-graphs/commit-graph-chain
 '
 
@@ -152,4 +152,31 @@ test_expect_success 'Use Bloom filters if they exist in the latest but not all c
 	test_bloom_filters_used_when_some_filters_are_missing "-- A/B"
 '
 
+BASE_BDAT_OFFSET=2240
+BASE_K_BYTE_OFFSET=$((BASE_BDAT_OFFSET + 10))
+BASE_LEN_BYTE_OFFSET=$((BASE_BDAT_OFFSET + 14))
+
+corrupt_graph() {
+	pos=$1
+	data="${2:-\0}"
+	grepstr=$3
+	orig_size=$(wc -c < .git/objects/info/commit-graph) &&
+	zero_pos=${4:-${orig_size}} &&
+	printf "$data" | dd of=".git/objects/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
+	dd of=".git/objects/info/commit-graph" bs=1 seek="$zero_pos" if=/dev/null
+}
+
+test_expect_success 'persist filter settings' '
+	test_when_finished rm -rf .git/objects/info/commit-graph* &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" git commit-graph write --reachable --changed-paths &&
+	grep "{\"hash_version\":1,\"num_hashes\":7,\"bits_per_entry\":10}" trace2.txt &&
+	cp .git/objects/info/commit-graph commit-graph-before &&
+	corrupt_graph $BASE_K_BYTE_OFFSET "\09" &&
+	corrupt_graph $BASE_LEN_BYTE_OFFSET "\0F" &&
+	cp .git/objects/info/commit-graph commit-graph-after &&
+	test_commit c18 A/corrupt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" git commit-graph write --reachable --changed-paths &&
+	grep "{\"hash_version\":1,\"num_hashes\":57,\"bits_per_entry\":70}" trace2.txt
+'
+
 test_done
\ No newline at end of file
-- 
gitgitgadget

