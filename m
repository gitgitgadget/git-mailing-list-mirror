Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2B439863
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="YF/fpzTU"
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC0F2D63
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 14:34:26 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-5842a94feb2so773595eaf.0
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 14:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699569265; x=1700174065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FDbHaI/JadI9HKCO6pbZxSp5CFQwHyNxGX4QDfRTwg=;
        b=YF/fpzTUHeTRccj810FM+SAAEKU7QC0KloioIqTfaZYdluTyEJ2AMdfAb7Z9iT5LKh
         46DGC+yo+JT2mtmWahOBeA1VY1jCzxsUd1FgoNwZG2+XUOWpeb+dhTa4+jRB8yh9rFQx
         /odqizM//28Yr2djeqXel53tkSYbEcesFIbmyUbkDpUOy8ZkQLTs8U6E5tm1VaiWB0kT
         iKISogcgY9PhEgiB5tccu5+4K1sZLwW5zsRuH6C0fnOwQ2hAMgIUaAwtT9x1rmh78X07
         NSbogUeERrYhgBHOq5tivyQ7K3sUfpv5n8rpqY1c6sPppr+ygilmgTAr/Ug77ixt4AcL
         v5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699569265; x=1700174065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FDbHaI/JadI9HKCO6pbZxSp5CFQwHyNxGX4QDfRTwg=;
        b=wzZVU5uLIFXs46mwUO7ignjwZ5g8Q5bF4RbjEopx8QGItDn52HQ2uc0ERnf+EwMt74
         53PSrJg64TZ/yXbmAVQ9/LUIjGAzqDVii1iqxMqatt7BlD1QM1e58jfv9mFY1I1znkvw
         Cz+vFQEH/jL6LfzXjkWxD+h/cEVLamGGibdDFUnQqapxTXwqnrr90yM+Co/WFTeOpGzC
         C/TXaVbraxKR/dQmyzk38FxGUjg44ZQ979B4GFKLKZLQzOGS30SdmOF1rjh5Cbq/JOEU
         TOUYCrT9muQFygUtrKga2LaQijp3PVY5tDWQ+xp2dg0Os4fOqVN02XWBfWgESQfhx3yc
         VAvA==
X-Gm-Message-State: AOJu0YxWjNM3HYq3a2IIfNT4Qhq4vThJkZ0JkhD68nkrOcqlFvm9WDgx
	hiW9ZcD112eQle4/wNl+O5P7ezduhQT3YCp5+r3b8Q==
X-Google-Smtp-Source: AGHT+IGtoXtithsqJ1ROjpc8/upBKvYnzDpBZyWEFL/W+UH4FwY49w7EW+SqMiq5u3Nibfdyx8oMgg==
X-Received: by 2002:a05:6358:5e0c:b0:169:9788:8741 with SMTP id q12-20020a0563585e0c00b0016997888741mr5423392rwn.27.1699569265209;
        Thu, 09 Nov 2023 14:34:25 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c16-20020ac853d0000000b0041eef6cacf4sm2298482qtq.81.2023.11.09.14.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 14:34:25 -0800 (PST)
Date: Thu, 9 Nov 2023 17:34:24 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/7] commit-graph: read `BIDX` chunk with
 `pair_chunk_expect()`
Message-ID: <1f556f5b02d69bed688cc290d22ed8b7e646c4a7.1699569246.git.me@ttaylorr.com>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <cover.1699569246.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1699569246.git.me@ttaylorr.com>

The `BIDX` chunk can benefit from the new chunk-format API function
described in the previous commit. Convert it to `pair_chunk_expect()`
accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 3b456d199f..76d220508b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -299,18 +299,6 @@ static int graph_read_oid_fanout(const unsigned char *chunk_start,
 	return 0;
 }
 
-static int graph_read_bloom_index(const unsigned char *chunk_start,
-				  size_t chunk_size, void *data)
-{
-	struct commit_graph *g = data;
-	if (chunk_size / 4 != g->num_commits) {
-		warning(_("commit-graph changed-path index chunk is too small"));
-		return -1;
-	}
-	g->chunk_bloom_indexes = chunk_start;
-	return 0;
-}
-
 static int graph_read_bloom_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
@@ -437,8 +425,11 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	}
 
 	if (s->commit_graph_read_changed_paths) {
-		read_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
-			   graph_read_bloom_index, graph);
+		int res = pair_chunk_expect(cf, GRAPH_CHUNKID_BLOOMINDEXES,
+				      &graph->chunk_bloom_indexes,
+				      sizeof(uint32_t), graph->num_commits);
+		if (res && res != CHUNK_NOT_FOUND)
+			warning(_("commit-graph changed-path index chunk is too small"));
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
 			   graph_read_bloom_data, graph);
 	}
-- 
2.43.0.rc0.39.g44bd344727

