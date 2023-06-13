Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27855EB64D7
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 17:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbjFMRk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 13:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240185AbjFMRkR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 13:40:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B49AC9
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 10:40:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5692be06cb2so83503507b3.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 10:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686678014; x=1689270014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4kUJW+8FaqLzgttrJyg1cSLzKp0rVov2HBJYZBKRSbA=;
        b=6q8h/LgLKh5UWZurdRJbprexDECsPsmBkXeMO8FRnbVUcfrz9m1G7Az1H5DoXqfN40
         0OCIuI1c9LXXhiecbSxbhA9z0yq6Jpe4UblAm5Zw2DJfDdump7UAupwYQrQ19O6mDca6
         KqRnXcqcopoHRwPsw7OLUIExC2rmGMND7e6mPdap5xGf/xpeHO11HuarDk5M6BQcnkvY
         sGKMsqSNp7znMCbMYPNNOHTd658UnZErktpdvvQczAvBPZNGQWNZLMlAt8K2+Q+Ezwyg
         KlHSrVyii0d+wk7yisQMA2kX5zFWv/y2Tp3AGFe7Rexm7UqWJiXQL6bICzG7n0fNYwCw
         9fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686678014; x=1689270014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kUJW+8FaqLzgttrJyg1cSLzKp0rVov2HBJYZBKRSbA=;
        b=gPfAspxfzkSiaNXRLw8PN2Pk9A4Ex1Je9PJoRhU6SYBrIkTcpEQT1To1EsJzU/vTVI
         b7SIEa3h8kqOqov52d2I28mwIi1o9dCMMMPvu3hBxQ2gDItv8/1F4wboyLGiahqtCXMe
         by2xR3nln+f1oyQidf60FvUCvLVSpK38WGYp+XAoBXmzryhX+iSBJCqu8pP/cxUzBadv
         vA1pxAoM3VHJUSjMNGIkhvOEaus9hs23rNVKGGJOQR/B3ajFPS237RpjA59LWtzwigS6
         l7Y5Z0iUMqMAGjy/XwGwxAAXn02ksndzzCfPO8nu1sQbLcc0W6K5ny98NQUbMO7OnNbo
         t3Wg==
X-Gm-Message-State: AC+VfDwxDXsZ3n89rqL3U+FqqkCOlKhWwXs2HPzFFQljm5qgdLUq42/r
        oMQGd4NNfhYKBdzYiBdn7tQ9V7L5o4YUKhMBijMedI1GPE9lEDB2TQa/htCFlAmJhin0Gk8eyL4
        stZZhQmFPmm6XAeSwOtR5Or9U6x1anUvhEihU8RUhNRVsblATvbI/ADaWiW47rIEzCha6ce/Ek+
        00
X-Google-Smtp-Source: ACHHUZ6i8zSv5F24jm/JOCHglnrwYTbNWzjnG9x+CIingp+a3v9lGE/fC9jhGwrAx9EjApN9h9JpPOwXLJDgIqngryVR
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:5e39:4d58:c992:1db0])
 (user=jonathantanmy job=sendgmr) by 2002:a81:a8c6:0:b0:56d:21a1:16a1 with
 SMTP id f189-20020a81a8c6000000b0056d21a116a1mr1068592ywh.5.1686678014434;
 Tue, 13 Jun 2023 10:40:14 -0700 (PDT)
Date:   Tue, 13 Jun 2023 10:39:57 -0700
In-Reply-To: <cover.1686677910.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1686677910.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <6adfa53dafc8c34f94a017fdc08460911f53d310.1686677910.git.jonathantanmy@google.com>
Subject: [PATCH v4 3/4] repo-settings: introduce commitgraph.changedPathsVersion
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent commit will introduce another version of the changed-path
filter in the commit graph file. In order to control which version is
to be accepted when read (and which version to write), a config variable
is needed.

