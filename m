Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3B224E0
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hO9BLJrF"
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BA9E6
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:34 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4195fddd6d7so20450841cf.0
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697225134; x=1697829934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bgFolJu8Y3Md8X+JvcQ8Z0v/knZLWnQV9pSSHP3t8FM=;
        b=hO9BLJrF9LRl9NUL9VbF2YHjC/l8DEG2nGG5NDiIhRq27jp/z0CKvS0vET7dEwqTBG
         1rROjsXiDACVY6nX5VdYTQHf8gG9TER5hL4brqVzFOQqKL1W2k/eYnlZj7KUTB7jWBUx
         MecBqXdiXAKwGv44wEkoUCvStfb9Qd+P4Vv3Is3wmGY1fiRqrix9d40U7oUhTdlwdsO8
         XzB1Q0dKKZA8sPZYH2grIQ00tGYBrdsQIlzzc7677OxK/hmpAv9kgcuoMZHUhKbigUza
         DqAC+xK8Wh1INXDalyeEJ3pxCm3NXWXrQw1krYGmFyBZqVm0mv3fl2TfTOaA2Tfz64uk
         aRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697225134; x=1697829934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgFolJu8Y3Md8X+JvcQ8Z0v/knZLWnQV9pSSHP3t8FM=;
        b=t180DCk74n2HIh4bL0vsB/u7JgXOFBUFjMcbQ7hiFI34jnRg3Z99tO2udHvYpFDe4o
         C1C1gd2iUrglrW8S8eLHxpkWEPQ9/q+kC/RAwsPTvJx3jeV0bKw8etxdu8NJ5P8uzO4V
         PXY5Kkzlmt+77tsPiBUEeMNK+24Y3UMJNEBx8phxGknSPJYXu+bCDReRgThZ7JiruNy9
         Mhou6SJ+GIba9h5bEgsDUKh9p71m1bsJjulwq+224SGCs0H0kunD/QfP7X1r9RO0XBT0
         YpBReRSMFqHV4Pvg0ahFgr9+wqGsGM6cydpvYuXISzSlh7CWj8eeN5rIlJRCbgyeQsxO
         iYAg==
X-Gm-Message-State: AOJu0YySkkxUGEQSMqUdV2Bt+M9tbKbNO1LqQzc4MjFvAalEwYyWRoBL
	8731SdhVVxS2Sr1mmB8ZhzAdUbbj10J9wU+mo3soBQ==
X-Google-Smtp-Source: AGHT+IFayh2I28V4Bduz5ZfRDad1/yoyEJlQ5Qw8XTuJ569ZoGdlyqahIhAMfJhLebWUH8WvEAXuFQ==
X-Received: by 2002:ac8:588c:0:b0:408:392e:2aa5 with SMTP id t12-20020ac8588c000000b00408392e2aa5mr1749128qta.20.1697225133909;
        Fri, 13 Oct 2023 12:25:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id jk3-20020a05622a748300b0041aff9339a2sm821638qtb.22.2023.10.13.12.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 12:25:33 -0700 (PDT)
Date: Fri, 13 Oct 2023 15:25:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 6/8] midx: read `OIDF` chunk with `pair_chunk_expect()`
Message-ID: <b39203b32c24772d5d8a257c4f647b7d9bd92d53.1697225110.git.me@ttaylorr.com>
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

Perform an identical conversion as in previous commits to read the
OIDF chunk in the MIDX machinery.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/midx.c b/midx.c
index 2f3863c936..38bf816cce 100644
--- a/midx.c
+++ b/midx.c
@@ -61,20 +61,6 @@ void get_midx_rev_filename(struct strbuf *out, struct multi_pack_index *m)
 	strbuf_addf(out, "-%s.rev", hash_to_hex(get_midx_checksum(m)));
 }
 
-static int midx_read_oid_fanout(const unsigned char *chunk_start,
-				size_t chunk_size, void *data)
-{
-	struct multi_pack_index *m = data;
-	m->chunk_oid_fanout = (uint32_t *)chunk_start;
-
-	if (chunk_size != 4 * 256) {
-		error(_("multi-pack-index OID fanout is of the wrong size"));
-		return 1;
-	}
-	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
-	return 0;
-}
-
 static int midx_read_oid_lookup(const unsigned char *chunk_start,
 				size_t chunk_size, void *data)
 {
@@ -173,8 +159,13 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 
 	if (pair_chunk(cf, MIDX_CHUNKID_PACKNAMES, &m->chunk_pack_names, &m->chunk_pack_names_len))
 		die(_("multi-pack-index required pack-name chunk missing or corrupted"));
-	if (read_chunk(cf, MIDX_CHUNKID_OIDFANOUT, midx_read_oid_fanout, m))
+	if (pair_chunk_expect(cf, MIDX_CHUNKID_OIDFANOUT,
+			      (const unsigned char **)&m->chunk_oid_fanout,
+			      256 * sizeof(uint32_t))) {
+		error(_("multi-pack-index OID fanout is of the wrong size"));
 		die(_("multi-pack-index required OID fanout chunk missing or corrupted"));
+	}
+	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
 	if (read_chunk(cf, MIDX_CHUNKID_OIDLOOKUP, midx_read_oid_lookup, m))
 		die(_("multi-pack-index required OID lookup chunk missing or corrupted"));
 	if (read_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS, midx_read_object_offsets, m))
-- 
2.42.0.352.gd9c5062ff7.dirty

