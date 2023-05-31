Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D109C7EE29
	for <git@archiver.kernel.org>; Wed, 31 May 2023 23:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjEaXMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 19:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjEaXMt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 19:12:49 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86402134
        for <git@vger.kernel.org>; Wed, 31 May 2023 16:12:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565d1b86a63so2664257b3.0
        for <git@vger.kernel.org>; Wed, 31 May 2023 16:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685574765; x=1688166765;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZxUFq+XFpm6iER00Cpqd1NymxfgQWsham2KB2kIWao=;
        b=hkOZKkpi7lCyOLs1BPmAW+/YuXCjIkb8KDb/Z/tAkwf7LV9olrwV0aiWvl7kYCmQen
         1YrEJ2PLTl7Q14xkNOEszB7H2rRkyDxZP3P6T4ADSqtn+OctvRQDCEVs9HItDRHwiERl
         0VfY4oITrd5uF69pfszL9deZl8tdAiW6HF5qJvoPWXOmyQHTSdXgkClZqyYfot6/sW/g
         pjkFNQg2yJQXsNDk44ypWwL2vz49TYXjtxE1wKrnIqgKkC6YbBg8ysAultILNE0YfQcc
         jS/7s9mCcIeCBqqOJvTNPWsaoQ2F7EoYeyi1+aQMr6DXhcCmBx5wn3GlscCJ8iKkFvlf
         3qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685574766; x=1688166766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZxUFq+XFpm6iER00Cpqd1NymxfgQWsham2KB2kIWao=;
        b=TI4t64FNEKICm42cEQJfD4fYnRRM7FaAbdpBFRwyZlExn3zbziv9YShOoc/0t0dCKt
         brchUJRCqRz2ECEOu1ipFx2h6/CZh12+Khx3mKiKWFcoBkfeCVILnXdGpyBBjC7g13qg
         ya7U8/B+vMi6/rrNPZ0NuqrRCmbrPQUczhoyKJ8iH5qjikH4rzGWlXUTnekUgSftmgAK
         Yk8zU7eC2Azirre4HeD+fgsx2pXxKCBXhTLrcN3n230RRinYerfe6YACXYA4Z2f20owJ
         jLrW9aS+XPh83LylFoX7UXpk4NEaVAxV9f+7HFUP5MkYiue8Z72OHzK6qseZyYBbWCWf
         ylQw==
X-Gm-Message-State: AC+VfDw3Gq/jbhJvE0do8cSgZgILSE+ZELqdYZiVR7TanXWCHZ0hDrsh
        ERlHdhp+m7G+FsvOXdfQPOLCwESi9doyDMScKLs67H76myz/NIKNcjSUP9OPTj2AC5XXsUMQC3F
        hLHYWaQn3JqaCVoLwusrJO9eW2L+R4zc3IVgFKbJNpSuxeTV4Tsrhvm8m/giW/7mR89pKw1YpJu
        I0
X-Google-Smtp-Source: ACHHUZ5teGAoAJp5nu0HKNC2KBUmf/LoeSWM4OfVdho28J7rHex22yGYglNBXgadp5pKNntLxyvndZvKzDXyDFxPNQov
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:2ee:ade5:9636:9867])
 (user=jonathantanmy job=sendgmr) by 2002:a25:bb0c:0:b0:b8f:6b84:33cb with
 SMTP id z12-20020a25bb0c000000b00b8f6b8433cbmr3057577ybg.11.1685574765752;
 Wed, 31 May 2023 16:12:45 -0700 (PDT)
Date:   Wed, 31 May 2023 16:12:36 -0700
In-Reply-To: <cover.1685574402.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1685574402.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <4a7553f3fb69b91c80535632c80181b51fd2d015.1685574402.git.jonathantanmy@google.com>
Subject: [PATCH v2 2/3] repo-settings: introduce commitgraph.changedPathsVersion
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
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
2.41.0.rc0.172.g3f132b7071-goog

