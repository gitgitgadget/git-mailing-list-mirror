Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7DEC55192
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18EF721473
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="JaKutsk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgDWVlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgDWVlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 17:41:16 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161EFC09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:41:16 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mq3so3042554pjb.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lynpfoXwYfpxnOFiOfS3Q3usZSFf+AAKP9sCVspmNxw=;
        b=JaKutsk2bNuc87mir++IjHpft1S6G8GIMdzRXkmeP5Ynr902P8QSo8/jMaafwaa4N+
         co0iv4nq8U+zVYBGENa8CRo7gYvatR0UUaIh79O8nxgZGSezzhW/obr0a1Fn4M5tvNU9
         FIkvoc0iWRS/vSynHHEZC4t4klBshbdh7dG2QhviJGATW7TmDvHjhvEB1mYnXz0wOEpE
         Zq7wTf3F9cvPq15IxOzrMKeeQJGmTMGhZEfPZeB+EYZG0XF0AGAXkpMSKfIWWb0hLbSz
         jTJ6S9XJCwuZLhRznuuJyWhDxfyUzhhhjyEeWQVS15xk7GgMEG+pvaA+dl/btoDIFEcE
         bIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lynpfoXwYfpxnOFiOfS3Q3usZSFf+AAKP9sCVspmNxw=;
        b=PESYtSP5IMyB1bLgVK9mg0iphLZ6cKEt06dCLpadsDZVv3GWi4pBUL8yDAkReMDffx
         RVrCwH000BnYLX8LA8z3PcyybNpVtO19CYlMAlU1vi+Bnn6JopxwyP3r3xfratPWE2cD
         Pnfz3wD3MRWFh8yHqCGqbOOKq1105Mazi1UBd/tETJA2sskCNv4xbLFN4CDiVv49XtHF
         0qMSvCJ/WqAC+Y6eSuJVrdGzJNqq99H6Oxkf6iENmo2Lc08LdZQCp1QYWpxjiwL/1LQ8
         uSTrp28OKhEIfE4W8UNdCTy0iCWc784hZTI2q1LtwHqGExqEiLdKT/Lill8Usnx5tEt/
         QIqw==
X-Gm-Message-State: AGi0Pubc5bDuwVwIAY8L/f+Al3R9THvxNwXrj43+354FpqOSobwpnsGS
        rB8N+zW6zXSV93JqYNNMr5G/2pX9CFi2zw==
X-Google-Smtp-Source: APiQypIqxKkgNtgcTqAeQygZgK5ZoZTKGRBRJoQ/fBDYSS0CNhKXd7MfpwGTqxzbpsTYZn+fkBInDQ==
X-Received: by 2002:a17:90a:1501:: with SMTP id l1mr2776485pja.82.1587678074955;
        Thu, 23 Apr 2020 14:41:14 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id h197sm3660437pfe.208.2020.04.23.14.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:41:14 -0700 (PDT)
Date:   Thu, 23 Apr 2020 15:41:13 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, szeder.dev@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH 4/4] commit-graph: close descriptors after mmap
Message-ID: <e05db264cb50760cab222157b436e82adeaeadc8.1587677671.git.me@ttaylorr.com>
References: <cover.1587677671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1587677671.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We don't ever refer to the descriptor after mmap-ing it. And keeping it
open means we can run out of descriptors in degenerate cases (e.g.,
thousands of split chain files). Let's close it as soon as possible.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c      | 15 +++++----------
 commit-graph.h      |  3 +--
 fuzz-commit-graph.c |  5 ++---
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b2d2fdfe3d..e9b458539f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -69,7 +69,6 @@ static uint8_t oid_version(void)
 static struct commit_graph *alloc_commit_graph(void)
 {
 	struct commit_graph *g = xcalloc(1, sizeof(*g));
-	g->graph_fd = -1;
 
 	return g;
 }
@@ -123,14 +122,13 @@ struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
 		return NULL;
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	ret = parse_commit_graph(graph_map, fd, graph_size);
+	close(fd);
+	ret = parse_commit_graph(graph_map, graph_size);
 
 	if (ret)
 		ret->odb = odb;
-	else {
+	else
 		munmap(graph_map, graph_size);
-		close(fd);
-	}
 
 	return ret;
 }
@@ -165,8 +163,7 @@ static int verify_commit_graph_lite(struct commit_graph *g)
 	return 0;
 }
 
-struct commit_graph *parse_commit_graph(void *graph_map, int fd,
-					size_t graph_size)
+struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size)
 {
 	const unsigned char *data, *chunk_lookup;
 	uint32_t i;
@@ -209,7 +206,6 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 
 	graph->hash_len = the_hash_algo->rawsz;
 	graph->num_chunks = *(unsigned char*)(data + 6);
-	graph->graph_fd = fd;
 	graph->data = graph_map;
 	graph->data_len = graph_size;
 
@@ -2125,10 +2121,9 @@ void free_commit_graph(struct commit_graph *g)
 {
 	if (!g)
 		return;
-	if (g->graph_fd >= 0) {
+	if (g->data) {
 		munmap((void *)g->data, g->data_len);
 		g->data = NULL;
-		close(g->graph_fd);
 	}
 	free(g->filename);
 	free(g);
diff --git a/commit-graph.h b/commit-graph.h
index 98ef121924..a0a2c4a1e5 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -66,8 +66,7 @@ struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
 						 struct object_directory *odb);
 struct commit_graph *read_commit_graph_one(struct repository *r,
 					   struct object_directory *odb);
-struct commit_graph *parse_commit_graph(void *graph_map, int fd,
-					size_t graph_size);
+struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size);
 
 /*
  * Return 1 if and only if the repository has a commit-graph
diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
index 0157acbf2e..9fd1c04edd 100644
--- a/fuzz-commit-graph.c
+++ b/fuzz-commit-graph.c
@@ -1,8 +1,7 @@
 #include "commit-graph.h"
 #include "repository.h"
 
-struct commit_graph *parse_commit_graph(void *graph_map, int fd,
-					size_t graph_size);
+struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size);
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 
@@ -11,7 +10,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	struct commit_graph *g;
 
 	initialize_the_repository();
-	g = parse_commit_graph((void *)data, -1, size);
+	g = parse_commit_graph((void *)data, size);
 	repo_clear(the_repository);
 	free(g);
 
-- 
2.26.0.113.ge9739cdccc
