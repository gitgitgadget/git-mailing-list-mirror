Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7450FC43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 15:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 286A122274
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 15:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fORIFwlm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgIIP3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgIIP1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 11:27:24 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B9FC0619CB
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 08:23:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q63so2002506qkf.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ye5G3SmcAbeoLvNM8waHHba3R+gSvPixSydParYIhyg=;
        b=fORIFwlmqglP9fObDFglm1FudL/XWUGofxmVlAQVS4zSKKzsOeBVuXimsXJujmwGdg
         ISQJZNrO3KviXoSJFdX3ICcSNhvPdf1mmvpiJfhosAGkEZJlJyXWhMSw76pnrX6y+WVR
         PHiQwqYT8qt0cvKqwBWr9JMiLn2mc+Gt/IISjOSc6T/KkauYB5YWDRquVRCyOTNWzoVF
         5/oFGOsfjSXEpAkuzsJ8/3nZbMDta86ZGxAGfFyBvvFLbxUC7UZaoanZ1oZwiydYDQ1j
         yeuvCKdatWE/XL0/lPNEWRp4CI483bsjU9rgUe1PjlKbCwX77hInD5zm6KtBt88d668k
         1uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ye5G3SmcAbeoLvNM8waHHba3R+gSvPixSydParYIhyg=;
        b=WBNjqK3nqyivB7gWFN9AEZHhSJSfDp7Jc7k+UKkv/0vqv8qgGsSm/RkxDZvsmSGt6q
         aRlHRpazM3JWLEN4c+rH5Zi4LVpACMi/3fJCclLvJJjxGQyZSc++Z84USXOq+QM2W24t
         hqbE4cF3/T38/xVjkK38JUw60T/ldIjv/CJFCCKtwOPMmU4jX5uU3FFMfPGkVEZObVM9
         Jjat/UCj4LOV0Ao1cGm6RHYGWZ8x7p5K/udp8RtiXl1fYKibQstELOzesQfr4Vqyxrdb
         ju2+ERPsWn7O6dgDyRMAdQAwlviQ5CJhUiqLnNzX9+mMXqWl71U0dXwfSESPNj5zAl8l
         PWaQ==
X-Gm-Message-State: AOAM5306BhlCLqjJLpsEZD2pD91oW9R3nYKY0VZY8GDp0BCrbpHlV3ot
        uKbHn1mh7UQzG9el/0qVw+HIC8og+yFAXLxA
X-Google-Smtp-Source: ABdhPJxGlx2oe3AH1K8Th2cP1nzh/lVuHXFvMPH6wBO8n+SfJXhNb46ZdJDrzGuw6A0h0tEaV1KHpw==
X-Received: by 2002:a37:6248:: with SMTP id w69mr3567104qkb.448.1599664979197;
        Wed, 09 Sep 2020 08:22:59 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:10e2:cf5e:922:2af0])
        by smtp.gmail.com with ESMTPSA id j1sm3371152qtk.91.2020.09.09.08.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:22:58 -0700 (PDT)
Date:   Wed, 9 Sep 2020 11:22:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH 03/12] commit-graph: pass a 'struct repository *' in more
 places
Message-ID: <0817b0f618700ced34af6c597eee7312993b0d1f.1599664389.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1599664389.git.me@ttaylorr.com>
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
2.28.0.462.g4ff11cec37

