Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DB238F91
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="O5K6igdR"
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762C0420B
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 14:34:16 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-778711ee748so91071685a.2
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 14:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699569255; x=1700174055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=696+HX+GCK9IWWK4+KZKl3vji+WPm7c9povP4DkKz+A=;
        b=O5K6igdR3bPOwlWGh/+Zz/M3e5tj+mN7Qr85fSUBSz/F2J/ACt+m4NWjhZDCKHlI7t
         BZAw4XeQhMxKJNKmGHJbNp673ifYxkxi0SUQmzySMPyOdk0xndlw/UIC4EaazRZ3zvka
         2QkD5NFmaE0ExFDBsQcq4gs1mYs+TqpKITMkTLbIO3k8Jkk4N4aR++ttRCh7dU8cNZnZ
         3W3HcQP5p4DEuORDRBmMWhAnIAB3uSXPJYBgV5Df2bsS/7z/0rvi3ywn2tAahE72X5L2
         7X4IrYPLM3FJqJNPii9OM+yqIFPD74t+zbpGDkoFiXpEaW269duNRs6zI8aFJjhZfixh
         X3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699569255; x=1700174055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=696+HX+GCK9IWWK4+KZKl3vji+WPm7c9povP4DkKz+A=;
        b=uN9VP/2AZpEy4uIOSal0o+R2Q1IaDkdidKOy9KxTyU/p2cWNA4TIYUjGNCTpsLJ93U
         r9DuRn9XWFReusWIWHtjNemNZKzUqQ1CNhcD+6XTuMSB4VTQp+CA8JyRL5v22nicT5f2
         FGE1N4/9L8drJq8hmbSO8mtoEmpqVslxJpDuA7pQzLidCaNeD3gTyeqIR+gNtd2/IGJE
         6vyiGf9IdqcTFnW5OWimsuHNA/UfItsfoc0YSa9f4Jjz9ucVrobRtGWnTcwWeosm9ylJ
         ZCx1MzbA4+INbHxDriIcCU8Er45UwiRDA2JVX1h5V6f7t4VmAN3+qpvHAMwhnG99c83C
         yCYA==
X-Gm-Message-State: AOJu0YxC5P3tYyoxSz6h4wK/dN93fFIT85aioEBFmsUg5mfH6MM4p2N+
	TNopmvRXRi3sFvEICI4s5hjKIo3NZaDTid8Jh/C3jQ==
X-Google-Smtp-Source: AGHT+IF+VCTRJ4ZI2Kfovy5Zjq17bGbBMNaxj9+8quJctXg6y+t4vlChkvf5FWFWQpc+RNHcDW9yJA==
X-Received: by 2002:a05:620a:28d5:b0:77b:c67a:4b59 with SMTP id l21-20020a05620a28d500b0077bc67a4b59mr402393qkp.3.1699569255355;
        Thu, 09 Nov 2023 14:34:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id rv9-20020a05620a688900b0077438383a07sm244469qkn.80.2023.11.09.14.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 14:34:15 -0800 (PST)
Date: Thu, 9 Nov 2023 17:34:14 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/7] commit-graph: read `OIDL` chunk with
 `pair_chunk_expect()`
Message-ID: <5b3c0b99f8052733bb714122582ab229556c94ef.1699569246.git.me@ttaylorr.com>
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

The `OIDL` chunk can benefit from the new chunk-format API function
described in the previous commit. Convert it to `pair_chunk_expect()`
accordingly.

While here, clean up some of the duplicate error messages to simplify
the output when we are missing or have a corrupt OIDL chunk.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c          | 16 ++++------------
 t/t5318-commit-graph.sh |  3 +--
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 93cf690565..6072c2a17f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -299,16 +299,6 @@ static int graph_read_oid_fanout(const unsigned char *chunk_start,
 	return 0;
 }
 
-static int graph_read_oid_lookup(const unsigned char *chunk_start,
-				 size_t chunk_size, void *data)
-{
-	struct commit_graph *g = data;
-	g->chunk_oid_lookup = chunk_start;
-	if (chunk_size / g->hash_len != g->num_commits)
-		return error(_("commit-graph OID lookup chunk is the wrong size"));
-	return 0;
-}
-
 static int graph_read_commit_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
@@ -435,8 +425,10 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 		error(_("commit-graph required OID fanout chunk missing or corrupted"));
 		goto free_and_return;
 	}
-	if (read_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph)) {
-		error(_("commit-graph required OID lookup chunk missing or corrupted"));
+	if (pair_chunk_expect(cf, GRAPH_CHUNKID_OIDLOOKUP,
+			      &graph->chunk_oid_lookup, graph->hash_len,
+			      graph->num_commits)) {
+		error(_("commit-graph OID lookup chunk is the wrong size"));
 		goto free_and_return;
 	}
 	if (read_chunk(cf, GRAPH_CHUNKID_DATA, graph_read_commit_data, graph)) {
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index b0d436a6f0..b3e8af018d 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -545,7 +545,7 @@ test_expect_success 'detect missing OID fanout chunk' '
 
 test_expect_success 'detect missing OID lookup chunk' '
 	corrupt_graph_and_verify $GRAPH_BYTE_OID_LOOKUP_ID "\0" \
-		"commit-graph required OID lookup chunk missing or corrupted"
+		"commit-graph OID lookup chunk is the wrong size"
 '
 
 test_expect_success 'detect missing commit data chunk' '
@@ -851,7 +851,6 @@ test_expect_success 'reader notices fanout/lookup table mismatch' '
 	check_corrupt_chunk OIDF 1020 "FFFFFFFF" &&
 	cat >expect.err <<-\EOF &&
 	error: commit-graph OID lookup chunk is the wrong size
-	error: commit-graph required OID lookup chunk missing or corrupted
 	EOF
 	test_cmp expect.err err
 '
-- 
2.43.0.rc0.39.g44bd344727

