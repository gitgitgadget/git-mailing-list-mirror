Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9592C0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbjHKRGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbjHKRFz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:05:55 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439092123
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:05:53 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-583b0637c04so31475727b3.1
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691773552; x=1692378352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fr1dECbZ6nAL59hLgihhWIiTy7qmPrxT2PENGEAXkGk=;
        b=Dx9qgXv17hN2mcQ4bskTx2azfHGs0gkZQ3xMShSvembwlAdn9emOUg4AC3rRmBfHp6
         MX5xs64xydfIl5SRz81IyMUZVScnCIlUM/8QrPNnT4VrYcq/yr39gcAnB6+OTkd+L4Kq
         YiLxQ0CP+9LTgPa+yxzuXyLfKhFQet26d3rzf2dOzxl10hxNXvtM6A31tQJjVAdfTUJR
         bRkdBcY9qf9IYX7TG+16WOUu6Cg73ImrPUTA3nR1dg1tKm2r5U3hWtPEZTAS7zkpunzA
         4n4EKA6joGWPRN/n8zZ85bd7YfHqXnIGdIzHrMKKNt7Qp3aIbRhQksilKxVoFbl883If
         nVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691773552; x=1692378352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fr1dECbZ6nAL59hLgihhWIiTy7qmPrxT2PENGEAXkGk=;
        b=FwGJN6uoEzNZi7xa23vj06QDlDe+gjyL60ya1tSgdMowUN/DY+xbXboTkqe6weHPBR
         jek3xJVDfhcYc22QttGd86OUOZQsTtodVUPBM2vEGrB5uyyVyFLg1ZXvbSOCJJh9AAqc
         auvd6hJraJ4e9bQmkeAv5yWFUbaX9m/J0CM/C99bLDJKIQ/wGjaTc6BKvR6zHuS/OXG+
         drZYZVz3MhkL6p/JUtvLaGZzw76bHzvYi8qTjV0Z4SI+mJc18Md1kNYGB3rMdVLV2qZx
         24Gg9ZkkNI/NOWBbbpEaHEzpVvNPvjjfkoDq/CItuTGT1XdNGBboQGJI9RMtHSadJGKR
         w4nQ==
X-Gm-Message-State: AOJu0YyaKQiDqO0/TusWTzilbQBJfDke9cjwRyzUxzU2jfzjHnGgAS/g
        qihRVma0IMLuiUo+Nth2bi48vP3JLWoypIp2ozfTqg==
X-Google-Smtp-Source: AGHT+IELhn92W/Nx6kfeG4XceS/vCsz8+77u3+iAH+l5oSEi/cbyVAe+SdZpxoKhMIJRkY6KPkGggQ==
X-Received: by 2002:a0d:e8c1:0:b0:586:a68b:4c97 with SMTP id r184-20020a0de8c1000000b00586a68b4c97mr7349015ywe.13.1691773552303;
        Fri, 11 Aug 2023 10:05:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x204-20020a817cd5000000b0056dfbc37d9fsm1112599ywc.50.2023.08.11.10.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 10:05:51 -0700 (PDT)
Date:   Fri, 11 Aug 2023 13:05:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v2 4/5] commit-graph: invert negated conditional, extract to
 function
Message-ID: <32b5d69ebec53ff088e9ddb1a074a0dd7cf12d4b.1691773533.git.me@ttaylorr.com>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1691773533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691773533.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we're using `commit_graph_generation_from_graph()` (which can
return a zero value) and we have a pure if/else instead of an else-if,
let's swap the arms of the if-statement.

This avoids an "if (!x) { foo(); } else { bar(); }" and replaces it with
the more readable "if (x) { bar(); } else { foo(); }".

Let's also move this code to verify mixed zero/non-zero generation
numbers out to its own function, and have it modify the
`generation_zero` variable through a pointer.

There is no functionality change in this patch, but note that there are
a couple of textual differences. First, the wrapping is adjusted on both
`graph_report()` calls to avoid overly-long lines. Second, we use the
OID from `graph_commit` instead of passing in `cur_oid`, since these are
verified to be the same by `verify_one_commit_graph()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index acca753ce8..f7d9b31546 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2568,6 +2568,27 @@ static int commit_graph_checksum_valid(struct commit_graph *g)
 	return hashfile_checksum_valid(g->data, g->data_len);
 }
 
+static void verify_mixed_generation_numbers(struct commit_graph *g,
+					    struct commit *graph_commit,
+					    int *generation_zero)
+{
+	if (commit_graph_generation_from_graph(graph_commit)) {
+		if (*generation_zero == GENERATION_ZERO_EXISTS)
+			graph_report(_("commit-graph has non-zero generation "
+				       "number for commit %s, but zero "
+				       "elsewhere"),
+				     oid_to_hex(&graph_commit->object.oid));
+		*generation_zero = GENERATION_NUMBER_EXISTS;
+	} else {
+		if (*generation_zero == GENERATION_NUMBER_EXISTS)
+			graph_report(_("commit-graph has generation number "
+				       "zero for commit %s, but non-zero "
+				       "elsewhere"),
+				     oid_to_hex(&graph_commit->object.oid));
+		*generation_zero = GENERATION_ZERO_EXISTS;
+	}
+}
+
 static int verify_one_commit_graph(struct repository *r,
 				   struct commit_graph *g,
 				   struct progress *progress,
@@ -2681,17 +2702,8 @@ static int verify_one_commit_graph(struct repository *r,
 			graph_report(_("commit-graph parent list for commit %s terminates early"),
 				     oid_to_hex(&cur_oid));
 
-		if (!commit_graph_generation_from_graph(graph_commit)) {
-			if (generation_zero == GENERATION_NUMBER_EXISTS)
-				graph_report(_("commit-graph has generation number zero for commit %s, but non-zero elsewhere"),
-					     oid_to_hex(&cur_oid));
-			generation_zero = GENERATION_ZERO_EXISTS;
-		} else {
-			if (generation_zero == GENERATION_ZERO_EXISTS)
-				graph_report(_("commit-graph has non-zero generation number for commit %s, but zero elsewhere"),
-					     oid_to_hex(&cur_oid));
-			generation_zero = GENERATION_NUMBER_EXISTS;
-		}
+		verify_mixed_generation_numbers(g, graph_commit,
+						&generation_zero);
 
 		if (generation_zero == GENERATION_ZERO_EXISTS)
 			continue;
-- 
2.42.0.rc0.30.gb82b15ebc8

