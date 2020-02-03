Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92AFC3524D
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 21:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAA22087E
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 21:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="dD89+Zsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgBCVSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:18:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41706 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgBCVSG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 16:18:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id t14so6344091plr.8
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 13:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rcue2sRtSBCn2qWsekG8m907Ng8gf/+kVKluGsHflS0=;
        b=dD89+Zsj3r5py+X1QQUIhx/PzbkweE6UVWVOucygbtrDu8EDOHLiFmQUKTWPm9zm+7
         YAo71D5LwmYM6t7jKohceFMLT0jpmPwM4i0TPNQYf2v7MrqhTyqfa9/EsBoPWcomPhAJ
         +MgQlne1go0vhOwCcPxPxpC956iD4iEhbRR5wPM2LhCk9vCBQvJeO+I+Ceb+ng8TK4+c
         UwP1rTEJMxFUDRuX6Nm7IRF1A9Z+Op0VScwhKH7PnrNfiuDZZz4R1khLpXS5ptUHj5JR
         s1oksb6Wg0PSJapDvYdMGHEaV9ehaw10f+AcQTYepeV5DfVzGcsq6On5JGSPMfAVqVoU
         KzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rcue2sRtSBCn2qWsekG8m907Ng8gf/+kVKluGsHflS0=;
        b=Ox4HX5re7j2F8BT1r5SCxyZuwx084vD/bu7L+lPp5+DdTH9V/6hsjplDy5PbAeLQCW
         P27jY4m+O5SGhPNXE2T5rt/ydBjvGoEl8Vlb4GKOJaMOypV3E2zo8xbqd90Jb2FkrXkw
         muSHAKt19f/G1+9Zz8qH+fXR4utLi2pgwMjQItED6ujtZblhfnz90YolUfXP1PcYYdi3
         9AgKz+9rJDRPYv3rEBwNXCfmH+9Mdp+JqQzU8KW5slTnqNhzBVbTGvYJaGY7N5+qe/Gq
         PxyRJC6ENvD8U+KdYZTAVbC/ZjyYBSxlxtrRfxlFwgSawB0Q9jlD/xbrIl+M+T6Neqrd
         q7kg==
X-Gm-Message-State: APjAAAXfqWReBp8e4U58VR7bNPKK8JoHkXp3V68scQuP+gQoQbYQaXvk
        3jG6YZJ58YeSFG7Uc0rrfnCmJBkevmPGgg==
X-Google-Smtp-Source: APXvYqy1HvZc+6HVMuXh+1K6PGw6KYJ1LrUh/crN3YSihqWE8gbWF7/caAhMflUJbwcrJQT0qzg1zw==
X-Received: by 2002:a17:902:34a:: with SMTP id 68mr24444535pld.250.1580764685077;
        Mon, 03 Feb 2020 13:18:05 -0800 (PST)
Received: from localhost ([205.175.106.126])
        by smtp.gmail.com with ESMTPSA id d2sm386341pjv.18.2020.02.03.13.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 13:18:04 -0800 (PST)
Date:   Mon, 3 Feb 2020 13:18:04 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [PATCH v2 5/5] commit-graph.h: use odb in
 'load_commit_graph_one_fd_st'
Message-ID: <aa12b7378b90abff5cb288a64fbe4a1b335cf73b.1580764494.git.me@ttaylorr.com>
References: <cover.1580424766.git.me@ttaylorr.com>
 <cover.1580764494.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1580764494.git.me@ttaylorr.com>
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
index b16eba2a7a..dd6ab84be8 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -95,7 +95,7 @@ static int graph_verify(int argc, const char **argv)
 	FREE_AND_NULL(graph_name);
 
 	if (open_ok)
-		graph = load_commit_graph_one_fd_st(fd, &st);
+		graph = load_commit_graph_one_fd_st(fd, &st, odb);
 	else
 		graph = read_commit_graph_one(the_repository, odb);
 
diff --git a/commit-graph.c b/commit-graph.c
index 49541760b5..656dd647d5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -108,7 +108,8 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
 	return 1;
 }
 
-struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st)
+struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
+						 struct object_directory *odb)
 {
 	void *graph_map;
 	size_t graph_size;
@@ -124,7 +125,9 @@ struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st)
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	ret = parse_commit_graph(graph_map, fd, graph_size);
 
-	if (!ret) {
+	if (ret)
+		ret->odb = odb;
+	else {
 		munmap(graph_map, graph_size);
 		close(fd);
 	}
@@ -299,7 +302,8 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 	return graph;
 }
 
-static struct commit_graph *load_commit_graph_one(const char *graph_file)
+static struct commit_graph *load_commit_graph_one(const char *graph_file,
+						  struct object_directory *odb)
 {
 
 	struct stat st;
@@ -310,7 +314,7 @@ static struct commit_graph *load_commit_graph_one(const char *graph_file)
 	if (!open_ok)
 		return NULL;
 
-	g = load_commit_graph_one_fd_st(fd, &st);
+	g = load_commit_graph_one_fd_st(fd, &st, odb);
 
 	if (g)
 		g->filename = xstrdup(graph_file);
@@ -322,12 +326,9 @@ static struct commit_graph *load_commit_graph_v1(struct repository *r,
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
 
@@ -406,13 +407,11 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
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
index 5a690723b0..e87a6f6360 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -61,7 +61,8 @@ struct commit_graph {
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
2.25.0.119.gaa12b7378b
