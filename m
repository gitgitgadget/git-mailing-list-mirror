Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52642C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCA622D00
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="QsJmF3Tq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgHERG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgHERCf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:02:35 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE6EC06179F
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:02:35 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id d14so42306358qke.13
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OaOZ9gT79tjrUv9cgKcQTqD6M81VIYGGJlB88j6wVR4=;
        b=QsJmF3TqO3+FdViREG1kQ7zx/n/d9hEhMxCTGYk1kiiZQgs2cBFQW9vTbWKMVqq7Dd
         DbVi4a7PE7sfuoUcoww9XniwbIH24J8TyHoiv8fDssllyKA8X6jD5NN577UisIkcpIPz
         ZYqhREYsEyGivFfFYS20ZPsGgzMK91u1Jn/C99M2IMlxMirlXlkT0D4hIxGoAIR2ufbh
         4lmD6wrxzK9lOLqdbG4DLfKBM5gPE8Dg3RkHBqbbiBvigsUn39xiUjiFBBVlW6pphIId
         /JgjjyBjWhF9ORReZEhPf526DPpnWhkxi7OveYg/B+g2KsCEFZTlY9Y8MaZYrBUFLO5U
         WALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OaOZ9gT79tjrUv9cgKcQTqD6M81VIYGGJlB88j6wVR4=;
        b=CR3LuNVmkKJuODgs2jXcxiCfRhLww1h+3ixWJ4Pxm37hCmyNqQeRUMNjsSxekCooBf
         hAR7bZuPKnWTGPS6+PCMH468OdCQvwG9B9+Z7FOGiXJpsReFFtKgsK3idmeLgeTCKISY
         b8ZLWPwwanYGhb5gkM13JuTkQJfHkzi0H1iKc/sMyuiQ6jxMdkRf/V18xMYsUhnGkDOV
         FCYSb1SgvxTCZI7XRqvez5ufwR1T4DdcaiWWGMCrvZASSllB9aCYTD1KbX2l+JI+/NAS
         HIgdWeaGTuATeMfqoHaJBOQxOT+m/ZY1zCuN3zkoCbrnkN6CwKEHQ5i8Fty4CQnQsYpb
         XQDg==
X-Gm-Message-State: AOAM532QDBFaUnau7r52k0oSMG13CuDpo++SDMR30ECjin9U8qVhPVwx
        1m1lBzMfTI76HcHe3j/lDaDekhUhEShywQ==
X-Google-Smtp-Source: ABdhPJw2o+SikMVAdIGV0T6Qtd0dwCuhkovC6XNZ90x7eSqZCWoXmA4zyQTJZw9+rMEWRmQz8PTwvA==
X-Received: by 2002:a37:3c1:: with SMTP id 184mr4262189qkd.312.1596646953788;
        Wed, 05 Aug 2020 10:02:33 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id g4sm1953376qka.25.2020.08.05.10.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:02:33 -0700 (PDT)
Date:   Wed, 5 Aug 2020 13:02:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com
Subject: [PATCH v2 05/14] commit-graph: respect 'commitGraph.readChangedPaths'
Message-ID: <404f10319af210a2edf05bd1097ab5a844cc5c37.1596646576.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1596646576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596646576.git.me@ttaylorr.com>
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
index ef0768b91a..78883c6e63 100644
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
index 0c1030641c..a516e93d71 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -320,6 +320,8 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 		return NULL;
 	}
 
+	prepare_repo_settings(r);
+
 	graph = alloc_commit_graph();
 
 	graph->hash_len = the_hash_algo->rawsz;
@@ -396,14 +398,14 @@ struct commit_graph *parse_commit_graph(struct repository *r,
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
index 0918408b34..9e551bc03d 100644
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
index 3c1f7d54bd..81759b7d27 100644
--- a/repository.h
+++ b/repository.h
@@ -29,6 +29,7 @@ struct repo_settings {
 	int initialized;
 
 	int core_commit_graph;
+	int commit_graph_read_changed_paths;
 	int gc_write_commit_graph;
 	int fetch_write_commit_graph;
 
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fe19f6a60c..b3d1f596f8 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -90,7 +90,9 @@ do
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
2.28.0.rc1.13.ge78abce653

