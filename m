Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD26C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjHASmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjHASmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:42:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1B12712
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:41:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c5fc972760eso6471559276.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915309; x=1691520109;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UP7ngzbctY+J++YVHHRiOWNnUiMb65kHHS+WU+BGA8c=;
        b=nU8JKLA1xPNR9sukGBFIYhTtIVJmUQNrrNVV3GBmCxN852Kd5LC9qmtPDHFxNg+Eqh
         rJncHVYSQ/L4N8Kp1yzEsXR98uZ/piij33g1n8/Cs80rgKvqG4fIN0Jb7uqztmhEOPkz
         2lFHTaRFAeQAkaAj5du1S/OJtDbFCI3F4GP1wa64kGzkUtac485sjoOmoBjy+KGVXZHL
         Zv4c+G8GZuyUYE30lFzTbB1XYuGsAQjmSxKOGKn5M1f6zU/QQ6F+gp7oeRPQDHPIdeoS
         bpZIATcVgPlxUXpbfHcvF3ml1UO7IzY0MLXXyzpMB/EL5lcjRoxpSrQcuvMllDaujF54
         t+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915309; x=1691520109;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UP7ngzbctY+J++YVHHRiOWNnUiMb65kHHS+WU+BGA8c=;
        b=PVqX6MInDLlYxulMUEji07UjkRtIB6XP/j6q3dZ+ur1aiYjmq+ya1lozqFPOtbiXBZ
         BekGhw9/z7+zEMBONyyiUY187VX+76ceYpks3OXqmGtzP6xDZP2yw/h/2IbZnE31W6I0
         6YGMiemUyrrGWWwWZz++NwJ4Px1gCpPf9crY0nGiearcIVE7bNv4a/U7XBFVwRtGMLFg
         2tiIFFxMoWHIX4tEnR27N9s9Y+D7M7oc/rRiBPwKtr9HXfol4jv7ft6XuXNz+s0HBIfD
         mbxca8hL4DGM3dHg5yXHWg3E7Hz8yyAM99ApSojIniTYURisZz78VJBWZ6wDEscu0TbB
         Y9QQ==
X-Gm-Message-State: ABy/qLaDBWgB5Xfez2s11UsirL97Hb0nxfPfAHRE1mvAjZGXjF4y6oIn
        bm3hFBykdcUwdGeMA+l7HtlZ/6HyP8ZBKYicw0gwDryE0UD+Zz0tvOqH39n20pryVgBdDOPDmHs
        uO7aYOROIPW9igx9NiLXutsk0c+ymCrBb5t9j9VUwBth4UtpioRXZ+V/tuZukvzNY2QwGD6lS8g
        E3
X-Google-Smtp-Source: APBJJlFJTNfgzdLrXLm/guh0YrliKW9HlX8PNeMrosHSf1zQAXg9MYtrQdTUJZnb6QkY+X8msTmVa7njthW3kwFJU1/K
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:a487:6e54:d296:9521])
 (user=jonathantanmy job=sendgmr) by 2002:a25:5016:0:b0:d15:fc00:fc69 with
 SMTP id e22-20020a255016000000b00d15fc00fc69mr95475ybb.9.1690915309595; Tue,
 01 Aug 2023 11:41:49 -0700 (PDT)
Date:   Tue,  1 Aug 2023 11:41:36 -0700
In-Reply-To: <cover.1690912539.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1690912539.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <3ce6090a4d3634b2e947d57f06714182207bb33a.1690912539.git.jonathantanmy@google.com>
Subject: [PATCH v7 1/7] gitformat-commit-graph: describe version 2 of BDAT
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
2.41.0.585.gd2178a4bd4-goog

