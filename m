Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EAC32070F
	for <e@80x24.org>; Mon, 19 Sep 2016 21:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbcISVJH (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 17:09:07 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36555 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbcISVJF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 17:09:05 -0400
Received: by mail-pf0-f182.google.com with SMTP id q2so34516651pfj.3
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 14:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=45o8D/TJsvLSubcyrNEcRRiDnfREtVS2uOsLVpZDqq0=;
        b=OI4f0UBfEl8T7ATsyc6KDnoMoYr4HN07EW4Q7A7E5QbNVYpFPDJbRI8mBqH7QYyiwl
         VAupJ5ibK2Vay6YLQwxisYxJit8Up5R7j9n50qBMfVTWt8Wqix8xZGlnSPFt7KLIH+0j
         WeHnrd+dnrt5W8T+0GxYHSXpYZnJR8tulBjkdErHVZrHptPRhRzvXnvpvGvzrgu2jwJe
         c+XEwK0vYJnF+tHcpO+dOMHRZSS2jPeBrpekrPFAzhs/MlqNCKoFlPnDWBkNJq3EnLOi
         dSaFYwkPSNkiuWIpfHH2cTVXGRpJ3kg21jL4MjAmvEEvllzzHQ/4aiiyYjePNXIG0uXL
         qgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=45o8D/TJsvLSubcyrNEcRRiDnfREtVS2uOsLVpZDqq0=;
        b=Yq7hpJQ7HVsgHAMbOAjiPlCZeYW3PQ8l22C3MrThyGK9xKwXaXL+c/wWtxs9pwkS5M
         nUHomDfVgA0vat0czJ4lCPgaibN+31Xo4KfFpCGE4NPi8TKqARfBlIPWMw1dj22CAehi
         t2c592LW4u0DhsbGqHqx8rmIIKRUcnBdyWurJftfGlgcn1kY4MZ64SpQGUL4KVnetPOy
         cp6/Y11/e46RJ3RbbuJFMCypnoPZOa3v9Gdo/HQP3OgjV8t3BKNjXm9X62Mf9VA+p/6T
         Dnx5wcArxw2ecpySL8GpOzPtmozNd9J4DpStcqJQiRV3vL/W1uQoAAXTDgmOElA9iiJJ
         DoWQ==
X-Gm-Message-State: AE9vXwNThEZKOckiaxh/+xaGi3rv0E9P35whXyKgAK/0N9ni7wXyhzq5bRUUJeG0CB2pKfnb
X-Received: by 10.98.60.153 with SMTP id b25mr50524824pfk.12.1474319345176;
        Mon, 19 Sep 2016 14:09:05 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id q14sm54484171pfg.63.2016.09.19.14.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Sep 2016 14:09:04 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v2 1/4] mailinfo: separate in-body header processing
Date:   Mon, 19 Sep 2016 14:08:50 -0700
Message-Id: <12ea344c46ed17ed90dd92bebc45be761a51ef80.1474319086.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.10.0.rc2.20.g5b18e70
In-Reply-To: <cover.1474319086.git.jonathantanmy@google.com>
References: <cover.1474319086.git.jonathantanmy@google.com>
In-Reply-To: <cover.1474319086.git.jonathantanmy@google.com>
References: <cover.1474319086.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The check_header function contains logic specific to in-body headers,
although it is invoked during both the processing of actual headers and
in-body headers. Separate out the in-body header part into its own
function.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 mailinfo.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index e19abe3..0c4738a 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -495,21 +495,6 @@ static int check_header(struct mailinfo *mi,
 		goto check_header_out;
 	}
 
-	/* for inbody stuff */
-	if (starts_with(line->buf, ">From") && isspace(line->buf[5])) {
-		ret = is_format_patch_separator(line->buf + 1, line->len - 1);
-		goto check_header_out;
-	}
-	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
-		for (i = 0; header[i]; i++) {
-			if (!strcmp("Subject", header[i])) {
-				handle_header(&hdr_data[i], line);
-				ret = 1;
-				goto check_header_out;
-			}
-		}
-	}
-
 check_header_out:
 	strbuf_release(&sb);
 	return ret;
@@ -623,6 +608,22 @@ static int is_scissors_line(const struct strbuf *line)
 		gap * 2 < perforation);
 }
 
+static int check_inbody_header(struct mailinfo *mi, const struct strbuf *line)
+{
+	if (starts_with(line->buf, ">From") && isspace(line->buf[5]))
+		return is_format_patch_separator(line->buf + 1, line->len - 1);
+	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
+		int i;
+		for (i = 0; header[i]; i++)
+			if (!strcmp("Subject", header[i])) {
+				handle_header(&mi->s_hdr_data[i], line);
+				return 1;
+			}
+		return 0;
+	}
+	return check_header(mi, line, mi->s_hdr_data, 0);
+}
+
 static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 {
 	assert(!mi->filter_stage);
@@ -633,7 +634,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	}
 
 	if (mi->use_inbody_headers && mi->header_stage) {
-		mi->header_stage = check_header(mi, line, mi->s_hdr_data, 0);
+		mi->header_stage = check_inbody_header(mi, line);
 		if (mi->header_stage)
 			return 0;
 	} else
-- 
2.10.0.rc2.20.g5b18e70

