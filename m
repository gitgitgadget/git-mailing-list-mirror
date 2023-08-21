Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8958AEE49A6
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjHUVep (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjHUVeo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:34:44 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AF910E
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:34:42 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d678b44d1f3so5223660276.0
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692653681; x=1693258481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdpcKTE34f/TnkW6tiomJjCGgN3+mUvs49ILwJA/UW0=;
        b=SG8Fdxukmo1r52bVRLQyZ4qWZvGaWYvBJkPxBFwruUQe78wVJKgrFYWU0nfV+rBoty
         IR6wMRqgNa6uHFC26kC/JaBxpJjV2Qn46WaSo6CntbkT12fzzVjVDhHcMDflN7QjQwk3
         37Lfhh5e6v3JkbyGbXmHLzP8PM4t8OHe7w2KojTkQV/x4/ofIXZE9AAoZu6dGNq5pUdw
         xHVI89K6lei6g9bknMhtmXvpu1RKSn+vDbi+fvJmXanJLO5HMDIos3rZElQHFNhkLKnY
         ji+0pKhSQMObx3OSv9rdVWD0Uzkdbhss0ZyYcW0CzUJVCyBH4IDDSGr8QXUXx47X0sS/
         oC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692653681; x=1693258481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdpcKTE34f/TnkW6tiomJjCGgN3+mUvs49ILwJA/UW0=;
        b=Ox7SvgQ2Cuiyjbpf0BFbmNp/QLSAIi4MuQDSBzWmW4TuHzIioX9RzjUyOArFkFNI5/
         FqWf5uhyjUjcYlhJKpZVeL6cW856FNPRIDNG+aUcU4Y3ESzpNHSwbTTIWMrKxii6xr7s
         HIBjq7IZjm/PhfZY153mpF6e9s/h9LBqhF3Bv1sl6tIFIIBwz0NiVtkJeIb3Z5WrIaym
         Sfo6U0g6M5+hL0hYgZc91KLASLiCkIEs8yHHEK/YYUauD7MFpdy6B/XXzToCqN2jtrMp
         GL2dfU8QoXAUJfl31tiQzMovGOMpT75dC4vfU1Wxj6Pa0vVM6Skg118OHrovHxqZTqzw
         LHCg==
X-Gm-Message-State: AOJu0Yzy64LjAtc+137x0wpc+eIH0PA4fJZfrPLn+hQKesIbB0+FIbGC
        SjpOA77VeA18nwkfNEvBiY1t2zrKDGw3aWvdAMpu/w==
X-Google-Smtp-Source: AGHT+IFNWBbbPnyBYJcKVdkhUbqv2Vde8iIi8Yw8qi6paKeCE1amQx2m7x8Ouq96+rNu2xst1Q9UaA==
X-Received: by 2002:a5b:609:0:b0:d21:3e0d:4447 with SMTP id d9-20020a5b0609000000b00d213e0d4447mr6048697ybq.12.1692653681344;
        Mon, 21 Aug 2023 14:34:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 206-20020a2506d7000000b00d1f0204c1b6sm2057276ybg.27.2023.08.21.14.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:34:41 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:34:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v3 3/4] t/t5318-commit-graph.sh: test generation zero
 transitions during fsck
Message-ID: <34a505dd4b94a03e57556841c86802f8043c0e56.1692653671.git.me@ttaylorr.com>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1692653671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692653671.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The second test called "detect incorrect generation number" asserts that
we correctly warn during an fsck when we see a non-zero generation
number after seeing a zero beforehand.

The other transition (going from non-zero to zero) was previously
untested. Test both directions, and rename the existing test to make
clear which direction it is exercising.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5318-commit-graph.sh | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 4e70820c74..8e96471b34 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -450,14 +450,15 @@ GRAPH_BYTE_FANOUT2=$(($GRAPH_FANOUT_OFFSET + 4 * 255))
 GRAPH_OID_LOOKUP_OFFSET=$(($GRAPH_FANOUT_OFFSET + 4 * 256))
 GRAPH_BYTE_OID_LOOKUP_ORDER=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * 8))
 GRAPH_BYTE_OID_LOOKUP_MISSING=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * 4 + 10))
+GRAPH_COMMIT_DATA_WIDTH=$(($HASH_LEN + 16))
 GRAPH_COMMIT_DATA_OFFSET=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * $NUM_COMMITS))
 GRAPH_BYTE_COMMIT_TREE=$GRAPH_COMMIT_DATA_OFFSET
 GRAPH_BYTE_COMMIT_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN))
 GRAPH_BYTE_COMMIT_EXTRA_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 4))
 GRAPH_BYTE_COMMIT_WRONG_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 3))
 GRAPH_BYTE_COMMIT_GENERATION=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 11))
+GRAPH_BYTE_COMMIT_GENERATION_LAST=$(($GRAPH_BYTE_COMMIT_GENERATION + $(($NUM_COMMITS - 1)) * $GRAPH_COMMIT_DATA_WIDTH))
 GRAPH_BYTE_COMMIT_DATE=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12))
-GRAPH_COMMIT_DATA_WIDTH=$(($HASH_LEN + 16))
 GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
 			     $GRAPH_COMMIT_DATA_WIDTH * $NUM_COMMITS))
 GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
@@ -596,11 +597,6 @@ test_expect_success 'detect incorrect generation number' '
 		"generation for commit"
 '
 
-test_expect_success 'detect incorrect generation number' '
-	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\01" \
-		"but zero elsewhere"
-'
-
 test_expect_success 'detect incorrect commit date' '
 	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_DATE "\01" \
 		"commit date"
@@ -622,6 +618,16 @@ test_expect_success 'detect incorrect chunk count' '
 		$GRAPH_CHUNK_LOOKUP_OFFSET
 '
 
+test_expect_success 'detect mixed generation numbers (non-zero to zero)' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION_LAST "\0\0\0\0" \
+		"but non-zero elsewhere"
+'
+
+test_expect_success 'detect mixed generation numbers (zero to non-zero)' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\0\0\0\0" \
+		"but zero elsewhere"
+'
+
 test_expect_success 'git fsck (checks commit-graph when config set to true)' '
 	git -C full fsck &&
 	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
-- 
2.42.0.4.g52b49bb434