Therefore, introduce this config variable. For forwards compatibility,
teach Git to not read commit graphs when the config variable
is set to an unsupported version. Because we teach Git this,
commitgraph.readChangedPaths is now redundant, so deprecate it and
define its behavior in terms of the config variable we introduce.

This commit does not change the behavior of writing (Git writes changed
path filters when explicitly instructed regardless of any config
variable), but a subsequent commit will restrict Git such that it will
only write when commitgraph.changedPathsVersion is 0, 1, or 2.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/commitgraph.txt | 16 +++++++++++++---
 commit-graph.c                       |  2 +-
 oss-fuzz/fuzz-commit-graph.c         |  2 +-
 repo-settings.c                      |  6 +++++-
 repository.h                         |  2 +-
 5 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
index 30604e4a4c..eaa10bf232 100644
--- a/Documentation/config/commitgraph.txt
+++ b/Documentation/config/commitgraph.txt
@@ -9,6 +9,16 @@ commitGraph.maxNewFilters::
 	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
 
 commitGraph.readChangedPaths::
-	If true, then git will use the changed-path Bloom filters in the
-	commit-graph file (if it exists, and they are present). Defaults to
-	true. See linkgit:git-commit-graph[1] for more information.
+	Deprecated. Equivalent to changedPathsVersion=1 if true, and
+	changedPathsVersion=0 if false.
+
+commitGraph.changedPathsVersion::
+	Specifies the version of the changed-path Bloom filters that Git will read and
+	write. May be 0 or 1. Any changed-path Bloom filters on disk that do not
+	match the version set in this config variable will be ignored.
++
+Defaults to 1.
++
+If 0, git will write version 1 Bloom filters when instructed to write.
++
+See linkgit:git-commit-graph[1] for more information.
diff --git a/commit-graph.c b/commit-graph.c
index c11b59f28b..bd448047f1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -399,7 +399,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 			graph->read_generation_data = 1;
 	}
 
-	if (s->commit_graph_read_changed_paths) {
+	if (s->commit_graph_changed_paths_version == 1) {
 		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   &graph->chunk_bloom_indexes);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index 914026f5d8..b56731f51a 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -18,7 +18,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	 * possible.
 	 */
 	the_repository->settings.commit_graph_generation_version = 2;
-	the_repository->settings.commit_graph_read_changed_paths = 1;
+	the_repository->settings.commit_graph_changed_paths_version = 1;
 	g = parse_commit_graph(&the_repository->settings, (void *)data, size);
 	repo_clear(the_repository);
 	free_commit_graph(g);
diff --git a/repo-settings.c b/repo-settings.c
index 3dbd3f0e2e..6cbe02681b 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -24,6 +24,7 @@ void prepare_repo_settings(struct repository *r)
 	int value;
 	const char *strval;
 	int manyfiles;
+	int readChangedPaths;
 
 	if (!r->gitdir)
 		BUG("Cannot add settings for uninitialized repository");
@@ -54,7 +55,10 @@ void prepare_repo_settings(struct repository *r)
 	/* Commit graph config or default, does not cascade (simple) */
 	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
 	repo_cfg_int(r, "commitgraph.generationversion", &r->settings.commit_graph_generation_version, 2);
-	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
+	repo_cfg_bool(r, "commitgraph.readchangedpaths", &readChangedPaths, 1);
+	repo_cfg_int(r, "commitgraph.changedpathsversion",
+		     &r->settings.commit_graph_changed_paths_version,
+		     readChangedPaths ? 1 : 0);
 	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
 	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
 
diff --git a/repository.h b/repository.h
index e8c67ffe16..1f1c32a6dd 100644
--- a/repository.h
+++ b/repository.h
@@ -32,7 +32,7 @@ struct repo_settings {
 
 	int core_commit_graph;
 	int commit_graph_generation_version;
-	int commit_graph_read_changed_paths;
+	int commit_graph_changed_paths_version;
 	int gc_write_commit_graph;
 	int gc_cruft_packs;
 	int fetch_write_commit_graph;
-- 
2.41.0.162.gfafddb0af9-goog

