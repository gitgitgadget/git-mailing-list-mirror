Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDB7D1F4FF
	for <e@80x24.org>; Tue, 20 Sep 2016 17:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755558AbcITRSE (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 13:18:04 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33728 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754694AbcITRSD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 13:18:03 -0400
Received: by mail-pf0-f175.google.com with SMTP id 21so9423904pfy.0
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=45o8D/TJsvLSubcyrNEcRRiDnfREtVS2uOsLVpZDqq0=;
        b=iS4W102P9rtF89KM5OZ4MrluanZ1kP/818Vti/eD3w2zN+saXqFlgR0Vycg8n/RKEM
         vfJcc9Qg5MtceH+5UZaVFrbtChVE+BRGMn4iyKlxvk+5hMycf3qT5Yvk5LeBXJ+uspyA
         KiJT5K7c7CjIuNDcTSYroUMI9HpNhrXUBO/vmqmAVZ7sltKXYO2KVTfqt2V67PFBmVEu
         BJUXZiAgowKRhldPuAFauzXoKVCQLvNNJyiWF3tNk8SWL/lynU107GYAx3ZaiQ4Syx9o
         TafTMn1x3ybgrbGx03qZ75qqI9p5+CdAT50yB6dLvdTjJB/L9PpD4uuhK0NOgHYR8UC0
         W9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=45o8D/TJsvLSubcyrNEcRRiDnfREtVS2uOsLVpZDqq0=;
        b=S5y6bS5HFmMUGfdS4r1ezhJoRidsS/pwlszx7PXVnWNJpgGCCjphMmzvIpsvCC2bq5
         d4F04kqCuVFY2sG79Xqb6J8s76Ia2X6JXEY8nBg8OBc2wEenQ8YKlBVEFGL0PbccKUuw
         1h1XWhDCmXR4y1nWYN8sc+tsHEs61QAKeLru08lnWwC+eFz3ZEx0TYb3DmepNTfB9P/F
         mxWJs4WuZI5eUHIcyGhrZYx+qHPrRwoLxGU0LUEoGwPllBIoVsjX6/XsPdqbWcd+psQu
         EKkxAumQQpgFy1vx1TxFoiRvC7ahO+ucgqSQSN+uXHwTopWJ3+HK1jHfNM87Bof1rVsj
         Buyw==
X-Gm-Message-State: AE9vXwNXkDB934L2nqFIH0V//B16xMiwcWdBPswoJLGdPT0hxe+W1CETEg2nGm76WAsV1ntn
X-Received: by 10.98.131.193 with SMTP id h184mr35277739pfe.92.1474391881710;
        Tue, 20 Sep 2016 10:18:01 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id x9sm80586932pfd.70.2016.09.20.10.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 10:18:00 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 1/3] mailinfo: separate in-body header processing
Date:   Tue, 20 Sep 2016 10:17:51 -0700
Message-Id: <12ea344c46ed17ed90dd92bebc45be761a51ef80.1474391594.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.10.0.rc2.20.g5b18e70
In-Reply-To: <cover.1474391594.git.jonathantanmy@google.com>
References: <cover.1474391594.git.jonathantanmy@google.com>
In-Reply-To: <cover.1474391594.git.jonathantanmy@google.com>
References: <cover.1474319086.git.jonathantanmy@google.com> <cover.1474391594.git.jonathantanmy@google.com>
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

