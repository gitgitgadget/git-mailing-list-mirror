Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6903E202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbdF3AHl (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:07:41 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32994 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbdF3AHj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:39 -0400
Received: by mail-pf0-f175.google.com with SMTP id e7so58083595pfk.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5oYmzRp0N3UAnia023EX3p036s2/3bYFn7kVPWQFqe4=;
        b=RbOJZVx0OOPWpXLW1vXSt9ttK8e9PPd9TaQe+AFB7LbfJVK9HxbX/t7cLaicY9fUIY
         H6VJ5mNI7TdWcJ9cnzgEMAij1QzjXpP2hBi2Q/fPpiCJd8TCFkYc7QQy6K995Mm6RRwc
         RktfbEpA8x9rK5t2VsDq85SnVLRnP/0HkfQShyQCx0gSdHeo4q9ssxrHoWJpU78tLA1W
         aCaQT64ulvpCPStr17QoWpw/hlxO0S+0s+L8lPHJ3kxsLP99N9sQe/57J1vH2O9zKe+Y
         UNrwFvrQXh3gmADKwjkPgtID6HhxL9au2E3DgI4V+9QCOdyE5QdLMQ4DssB1efyHqsVZ
         HeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5oYmzRp0N3UAnia023EX3p036s2/3bYFn7kVPWQFqe4=;
        b=P2LHmGOfSJTYpfZdWnRYkaln49LOAoH5IIrIkcZ6lzMcFYy4th7AbmZ2joJWpLmMQk
         /ljX7xljIM//+RBwQhod/hUnEt8MQUaQJfgLk/LZW/seA2KTowCOMoNGcFTv5Wox8rjh
         C1b/RXy0dckg+f1f+/LfpDPvfbCtGUExsR+n8lGGGkJvJ117MruyJ5dmb5/yw3ndTEEp
         gl0OHvtu2KMSnd90cBml1LLFqBxlx4H3l3JGwH2kZImHz8No6Jh+fAUtipjZ/H4dvPo0
         b8jSqfSM9MD12Ur686tnGcjt2Y7gHDm13nG/8ODDCnffNkSysaLVwfx9KcRF1K3vhSkk
         exQg==
X-Gm-Message-State: AKS2vOz6R+7Y2Gki/AcimhDKFYsC7WDbPqXA/VIudQ/EZthbYRordToa
        0vLEguMP02zG1pqCnHkwiw==
X-Received: by 10.84.229.6 with SMTP id b6mr20626805plk.247.1498781258904;
        Thu, 29 Jun 2017 17:07:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id t26sm6913595pfl.41.2017.06.29.17.07.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:38 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 12/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_HEADER
Date:   Thu, 29 Jun 2017 17:06:57 -0700
Message-Id: <20170630000710.10601-13-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630000710.10601-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The header is constructed lazily including line breaks, so just emit
the raw string as is.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 49b45fef29..78f7c6f82f 100644
--- a/diff.c
+++ b/diff.c
@@ -561,6 +561,7 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_HEADER,
 	DIFF_SYMBOL_FILEPAIR_PLUS,
 	DIFF_SYMBOL_FILEPAIR_MINUS,
 	DIFF_SYMBOL_WORDS_PORCELAIN,
@@ -689,6 +690,9 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			line, reset,
 			strchr(line, ' ') ? "\t" : "");
 		break;
+	case DIFF_SYMBOL_HEADER:
+		fprintf(o->file, "%s", line);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -1385,7 +1389,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	o->found_changes = 1;
 
 	if (ecbdata->header) {
-		fprintf(o->file, "%s", ecbdata->header->buf);
+		emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
+				 ecbdata->header->buf, ecbdata->header->len, 0);
 		strbuf_reset(ecbdata->header);
 		ecbdata->header = NULL;
 	}
@@ -2519,7 +2524,8 @@ static void builtin_diff(const char *name_a,
 		if (complete_rewrite &&
 		    (textconv_one || !diff_filespec_is_binary(one)) &&
 		    (textconv_two || !diff_filespec_is_binary(two))) {
-			fprintf(o->file, "%s", header.buf);
+			emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
+					 header.buf, header.len, 0);
 			strbuf_reset(&header);
 			emit_rewrite_diff(name_a, name_b, one, two,
 						textconv_one, textconv_two, o);
@@ -2529,7 +2535,8 @@ static void builtin_diff(const char *name_a,
 	}
 
 	if (o->irreversible_delete && lbl[1][0] == '/') {
-		fprintf(o->file, "%s", header.buf);
+		emit_diff_symbol(o, DIFF_SYMBOL_HEADER, header.buf,
+				 header.len, 0);
 		strbuf_reset(&header);
 		goto free_ab_and_return;
 	} else if (!DIFF_OPT_TST(o, TEXT) &&
@@ -2540,10 +2547,13 @@ static void builtin_diff(const char *name_a,
 		    !DIFF_OPT_TST(o, BINARY)) {
 			if (!oidcmp(&one->oid, &two->oid)) {
 				if (must_show_header)
-					fprintf(o->file, "%s", header.buf);
+					emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
+							 header.buf, header.len,
+							 0);
 				goto free_ab_and_return;
 			}
-			fprintf(o->file, "%s", header.buf);
+			emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
+					 header.buf, header.len, 0);
 			fprintf(o->file, "%sBinary files %s and %s differ\n",
 				line_prefix, lbl[0], lbl[1]);
 			goto free_ab_and_return;
@@ -2554,10 +2564,11 @@ static void builtin_diff(const char *name_a,
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size)) {
 			if (must_show_header)
-				fprintf(o->file, "%s", header.buf);
+				emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
+						 header.buf, header.len, 0);
 			goto free_ab_and_return;
 		}
-		fprintf(o->file, "%s", header.buf);
+		emit_diff_symbol(o, DIFF_SYMBOL_HEADER, header.buf, header.len, 0);
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
 			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
@@ -2575,7 +2586,8 @@ static void builtin_diff(const char *name_a,
 		const struct userdiff_funcname *pe;
 
 		if (must_show_header) {
-			fprintf(o->file, "%s", header.buf);
+			emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
+					 header.buf, header.len, 0);
 			strbuf_reset(&header);
 		}
 
-- 
2.13.0.31.g9b732c453e

