Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B2EEB64DD
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 21:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGTVqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 17:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGTVqx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 17:46:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2A02711
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:46:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c6db61f7f64so1098340276.0
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689889607; x=1690494407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X6j9AI68U4Y1AUd0e55eKzy69G8jkfku1jDNd6XpLp8=;
        b=OX88op/5w8g7WdO2D/eTMhAcqyJz8i4qNYVOBeVwCBJXUXBkGFFqSHnyqUQlnnwpfz
         1Y23N5o0weWg7hlIzq7pfR+Jmw3fLxT/qzIjcUPm3Rs1b2ES+45lblGdmGsuP1ahvYGA
         ooTcmNtN+V/HliRzYPOX6QAtC7Cfme5hKjbgf7L03Dt70fHpIbg+24rF0wLH6oeOh1Yq
         KQm6NQXLZ59O6axWH9y5I+QipvqyHyWxxM4r+ApdHqsJVBR5dZRFE5P3PuIfzhRIWnsd
         muh8QtyOy8D6xxzQ6/FXvgWReh1m8HOg1rDvDAZpIw9qs09KCjfMR+dON7Z0cvgJ1x7o
         ZkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689889607; x=1690494407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6j9AI68U4Y1AUd0e55eKzy69G8jkfku1jDNd6XpLp8=;
        b=FC3jzhQRniENj40b0tv4tkkyk9aZxlD8gSyYqBjOXeCKkWmInyO3eUVZpXBJMwpWkC
         5JP2guZSCfoqnIqVzzoWIX7boGaOrXNLSCNcRdvEqgL7rl5j0tSmwX5+41Rrkjxjc9la
         YKOumxzpiEWldXfzj/eGiim7MBkmAjnIFi0D1euf9FoJxabdf6UBft+ddonvABOXMOgL
         r6jrOaO+u+8Zr8lt4FSyLHuYtgjhI5gZ7HdNJd5G1VWYEx6EuT1M7a3t8XN/SRRmnYAi
         /n/idEUUPkd1FTBIUjAuWoDsuuLC4BUiYpMW1m0ibk8BaWYCwfBa5BXDy0d6U3Snt56s
         lVPg==
X-Gm-Message-State: ABy/qLZB0bM+t77qJcSJmXgoaPRdY+CaB/qqAAl+FWf/FZADP59uB9LM
        5CZW9Ghed21UvpYaI5bB8wauL/luKY/Otkx1rS/OONTO2J1rmI+ytQY4vG+8hf+/EMtf6GesWDf
        q1BeX1eI2ansWS2rrMrDjR1EDG5JIrw6Xf62LeKs8XrduCkSpHZW4hhvYR+QHBK2ApLOb4BXdUn
        NJ
X-Google-Smtp-Source: APBJJlEjtVyBQakS6d3ZxZ83h2pJM++utcCrDTyAFfEMy03sQ8QWL+ZZOEW1ivnEvo5BkztbDihbZJjku05gp8RsTimL
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:387b:f15b:5fda:c8a5])
 (user=jonathantanmy job=sendgmr) by 2002:a25:404a:0:b0:cbf:8936:4cb8 with
 SMTP id n71-20020a25404a000000b00cbf89364cb8mr1951yba.2.1689889607355; Thu,
 20 Jul 2023 14:46:47 -0700 (PDT)
Date:   Thu, 20 Jul 2023 14:46:35 -0700
In-Reply-To: <cover.1689889382.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1689889382.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <1955734d1f7385ccc1bd3bb189b72e36d8a9b6ec.1689889382.git.jonathantanmy@google.com>
Subject: [PATCH v6 2/7] t/helper/test-read-graph.c: extract `dump_graph_info()`
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <me@ttaylorr.com>

Prepare for the 'read-graph' test helper to perform other tasks besides
dumping high-level information about the commit-graph by extracting its
main routine into a separate function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-graph.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 8c7a83f578..c664928412 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -5,20 +5,8 @@
 #include "bloom.h"
 #include "setup.h"
 
-int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
+static void dump_graph_info(struct commit_graph *graph)
 {
-	struct commit_graph *graph = NULL;
-	struct object_directory *odb;
-
-	setup_git_directory();
-	odb = the_repository->objects->odb;
-
-	prepare_repo_settings(the_repository);
-
-	graph = read_commit_graph_one(the_repository, odb);
-	if (!graph)
-		return 1;
-
 	printf("header: %08x %d %d %d %d\n",
 		ntohl(*(uint32_t*)graph->data),
 		*(unsigned char*)(graph->data + 4),
@@ -57,8 +45,27 @@ int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
 	if (graph->topo_levels)
 		printf(" topo_levels");
 	printf("\n");
+}
+
+int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
+{
+	struct commit_graph *graph = NULL;
+	struct object_directory *odb;
+
+	setup_git_directory();
+	odb = the_repository->objects->odb;
+
+	prepare_repo_settings(the_repository);
+
+	graph = read_commit_graph_one(the_repository, odb);
+	if (!graph)
+		return 1;
+
+	dump_graph_info(graph);
 
 	UNLEAK(graph);
 
 	return 0;
 }
+
+
-- 
2.41.0.487.g6d72f3e995-goog

