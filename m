Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A05AA202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbdF3AHu (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:07:50 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33021 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbdF3AHr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:47 -0400
Received: by mail-pf0-f170.google.com with SMTP id e7so58084823pfk.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zsMoGCMIj4/s33TY3svRh3pK8Dz7qVSuVKfryMakM48=;
        b=LDuO4c+5iUp3j/fmaxTxhLvOUUsfJdMMNvTd2HE2nnN2G+29wU06bX53YY7WTKAXYH
         0+HiB3qArbBvmvLffLAm9/9QbykU6whHjHMwbo2pRm5eNwWq7KpqyHpxguABYIUlEqhy
         iDLnxscXy8xvV337AkWmc1FHX9tNNY1wxSX6Cy3ZlJofdgBG6r3mIYW/FflXTUmgZcEU
         ai6M/8J0em9No+XuLcWQCmPu9Zyf7AB3rGhGsTt/v7cjnh1ShQ+nBp6nN4dL+qLYLV8Z
         tUA7JDPTRUYKfCxoyOiJIGplIRZSBFdNI+8ostMLWQs7qYbksMYKSyCVxB6k+8bitXpV
         JIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zsMoGCMIj4/s33TY3svRh3pK8Dz7qVSuVKfryMakM48=;
        b=tQv4xCqSujXvM+axEQba6nH5qHCa30tPvVaXqubLgKQZzfx3Nu6A+LEkjrVbIsr4kw
         JNMXFdYd5G0fmXhQoq8S5dnLGKxC0AUrUIw9UxMQRxhfXtYrv5zg0xMfVzkSbOXvSotZ
         LNdJNxVswlqYRBpVMytEYpAWF7u7zBjtzHITaT2KHG+EmqMkyEYuLScZ7uba2c2NPEt4
         xBiO/MwW9dNnHWmpeDUlPushZoSuM2tQcj1Xa93UqdlIcl2X8QkbqO9VLHKI0hjIJ8s1
         VZg4CMyOR6LNgJ1hJGQ7Pj7wvxRBS1ZtJnzL76lWjMUQ5MUryK1MawyrK4iFm/mtC/36
         nW4g==
X-Gm-Message-State: AKS2vOz7yrigii7bNk47HSizZsScKhJax8iynji2wq7KSH9ic4eJ6pco
        Yl6oE/7cnlgzR41H
X-Received: by 10.99.125.86 with SMTP id m22mr49774pgn.96.1498781266388;
        Thu, 29 Jun 2017 17:07:46 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id 197sm11399326pga.58.2017.06.29.17.07.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 18/25] diff.c: convert word diffing to use emit_diff_symbol
Date:   Thu, 29 Jun 2017 17:07:03 -0700
Message-Id: <20170630000710.10601-19-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630000710.10601-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The word diffing is not line oriented and would need some serious
effort to be transformed into a line oriented approach, so
just go with a symbol DIFF_SYMBOL_WORD_DIFF that is a partial line.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 79 ++++++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/diff.c b/diff.c
index 76d4b8ebf9..e0d39d04da 100644
--- a/diff.c
+++ b/diff.c
@@ -570,6 +570,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_STATS_SUMMARY_ABBREV,
 	DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES,
 	DIFF_SYMBOL_STATS_LINE,
+	DIFF_SYMBOL_WORD_DIFF,
 	DIFF_SYMBOL_SUBMODULE_ADD,
 	DIFF_SYMBOL_SUBMODULE_DEL,
 	DIFF_SYMBOL_SUBMODULE_UNTRACKED,
@@ -762,6 +763,9 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_STATS_SUMMARY_ABBREV:
 		emit_line(o, "", "", " ...\n", strlen(" ...\n"));
 		break;
+	case DIFF_SYMBOL_WORD_DIFF:
+		fprintf(o->file, "%.*s", len, line);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -1092,37 +1096,49 @@ struct diff_words_data {
 	struct diff_words_style *style;
 };
 
