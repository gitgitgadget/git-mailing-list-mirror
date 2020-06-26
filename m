Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EADC433E1
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F11A207E8
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mjr57eay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgFZMat (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgFZMao (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 08:30:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64EDC08C5DB
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:43 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 22so8678823wmg.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NPwgmjtGtVfhNaIMtMRTJuLX4Hhz/h7avtSR/My5caQ=;
        b=Mjr57eaykwHOaHrIqOJ+9pl5AQTxSKZTxz0IVV8uIRqsz6yDbvjLGDWSMrOKtP+TLg
         6n3gxhoPHYMpJFE/meZ8S4p4KeOnmVJ0QqwXsQbwjVtOF0U7HiTDZmVmn4JyRj5obDG9
         GoGk9IQRBPLw8GrYe2EiaVa3YsvL7hUdAcywg10pB6XYSHAwomjo9OJD7NSvBDya6iTM
         mtP0YuVFa06GXN7PWsNzAulX8ofc9XTXHb5ThRVdaJ+H/MByffiUH7iD9TrCTQ4vnzhR
         J3q/ns2RbExES/lOL8yZ1ZKjaeecAkrhTfJktLNmmSinc7lyLCJxXHv9oAGMck7OZqk3
         F8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NPwgmjtGtVfhNaIMtMRTJuLX4Hhz/h7avtSR/My5caQ=;
        b=J9LM9bkOtLqKhp5PWB3GvackUbRyrigHanThqhywj3iSnrbG5Oe1SKx07x+1BLsCjT
         s15JGl3Ckp91yALVK7dxwnjeYqz/qQVWyahiNF2jakddbmOFdwlptQ8ICxh/I6X4pU9r
         yDwymsHs0tYTAILA1oveaVsx/Z4Nmdjw+USH4+Sa+IYiUvzjlPiRW7qyqhuT+t3CHWDV
         w1WGGFK9e08Qw9M73sEcQx9ICKuCct0UDsZWSdNsY+BhLMM0jAf6J0wg7MBnQYKK68TJ
         x81qFYQk3jBt/7f0aBgJ++ZVE7y2tcvzHDH2FHFE4vzYKRqsSO78kVO5YMxAEyV8zY8b
         51Tw==
X-Gm-Message-State: AOAM533tHbWGkzftpScCfs5SdoIqdlpie1mMkF2QWTQMa8HSK4k+37sD
        mkCs2CP1ul39VNSa5k04cZqUB2M9
X-Google-Smtp-Source: ABdhPJwY29Byy3hN8KOT51aCOLkb5yRLpw+7vxmNvutsxzpflyb+vWsnoXHyuZcw6D8tvAbgc4RpBQ==
X-Received: by 2002:a1c:1946:: with SMTP id 67mr3405347wmz.59.1593174642088;
        Fri, 26 Jun 2020 05:30:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q188sm14463947wma.46.2020.06.26.05.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:30:41 -0700 (PDT)
Message-Id: <33e22d05cbf9d60e5f0164985d3481643220d8fa.1593174637.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
References: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
        <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Jun 2020 12:30:30 +0000
Subject: [PATCH v3 04/10] commit-graph: persist existence of changed-paths
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
 commit-graph.c                     | 45 ++++++++++++++++++++++++++++--
 commit-graph.h                     |  1 +
 t/t4216-log-bloom.sh               | 17 ++++++++++-
 5 files changed, 67 insertions(+), 6 deletions(-)

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
index 6a28d4a5a6..11088fc11f 100644
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
@@ -1543,9 +1562,15 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	int num_chunks = 3;
 	uint64_t chunk_offset;
 	struct object_id file_hash;
-	const struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
+	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
-	ctx->bloom_settings = &bloom_settings;
+	if (!ctx->bloom_settings) {
+		bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
+							      bloom_settings.bits_per_entry);
+		bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
+							  bloom_settings.num_hashes);
+		ctx->bloom_settings = &bloom_settings;
+	}
 
 	if (ctx->split) {
 		struct strbuf tmp_file = STRBUF_INIT;
@@ -1970,9 +1995,23 @@ int write_commit_graph(struct object_directory *odb,
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
index c7011f33e2..73ed51b595 100755
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
 
@@ -152,4 +152,19 @@ test_expect_success 'Use Bloom filters if they exist in the latest but not all c
 	test_bloom_filters_used_when_some_filters_are_missing "-- A/B"
 '
 
+test_expect_success 'persist filter settings' '
+	test_when_finished rm -rf .git/objects/info/commit-graph* &&
+	rm -rf .git/objects/info/commit-graph* &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+		GIT_TRACE2_EVENT_NESTING=5 \
+		GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=9 \
+		GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY=15 \
+		git commit-graph write --reachable --changed-paths &&
+	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15}" trace2.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2-auto.txt" \
+		GIT_TRACE2_EVENT_NESTING=5 \
+		git commit-graph write --reachable --changed-paths &&
+	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15}" trace2-auto.txt
+'
+
 test_done
\ No newline at end of file
-- 
gitgitgadget

