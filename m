Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DED3C433E5
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B17619D3
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhC3PE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbhC3PEc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:04:32 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A43CC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:32 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e8so16765823iok.5
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iHZGzO8Jecmr9vlHZnZ2tnw49/4/HdyfZGEjBh6XtVQ=;
        b=wgmvkB37z7YSVqeK422WpciZrQSss+edb6C5EDpJ18evLx6VDaJaXGoxDtrdkiBoOw
         TMyxu4naN2VpCREoP/ixxlPD8vG/PMwhJ9nf71qqn/qFXM15D+RzDArR/Lc+NdNd/hHJ
         kTQK/IXzcKXb1o7Arx8FZvdCh0RtRUQyifRQmUf8I74U+p7Flb3rhAN9blFty0TK4trY
         jeoram3pMxhbdr1NETsiPOaGMJhsPH80KMLjmQxB0ztE7XDNX/ZoxBebGIfBGkno/1Fx
         UakrhULVrw1k5PrmUT2uqoO3KdZaAC6Rd5JlscYy9chgNC4AtiykWTBxV6sLQVALoSSh
         7Dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iHZGzO8Jecmr9vlHZnZ2tnw49/4/HdyfZGEjBh6XtVQ=;
        b=i3r81ylsDBcmb9ZlDZ/czT2LsZJpIKQeMy0FQosevjNAzApVA+4MPXEHK/ORlDRYlo
         WTzlFwylzMUxcfd3IkJaETR/De4OB27pkPhKzCR1R3thYXWfPjjK74kJaG93wNGV8RHz
         kY5G5ihi2C+7DU9+SZC6hueYgmf3mVA0TPyn3orMjNlsNBGj2EpGlaQdDTzLOFw03X5S
         Xf9c8GkzKPAgSz4Q05iDraZ7fX0h8UirxxbGvM/GyIognarHOLfDAPZtkRoQ2d8fDW51
         /7NLQIe1vgghKf6vEcm5qAkw9c8mwHAqELO9zqUc/mE+++I5LCQFIL7CGVycMT5ihCrn
         le4g==
X-Gm-Message-State: AOAM530h5rQMPhVcaLzirdLRCp+sGRWSvi690BrCDhSLLiM2LDFM5yCH
        D43Hk/r+7N9dLPT1YrfoaJVf6Xz57x4UpQ==
X-Google-Smtp-Source: ABdhPJxgXP5ZcpeOCnF54xNzjz5K/nHsGorRu/mt/Ions6SQHXXyYgfZm6RSzWX5BgreDjWsO6pPtw==
X-Received: by 2002:a5e:cb4c:: with SMTP id h12mr24140210iok.183.1617116671227;
        Tue, 30 Mar 2021 08:04:31 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id u10sm11419022ill.30.2021.03.30.08.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:04:30 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:04:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: [PATCH v4 14/16] pack-write.c: extract 'write_rev_file_order'
Message-ID: <9f40019eb3d3315cb03440e6237bced4feb6cf67.1617116623.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1617116623.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617116623.git.me@ttaylorr.com>
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
 pack-write.c | 36 +++++++++++++++++++++++++-----------
 pack.h       |  1 +
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 2ca85a9d16..f1fc3ecafa 100644
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
@@ -228,6 +219,29 @@ const char *write_rev_file(const char *rev_name,
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
@@ -262,7 +276,7 @@ const char *write_rev_file(const char *rev_name,
 
 	write_rev_header(f);
 
-	write_rev_index_positions(f, objects, nr_objects);
+	write_rev_index_positions(f, pack_order, nr_objects);
 	write_rev_trailer(f, hash);
 
 	if (rev_name && adjust_shared_perm(rev_name) < 0)
diff --git a/pack.h b/pack.h
index 857cbd5bd4..fa13954526 100644
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

