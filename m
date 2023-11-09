Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6376038FAD
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 22:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0+Yqbr7P"
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DF82D63
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 14:34:28 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77891f362cfso118926585a.1
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 14:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699569268; x=1700174068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fE/0gP3h92H6q2grDmi4MIhWQHAzT6ox8nv+VdRFXJw=;
        b=0+Yqbr7P0ygayRitb9CIvW8nNV7jJIQO497KYNdiVj7HMRw4a9U+WdxPwH2h3PyqfJ
         qY0t19o15PPVFZHFsnq284xBAbZpXaVEvtczSjGwk4YGyTEw2FGwj1Y8Ju7SXMuwvp+Q
         wvpBy1RZ7DnDOQzaEz8hOzx+XBliVuTe8Gngh1D6w/bgbu+3b9wBGXtntjWf1APK3PQ+
         F1Gjbd49s7/NsAajiBGImKIL9nfka6DLKg6zh8DxDN4p1brIZebDZoUArmbcpkld4eFX
         QRn3KL5YXjtw2sN/vYl+Pk06y70ydBcfjGdMmEsOFEPIHe6ccSeye4kEj8J8rdgse/RD
         o23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699569268; x=1700174068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fE/0gP3h92H6q2grDmi4MIhWQHAzT6ox8nv+VdRFXJw=;
        b=U3F5ydb4lcXrk4Jl97wnunA6CzaRvefmfiFw4pGm38K3c+RnSISjlzj5ED8mKzuoev
         LF9SaJU3TXm5M+hbkjnxqEGwfZi6h6G+QbsEGjBvLoImE78bDqe5Snlt98yJZ3+dgcti
         p4wi+Qc4Bwcu7XZPCpfb8kFfrSInJCub9CCzFX0zZdmESHpY3OqW60Yy7yYrmxNWc7Oo
         tXI1CPKuV613QEXxuAGgEPldFphjwq/BihcmKXQpPw/IWYccdQWmM0T0lUxujIrsLSoB
         cr0aZJ1VD/xITQfjcIXk+yi62Z3CNJ9aiPgj3iATKh+++ao5npO2sjJB9GNgRRSi2fva
         9QVg==
X-Gm-Message-State: AOJu0YwEbHNNU7Bo1Q5cQGMiOzIgCtgVs+BKW4DrzNHs6gRhKgW7Dk1P
	Zl0/vnZrIpe88CzZ5GtRdLo+mRv9vRD3EwiqgciTPQ==
X-Google-Smtp-Source: AGHT+IHrRx1pk1jtXi5si++8wY8aPBCfLmzI+IFQdSj2r3WL7NK4CgT2hr2jnEiUtPwf4rt0L77NfQ==
X-Received: by 2002:a05:620a:2408:b0:778:8ebc:129f with SMTP id d8-20020a05620a240800b007788ebc129fmr1051744qkn.8.1699569267792;
        Thu, 09 Nov 2023 14:34:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y17-20020ac87091000000b00419c40a0d70sm2332035qto.54.2023.11.09.14.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 14:34:27 -0800 (PST)
Date: Thu, 9 Nov 2023 17:34:26 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/7] midx: read `OIDL` chunk with `pair_chunk_expect()`
Message-ID: <c2b0e54241658af55d4ad3d3d600c7059f9bd33c.1699569246.git.me@ttaylorr.com>
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

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c                      | 16 ++--------------
 t/t5319-multi-pack-index.sh |  1 -
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/midx.c b/midx.c
index 1d14661dad..66f34ed1a3 100644
--- a/midx.c
+++ b/midx.c
@@ -86,19 +86,6 @@ static int midx_read_oid_fanout(const unsigned char *chunk_start,
 	return 0;
 }
 
-static int midx_read_oid_lookup(const unsigned char *chunk_start,
-				size_t chunk_size, void *data)
-{
-	struct multi_pack_index *m = data;
-	m->chunk_oid_lookup = chunk_start;
-
-	if (chunk_size != st_mult(m->hash_len, m->num_objects)) {
-		error(_("multi-pack-index OID lookup chunk is the wrong size"));
-		return 1;
-	}
-	return 0;
-}
-
 static int midx_read_object_offsets(const unsigned char *chunk_start,
 				    size_t chunk_size, void *data)
 {
@@ -186,7 +173,8 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 		die(_("multi-pack-index required pack-name chunk missing or corrupted"));
 	if (read_chunk(cf, MIDX_CHUNKID_OIDFANOUT, midx_read_oid_fanout, m))
 		die(_("multi-pack-index required OID fanout chunk missing or corrupted"));
-	if (read_chunk(cf, MIDX_CHUNKID_OIDLOOKUP, midx_read_oid_lookup, m))
+	if (pair_chunk_expect(cf, MIDX_CHUNKID_OIDLOOKUP, &m->chunk_oid_lookup,
+			      m->hash_len, m->num_objects))
 		die(_("multi-pack-index required OID lookup chunk missing or corrupted"));
 	if (read_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS, midx_read_object_offsets, m))
 		die(_("multi-pack-index required object offsets chunk missing or corrupted"));
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 313496c0cf..2d68616c59 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1077,7 +1077,6 @@ test_expect_success 'reader notices too-small oid lookup chunk' '
 	corrupt_chunk OIDL clear 00000000 &&
 	test_must_fail git log 2>err &&
 	cat >expect <<-\EOF &&
-	error: multi-pack-index OID lookup chunk is the wrong size
 	fatal: multi-pack-index required OID lookup chunk missing or corrupted
 	EOF
 	test_cmp expect err
-- 
2.43.0.rc0.39.g44bd344727

