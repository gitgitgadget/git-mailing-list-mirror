Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C336DC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D0023719
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="hx8UBLau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgIRC7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgIRC7P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 22:59:15 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44855C06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:15 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id t138so4689832qka.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PJQDiWIf+AbD8KIajdV9L7975Pp1xcbN/65IdFDqbAw=;
        b=hx8UBLauMZgYHUP0sX3Mi+XZ/OMoIih7/BKrMy1AtjBEbx4vesGBPc/kZI4/DrN5WW
         Y+ieqtRc2yS2DaOxKBJIs6yZSd7QSw7lresgDBUbpRgRpsWxQeXYzdxuwaxApBbW+ylI
         jTqzaeC1y1qZzgokYoI+1zTIS6VYmnJO7tq53w2qOdL84ArTZpx+0q/sFnEbqjdhbaoz
         f2zGDJTrlC5N57jjzE5VqHbZ5aPWFlFVOUvP47sX+e1Llo8copmQb0g+1SVCV1nwzpWz
         KsLc3EaN1NxvOLFZEPvimJOMR5e7WYywfQID1XPb8j+jgRAKVAFKZg15O2zuI6IpTOhk
         msmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PJQDiWIf+AbD8KIajdV9L7975Pp1xcbN/65IdFDqbAw=;
        b=nf5JjCwENchmjH+7/qkM4S4MDLDtP3eN14omwRR5eUTxZNpCTiPnNww5l1JIeYlN7r
         86u0fTZR5/KjlezPDvVfVVugEZ2j9M7t067l5OQkAl8zHzlkNKb9bVbXC8rS2ZQqZO/m
         UX/Jqej9MDOdOJFbEYjo59hPCln63XleYP+96Y0an5PLPJoM3U1rbJvNCYiHC54yiOAQ
         ZdB1fAa1no5PFHbSJ6ZUnMAvNZa10om+F/csO0Ruz0KvCWHtlT/y6u9TproAvTv46YlL
         G1MEyqVPcdPOSfTnkfYYSNGuIgMyxj6ZaRsBXW4l+agRBnmxMtFAZH8NI820gWZsFynH
         UnLg==
X-Gm-Message-State: AOAM531+bkwtiqTcAXy2ZsrfZ7BB2y0FO4miWoAAkbff3E7Ge3r84emX
        OzAGay7H+q8qJU9zDE+635KMRTNAN1CK9ZRp
X-Google-Smtp-Source: ABdhPJxB0xDGqtWopNFrFet8YqSzkcTkloc1ggyiLr0+bO2/iZq3yjyJuB5PH+XBgEB5PFLATMEjSg==
X-Received: by 2002:a05:620a:2118:: with SMTP id l24mr20282675qkl.298.1600397954151;
        Thu, 17 Sep 2020 19:59:14 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id e1sm1304908qtb.0.2020.09.17.19.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 19:59:13 -0700 (PDT)
Date:   Thu, 17 Sep 2020 22:59:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 05/13] commit-graph: respect 'commitGraph.readChangedPaths'
Message-ID: <2e79a470319612b293748cdc0c1fe601cf2e20f1.1600397826.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600397826.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1600397826.git.me@ttaylorr.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.28.0.510.g375ecf1f36

