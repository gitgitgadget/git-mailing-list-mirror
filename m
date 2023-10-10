Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D120CD8CB6
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjJJUdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjJJUdh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:33:37 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD66CA
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:35 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77574c2cffdso24862385a.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696970014; x=1697574814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HrhldJ5BiV5CHevI9UjIhPIAgr48MFPlcVr2jUR0coQ=;
        b=ttdlZTDDL5ovJdsJ1FU5HYSLnI64X4ua97gG63/c69oBEsNwH+FU5FswbY3tMfhmYK
         rZj4Wr61R4iKqOG9jQONZIBif670QT0YRR+Ws83suvZi87ZWyT84iolHdcyBfC7t/Z/Q
         B6vW2r1WZ205Lr665SL3OB/8ibiaP8NpVeICYXU9CFlzEALka2MAqzgrXurUVIIqnr0K
         ULvNtLUVWjyDmRqkO+ZN/IZwZFsvqXdsbx4VGgWC2wYsPNDQOze2IQRPjIyNydNUzuj8
         nAbJj2bffiCW1EoRhA0iTfy1+z1LjaAOhDU7iiEHOlnVl6lIzppQW8640L3C2Ft8PXPX
         YXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970014; x=1697574814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrhldJ5BiV5CHevI9UjIhPIAgr48MFPlcVr2jUR0coQ=;
        b=P79Ujf8vksExWObdhwKMWCe4bH2DlJ6boqjyDdx9p2HPX1UyDBom+uWq5VnGCcutzH
         TMlwjcDwIxVtHZYqBg97i0VaorQftqSUe84VErRYoRU4w4EUmGCVxeC1KzYlG++EOshz
         cFUuDzlME+E1NFjf+ZlZYFKISoB5TSLocx08vH9tCOXg+KZ+aqJ48TOTxQdAISEuvCki
         aX2MkPqcPcvVspRcMHnx39SvlfiJGVBnmlzUsAkip6ehCotD9h8qLu1YexscUGDcprDt
         col5I5o4V44grZMwwwTc4kD1ssh9jDhNTF6/I11RvXoxwGpfkQlHVzpcsou+0zwtA9+D
         PH4Q==
X-Gm-Message-State: AOJu0YxVz1xATkIjRMeg1Cv8FiDOJ/F8706EKfG7cvD7EIgYg6V9yQNJ
        YTxs/rYpVk7QuyOFFkscjn2zpM34egQPxhGJOBTQxg==
X-Google-Smtp-Source: AGHT+IGQClRCTwmQGRSXBHJbh41t9mXyvwWrvGiX76vsZZNTOdRypzHweC2NuqXHIQZjCmW+9xWaqQ==
X-Received: by 2002:a05:620a:2956:b0:765:734b:1792 with SMTP id n22-20020a05620a295600b00765734b1792mr22399786qkp.23.1696970014639;
        Tue, 10 Oct 2023 13:33:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z26-20020ae9c11a000000b0076ca9f79e1fsm4617602qki.46.2023.10.10.13.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:33:34 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:33:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 05/17] t/helper/test-read-graph.c: extract
 `dump_graph_info()`
Message-ID: <94552abf455c6d341a0811333ae4edb4a8cea259.1696969994.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696969994.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prepare for the 'read-graph' test helper to perform other tasks besides
dumping high-level information about the commit-graph by extracting its
main routine into a separate function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-graph.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 8c7a83f578..3375392f6c 100644
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
@@ -57,6 +45,23 @@ int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
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
 
-- 
2.42.0.342.g8bb3a896ee

