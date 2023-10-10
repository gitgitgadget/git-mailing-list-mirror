Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0474CD8CB7
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343758AbjJJUdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjJJUdn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:33:43 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130E09E
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:42 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-41b2bf4e9edso2204871cf.1
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696970021; x=1697574821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MX+pavq5/sxT1Zqj6yeMZBcPmMUxfU9Mt6wuoUTDNHA=;
        b=FMxfoRPggHlaWFO7g5IYvg0yCvf9HVbeVo+YIZlh91KfyJCqrs1pESxd7LZLUPtt/T
         Tn5HUcFwzSzzy/1g77wsZoK6eArbqiIZ6gLiRcHN00ACpvMDJvIadLBqxvXtSgLjMvwd
         Nnbl3hACvwH5blaZhn4fkuPUlNdk8p59ENd9eQFJ+xO2PQC9kIa1SPjAF0QbtOAZKhKR
         P8h16Ap5C1ukNhFCgR78i9Bfou6rIiPBmHeerdDCRxb7xBDPLN+/NQ2CQu6LOAloD32A
         08ihiYOJYwACQTPxpAAMMVkfeDvjPQIi27/4U5J5eDND3CDvrGvJio4lVl4u4vdg6fR/
         Ay9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970021; x=1697574821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX+pavq5/sxT1Zqj6yeMZBcPmMUxfU9Mt6wuoUTDNHA=;
        b=iOX1xe8Rxc27JrIL/uo0xX60LH4W8cY6PE2DJnsLMdNnB1oRaBatRAL0kelLnM3PEU
         IBJ0s4AF5+eQJfRT770pey4mkzI+HQPuaF0WimjDGC3qhESODLL7w5ZXaNfskOV4ctYN
         gNRyB8G9yh/TTJt1sGxjqeRKaeFmu0csV4FrsrppCX1fMBPNiXn1NvH3EPE5iwUzJK+7
         rgeBf3J3d1jg/s2WrWMzaWB74mydpx/QoNfS6VhU6FeqfD3yVAqfyq66e9UDWhlacHnA
         dPVam9EggWbpFsfNDoMX9RUz1kW09wIbcgxrzHP94Hgh8mrVIdRdAtT7k02qrsEsC6IP
         VyVw==
X-Gm-Message-State: AOJu0YxAMFdlgUd8aqXcYRC4Zl3eDW8LQnPVSQx75VGJeb5MetJK6SGZ
        +LdCVR2eaZd7EC+NcfiTvvDwVonQo6cCnwKs3t1BPA==
X-Google-Smtp-Source: AGHT+IEMw0S+xa7FB43lx3uoWqi5mq/Waj67oyVyqyM3BxasPcOMskioQGZrS3pM3lQHdkMo5yZYRQ==
X-Received: by 2002:ac8:5b02:0:b0:418:11ab:1bf7 with SMTP id m2-20020ac85b02000000b0041811ab1bf7mr20775256qtw.30.1696970021013;
        Tue, 10 Oct 2023 13:33:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g10-20020ac84b6a000000b00417dd1dd0adsm4798765qts.87.2023.10.10.13.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:33:40 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:33:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 07/17] t/helper/test-read-graph: implement `bloom-filters`
 mode
Message-ID: <d23cd8903722966ec40fca7d76e502bf815e611e.1696969994.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696969994.git.me@ttaylorr.com>
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
2.42.0.342.g8bb3a896ee

