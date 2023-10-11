Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C42CD98E0
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 01:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344606AbjJKBYr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 21:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344597AbjJKBYr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 21:24:47 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5883E8F
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 18:24:45 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-65b0557ec77so36737896d6.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 18:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696987484; x=1697592284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2OIZsxgWvFnLkAOGAiBiQIr3Bb8DD3y2d3EifO86zCs=;
        b=yLbnZaKJuhKS2NuQS/3ZU4XNl3/V+m4grytwWVPSSWd7VW2T2l9MnpVibCXaivTv9P
         piydfzK7m/2ejymYYIFmxH9z9BxlABYnlf45h/meoEA5FCAtgXvTJAchR54qOG91wVZM
         PubiHxk34UaiHNPg59XdIdqW9P66NjaS5595IpD4Kybl7d5F70VbLMbRizk/YYDU31pk
         e3DZ/HZ5whobMHzT69/wkFRNuKyaHh/2PxiaUK/de8Q3BpRNuztVq3zfBCfSSD+581ML
         GkoZFxQqmvnoP+WOB+xLBpTonMvNG6HNaYogx6reUGPx/Mvl+KSJTXG1OGpyUpO4Ml7J
         JUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696987484; x=1697592284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OIZsxgWvFnLkAOGAiBiQIr3Bb8DD3y2d3EifO86zCs=;
        b=R0yeNBnLFDfLtJY+t7vxUFNcvgVCv+HWU+49vZ0w6sDXD23k/zyV3OG0+1N1urVB7S
         fy7IJWaOLqC0UYtBZUOclN2cEFveQ1rI4J2ew2/BuVOq49vqfSn3063wuTdVrHcynADh
         CFyki5D6mv68ZzniuYbKAFf5e+gfDOEit3saHDxmGqpfPXie2+HajMs1cYLmYAquL1En
         iYLhwuZ1vmSWN2uTB2zKSpeOzpSUpb7Zs+8snSdma/ddUrC3/1qRb4VGSm6mfHSVs6Zo
         9bQKLSMoDvb4SPqV6OF0ugdU/+2WuzETHJAokgl63KBa7eQQXOD9kI4E0uCAa0NXcVv7
         0yMw==
X-Gm-Message-State: AOJu0Yy3TLfPmnSq7S0tsWJdln3MoavpLb4c4p9AYP7ccioDkWnIDuTj
        b58aiwwPB2kZoLCbV2DOHvEz+mF+IeIwPwEseh7GqQ==
X-Google-Smtp-Source: AGHT+IGNY0wXerdc+6Y2Ki5kZvoSJkWbpQMgrjgKhNYv1tYmRtW/GWhyazeukK6BjHE+u3FBi55ejQ==
X-Received: by 2002:a05:6214:3bc9:b0:63d:9d0:1949 with SMTP id ng9-20020a0562143bc900b0063d09d01949mr22176512qvb.24.1696987484428;
        Tue, 10 Oct 2023 18:24:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m12-20020a0cf18c000000b0065b02eaeee7sm5228467qvl.83.2023.10.10.18.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 18:24:43 -0700 (PDT)
Date:   Tue, 10 Oct 2023 21:24:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/20] commit-graph: check size of oid fanout chunk
Message-ID: <ZSX5V4VkpNbY5izU@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009205951.GD3282181@coredump.intra.peff.net>
 <ZSXnZXglgbfK3VYd@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSXnZXglgbfK3VYd@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2023 at 08:08:05PM -0400, Taylor Blau wrote:
> Do you think it would be worth changing pair_chunk() to take an expected
> size_t and handle this generically? I.e. have a version of
> chunk-format::pair_chunk_fn() that looks something like:
>
>     static int pair_chunk_fn(const unsigned char *chunk_start,
>                              size_t chunk_size, void *data)
>     {
>         const unsigned char **p = data;
>         if (chunk_size != data->size)
>             return -1;
>         *p = chunk_start;
>         return 0;
>     }
>
> and then our call here would be:
>
>   if (pair_chunk(cf, GRAPH_CHUNKID_OIDFANOUT,
>                  (const unsigned char **)&graph->chunk_oid_fanout,
>                  256 * sizeof(uint32_t)) < 0)
>       return error("commit-graph oid fanout chunk is wrong size");

