Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513FFEE4996
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjHUVoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjHUVoO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:44:14 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8F8184
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:09 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-58c92a2c52dso43639987b3.2
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692654248; x=1693259048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NxNwZkn3g2SSRrZUNiETz3zUJWWuDbypV2yIC9yy4zs=;
        b=YJikXEE8jx79WiAqNKMwTMvL69WT2F67z+/QueDss/FWR2W/pKfFLPGExAWZwTNad9
         ++t72fifHTuU7f/UvyLTT2c0f8GVcKJmTGzf/aqWr3TlTzZxR9ybtIpzuF84f1g5HpsL
         Dj45WAvvdlQhTWIgdpUbgzsl5xu3vwuor22KEtfRMzQxlrK71MFlo9GMtdKbrjWaZUmr
         9fjF20oJJHp19kvLWs9dOE1U/3vEiLwH1pXtb6hb/6/N1OL6KRQOlE1hWrly1xSaGsVU
         v/MGc1fZyKhfvIieEfYvq/sLLcN4NTfkpK1bF9mnjsB+dZsIv5eUNLuVFL+njZeoKaFS
         J58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692654248; x=1693259048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxNwZkn3g2SSRrZUNiETz3zUJWWuDbypV2yIC9yy4zs=;
        b=joMa6jJ3h6tmyk1Le7zcHns83d0pjsOvLaS1JOjb8qwiVqNR9Ne1eTQTmvYiRd8i+b
         4cOykUiCJY3dEfpJ8sWVNoiEMpZSvY66yVEBXN1iMVpXoNGd8Mxnk5CmKVh1KG1yaGq1
         XNIFBcgbYeH/WXaLHohdABxxYd9ishcsNmERVoXjgzcEjh9Z6ItGB+kB7Yzexl5iU2zx
         7FCgcSM+c2eE+dxLWDPRsrlWFtGw/Qo2T7etyDjt7wPxLF/JDDS3nsEeHJQ7jBrzYVWR
         UjnuqCt6IJrS8Ihu1lFO7EGV/4RSgsaoylOngB22yTjOtJXWf3fPymS5xNOAn7ZW8Bho
         U5zQ==
X-Gm-Message-State: AOJu0Yybj7b2Y38NvSwvZBGFN1MScoTl97HztIJcGIAGyzqABViDUIwA
        bp+QWeBRxF1BJn/OwIz0gq7UVja/ZrCqibT+3ARsVQ==
X-Google-Smtp-Source: AGHT+IGAxb0FU1M9YZtgpYb+QTZCEtwOz5FMP1HYSbUjlgw1utFhVT3WBWUuf9N8yERP0dd6lmnX+w==
X-Received: by 2002:a81:5cd4:0:b0:586:a141:3b3e with SMTP id q203-20020a815cd4000000b00586a1413b3emr8726061ywb.13.1692654248414;
        Mon, 21 Aug 2023 14:44:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n2-20020a0dfd02000000b005837633d9cbsm2423405ywf.64.2023.08.21.14.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:44:08 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:44:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 04/15] t/helper/test-read-graph: implement `bloom-filters`
 mode
Message-ID: <9a98ca09dc85d1bad79a79425fe88c83f5756c14.1692654233.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692654233.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement a mode of the "read-graph" test helper to dump out the
hexadecimal contents of the Bloom filter(s) contained in a commit-graph.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-graph.c | 44 +++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 3375392f6c..da9ac8584d 100644
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
@@ -58,12 +80,24 @@ int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
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
+
+
-- 
2.42.0.4.g52b49bb434

