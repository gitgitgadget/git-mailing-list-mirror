Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D613C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F3664E90
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhBXTOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbhBXTMY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:12:24 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44687C061356
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:10:21 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id s15so2299200qtq.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OdrrVVdY9eTH+bR/GFmli0pijBOQNZeXKRXpgiM9zIs=;
        b=0o5AXxiBbrLIPRwnAxKRngtenMAW+e3kG+pj+Rmhv4ZMYndPwf3dNtHO7Ce5AC6hg4
         rtU5MVu4676G/+LN9oaYuh/CcP0kr5Cc2Eq3uJk1Gbg5x8VUp0rEQVBa70ZbDIhxNZnH
         xiZcGgaLJdxQ6lHyh/K/ziF4jfdrBuRuMaNec3fPWjg4g8hcsWNBzTbaQYUnZl5iFweB
         H9ua96w2tNRs9Zz/oULZDEHQ2pQ8Hh5SL2YYlECQXXPZ48Fmnlt/q0+S7jb3fY6UR/aS
         qIQZJKChNw1gSuot0qbqVjsJZMqv5xP++ipICBLnnCwbuzbcQkWopPdcS/hErR3HSfLg
         G47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OdrrVVdY9eTH+bR/GFmli0pijBOQNZeXKRXpgiM9zIs=;
        b=Rukox5IfpLR7PPTAVCEHxSnKrC39cf8jmF7PvkDSzH9B+nrlKPT5lxLokKBBGYmwJP
         leU2Y6p6bXi6nRvPxkHONdtnH+5nrNTZaEOxroXMMybi8A11OqaJOp/G84sqAbFYQYU/
         mntynBttZCxfZ5rfNeHdfDtd/8Bu0vCCI2T6MdT6apG1icTRqTOhj1fX78e+ocsHMtAv
         GH1/CIJM8VNTI7aZ4xrq5RmkRAmanMxeCrgg5YokaTW3XfXMTFW/UrH5e6zO/LYFj9Px
         8glQpvdjlsftRxvy42CuiXQ5tvvd8gXpJ4H5n0DMFbV+WBoMeJquvYVtInk0fZaLtAIk
         NKOg==
X-Gm-Message-State: AOAM533JiEquTWBoTb9sAQGkUnSLP9zTF2WY10RnJqw8b3soAl8v1mPF
        ortHUegOs3t16ZS2a0WRJPCn23novWfr9rbU
X-Google-Smtp-Source: ABdhPJymttxKqewFsADMdDLVh7/S/Y8qII4bX2gs+mhJi7/i7D4rTarL2xtUippsI5PZ2ybRIX/Qiw==
X-Received: by 2002:a05:622a:3ca:: with SMTP id k10mr31439845qtx.270.1614193820245;
        Wed, 24 Feb 2021 11:10:20 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:268b:c46e:d22e:db6b])
        by smtp.gmail.com with ESMTPSA id l60sm1893383qte.13.2021.02.24.11.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:10:19 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:10:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, avarab@gmail.com,
        gitster@pobox.com
Subject: [PATCH v2 14/15] pack-write.c: extract 'write_rev_file_order'
Message-ID: <ab7012b283bd6a3d6bb16b5ffeec11acf6a4ab43.1614193703.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1614193703.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614193703.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Existing callers provide the reverse index code with an array of 'struct
pack_idx_entry *'s, which is then sorted by pack order (comparing the
offsets of each object within the pack).

Prepare for the multi-pack index to write a .rev file by providing a way
to write the reverse index without an array of pack_idx_entry (which the
MIDX code does not have).

Instead, callers can invoke 'write_rev_index_positions()', which takes
an array of uint32_t's. The ith entry in this array specifies the ith
object's (in index order) position within the pack (in pack order).

Expose this new function for use in a later patch, and rewrite the
existing write_rev_file() in terms of this new function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-write.c | 39 ++++++++++++++++++++++++++++-----------
 pack.h       |  1 +
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 680c36755d..75fcf70db1 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -201,21 +201,12 @@ static void write_rev_header(struct hashfile *f)
 }
 
 static void write_rev_index_positions(struct hashfile *f,
-				      struct pack_idx_entry **objects,
+				      uint32_t *pack_order,
 				      uint32_t nr_objects)
 {
-	uint32_t *pack_order;
 	uint32_t i;
-
-	ALLOC_ARRAY(pack_order, nr_objects);
-	for (i = 0; i < nr_objects; i++)
-		pack_order[i] = i;
-	QSORT_S(pack_order, nr_objects, pack_order_cmp, objects);
-
 	for (i = 0; i < nr_objects; i++)
 		hashwrite_be32(f, pack_order[i]);
-
-	free(pack_order);
 }
 
 static void write_rev_trailer(struct hashfile *f, const unsigned char *hash)
@@ -228,6 +219,32 @@ const char *write_rev_file(const char *rev_name,
 			   uint32_t nr_objects,
 			   const unsigned char *hash,
 			   unsigned flags)
+{
+	uint32_t *pack_order;
+	uint32_t i;
+	const char *ret;
+
+	ALLOC_ARRAY(pack_order, nr_objects);
+	for (i = 0; i < nr_objects; i++)
+		pack_order[i] = i;
+	QSORT_S(pack_order, nr_objects, pack_order_cmp, objects);
+
+	if (!(flags & (WRITE_REV | WRITE_REV_VERIFY)))
+		return NULL;
+
+	ret = write_rev_file_order(rev_name, pack_order, nr_objects, hash,
+				   flags);
+
+	free(pack_order);
+
+	return ret;
+}
+
+const char *write_rev_file_order(const char *rev_name,
+				 uint32_t *pack_order,
+				 uint32_t nr_objects,
+				 const unsigned char *hash,
+				 unsigned flags)
 {
 	struct hashfile *f;
 	int fd;
@@ -262,7 +279,7 @@ const char *write_rev_file(const char *rev_name,
 
 	write_rev_header(f);
 
-	write_rev_index_positions(f, objects, nr_objects);
+	write_rev_index_positions(f, pack_order, nr_objects);
 	write_rev_trailer(f, hash);
 
 	if (rev_name && adjust_shared_perm(rev_name) < 0)
diff --git a/pack.h b/pack.h
index afdcf8f5c7..09c2a7dd3a 100644
--- a/pack.h
+++ b/pack.h
@@ -94,6 +94,7 @@ struct ref;
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought);
 
 const char *write_rev_file(const char *rev_name, struct pack_idx_entry **objects, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
+const char *write_rev_file_order(const char *rev_name, uint32_t *pack_order, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
 
 /*
  * The "hdr" output buffer should be at least this big, which will handle sizes
-- 
2.30.0.667.g81c0cbc6fd

