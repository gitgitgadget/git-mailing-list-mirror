Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76447EE4996
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjHUVoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjHUVoS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:44:18 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96E1132
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:14 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58df8cab1f2so42574977b3.3
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692654254; x=1693259054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9coSinmdfSKWrEGXwxhlRm8qq0mw3reh9gVyDvDbsd0=;
        b=X89HXgslLx1oetRwF3X8n485dveMwVGxvVibE5b+4zPujMGWO9Omf7OUF7yWv1W9hp
         MxI5dJeIEM9/ePKisfXPhDg+cJeL6AHxhX4dO+AnI/2GZiF0ZH1rcwLgvABVWH9eemkB
         yqtVRxtE56uWsLe0PkqOW9fPYqOpspUEnHtJfDF5MniVpcHQhmb39UfbR9wcvlnfrgRf
         9r8DK8XiSLlQTzOONq8IYULrSn4O2hg9r7d7wDPWvXn1CKZjn9cohCC8EQjycdV+1eA0
         eqUIBEZcsTdeCG13Zd1SG5PR50Uk/ulFIFDxdXeB4G6KlX5WWf+sFvmY9ssdAjxtkPZ5
         mqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692654254; x=1693259054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9coSinmdfSKWrEGXwxhlRm8qq0mw3reh9gVyDvDbsd0=;
        b=I7b/Q7AHn4JihEwfVRq4ZfKycVHl3BDv4U2kn7ldd+DeTSjrMTuhcJRBNFladPwwiW
         zkHUnEVWIctPVqC5Z2j54cxAvvAyJlhit8yb/OG/XVBWV5B+PVA8MxQK+YiKay1cLZL5
         66Bw8uQctlsif8R8tvYxWlU09kbi/J8n+KxKRQFMMRW3LrSN3K0kWitAfY3ctLGtTV7E
         m9m8lnAILnvE2kPAcPy6CB2+eB4vOs3mTez0L4VpNEkZDFfkyqvWHrokBXMvqlQDRNzj
         XViuZZSDG7xKekpbGrKRR2/O4xUfsvoMLV5bUpp5/IYL4hLLRLUPBg0thtV5CF0pxtdQ
         znEQ==
X-Gm-Message-State: AOJu0YzDH5LQETsYcFLzMD9PgI4tP0sbaqF/+kccJFDKBWrvrIb41r5X
        gRc6usUAREalDJOn8YVSpITomQdbl4KkbBvhtGRDGg==
X-Google-Smtp-Source: AGHT+IEc++oaGr7PkutGADdzPpvnmyIVIgY8toK5P59ZGbUO0DO6M0FmR+pMN0bn4QvLMJgBo+CajA==
X-Received: by 2002:a0d:ccc9:0:b0:576:7dfc:e73e with SMTP id o192-20020a0dccc9000000b005767dfce73emr8643333ywd.32.1692654253956;
        Mon, 21 Aug 2023 14:44:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u193-20020a8184ca000000b0058419c57c66sm2429057ywf.4.2023.08.21.14.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:44:13 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:44:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 06/15] repo-settings: introduce
 commitgraph.changedPathsVersion
Message-ID: <ef5b54c53404fe5a02424e795d5722f2cf3f8ae8.1692654233.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692654233.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

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
Signed-off-by: Taylor Blau <me@ttaylorr.com>
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
index 0aa1640d15..da99f15fdf 100644
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
2.42.0.4.g52b49bb434

