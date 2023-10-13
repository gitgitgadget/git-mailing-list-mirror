Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77C32376D
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ceEpWXH3"
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95007A9
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:23 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4197bb0a0d9so14382911cf.3
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697225122; x=1697829922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fAq6mbBAohEzrtPePLq4Lqw8rDkaGGY2VM65qOtCsyg=;
        b=ceEpWXH3jDtECf1juLAgniQag7vI3DeT6mw3iqkUjth1QKcpDP4W/fg3QN2czMuD0+
         JOU7B8HY1gPy+PhmXbgrT/6k0/V9df2aT4XAmu8vi25QxyUoDxXNfak5npc2nI0LJANb
         gZfDTUriFbp7VRCUZEUDjP+Sks0Y+NVfoQoIXR7NqhR0KezwlXKvmQjIZR+Rp5Mky7x2
         6O9C6vSqD+3lxToAQrv7iFJ8XOA+rC0nQDqzDY9HxCDZnCg/MmdbMVbf9gSWI38PfVl5
         Sgq6llthz3fw3Y/nSLQ0McgMrWhUez0/pZAqtGPdeD/eGcMkEJzUtdL66wbBYJGKQHQM
         S7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697225122; x=1697829922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAq6mbBAohEzrtPePLq4Lqw8rDkaGGY2VM65qOtCsyg=;
        b=CnfhrBv2IKAqzmAruDIq613lwmLMXViW3laNLwGKZzt69nslqeYN9H5ikrdzopekJt
         F6XVUV4OONMTZiPC6nF1dFoVIzrGFknfegWNen2B2/A4SXAeik8xvay+2m9UWpFPIO+0
         eXbRMbl7ROvReoN25OiIAqXB6VlVqQaSsMsM+DXr4orkqnIRo0eY3qND44DxBKG++Wy4
         2YUtPr3EY4uk4RCyGIt0gmnUFS25/OaHJcrcXkBFK/jAoiS7LP2n3qJuQPi+IFz1PupX
         ZvCSu2+81MzgxP6roN4dzeSg0KNXp+nTi7X8ELvBlNGUS4p0/ZW0HDsnfBimwfwBAEYM
         TCyw==
X-Gm-Message-State: AOJu0YyR1e0ZKoBBG8TWSWUMVJvf71Vz4TZPyxOAI7lESj3WOCkIYB0K
	cv01jTevw75SK7dUwJJlIriUX/2KRzyNnovrqiTWdg==
X-Google-Smtp-Source: AGHT+IGahuI7lpI21I8obhTJbQJueq8BXg7SCqKNC6VpraiGTd4mgwIA8dDCWi5+xU3hcb14+kv8Tw==
X-Received: by 2002:ac8:578d:0:b0:412:c2a:eaef with SMTP id v13-20020ac8578d000000b004120c2aeaefmr34938086qta.11.1697225122579;
        Fri, 13 Oct 2023 12:25:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h3-20020ac85483000000b004194c21ee85sm832536qtq.79.2023.10.13.12.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 12:25:22 -0700 (PDT)
Date: Fri, 13 Oct 2023 15:25:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 2/8] commit-graph: read `OIDF` chunk with
 `pair_chunk_expect()`
Message-ID: <3e0969d794a775f9167d7a20fe6aeb17edc60d8a.1697225110.git.me@ttaylorr.com>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <cover.1697225110.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697225110.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The `OIDF` chunk can benefit from the new chunk-format API function
described in the previous commit. Convert it to `pair_chunk_expect()`
accordingly.

While we're at it, let's mark the error() string for translation.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 1f334987b5..cdefd7f926 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -321,16 +321,6 @@ static int verify_commit_graph_lite(struct commit_graph *g)
 	return 0;
 }
 
-static int graph_read_oid_fanout(const unsigned char *chunk_start,
-				 size_t chunk_size, void *data)
-{
-	struct commit_graph *g = data;
-	if (chunk_size != 256 * sizeof(uint32_t))
-		return error("commit-graph oid fanout chunk is wrong size");
-	g->chunk_oid_fanout = (const uint32_t *)chunk_start;
-	return 0;
-}
-
 static int graph_read_oid_lookup(const unsigned char *chunk_start,
 				 size_t chunk_size, void *data)
 {
@@ -462,7 +452,10 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 				   GRAPH_HEADER_SIZE, graph->num_chunks, 1))
 		goto free_and_return;
 
-	read_chunk(cf, GRAPH_CHUNKID_OIDFANOUT, graph_read_oid_fanout, graph);
+	if (pair_chunk_expect(cf, GRAPH_CHUNKID_OIDFANOUT,
+			      (const unsigned char **)&graph->chunk_oid_fanout,
+			      256 * sizeof(uint32_t)))
+		error(_("commit-graph oid fanout chunk is wrong size"));
 	read_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph);
 	read_chunk(cf, GRAPH_CHUNKID_DATA, graph_read_commit_data, graph);
 	pair_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges,
-- 
2.42.0.352.gd9c5062ff7.dirty