I took a brief stab at implementing this tonight and came up with this,
which applies on top of this patch. Looking through the rest of the
series briefly[^1], I think having something like this would be useful:

--- 8< ---
diff --git a/chunk-format.c b/chunk-format.c
index 8d910e23f6..38b0f847be 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -157,6 +157,8 @@ int read_table_of_contents(struct chunkfile *cf,
 struct pair_chunk_data {
 	const unsigned char **p;
 	size_t *size;
+
+	size_t expected_size;
 };

 static int pair_chunk_fn(const unsigned char *chunk_start,
@@ -169,6 +171,20 @@ static int pair_chunk_fn(const unsigned char *chunk_start,
 	return 0;
 }

+static int pair_chunk_expect_fn(const unsigned char *chunk_start,
+				size_t chunk_size,
+				void *data)
+{
+	struct pair_chunk_data *pcd = data;
+	if (pcd->expected_size != chunk_size)
+		return error(_("mismatched chunk size, got: %"PRIuMAX", wanted:"
+			       " %"PRIuMAX),
+			     (uintmax_t)chunk_size,
+			     (uintmax_t)pcd->expected_size);
+	*pcd->p = chunk_start;
+	return 0;
+}
+
 int pair_chunk(struct chunkfile *cf,
 	       uint32_t chunk_id,
 	       const unsigned char **p,
@@ -178,6 +194,14 @@ int pair_chunk(struct chunkfile *cf,
 	return read_chunk(cf, chunk_id, pair_chunk_fn, &pcd);
 }

+int pair_chunk_expect(struct chunkfile *cf,
+		      uint32_t chunk_id, const unsigned char **p,
+		      size_t expected_size)
+{
+	struct pair_chunk_data pcd = { .p = p, .expected_size = expected_size };
+	return read_chunk(cf, chunk_id, pair_chunk_expect_fn, &pcd);
+}
+
 int pair_chunk_unsafe(struct chunkfile *cf,
 		      uint32_t chunk_id,
 		      const unsigned char **p)
diff --git a/chunk-format.h b/chunk-format.h
index 8dce7967f4..778f81f555 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -53,6 +53,10 @@ int pair_chunk(struct chunkfile *cf,
 	       const unsigned char **p,
 	       size_t *size);

+int pair_chunk_expect(struct chunkfile *cf,
+		      uint32_t chunk_id, const unsigned char **p,
+		      size_t expected_size);
+
 /*
  * Unsafe version of pair_chunk; it does not return the size,
  * meaning that the caller cannot possibly be careful about
diff --git a/commit-graph.c b/commit-graph.c
index 9b3b01da61..ed85161fdb 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -305,16 +305,6 @@ static int verify_commit_graph_lite(struct commit_graph *g)
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
@@ -404,7 +394,10 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 				   GRAPH_HEADER_SIZE, graph->num_chunks))
 		goto free_and_return;

-	read_chunk(cf, GRAPH_CHUNKID_OIDFANOUT, graph_read_oid_fanout, graph);
+	if (pair_chunk_expect(cf, GRAPH_CHUNKID_OIDFANOUT,
+			      (const unsigned char **)&graph->chunk_oid_fanout,
+			      256 * sizeof(uint32_t)) < 0)
+		error(_("commit-graph oid fanout chunk is wrong size"));
 	read_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph);
 	pair_chunk_unsafe(cf, GRAPH_CHUNKID_DATA, &graph->chunk_commit_data);
 	pair_chunk_unsafe(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges);
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d25bea3ec5..467b5f5e9c 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -841,6 +841,7 @@ test_expect_success 'reader notices too-small oid fanout chunk' '
 	# otherwise we hit an earlier check
 	check_corrupt_chunk OIDF clear $(printf "000000%02x" $(test_seq 250)) &&
 	cat >expect.err <<-\EOF &&
+	error: mismatched chunk size, got: 1000, wanted: 1024
 	error: commit-graph oid fanout chunk is wrong size
 	error: commit-graph is missing the OID Fanout chunk
 	EOF
--- >8 ---

Or, quite honestly, having the "expected_size" parameter be required in
the safe version of `pair_chunk()`.

Thanks,
Taylor

[^1]: A non-brief review is on my to-do list for tomorrow.
