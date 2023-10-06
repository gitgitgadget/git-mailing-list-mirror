Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FE7E94133
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 22:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjJFWCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 18:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjJFWCC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 18:02:02 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B8DC6
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 15:02:01 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7741c5bac51so164523585a.1
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 15:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696629720; x=1697234520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PEfiUoaCsKtEaNT9T49KMG0BkYQOfIczSGf0JPJ2QGE=;
        b=mGSpu1CSra9+IrOTwNVjmUvxV1IvOePEtSQfoUELfv0s3oPoPHLAjwNJu8pSx+Jipc
         HqP6yH4tvDYDiZ1peCNz/dK8Y748g1ZEyis0xYomh3KlYRqejgkaN9aGWjz278nAulWR
         ZMmxlgyqEDng0aJpBfcDLMaOVdAzNlv2KSrhJPiGjbCVzG7OnsPI9W6wjUl5k4DsqRhA
         ejtLtNSfUlo6TjNblcoF15yIFpw/nbQseJhaNiKql642X/jkIsF5KFsAkOC8CXjXXG3J
         iWvw8Fw2VucWVca0Fro5Mz7gg0YywUWcvslInhwLjlfUBLSVy5ELtx+KJCtUuUs4Sc64
         W3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696629720; x=1697234520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEfiUoaCsKtEaNT9T49KMG0BkYQOfIczSGf0JPJ2QGE=;
        b=rzkEeoSg543YVsLjjRr5yk45B/XSzAXrt0ZtzkaWBOMBaelaTYZvIWCSg3PjWJVILA
         E9P6jbTBubP1/nj9yOUcynV0osSsfIi9utQ+q1/0NTuSEP5reqWk1Oo8IDXxP7LyJ5pc
         q83IKhjUlCzWjheeZt0jXmjNd4N682gPAh0fWhZQqQ5UlpL0vr9KFQ+53VbWTIBFX8gO
         PEF2FTVTy4j+0IaeT2m5JYRVuIalQh1HIGfybOggZiJfBxxfJjWkLqU8MpwHxa5d931y
         u7fO2815ZOOFEFU+G7OE5KU0ilxVA8uH3s+JGfps2jcq51tKRkRIQWSyJzBXeJuaHbpX
         ZuEw==
X-Gm-Message-State: AOJu0Ywbv/MWDyv+3g2wGdmhaW8DtJEly7aJzImNwE904IJfSUQ7NIqd
        YNen/OB9YCVqtEOciGV48YlH9OaaBLKwUJXzrNhP1A==
X-Google-Smtp-Source: AGHT+IGsqz/allKA+wGYUWuXOBNE+h72I/uQHIZ1LHFkao4YMjYIblnNJ+7DzUOfUpqRw+OkVY10nA==
X-Received: by 2002:a05:620a:444c:b0:775:9bc3:c492 with SMTP id w12-20020a05620a444c00b007759bc3c492mr12217442qkp.7.1696629719875;
        Fri, 06 Oct 2023 15:01:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v9-20020ae9e309000000b0076d25b11b62sm1615988qkf.38.2023.10.06.15.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 15:01:59 -0700 (PDT)
Date:   Fri, 6 Oct 2023 18:01:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        "Eric W. Biederman" <ebiederm@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/7] bulk-checkin: factor our `finalize_checkpoint()`
Message-ID: <9c6ca564adf297e77e3304ef06692b8c82cddfd6.1696629697.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696629697.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as previous commits, factor out the routine to
finalize the just-written object from the bulk-checkin mechanism.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 2dae8be461..a9497fcb28 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -289,6 +289,30 @@ static void truncate_checkpoint(struct bulk_checkin_packfile *state,
 	flush_bulk_checkin_packfile(state);
 }
 
+static void finalize_checkpoint(struct bulk_checkin_packfile *state,
+				git_hash_ctx *ctx,
+				struct hashfile_checkpoint *checkpoint,
+				struct pack_idx_entry *idx,
+				struct object_id *result_oid)
+{
+	the_hash_algo->final_oid_fn(result_oid, ctx);
+	if (!idx)
+		return;
+
+	idx->crc32 = crc32_end(state->f);
+	if (already_written(state, result_oid)) {
+		hashfile_truncate(state->f, checkpoint);
+		state->offset = checkpoint->offset;
+		free(idx);
+	} else {
+		oidcpy(&idx->oid, result_oid);
+		ALLOC_GROW(state->written,
+			   state->nr_written + 1,
+			   state->alloc_written);
+		state->written[state->nr_written++] = idx;
+	}
+}
+
 static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 				struct object_id *result_oid,
 				int fd, size_t size,
@@ -320,22 +344,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
 			return error("cannot seek back");
 	}
-	the_hash_algo->final_oid_fn(result_oid, &ctx);
-	if (!idx)
-		return 0;
-
-	idx->crc32 = crc32_end(state->f);
-	if (already_written(state, result_oid)) {
-		hashfile_truncate(state->f, &checkpoint);
-		state->offset = checkpoint.offset;
-		free(idx);
-	} else {
-		oidcpy(&idx->oid, result_oid);
-		ALLOC_GROW(state->written,
-			   state->nr_written + 1,
-			   state->alloc_written);
-		state->written[state->nr_written++] = idx;
-	}
+	finalize_checkpoint(state, &ctx, &checkpoint, idx, result_oid);
 	return 0;
 }
 
-- 
2.42.0.8.g7a7e1e881e.dirty

