Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C74DC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E82FD20872
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="b+b/MDLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgIPSHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgIPSHK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:07:10 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0278C061788
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:07:09 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cr8so4000126qvb.10
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jGDpqN2Zui4Hmu5NwotOKRW01cVi6UT23SkbgECw41Q=;
        b=b+b/MDLvqxPlk7zXt/oeLvt5vS4li8iF+ZCNnq80OHqtB4+KFQ2xpldJeVsRXYrkFy
         tHKMaYlDUagRwC1yA6f+O2vTmTNXwZJhWRISabxePAz/JySjZ5WapmufBvyOF0QV4BK9
         RcVJlw7x3iaTqgh8pfxvcCU495y/Zw3liRbmI03mA4ZlZUC7g1iH0mjeQMx8/KNszhkM
         2C8uiGa3fQYjFx3XB7h7iQ6ZoNMRznuLv2fhMLw3deNd/SqxGnnCiIf6wHZrJSTG+l9f
         Glsg07ZKyYUrFgxFLtyjlPfxgtac+4J49jWmsUwfZt7GLgcz2KxTEnzvk0rv8sJqpPFW
         W3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jGDpqN2Zui4Hmu5NwotOKRW01cVi6UT23SkbgECw41Q=;
        b=k1gPb2gJr8Lq3y000EqxIux40GxvokqeTWhzQmhyR4lmViF5pSxK9WBNyEWRxYoLGn
         rxXF4/OmWCJZn/ecdc00P1MTNYf980by1KzGQKc2OA1LtGq2bnTha0pX+DbIz/kR1SKL
         Anbb5GVv0dGahiAGfZ7jsU+OVO1Q2NuSyuUb69Z+2Xplplqoji0cGuFvp7WRNYb3aHGY
         +H+dxei4YoKasYSerUr1I7FgUGISwsKPrc1nm0akYHAFI7GSIy2zUawOIXbKmr1tNqu8
         13xJvEPkJHWTitFPU2bvOthQajgI5pP9eTG9HoZRXK6v1R3Sushzvk3XjP+jG2JzL1C/
         7GrA==
X-Gm-Message-State: AOAM533EWr2AZEo1LKfzj+i4nFqx7nCk505sV3554a1FsYHpBhuWzugg
        zTvu726beTk9oHSzUYqAxN6l66muuiCB6Hxz
X-Google-Smtp-Source: ABdhPJzvw7k+gki0J1ZfBGxjR2mFREQ9HTNLBqL8phUBut9+uNDVBnLqmTHC4uOifQG7Jkx+dFwlIA==
X-Received: by 2002:ad4:4b61:: with SMTP id m1mr25023292qvx.11.1600279628581;
        Wed, 16 Sep 2020 11:07:08 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e86e:6adf:7537:ae24])
        by smtp.gmail.com with ESMTPSA id e1sm19885407qtb.0.2020.09.16.11.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:07:07 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:07:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 03/13] commit-graph: pass a 'struct repository *' in more
 places
Message-ID: <f9c7109daf44b2d99f21a42843a5d5591abb4087.1600279373.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600279373.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1600279373.git.me@ttaylorr.com>
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
2.28.0.510.g86fdc5f89a

