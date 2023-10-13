Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5AF262BF
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EUCQND5a"
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DF0CE
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:40 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3af5fd13004so1607048b6e.0
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697225139; x=1697829939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M85EuHX7xw/EodNm4yfeLAowWD6UW8lizY0TRLvsMVE=;
        b=EUCQND5aA+Oet7XhZ3f+gG1LQnQhB+W8Euvc1H7i7xP1gESs5mHyN+gw57n6+AbkwW
         2yZCU/g9EDpMvVtYWT0NftVLSgqlXbPVeqIedOh3hRllqLiIgO1PSoEi5ToptOTrVsOZ
         snPMQ7moEtzdOb/MARFdbV21YxVzamfTxeuDbNBHkIKo2ya//dtaxbV4H5SJa6aPU7r1
         a6x3TVv+VC42Pt6nomko+LI/D7lkrsT7LkBpF9fCCbyP5TYFkpZWL95400rEbacK4cBV
         Xl4mhES634LNuW5aL0tZ3y3HxRQa94m0uhyuYVqiy3p1vYrOtgbO/oDtjdhTE/gcEvH3
         ZQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697225139; x=1697829939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M85EuHX7xw/EodNm4yfeLAowWD6UW8lizY0TRLvsMVE=;
        b=GE+o2fWDP3ElIjphaLZjeuAWBbiwtnPQb80w+y14CAc4wOmWXCEk4tLLIqnFFb4+VG
         AZOUmdZHkpLvvdeCDiBZAovLXvNEGcs4npUZiflLPAHKDPlVoHpqQk41JLtSqvES5Fi7
         UUDmBirg5wa7Ei3gG8jScjK7XwiR4eVrhbRYwnjheJDKUck3JOIzcGZB0hjCJjmtKKf0
         ZMXUDbPYlSNzi+v3mjiYVp5oBeL4XlOgn35auHqnRIfEktTO6lZ9ofOgrLbvcrjLsTx3
         tiEr9+WFjRhvPOdnrTNDfxpHu+Uwt0yxfFD2A+S/pwtOoBBq0k7+inANvDCFlIzpx1l+
         Js9g==
X-Gm-Message-State: AOJu0Yy0mdtnYTHoL6qT8AbMqkBujAxHEMI8s4MQV1eKpLhxPQaG0zQ4
	w8764mZiwxkxnpR+8kAf30IyUP+GSiOFE/TRzfsHFQ==
X-Google-Smtp-Source: AGHT+IHGAsZzqBRmvNTNpdzMUEy2NXexfFtchUrfLpiicSZDvxih8B+XVYq22bUfthYCtw1T3/6qvQ==
X-Received: by 2002:a05:6808:152a:b0:3ad:f4cc:79a5 with SMTP id u42-20020a056808152a00b003adf4cc79a5mr36111957oiw.33.1697225139357;
        Fri, 13 Oct 2023 12:25:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id hg3-20020a05622a610300b004166905aa2asm821240qtb.28.2023.10.13.12.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 12:25:39 -0700 (PDT)
Date: Fri, 13 Oct 2023 15:25:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 8/8] midx: read `OOFF` chunk with `pair_chunk_expect()`
Message-ID: <a920f426ed9442b7e2ddc4de5d827e393a20c2f3.1697225110.git.me@ttaylorr.com>
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
OOFF chunk in the MIDX machinery.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/midx.c b/midx.c
index 74167b8fdb..4aeadd5e00 100644
--- a/midx.c
+++ b/midx.c
@@ -61,19 +61,6 @@ void get_midx_rev_filename(struct strbuf *out, struct multi_pack_index *m)
 	strbuf_addf(out, "-%s.rev", hash_to_hex(get_midx_checksum(m)));
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
@@ -158,8 +145,12 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 		error(_("multi-pack-index OID lookup chunk is the wrong size"));
 		die(_("multi-pack-index required OID lookup chunk missing or corrupted"));
 	}
-	if (read_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS, midx_read_object_offsets, m))
+	if (pair_chunk_expect(cf, MIDX_CHUNKID_OBJECTOFFSETS,
+			      &m->chunk_object_offsets,
+			      st_mult(m->num_objects, MIDX_CHUNK_OFFSET_WIDTH))) {
+		error(_("multi-pack-index object offset chunk is the wrong size"));
 		die(_("multi-pack-index required object offsets chunk missing or corrupted"));
+	}
 
 	pair_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets,
 		   &m->chunk_large_offsets_len);
-- 
2.42.0.352.gd9c5062ff7.dirty
