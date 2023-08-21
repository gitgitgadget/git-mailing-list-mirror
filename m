Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFD4EE49A6
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjHUVoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHUVoC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:44:02 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B15CE
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:01 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-c5ffb6cda23so3902782276.0
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692654240; x=1693259040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KRkNE1/nGOI82nK7u38WemxT+IQUINtiXVcM9B7Bgyg=;
        b=aovnDSdXvdc3NZWSRKupQjEsewG00GrRjYIYETUc75VZQpI+1B1L7VZwjUJ0h0m4XP
         xbFFi91atJlVkVyd19CD2cljUAORTeGdpq2hNcxFKsGCe/5sAafSh/Pabx/O7jjpHEhi
         9LQjr4Jq5wUwHXBEWRnXaF1Njo5xoCk1G1jD8EMhYFTUMX+Y2SEFHBkY90jVw7diiPvv
         OBe5fXbtCnFSt7GC1E1ZrERfIoEgV4j7p/6+/XCXW3L47+CY67JTJUwLGZ/fmRxltcyl
         QeyWW3jksbpZ8xGMGaeM/XTY7g2+MI09XV0iKSgipOURNAyHDQvi0Ohjss8YvWyaOR3Q
         digg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692654240; x=1693259040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRkNE1/nGOI82nK7u38WemxT+IQUINtiXVcM9B7Bgyg=;
        b=YU+0tujaRtl4l3ntQ0yunaCkTL2gvgPYqL4cdmZSfjiWJymxCVLvlWIO+HUvmrB6L/
         sBtAxzN0F/q9OEKYtC5U2AxmTPK2pDbMhESI3KgPujV2Mc919Cu0J8GPQ85RZEk383FU
         4ep0c3kvyJ59hwkvJ2eWgfuBxjUn9QPYNXc0tH4QNZQ9D4gYgAldJ856Aey/8bgx4N3L
         e+kYe8ngfM5Lh+WdlSXZYVSIz1OXNl6iV+T53CDUjHacmCt6a/vBKRugABw9HzT7YcOn
         ZHFdGmG8Auc/H6JeDIJ3Y+q15Cb1Lurh2j+/7c7SB7f3z51Mm95AgmBL4qreHdsvyh2q
         DhQA==
X-Gm-Message-State: AOJu0Ywc7NQTI4CvCF2onLAqISdxaCGiREnzDA3lpYswE+hJKfg96lxc
        aZqpAb6ILsjlesyxSLqaCTZt4s3lApd5xXgqcbAxKQ==
X-Google-Smtp-Source: AGHT+IFUiOF8DR0XhNLDZAIArqP6glANhILpqq+GOFsLua552vnT3h/XBtZC1mVBq8kzhbs8nY3s0A==
X-Received: by 2002:a25:e042:0:b0:d16:bdcf:943d with SMTP id x63-20020a25e042000000b00d16bdcf943dmr8420730ybg.6.1692654240412;
        Mon, 21 Aug 2023 14:44:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l64-20020a252543000000b00d145ec9f495sm2055483ybl.46.2023.08.21.14.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:44:00 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:43:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 01/15] gitformat-commit-graph: describe version 2 of BDAT
Message-ID: <0241b6e18867dab34c8dd8b49a861884e9818d37.1692654233.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692654233.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

The code change to Git to support version 2 will be done in subsequent
commits.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/gitformat-commit-graph.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
index 31cad585e2..3e906e8030 100644
--- a/Documentation/gitformat-commit-graph.txt
+++ b/Documentation/gitformat-commit-graph.txt
@@ -142,13 +142,16 @@ All multi-byte numbers are in network byte order.
 
 ==== Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
     * It starts with header consisting of three unsigned 32-bit integers:
-      - Version of the hash algorithm being used. We currently only support
-	value 1 which corresponds to the 32-bit version of the murmur3 hash
+      - Version of the hash algorithm being used. We currently support
+	value 2 which corresponds to the 32-bit version of the murmur3 hash
 	implemented exactly as described in
 	https://en.wikipedia.org/wiki/MurmurHash#Algorithm and the double
 	hashing technique using seed values 0x293ae76f and 0x7e646e2 as
 	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
-	in Probabilistic Verification"
+	in Probabilistic Verification". Version 1 Bloom filters have a bug that appears
+	when char is signed and the repository has path names that have characters >=
+	0x80; Git supports reading and writing them, but this ability will be removed
+	in a future version of Git.
       - The number of times a path is hashed and hence the number of bit positions
 	      that cumulatively determine whether a file is present in the commit.
       - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
-- 
2.42.0.4.g52b49bb434

