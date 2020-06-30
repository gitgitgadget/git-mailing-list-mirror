Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219B2C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 17:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 008DD20772
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 17:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="uUas8twD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733069AbgF3RRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730374AbgF3RRo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 13:17:44 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADCEC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 10:17:44 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e12so16140915qtr.9
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c8I5s7nJAiONyWymM8ic/J47duN1kstf68mirVTbQMo=;
        b=uUas8twD5n5s/ujsucuzXfOV/3PeYnNtAc8vIGTGZFJwgCCCt1bECgSyis7J1t+Y4q
         gQKlZ5XqfBvP95YZQDdGdYyKvhgm9sBp3lxkSpQ+0DIe6bL3/qBCbz+1OA/3xBimxLRO
         o64EJu7oH0NKVfwUhUDi8boR7ImX93UhBMXqIGEbx9K3JanJsk6GNRXys9025ZPS4Kt8
         katXyY95pQQbwbV8W7m2I3/MiQj93zxaoqPUiH+MK/rzlqDpEvkj8+AvOazBA6TQ39eL
         1rNLHTeLaxitG6vRbWrTg7cluF1QreK9Ul4a7pumgqZX0t9FK/a81in3+N4hPa1QBRik
         dmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c8I5s7nJAiONyWymM8ic/J47duN1kstf68mirVTbQMo=;
        b=VtZe+AvzG/bRp+TajEgsvkcMfnVv9NcLXD/KBgyqx15BDCpCd9/m2v6ydhKMNWo67V
         wl7VjgegB6xlfox87GJC+oRCblaNz/rQuIQl9yAfdJ5iuCaBVMfKBchVidKQXmML3Cnj
         Vzqx51A+aYMdtJvGapb6ABUewtwfx6kvW/iU/9PMfAflJEdxidnsFto+gt58UFvlqdiq
         uN5ckhqc8xxMaY0w2scjj0r7DZhboYM+fZ7aen+SWu5A8U3J0mzGnYe/UyMDAJKVS79o
         QYlc3ZPk16t0XJ72ptLOYWRM/03qc/COSzplIgWHcZxV2UtB6MTxQzl+4PWdrvUH8oaP
         VfeQ==
X-Gm-Message-State: AOAM533d+yUGq2J9X3Wlew5AxddHH1mx2uqyQ1QN2hVW93WCD0jxDAUi
        auNvtXBBf0etbiE5GZn71SFvKk+RaNbHGw==
X-Google-Smtp-Source: ABdhPJxUYCHL5mqgXtNWyQQUyzQCzXyaZ6QZw3yUF/6RvQGIR7GXtE/6z5blFAeBPab4Q4DCoABH/Q==
X-Received: by 2002:ac8:3778:: with SMTP id p53mr22548872qtb.228.1593537462788;
        Tue, 30 Jun 2020 10:17:42 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f0ef:6367:5d8f:d7c])
        by smtp.gmail.com with ESMTPSA id x13sm3224240qts.57.2020.06.30.10.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 10:17:42 -0700 (PDT)
Date:   Tue, 30 Jun 2020 13:17:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 1/3] commit-graph: pass a 'struct repository *' in more places
Message-ID: <4ea9933b50fe0bc2738ab0e0dc52a4f17c4a2cb4.1593536481.git.me@ttaylorr.com>
References: <cover.1593536481.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1593536481.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, some commit-graph internals will want access to
'r->settings', but we only have the 'struct object_directory *'
corresponding to that repository.

Add an additional parameter to pass the repository around in more
places. In the next patch, we will remove the object directory (and
instead reference it with 'r->odb').

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/commit-graph.c |  2 +-
 commit-graph.c         | 13 ++++++++-----
 commit-graph.h         |  4 +++-
 fuzz-commit-graph.c    |  5 +++--
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 75455da138..7c0f98531d 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -106,7 +106,7 @@ static int graph_verify(int argc, const char **argv)
 	FREE_AND_NULL(graph_name);
 
 	if (open_ok)
-		graph = load_commit_graph_one_fd_st(fd, &st, odb);
+		graph = load_commit_graph_one_fd_st(fd, &st, the_repository, odb);
 	else
 		graph = read_commit_graph_one(the_repository, odb);
 
diff --git a/commit-graph.c b/commit-graph.c
index 2ff042fbf4..fdfb0888f0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -170,6 +170,7 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
 }
 
 struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
+						 struct repository *r,
 						 struct object_directory *odb)
 {
 	void *graph_map;
@@ -185,7 +186,7 @@ struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	ret = parse_commit_graph(graph_map, graph_size);
+	ret = parse_commit_graph(r, graph_map, graph_size);
 
 	if (ret)
 		ret->odb = odb;
@@ -225,7 +226,8 @@ static int verify_commit_graph_lite(struct commit_graph *g)
 	return 0;
 }
 
-struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size)
+struct commit_graph *parse_commit_graph(struct repository *r,
+					void *graph_map, size_t graph_size)
 {
 	const unsigned char *data, *chunk_lookup;
 	uint32_t i;
@@ -396,6 +398,7 @@ struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size)
 }
 
 static struct commit_graph *load_commit_graph_one(const char *graph_file,
+						  struct repository *r,
 						  struct object_directory *odb)
 {
 
@@ -407,7 +410,7 @@ static struct commit_graph *load_commit_graph_one(const char *graph_file,
 	if (!open_ok)
 		return NULL;
 
-	g = load_commit_graph_one_fd_st(fd, &st, odb);
+	g = load_commit_graph_one_fd_st(fd, &st, r, odb);
 
 	if (g)
 		g->filename = xstrdup(graph_file);
@@ -419,7 +422,7 @@ static struct commit_graph *load_commit_graph_v1(struct repository *r,
 						 struct object_directory *odb)
 {
 	char *graph_name = get_commit_graph_filename(odb);
-	struct commit_graph *g = load_commit_graph_one(graph_name, odb);
+	struct commit_graph *g = load_commit_graph_one(graph_name, r, odb);
 	free(graph_name);
 
 	return g;
@@ -500,7 +503,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 		valid = 0;
 		for (odb = r->objects->odb; odb; odb = odb->next) {
 			char *graph_name = get_split_graph_filename(odb, line.buf);
-			struct commit_graph *g = load_commit_graph_one(graph_name, odb);
+			struct commit_graph *g = load_commit_graph_one(graph_name, r, odb);
 
 			free(graph_name);
 
diff --git a/commit-graph.h b/commit-graph.h
index 3ba0da1e5f..03d848e168 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -76,10 +76,12 @@ struct commit_graph {
 };
 
 struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
+						 struct repository *r,
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
2.27.0.224.g4cfa086e50

