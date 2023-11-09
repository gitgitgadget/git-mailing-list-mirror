Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203F039856
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xov8Lq+2"
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FF42D63
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 14:34:23 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-586f68b78ddso764888eaf.2
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 14:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699569262; x=1700174062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6uvJ8CYZIzc8Ud08TRsM4z79zgntDfUAlcG+b4Q9AU=;
        b=xov8Lq+2xFIRCcoYoFDDPcYVHRwAMi0Vkz+m2RWYWAuiNWPY3EBrEStRr2oBZ7Aagr
         ejYFdoTmAaYwZvfkiCZWCYx1tgOgvZEih0tI4m8fOOFJKY7OC5E/cx/R4S5yXa8VVTUW
         j1uWDfvjXr2zFE/V11RBnZ10+Yb4WRWmeUpd49KLQF1r366BFkl/QstmtOOzDSX8G75s
         ro1i30D+axMBMZYfa7oilOLzVwi+b0Hs0x0NxxrKSC9qYo4jPXA/DQ4/lFUK6QIJX7Q1
         MX8By6kl4DYBysrNVWPRoHAtFlzLrdEXkeAm2OkOJeAZK0kxqtSiLuaCiwb15Y48vgiQ
         quXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699569262; x=1700174062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6uvJ8CYZIzc8Ud08TRsM4z79zgntDfUAlcG+b4Q9AU=;
        b=Wl9ex1W+qwXanAkQBgVh/YsYXTVTgtdopES8ivcm9AJaf6NgrcWCpdgxtRbMpP2Ktj
         41P1/eBkyeFZTS5tBneBsFLwHsF/y+C3nJyAO8y7ZkJUV2CiQHM2oOGPO0FPMJmHYrHo
         JYQDUchD0Ff9rSVLH+saQuDLFFu+jilxuS8smG7FnAUyCduJlfhQM2LdeSQMxrUdb9SM
         w25z7+OdmyKvuj53wcghzOEKZWOvGqdMTWPuTk8NTmkR23IrkUJG7XZGGQUhqBU8cCh9
         ikAc8axh/hVsX7L7sIs7R/jT5MOLzR4/rp97AtWUYxgXAf23U11TlOVfb+3EvOHiG/FS
         9tDA==
X-Gm-Message-State: AOJu0YzSe6HqPKisZPgCC0CSPXZnwV3KR9tEvMzuP6CW0WEwV8fE95A5
	Zf4hZvH4JytRhk9EhICfsXEQRhuIuszCP/7Eq4HpYQ==
X-Google-Smtp-Source: AGHT+IEaF+S66tzKTAurUALee7fDMqEwdXi4x/17Xf+LfMOPWMOUxSdT1vKfNqYRgdIf7fLtPapFPg==
X-Received: by 2002:a05:6358:9392:b0:169:49f7:cb1c with SMTP id h18-20020a056358939200b0016949f7cb1cmr7514048rwb.8.1699569262584;
        Thu, 09 Nov 2023 14:34:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k20-20020ac84794000000b004179e79069asm2293857qtq.21.2023.11.09.14.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 14:34:22 -0800 (PST)
Date: Thu, 9 Nov 2023 17:34:21 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/7] commit-graph: read `GDAT` chunk with
 `pair_chunk_expect()`
Message-ID: <dcde17455ceb135b5298e86e8256e62cf05ed124.1699569246.git.me@ttaylorr.com>
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

The `GDAT` chunk can benefit from the new chunk-format API function
described in the previous commit. Convert it to `pair_chunk_expect()`
accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 67ab0f2448..3b456d199f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -299,16 +299,6 @@ static int graph_read_oid_fanout(const unsigned char *chunk_start,
 	return 0;
 }
 
-static int graph_read_generation_data(const unsigned char *chunk_start,
-				      size_t chunk_size, void *data)
-{
-	struct commit_graph *g = data;
-	if (chunk_size / sizeof(uint32_t) != g->num_commits)
-		return error(_("commit-graph generations chunk is wrong size"));
-	g->chunk_generation_data = chunk_start;
-	return 0;
-}
-
 static int graph_read_bloom_index(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
@@ -433,8 +423,11 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 		   &graph->chunk_base_graphs_size);
 
 	if (s->commit_graph_generation_version >= 2) {
-		read_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
-			   graph_read_generation_data, graph);
+		if (pair_chunk_expect(cf, GRAPH_CHUNKID_GENERATION_DATA,
+				      &graph->chunk_generation_data,
+				      sizeof(uint32_t),
+				      graph->num_commits))
+			error(_("commit-graph generations chunk is wrong size"));
 		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
 			   &graph->chunk_generation_data_overflow,
 			   &graph->chunk_generation_data_overflow_size);
-- 
2.43.0.rc0.39.g44bd344727

