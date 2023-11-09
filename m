Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443C38FB3
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iCg3XMj4"
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1CD2D63
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 14:34:14 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-778a47bc09aso90110785a.3
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 14:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699569253; x=1700174053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0GnV4Z+c6dZbNpid6RQ+HjufacG8wqK42c+ZwyHwlU=;
        b=iCg3XMj4IMFTqEIG1fP53hnZ4LNY7Uioom9dOtUDlg6YeoGXO1vDW1Zf2iQHlva51A
         GswDrUPWFpEYhswdmrfj7blVaOch0zcEUqc9gk58VE37NaY5MTlxcN4Wv7JJrpEIf5Cu
         mfipzHVGA4xorJYLxzslAUoKMyuYbAu4izBpBrmILXHwViPRefJ94lfsdETSi31aeJSO
         gh7KxzcBsmrlT4wEHyHBIQsGo20hDfY2iG0pHFIXnWk26eNqu01rd6+K04kcDpZkEhki
         dNey09ajRtGmz39OBlbhqtk6VRO9b9Dkwemthh0SUh1sdFjRe8jFKLDEk5HpJDLCdQRv
         HJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699569253; x=1700174053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0GnV4Z+c6dZbNpid6RQ+HjufacG8wqK42c+ZwyHwlU=;
        b=pDlK8Hrdh6UOPWluZMd50ut79Ov/ECadLD0BB5Er6Dd2hEOAq7KrYyArByOMxDN1lw
         SL2SPwgkFl9fS14GSRBrcqHK73dTTKNjfsdY8KOha/TJjGtLN+9UYbEypJcrvmUnQdzK
         dVvNuXMJ8A1qWQvZ1/smZ32XMfbLdT56981nSy5FqAI2hujvUizxOZE3X6GPUtbZdruQ
         kv6Z3GntwLffcDZJPsNxIDh8xkVaAV9FVrNzk1QGrZ8kDD3+IWNbwWVN2tIR2cyaysOV
         EjukjBkfMfayoDTXdlpe8+rHxzVHOSY5seXYS6aKVbD8YtVdi14IGdqnQ2tyO3cW3BpP
         +Q3g==
X-Gm-Message-State: AOJu0Yxkjuo5CQoTxTCOz5/eQ1y+XMweEcYJC3rtR3WlEeISX1Mtl+6d
	uD/wxz5BmU0IDebXSvuLuxytIhEV0oVkWdlbMa5SLw==
X-Google-Smtp-Source: AGHT+IFknJ1TNULMkhYf2/dZXsP/r/ACSCik2uNjZYiO4YBvfdiRGGjYc99i5ZRkWbZzg0n7YjTRig==
X-Received: by 2002:a05:620a:408b:b0:779:e90c:f203 with SMTP id f11-20020a05620a408b00b00779e90cf203mr6715192qko.9.1699569252890;
        Thu, 09 Nov 2023 14:34:12 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z20-20020ae9c114000000b0076cb3690ae7sm248902qki.68.2023.11.09.14.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 14:34:12 -0800 (PST)
Date: Thu, 9 Nov 2023 17:34:11 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/7] chunk-format: introduce `pair_chunk_expect()` helper
Message-ID: <af5fe3b7237caeba8f970e967933db96c83a230e.1699569246.git.me@ttaylorr.com>
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

In 570b8b8836 (chunk-format: note that pair_chunk() is unsafe,
2023-10-09), the pair_chunk() interface grew a required "size" pointer,
so that the caller is forced to at least have a handle on the actual
size of the given chunk.

Many callers were converted to the new interface. A handful were instead
converted from the unsafe version of pair_chunk() to read_chunk() so
that they could check their expected size.

This led to a lot of code like:

    static int graph_read_oid_lookup(const unsigned char *chunk_start,
                                     size_t chunk_size, void *data)
    {
      struct commit_graph *g = data;
      g->chunk_oid_lookup = chunk_start;
      if (chunk_size / g->hash_len != g->num_commits)
        return error(_("commit-graph OID lookup chunk is the wrong size"));
      return 0;
    }

, leaving the caller to use read_chunk(), like so:

    read_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph);

