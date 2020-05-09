Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD7C47247
	for <git@archiver.kernel.org>; Sat,  9 May 2020 14:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAF721473
	for <git@archiver.kernel.org>; Sat,  9 May 2020 14:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp2fWgFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgEIOYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 10:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727952AbgEIOYf (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 May 2020 10:24:35 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA3EC05BD09
        for <git@vger.kernel.org>; Sat,  9 May 2020 07:24:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m24so3480255wml.2
        for <git@vger.kernel.org>; Sat, 09 May 2020 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6oMiC5HfMt17+yhDMimQ4CYPwwr8sDw5Rq+k+C87Z9I=;
        b=Rp2fWgFS/XoZ021gemsg/H1AjnMTL2o24Uq5FqUQr8rZ5V81wBvTUtvzsVTirPnMl2
         jaMf4J0nwIGD7S4afouw/RA4a9w798LgPd9TfzYcn3HiIW6v6aB+1RKv6Nx2MuZlgVja
         6EBabneKrqXebES3tcOIvF6kxBn4Ok6KLhPUEdJKMT7fwTWsKGaA2+DWwBtvtmw9poPP
         PU8+i9odYQnitiWM14ayyOdNJvnI3UQIbm5H1XEUm8eNPVhXH86790bVGGGE89eHKVjD
         zqfEspX3L8b/CLRxPV2D4HO7JzY2V1lJbm1YZJx57Ik7QRVRYnT6TrEbOD+UjYg7nUab
         ROVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6oMiC5HfMt17+yhDMimQ4CYPwwr8sDw5Rq+k+C87Z9I=;
        b=E9O+1cc8nZJZOsZDghGAWdKXx58tVbgP1ZeXDxfCHXij+Vsc5cXLJO9qzo46m2U60y
         ADsVNT0DzT6/zxD+Dgy30QU9b6nFkMxg/4ad0et+BkteNEzKIcGxFWcyTMWC9rMfVgC8
         wPyJAS8E7uqRwivW87HUtWbYNhiMKljQpPC1aeZUisLIIjZknleLR6fzHdfEVSdvLzjq
         9XcnQJf1aDmOaZsNakXmdJKOxtZvr1hCzQ62XsNc9zJDUB2Ddj8nPpcd5xvHqIHqh3o8
         FI1tV2Sf3e6v91YN0IOR7SqrVsxffhq6Z7IMXvkXovrvxBYxjxtXTgj2EXNekahi+hoi
         ue0A==
X-Gm-Message-State: AGi0PuZYZAeF/QvRC26H5WgUStJlATNwXYRzws1C45ADgks7wKkZQYAG
        dRCbbn7OX0O1Woc5IaqmKvDimgc9
X-Google-Smtp-Source: APiQypIXpZS7uxy1KhfS/KVHoGMisvXiHAzVz744XedeE6vPRBi5OKoa+3m4u251fISk1G+chuPEFQ==
X-Received: by 2002:a1c:990d:: with SMTP id b13mr21116632wme.179.1589034273795;
        Sat, 09 May 2020 07:24:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm8128724wrm.8.2020.05.09.07.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 07:24:33 -0700 (PDT)
Message-Id: <efeb3d7d1321e53e05079f296a5db5ab87f5fab2.1589034270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
References: <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
        <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
From:   "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 May 2020 14:24:30 +0000
Subject: [PATCH v3 3/3] Ensured t5319 follows arith expansion guideline
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Son Luong Ngoc <sluongng@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Son Luong Ngoc <sluongng@gmail.com>

As the old versions of dash is deprecated, dollar-sign inside
artihmetic expansion is no longer needed.
This ensures t5319 follows the coding guideline updated
in 'jk/arith-expansion-coding-guidelines' 6d4bf5813cd2c1a3b93fd4f0b231733f82133cce.

Reported-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
---
 t/t5319-multi-pack-index.sh | 38 ++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 67afe1bb8d9..065f48747f3 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -62,8 +62,8 @@ generate_objects () {
 	} >wide_delta_$iii &&
 	{
 		test-tool genrandom "foo"$i 100 &&
-		test-tool genrandom "foo"$(( $i + 1 )) 100 &&
-		test-tool genrandom "foo"$(( $i + 2 )) 100
+		test-tool genrandom "foo"$(( i + 1 )) 100 &&
+		test-tool genrandom "foo"$(( i + 2 )) 100
 	} >deep_delta_$iii &&
 	{
 		echo $iii &&
@@ -251,21 +251,21 @@ MIDX_BYTE_OID_VERSION=5
 MIDX_BYTE_CHUNK_COUNT=6
 MIDX_HEADER_SIZE=12
 MIDX_BYTE_CHUNK_ID=$MIDX_HEADER_SIZE
-MIDX_BYTE_CHUNK_OFFSET=$(($MIDX_HEADER_SIZE + 4))
+MIDX_BYTE_CHUNK_OFFSET=$((MIDX_HEADER_SIZE + 4))
 MIDX_NUM_CHUNKS=5
 MIDX_CHUNK_LOOKUP_WIDTH=12
-MIDX_OFFSET_PACKNAMES=$(($MIDX_HEADER_SIZE + \
-			 $MIDX_NUM_CHUNKS * $MIDX_CHUNK_LOOKUP_WIDTH))
-MIDX_BYTE_PACKNAME_ORDER=$(($MIDX_OFFSET_PACKNAMES + 2))
-MIDX_OFFSET_OID_FANOUT=$(($MIDX_OFFSET_PACKNAMES + $(test_oid packnameoff)))
+MIDX_OFFSET_PACKNAMES=$((MIDX_HEADER_SIZE + \
+			 MIDX_NUM_CHUNKS * MIDX_CHUNK_LOOKUP_WIDTH))
+MIDX_BYTE_PACKNAME_ORDER=$((MIDX_OFFSET_PACKNAMES + 2))
+MIDX_OFFSET_OID_FANOUT=$((MIDX_OFFSET_PACKNAMES + $(test_oid packnameoff)))
 MIDX_OID_FANOUT_WIDTH=4
-MIDX_BYTE_OID_FANOUT_ORDER=$((MIDX_OFFSET_OID_FANOUT + 250 * $MIDX_OID_FANOUT_WIDTH + $(test_oid fanoutoff)))
-MIDX_OFFSET_OID_LOOKUP=$(($MIDX_OFFSET_OID_FANOUT + 256 * $MIDX_OID_FANOUT_WIDTH))
-MIDX_BYTE_OID_LOOKUP=$(($MIDX_OFFSET_OID_LOOKUP + 16 * $HASH_LEN))
-MIDX_OFFSET_OBJECT_OFFSETS=$(($MIDX_OFFSET_OID_LOOKUP + $NUM_OBJECTS * $HASH_LEN))
+MIDX_BYTE_OID_FANOUT_ORDER=$((MIDX_OFFSET_OID_FANOUT + 250 * MIDX_OID_FANOUT_WIDTH + $(test_oid fanoutoff)))
+MIDX_OFFSET_OID_LOOKUP=$((MIDX_OFFSET_OID_FANOUT + 256 * MIDX_OID_FANOUT_WIDTH))
+MIDX_BYTE_OID_LOOKUP=$((MIDX_OFFSET_OID_LOOKUP + 16 * HASH_LEN))
+MIDX_OFFSET_OBJECT_OFFSETS=$((MIDX_OFFSET_OID_LOOKUP + NUM_OBJECTS * HASH_LEN))
 MIDX_OFFSET_WIDTH=8
-MIDX_BYTE_PACK_INT_ID=$(($MIDX_OFFSET_OBJECT_OFFSETS + 16 * $MIDX_OFFSET_WIDTH + 2))
-MIDX_BYTE_OFFSET=$(($MIDX_OFFSET_OBJECT_OFFSETS + 16 * $MIDX_OFFSET_WIDTH + 6))
+MIDX_BYTE_PACK_INT_ID=$((MIDX_OFFSET_OBJECT_OFFSETS + 16 * MIDX_OFFSET_WIDTH + 2))
+MIDX_BYTE_OFFSET=$((MIDX_OFFSET_OBJECT_OFFSETS + 16 * MIDX_OFFSET_WIDTH + 6))
 
 test_expect_success 'verify bad version' '
 	corrupt_midx_and_verify $MIDX_BYTE_VERSION "\00" $objdir \
@@ -417,10 +417,10 @@ test_expect_success 'verify multi-pack-index with 64-bit offsets' '
 
 NUM_OBJECTS=63
 MIDX_OFFSET_OID_FANOUT=$((MIDX_OFFSET_PACKNAMES + 54))
-MIDX_OFFSET_OID_LOOKUP=$((MIDX_OFFSET_OID_FANOUT + 256 * $MIDX_OID_FANOUT_WIDTH))
-MIDX_OFFSET_OBJECT_OFFSETS=$(($MIDX_OFFSET_OID_LOOKUP + $NUM_OBJECTS * $HASH_LEN))
-MIDX_OFFSET_LARGE_OFFSETS=$(($MIDX_OFFSET_OBJECT_OFFSETS + $NUM_OBJECTS * $MIDX_OFFSET_WIDTH))
-MIDX_BYTE_LARGE_OFFSET=$(($MIDX_OFFSET_LARGE_OFFSETS + 3))
+MIDX_OFFSET_OID_LOOKUP=$((MIDX_OFFSET_OID_FANOUT + 256 * MIDX_OID_FANOUT_WIDTH))
+MIDX_OFFSET_OBJECT_OFFSETS=$((MIDX_OFFSET_OID_LOOKUP + NUM_OBJECTS * HASH_LEN))
+MIDX_OFFSET_LARGE_OFFSETS=$((MIDX_OFFSET_OBJECT_OFFSETS + NUM_OBJECTS * MIDX_OFFSET_WIDTH))
+MIDX_BYTE_LARGE_OFFSET=$((MIDX_OFFSET_LARGE_OFFSETS + 3))
 
 test_expect_success 'verify incorrect 64-bit offset' '
 	corrupt_midx_and_verify $MIDX_BYTE_LARGE_OFFSET "\07" objects64 \
@@ -555,7 +555,7 @@ test_expect_success 'repack respects repack.packKeptObjects=false' '
 		test-tool read-midx .git/objects | grep idx >midx-list &&
 		test_line_count = 5 midx-list &&
 		THIRD_SMALLEST_SIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | head -n 3 | tail -n 1) &&
-		BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&
+		BATCH_SIZE=$((THIRD_SMALLEST_SIZE + 1)) &&
 		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
 		ls .git/objects/pack/*idx >idx-list &&
 		test_line_count = 5 idx-list &&
@@ -570,7 +570,7 @@ test_expect_success 'repack creates a new pack' '
 		ls .git/objects/pack/*idx >idx-list &&
 		test_line_count = 5 idx-list &&
 		THIRD_SMALLEST_SIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | head -n 3 | tail -n 1) &&
-		BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&
+		BATCH_SIZE=$((THIRD_SMALLEST_SIZE + 1)) &&
 		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
 		ls .git/objects/pack/*idx >idx-list &&
 		test_line_count = 6 idx-list &&
-- 
gitgitgadget
