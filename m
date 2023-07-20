Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E3CEB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 21:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGTVrF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 17:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjGTVqz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 17:46:55 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCE1270D
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:46:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-573cacf4804so11740257b3.1
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689889611; x=1690494411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FMSEtBgqHrUV7fVgpLlX3v8Cs/zi9q784OT1a7GL5v8=;
        b=XBQ4MJvFruBP0WzepKVf/qW2IUobaiRgGYrIbGjg1AlYrAEk/OrQwYj3NR3LaokVi6
         CJyR8n43BE+zi18jnZFinohsAmEwvcR11wW4w94x9CVYJLz2C+fy3KrIsN0qgrmF1jl8
         tfymkf1TiJdzA6od8xvE9/B71MDpbntfuME+6vW9mqsN83QC6txzJXDoBLxCDB5ErnV6
         MbObJJkOlf1FujoldhUJKvwR3Ns8Qwsh715/50kBZRIdaRIbRbDrB9nmX/9LLlCmErX8
         B14OScXEOg/xek9wi79MlxAP5SbF7u7n4q1ysPo3M3bLohdJArJFYAFKV/svtVF8TUsI
         9otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689889611; x=1690494411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMSEtBgqHrUV7fVgpLlX3v8Cs/zi9q784OT1a7GL5v8=;
        b=Cr8/eNtD1f7WWaQy4F5e4IjE56Mixu9yJnpowJ/EoxhnF7T6wr9xQGpDP0yK8aoOTy
         zhsjpzeW73BMui+RDRR5U5OmJlLVqVI1QicJY885kqPI+LqH8w5EsBRJbNxPjehRjq4Y
         5Skp+hajQ2bbJIRr4R8T1JSLN3zy+txRXV5sbCtsabiqLtfUhQjSUXUGg1Gw5+0WB+QF
         VcRihkHOuoJxkQuFdDKyWWwaQG1c/vz+aCPl1xkKr3jqOBIfKN7rcATIMSCJKpqJzs7q
         30zfCJOHu273Yo3sv4t2HUcdk5Y/edxwSCgFubmDGJSCitfiSVx9c7+hfUoahjkGk4GI
         lQxA==
X-Gm-Message-State: ABy/qLZoi3AShnHImaXtFFsHIS0RcIKrVtAxhfiQrslpFf9nRK6slx8p
        RzMW2XFsNLejoziaELIY+X8dK1on5ZbYEBvraFGy11ucW+0SfSaP2YTtAX2chr/BK3Ldvkr4RFQ
        K97JgjI8UNHhjiqQNc6kywco2yzah9AxovoMPJshuFTWjw3nEwgou5YEiY4JW8RKKeHNgMQiJUH
        NA
X-Google-Smtp-Source: APBJJlEUxYZ6JLq2uX3BwvebHzhAgTpVbq8mdMyqZXPnQZlSlVoPALCBr3bQOy61nmABYfDCuPAu5Q2d6MXKed7FR/Q/
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:387b:f15b:5fda:c8a5])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b60e:0:b0:579:efd3:967 with SMTP
 id u14-20020a81b60e000000b00579efd30967mr4395ywh.0.1689889610954; Thu, 20 Jul
 2023 14:46:50 -0700 (PDT)
Date:   Thu, 20 Jul 2023 14:46:37 -0700
In-Reply-To: <cover.1689889382.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1689889382.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <47b55758e603debbcecdc817d016714ab98e2b54.1689889382.git.jonathantanmy@google.com>
Subject: [PATCH v6 4/7] t/helper/test-read-graph: implement `bloom-filters` mode
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <me@ttaylorr.com>

Implement a mode of the "read-graph" test helper to dump out the
hexadecimal contents of the Bloom filter(s) contained in a commit-graph.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-graph.c | 42 +++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index c664928412..da9ac8584d 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -47,10 +47,32 @@ static void dump_graph_info(struct commit_graph *graph)
 	printf("\n");
 }
 
-int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
+static void dump_graph_bloom_filters(struct commit_graph *graph)
+{
+	uint32_t i;
+
+	for (i = 0; i < graph->num_commits + graph->num_commits_in_base; i++) {
+		struct bloom_filter filter = { 0 };
+		size_t j;
+
+		if (load_bloom_filter_from_graph(graph, &filter, i) < 0) {
+			fprintf(stderr, "missing Bloom filter for graph "
+				"position %"PRIu32"\n", i);
+			continue;
+		}
+
+		for (j = 0; j < filter.len; j++)
+			printf("%02x", filter.data[j]);
+		if (filter.len)
+			printf("\n");
+	}
+}
+
+int cmd__read_graph(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
 	struct object_directory *odb;
+	int ret = 0;
 
 	setup_git_directory();
 	odb = the_repository->objects->odb;
@@ -58,14 +80,24 @@ int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
 	prepare_repo_settings(the_repository);
 
 	graph = read_commit_graph_one(the_repository, odb);
-	if (!graph)
-		return 1;
+	if (!graph) {
+		ret = 1;
+		goto done;
+	}
 
-	dump_graph_info(graph);
+	if (argc <= 1)
+		dump_graph_info(graph);
+	else if (!strcmp(argv[1], "bloom-filters"))
+		dump_graph_bloom_filters(graph);
+	else {
+		fprintf(stderr, "unknown sub-command: '%s'\n", argv[1]);
+		ret = 1;
+	}
 
+done:
 	UNLEAK(graph);
 
-	return 0;
+	return ret;
 }
 
 
-- 
2.41.0.487.g6d72f3e995-goog

