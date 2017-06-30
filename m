Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40EAC201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753054AbdF3Uxb (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:53:31 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34042 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753044AbdF3Ux3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:29 -0400
Received: by mail-pg0-f54.google.com with SMTP id t186so69045570pgb.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5oYmzRp0N3UAnia023EX3p036s2/3bYFn7kVPWQFqe4=;
        b=aMwMSkvTah35VjhUzxN4IDsfzHA0hke8ij1nwvoehZtshz4g6CfnJC6kZy5ZeX4Y/x
         6xYQOpfctE7YQ1pkEg+/9cdQZ8KdotZYiG7tF0fQXiXK0cLQ08Nbn/o2WxUFKuhtpflV
         u+SAlGCdDICmnW91sVT3iAhShfTm22HdidFTOn4+cJ0SaUj596EkQVwWQ74cHZK+LkXE
         oMeLaANLVR66kqdBmzv33WPP1ekqsjGR5xSgiOW0j+D53lSjlZglmzHld4Af+LIxyPjn
         NBb1dC/y9qWciwuWlRq7fm5x7ueW5X1QKFRYsAnpvbAcuVbotJ9H1rl5fIkhjr+Rh49v
         wUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5oYmzRp0N3UAnia023EX3p036s2/3bYFn7kVPWQFqe4=;
        b=nEGbOt1gOuPBPdVfR7I+Hav0VZyFPBcJXXAY8bsZmRwAPB4gN0RNl+5Yn2tjBNvrTd
         HzDC2p3sfpn9KpVBrLnW7G8bFIVe4Wq2SriSmDbzeXi2bCnN1C8E3w9PyL18Rqb3xRXf
         uw7YiAn2Eu+KcBsSKbCMXd0dyKtW3kga+uWVUIgjNeorIQbxxQGGSPkZcELixjvVlbMB
         ufwuDob5AN63W0c7lMzUKtnqvO/TWFdnJ2VggDMmsDklrWXcNS01rn2eD9MXDffky85R
         4PKGAzmdJ424lk9/aXO8fPOPRkv4JxTfHVf0ZbOKZcaLFJJNFpmld2aPnlDte+YEW6u/
         p4mA==
X-Gm-Message-State: AKS2vOxVMarwx1mH56pgmj0UpJugnmNajjFHXoF30q6+zUIfj9Elmy91
        tWTrgXd2p64p8/MM
X-Received: by 10.84.179.36 with SMTP id a33mr9327963plc.144.1498856009130;
        Fri, 30 Jun 2017 13:53:29 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id d185sm14992105pgc.39.2017.06.30.13.53.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:28 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 12/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_HEADER
Date:   Fri, 30 Jun 2017 13:52:57 -0700
Message-Id: <20170630205310.7380-13-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630205310.7380-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630205310.7380-1-sbeller@google.com>
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

