Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890C7C10DAA
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4831D20786
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="IC8G1JMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgICWqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729581AbgICWqO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 18:46:14 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB763C061249
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 15:46:13 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w16so4690424qkj.7
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 15:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MYSeo56uRodtCiJWZQi2tkaNankbkIOuGdGn/m8FMFs=;
        b=IC8G1JMm3JTbm6y9CFj3RkObXhboQ3BxupUqd0aGPxvdukIdiOaDvf2A028xvcvumZ
         /0xIDZKHZd408QYp4gl5ORNfaMZWrBGoHz8R2jtchDGLqsVyyKiukSfVdDYGze5ricA6
         gmUb2vp6sqyc/ALSXpY1Te0/G44Q+XCEQQr2NmF3RXOK65JdSVJiVGBmzyRWAs3oYsBF
         6OJTe0uefkwbMrgeekq8vldtaGOlZjTSfLN8C6ZCM4an0NcCTS24y2oCmje2GELGtO+O
         yyZ4OzZIYmRu3goCSp+iTO+8MxSwOzoZeRhcZua4Diht/hAG16k28YNz+ulVQ7sLcmVC
         Fntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MYSeo56uRodtCiJWZQi2tkaNankbkIOuGdGn/m8FMFs=;
        b=RvO8qyZ0qXq8TLlKsncopQztwxIM5pj9nTgSYZC8ErGi4ITcfJCHkJWospT84yGI9w
         8yEemDbU2tQiMdL014bXIKUA2vvvZ98ls1txbMld5QtKFSW1PvxR9/h+pmYPV9yXgSY4
         T9Enq8Dt2pg+bP7DowMpksT50TEEqlDd7ZiPg9HUqbmMjqHAr/39wUugoRoz7yamTWzS
         Ozc1g/D0KAfX0uHPQgRm/w+bU5gimTM5TvjCV9byq+zEyeOMtObOIXojrQxCA1LblGHh
         GhYVUE6eJnrp/Gk4puo1CqktodrhP7lSykm2UrB9bjDVi6nEgxP71HjI1iFAZzIxAIqP
         KtsA==
X-Gm-Message-State: AOAM532HP2aw1PEhhJt6BeODyD4GXt1o0uh48C0c2owWgcYcBqFBYgmy
        hB7jTEVMspb5USF2Xqk35r5XGSDenm9wazbQ
X-Google-Smtp-Source: ABdhPJwY0zC874XeOmuEbdiVBlcP/CjqsEBqwOL+kxK4498FYep4cyZqe+pi8NQHOV8h/6f02xhsTw==
X-Received: by 2002:a05:620a:3d0:: with SMTP id r16mr5306501qkm.129.1599173172817;
        Thu, 03 Sep 2020 15:46:12 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a97c:6dae:76a4:c715])
        by smtp.gmail.com with ESMTPSA id f3sm3089943qth.56.2020.09.03.15.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:46:12 -0700 (PDT)
Date:   Thu, 3 Sep 2020 18:46:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v4 03/14] commit-graph: pass a 'struct repository *' in more
 places
Message-ID: <639a962a4920d35002aa5111d1d983b96277e882.1599172907.git.me@ttaylorr.com>
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

In a future commit, some commit-graph internals will want access to
'r->settings', but we only have the 'struct object_directory *'
corresponding to that repository.

Add an additional parameter to pass the repository around in more
places.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/commit-graph.c |  2 +-
 commit-graph.c         | 17 ++++++++++-------
 commit-graph.h         |  6 ++++--
 fuzz-commit-graph.c    |  5 +++--
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 523501f217..ba5584463f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -106,7 +106,7 @@ static int graph_verify(int argc, const char **argv)
 	FREE_AND_NULL(graph_name);
 
 	if (open_ok)
-		graph = load_commit_graph_one_fd_st(fd, &st, odb);
+		graph = load_commit_graph_one_fd_st(the_repository, fd, &st, odb);
 	else
 		graph = read_commit_graph_one(the_repository, odb);
 
diff --git a/commit-graph.c b/commit-graph.c
index 6a36ed0b06..72a838bd00 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -231,7 +231,8 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
 	return 1;
 }
 
-struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
+struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
+						 int fd, struct stat *st,
 						 struct object_directory *odb)
 {
 	void *graph_map;
@@ -247,7 +248,7 @@ struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	ret = parse_commit_graph(graph_map, graph_size);
+	ret = parse_commit_graph(r, graph_map, graph_size);
 
 	if (ret)
 		ret->odb = odb;
@@ -287,7 +288,8 @@ static int verify_commit_graph_lite(struct commit_graph *g)
 	return 0;
 }
 
-struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size)
+struct commit_graph *parse_commit_graph(struct repository *r,
+					void *graph_map, size_t graph_size)
 {
 	const unsigned char *data, *chunk_lookup;
 	uint32_t i;
@@ -452,7 +454,8 @@ struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size)
 	return NULL;
 }
 
-static struct commit_graph *load_commit_graph_one(const char *graph_file,
+static struct commit_graph *load_commit_graph_one(struct repository *r,
+						  const char *graph_file,
 						  struct object_directory *odb)
 {
 
@@ -464,7 +467,7 @@ static struct commit_graph *load_commit_graph_one(const char *graph_file,
 	if (!open_ok)
 		return NULL;
 
-	g = load_commit_graph_one_fd_st(fd, &st, odb);
+	g = load_commit_graph_one_fd_st(r, fd, &st, odb);
 
 	if (g)
 		g->filename = xstrdup(graph_file);
@@ -476,7 +479,7 @@ static struct commit_graph *load_commit_graph_v1(struct repository *r,
 						 struct object_directory *odb)
 {
 	char *graph_name = get_commit_graph_filename(odb);
-	struct commit_graph *g = load_commit_graph_one(graph_name, odb);
+	struct commit_graph *g = load_commit_graph_one(r, graph_name, odb);
 	free(graph_name);
 
 	return g;
@@ -557,7 +560,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 		valid = 0;
 		for (odb = r->objects->odb; odb; odb = odb->next) {
 			char *graph_name = get_split_graph_filename(odb, line.buf);
-			struct commit_graph *g = load_commit_graph_one(graph_name, odb);
+			struct commit_graph *g = load_commit_graph_one(r, graph_name, odb);
 
 			free(graph_name);
 
diff --git a/commit-graph.h b/commit-graph.h
index 0677dd1031..d9acb22bac 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -75,11 +75,13 @@ struct commit_graph {
 	struct bloom_filter_settings *bloom_filter_settings;
 };
 
-struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
+struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
+						 int fd, struct stat *st,
 						 struct object_directory *odb);
 struct commit_graph *read_commit_graph_one(struct repository *r,
 					   struct object_directory *odb);
-struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size);
+struct commit_graph *parse_commit_graph(struct repository *r,
+					void *graph_map, size_t graph_size);
 
 /*
  * Return 1 if and only if the repository has a commit-graph
diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
index 430817214d..e7cf6d5b0f 100644
--- a/fuzz-commit-graph.c
+++ b/fuzz-commit-graph.c
@@ -1,7 +1,8 @@
 #include "commit-graph.h"
 #include "repository.h"
 
-struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size);
+struct commit_graph *parse_commit_graph(struct repository *r,
+					void *graph_map, size_t graph_size);
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 
@@ -10,7 +11,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	struct commit_graph *g;
 
 	initialize_the_repository();
-	g = parse_commit_graph((void *)data, size);
+	g = parse_commit_graph(the_repository, (void *)data, size);
 	repo_clear(the_repository);
 	free_commit_graph(g);
 
-- 
2.27.0.2918.gc99a27ff8f

