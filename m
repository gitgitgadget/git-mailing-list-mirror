Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09D531FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbdFTCsr (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:48:47 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35338 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFTCsp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:45 -0400
Received: by mail-pf0-f181.google.com with SMTP id c73so2561674pfk.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A5cKB019sv6wkko3KUk9GU/vOAsrKUlcbp8cMQ3s0Ec=;
        b=NQ4xVSGON7ZJBZfbX1rllPYsMuYJ0/WDxJT/YdtTZ9GeOVtgoWjK2/EuSlFlDefD/8
         g3Sjy7xDdHtrT9j2zhgeUMaM86Ml1Mu55H25XG04F5qYcR/48xIhoEgwXeGFR0Q4s1PV
         g0WsxApnUOxIBnHQomXk7LD0peeTA3Ze/dqJgNawBFxHeyZpS2x0d2thvzc3DoonMir6
         jOfFZTsn/z8a78J52nGsA8yhWnnRCdxR1qubnsl8/jK6Ccshe/2gyJfQocmjcRJ+I5ic
         nJ2RfAcXV5vmxnxDytNP6/Jsi6bnmgNal6GaVV6oRaukD7/8c88XQ0I2FiADK4ypMlYA
         e/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A5cKB019sv6wkko3KUk9GU/vOAsrKUlcbp8cMQ3s0Ec=;
        b=UeOB1qbpp9lwyaPvM7y3iww87a7IU4emoY2NNo/eBUkFJMHbpmnLW7/cL+evuIydAv
         Mtc14Eoz49iD8NU4KXIWhe0KohFXAjpjzDoOfnsyRxdihTgsp06bwRtNjtJ18c6XK8kN
         oxY60nHsIrQpexSBskvs/GNqU1nlb+xVJgeKsni+Zc4oeD6vuzY6XuIUwSzqkPuvPoAy
         D/y02FSWpnxqaIg/kXH8jVlAVbVCj5gYMeFFKZ8fFInU/vEifKCDM/8qoY55CZW2JXLr
         zSrxdP6hPZfLR8US8PvusMJkQlV6jwPbn/Knuyy3piNyvnnbmXeaSHetOnjGLoNXZMf3
         fZzQ==
X-Gm-Message-State: AKS2vOyIP9pp+e9pzQ4kt4KyO8auLakMLhxNCGv8KPdDdFpgLhB94D3c
        /ov64iTDkGo5L8YQ
X-Received: by 10.99.2.78 with SMTP id 75mr20502009pgc.120.1497926919343;
        Mon, 19 Jun 2017 19:48:39 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id x27sm26803150pfe.113.2017.06.19.19.48.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:38 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 12/26] diff.c: emit_diff_symbol learns DIFF_SYMBOL_HEADER
Date:   Mon, 19 Jun 2017 19:48:02 -0700
Message-Id: <20170620024816.20021-13-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 7c56150b56..95f11ea86f 100644
--- a/diff.c
+++ b/diff.c
@@ -571,6 +571,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_WORDS_PORCELAIN,
 	DIFF_SYMBOL_WORDS,
 	DIFF_SYMBOL_FILEPAIR,
+	DIFF_SYMBOL_HEADER,
 };
 /*
  * Flags for content lines:
@@ -685,6 +686,9 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			line, reset,
 			strchr(line, ' ') ? "\t" : "");
 		break;
+	case DIFF_SYMBOL_HEADER:
+		fprintf(o->file, "%s", line);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -1380,7 +1384,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	o->found_changes = 1;
 
 	if (ecbdata->header) {
-		fprintf(o->file, "%s", ecbdata->header->buf);
+		emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
+				 ecbdata->header->buf, ecbdata->header->len, 0);
 		strbuf_reset(ecbdata->header);
 		ecbdata->header = NULL;
 	}
@@ -2514,7 +2519,8 @@ static void builtin_diff(const char *name_a,
 		if (complete_rewrite &&
 		    (textconv_one || !diff_filespec_is_binary(one)) &&
 		    (textconv_two || !diff_filespec_is_binary(two))) {
-			fprintf(o->file, "%s", header.buf);
+			emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
+					 header.buf, header.len, 0);
 			strbuf_reset(&header);
 			emit_rewrite_diff(name_a, name_b, one, two,
 						textconv_one, textconv_two, o);
@@ -2524,7 +2530,8 @@ static void builtin_diff(const char *name_a,
 	}
 
 	if (o->irreversible_delete && lbl[1][0] == '/') {
-		fprintf(o->file, "%s", header.buf);
+		emit_diff_symbol(o, DIFF_SYMBOL_HEADER, header.buf,
+				 header.len, 0);
 		strbuf_reset(&header);
 		goto free_ab_and_return;
 	} else if (!DIFF_OPT_TST(o, TEXT) &&
@@ -2535,10 +2542,13 @@ static void builtin_diff(const char *name_a,
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
@@ -2549,10 +2559,11 @@ static void builtin_diff(const char *name_a,
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
@@ -2570,7 +2581,8 @@ static void builtin_diff(const char *name_a,
 		const struct userdiff_funcname *pe;
 
 		if (must_show_header) {
-			fprintf(o->file, "%s", header.buf);
+			emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
+					 header.buf, header.len, 0);
 			strbuf_reset(&header);
 		}
 
-- 
2.12.2.575.gb14f27f917

