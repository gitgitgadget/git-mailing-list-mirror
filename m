Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E09BC4332D
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E3C64FFD
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhCKRF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhCKRFh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:05:37 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B5AC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:37 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id j7so1663074qtx.5
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iHZGzO8Jecmr9vlHZnZ2tnw49/4/HdyfZGEjBh6XtVQ=;
        b=s5App8Cwzrk3eytwCziKcfHs1ktStJE4xMfksY+TRsT0s9vb3guUPKQ9BF5t0S1Bu0
         CSBYen0AlI3kIcn5HDn76XITBQH9g/532JhrV4/nuBKq44AaFmp6hzxi9NKTsHE1OGkT
         IX60zEM/u855qhhxKMB2UiWTEruRQ8LbfH9l7LZE4R5lrT/uoVB9Mj7c9kY9wPOgxMQs
         2jdC9k3CjFIecq3lSYpxp2L5/4uUrz+Tdiep6gfZ6YFS6UIEQXubJ5w7CfPErhozSFf3
         Axo1beOdwqb393ui3eCI+Pl5goBTZCm5oJuK9kFE/4zaogXxNmmv7YTfADDGQrtriZGg
         ID4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iHZGzO8Jecmr9vlHZnZ2tnw49/4/HdyfZGEjBh6XtVQ=;
        b=LI2hUl9fX8vRLp7unqTSOsr0bX057Zzm9FJpIp3KU96SEl+fHSZaM4GVQb9sLYFLMv
         pumG1u0Np7U2KCkcDlIAoihgd2dpXj2qXVOIACMzdl96V+Ech8s7DbNri6p1iIsqIdeu
         +mFQbGAFKozmcHWE8UbSN0TGgwKp+VxU1qHk+6uxREoXodP/rKdRPsiQ8lxmVWuhM0M7
         dqPFMvWzHcqTahPNPBRXvQ2IO10ToMT+0PY2Hmx1Ul0hyM5bRI97B3L2Hs88MUAuKGvs
         fknrTwBmhegwzXcspp71yc70RrdUVb6hcl04p0hfFllXv6HuIEOGkMpBcbwFtLSqxV6A
         l5ag==
X-Gm-Message-State: AOAM5302eBT1YVgG0DQKo+qUeHqzxWUspGSnq4aCxr/FvocIL45Gxf4w
        lNyzXtfx6s2MRd3AB5Ur90QxYss50XmDpeIQ
X-Google-Smtp-Source: ABdhPJwydU6mVF7Yfv1LxL1IjwTVIdd2a7kXyr88Ct1JoISpKGpDLzhiA/C0dIXtGUwSRJh6g3YgDA==
X-Received: by 2002:ac8:5a0d:: with SMTP id n13mr7885460qta.345.1615482336360;
        Thu, 11 Mar 2021 09:05:36 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f947:1686:6ada:db5b])
        by smtp.gmail.com with ESMTPSA id y1sm2294554qkf.55.2021.03.11.09.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:05:35 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:05:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net
Subject: [PATCH v3 14/16] pack-write.c: extract 'write_rev_file_order'
Message-ID: <f5314f1822ec9deb44bc78baa01b46a780581c53.1615482270.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1615482270.git.me@ttaylorr.com>
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

