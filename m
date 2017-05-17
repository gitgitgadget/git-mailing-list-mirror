Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C09202023D
	for <e@80x24.org>; Wed, 17 May 2017 02:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbdEQC7s (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:59:48 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:32934 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752990AbdEQC7n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:59:43 -0400
Received: by mail-pf0-f181.google.com with SMTP id e193so89805313pfh.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ufmT24cw2m/o2F1c3FroKFcnJdei9cwkjmTuH1Qhoeg=;
        b=KgZzy3EnxTQAMknJz871RFEbatchyn8FnPZ+DdasIndCXCoSHu6Mw3lhH5EFwLd61o
         kOUdzbXY/rrmNDY/by8QxhGVjKsBxY2ncx2DaR1b3JP2XZwz2c+xDeIipS8Jbodrg8iz
         CTqoLAJH+M14M+YlibFnvJqOogRcktqfKEsuso1XxnJoLWPgOXhNnb3xmXZLHcckHnaN
         1yZbKz/O6lNwC7SAYQwh2I9EJ1tR9QdE2Wr0vpaHB+l1Jx1hdu0dmOr6cUktNnc6dk2G
         qH41/1vSoV4yVAZzGosAd76DSqbYIpNpTaiiJ+RT/GUmSHRoK2u/7ltm2qsunMwH/qGE
         reVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ufmT24cw2m/o2F1c3FroKFcnJdei9cwkjmTuH1Qhoeg=;
        b=fM9EA47IjjnuCE5FDwsVKZDiQelOef5uHf0HucJq7dM5dj0VivsN0K+26CJ/KZNPQD
         PvHKdCzRgj5nQif8ypzJoWajMrEeX91L04yuH8zTQVtoGIQat18PZ6UmnKaUTO0QJXl6
         hew+WlVjw1UsxS8+CsJ859b/awuM0yVKEoyF4UO4s2KeNJnxAp3KmBCle5y1mDUjkQj1
         iAKIIZ4ArtUTA1dfn64aYs4JMp/gSZ/nNsPVz+I95M4o+NWx9/lTQtaHo3iTWWaLSAw3
         HRjRW1WpHX5UwdBclzcvZjVb3FghRhKgIM+tScqibGrMJ6NZBfup9NvPbZvORmW8gMsx
         Q+ww==
X-Gm-Message-State: AODbwcDGf+7zeO4wPE08tcdutNGDa+Rc9/wBipf/ZzFdAm4bh9mvVHkK
        vbBfzZo8gaQnrn0T
X-Received: by 10.99.117.65 with SMTP id f1mr1357152pgn.58.1494989966195;
        Tue, 16 May 2017 19:59:26 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id c12sm657910pfl.79.2017.05.16.19.59.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:59:25 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 18/20] diff.c: emit_line includes whitespace highlighting
Date:   Tue, 16 May 2017 19:58:55 -0700
Message-Id: <20170517025857.32320-19-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517025857.32320-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170517025857.32320-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently any whitespace highlighting happens outside the emit_line
function. Teach the highlighting to emit_line, triggered by a new
parameter.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c      | 104 +++++++++++++++++++++++++++++++++++-------------------------
 diff.h      |   4 ++-
 submodule.c |  14 ++++----
 3 files changed, 71 insertions(+), 51 deletions(-)

