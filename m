Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACEE12082E
	for <e@80x24.org>; Fri, 23 Jun 2017 01:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754081AbdFWB3m (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:29:42 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33362 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753833AbdFWB3k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:40 -0400
Received: by mail-pf0-f172.google.com with SMTP id e7so16606204pfk.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=55Yc0T5nnBUKa7zPoWiNvpcJq9Fs5C1y3lCN8Q3IJh4=;
        b=hTffL/vGmI1WAJg/m0lYCbrRGf33vLSjj6gm2MVCXgmcDCMhCLaDLfijXXVc6hue99
         tXl/JhrMNkxlrd6AUQLodEKaWvC7w3ZXIkO2h2K09XYSEpdHSssLAWUbqUuhFnbWttMB
         lzxgF3gJ027qR8f8+gE8W74OFQZHqh6LoNxImjrAFraF1nDe0PMzufKJYba6qE91bBQo
         sNAyANusj6o5Ueb3/gHmQshHxzm1uo85P5qe8aQ6219nn66dvGXTORkkTkRjNUozhiVB
         azgyKmtfAhFYRInHHc3llAynz++4AdPBfHUEKy3WPO+QIIbdb9Zvm1bl/wR1KjlqDN1/
         An2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=55Yc0T5nnBUKa7zPoWiNvpcJq9Fs5C1y3lCN8Q3IJh4=;
        b=MPGbab+AMKoStkQis2DW7RqqN1xAxekt/bW6QKPa8fuYCNU1zqVvqpvqP03aGHLZR+
         YW6WzahwWyugSYo7FqCTCrvs/tQ/LI0z++mzcGLj6PCRmcD4TZNFB2yosxRnoVHNtRIA
         NhTt557qVamEqrX2T+2TYehy/SwSkLT+AI158l7iCmHd+3f0Igi4h9EfVgUq7m7DXxQK
         7C/7f9/jPg2qqVCCLNSVq5r8hlhTPURLdq+a+FIcMW4EkLcCA6+iJaL9VWxYWTBm1FjG
         jFxOIRyx1KZxmD2e+IoahrVmkWw0i8G92RZx5SuvNKwNxavo+C81+E5iB0BB1Y2DqPfU
         1z/A==
X-Gm-Message-State: AKS2vOzKlYW+ZAn1otnnZCYxyqP4yCIfCQ0OB6quQJdMLbw9EKpIbYL3
        PYX91MoJ2Hx1hSYQ
X-Received: by 10.101.76.3 with SMTP id u3mr4037023pgq.177.1498181379579;
        Thu, 22 Jun 2017 18:29:39 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id z71sm6146647pfd.45.2017.06.22.18.29.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:38 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 09/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS[_PORCELAIN]
Date:   Thu, 22 Jun 2017 18:29:03 -0700
Message-Id: <20170623012919.28693-10-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index e7583efca3..3d081edd12 100644
--- a/diff.c
+++ b/diff.c
@@ -560,6 +560,8 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_WORDS_PORCELAIN,
+	DIFF_SYMBOL_WORDS,
 	DIFF_SYMBOL_CONTEXT,
 	DIFF_SYMBOL_PLUS,
 	DIFF_SYMBOL_MINUS,
@@ -648,6 +650,26 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 		emit_line_ws_markup(o, set, reset, line, len, '-',
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
+	case DIFF_SYMBOL_WORDS_PORCELAIN:
+		context = diff_get_color_opt(o, DIFF_CONTEXT);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line(o, context, reset, line, len);
+		fputs("~\n", o->file);
+		break;
+	case DIFF_SYMBOL_WORDS:
+		context = diff_get_color_opt(o, DIFF_CONTEXT);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		/*
+		 * Skip the prefix character, if any.  With
+		 * diff_suppress_blank_empty, there may be
+		 * none.
+		 */
+		if (line[0] != '\n') {
+			line++;
+			len--;
+		}
+		emit_line(o, context, reset, line, len);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -1342,7 +1364,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 {
 	struct emit_callback *ecbdata = priv;
 	const char *meta = diff_get_color(ecbdata->color_diff, DIFF_METAINFO);
-	const char *context = diff_get_color(ecbdata->color_diff, DIFF_CONTEXT);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 	struct diff_options *o = ecbdata->opt;
 	const char *line_prefix = diff_line_prefix(o);
@@ -1384,6 +1405,9 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 
 	if (ecbdata->diff_words) {
+		enum diff_symbol s =
+			ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN ?
+			DIFF_SYMBOL_WORDS_PORCELAIN : DIFF_SYMBOL_WORDS;
 		if (line[0] == '-') {
 			diff_words_append(line, len,
 					  &ecbdata->diff_words->minus);
@@ -1403,21 +1427,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			return;
 		}
 		diff_words_flush(ecbdata);
-		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
-			emit_line(o, context, reset, line, len);
-			fputs("~\n", o->file);
-		} else {
-			/*
-			 * Skip the prefix character, if any.  With
-			 * diff_suppress_blank_empty, there may be
-			 * none.
-			 */
-			if (line[0] != '\n') {
-			      line++;
-			      len--;
-			}
-			emit_line(o, context, reset, line, len);
-		}
+		emit_diff_symbol(o, s, line, len, 0);
 		return;
 	}
 
-- 
2.12.2.575.gb14f27f917

