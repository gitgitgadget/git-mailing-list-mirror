Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA1CEB64DD
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 21:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjGTVrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 17:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjGTVq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 17:46:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FFE1719
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:46:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-cffb72c1d6dso634148276.0
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689889614; x=1690494414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WoIRJJyGDBoS2zbhHabT1V+pq34N855HUZoC1vDBNg=;
        b=iEAVwN6ja90XCi2AyJ8GYdCSuAdAKIA3WoQ3G+euRYJ8oeACRcxa4DXp9uWUxhaVc9
         yTAJVwjCq+lWO9ng58yxvZWff31F5BW3iE8nAbE1d3KiCRQZOm/lHkcz4ts+Pt55QPPm
         dISXitByJHPESjBOamXKtSrq15mSBEA1FQXTaaZ9VB1CwD1W6kuyLVrT5gID5Ixbu/So
         fO31QdBRK7Mc5tSlo1tzYa/HNEmp5nH4zYURybVs/eAO/eWPtvx/LA6pubAlJ1hYytzJ
         QPtjSMO08H3sHttBU8qJ68kRZjLvloubVUhxKE7JhrBX68YfhJYuKMloDu98fbej6Onc
         dTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689889614; x=1690494414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WoIRJJyGDBoS2zbhHabT1V+pq34N855HUZoC1vDBNg=;
        b=f+oeRVeuDNhNiQBcpykvGVEqdjCePQCUG0CPiigOObI/ArlRhWW1bjHmCfk3zZzZNP
         e+OheqXAEH9Jm0wohtH3w2t7/9KjLqvS0E5oivT0YthLG0nG12tWo3NU8jgRWWc79Zje
         yaDJGLXCqsX/RFmrLo1sgZ/gTHd29k46N8s/+g6ovuVVfxPhEDO1ilstEqN0BSGluCua
         w05eCHtaLtM9BepLu9rQrz5hIu1cREkp6FFYAyi+6RB6bP/vnYkd4BSz4DrpyBI1/Ti+
         F7vJge8RtkrKv6JEc2VoXTy/ibMgA2cxxZ1I1oA32JRq7RvIIzPqVelXtB5L413LDrmv
         X+5Q==
X-Gm-Message-State: ABy/qLY8xCHZtdMYh/exbQ/ABJ0A7Kygbz39t4alqZKFgZXWVEtxnWw3
        BW8SrV+KaMKne8yEavzcvZ0E5zXas9mCuysZhLJdJB1uNI7uSK4D1ZGivdOYkPf0G2ziMrAUuqc
        Mt3mEqS0xsHsgtTTn+gOA11iSkyvCtEV+UgusbOfm1b0krZkqLoZLEAXfL5I6IlxQlvmWpJdcXK
        HC
X-Google-Smtp-Source: APBJJlFloklUbDdYdoL1MqamJnDpGcccmNV7y/V+M2LVmcDCKJaTza2ihFViDGADztop55BdwLT20ggancp3OAe0VdX5
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:387b:f15b:5fda:c8a5])
 (user=jonathantanmy job=sendgmr) by 2002:a25:d8a:0:b0:cf4:7cc7:14f7 with SMTP
 id 132-20020a250d8a000000b00cf47cc714f7mr1463ybn.11.1689889614430; Thu, 20
 Jul 2023 14:46:54 -0700 (PDT)
Date:   Thu, 20 Jul 2023 14:46:39 -0700
In-Reply-To: <cover.1689889382.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1689889382.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <dc3f6d2d4fc5b785f86a2cfe14269c5847afad92.1689889382.git.jonathantanmy@google.com>
Subject: [PATCH v6 6/7] repo-settings: introduce commitgraph.changedPathsVersion
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
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
 Documentation/config/commitgraph.txt | 23 ++++++++++++++++++++---
 commit-graph.c                       |  2 +-
 oss-fuzz/fuzz-commit-graph.c         |  2 +-
 repo-settings.c                      |  6 +++++-
 repository.h                         |  2 +-
 5 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
index 30604e4a4c..2dc9170622 100644
--- a/Documentation/config/commitgraph.txt
+++ b/Documentation/config/commitgraph.txt
@@ -9,6 +9,23 @@ commitGraph.maxNewFilters::
 	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
 
 commitGraph.readChangedPaths::
-	If true, then git will use the changed-path Bloom filters in the
-	commit-graph file (if it exists, and they are present). Defaults to
-	true. See linkgit:git-commit-graph[1] for more information.
+	Deprecated. Equivalent to commitGraph.changedPathsVersion=-1 if true, and
+	commitGraph.changedPathsVersion=0 if false. (If commitGraph.changedPathVersion
+	is also set, commitGraph.changedPathsVersion takes precedence.)
+
+commitGraph.changedPathsVersion::
+	Specifies the version of the changed-path Bloom filters that Git will read and
+	write. May be -1, 0 or 1.
++
+Defaults to -1.
++
+If -1, Git will use the version of the changed-path Bloom filters in the
+repository, defaulting to 1 if there are none.
++
+If 0, Git will not read any Bloom filters, and will write version 1 Bloom
+filters when instructed to write.
++
+If 1, Git will only read version 1 Bloom filters, and will write version 1
+Bloom filters.
++
+See linkgit:git-commit-graph[1] for more information.
diff --git a/commit-graph.c b/commit-graph.c
index efc697e437..1f26c07de4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -401,7 +401,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 			graph->read_generation_data = 1;
 	}
 
-	if (s->commit_graph_read_changed_paths) {
+	if (s->commit_graph_changed_paths_version) {
 		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   &graph->chunk_bloom_indexes);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index 2992079dd9..325c0b991a 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -19,7 +19,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	 * possible.
 	 */
 	the_repository->settings.commit_graph_generation_version = 2;
-	the_repository->settings.commit_graph_read_changed_paths = 1;
+	the_repository->settings.commit_graph_changed_paths_version = 1;
 	g = parse_commit_graph(&the_repository->settings, (void *)data, size);
 	repo_clear(the_repository);
 	free_commit_graph(g);
diff --git a/repo-settings.c b/repo-settings.c
index 525f69c0c7..db8fe817f3 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -24,6 +24,7 @@ void prepare_repo_settings(struct repository *r)
 	int value;
 	const char *strval;
 	int manyfiles;
+	int read_changed_paths;
 
 	if (!r->gitdir)
 		BUG("Cannot add settings for uninitialized repository");
@@ -54,7 +55,10 @@ void prepare_repo_settings(struct repository *r)
 	/* Commit graph config or default, does not cascade (simple) */
 	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
 	repo_cfg_int(r, "commitgraph.generationversion", &r->settings.commit_graph_generation_version, 2);
-	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
+	repo_cfg_bool(r, "commitgraph.readchangedpaths", &read_changed_paths, 1);
+	repo_cfg_int(r, "commitgraph.changedpathsversion",
+		     &r->settings.commit_graph_changed_paths_version,
+		     read_changed_paths ? -1 : 0);
 	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
 	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
 
diff --git a/repository.h b/repository.h
index 5f18486f64..f71154e12c 100644
--- a/repository.h
+++ b/repository.h
@@ -29,7 +29,7 @@ struct repo_settings {
 
 	int core_commit_graph;
 	int commit_graph_generation_version;
-	int commit_graph_read_changed_paths;
+	int commit_graph_changed_paths_version;
 	int gc_write_commit_graph;
 	int fetch_write_commit_graph;
 	int command_requires_full_index;
-- 
2.41.0.487.g6d72f3e995-goog

