Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA87F202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbdF3AHg (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:07:36 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:32963 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbdF3AHa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:30 -0400
Received: by mail-pf0-f179.google.com with SMTP id e7so58082196pfk.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gp2p0rh900T64j6jVmbegwUukokMIIk0hQXTUdGrT2k=;
        b=PQn+obOfm5oxpZX/QTOm/x7w6/7uUBrP0ylHEuN4QOV9AwINuNBPfkAflYIFk55YNL
         yerVhAOsvfWnfkce3wkO0mkoLh8DATnxn3aawuhpb4NdypcQps1sxxT1C7dAQPsEl/9u
         Iu1S8cmp+Fso65I1xtVOwm4Wi8o7jFZtVzqfupJczGDr9qAsCHCAnt6hBQ4TouT4jst0
         LhiHbvcd+GPewhLkf6lSx8gLwhOkobQREaSnZ7bS/2ahOL3NQgyWFXbPxRSBnD6Qo4Rr
         Tb4is47vP87mcVd4O0Ulayu/d0owsxWLgh7dQo0Yfy78eTLDa60W+T4fDX3pCV9XJzXg
         /m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gp2p0rh900T64j6jVmbegwUukokMIIk0hQXTUdGrT2k=;
        b=LJaKW7/CONUPgtiljeeSK1aqyFF12TPlPEP1pIaqvrk3o4yazIHr2zNrfN5nWGzyS8
         OqK+2xBRVqj4pglOV9SneZq/nCG8JUwPtTe+KAa3dfDLG8JGOZlayMY+EQgiQMUalpHb
         z2l6YULhjVPOJdpxpYMfdSY4UYt4WdAzm0VyZ4GEZC5hEgqR4BtTCFidK8npnHOvOaBc
         AQaFe1hNvEQDuFZGQ80WiQetcFo1TKFwrURDhKKw97+bkwEaIv9LGSs+VdY6Y+asAfIa
         QdyxsXUemjHsTJOQ2F5M49ui5CmeURVdyIPX6nnsxpSn5X8Qjv25K3/gpeLIzzNIc9jQ
         AwYg==
X-Gm-Message-State: AKS2vOzkpXAFPjmO6I3qz/XqLyptp0jPZG/h1wsXsIuJEPbjZ+PHcJrS
        2kV01SsfefSfasZ2
X-Received: by 10.98.204.23 with SMTP id a23mr19316620pfg.59.1498781250096;
        Thu, 29 Jun 2017 17:07:30 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id d71sm15981975pfe.106.2017.06.29.17.07.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_MARKER
Date:   Thu, 29 Jun 2017 17:06:50 -0700
Message-Id: <20170630000710.10601-6-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630000710.10601-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 4637368d59..75b996c4cf 100644
--- a/diff.c
+++ b/diff.c
@@ -561,13 +561,20 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_CONTEXT_MARKER,
 	DIFF_SYMBOL_SEPARATOR
 };
 
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len)
 {
+	const char *context, *reset;
 	switch (s) {
+	case DIFF_SYMBOL_CONTEXT_MARKER:
+		context = diff_get_color_opt(o, DIFF_CONTEXT);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line(o, context, reset, line, len);
+		break;
 	case DIFF_SYMBOL_SEPARATOR:
 		fprintf(o->file, "%s%c",
 			diff_line_prefix(o),
@@ -662,7 +669,8 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	if (len < 10 ||
 	    memcmp(line, atat, 2) ||
 	    !(ep = memmem(line + 2, len - 2, atat, 2))) {
-		emit_line(ecbdata->opt, context, reset, line, len);
+		emit_diff_symbol(ecbdata->opt,
+				 DIFF_SYMBOL_CONTEXT_MARKER, line, len);
 		return;
 	}
 	ep += 2; /* skip over @@ */
-- 
2.13.0.31.g9b732c453e

