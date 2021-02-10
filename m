Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FECC433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8FE264DD6
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhBJXFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbhBJXEx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 18:04:53 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E7FC061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:03:30 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id e15so2860013qte.9
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OdrrVVdY9eTH+bR/GFmli0pijBOQNZeXKRXpgiM9zIs=;
        b=Oj37yecdCUl3sk8TbzPem2qy9iM5Yg1bpsRQzWPnKV7qCHOtr28054HWih2FZ8klcN
         OqbWnGft7EWys2+iAFyvoEnDrQDKSTBMPpp7T4oLe3IF2r1mleOBakp0VoaZp0gSBsFq
         r7ArqJLHBxBV7ra/tQTc4CwxdLKY1kf2iB9y4ugzogr5cNmL8M8h/u551Z96heUmQ75V
         G+S0GrWvcXGUS+THmAq6bbFfLuTwEtRoarFcjsLEvHlSmokA7EN4BypgVNsyUuP/P/hl
         ZURiUurJ777s7s4mgSXy2FPAvduj2lhfkThfCxN6VOgygZkBILp7oNahKlpTlXSCP+5/
         Ociw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OdrrVVdY9eTH+bR/GFmli0pijBOQNZeXKRXpgiM9zIs=;
        b=tr9mynse7uDXhdtcKiI5UjoRJtUEvWQOdA36hsL0K6SJVRddaXMBsJO4lsbd1ponfN
         rEzsL0gjlpkGFpAG8HFpo4R9yTY4zfjA4LYD5qIJz+NdPT8ooIUehSCbU1jxSbZp2A97
         PTpI8275ys0ba94c6NQXE5u/QBqddZMpcveMNF/XuYU0VPYhHdLQ0GUDhC4lS+oCKCem
         xCwbZDmImx1wWoENJ1pkWuqe1basqcsAEuAmKHRapQRrSfDm8F6Fe11+J5ChkyoVm/5g
         ak7Qgea4QmT7mU064/fEYntC5ZqQfdVSfuoB7ew1/YAyDR7NnRbNtTTRnWi1Iq9/+QGg
         auXg==
X-Gm-Message-State: AOAM533sAoXeJPiGZp8q7E7E+An48Jdxb3cXQYV6VhwIHLlk88ZItoV5
        n7KUPh1d961fDLMA2gctTEAh2UnbYITHpUei
X-Google-Smtp-Source: ABdhPJyYarmGxmT0JHPMRMQlln1sw0KKzzUcwz2GmSnZkrcTnyFGY55T/E4reuPLG42xD/VbVJuqaA==
X-Received: by 2002:ac8:e82:: with SMTP id v2mr4956288qti.164.1612998209327;
        Wed, 10 Feb 2021 15:03:29 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2c3d:3179:bfad:c65])
        by smtp.gmail.com with ESMTPSA id l35sm2308090qtd.90.2021.02.10.15.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:03:28 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:03:26 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 8/9] pack-write.c: extract 'write_rev_file_order'
Message-ID: <4829b93f42955f417d7ccdfffeee2393313a347e.1612998106.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1612998106.git.me@ttaylorr.com>
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

