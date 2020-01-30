Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037A2C33CB3
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD19B2063A
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="TsnvYCrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgA3XAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:00:51 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42615 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbgA3XAu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 18:00:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id s64so2405043pgb.9
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 15:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q6/xtevWMepwUgTxVi+MaHnClkd9BUixgXtTuS1NRis=;
        b=TsnvYCrV4ADNX9l7iGE/OzqG348SonxXSM7jDliqFy1x8rPEeXfIymlR8E76L701Ya
         NcFzT8YHjYAiePEBhVUcx/Gcf9AAxwYR9+1qr3I+eZADDqlFzfNDMKNRbtKVb4EZhJUO
         osE+KAyHUe0QGANIogh/k7amyRfMeNGXknbLxXChWaj09gCXlvm2AOlx9Cebvv+7Xmnb
         fDl5CPUNg1UkPi71FQTvj59uSlXvGNXze8ZMWev4uZOZ6qlULCR96uj/z3D5rlUFL5lM
         gDgPHjfGEZyVZDXihcP9ndRto6dSoqRRUgt1clBUNhO4+RGzGPZEffFDByVNnwUJQuxn
         vGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q6/xtevWMepwUgTxVi+MaHnClkd9BUixgXtTuS1NRis=;
        b=r51JtEV1BiCoQEmrgm6Cmp2LsJjbLHESKtbbNj2F2Px2PmYue+5XdjsHKoszNR64Yt
         7maYKQzcBPF9knmiD1a61/fcxahh5cUYb7wAHxGcCI0rEFDd7rpuvTB1orb57nBOioM9
         PAYQOzy9e8E5lACOzLej/2Ije9Brkx0iTE80inSfrWsaIjWPt1MWYxSFhSkSpRD+Quf4
         JqYlpxUNp96abh15gcsqD6LGG5nheOOQDo4I52ZVHIFTdm4jxiItVaLumb0gVHc6GVKo
         Jb0JzonCFkUtN5nUQZdU3aLr4IxvjndFwLCvd53bF6jNmZN9uorPsEt+MBgwsExGhPga
         o1xA==
X-Gm-Message-State: APjAAAXqfqkBVn7scWFy4pubhOlFA5XKOjYkkDnLHvJzB0QS0vs77vaG
        1fAC/jYzRAtvlTaikQdHnUfekHpL8Xcwuw==
X-Google-Smtp-Source: APXvYqwHXmQ/IP9pJOQZ6NUsK+uwBOiMIVwWYzkVqNVL7g0hudN+tv1oykXyz2KCwMV5dzyk1ewgNQ==
X-Received: by 2002:a63:211f:: with SMTP id h31mr6678092pgh.299.1580425249034;
        Thu, 30 Jan 2020 15:00:49 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:5c8f:7dac:47b8:95ff])
        by smtp.gmail.com with ESMTPSA id m101sm7827422pje.13.2020.01.30.15.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 15:00:48 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:00:47 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH 6/6] commit-graph.h: use odb in 'load_commit_graph_one_fd_st'
Message-ID: <15c74d0f65545d7ceb258712e27c388b58cd54d9.1580424766.git.me@ttaylorr.com>
References: <cover.1580424766.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1580424766.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply a similar treatment as in the previous patch to pass a 'struct
object_directory *' through the 'load_commit_graph_one_fd_st'
initializer, too.

This prevents a potential bug where a pointer comparison is made to a
NULL 'g->odb', which would cause the commit-graph machinery to think
that a pair of commit-graphs belonged to different alternates when in
fact they do not (i.e., in the case of no '--object-dir').

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/commit-graph.c     |  2 +-
 commit-graph.c             | 21 ++++++++++-----------
 commit-graph.h             |  3 ++-
 t/helper/test-read-graph.c |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 4ab045395e..de321c71ad 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -86,7 +86,7 @@ static int graph_verify(int argc, const char **argv)
 	FREE_AND_NULL(graph_name);
 
 	if (open_ok)
-		graph = load_commit_graph_one_fd_st(fd, &st);
+		graph = load_commit_graph_one_fd_st(fd, &st, odb);
 	else
 		graph = read_commit_graph_one(the_repository, odb);
 
diff --git a/commit-graph.c b/commit-graph.c
index 09316240f0..6d34829f57 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -128,7 +128,8 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
 	return 1;
 }
 
-struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st)
+struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
+						 struct object_directory *odb)
 {
 	void *graph_map;
 	size_t graph_size;
@@ -144,7 +145,9 @@ struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st)
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	ret = parse_commit_graph(graph_map, fd, graph_size);
 
-	if (!ret) {
+	if (ret)
+		ret->odb = odb;
+	else {
 		munmap(graph_map, graph_size);
 		close(fd);
 	}
@@ -319,7 +322,8 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 	return graph;
 }
 
-static struct commit_graph *load_commit_graph_one(const char *graph_file)
+static struct commit_graph *load_commit_graph_one(const char *graph_file,
+						  struct object_directory *odb)
 {
 
 	struct stat st;
@@ -330,7 +334,7 @@ static struct commit_graph *load_commit_graph_one(const char *graph_file)
 	if (!open_ok)
 		return NULL;
 
-	g = load_commit_graph_one_fd_st(fd, &st);
+	g = load_commit_graph_one_fd_st(fd, &st, odb);
 
 	if (g)
 		g->filename = xstrdup(graph_file);
@@ -342,12 +346,9 @@ static struct commit_graph *load_commit_graph_v1(struct repository *r,
 						 struct object_directory *odb)
 {
 	char *graph_name = get_commit_graph_filename(odb);
-	struct commit_graph *g = load_commit_graph_one(graph_name);
+	struct commit_graph *g = load_commit_graph_one(graph_name, odb);
 	free(graph_name);
 
-	if (g)
-		g->odb = odb;
-
 	return g;
 }
 
@@ -426,13 +427,11 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 		valid = 0;
 		for (odb = r->objects->odb; odb; odb = odb->next) {
 			char *graph_name = get_split_graph_filename(odb, line.buf);
-			struct commit_graph *g = load_commit_graph_one(graph_name);
+			struct commit_graph *g = load_commit_graph_one(graph_name, odb);
 
 			free(graph_name);
 
 			if (g) {
-				g->odb = odb;
-
 				if (add_graph_to_chain(g, graph_chain, oids, i)) {
 					graph_chain = g;
 					valid = 1;
diff --git a/commit-graph.h b/commit-graph.h
index 97e2bce313..7d9fc9c16a 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -63,7 +63,8 @@ struct commit_graph {
 	const unsigned char *chunk_base_graphs;
 };
 
-struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
+struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
+						 struct object_directory *odb);
 struct commit_graph *read_commit_graph_one(struct repository *r,
 					   struct object_directory *odb);
 struct commit_graph *parse_commit_graph(void *graph_map, int fd,
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 2c2f65f06c..f8a461767c 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -22,7 +22,7 @@ int cmd__read_graph(int argc, const char **argv)
 	if (!open_ok)
 		die_errno(_("Could not open commit-graph '%s'"), graph_name);
 
-	graph = load_commit_graph_one_fd_st(fd, &st);
+	graph = load_commit_graph_one_fd_st(fd, &st, odb);
 	if (!graph)
 		return 1;
 
-- 
2.25.0.dirty
