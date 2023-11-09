Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE833984C
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MTzuC7dk"
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E01E2D63
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 14:34:31 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41eae4f0ee6so9250941cf.3
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 14:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699569270; x=1700174070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zle5ZNhB+UwAR7G7/cow/My6dhR+1Xu8cKgtyP7ptW4=;
        b=MTzuC7dkvtbTA9eGaXb4T+aCFcaFSP/8E6o43cGkemqxfNtPc8gLIOPTnNogDEFRkP
         cE//LFkREoqUhX71iXJUURKJq6LnkMbYXjzGzsqmuPymgWLY0OqvXLN6vbtp2pTGAxtM
         xaDpLRY/I1wbl+xgR2SxbJUlvMSS9M+tg0lF3CrXJFoyXendaBjHp8wGH+nUIpUk6BsF
         2O2nSLJdkaERGTUNSqLUHOd3i/KLvtBJSp9I+6UkvdeWPf6tgJwNj2v5JeAnfVYlaEhe
         JDwXgykBykf+inJQ0rm2vakq31my9IglzmDIOJQOC6J0khi9OmJYJkb6vvp2gBPZZbTj
         90zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699569270; x=1700174070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zle5ZNhB+UwAR7G7/cow/My6dhR+1Xu8cKgtyP7ptW4=;
        b=gZhu5RcJK4VI/pWD7vde/Dvt3r6560H2vxCGm7zaDKeLVqexgqMaWtFnbiFf8r9oEv
         gPnM09RvDG0b/H/ibMIo4Kmg0hcGsU3mcaFVg2vELIqO5ZA+35G1+jW+Q8urhfrbvBDO
         b/bhroyS+4uoglOaOGg6iRy5uxBXtRAk4/5Kcl3y/b/ROTZCA71rRHMk0T8j6aLSZhbW
         Ch6gAwgXuGbRW0qiY4sHqvPRAYiyQ73pJRkHDCuStC0AK9WvnoH7wwCLlHv5/AEszTkR
         FIZpOmXM5e3NkBw5a3lbegzs7h5k2xEIJg+uXefkIm3C6UwqFjYh4TcrSgpUOLxNIYka
         53DA==
X-Gm-Message-State: AOJu0Yxk7jxM0h4KgHxFhh3r9nVjlZUsp2g9YeFYv4DKFe004xuz+0M0
	WonDbfc+3gjPf9W1P0uDo520c8ELwafqHLmvhn/VvQ==
X-Google-Smtp-Source: AGHT+IFyDEi0CmJbs7tveExSV+NzfKFMUBxmndUx5ldH7YeYN7S4kf/cuSX5Kvlc/GRevMXlH6SyaQ==
X-Received: by 2002:a05:622a:1883:b0:41c:bf98:dab1 with SMTP id v3-20020a05622a188300b0041cbf98dab1mr5461376qtc.13.1699569270366;
        Thu, 09 Nov 2023 14:34:30 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b19-20020ac844d3000000b004180fb5c6adsm2303852qto.25.2023.11.09.14.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 14:34:30 -0800 (PST)
Date: Thu, 9 Nov 2023 17:34:29 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/7] midx: read `OOFF` chunk with `pair_chunk_expect()`
Message-ID: <44bd344727622b86a00424f37dbaa0c35d85189a.1699569246.git.me@ttaylorr.com>
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

The `OOFF` chunk can benefit from the new chunk-format API function
described in the previous commit. Convert it to `pair_chunk_expect()`
accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c                      | 17 +++--------------
 t/t5319-multi-pack-index.sh |  1 -
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/midx.c b/midx.c
index 66f34ed1a3..ca41748b74 100644
--- a/midx.c
+++ b/midx.c
@@ -86,19 +86,6 @@ static int midx_read_oid_fanout(const unsigned char *chunk_start,
 	return 0;
 }
 
-static int midx_read_object_offsets(const unsigned char *chunk_start,
-				    size_t chunk_size, void *data)
-{
-	struct multi_pack_index *m = data;
-	m->chunk_object_offsets = chunk_start;
-
-	if (chunk_size != st_mult(m->num_objects, MIDX_CHUNK_OFFSET_WIDTH)) {
-		error(_("multi-pack-index object offset chunk is the wrong size"));
-		return 1;
-	}
-	return 0;
-}
-
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local)
 {
 	struct multi_pack_index *m = NULL;
@@ -176,7 +163,9 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	if (pair_chunk_expect(cf, MIDX_CHUNKID_OIDLOOKUP, &m->chunk_oid_lookup,
 			      m->hash_len, m->num_objects))
 		die(_("multi-pack-index required OID lookup chunk missing or corrupted"));
-	if (read_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS, midx_read_object_offsets, m))
+	if (pair_chunk_expect(cf, MIDX_CHUNKID_OBJECTOFFSETS,
+			      &m->chunk_object_offsets, MIDX_CHUNK_OFFSET_WIDTH,
+			      m->num_objects))
 		die(_("multi-pack-index required object offsets chunk missing or corrupted"));
 
 	pair_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets,
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 2d68616c59..f1f6764efe 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1111,7 +1111,6 @@ test_expect_success 'reader notices too-small object offset chunk' '
 	corrupt_chunk OOFF clear 00000000 &&
 	test_must_fail git log 2>err &&
 	cat >expect <<-\EOF &&
-	error: multi-pack-index object offset chunk is the wrong size
 	fatal: multi-pack-index required object offsets chunk missing or corrupted
 	EOF
 	test_cmp expect err
-- 
2.43.0.rc0.39.g44bd344727
