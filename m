Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D85BC433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF1022078E
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MVworPmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgICWqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729579AbgICWqX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 18:46:23 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552A7C061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 15:46:23 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g3so3240528qtq.10
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 15:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cqzwbwviXpVDnWui0q21WP1AZ9olbeMJ0rHHylfp8TQ=;
        b=MVworPmcxc2Cnf602/1t1HaCkfbaEawgiARYNb70UvOZnvXbqetLJ59ifZcusyy70i
         ucpA1ump4kyR7VEWghzN7KCTa+qQ8B4AD8SWtDD6PRny8yYIBSLl8xiod6TZGN4guesA
         M/Fm1uyi8/9X9umiuII567I0p0i+qYh+xoNYVmWc1HVXyTU7Em5H+Jxl2ftDWcSi21zC
         96s3NaS7RTK/cIqpXkmg4BdJvNsmpcKn6WLSDJ9znQ2/hHUwsWtfX7ISToJ25hfH2FkA
         3hfJMLtId+j/yi2GZi1dxIko9hnngSzhNK7Myz8BYq2V9CvVuTXbAysEozoMXP1b2T+0
         Llaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cqzwbwviXpVDnWui0q21WP1AZ9olbeMJ0rHHylfp8TQ=;
        b=XtcuZmrRl+37FXKKaYjL5NWANbsh5+IFP+zm/Q0NEQC2FssKOENe04faJVvSTOnLCr
         9Qm/oG3APK7CJx4YfWj0t5eA6OubKEgbwZVEyrjsLwqg0SpR4pO1/0Dj51SvhhAIutxd
         GsVau7DfVlvqKT6u15xXDndvwZWBGTbj0+eY4GNz/p1tNR8CWwXTdIHSNfnSFFmbLIPz
         hEbKeL5t63xccXmYhswhetAv7hIL2CEuC9BQ9a2dFRzS6VblogDKSSxJWz3IYaZMc/fM
         YqaQwVmXoN+QAJdEh58j1LDf3HczBNyY2ZxbLUy+nMN+syUeMUSoCKdUigNHWw+EwmKk
         3Ahg==
X-Gm-Message-State: AOAM532PbnZT2t3A9LqJpxI4gSOk8hKBT/bd5h9rgY7ZjMiKuQJFj2O8
        z+c9wA0laR1IdMvqBeNx24RR++efKDkV9sDG
X-Google-Smtp-Source: ABdhPJz5ewqh9izcNHBNyk/ea5Hq8RagxO8r3q3j84OfhkfJ+J1jUMAZnQCjT1fBOs5jZlop43KuXg==
X-Received: by 2002:ac8:2612:: with SMTP id u18mr6101042qtu.363.1599173182252;
        Thu, 03 Sep 2020 15:46:22 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a97c:6dae:76a4:c715])
        by smtp.gmail.com with ESMTPSA id c13sm3162897qtq.5.2020.09.03.15.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:46:21 -0700 (PDT)
Date:   Thu, 3 Sep 2020 18:46:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v4 05/14] commit-graph: respect 'commitGraph.readChangedPaths'
Message-ID: <8aff54d83e26953476da7ca9a1676bd945c00aa2.1599172908.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1599172907.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1599172907.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git uses the 'core.commitGraph' configuration value to control whether
or not the commit graph is used when parsing commits or performing a
traversal.

Now that commit-graphs can also contain a section for changed-path Bloom
filters, administrators that already have commit-graphs may find it
convenient to use those graphs without relying on their changed-path
Bloom filters. This can happen, for example, during a staged roll-out,
or in the event of an incident.

Introduce 'commitGraph.readChangedPaths' to control whether or not Bloom
filters are read. Note that this configuration is independent from both:

  - 'core.commitGraph', to allow flexibility in using all parts of a
    commit-graph _except_ for its Bloom filters.

  - The '--changed-paths' option for 'git commit-graph write', to allow
    reading and writing Bloom filters to be controlled independently.

