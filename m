Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA73AC001DF
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 21:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbjGMVnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 17:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjGMVm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 17:42:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131DA30CA
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 14:42:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c83284edf0eso1070365276.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689284536; x=1691876536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CK5HCzRVo86namNxblZ7MyVZoMEExkrrhKKpMQwHq/M=;
        b=KHJrWy7RxapIQz4WLuYL2VOF6R5/9x0WAiMAWISykiSKN/+LDmVJKUsOkJjSS/tKrg
         x5gs8tw2Mwe8UiS4HwqUO/5O7NjckDZz/LLh+q9yA/KU6piiPLN5vkLKjPQO/dD9VVCe
         pp5lMOLAQ69GeJ2Rckz1nZ2aZBOx/P7qb4KkZI2lUrOqk9hKeoUAYa+x4hKhwJn/inG/
         rRAvi8bj4o2bQ6RpKjwGDFZFnN/ZwiuPLyBJWQ4v5rkNyoW68bnC1CsvseGnRU/8JhnO
         puE5zxJIo2GKdGBGkkheT7JdehCsNULJQ1pN5P3ztRKs3HXzu6T/ZOfTBoTiwZAyGtbZ
         qpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689284536; x=1691876536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CK5HCzRVo86namNxblZ7MyVZoMEExkrrhKKpMQwHq/M=;
        b=RmkuT0dyuhMtTi4jDbSIO1x20fa54JYF9/DI/Ke45+Jlczl0K0uihShOP6HOZp7sKN
         dNS/hwIOYiHUx/asjHmKNPNpCHLJCjiZVdLbkMdQ8KH1leZ2NjvzNAmLRvqk4CjCoAvd
         xr0SzXITQwDHc4tnBFPAkqTHf8QwDN/dJOjT6KvPU19fREECanIL1mbcgZ7jOtJ+N01N
         cyVOQg2xY4dLjziExETE8nABDrybdnNFzOLNW+3SD9xcVrWdpMnPJQoT8+UCTJeJeqJ0
         3FUylO8fBnP4zIsexNGgRDoPyf002XcOGZT1/PY2JgGWL/9LC1rzfzgRaEe6itffueEy
         DCRw==
X-Gm-Message-State: ABy/qLa+t2naz4zAkUFxbXu38ZfgmuqYOuDTZq+gzA9SkEMCgbNRe+dr
        gB/1QH95dHcOywFCNvEpII3WntXhuBgGh+gAhJiy8KKmA93R3tqW1nxfVwsG8qEliy1saeaRQ1i
        DIHYqH6SuOcZMPB4mZIGb7vWetG/VEzAWsqDd0YJpAZfIm7usbk21Tf9Aq8iO/JhOeaAGtWVaLt
        Ao
X-Google-Smtp-Source: APBJJlHuuCgB1dKqZIVUI9gdPoJB8xK30j5Pdq5jn6z2YKmQTbp+Ocp5qKpeERmhzadN+wiB8m6VRkytu0e1XOPaEcxc
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:8bde:aac2:2aa0:da1a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:c594:0:b0:cb4:285:721a with SMTP
 id v142-20020a25c594000000b00cb40285721amr11171ybe.11.1689284536548; Thu, 13
 Jul 2023 14:42:16 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:42:08 -0700
In-Reply-To: <cover.1689283789.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1689283789.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <52e281eef0e857de93e5bdc6e0ef50065adaab2c.1689283789.git.jonathantanmy@google.com>
Subject: [PATCH v5 1/4] gitformat-commit-graph: describe version 2 of BDAT
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
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
2.41.0.255.g8b1d071c50-goog

