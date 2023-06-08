Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABB1C7EE2E
	for <git@archiver.kernel.org>; Thu,  8 Jun 2023 19:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbjFHTWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbjFHTWO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 15:22:14 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1E030E5
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 12:21:37 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b0371a51cfso396035ad.0
        for <git@vger.kernel.org>; Thu, 08 Jun 2023 12:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686252096; x=1688844096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4kUJW+8FaqLzgttrJyg1cSLzKp0rVov2HBJYZBKRSbA=;
        b=4xeG5w7/Pgs/A8RWUATkxYSve+1IxTtis4ftv6sblfDDA6EV+CxcnOFZUx1537kRb+
         NJmF8S9kOa8F6L64hVWmKIgMCBjboj0Hcdj4WmalMJI7pN9qpLSBPQgtozIqXZCR/Do2
         TUaT7YkP1T5CTnhoYoguiiD8Rmad5Si1AmwvhaPN0BK3/zVvVX/ciUc0Yv+oXvFdMWMQ
         K9D00TudBB8uWSfNrs2gUBFOtM4+Kuh91BrO9MbYSr3kER+F0J4Ziv5+z8nIScAf2mqC
         JpFyU/56L62yaO7Tl4iO3gmzWEhnng20QeJkynqm1fWNjQrcZ8vN27ywMEPo0JSha+Da
         YxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686252096; x=1688844096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kUJW+8FaqLzgttrJyg1cSLzKp0rVov2HBJYZBKRSbA=;
        b=aw46pkHBNfHNi6keihjEbrowf5rIlRQ2AylMCNsBKVFLQUd1z4dNPYKQ/ImuEKMQH5
         enYp3+gBYc8PLkvWIKlrXCeCJXNEXdmGciSnfY58wsG11HCMC65+AtTG5w/WP78KozH8
         FXnd2Nv9QR7QgxY8WKAmiaxaou4jS8WBnRqBRCX7ehjYAuCs7eA4Z7LxacpoNx/M2fsT
         QFFPAwCwDSNo0vz/R5z3p2PkmCVHtVb0Wcj6Z3yans3ggiXnpI0Lj7gna+BXCjbKplRA
         PR+CDA4logc56Po4Dy+HIlHKrxq9xft0Fd3xNfhj7r+dk3Ath7+YdfbfHHnKAnhfB3CB
         c2IQ==
X-Gm-Message-State: AC+VfDwwfPtgo3w1ksYeYeWyki7e/KJ2ibxygoaqXmW7FmuW1Up5vaTu
        gRTcpwzGEJXBpCKeUdQf4a1owRJLC0Kl4sFAqIusOe6BkgQbxpNbnF10IPkF5aA8/BGk/99A3ei
        9/JBfYR+oJ3qER6eFYMlHH2Pv+jurcEB9CMInoi5+9uq1AzqozQ/qHtaEcribFgrlm3EQb9WHgs
        1T
X-Google-Smtp-Source: ACHHUZ71gS9sa458l+jyEAcHLhgtgepOtP0gPpMLd4I9vy9mhvnvVUfJLY3Fp+K08sGCH7ooxWvjuEiBMZpu2S9dXOqx
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:bde7:a867:45f9:3528])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:ced0:b0:1b0:50db:1887 with
 SMTP id d16-20020a170902ced000b001b050db1887mr3000539plg.7.1686252095737;
 Thu, 08 Jun 2023 12:21:35 -0700 (PDT)
Date:   Thu,  8 Jun 2023 12:21:24 -0700
In-Reply-To: <cover.1686251688.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1686251688.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <d6982268a427de9d2e56f4a4dcdd200ea5adcdcc.1686251688.git.jonathantanmy@google.com>
Subject: [PATCH v3 3/4] repo-settings: introduce commitgraph.changedPathsVersion
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
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