When the variable is set, pretend as if no Bloom data was specified at
all. This avoids adding additional special-casing outside of the
commit-graph internals.

Suggested-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config.txt             | 2 ++
 Documentation/config/commitgraph.txt | 4 ++++
 commit-graph.c                       | 6 ++++--
 repo-settings.c                      | 3 +++
 repository.h                         | 1 +
 t/t4216-log-bloom.sh                 | 4 +++-
 6 files changed, 17 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/config/commitgraph.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3042d80978..770ae79b82 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -340,6 +340,8 @@ include::config/column.txt[]
 
 include::config/commit.txt[]
 
+include::config/commitgraph.txt[]
+
 include::config/credential.txt[]
 
 include::config/completion.txt[]
diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
new file mode 100644
index 0000000000..cff0797b54
--- /dev/null
+++ b/Documentation/config/commitgraph.txt
@@ -0,0 +1,4 @@
+commitGraph.readChangedPaths::
+	If true, then git will use the changed-path Bloom filters in the
+	commit-graph file (if it exists, and they are present). Defaults to
+	true. See linkgit:git-commit-graph[1] for more information.
diff --git a/commit-graph.c b/commit-graph.c
index 72a838bd00..ea54d108b9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -327,6 +327,8 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 		return NULL;
 	}
 
+	prepare_repo_settings(r);
+
 	graph = alloc_commit_graph();
 
 	graph->hash_len = the_hash_algo->rawsz;
@@ -403,14 +405,14 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 		case GRAPH_CHUNKID_BLOOMINDEXES:
 			if (graph->chunk_bloom_indexes)
 				chunk_repeated = 1;
-			else
+			else if (r->settings.commit_graph_read_changed_paths)
 				graph->chunk_bloom_indexes = data + chunk_offset;
 			break;
 
 		case GRAPH_CHUNKID_BLOOMDATA:
 			if (graph->chunk_bloom_data)
 				chunk_repeated = 1;
-			else {
+			else if (r->settings.commit_graph_read_changed_paths) {
 				uint32_t hash_version;
 				graph->chunk_bloom_data = data + chunk_offset;
 				hash_version = get_be32(data + chunk_offset);
diff --git a/repo-settings.c b/repo-settings.c
index aa61a35338..88ccce2036 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -17,9 +17,12 @@ void prepare_repo_settings(struct repository *r)
 
 	if (!repo_config_get_bool(r, "core.commitgraph", &value))
 		r->settings.core_commit_graph = value;
+	if (!repo_config_get_bool(r, "commitgraph.readchangedpaths", &value))
+		r->settings.commit_graph_read_changed_paths = value;
 	if (!repo_config_get_bool(r, "gc.writecommitgraph", &value))
 		r->settings.gc_write_commit_graph = value;
 	UPDATE_DEFAULT_BOOL(r->settings.core_commit_graph, 1);
+	UPDATE_DEFAULT_BOOL(r->settings.commit_graph_read_changed_paths, 1);
 	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
 
 	if (!repo_config_get_int(r, "index.version", &value))
diff --git a/repository.h b/repository.h
index 628c834367..bacf843d46 100644
--- a/repository.h
+++ b/repository.h
@@ -30,6 +30,7 @@ struct repo_settings {
 	int initialized;
 
 	int core_commit_graph;
+	int commit_graph_read_changed_paths;
 	int gc_write_commit_graph;
 	int fetch_write_commit_graph;
 
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index cd89c75002..fc7693806c 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -95,7 +95,9 @@ do
 		      "--ancestry-path side..master"
 	do
 		test_expect_success "git log option: $option for path: $path" '
-			test_bloom_filters_used "$option -- $path"
+			test_bloom_filters_used "$option -- $path" &&
+			test_config commitgraph.readChangedPaths false &&
+			test_bloom_filters_not_used "$option -- $path"
 		'
 	done
 done
-- 
2.27.0.2918.gc99a27ff8f