diff --git a/diff.c b/diff.c
index 964b5cb5a7..34482a6a09 100644
--- a/diff.c
+++ b/diff.c
@@ -516,15 +516,33 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
-void emit_line(struct diff_options *o, const char *set, const char *reset,
-	       int add_line_prefix, int sign, const char *line, int len)
+void emit_line(struct diff_options *o,
+	       const char *set, const char *reset,
+	       int add_line_prefix, int markup_ws,
+	       int sign, const char *line, int len)
 {
+	const char *ws;
 	int has_trailing_newline, has_trailing_carriage_return;
 	FILE *file = o->file;
 
 	if (add_line_prefix)
 		fputs(diff_line_prefix(o), file);
 
+	if (markup_ws) {
+		ws = diff_get_color(o->use_color, DIFF_WHITESPACE);
+
+		if (set)
+			fputs(set, file);
+		if (sign)
+			fputc(sign, file);
+		if (reset)
+			fputs(reset, file);
+		ws = diff_get_color(o->use_color, DIFF_WHITESPACE);
+		ws_check_emit(line, len, o->ws_rule,
+			      file, set, reset, ws);
+		return;
+	}
+
 	has_trailing_newline = (len > 0 && line[len-1] == '\n');
 	if (has_trailing_newline)
 		len--;
@@ -558,7 +576,7 @@ void emit_line_fmt(struct diff_options *o,
 	strbuf_vaddf(&sb, fmt, ap);
 	va_end(ap);
 
-	emit_line(o, set, reset, add_line_prefix, 0, sb.buf, sb.len);
+	emit_line(o, set, reset, add_line_prefix, 0, 0, sb.buf, sb.len);
 	strbuf_release(&sb);
 }
 
@@ -590,16 +608,15 @@ static void emit_line_checked(const char *reset,
 	}
 
 	if (!ws)
-		emit_line(ecbdata->opt, set, reset, 1, sign, line, len);
+		emit_line(ecbdata->opt, set, reset, 1, 0, sign, line, len);
 	else if (sign == '+' && new_blank_line_at_eof(ecbdata, line, len))
 		/* Blank line at EOF - paint '+' as well */
-		emit_line(ecbdata->opt, ws, reset, 1, sign, line, len);
+		emit_line(ecbdata->opt, ws, reset, 1, 1, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line(ecbdata->opt, set, reset, 1, sign, "", 0);
-		ws_check_emit(line, len, ecbdata->ws_rule,
-			      ecbdata->opt->file, set, reset, ws);
+		emit_line(ecbdata->opt, set, reset, 1, 1, sign, line, len);
 	}
+
 }
 
 static void emit_add_line(const char *reset,
@@ -646,7 +663,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	if (len < 10 ||
 	    memcmp(line, atat, 2) ||
 	    !(ep = memmem(line + 2, len - 2, atat, 2))) {
-		emit_line(ecbdata->opt, context, reset, 1, 0, line, len);
+		emit_line(ecbdata->opt, context, reset, 1, 0, 0, line, len);
 		return;
 	}
 	ep += 2; /* skip over @@ */
@@ -682,7 +699,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	strbuf_add(&msgbuf, line + len, org_len - len);
 	strbuf_complete_line(&msgbuf);
 
-	emit_line(ecbdata->opt, "", "", 1, 0, msgbuf.buf, msgbuf.len);
+	emit_line(ecbdata->opt, "", "", 1, 0, 0, msgbuf.buf, msgbuf.len);
 	strbuf_release(&msgbuf);
 }
 
@@ -755,7 +772,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		static const char *nneof = "\\ No newline at end of file\n";
 		const char *context = diff_get_color(ecb->color_diff,
 						     DIFF_CONTEXT);
-		emit_line(ecb->opt, context, reset, 1, 0,
+		emit_line(ecb->opt, context, reset, 1, 0, 0,
 			    nneof, strlen(nneof));
 		strbuf_release(&sb);
 	}
