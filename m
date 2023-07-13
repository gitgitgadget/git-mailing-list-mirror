Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCDAC001DF
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 21:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbjGMVnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 17:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbjGMVnA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 17:43:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E9D30E8
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 14:42:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57059e6f9c7so17510587b3.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 14:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689284540; x=1691876540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ak48/ijFj0jw5zdBPImoI74xXDRoo4vJT+6IP9zYTg=;
        b=DxMk4G1kbQLp4035g+Dlf52S9ewj1sgGX2DnvZrNuhYLHpjCu+GgGRPHwxxjIGCq0o
         lOzXirezkOA/03LgXrjF8BXPcUxt0+gcslTRG5No2Jf760mTPx8U5zSIm3OwR1j4j+Hm
         CLWeH+gd2kMNvFCzLQ4QmsMyz4nN9TVy989GyMZFEtUR6WUba7H95Tm7cRwweDaDtI3w
         J4jAZi7NEhcGrtyPNG2EQ5paySpeqT9K+jMy2dMRw4nhZ6SIfggqZseCpZshfybx/aDu
         rQ8UP0jgHXCP3nVbUXvlOM+kmMDRfrQ+SIoU4g9NttsEnyTU8b9rIFFI0Jp43VmMoA40
         AQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689284540; x=1691876540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ak48/ijFj0jw5zdBPImoI74xXDRoo4vJT+6IP9zYTg=;
        b=LiS7riLwMTfrhCTexFaLf1Pc9hEfyafj3sQMTvnQJbO/EZsINhmlvvbJ6dAKbVtlyb
         RKCvW5PPeElmqZPDmyCt/By8EoPZXM9Xt9kFiDYzwAGhJdhXX09u5uHVPMiOc036n+aR
         kiULCtth8lJtavYVVHkqxI9PhGa/ad2xC7N6WV+caz/3CC9qU4eOM+I1wOmcJUWX2gt2
         0hdKbg8F1L9wIx6HM//U77pkybriEvQYbx6CjduKGYRMCDcqnHCMZSV81naqCDYgwwk5
         lc2hj1BcHK24R5mJoN0GNBYvUAKGd3nSVgslyLazWBSFirYzckCYDGtbxY+BU+A8/vif
         vjEw==
X-Gm-Message-State: ABy/qLaGSRgNCMxtegyQgTVwoeM2EPBnP1TQqkpiA24lbmI6tf83QInY
        vSXbFp6ujE/gR3fFZRWwEFxxk41mBgqzE7MXps5/NAAZtzubisWAOWwxO5VV60iTOlRhHPG3U6E
        051biH+GHCnqs9z0gc9kBb2FHf9cZkMn/+jDfj7wRjIPhWEPdGv4YHa3//88Vv3BlQ1CvkpP2+S
        xS
X-Google-Smtp-Source: APBJJlGNB+5qRgxZJubVyhrLEVnUd7ueAfme1hyG34CxZDxGjpg1cSbMezj/5hazL13hFovxdnqUQ9b+kBxSbDZhlNgS
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:8bde:aac2:2aa0:da1a])
 (user=jonathantanmy job=sendgmr) by 2002:a81:c606:0:b0:56c:f903:8678 with
 SMTP id l6-20020a81c606000000b0056cf9038678mr12646ywi.2.1689284540176; Thu,
 13 Jul 2023 14:42:20 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:42:10 -0700
In-Reply-To: <cover.1689283789.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1689283789.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <131095666d414ff68416526112c8f8deb31ac9e1.1689283789.git.jonathantanmy@google.com>
Subject: [PATCH v5 3/4] repo-settings: introduce commitgraph.changedPathsVersion
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent commit will introduce another version of the changed-path
filter in the commit graph file. In order to control which version to
write (and read), a config variable is needed.

Therefore, introduce this config variable. For forwards compatibility,
teach Git to not read commit graphs when the config variable
is set to an unsupported version. Because we teach Git this,
commitgraph.readChangedPaths is now redundant, so deprecate it and
define its behavior in terms of the config variable we introduce.

This commit does not change the behavior of writing (Git writes changed
path filters when explicitly instructed regardless of any config
variable), but a subsequent commit will restrict Git such that it will
only write when commitgraph.changedPathsVersion is a recognized value.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/commitgraph.txt | 19 ++++++++++++++++---
 commit-graph.c                       |  2 +-
 oss-fuzz/fuzz-commit-graph.c         |  2 +-
 repo-settings.c                      |  6 +++++-
 repository.h                         |  2 +-
 5 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
index 30604e4a4c..07f3799e05 100644
--- a/Documentation/config/commitgraph.txt
+++ b/Documentation/config/commitgraph.txt
@@ -9,6 +9,19 @@ commitGraph.maxNewFilters::
 	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
 
 commitGraph.readChangedPaths::
-	If true, then git will use the changed-path Bloom filters in the
-	commit-graph file (if it exists, and they are present). Defaults to
-	true. See linkgit:git-commit-graph[1] for more information.
+	Deprecated. Equivalent to changedPathsVersion=-1 if true, and
+	changedPathsVersion=0 if false.
+
+commitGraph.changedPathsVersion::
+	Specifies the version of the changed-path Bloom filters that Git will read and
+	write. May be -1, 0 or 1. Any changed-path Bloom filters on disk that do not
+	match the version set in this config variable will be ignored.
++
+Defaults to -1.
++
+If -1, Git will use the version of the changed-path Bloom filters in the
+repository, defaulting to 1 if there are none.
++
+If 0, git will write version 1 Bloom filters when instructed to write.
++
+See linkgit:git-commit-graph[1] for more information.
diff --git a/commit-graph.c b/commit-graph.c
index c11b59f28b..9b72319450 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -399,7 +399,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 			graph->read_generation_data = 1;
 	}
 
-	if (s->commit_graph_read_changed_paths) {
+	if (s->commit_graph_changed_paths_version != 0) {
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
index 3dbd3f0e2e..e3b6565ffc 100644
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
+		     readChangedPaths ? -1 : 0);
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
2.41.0.255.g8b1d071c50-goog

