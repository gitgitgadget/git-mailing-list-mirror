Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04AC4202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbdF3AIi (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:08:38 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34307 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752380AbdF3AHf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:35 -0400
Received: by mail-pg0-f49.google.com with SMTP id t186so55416222pgb.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wz3+ygNjCIs8sVknYTnFQ56NbzgzTxHIn20tg/4TMrk=;
        b=t7AmI/x75BhZUQtFqJwWZV9tQGHlqKl3xWJ9jgiu5df3+6U7hIXcDqzQbDfM8vPBd6
         DJUlOuPxoyhlXzzp5MM/jCP99py1izx2Kl0H8BCKGWXl9+NFwaCDPvyaGCkHjfl5/9q1
         +OwyV0jgyAJEMDB/WpGJgU5LymxmagkuAkA2ZKfmqVNCF83gRErKK92kwBzRE+sVm2HI
         nRP4W4ooNcHWNvxJLiy+tg6JsACvIfuOxGMzVl+o1c6CJ2kg3rUm959OoALXCaG94Fkt
         VcFdPxcFdxbLoxQY3rIIRwCAyD9Au2dsEArRKn1EctpC0ig78kG/U9tYjVwhib3d8vB1
         u9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wz3+ygNjCIs8sVknYTnFQ56NbzgzTxHIn20tg/4TMrk=;
        b=JTHNqx0lg/miph/P/S4u0X+cNu2lyoVifx4iKQWPQDLbdWrzESVfGFmht9bG8jimt0
         8C2qq2Hi8voIpMibgfrlemWKQnNxKtBUzpivQjPO+FVrnQenHXRB7P0otFQmiaqeohFg
         +v8ExyG+y7givDfd2dzNgebEaCNVnc5mRRvcWi3yITHLQnoek4WmtNEPL7qHUxUrqG2i
         xvN/64KMNGOZFw6+1BCBLe/Kss8r7/C/hydVGGeJbo5JcvS1F6VPdXfcTJvD2Cf8zsBJ
         yGe3VlMXeXW93tspA4+Vazw962LcI9xQ4RPdspyvXOTp4cQs6e1fPYSHgcUW/U3JiEBI
         01Tg==
X-Gm-Message-State: AKS2vOxpkw1PGGAo5mztAgpiBbInSw7XjHmpqu9kndrQtIrzCyiQLBQ0
        umSBfqGx1pR6tt7Q
X-Received: by 10.98.202.210 with SMTP id y79mr19720329pfk.230.1498781254976;
        Thu, 29 Jun 2017 17:07:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id y185sm11285445pgb.9.2017.06.29.17.07.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS[_PORCELAIN]
Date:   Thu, 29 Jun 2017 17:06:54 -0700
Message-Id: <20170630000710.10601-10-sbeller@google.com>
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
 diff.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index e5430d56da..85bfd9310d 100644
--- a/diff.c
+++ b/diff.c
@@ -561,6 +561,8 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_WORDS_PORCELAIN,
+	DIFF_SYMBOL_WORDS,
 	DIFF_SYMBOL_CONTEXT,
 	DIFF_SYMBOL_PLUS,
 	DIFF_SYMBOL_MINUS,
@@ -649,6 +651,26 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
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
2.13.0.31.g9b732c453e