-static int fn_out_diff_words_write_helper(FILE *fp,
+static int fn_out_diff_words_write_helper(struct diff_options *o,
 					  struct diff_words_style_elem *st_el,
 					  const char *newline,
-					  size_t count, const char *buf,
-					  const char *line_prefix)
+					  size_t count, const char *buf)
 {
 	int print = 0;
+	struct strbuf sb = STRBUF_INIT;
 
 	while (count) {
 		char *p = memchr(buf, '\n', count);
 		if (print)
-			fputs(line_prefix, fp);
+			strbuf_addstr(&sb, diff_line_prefix(o));
+
 		if (p != buf) {
-			if (st_el->color && fputs(st_el->color, fp) < 0)
-				return -1;
-			if (fputs(st_el->prefix, fp) < 0 ||
-			    fwrite(buf, p ? p - buf : count, 1, fp) != 1 ||
-			    fputs(st_el->suffix, fp) < 0)
-				return -1;
-			if (st_el->color && *st_el->color
-			    && fputs(GIT_COLOR_RESET, fp) < 0)
-				return -1;
+			const char *reset = st_el->color && *st_el->color ?
+					    GIT_COLOR_RESET : NULL;
+			if (st_el->color && *st_el->color)
+				strbuf_addstr(&sb, st_el->color);
+			strbuf_addstr(&sb, st_el->prefix);
+			strbuf_add(&sb, buf, p ? p - buf : count);
+			strbuf_addstr(&sb, st_el->suffix);
+			if (reset)
+				strbuf_addstr(&sb, reset);
 		}
 		if (!p)
-			return 0;
-		if (fputs(newline, fp) < 0)
-			return -1;
+			goto out;
+
+		strbuf_addstr(&sb, newline);
 		count -= p + 1 - buf;
 		buf = p + 1;
 		print = 1;
+		if (count) {
+			emit_diff_symbol(o, DIFF_SYMBOL_WORD_DIFF,
+					 sb.buf, sb.len, 0);
+			strbuf_reset(&sb);
+		}
 	}
+
+out:
+	if (sb.len)
+		emit_diff_symbol(o, DIFF_SYMBOL_WORD_DIFF,
+				 sb.buf, sb.len, 0);
+	strbuf_release(&sb);
 	return 0;
 }
 
@@ -1204,24 +1220,20 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 		fputs(line_prefix, diff_words->opt->file);
 	}
 	if (diff_words->current_plus != plus_begin) {
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words->opt,
 				&style->ctx, style->newline,
 				plus_begin - diff_words->current_plus,
-				diff_words->current_plus, line_prefix);
-		if (*(plus_begin - 1) == '\n')
-			fputs(line_prefix, diff_words->opt->file);
+				diff_words->current_plus);
 	}
 	if (minus_begin != minus_end) {
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words->opt,
 				&style->old, style->newline,
-				minus_end - minus_begin, minus_begin,
-				line_prefix);
+				minus_end - minus_begin, minus_begin);
 	}
 	if (plus_begin != plus_end) {
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words->opt,
 				&style->new, style->newline,
-				plus_end - plus_begin, plus_begin,
-				line_prefix);
+				plus_end - plus_begin, plus_begin);
 	}
 
 	diff_words->current_plus = plus_end;
@@ -1315,11 +1327,12 @@ static void diff_words_show(struct diff_words_data *diff_words)
 
 	/* special case: only removal */
 	if (!diff_words->plus.text.size) {
-		fputs(line_prefix, diff_words->opt->file);
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		emit_diff_symbol(diff_words->opt, DIFF_SYMBOL_WORD_DIFF,
+				 line_prefix, strlen(line_prefix), 0);
+		fn_out_diff_words_write_helper(diff_words->opt,
 			&style->old, style->newline,
 			diff_words->minus.text.size,
-			diff_words->minus.text.ptr, line_prefix);
+			diff_words->minus.text.ptr);
 		diff_words->minus.text.size = 0;
 		return;
 	}
@@ -1342,12 +1355,12 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	if (diff_words->current_plus != diff_words->plus.text.ptr +
 			diff_words->plus.text.size) {
 		if (color_words_output_graph_prefix(diff_words))
-			fputs(line_prefix, diff_words->opt->file);
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+			emit_diff_symbol(diff_words->opt, DIFF_SYMBOL_WORD_DIFF,
+					 line_prefix, strlen(line_prefix), 0);
+		fn_out_diff_words_write_helper(diff_words->opt,
 			&style->ctx, style->newline,
 			diff_words->plus.text.ptr + diff_words->plus.text.size
-			- diff_words->current_plus, diff_words->current_plus,
-			line_prefix);
+			- diff_words->current_plus, diff_words->current_plus);
 	}
 	diff_words->minus.text.size = diff_words->plus.text.size = 0;
 }
-- 
2.13.0.31.g9b732c453e

