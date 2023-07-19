Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A2DC001DE
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 17:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjGSRzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 13:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjGSRzw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 13:55:52 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6371FCB
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 10:55:51 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5634808e16eso4583821eaf.2
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 10:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689789350; x=1692381350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yoDq01+VNd7jmgdH9dZC8g/2pAdNYqa10qv8NrzKSaA=;
        b=2PVJaQm6DMVEtTZOp3N9hibLaiI8DRkfwK30Ly4AUZ78bic+37BoCIhIxgud6Le1sD
         vnz9YWYYXaQJj8OfptfK9yqhSLxhoqiHKhRg3n3JAbzU8nVpl5gQufpzbSQpTkvoQN6o
         Lsy/LGE1OiA35+mN7pfyUJatT10Qmq5o8LCKo90NCCZRrxKiNmwxP72aWSIxn2GDHCJi
         PoJX5Ul30vXdY/vMfdRpyqiy1hjsAjFvewF8b4BDXCvxOV59//wWOeom+oL++uu71KBS
         l8lq2/Wn9meE210rbrQ57yqef7u6NZ2s/qN3SY+ZZvqcaMV4K9GmxIeZjN4LPgSKD2vt
         QSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689789350; x=1692381350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoDq01+VNd7jmgdH9dZC8g/2pAdNYqa10qv8NrzKSaA=;
        b=cFzQtnn4eg0T3/WZDVkdUrKKxjHg0pRD12D5mn0yRoOpz8kp+NN671XQp6hrpLWYoB
         ZJd4cwWt/YbAmaGTLKU8X1td3zDWPxk50eRWIBzFjfW67tmxZTFxopDtz1KpZdmdkx26
         UDlZFnhhgYL4DfMOjE773vxxBpdVedY5A5OfsWIZjfoCbglrSd1SdogYa/Myajia6axG
         BqJB2+eFuzX0kwKXBjJM8PFQQgHSyWuvxI2JBlTbN8Z8weEZdRj2TMM9tX8YwyuTKkTR
         wZR6p5fs+niO2vWzMHFbxe4EvVA2BuzJBSCR0zFQ6DYZlaKur/ycK2mNusCwVo9YLOoI
         v+Pg==
X-Gm-Message-State: ABy/qLZwqi8SoND9mI2OVAoU2azRWC32J87mXqI8ygNLvBft9EP146K3
        3Gbw3HfkhXicmiU2SCqXASK/4v9LuMKR0sjytQKhlQ==
X-Google-Smtp-Source: APBJJlF+9n5WqeJ5fKqT+iFUcva6MNZyhJGOD9as84llHE8biXmR0mNFEBmZ6+zg8CdWM+GpVu+1uA==
X-Received: by 2002:a05:6808:14d5:b0:3a1:f237:ec62 with SMTP id f21-20020a05680814d500b003a1f237ec62mr8441506oiw.48.1689789350681;
        Wed, 19 Jul 2023 10:55:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t62-20020a0dd141000000b0057725aeb4afsm1134357ywd.84.2023.07.19.10.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 10:55:50 -0700 (PDT)
Date:   Wed, 19 Jul 2023 13:55:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] t/helper/test-read-graph: implement `bloom-filters` mode
Message-ID: <51463636135842c1041af54ea460a54e2cf3055a.1689789226.git.me@ttaylorr.com>
References: <ZLgc5q0FrL1s7j0j@nand.local>
 <cover.1689789226.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689789226.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement a mode of the "read-graph" test helper to dump out the
hexadecimal contents of the Bloom filter(s) contained in a commit-graph.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-graph.c | 42 +++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index c6649284123..da9ac8584da 100644
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
2.41.0.366.g215419bf3c2.dirty

