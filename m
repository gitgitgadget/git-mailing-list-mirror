Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062F3C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E27C860FE9
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhFUW1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbhFUW1n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:27:43 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C73C061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:28 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id z1so6810010ils.0
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sre3Q6XvNNpfuISWO9VaDHBk4aYBbs63EGuy0S0Dpb0=;
        b=aUL23VQ/eZQtJU8WgX8evO0AlrGyPb+9/RPxE4iF4sXfXh7+RLZBpK5QJcIHsFlKFV
         7lEau7rwZkGewqCaOnXzhHqOKos3dNlpxh7PeomR08VxlJAKWyQc8fw/4bkU0mVOBOmu
         2MKV6M7UItvfnAAc9+PnBYUda4/sNRq+wbtln0/tBq1BSXIescAMjFK3zBH/bbYPJwD4
         4gjzpZ7/MGZ4vWJ9HxZaThReYt+fs7URP4ap+QjjCSgT2z2qwBdXkvG5rhQHvWW9VkNM
         onCsTCwyI7sP2kLlYBJO4sK0VuOV7Gexh9Q6nxeKE58ZfYnuPo50B2nuKzwnsUVen1Fm
         GGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sre3Q6XvNNpfuISWO9VaDHBk4aYBbs63EGuy0S0Dpb0=;
        b=RvAKN1cCwZjy7JAgK9ba4rTE6oqWyzS/5yeNoLKyPG6G1SnZ7CKbe1OW41tgNY08Rz
         CIRfTXDuAiBJO4rBWmTrgofHHtgTCIM9CT8BNY85Z4NnsZFYFOo2+sId4bKd4NkdL1fm
         UQTpwuXPCVgymGrVXU1O4q+fG91CFFTgaplSZQgSaqPzNs/Yg7TSJlFx/eJfyFJGvW9k
         XwtSOMHIc+hcppsA+YxfquHjEHQcyJmvCje5XP97aZU/kfxyR4k9dajOUEKuMIFFasF8
         Vw6hGwO+ATNldiPUvAMuZx+eYhWf+EtDkw1ENvaFuX5EKDxGFKj5+qNR/G1vVTZpqIIF
         sNcQ==
X-Gm-Message-State: AOAM533fYaVa3KvOOrAqTqAlWDjQaZmEt8Pd509sjo+Q6Xnfv1qHUd8P
        t66miJJHQtj1ZDnHecL9j3D3/33U0BfIjfSd
X-Google-Smtp-Source: ABdhPJyoGBjAgz2xfWcCW7enSonVLUJbelXQbjPxXpUGEAuv/gAa0NLubyed8a+BLCnpCwAIeT18gw==
X-Received: by 2002:a92:dc48:: with SMTP id x8mr343255ilq.213.1624314327629;
        Mon, 21 Jun 2021 15:25:27 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id u14sm3394968iln.43.2021.06.21.15.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:27 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 11/24] pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
Message-ID: <ac1f46aa1f0dbc7fba45229555b11b390fe104a0.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent patch to support reading MIDX bitmaps will be less noisy
after extracting a generic function to fetch the nth OID contained in
the bitmap.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 2dc135d34a..9757cd0fbb 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -223,6 +223,13 @@ static inline uint8_t read_u8(const unsigned char *buffer, size_t *pos)
 
 #define MAX_XOR_OFFSET 160
 
+static void nth_bitmap_object_oid(struct bitmap_index *index,
+				  struct object_id *oid,
+				  uint32_t n)
+{
+	nth_packed_object_id(oid, index->pack, n);
+}
+
 static int load_bitmap_entries_v1(struct bitmap_index *index)
 {
 	uint32_t i;
@@ -242,9 +249,7 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		xor_offset = read_u8(index->map, &index->map_pos);
 		flags = read_u8(index->map, &index->map_pos);
 
-		if (nth_packed_object_id(&oid, index->pack, commit_idx_pos) < 0)
-			return error("corrupt ewah bitmap: commit index %u out of range",
-				     (unsigned)commit_idx_pos);
+		nth_bitmap_object_oid(index, &oid, commit_idx_pos);
 
 		bitmap = read_bitmap_1(index);
 		if (!bitmap)
@@ -844,8 +849,8 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 		off_t ofs = pack_pos_to_offset(pack, pos);
 		if (packed_object_info(the_repository, pack, ofs, &oi) < 0) {
 			struct object_id oid;
-			nth_packed_object_id(&oid, pack,
-					     pack_pos_to_index(pack, pos));
+			nth_bitmap_object_oid(bitmap_git, &oid,
+					      pack_pos_to_index(pack, pos));
 			die(_("unable to get size of %s"), oid_to_hex(&oid));
 		}
 	} else {
-- 
2.31.1.163.ga65ce7f831

