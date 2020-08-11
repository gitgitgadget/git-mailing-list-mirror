Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A7CC433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA08220774
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="To3+7wEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgHKUvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKUva (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 16:51:30 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B25C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:30 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c12so10538252qtn.9
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V9PKuOid9ZDCDhUVkEnzx8062h6610ZwJ92cJXhzY/I=;
        b=To3+7wEeQ+ZoAiecrBCN4Jy3SeuaKDEYoEUxcmwk9DhzAgSaBIB4fVq6j897412vLc
         BUYk9kRNBGkAPo6Yhn7mKsFmDLWBIVZmj9G86AagrMAxHXlH5VC+6q0mF1W/MmweWhDm
         xdOfVkmdBkgD0/3Nf+90yTqUowGKH6MYrS9NVWD5Ekrcz/17PUTYmYXBnYvli9QlV9MM
         6ojiS+vNFg3RDytnwhpb2wDg5tBOKP3OT3UsF6kLqM2eHv8ODHnbvaVrTf6wnFCoHVqW
         XeO8OCHP1TllmBoBRLWk9SWKh6doSwvDNJJwqvep+Wll9bNvBnYFQM4vMuQlG0hUiHRb
         vDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V9PKuOid9ZDCDhUVkEnzx8062h6610ZwJ92cJXhzY/I=;
        b=cCTzv1sgZd7x5KDTmLSjhMSSSidfqghYjiql2H1G6ktycUZw7pJF6ALre6tkzMy+wr
         frFGQoqWN1DvHBKcvNLoOOGpvq55ENNT4FOI2UjqsoyUhJ7tUZQNbWMaMszXl6XiScu3
         aX4IF7LfxZioUf1BmB+YGJXvA8Fl2a6vBm9f7/oxmSHVCE8XzLgAwasXqRb2ZighovHP
         vBd9mZJ0mZQZoxHH4sWYEUQrOhGFwRasP6Lc3ZnotV27mgO86rrNeiO8OZrfEcjT0KY1
         SpNv9mgc93gNpx/uceJU1U+uwod6VtDSB/cPcE8bH1+31OzoB9dKWCVlzcostON49ya/
         5EJA==
X-Gm-Message-State: AOAM531inmCPN9/um8UbMoUg1Xn7XOD5Kc57XWebG++y8Ghur27sFRg0
        WxCeA+n+qxHZZnmLmQxkQNlWKiAq/DNYTgIk
X-Google-Smtp-Source: ABdhPJwl6CHmkbyVB63HkF54pgRfyyB7HFfHgAzG0J9VreCWvbsN7g4HTEKB7f7f/Gu2T522ZewaBQ==
X-Received: by 2002:ac8:4511:: with SMTP id q17mr3023471qtn.117.1597179089546;
        Tue, 11 Aug 2020 13:51:29 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id d8sm20917170qtr.12.2020.08.11.13.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 13:51:28 -0700 (PDT)
Date:   Tue, 11 Aug 2020 16:51:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com,
        gitster@pobox.com
Subject: [PATCH v3 03/14] commit-graph: pass a 'struct repository *' in more
 places
Message-ID: <8dbe4838b725e21d7bfe16eb2c4e15e68f620dd0.1597178915.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1597178914.git.me@ttaylorr.com>
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
index d4b06811be..0c1030641c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -224,7 +224,8 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
 	return 1;
 }
 
-struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
+struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
+						 int fd, struct stat *st,
 						 struct object_directory *odb)
 {
 	void *graph_map;
@@ -240,7 +241,7 @@ struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	ret = parse_commit_graph(graph_map, graph_size);
+	ret = parse_commit_graph(r, graph_map, graph_size);
 
 	if (ret)
 		ret->odb = odb;
@@ -280,7 +281,8 @@ static int verify_commit_graph_lite(struct commit_graph *g)
 	return 0;
 }
 
-struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size)
+struct commit_graph *parse_commit_graph(struct repository *r,
+					void *graph_map, size_t graph_size)
 {
 	const unsigned char *data, *chunk_lookup;
 	uint32_t i;
@@ -445,7 +447,8 @@ struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size)
 	return NULL;
 }
 
-static struct commit_graph *load_commit_graph_one(const char *graph_file,
+static struct commit_graph *load_commit_graph_one(struct repository *r,
+						  const char *graph_file,
 						  struct object_directory *odb)
 {
 
@@ -457,7 +460,7 @@ static struct commit_graph *load_commit_graph_one(const char *graph_file,
 	if (!open_ok)
 		return NULL;
 
-	g = load_commit_graph_one_fd_st(fd, &st, odb);
+	g = load_commit_graph_one_fd_st(r, fd, &st, odb);
 
 	if (g)
 		g->filename = xstrdup(graph_file);
@@ -469,7 +472,7 @@ static struct commit_graph *load_commit_graph_v1(struct repository *r,
 						 struct object_directory *odb)
 {
 	char *graph_name = get_commit_graph_filename(odb);
-	struct commit_graph *g = load_commit_graph_one(graph_name, odb);
+	struct commit_graph *g = load_commit_graph_one(r, graph_name, odb);
 	free(graph_name);
 
 	return g;
@@ -550,7 +553,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
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
2.28.0.rc1.13.ge78abce653

