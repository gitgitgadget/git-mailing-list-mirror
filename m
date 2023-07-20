Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A0CC0015E
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 21:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGTVqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 17:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGTVqw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 17:46:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751872D46
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:46:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56942667393so11490617b3.2
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689889605; x=1690494405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fg0dW97EQnVC2NCmkwCB2RFE/9Dy8wl6g2ib3iNewQQ=;
        b=aA+XpJ+nkQcPFFZhozKEyrELrku6dkIBIwE483kSGwD9PaqltMHQQTKwtg8LVwRH2o
         XRWGYOR1bgN7hH3Te6wwyJqhicAyx4lkJ4vB+Q800WbKI2sfiU7Fdc15FcuC3ta7SVkc
         AiLI3Z4kZ7lxe3dohK5SOWCRgEZpBdlEBN+Eakdn+P4eCDmMG0zhO8yzdml+S3617/pc
         XibX7l9Sku4DZPBr5/J+of96bM/Q8zBplZ9OJdQfYs+JKaIcYkT2k48j6lF2xBQk3k3Y
         caewQ139gI3FDWFe5bnIPuv5pKNzmYU5Hgma8LbimVDqSVFMlFtR87N6aP6ko93RfLHO
         VXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689889605; x=1690494405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fg0dW97EQnVC2NCmkwCB2RFE/9Dy8wl6g2ib3iNewQQ=;
        b=I90gf85QOmrP3BudqTgfRjwL9ZHy2NBQJZLMRU6AIeUaYgim1r6ZPsgPufbf5ZE54x
         OllPvbdWyNdwM+ozXP8+1Xt5oXhxwba9LQGDGyeTThq7C6/wlDGA31Az9sSsu1Z+BZ0z
         RSlZQnX+zhT7c2oFe6502Na2TkGIHBFldTeA2gY4v0WsBBXPhPzIZvegtOKtyVT9FnmX
         3uex5PZFcb+lJ5Drs+lkiMZk2HV0imXSXLmskVzLVnmBwwg4KcVzC2DtG8Hk/al7GNLQ
         Spc+OPslK45LrYrqGAySe7O+FcA+4lZTlM10kVSB7BNP651URyzxDNo95a8y8kOqWGkv
         rkGA==
X-Gm-Message-State: ABy/qLa9B5LZB/2ubIEWIu6jgx2baULqKdnBDOko1LeO7o8GPsmerzCk
        UaEn5IdwxFiNEdPSgyRozJNTPUtKuaABAMaAjMAlOMnuCn/aF98D7mE9fGdzEVHeyDvoiztUi+Q
        qK6DZ3MuBYEZSBnjOgwwx7eE2HraLLM/OAp+R7FFWNa5U/WzJ+yqc9uo90eHUbNSynbY9NpXcep
        9N
X-Google-Smtp-Source: APBJJlFi9PFY1eRAVQasZMwJ9xVoj7lspVdtIHFl1hzMjhbcqd9foVdUSuN4GGVn1EnM7F/cMEmgHTsvmGJgfBh5Vuub
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:387b:f15b:5fda:c8a5])
 (user=jonathantanmy job=sendgmr) by 2002:a25:8e12:0:b0:cfe:e8ca:7323 with
 SMTP id p18-20020a258e12000000b00cfee8ca7323mr1593ybl.4.1689889605654; Thu,
 20 Jul 2023 14:46:45 -0700 (PDT)
Date:   Thu, 20 Jul 2023 14:46:34 -0700
In-Reply-To: <cover.1689889382.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1689889382.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <3ce6090a4d3634b2e947d57f06714182207bb33a.1689889382.git.jonathantanmy@google.com>
Subject: [PATCH v6 1/7] gitformat-commit-graph: describe version 2 of BDAT
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code change to Git to support version 2 will be done in subsequent
commits.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.41.0.487.g6d72f3e995-goog

