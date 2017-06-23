Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5A82084A
	for <e@80x24.org>; Fri, 23 Jun 2017 01:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbdFWBaa (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:30:30 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36480 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753833AbdFWB3s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:48 -0400
Received: by mail-pg0-f54.google.com with SMTP id u62so14978042pgb.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EP/wCw0lWjhNZhRebAF7cOk0H8fhahtS9NYrR7Ckdes=;
        b=BFJdrsN0/pHMqElvs2TRKLXZgS7JOLBkOAw7vV9kvRYONsIF5pLeIZjlI307IGG648
         9JGG1NYoP3YgEMMIfPSuf7FQyCiCYSixaN93UENRVRuli6ekd1l/u855fCRlRz30E3DX
         CixcmIfMTYlgoZMjZLPLTdkqU5iFXzxID1VRPiCCgiGAe9c1ghXgXYjTHJGZU3DjJrlj
         HGmuI7Q436he1b85gYqoBg9yFoeZcWamAV3wxo171vrt1WCnz8HW6/N5TU6ZBhpofmt/
         xHfZ1KxqO9dlqb0ToClZNiXSJO4kpamSgmZyiBEG7mo653f6ZH3seoh+DAAk6qnXRxeO
         fvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EP/wCw0lWjhNZhRebAF7cOk0H8fhahtS9NYrR7Ckdes=;
        b=g4kDA/ylQ9onwswl0Gms4PPRbBAnXo8V7bhG3ItMxzHm6rn9kMPa2qf97E+zRAF+H9
         k+Mvsr1on9Pje8xWq7HJMuQ38gMXbQqATWSvFtUHvpKlJTHRfH/LtQCjCmI5fkTEj/yU
         2KkQks+RsiiNeqYWo2S5IlVFNKdV7NZhDHSJD/x7uBsZ6XTGsnahCrgl+xrIIwJsTnMx
         XT+g4435Hr6aXE45fzcZ1IV7LQ8wR86m0OqL53y2txvGD6TfTPYdOssnj/DxhJqlxrfI
         rcyG32pwyH3JijZxK5X0Zz0LetOOHQUSJkQsrQLpjThsgE6HfY4W8sCdECo4GzNOZ1JL
         C8Cg==
X-Gm-Message-State: AKS2vOxdAJLh12nUB9aTd5w8Oa0xwfB5Ucj60uEovgK9387cMMRbj5w3
        GnuGVFyDKtMM8d+zsgHyew==
X-Received: by 10.101.86.4 with SMTP id l4mr5574565pgs.29.1498181382137;
        Thu, 22 Jun 2017 18:29:42 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id a71sm1748806pfl.129.2017.06.22.18.29.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 11/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR_{PLUS, MINUS}
Date:   Thu, 22 Jun 2017 18:29:05 -0700
Message-Id: <20170623012919.28693-12-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have to use fprintf instead of emit_line, because we want to emit the
tab after the color. This is important for ancient versions of gnu patch
AFAICT, although we probably do not want to feed colored output to the
patch utility, such that it would not matter if the trailing tab is
colored. Keep the corner case as-is though.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 51 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/diff.c b/diff.c
index f3d0918810..761ee581ad 100644
--- a/diff.c
+++ b/diff.c
@@ -560,6 +560,8 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_FILEPAIR_PLUS,
+	DIFF_SYMBOL_FILEPAIR_MINUS,
 	DIFF_SYMBOL_WORDS_PORCELAIN,
 	DIFF_SYMBOL_WORDS,
 	DIFF_SYMBOL_CONTEXT,
@@ -610,7 +612,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len, unsigned flags)
 {
 	static const char *nneof = " No newline at end of file\n";
-	const char *context, *reset, *set;
+	const char *context, *reset, *set, *meta;
 	switch (s) {
 	case DIFF_SYMBOL_NO_LF_EOF:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
@@ -672,6 +674,20 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 		}
 		emit_line(o, context, reset, line, len);
 		break;
+	case DIFF_SYMBOL_FILEPAIR_PLUS:
+		meta = diff_get_color_opt(o, DIFF_METAINFO);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		fprintf(o->file, "%s%s+++ %s%s%s\n", diff_line_prefix(o), meta,
+			line, reset,
+			strchr(line, ' ') ? "\t" : "");
+		break;
+	case DIFF_SYMBOL_FILEPAIR_MINUS:
+		meta = diff_get_color_opt(o, DIFF_METAINFO);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		fprintf(o->file, "%s%s--- %s%s%s\n", diff_line_prefix(o), meta,
+			line, reset,
+			strchr(line, ' ') ? "\t" : "");
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -843,8 +859,6 @@ static void emit_rewrite_diff(const char *name_a,
 			      struct diff_options *o)
 {
 	int lc_a, lc_b;
-	const char *name_a_tab, *name_b_tab;
-	const char *metainfo = diff_get_color(o->use_color, DIFF_METAINFO);
 	const char *fraginfo = diff_get_color(o->use_color, DIFF_FRAGINFO);
 	const char *reset = diff_get_color(o->use_color, DIFF_RESET);
 	static struct strbuf a_name = STRBUF_INIT, b_name = STRBUF_INIT;
@@ -864,8 +878,6 @@ static void emit_rewrite_diff(const char *name_a,
 
 	name_a += (*name_a == '/');
 	name_b += (*name_b == '/');
-	name_a_tab = strchr(name_a, ' ') ? "\t" : "";
-	name_b_tab = strchr(name_b, ' ') ? "\t" : "";
 
 	strbuf_reset(&a_name);
 	strbuf_reset(&b_name);
@@ -892,11 +904,13 @@ static void emit_rewrite_diff(const char *name_a,
 
 	lc_a = count_lines(data_one, size_one);
 	lc_b = count_lines(data_two, size_two);
-	fprintf(o->file,
-		"%s%s--- %s%s%s\n%s%s+++ %s%s%s\n%s%s@@ -",
-		line_prefix, metainfo, a_name.buf, name_a_tab, reset,
-		line_prefix, metainfo, b_name.buf, name_b_tab, reset,
-		line_prefix, fraginfo);
+
+	emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR_MINUS,
+			 a_name.buf, a_name.len, 0);
+	emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR_PLUS,
+			 b_name.buf, b_name.len, 0);
+
+	fprintf(o->file, "%s%s@@ -", line_prefix, fraginfo);
 	if (!o->irreversible_delete)
 		print_line_count(o->file, lc_a);
 	else
@@ -1365,10 +1379,8 @@ static void find_lno(const char *line, struct emit_callback *ecbdata)
 static void fn_out_consume(void *priv, char *line, unsigned long len)
 {
 	struct emit_callback *ecbdata = priv;
-	const char *meta = diff_get_color(ecbdata->color_diff, DIFF_METAINFO);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 	struct diff_options *o = ecbdata->opt;
-	const char *line_prefix = diff_line_prefix(o);
 
 	o->found_changes = 1;
 
@@ -1379,15 +1391,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 
 	if (ecbdata->label_path[0]) {
-		const char *name_a_tab, *name_b_tab;
-
-		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
-		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
-
-		fprintf(o->file, "%s%s--- %s%s%s\n",
-			line_prefix, meta, ecbdata->label_path[0], reset, name_a_tab);
-		fprintf(o->file, "%s%s+++ %s%s%s\n",
-			line_prefix, meta, ecbdata->label_path[1], reset, name_b_tab);
+		emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR_MINUS,
+				 ecbdata->label_path[0],
+				 strlen(ecbdata->label_path[0]), 0);
+		emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR_PLUS,
+				 ecbdata->label_path[1],
+				 strlen(ecbdata->label_path[1]), 0);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
-- 
2.12.2.575.gb14f27f917

