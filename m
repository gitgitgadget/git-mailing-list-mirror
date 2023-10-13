Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C63241E4
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="zPoZZENF"
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBB5F0
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:37 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d77ad095f13so2462644276.2
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697225136; x=1697829936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w2zc6g4RWcbBE0i46CrILLQ31UNkbOvaTior+gb4iU4=;
        b=zPoZZENFKDRrMA92Xl4M5DT+c6OpXuI/Am4pbGHmnjNrQpW4UOi8vEFwlCyEDpyWUk
         uR9fpEoDenogIgTH9Iii0AOXo7cmtlbfolMQyeSJHAQeLv9RzcB6PN3z8Ali7yxcl+PV
         zLUABrFPyAQk4IfTCp1ralxPjQCsBo2Uv12RN3crcW/WkAR2uaucWCQHsPQplejrS93C
         3eLnZkkENEW16U8T+x9txDAgvLhBbQjDQaxRqUAbZuiEizWSF7C5LjurIKsGj1rX2Png
         IfV/9Gjis3W0n9GgZEJHKaUWvbGMraw3+cl1SvYHuCMvKNE2TBCSZCKlAm2mNTSiJVsv
         kWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697225136; x=1697829936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2zc6g4RWcbBE0i46CrILLQ31UNkbOvaTior+gb4iU4=;
        b=oSJk3ut+QkjyaBTppqipRJyVcAjdAIIPjXZHgaPaW/NShOsQUSa2DltBAU45KhkNfS
         twdCRfQXt7+KZDLIva+CuOOGnCAqwuoFR3kyuVqCDvr1fAeskdJGeXsDqYbF4Q5hGI3X
         7M5C4KIzU4ABcan5BI/4fhDOoEKDxDGvqGhFFJyhVs4J+WOBQVyD+Gl/jFQyjIlx2+pu
         MhKimoEOdOrnzPNHcvd+PyVBaT7XwKG3D8F0JN/L50o1eg3yxEyB/XZ+ACXKiSur3MVQ
         dbRZNxzuvZo7wKLL1r4bH1vv2xzos3Mv8RuT2x4Fvb7s7QzEQEfdcP1aoQROxxp2qjFY
         YlpQ==
X-Gm-Message-State: AOJu0YzadUpzqJPYnQKoFnKH54w8h87sPLwRsGo0UWM/is8QEeynB/VE
	RlUJtwWEzqz8+8TFBJrbfhchrTOd32171n2tQjCT7Q==
X-Google-Smtp-Source: AGHT+IGDDvozOCDa76ufpb6oqdvzkS1m+Vj3gDj9+0ofrIBpG0JEMPb1JRa+EwNE7MY5wLro39emzA==
X-Received: by 2002:a25:4e05:0:b0:d69:8faa:5a28 with SMTP id c5-20020a254e05000000b00d698faa5a28mr25353026ybb.55.1697225136533;
        Fri, 13 Oct 2023 12:25:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a10-20020a0ce90a000000b006577e289d37sm908408qvo.2.2023.10.13.12.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 12:25:36 -0700 (PDT)
Date: Fri, 13 Oct 2023 15:25:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 7/8] midx: read `OIDL` chunk with `pair_chunk_expect()`
Message-ID: <5844dd9383076b158eba20b9e43019280b74dd76.1697225110.git.me@ttaylorr.com>
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
OIDL chunk in the MIDX machinery.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/midx.c b/midx.c
index 38bf816cce..74167b8fdb 100644
--- a/midx.c
+++ b/midx.c
@@ -61,19 +61,6 @@ void get_midx_rev_filename(struct strbuf *out, struct multi_pack_index *m)
 	strbuf_addf(out, "-%s.rev", hash_to_hex(get_midx_checksum(m)));
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
@@ -166,8 +153,11 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 		die(_("multi-pack-index required OID fanout chunk missing or corrupted"));
 	}
 	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
-	if (read_chunk(cf, MIDX_CHUNKID_OIDLOOKUP, midx_read_oid_lookup, m))
+	if (pair_chunk_expect(cf, MIDX_CHUNKID_OIDLOOKUP, &m->chunk_oid_lookup,
+			      st_mult(m->hash_len, m->num_objects))) {
+		error(_("multi-pack-index OID lookup chunk is the wrong size"));
 		die(_("multi-pack-index required OID lookup chunk missing or corrupted"));
+	}
 	if (read_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS, midx_read_object_offsets, m))
 		die(_("multi-pack-index required object offsets chunk missing or corrupted"));
 
-- 
2.42.0.352.gd9c5062ff7.dirty

