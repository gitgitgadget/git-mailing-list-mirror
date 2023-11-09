Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2B3984C
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="A/+xrTRJ"
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D152D63
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 14:34:20 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-66d134a019cso8966126d6.3
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 14:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699569259; x=1700174059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WzCj/zAPXAisyinsnvEsPp7o5gd/chwi6G5f91Zfr/Y=;
        b=A/+xrTRJclqDIHyhosxgtyxXfGVE9bwyGgB8WxRYIyjtPrBf7K2Gs0L7+uRETMbQ06
         zpZe3tiCqJwgtyKnyEiKkEGN1PIlI9PbWIjSv8OULF88TfGz5oxawk81kTPMN2McHq5f
         0TmeIacFB+ZHL/WI6EKL16dK9LioiSUdi1T67nl7Yn520IPXsqkd2ePJTozc0dHn/tUk
         tuVkpiMD9xInyAb1HABNvvKL+IpbiZOiEYkc9Vc4SnF38FbgmRhiPW9IsqToYzl+lH+w
         lsxF2l6kcGUJ99tgWa8JN4x4+f8IX7KMApvqUCW9Y6gH/HEfkwE3b/QmDCjU/dFgqfaK
         LHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699569259; x=1700174059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzCj/zAPXAisyinsnvEsPp7o5gd/chwi6G5f91Zfr/Y=;
        b=ffWoRiqRO1bFdluwJBeyWuIbjPM/pdL3LcfkhIbl6fAjEl4QCaZLFK6SOSsLGLtBdZ
         oxLEQMLM7ZhdKF3cTuUfY2d0gx4pRw3787XvIuithbaac5YPTcdSHZ1b7vHjpV/8cujH
         wRth70p3xkT7P7YUAQVasVQQjCLxNGP4sPmt3wg8/viiNP1+IuhA3ohrdf9KtvBgZwtQ
         g4Onh5ykv9Rx0PR6B4/5EVqicMKm8qIAkiXNeVL2heyZBG/THtQ7xS2Ri6Sk+vslJOCI
         rsM2fWsg4cKgJ9cPazGVcysLh3O3IgJKzGLLwAaLj30HP0ilev6RZDqw9tKjzqbRwoCF
         4SMQ==
X-Gm-Message-State: AOJu0Yx8AX0VsDTBwMRnpTw6mczyLAfKPOeVU8b75r3o66EaIf66Z6WF
	PYu+AeL5mCQ277URxxwG5kSSeUsNtThMo1DJUeF4zQ==
X-Google-Smtp-Source: AGHT+IG9Aoha1W45eVytoeO7a3uaXj3nsFKQoCWPLdYvbL14fuB1YIw3oHGgJmEx4CByah1uGKB+dA==
X-Received: by 2002:a05:6214:c41:b0:658:71e1:5490 with SMTP id r1-20020a0562140c4100b0065871e15490mr6160294qvj.21.1699569259730;
        Thu, 09 Nov 2023 14:34:19 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id pl14-20020ad4468e000000b006714f8b5512sm2435676qvb.6.2023.11.09.14.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 14:34:19 -0800 (PST)
Date: Thu, 9 Nov 2023 17:34:18 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/7] commit-graph: read `CDAT` chunk with
 `pair_chunk_expect()`
Message-ID: <400a2ee7f464df0b659ee9ac2f5e112d65e4ff9a.1699569246.git.me@ttaylorr.com>
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

The `CDAT` chunk can benefit from the new chunk-format API function
described in the previous commit. Convert it to `pair_chunk_expect()`
accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c          | 15 +++------------
 t/t5318-commit-graph.sh |  3 +--
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6072c2a17f..67ab0f2448 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -299,16 +299,6 @@ static int graph_read_oid_fanout(const unsigned char *chunk_start,
 	return 0;
 }
 
-static int graph_read_commit_data(const unsigned char *chunk_start,
-				  size_t chunk_size, void *data)
-{
-	struct commit_graph *g = data;
-	if (chunk_size / GRAPH_DATA_WIDTH != g->num_commits)
-		return error(_("commit-graph commit data chunk is wrong size"));
-	g->chunk_commit_data = chunk_start;
-	return 0;
-}
-
 static int graph_read_generation_data(const unsigned char *chunk_start,
 				      size_t chunk_size, void *data)
 {
@@ -431,8 +421,9 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 		error(_("commit-graph OID lookup chunk is the wrong size"));
 		goto free_and_return;
 	}
-	if (read_chunk(cf, GRAPH_CHUNKID_DATA, graph_read_commit_data, graph)) {
-		error(_("commit-graph required commit data chunk missing or corrupted"));
+	if (pair_chunk_expect(cf, GRAPH_CHUNKID_DATA, &graph->chunk_commit_data,
+			      GRAPH_DATA_WIDTH, graph->num_commits)) {
+		error(_("commit-graph commit data chunk is wrong size"));
 		goto free_and_return;
 	}
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index b3e8af018d..fd5165bd07 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -550,7 +550,7 @@ test_expect_success 'detect missing OID lookup chunk' '
 
 test_expect_success 'detect missing commit data chunk' '
 	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_DATA_ID "\0" \
-		"commit-graph required commit data chunk missing or corrupted"
+		"commit-graph commit data chunk is wrong size"
 '
 
 test_expect_success 'detect incorrect fanout' '
@@ -875,7 +875,6 @@ test_expect_success 'reader notices too-small commit data chunk' '
 	check_corrupt_chunk CDAT clear 00000000 &&
 	cat >expect.err <<-\EOF &&
 	error: commit-graph commit data chunk is wrong size
-	error: commit-graph required commit data chunk missing or corrupted
 	EOF
 	test_cmp expect.err err
 '
-- 
2.43.0.rc0.39.g44bd344727

