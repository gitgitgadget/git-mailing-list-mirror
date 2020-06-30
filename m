Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938FCC433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 17:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E89A20775
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 17:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="HLj7DFUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390208AbgF3RRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390204AbgF3RRv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 13:17:51 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861F1C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 10:17:51 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id h18so9617424qvl.3
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 10:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0t/EeVB4aky+95a1hU9GZkQiEy8sQ3XXgJGtfmGVyFA=;
        b=HLj7DFUrKlcnxmXg2ZmYz/tLmJh1v3LS/Iadr1QK+TMbqUE3RvB79WOaYXq8forwKC
         QWpfYllw/zqTS1/AMFg/e1BfD7LT3Wi9cmPdCuncn/d+WZtubQicGAzjC1aWxZKbYO05
         iBtHWFZ1yCD7dp/Fdhz8TaqG5l+Kk2KMdnU2rACos2A32uKv5E1kq60KQNLf8NBmoViQ
         Z4V6BP+NhAlqVljlUUszIYZhkZbbgLSziaZCeZRr35Q5s65N3iwr6GWSaDih57cECL9C
         0SoM7pe5MTaur3h09QIaBr2o9cBGOKXxCHipvTYflmtgmigKr5geJXsGdc8SybCyKo1Z
         nsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0t/EeVB4aky+95a1hU9GZkQiEy8sQ3XXgJGtfmGVyFA=;
        b=CV8Ljhn1Iyk/CuOq0/+5aZSUMO7n2qtCUWnqGJoGJaLMuebWgVa01aCe2WrJFxuYuP
         KgrOoEJ+JOjD8D7+Zs3TLlo330Rh/0+i9TiM6PgjquTCpKPcBPmK9xRDr2LbCVNzyoIf
         bSxcPDZPfPagKsLs99Ypanm1smE0ZfeLkTvt50A79t4MiQ+xdRXmUnWATlLJqjvPYgdn
         EZN/RjW0C9Yz3EYPJpYC27XuViHOIL+j3YpFDuciiWwnKQo4Xog5NzxVHmbn9fksAVoA
         kC1eW8Fb76XkVnR8M3jsTSWmDs1sL+lwzi6t8Z8X0exQGCgmQ1l3QPtM9Eax97MOQnlG
         /+UQ==
X-Gm-Message-State: AOAM533pyCyQlg2+zg1Jr4UN7eyHMpiaOVhf/nTL13eozxm8G98H0qAx
        nzBsB1jdPga5MQs/4db+AyW066seZyajjg==
X-Google-Smtp-Source: ABdhPJy94GPf3WLaoExybFTdNMM6WmxDn41zXeHKAXJH2mKImVrukhJ8FFVobNN0yIYFLs6yXyEacQ==
X-Received: by 2002:a0c:e008:: with SMTP id j8mr17706554qvk.87.1593537470188;
        Tue, 30 Jun 2020 10:17:50 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f0ef:6367:5d8f:d7c])
        by smtp.gmail.com with ESMTPSA id e2sm3349175qkm.115.2020.06.30.10.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 10:17:49 -0700 (PDT)
Date:   Tue, 30 Jun 2020 13:17:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 3/3] commit-graph: respect 'core.useBloomFilters'
Message-ID: <4cfa086e503e19763a9d581fcb6a2ef818776dfc.1593536481.git.me@ttaylorr.com>
References: <cover.1593536481.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1593536481.git.me@ttaylorr.com>
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

Introduce 'core.useBloomFilters' to control whether or not Bloom filters
are read. Note that this configuration is independent from both:

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
 Documentation/config/core.txt | 5 +++++
 commit-graph.c                | 4 ++--
 repo-settings.c               | 3 +++
 repository.h                  | 1 +
 t/helper/test-read-graph.c    | 3 ++-
 t/t4216-log-bloom.sh          | 4 +++-
 6 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 74619a9c03..b146bf8d34 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -599,6 +599,11 @@ core.commitGraph::
 	to parse the graph structure of commits. Defaults to true. See
 	linkgit:git-commit-graph[1] for more information.
 
+core.useBloomFilters::
+	If true, then git will use the changed-path Bloom filters in the
+	commit-graph file (if it exists, and they are present). Defaults to
+	true. See linkgit:git-commit-graph[1] for more information.
+
 core.useReplaceRefs::
 	If set to `false`, behave as if the `--no-replace-objects`
 	option was given on the command line. See linkgit:git[1] and
diff --git a/commit-graph.c b/commit-graph.c
index fdfb0888f0..03c00415c4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -337,14 +337,14 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 		case GRAPH_CHUNKID_BLOOMINDEXES:
 			if (graph->chunk_bloom_indexes)
 				chunk_repeated = 1;
-			else
+			else if (r->settings.core_use_bloom_filters)
 				graph->chunk_bloom_indexes = data + chunk_offset;
 			break;
 
 		case GRAPH_CHUNKID_BLOOMDATA:
 			if (graph->chunk_bloom_data)
 				chunk_repeated = 1;
-			else {
+			else if (r->settings.core_use_bloom_filters) {
 				uint32_t hash_version;
 				graph->chunk_bloom_data = data + chunk_offset;
 				hash_version = get_be32(data + chunk_offset);
diff --git a/repo-settings.c b/repo-settings.c
index dc6817daa9..d8e3b1c61e 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -17,9 +17,12 @@ void prepare_repo_settings(struct repository *r)
 
 	if (!repo_config_get_bool(r, "core.commitgraph", &value))
 		r->settings.core_commit_graph = value;
+	if (!repo_config_get_bool(r, "core.usebloomfilters", &value))
+		r->settings.core_use_bloom_filters = value;
 	if (!repo_config_get_bool(r, "gc.writecommitgraph", &value))
 		r->settings.gc_write_commit_graph = value;
 	UPDATE_DEFAULT_BOOL(r->settings.core_commit_graph, 1);
+	UPDATE_DEFAULT_BOOL(r->settings.core_use_bloom_filters, 1);
 	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
 
 	if (!repo_config_get_int(r, "index.version", &value))
diff --git a/repository.h b/repository.h
index 3c1f7d54bd..cc61533122 100644
--- a/repository.h
+++ b/repository.h
@@ -29,6 +29,7 @@ struct repo_settings {
 	int initialized;
 
 	int core_commit_graph;
+	int core_use_bloom_filters;
 	int gc_write_commit_graph;
 	int fetch_write_commit_graph;
 
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 6d0c962438..5f585a1725 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -12,11 +12,12 @@ int cmd__read_graph(int argc, const char **argv)
 	setup_git_directory();
 	odb = the_repository->objects->odb;
 
+	prepare_repo_settings(the_repository);
+
 	graph = read_commit_graph_one(the_repository, odb);
 	if (!graph)
 		return 1;
 
-
 	printf("header: %08x %d %d %d %d\n",
 		ntohl(*(uint32_t*)graph->data),
 		*(unsigned char*)(graph->data + 4),
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 0b4cc4f8d1..b1a247477e 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -90,7 +90,9 @@ do
 		      "--ancestry-path side..master"
 	do
 		test_expect_success "git log option: $option for path: $path" '
-			test_bloom_filters_used "$option -- $path"
+			test_bloom_filters_used "$option -- $path" &&
+			test_config core.useBloomFilters false &&
+			test_bloom_filters_not_used "$option -- $path"
 		'
 	done
 done
-- 
2.27.0.224.g4cfa086e50
