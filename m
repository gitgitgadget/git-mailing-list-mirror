Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28282C433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0144120723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fo5NESDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgE2Ivd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgE2Iv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10420C08C5C8
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l26so2319922wme.3
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DkYxr9eR1tUXrGS2oYdrcl4hMsAHKOufUaJa6EKXO5I=;
        b=Fo5NESDNXHWc+n2oMn6WaNNDaIS4VmZGOz5zEb2WSR47ezxMlQZk7br1A1x2tDNShC
         fFShTja5SWLpuoSjUb0+ZIOyZqLKtzf9mUI+WC85MGNKa1N/+EtC+SzrUz7WsK1qf1Dt
         9VIXuJMeQGoFnQguoelhsSNCXIWp/P/bN29cb2HzBkTtTLSHUCWB1RL4n7a3Rsyf7vSM
         W7lyFBIH3zXFAtpCVD3mv9y8qUNlzRzEZOiHX97CTc/PPX6QPKKYwPtXsc4/QXJsuiae
         hlq0wy1v0dId7tiwnCqI9Qaqo/Q8p7gnUDyIP47fKlbBzcW2WPL4kamZ8O5J7onJHTS0
         a3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DkYxr9eR1tUXrGS2oYdrcl4hMsAHKOufUaJa6EKXO5I=;
        b=uacrlTFeCBbmQ9WplgfFU4ANteL7xpY+jwO7keoIEGgBP0Ovk3NBIt5z37FiMz5ovp
         nEtxe6X39r7KNFEPPZximd5NSDEZ1q6ur6i19OU5LC2UE9KRAV4rj/ODnim9GTSEczqu
         uQ4Vm/Vu5rp0coCMQx6Z0fcQLdq4nYRRxFbOf7Nd7rex81wVvX8EjB+2Y7UFFjZjKHs4
         jvMPHToYgBMAjQGTbDJsoPZwaS/qpiL7WQi685UyDOF2tuxSzVNLlC6HRmfkuotw4noo
         xiYcr+qjpgEitQei/YreA8Tr42lbnLTqh0vt77KEzWVgHYom7hGbFJJDPvwQ1NakygdO
         Q4iw==
X-Gm-Message-State: AOAM531Lwt8QFtJ/Iklg2nOiEbjojMAn2WnT3AizR2HqdLNyLhiVmVd4
        tLbJUMdHXokAVwYld0Q9PuepmGF9
X-Google-Smtp-Source: ABdhPJwB5tFmMDqV2IXuCpw99VuWqTuyIxdhOc7nW3xuMo7/+PG9ZDBeQAkGvMQsIgx9QrflLeAkXw==
X-Received: by 2002:a1c:7305:: with SMTP id d5mr7758964wmb.85.1590742286491;
        Fri, 29 May 2020 01:51:26 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:25 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 19/34] commit-graph: add commit slab for modified path Bloom filters
Date:   Fri, 29 May 2020 10:50:23 +0200
Message-Id: <20200529085038.26008-20-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 commit-graph.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 28f147a418..3a38f25ce9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -14,6 +14,8 @@
 #include "hashmap.h"
 #include "replace-object.h"
 #include "progress.h"
+#include "bloom-filter.h"
+#include "commit-slab.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -47,6 +49,20 @@
 /* Remember to update object flag allocation in object.h */
 #define REACHABLE       (1u<<15)
 
+struct modified_path_bloom_filter_info {
+	struct bloom_filter filter;
+};
+
+static void free_modified_path_bloom_filter_info_in_slab(
+		struct modified_path_bloom_filter_info *bfi)
+{
+	bloom_filter_free(&bfi->filter);
+}
+
+define_commit_slab(modified_path_bloom_filters,
+		   struct modified_path_bloom_filter_info);
+static struct modified_path_bloom_filters modified_path_bloom_filters;
+
 char *get_commit_graph_filename(const char *obj_dir)
 {
 	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
@@ -1008,8 +1024,18 @@ static int write_graph_chunk_modified_path_bloom_index(struct hashfile *f,
 
 	hashwrite(f, &ctx->mpbfctx.num_hashes, sizeof(uint8_t));
 	for (i = 0; i < ctx->commits.nr; i++) {
+		struct commit *commit = ctx->commits.list[i];
+		struct modified_path_bloom_filter_info *bfi;
+
 		display_progress(ctx->progress, ++ctx->progress_cnt);
-		hashwrite(f, &no_bloom_filter, sizeof(no_bloom_filter));
+
+		bfi = modified_path_bloom_filters_peek(
+				&modified_path_bloom_filters, commit);
+
+		if (!bfi || !bfi->filter.nr_bits)
+			hashwrite(f, &no_bloom_filter, sizeof(no_bloom_filter));
+		else
+			BUG("writing proper Bloom filters is not implemented yet");
 	}
 	return 0;
 }
@@ -1864,6 +1890,9 @@ int write_commit_graph(const char *obj_dir,
 		ctx->mpbfctx.num_hashes = GRAPH_MODIFIED_PATH_BLOOM_FILTER_DEFAULT_NR_HASHES;
 	}
 
+		init_modified_path_bloom_filters(&modified_path_bloom_filters);
+	}
+
 	if (ctx->split) {
 		struct commit_graph *g;
 		prepare_commit_graph(ctx->r);
@@ -1984,6 +2013,11 @@ int write_commit_graph(const char *obj_dir,
 		free(ctx->commit_graph_hash_after);
 	}
 
+	if (ctx->mpbfctx.use_modified_path_bloom_filters)
+		deep_clear_modified_path_bloom_filters(
+				&modified_path_bloom_filters,
+				free_modified_path_bloom_filter_info_in_slab);
+
 	free(ctx);
 
 	return res;
-- 
2.27.0.rc1.431.g5c813f95dc

