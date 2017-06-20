Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7685B1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbdFTCtZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:49:25 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33814 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdFTCsq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:46 -0400
Received: by mail-pf0-f169.google.com with SMTP id s66so62710533pfs.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=47xDqbSQPnJRXaWInztRz8mazauD0+qlnS1/Gv8DXYw=;
        b=gBNvIZUMpSYygpQdWSiwBqsymwiKtYfBicB7RBGPgst34WZq8ubQpELkWn+HGaagVJ
         9XMWC6Re8lMU4dxvek0hMWp87SlqkHUdoPKxuUKaFxti4v4o3ynG7Yt3AOyyXNQuE2/v
         7U26uIUo3jdrcJaov3wJdVOhow7NWrachY0fXBe1V7JFK29QWGoMeKvCcmhRYiizjatI
         JjuAh9u4UVvhWWsZNzhWJ6c6wjVRqtqdcNLESqMi4LQiThDm/xdOcC1881faIOR8/2rD
         Z88MI+mXkEICuKIIXKK/Sx4AGhPAlYPPtVxrZRFFUcgFaCHmQGGRUUG6yc20pN3cLu3O
         9MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=47xDqbSQPnJRXaWInztRz8mazauD0+qlnS1/Gv8DXYw=;
        b=mUK9ZUoukTAX8eODKKvG1S/mrsePq4S0g1P58sMbaxDGCP3LxdmQNfxc1EWhq5ECue
         cRhh4gq6IZLQqntoJiiTS6s9Bnyrzs2xicrg0J4dYcqqiXq/U8ZSrpta/VVc3eTEvEBL
         uuEFXzWMM8uhzEJFA0sTG79SkDtl5oKWnGkoqxqdqygZ63LpA7L0xaozkn49VkZAcjVQ
         mPpOFEY+5AAPNLK1MTue+5yoGM1y8kKJ+od6yHY/thqr6eNQylt35P7zcjFup5OSK6bg
         yFDnT7w63FZ7i6mxJ0V7mfEgAtxkEUcn+eQaIGdw/T4PxT3+rK457rB2wc991Guou/XL
         kHZw==
X-Gm-Message-State: AKS2vOygBgrih14bfqzsTThQffjLybSaHmPq5/ct4pvGhZWOF42TqJS6
        95/ChsSwZvaGYLrn
X-Received: by 10.99.178.16 with SMTP id x16mr28757032pge.220.1497926915798;
        Mon, 19 Jun 2017 19:48:35 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id z4sm20964041pgc.22.2017.06.19.19.48.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 09/26] diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS{_PORCELAIN}
Date:   Mon, 19 Jun 2017 19:47:59 -0700
Message-Id: <20170620024816.20021-10-sbeller@google.com>
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
 diff.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index 42c9f48dc2..7096457c8a 100644
--- a/diff.c
+++ b/diff.c
@@ -567,6 +567,8 @@ enum diff_symbol {
 	DIFF_SYMBOL_CONTEXT,
 	DIFF_SYMBOL_PLUS,
 	DIFF_SYMBOL_MINUS,
+	DIFF_SYMBOL_WORDS_PORCELAIN,
+	DIFF_SYMBOL_WORDS,
 };
 /*
  * Flags for content lines:
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

