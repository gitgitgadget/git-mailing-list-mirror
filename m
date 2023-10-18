Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB64368C
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="y852t2M7"
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8C1125
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:45 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-777506c6109so355478285a.3
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697653965; x=1698258765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bs46mJLdtTTiZ7uimsM5rjSde3YMEpzT/41x50J7HDY=;
        b=y852t2M7FpErEm0UVl+FOhOem8DK6sahbEp5fvEfn9vwH8hC0u2vnwBr8iNZ7FCH9V
         yPWAIBbQ6seHdfLI73h+uK63HDvpHmTPD6hhVdAJNkTeT9KvzvBthAzlJ9CIHni9SZxp
         gkXsfLJ46FldEgysR0QsRw4d2RcuwPn+g6enlMBoQAazh9A5cSoHoy2TFrySTLpxl7xc
         tpy4tpy/IEMhLbwU06lxXPpyhcJVp9/VJSf27LmCcWm78b+uRCZlqPHSc55XJZ/K4yMT
         yT4mVLU2DRmZXRtiAfCIfgLbl5zJ5LRVFg9YNLZmoffMGtXPr+ymIa+UJywNvNpkCfgh
         zY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653965; x=1698258765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bs46mJLdtTTiZ7uimsM5rjSde3YMEpzT/41x50J7HDY=;
        b=b0dM1Ij80fIvwsHBMp73MnMGTe5RS9AePouc4C5pN55flGnK/SnZwxAxp36xPLRL3I
         krbJ1czT1P3N+3Po536JdjjAtI2In1FTtMcXfR3gKVy7EOd5XvQg5+Nuc2n7Vtb3SZ/x
         SzhpKZBXdJTQosssYV9Nlq4Vc6Rk9dCFBbHzr3zLMiAHamCL21SLQjIIMIqg+EPYeRdv
         hmqU6zKF1VuvpFmchtpWmY8B7/qRVXEAavkCdwCfVuJ0q5pA73sc1b5McEtWCQgDn4nH
         QXvUbpz3Y3+zNTFpC4mh+/RWfSSgy6TuT23qtCYxPNLNuGWXfBKfIeBqHftW4c5mR8I/
         0w4w==
X-Gm-Message-State: AOJu0YwrGX21Djvb7JWcEJgIMbMQzv4WNc8vi9+TgCkSWjva0rSeozBC
	HYPFTHlNrQag/Tg7ZrCR71HnxOj7tTRD8NovVPd3Ew==
X-Google-Smtp-Source: AGHT+IFypAugvlScti0ckZPMlZ8oid3+IT1Q7bDd2LzopUByu+OysZrd1Ys/Q/2prefbAfi31VuJYw==
X-Received: by 2002:a05:620a:bd6:b0:775:ce76:474a with SMTP id s22-20020a05620a0bd600b00775ce76474amr6692485qki.52.1697653964834;
        Wed, 18 Oct 2023 11:32:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bk40-20020a05620a1a2800b00765ab6d3e81sm147515qkb.122.2023.10.18.11.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:32:44 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:32:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 05/17] t/helper/test-read-graph.c: extract
 `dump_graph_info()`
Message-ID: <3c2057c11c9229794e9d410e34260b2e92b2907e.1697653929.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697653929.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697653929.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
2.42.0.415.g8942f205c8