@@ -831,7 +848,7 @@ static void emit_rewrite_diff(const char *name_a,
 	strbuf_addstr(&out, " +");
 	add_line_count(&out, lc_b);
 	strbuf_addstr(&out, " @@\n");
-	emit_line(o, fraginfo, reset, 1, 0, out.buf, out.len);
+	emit_line(o, fraginfo, reset, 1, 0, 0, out.buf, out.len);
 	strbuf_release(&out);
 
 	if (lc_a && !o->irreversible_delete)
@@ -904,7 +921,7 @@ static int fn_out_diff_words_write_helper(struct diff_options *o,
 	while (count) {
 		char *p = memchr(buf, '\n', count);
 		if (print)
-			emit_line(o, NULL, NULL, 1, 0, "", 0);
+			emit_line(o, NULL, NULL, 1, 0, 0, "", 0);
 
 		if (p != buf) {
 			const char *reset = st_el->color && *st_el->color ?
@@ -913,14 +930,14 @@ static int fn_out_diff_words_write_helper(struct diff_options *o,
 			strbuf_add(&sb, buf, p ? p - buf : count);
 			strbuf_addstr(&sb, st_el->suffix);
 			emit_line(o, st_el->color, reset,
-				  0, 0, sb.buf, sb.len);
+				  0, 0, 0, sb.buf, sb.len);
 			strbuf_reset(&sb);
 		}
 		if (!p)
 			goto out;
 
 		strbuf_addstr(&sb, newline);
-		emit_line(o, NULL, NULL, 0, 0, sb.buf, sb.len);
+		emit_line(o, NULL, NULL, 0, 0, 0, sb.buf, sb.len);
 		strbuf_reset(&sb);
 		count -= p + 1 - buf;
 		buf = p + 1;
@@ -1135,7 +1152,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	if (diff_words->current_plus != diff_words->plus.text.ptr +
 			diff_words->plus.text.size) {
 		if (color_words_output_graph_prefix(diff_words))
-			emit_line(diff_words->opt, NULL, NULL, 1, 0, "", 0);
+			emit_line(diff_words->opt, NULL, NULL, 1, 0, 0, "", 0);
 		fn_out_diff_words_write_helper(diff_words->opt,
 			&style->ctx, style->newline,
 			diff_words->plus.text.ptr + diff_words->plus.text.size
@@ -1294,7 +1311,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	o->found_changes = 1;
 
 	if (ecbdata->header) {
-		emit_line(o, NULL, NULL, 0, 0,
+		emit_line(o, NULL, NULL, 0, 0, 0,
 			  ecbdata->header->buf, ecbdata->header->len);
 		strbuf_release(ecbdata->header);
 		ecbdata->header = NULL;
@@ -1347,8 +1364,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		}
 		diff_words_flush(ecbdata);
 		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
-			emit_line(o, context, reset, 1, 0, line, len);
-			emit_line(o, NULL, NULL, 0, 0, "~\n", 2);
+			emit_line(o, context, reset, 1, 0, 0, line, len);
+			emit_line(o, NULL, NULL, 0, 0, 0, "~\n", 2);
 		} else {
 			/*
 			 * Skip the prefix character, if any.  With
@@ -1359,7 +1376,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			      line++;
 			      len--;
 			}
-			emit_line(o, context, reset, 1, 0, line, len);
+			emit_line(o, context, reset, 1, 0, 0, line, len);
 		}
 		return;
 	}
@@ -1382,7 +1399,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		/* incomplete line at the end */
 		ecbdata->lno_in_preimage++;
 		emit_line(o, diff_get_color(ecbdata->color_diff, DIFF_CONTEXT),
-			  reset, 1, 0, line, len);
+			  reset, 1, 0, 0, line, len);
 		break;
 	}
 }
@@ -1571,7 +1588,7 @@ void print_stat_summary_0(struct diff_options *options, int files,
 	if (!files) {
 		assert(insertions == 0 && deletions == 0);
 		strbuf_addstr(&sb, " 0 files changed");
-		emit_line(options, NULL, NULL, 1, 0, sb.buf, sb.len);
+		emit_line(options, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 		return;
 	}
 
@@ -1599,7 +1616,7 @@ void print_stat_summary_0(struct diff_options *options, int files,
 			    deletions);
 	}
 	strbuf_addch(&sb, '\n');
-	emit_line(options, NULL, NULL, 1, 0, sb.buf, sb.len);
+	emit_line(options, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 	strbuf_release(&sb);
 }
 
@@ -1783,7 +1800,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			strbuf_addf(&out, " %*s", number_width, "Bin");
 			if (!added && !deleted) {
 				strbuf_addch(&out, '\n');
-				emit_line(options, NULL, NULL, 1, 0, out.buf, out.len);
+				emit_line(options, NULL, NULL, 1, 0, 0, out.buf, out.len);
 				strbuf_reset(&out);
 				continue;
 			}
@@ -1793,14 +1810,14 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			strbuf_addf(&out, "%s%"PRIuMAX"%s",
 				add_c, added, reset);
 			strbuf_addstr(&out, " bytes\n");
-			emit_line(options, NULL, NULL, 1, 0, out.buf, out.len);
+			emit_line(options, NULL, NULL, 1, 0, 0, out.buf, out.len);
 			strbuf_reset(&out);
 			continue;
 		}
 		else if (file->is_unmerged) {
 			show_name(&out, prefix, name, len);
 			strbuf_addstr(&out, " Unmerged\n");
-			emit_line(options, NULL, NULL, 1, 0, out.buf, out.len);
+			emit_line(options, NULL, NULL, 1, 0, 0, out.buf, out.len);
 			strbuf_reset(&out);
 			continue;
 		}
@@ -1831,7 +1848,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		show_graph(&out, '+', add, add_c, reset);
 		show_graph(&out, '-', del, del_c, reset);
 		strbuf_addch(&out, '\n');
-		emit_line(options, NULL, NULL, 1, 0, out.buf, out.len);
+		emit_line(options, NULL, NULL, 1, 0, 0, out.buf, out.len);
 		strbuf_reset(&out);
 	}
 
@@ -1853,7 +1870,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		if (i < count)
 			continue;
 		if (!extra_shown)
-			emit_line(options, NULL, NULL, 1, 0,
+			emit_line(options, NULL, NULL, 1, 0, 0,
 				  " ...\n", strlen(" ...\n"));
 		extra_shown = 1;
 	}
@@ -2207,7 +2224,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		fprintf(data->o->file, "%s%s:%d: %s.\n",
 			line_prefix, data->filename, data->lineno, err);
 		free(err);
-		emit_line(data->o, set, reset, 1, 0, line, 1);
+		emit_line(data->o, set, reset, 1, 0, 0, line, 1);
 		ws_check_emit(line + 1, len - 1, data->ws_rule,
 			      data->o->file, set, reset, ws);
 	} else if (line[0] == ' ') {
@@ -2303,9 +2320,9 @@ static void emit_binary_diff_body(struct diff_options *o,
 		line[len++] = '\n';
 		line[len] = '\0';
 
-		emit_line(o, NULL, NULL, 1, 0, line, len);
+		emit_line(o, NULL, NULL, 1, 0, 0, line, len);
 	}
-	emit_line(o, NULL, NULL, 1, 0, "\n", 1);
+	emit_line(o, NULL, NULL, 1, 0, 0, "\n", 1);
 	free(data);
 }
 
@@ -2314,7 +2331,7 @@ static void emit_binary_diff(struct diff_options *o,
 {
 	const char *s = "GIT binary patch\n";
 	const int len = strlen(s);
-	emit_line(o, NULL, NULL, 1, 0, s, len);
+	emit_line(o, NULL, NULL, 1, 0, 0, s, len);
 	emit_binary_diff_body(o, one, two);
 	emit_binary_diff_body(o, two, one);
 }
@@ -2457,7 +2474,7 @@ static void builtin_diff(const char *name_a,
 		if (complete_rewrite &&
 		    (textconv_one || !diff_filespec_is_binary(one)) &&
 		    (textconv_two || !diff_filespec_is_binary(two))) {
-			emit_line(o, NULL, NULL, 0, 0, header.buf, header.len);
+			emit_line(o, NULL, NULL, 0, 0, 0, header.buf, header.len);
 			strbuf_reset(&header);
 			emit_rewrite_diff(name_a, name_b, one, two,
 						textconv_one, textconv_two, o);
@@ -2467,7 +2484,7 @@ static void builtin_diff(const char *name_a,
 	}
 
 	if (o->irreversible_delete && lbl[1][0] == '/') {
-		emit_line(o, NULL, NULL, 0, 0, header.buf, header.len);
+		emit_line(o, NULL, NULL, 0, 0, 0, header.buf, header.len);
 		strbuf_reset(&header);
 		goto free_ab_and_return;
 	} else if (!DIFF_OPT_TST(o, TEXT) &&
@@ -2478,11 +2495,11 @@ static void builtin_diff(const char *name_a,
 		    !DIFF_OPT_TST(o, BINARY)) {
 			if (!oidcmp(&one->oid, &two->oid)) {
 				if (must_show_header)
-					emit_line(o, NULL, NULL, 0, 0,
+					emit_line(o, NULL, NULL, 0, 0, 0,
 						  header.buf, header.len);
 				goto free_ab_and_return;
 			}
-			emit_line(o, NULL, NULL, 0, 0,
+			emit_line(o, NULL, NULL, 0, 0, 0,
 				  header.buf, header.len);
 			emit_line_fmt(o, NULL, NULL, 1,
 				      "Binary files %s and %s differ\n",
@@ -2495,11 +2512,11 @@ static void builtin_diff(const char *name_a,
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size)) {
 			if (must_show_header)
-				emit_line(o, NULL, NULL, 0, 0,
+				emit_line(o, NULL, NULL, 0, 0, 0,
 					  header.buf, header.len);
 			goto free_ab_and_return;
 		}
-		emit_line(o, NULL, NULL, 0, 0,
+		emit_line(o, NULL, NULL, 0, 0, 0,
 			  header.buf, header.len);
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
@@ -2519,7 +2536,7 @@ static void builtin_diff(const char *name_a,
 		const struct userdiff_funcname *pe;
 
 		if (must_show_header) {
-			emit_line(o, NULL, NULL, 0, 0, header.buf, header.len);
+			emit_line(o, NULL, NULL, 0, 0, 0, header.buf, header.len);
 			strbuf_reset(&header);
 		}
 
@@ -2536,6 +2553,7 @@ static void builtin_diff(const char *name_a,
 		ecbdata.label_path = lbl;
 		ecbdata.color_diff = want_color(o->use_color);
 		ecbdata.ws_rule = whitespace_rule(name_b);
+		o->ws_rule = ecbdata.ws_rule;
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
 		ecbdata.opt = o;
@@ -4510,7 +4528,7 @@ static void show_file_mode_name(struct diff_options *opt, const char *newdelete,
 
 	quote_c_style(fs->path, &sb, NULL, 0);
 	strbuf_addch(&sb, '\n');
-	emit_line(opt, NULL, NULL, 1, 0, sb.buf, sb.len);
+	emit_line(opt, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 	strbuf_release(&sb);
 }
 
@@ -4562,7 +4580,7 @@ static void diff_summary(struct diff_options *opt, struct diff_filepair *p)
 			strbuf_addstr(&sb, " rewrite ");
 			quote_c_style(p->two->path, &sb, NULL, 0);
 			strbuf_addf(&sb, " (%d%%)\n", similarity_index(p));
-			emit_line(opt, NULL, NULL, 1, 0, sb.buf, sb.len);
+			emit_line(opt, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 		}
 		show_mode_change(opt, p, !p->score);
 		break;
@@ -4869,10 +4887,10 @@ void diff_flush(struct diff_options *options)
 			term[0] = options->line_termination;
 			term[1] = '\0';
 
-			emit_line(options, NULL, NULL, 1, 0, term, !!term[0]);
+			emit_line(options, NULL, NULL, 1, 0, 0, term, !!term[0]);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
-				emit_line(options, NULL, NULL, 0, 0,
+				emit_line(options, NULL, NULL, 0, 0, 0,
 					  options->stat_sep,
 					  strlen(options->stat_sep));
 			}
diff --git a/diff.h b/diff.h
index b75b0d7283..267acf1980 100644
--- a/diff.h
+++ b/diff.h
@@ -186,12 +186,14 @@ struct diff_options {
 	void *output_prefix_data;
 
 	int diff_path_counter;
+
+	unsigned ws_rule;
 };
 
 void emit_line_fmt(struct diff_options *o, const char *set, const char *reset,
 		   int add_line_prefix, const char *fmt, ...);
 void emit_line(struct diff_options *o, const char *set, const char *reset,
-	       int add_line_prefix, int sign, const char *line, int len);
+	       int add_line_prefix, int markup_ws, int sign, const char *line, int len);
 
 enum color_diff {
 	DIFF_RESET = 0,
diff --git a/submodule.c b/submodule.c
index 5996ebca44..868f913971 100644
--- a/submodule.c
+++ b/submodule.c
@@ -378,9 +378,9 @@ static void print_submodule_summary(struct rev_info *rev,
 		format_commit_message(commit, format, &sb, &ctx);
 		strbuf_addch(&sb, '\n');
 		if (commit->object.flags & SYMMETRIC_LEFT)
-			emit_line(o, del, reset, 1, 0, sb.buf, sb.len);
+			emit_line(o, del, reset, 1, 0, 0, sb.buf, sb.len);
 		else if (add)
-			emit_line(o, add, reset, 1, 0, sb.buf, sb.len);
+			emit_line(o, add, reset, 1, 0, 0, sb.buf, sb.len);
 	}
 	strbuf_release(&sb);
 }
@@ -473,7 +473,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 		strbuf_addf(&sb, " %s\n", message);
 	else
 		strbuf_addf(&sb, "%s:\n", fast_backward ? " (rewind)" : "");
-	emit_line(o, meta, reset, 1, 0,  sb.buf, sb.len);
+	emit_line(o, meta, reset, 1, 0, 0, sb.buf, sb.len);
 
 	strbuf_release(&sb);
 }
@@ -501,7 +501,7 @@ void show_submodule_summary(struct diff_options *o, const char *path,
 	/* Treat revision walker failure the same as missing commits */
 	if (prepare_submodule_summary(&rev, path, left, right, merge_bases)) {
 		const char *error = "(revision walker failed)\n";
-		emit_line(o, NULL, NULL, 1, 0, error, strlen(error));
+		emit_line(o, NULL, NULL, 1, 0, 0, error, strlen(error));
 		goto out;
 	}
 
@@ -570,15 +570,15 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 	prepare_submodule_repo_env(&cp.env_array);
 	if (start_command(&cp)) {
 		const char *error = "(diff failed)\n";
-		emit_line(o, NULL, NULL, 1, 0, error, strlen(error));
+		emit_line(o, NULL, NULL, 1, 0, 0, error, strlen(error));
 	}
 
 	while (strbuf_getwholeline_fd(&sb, cp.out, '\n') != EOF)
-		emit_line(o, NULL, NULL, 1, 0, sb.buf, sb.len);
+		emit_line(o, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 
 	if (finish_command(&cp)) {
 		const char *error = "(diff failed)\n";
-		emit_line(o, NULL, NULL, 1, 0, error, strlen(error));
+		emit_line(o, NULL, NULL, 1, 0, 0, error, strlen(error));
 	}
 
 done:
-- 
2.13.0.18.g7d86cc8ba0

