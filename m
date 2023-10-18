Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AC43D396
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="g1O031Wa"
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE1635B5
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:17 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7781bc3783fso139538885a.1
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697648890; x=1698253690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y7ZwlZkHGjvPzOo7/TXew226gbAp53JBC9TkQu6Y0uA=;
        b=g1O031WaJaih77acUXbC/s3q6PJs2p+J72phsIracXhMN5zvznzbECPY8XcFMMrXXM
         V9si9e4G8NFB4Z399PngtLXOoq122fLjR+BHyFNV5o57YXPL/z7WZMhQdniPdH0fvSwV
         h7NT2xOg3+d4YB733CtnTeXuQCbLrHMAD3L8HQvLfG8CTBAERtXc+xk8W5OwRTeXuf/l
         VGxnnQJPCDt/YIcfXrzaqeqQXY3Zgjc+myH8gx5LDHopPuRnJ0i49ciIy0PCwPulXokg
         gVn+JDv4gUClVRX8xq83eWx35ArQh+xwTkfHTVHvYc1fG88GzoQjzEApXyqGbzrJ050s
         kofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648890; x=1698253690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7ZwlZkHGjvPzOo7/TXew226gbAp53JBC9TkQu6Y0uA=;
        b=MTt0CsBx7Duf72ejGcob6IljD8fRrXQNPVlISS8i5ER5CEWyg+9kiWylPJVgXN62xM
         Vjq48kvSJ/IQTIIYXTg/945Jr4px1VmFcyfQq1LVz/bMu9YDS7x0R5meErT1k48+YNTi
         Hz0MYf4Hb82av03Sv0c0DT55XA0k3MrDgFNiipKgwJhvLMbIBUx3RCZE0hGh9Lato7E+
         Eif2q5ymvMy/fkcGfKnz0t6rqCAkXSXlILN5a50fqWZt1k1r28a74VMUJw8L6vYtKK1Y
         zFmoiAWZ6QuPwFK/LI+e0cwD8d91XELU/DgqYz/VTTfqvbWbgExxtbOx4Bq5DQpm1B6L
         IA3g==
X-Gm-Message-State: AOJu0Yw1hAbRdNG9LmXcxMqr71LzrSfae8S5Webd5F+PJ47OKVVnE7f4
	jga10winaBhRY1fMKSOAsPzq2nfgcnzalIvWePMY/A==
X-Google-Smtp-Source: AGHT+IHkIRVSsGt7RETl2PQ91C6hQzkyfLPrZPktxTF+DLvrHNJpjsM1uqGIyKG6TYpp6/EiGSAgUw==
X-Received: by 2002:ad4:5b8f:0:b0:668:da55:6c17 with SMTP id 15-20020ad45b8f000000b00668da556c17mr6909231qvp.49.1697648889977;
        Wed, 18 Oct 2023 10:08:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w11-20020a0562140b2b00b0066cf09f5ba9sm92912qvj.131.2023.10.18.10.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:08:09 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:08:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 07/10] bulk-checkin: generify `stream_blob_to_pack()` for
 arbitrary types
Message-ID: <04ec74e3574b8e0cfc503c46fa3481ef196348ac.1697648864.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697648864.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697648864.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The existing `stream_blob_to_pack()` function is named based on the fact
that it knows only how to stream blobs into a bulk-checkin pack.

But there is no longer anything in this function which prevents us from
writing objects of arbitrary types to the bulk-checkin pack. Prepare to
write OBJ_TREEs by removing this assumption, adding an `enum
object_type` parameter to this function's argument list, and renaming it
to `stream_obj_to_pack()` accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 133e02ce36..f0115efb2e 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -204,10 +204,10 @@ static ssize_t bulk_checkin_source_read(struct bulk_checkin_source *source,
  * status before calling us just in case we ask it to call us again
  * with a new pack.
  */
-static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
-			       git_hash_ctx *ctx, off_t *already_hashed_to,
-			       struct bulk_checkin_source *source,
-			       unsigned flags)
+static int stream_obj_to_pack(struct bulk_checkin_packfile *state,
+			      git_hash_ctx *ctx, off_t *already_hashed_to,
+			      struct bulk_checkin_source *source,
+			      enum object_type type, unsigned flags)
 {
 	git_zstream s;
 	unsigned char ibuf[16384];
@@ -220,8 +220,7 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 
 	git_deflate_init(&s, pack_compression_level);
 
-	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB,
-					      size);
+	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), type, size);
 	s.next_out = obuf + hdrlen;
 	s.avail_out = sizeof(obuf) - hdrlen;
 
@@ -402,8 +401,8 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 
 	while (1) {
 		prepare_checkpoint(state, &checkpoint, idx, flags);
-		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
-					 &source, flags))
+		if (!stream_obj_to_pack(state, &ctx, &already_hashed_to,
+					&source, OBJ_BLOB, flags))
 			break;
 		truncate_checkpoint(state, &checkpoint, idx);
 		if (bulk_checkin_source_seek_to(&source, seekback) == (off_t)-1)
-- 
2.42.0.408.g97fac66ae4

