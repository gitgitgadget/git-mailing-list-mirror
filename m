Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8710FCD8CB4
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjJJUeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343978AbjJJUeA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:34:00 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F07D7
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:48 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3ae2ec1a222so4283241b6e.2
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696970027; x=1697574827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w9ubiTD+WGpWF9zefVQgtwv/mgUKuh8XWcZTKgx5Q8A=;
        b=OVMSrjXTkzMOR0/PjiQf2JLVcn6n6TNnvsoY5OEbmlS/NsoAbx8c1VNj6+tTqOFaGS
         7xWjrPcyfzjxiK5wefkp8jApeXiTmYNa/95X0iLZ2WqrXXUhCrE2XyV0sOF0ctgRz9Ud
         FUE06GpEcKnD6twmentyrz+wQ8vq+uM4WSwa0mt7OgzjWaHNt75rQLo/CCwYmyLtpcwN
         QVEGAYE6W0/dekRC3Upf3KvnSEnxev9lTrgXFOsixM0hHf4vthb0Kwj4Ix6urAoAeKIn
         DXFv7NIXCX3+3LSU9Xbd7T6owao+/2KNWW/i6NF1aE97CV/0J+HAbIdPJK8v/kX3CuzT
         5syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970027; x=1697574827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9ubiTD+WGpWF9zefVQgtwv/mgUKuh8XWcZTKgx5Q8A=;
        b=dsqkDeeTkY7xUhY5qRHwP3yxz+n8sShHnN8AolTOFntEHKriWgNqTW7RMB55aaI9JZ
         hYwVEHaSkM618mpq8gVo5CWXcw7rtYaGhMbxx2f0rl9PxUvAmWm2xjm9hHE90rPnB0HE
         LEa/UUyNQs1mAVnsXumEc8wK7zvh02IUNw29vIm72ds6nZGPgONQoYxzWbuHP5N/PdTO
         MxCFK4lN1opkwlCpawKh0aWWOfFL8KsFSSNFH3V1QBcctQ6X++uV/p+HQ6fHeR2NNCxD
         qhMIfky2gKLZufOYEcnaTYf0IvpGSsvuLt8zqsASbjbsuyO4WvA1V6HBoY8K+AYN/4hM
         ENGQ==
X-Gm-Message-State: AOJu0Yy1DDWAbbszMAjrs1vF7SxmZ2A7JMyPufrjFngMGwSDody2R5Qx
        i/ou5gbuOtEjiDe6Iovwdf/L0zo4p8di2mIY8jZ2bw==
X-Google-Smtp-Source: AGHT+IGAQf7XNn9EhJEZcVbjF26BBbL4JTJX1VrQJMn655j5wkohHvTMWl2jxvJmq+3mf7hqfAanEw==
X-Received: by 2002:a05:6808:199f:b0:3a8:83df:d5a4 with SMTP id bj31-20020a056808199f00b003a883dfd5a4mr25446854oib.59.1696970027645;
        Tue, 10 Oct 2023 13:33:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j13-20020a0cf50d000000b0065b1f90ff8csm5135160qvm.40.2023.10.10.13.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:33:47 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:33:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 09/17] repo-settings: introduce
 commitgraph.changedPathsVersion
Message-ID: <a08a961f4170f58c34eec7d89b2e7979724f8a1d.1696969994.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696969994.git.me@ttaylorr.com>
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
index ae0902f7f4..ea677c87fb 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -411,7 +411,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
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
2.42.0.342.g8bb3a896ee

