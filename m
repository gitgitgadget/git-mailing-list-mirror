Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875D8208DE
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rmTEuGap"
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CA295
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:20 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77575233636so163973085a.2
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697225120; x=1697829920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XG4WCoWmp1vyMlGAqXq8uO3Pg6j11C+mEDyN6QSKRiQ=;
        b=rmTEuGapUWCO+rqaOAPuYFZWljm0qTqUg72qDXe9BdboqEBG0xvPvpVELf5KZneJUj
         sRgvsVVqI5rm8vL3C70vDPd/nYnFh3SyDQVEB0Ko/6Aq6LvD11/2P2DNq8ov+OgvjwKH
         bUvszgvS/2KNPy44pawG8mDqcV4X+2cmD7sv8A79FKIc35bdTZBM8T52JdV5TmfHgG6b
         xOJndSONWTSdFePMW6xT9amXXhuAaSQCGw3cbXRoCUiZMtck+fkFP8u3GORQUQfROZfD
         Su5x+ez4yYYs3VAwfJ4Cn0OmN2bRxBk8tDnBXxfeytypKAVvcE19eezIiyQIVma3SdRz
         K3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697225120; x=1697829920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XG4WCoWmp1vyMlGAqXq8uO3Pg6j11C+mEDyN6QSKRiQ=;
        b=hJjdUedKhIqgVP/X2pL8NizmeZ2jfJhfvPrfl2AZ9VC87zIW2ACAl2lpe/pF2gVbA8
         qgpoHq0nHhjTyrkHnYi1YC71GbZ+q5r1SPmRlJ8Q3W365pOGVL5OZWk4o6FPQmLPOq0P
         +pouq3dsh1qrvbIFmX9Z7u5GC31Xz/LyngWjFOG37RMshcvMjl/MDik6K4ktsB4FejcE
         0SBCz4rsaKqx8ltpdNUcJzGlcX8EA/wWFUTSSuIkkPBCK2EHLvQ/V1eADCOiGcGEYdkN
         18Z1MhgjtQuk+GQBNBoNs2ZZ7RWZTartx1q+jrZYlxtQfIC++S5+41msv02qiw4SENTp
         kYZw==
X-Gm-Message-State: AOJu0YzlndcC70C/bsulDmON/H6VZ7x0IkmGJZzWUaxgdd5QwaGDq1eR
	VSzBevAQDCtH18rwJLiRPv23pbz6uJmpMZrRHjycKA==
X-Google-Smtp-Source: AGHT+IHXWn6Vez0wGZ+dnXybWWjAIhj2x7iqMCSCpk6Yleg8OCJdCvX01eWqx24k3slEAOZR9Kx0fQ==
X-Received: by 2002:a05:620a:410c:b0:768:1e00:76c4 with SMTP id j12-20020a05620a410c00b007681e0076c4mr32317866qko.51.1697225119678;
        Fri, 13 Oct 2023 12:25:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id dt52-20020a05620a47b400b00767721aebc0sm881069qkb.32.2023.10.13.12.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 12:25:19 -0700 (PDT)
Date: Fri, 13 Oct 2023 15:25:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 1/8] chunk-format: introduce `pair_chunk_expect()` helper
Message-ID: <6fa20034b2246599b3e1cd49accfc421b0fba4fb.1697225110.git.me@ttaylorr.com>
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

In previous commits, the pair_chunk() interface grew a required "size"
pointer, so that the caller is forced to at least have a handle on the
actual size of the given chunk.

Many callers were converted to the new interface. A handful were instead
converted from the unsafe version of pair_chunk() to read_chunk() so
that they could check their expected size.

This led to a lot of code like:

    static int graph_read_oid_fanout(const unsigned char *chunk_start,
                                     size_t chunk_size, void *data)
    {
      struct commit_graph *g = data;
      if (chunk_size != 256 * sizeof(uint32_t))
        return error("commit-graph oid fanout chunk is wrong size");
      g->chunk_oid_fanout = (const uint32_t *)chunk_start;
      return 0;
    }

, leaving the caller to use read_chunk(), like so:

    read_chunk(cf, GRAPH_CHUNKID_OIDFANOUT, graph_read_oid_fanout, graph);

The callback to read_chunk() (in the above, `graph_read_oid_fanout()`)
does nothing more than (a) assign a pointer to the location of the start
of the chunk in the mmap'd file, and (b) assert that it has the correct
size.

For callers that know the expected size of their chunk(s) up-front, we
can simplify this by teaching the chunk-format API itself to validate
the expected size for us.

This is wrapped in a new function, called `pair_chunk_expect()` which
takes a "size_t" instead of a "size_t *", and validates that the given
chunk matches the expected size as given.

This will allow us to reduce the number of lines of code it takes to
perform these basic read_chunk() operations, by taking the above and
replacing it with something like:

    if (pair_chunk_expect(cf, GRAPH_CHUNKID_OIDFANOUT,
                          (const unsigned char **)&graph->chunk_oid_fanout,
                          256 * sizeof(uint32_t)))
      error(_("commit-graph oid fanout chunk is wrong size"));

We will perform those transformations in the following commits.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 chunk-format.c | 22 ++++++++++++++++++++++
 chunk-format.h | 12 +++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/chunk-format.c b/chunk-format.c
index cdc7f39b70..9550f15699 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -163,6 +163,8 @@ int read_table_of_contents(struct chunkfile *cf,
 struct pair_chunk_data {
 	const unsigned char **p;
 	size_t *size;
+
+	size_t expected_size;
 };
 
 static int pair_chunk_fn(const unsigned char *chunk_start,
@@ -175,6 +177,17 @@ static int pair_chunk_fn(const unsigned char *chunk_start,
 	return 0;
 }
 
+static int pair_chunk_expect_fn(const unsigned char *chunk_start,
+				size_t chunk_size,
+				void *data)
+{
+	struct pair_chunk_data *pcd = data;
+	if (pcd->expected_size != chunk_size)
+		return -1;
+	*pcd->p = chunk_start;
+	return 0;
+}
+
 int pair_chunk(struct chunkfile *cf,
 	       uint32_t chunk_id,
 	       const unsigned char **p,
@@ -184,6 +197,15 @@ int pair_chunk(struct chunkfile *cf,
 	return read_chunk(cf, chunk_id, pair_chunk_fn, &pcd);
 }
 
+int pair_chunk_expect(struct chunkfile *cf,
+		      uint32_t chunk_id,
+		      const unsigned char **p,
+		      size_t expected_size)
+{
+	struct pair_chunk_data pcd = { .p = p, .expected_size = expected_size };
+	return read_chunk(cf, chunk_id, pair_chunk_expect_fn, &pcd);
+}
+
 int read_chunk(struct chunkfile *cf,
 	       uint32_t chunk_id,
 	       chunk_read_fn fn,
diff --git a/chunk-format.h b/chunk-format.h
index 14b76180ef..92c529d7ab 100644
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
@@ -54,6 +55,15 @@ int pair_chunk(struct chunkfile *cf,
 	       const unsigned char **p,
 	       size_t *size);
 
+/*
+ * Similar to 'pair_chunk', but used for callers who have an expected
+ * size for the given 'chunk_id' in advance.
+ */
+int pair_chunk_expect(struct chunkfile *cf,
+		      uint32_t chunk_id,
+		      const unsigned char **p,
+		      size_t expected_size);
+
 typedef int (*chunk_read_fn)(const unsigned char *chunk_start,
 			     size_t chunk_size, void *data);
 /*
-- 
2.42.0.352.gd9c5062ff7.dirty