The callback to read_chunk() (in the above, `graph_read_oid_lookup()`)
does nothing more than (a) assign a pointer to the location of the start
of the chunk in the mmap'd file, and (b) assert that it has the correct
size.

For callers that know the expected size of their chunk(s) up-front (most
often because they are made up of a known number of fixed-size records),
we can simplify this by teaching the chunk-format API itself to validate
the expected size for us.

This is wrapped in a new function, called `pair_chunk_expect()` which
takes a pair of "size_t"s (corresponding to the record size and count),
instead of a "size_t *", and validates that the given chunk matches the
expected size as given.

This will allow us to reduce the number of lines of code it takes to
perform these basic read_chunk() operations, by taking the above and
replacing it with something like:

    if (pair_chunk_expect(cf, GRAPH_CHUNKID_OIDLOOKUP,
                          &graph->chunk_oid_lookup,
                          graph->hash_len, graph->num_commits))
      error(_("commit-graph oid lookup chunk is wrong size"));

We will perform those transformations in the following commits.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 chunk-format.c | 29 +++++++++++++++++++++++++++++
 chunk-format.h | 13 ++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/chunk-format.c b/chunk-format.c
index cdc7f39b70..be078dcca8 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -163,6 +163,10 @@ int read_table_of_contents(struct chunkfile *cf,
 struct pair_chunk_data {
 	const unsigned char **p;
 	size_t *size;
+
+	/* for pair_chunk_expect() only */
+	size_t record_size;
+	size_t record_nr;
 };
 
 static int pair_chunk_fn(const unsigned char *chunk_start,
@@ -175,6 +179,17 @@ static int pair_chunk_fn(const unsigned char *chunk_start,
 	return 0;
 }
 
+static int pair_chunk_expect_fn(const unsigned char *chunk_start,
+				size_t chunk_size,
+				void *data)
+{
+	struct pair_chunk_data *pcd = data;
+	if (chunk_size / pcd->record_size != pcd->record_nr)
+		return -1;
+	*pcd->p = chunk_start;
+	return 0;
+}
+
 int pair_chunk(struct chunkfile *cf,
 	       uint32_t chunk_id,
 	       const unsigned char **p,
@@ -184,6 +199,20 @@ int pair_chunk(struct chunkfile *cf,
 	return read_chunk(cf, chunk_id, pair_chunk_fn, &pcd);
 }
 
+int pair_chunk_expect(struct chunkfile *cf,
+		      uint32_t chunk_id,
+		      const unsigned char **p,
+		      size_t record_size,
+		      size_t record_nr)
+{
+	struct pair_chunk_data pcd = {
+		.p = p,
+		.record_size = record_size,
+		.record_nr = record_nr,
+	};
+	return read_chunk(cf, chunk_id, pair_chunk_expect_fn, &pcd);
+}
+
 int read_chunk(struct chunkfile *cf,
 	       uint32_t chunk_id,
 	       chunk_read_fn fn,
diff --git a/chunk-format.h b/chunk-format.h
index 14b76180ef..10806d7a9a 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -17,7 +17,8 @@ struct chunkfile;
  *
  * If reading a file, use a NULL 'struct hashfile *' and then call
  * read_table_of_contents(). Supply the memory-mapped data to the
- * pair_chunk() or read_chunk() methods, as appropriate.
+ * pair_chunk(), pair_chunk_expect(), or read_chunk() methods, as
+ * appropriate.
  *
  * DO NOT MIX THESE MODES. Use different 'struct chunkfile' instances
  * for reading and writing.
@@ -54,6 +55,16 @@ int pair_chunk(struct chunkfile *cf,
 	       const unsigned char **p,
 	       size_t *size);
 
+/*
+ * Similar to 'pair_chunk', but used for callers who are reading a chunk
+ * with a known number of fixed-width records.
+ */
+int pair_chunk_expect(struct chunkfile *cf,
+		      uint32_t chunk_id,
+		      const unsigned char **p,
+		      size_t record_size,
+		      size_t record_nr);
+
 typedef int (*chunk_read_fn)(const unsigned char *chunk_start,
 			     size_t chunk_size, void *data);
 /*
-- 
2.43.0.rc0.39.g44bd344727

