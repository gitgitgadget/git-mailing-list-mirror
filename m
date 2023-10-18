Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046447348
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="139zBtaU"
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E77411B
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:52 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7789577b53fso50738085a.3
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697653971; x=1698258771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jIDGriTomqbfCpZhujfid7f6s8be6EPNh9OcTJampgo=;
        b=139zBtaUP+ZJG124khorwTM12Z759n+5bbT6QXYFF/+wHSjV3Nw55naaP6OoSoajvU
         N30BQGI4DzoO36Ek/HraTvvcswT6usB352HSC8KWm94gQjRTuorpzsdOrJ5N50N/VTkS
         GI5Ku2h9+bPx82pS1pX9RL4lsAXEGyhqTgEW9FXlJ7+wV/LndNdLGQxcqNyGgjXJsVdr
         Imn+8M4bUg+V0IIiSkBIcqjuyrUl4pUKyoIG/BPAnC50VuRhSQxf5+47BMkduaJRBQCN
         bYMWAe0/jQ7WjDy2AqMkBIiUGnlH1R/hRcCBPYoRlz7VqVxPvdYwX5hrkHToo70/p8t9
         ogLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653971; x=1698258771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIDGriTomqbfCpZhujfid7f6s8be6EPNh9OcTJampgo=;
        b=BW00nbOcu+g3djU+4ZjEHSzswMKfD0F2bOfBTnRA9qyRn0GZbJmnKdkAQF4mnuPnDv
         4jZGgHy4vhyWSKXDZ5jYcr21nONdYPnPXqpsPxxkeFcLSHtslF7B1W2S5zquaXWSnZ9I
         cy/EDZELBf2zrsbQ5p3rfn7yn/W5SY8Tj2TCXbrPIax7rQ+2q+VbZ3Qd+grlVJ4IcV9A
         d9M1DOMp8/bcbRvdTZFwk1HO69EJgJXyXd83sEtSsSndHxhM0k9W7fCNxWIPqMh57Y/7
         UoI5Xx+1KESB5q/4l0I/rllbBSMzmEbKT7BjDRp53DnBnuTskDcEsXPPaXrD33vNnBsE
         hUzw==
X-Gm-Message-State: AOJu0YzvkjzaQdzEXM20TDWWgrw3/B4GiBzFFtUKr7rTiDS82C5TScfs
	yR81iVmtRoFdQkQsagUirEYilrIKHhDyzSkENLNP3g==
X-Google-Smtp-Source: AGHT+IFRi1sLrJORvjS1a/mR6SZ1nhaAZu/JYMOZyj+LTZu+LPS+hEVNCWr6T1UBmFTQx9LYeK4xKQ==
X-Received: by 2002:a05:6214:21ac:b0:66d:3690:7c2f with SMTP id t12-20020a05621421ac00b0066d36907c2fmr78067qvc.51.1697653971081;
        Wed, 18 Oct 2023 11:32:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m17-20020ad44d51000000b00658266be23fsm153049qvm.41.2023.10.18.11.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:32:50 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:32:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 07/17] t/helper/test-read-graph: implement `bloom-filters`
 mode
Message-ID: <c7016f51cddf892fa96e40db896e8fe96281ffd9.1697653929.git.me@ttaylorr.com>
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
2.42.0.415.g8942f205c8

