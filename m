Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 779A6201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757747AbdERTij (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:38:39 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34792 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757710AbdERTiR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:38:17 -0400
Received: by mail-pf0-f172.google.com with SMTP id 9so28529751pfj.1
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F8soGDR+xiwWlXn2V5RxvPzhJzdnPU+SfokHtgLqemQ=;
        b=RnJ4u2+rpFqlkeVvZl2bzz5KiWUuXT6m871FNVT5GPxTNge6pT/cekW7JPAUNEsfN5
         xogTv7xARlyL+xtiO7gVpYJp2JjB3l/zRS/7fj1/g8lNnXV+r2HyPY2bIqvmCyrU79sb
         IEMdW8sQvpinAU2oxPZJ70O4drbnYDovG516/GE0HImaQ56/bzYPaUISIDdmUErbeBGz
         uXMzMzfruu8rA/EeO7w8DnZANYhKmbGSl9B9wzbTgAmopr5SRSrkmfMfo7QDoNZNdLZW
         QVMlSEeZHAYn7vB24gATQ0CbRCgRVv8daRJ45HtvGMHU6Sot1AWTkBVbmjkz283lbmGL
         56qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F8soGDR+xiwWlXn2V5RxvPzhJzdnPU+SfokHtgLqemQ=;
        b=etF3NDv4KlkpxxLvtKzeVm2IeDJAWNwKU+sKvjKuooWn/2fhYudY/bIp9Nb8dp6NcG
         XcI+5NEZBx1C56uzassYCBOLYpSaIK/95q6rcKRhlDbxEi8jKUCAGiQVT3ubkXlYaPNT
         yPeF2mPD65Fj/cbksTaQktV33VFu9/a9FmgqOFiO8UIuRtRuv83OQsr6hlxqQGvZlF9H
         pv8VgDZ4p0enZCelBMxu5XR9qOGZN7u/9TyLzpqMeuX+WV7q8JIHk6qehptAL1uDQhyd
         WN+UJbrBkaNrKUPC2F1bInd7qvpN1jnJb2x0WObcTFOWw5uB2aiKAwcaYjxePtKgliDu
         37ZQ==
X-Gm-Message-State: AODbwcCg/+xc2GRD0B9QZhY2J6ThoSSa9/mbkA1Z45wDXWgxUngP4uL5
        vvNtSKOhObcC9lLa
X-Received: by 10.99.36.199 with SMTP id k190mr6030675pgk.83.1495136296259;
        Thu, 18 May 2017 12:38:16 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7013:588c:5765:703d])
        by smtp.gmail.com with ESMTPSA id c12sm9211027pgn.21.2017.05.18.12.38.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:38:15 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: [PATCHv3 18/20] diff.c: emit_line includes whitespace highlighting
Date:   Thu, 18 May 2017 12:37:44 -0700
Message-Id: <20170518193746.486-19-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170518193746.486-1-sbeller@google.com>
References: <20170517025857.32320-1-sbeller@google.com>
 <20170518193746.486-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently any whitespace highlighting happens outside the emit_line
function. Teach the highlighting to emit_line, triggered by a new
parameter.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 106 ++++++++++++++++++++++++++++++++++++++---------------------------
 diff.h |   2 ++
 2 files changed, 64 insertions(+), 44 deletions(-)

diff --git a/diff.c b/diff.c
index 0945802ebf..50d91643b6 100644
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
@@ -558,14 +576,14 @@ void emit_line_fmt(struct diff_options *o,
 	strbuf_vaddf(&sb, fmt, ap);
 	va_end(ap);
 
-	emit_line(o, set, reset, add_line_prefix, 0, sb.buf, sb.len);
+	emit_line(o, set, reset, add_line_prefix, 0, 0, sb.buf, sb.len);
 	strbuf_release(&sb);
 }
 
 void diff_emit_line(struct diff_options *o, const char *set, const char *reset,
 		    const char *line, int len)
 {
-	emit_line(o, set, reset, 1, 0, line, len);
+	emit_line(o, set, reset, 1, 0, 0, line, len);
 }
 
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
@@ -596,16 +614,15 @@ static void emit_line_checked(const char *reset,
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
@@ -652,7 +669,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	if (len < 10 ||
 	    memcmp(line, atat, 2) ||
 	    !(ep = memmem(line + 2, len - 2, atat, 2))) {
-		emit_line(ecbdata->opt, context, reset, 1, 0, line, len);
+		emit_line(ecbdata->opt, context, reset, 1, 0, 0, line, len);
 		return;
 	}
 	ep += 2; /* skip over @@ */
@@ -688,7 +705,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	strbuf_add(&msgbuf, line + len, org_len - len);
 	strbuf_complete_line(&msgbuf);
 
-	emit_line(ecbdata->opt, "", "", 1, 0, msgbuf.buf, msgbuf.len);
+	emit_line(ecbdata->opt, "", "", 1, 0, 0, msgbuf.buf, msgbuf.len);
 	strbuf_release(&msgbuf);
 }
 
@@ -759,7 +776,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		static const char *nneof = "\\ No newline at end of file\n";
 		const char *context = diff_get_color(ecb->color_diff,
 						     DIFF_CONTEXT);
-		emit_line(ecb->opt, context, reset, 1, 0,
+		emit_line(ecb->opt, context, reset, 1, 0, 0,
 			    nneof, strlen(nneof));
 		strbuf_release(&sb);
 	}
@@ -835,7 +852,7 @@ static void emit_rewrite_diff(const char *name_a,
 	strbuf_addstr(&out, " +");
 	add_line_count(&out, lc_b);
 	strbuf_addstr(&out, " @@\n");
-	emit_line(o, fraginfo, reset, 1, 0, out.buf, out.len);
+	emit_line(o, fraginfo, reset, 1, 0, 0, out.buf, out.len);
 	strbuf_release(&out);
 
 	if (lc_a && !o->irreversible_delete)
@@ -908,7 +925,7 @@ static int fn_out_diff_words_write_helper(struct diff_options *o,
 	while (count) {
 		char *p = memchr(buf, '\n', count);
 		if (print)
-			emit_line(o, NULL, NULL, 1, 0, "", 0);
+			emit_line(o, NULL, NULL, 1, 0, 0, "", 0);
 
 		if (p != buf) {
 			const char *reset = st_el->color && *st_el->color ?
@@ -917,14 +934,14 @@ static int fn_out_diff_words_write_helper(struct diff_options *o,
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
@@ -1139,7 +1156,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	if (diff_words->current_plus != diff_words->plus.text.ptr +
 			diff_words->plus.text.size) {
 		if (color_words_output_graph_prefix(diff_words))
-			emit_line(diff_words->opt, NULL, NULL, 1, 0, "", 0);
+			emit_line(diff_words->opt, NULL, NULL, 1, 0, 0, "", 0);
 		fn_out_diff_words_write_helper(diff_words->opt,
 			&style->ctx, style->newline,
 			diff_words->plus.text.ptr + diff_words->plus.text.size
@@ -1298,7 +1315,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	o->found_changes = 1;
 
 	if (ecbdata->header) {
-		emit_line(o, NULL, NULL, 0, 0,
+		emit_line(o, NULL, NULL, 0, 0, 0,
 			  ecbdata->header->buf, ecbdata->header->len);
 		strbuf_release(ecbdata->header);
 		ecbdata->header = NULL;
@@ -1351,8 +1368,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
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
@@ -1363,7 +1380,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			      line++;
 			      len--;
 			}
-			emit_line(o, context, reset, 1, 0, line, len);
+			emit_line(o, context, reset, 1, 0, 0, line, len);
 		}
 		return;
 	}
@@ -1386,7 +1403,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		/* incomplete line at the end */
 		ecbdata->lno_in_preimage++;
 		emit_line(o, diff_get_color(ecbdata->color_diff, DIFF_CONTEXT),
-			  reset, 1, 0, line, len);
+			  reset, 1, 0, 0, line, len);
 		break;
 	}
 }
@@ -1575,7 +1592,7 @@ void print_stat_summary_0(struct diff_options *options, int files,
 	if (!files) {
 		assert(insertions == 0 && deletions == 0);
 		strbuf_addstr(&sb, " 0 files changed");
-		emit_line(options, NULL, NULL, 1, 0, sb.buf, sb.len);
+		emit_line(options, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 		return;
 	}
 
@@ -1603,7 +1620,7 @@ void print_stat_summary_0(struct diff_options *options, int files,
 			    deletions);
 	}
 	strbuf_addch(&sb, '\n');
-	emit_line(options, NULL, NULL, 1, 0, sb.buf, sb.len);
+	emit_line(options, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 	strbuf_release(&sb);
 }
 
@@ -1787,7 +1804,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			strbuf_addf(&out, " %*s", number_width, "Bin");
 			if (!added && !deleted) {
 				strbuf_addch(&out, '\n');
-				emit_line(options, NULL, NULL, 1, 0, out.buf, out.len);
+				emit_line(options, NULL, NULL, 1, 0, 0, out.buf, out.len);
 				strbuf_reset(&out);
 				continue;
 			}
@@ -1797,14 +1814,14 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
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
@@ -1835,7 +1852,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		show_graph(&out, '+', add, add_c, reset);
 		show_graph(&out, '-', del, del_c, reset);
 		strbuf_addch(&out, '\n');
-		emit_line(options, NULL, NULL, 1, 0, out.buf, out.len);
+		emit_line(options, NULL, NULL, 1, 0, 0, out.buf, out.len);
 		strbuf_reset(&out);
 	}
 
@@ -1857,7 +1874,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		if (i < count)
 			continue;
 		if (!extra_shown)
-			emit_line(options, NULL, NULL, 1, 0,
+			emit_line(options, NULL, NULL, 1, 0, 0,
 				  " ...\n", strlen(" ...\n"));
 		extra_shown = 1;
 	}
@@ -2211,7 +2228,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		fprintf(data->o->file, "%s%s:%d: %s.\n",
 			line_prefix, data->filename, data->lineno, err);
 		free(err);
-		emit_line(data->o, set, reset, 1, 0, line, 1);
+		emit_line(data->o, set, reset, 1, 0, 0, line, 1);
 		ws_check_emit(line + 1, len - 1, data->ws_rule,
 			      data->o->file, set, reset, ws);
 	} else if (line[0] == ' ') {
@@ -2307,9 +2324,9 @@ static void emit_binary_diff_body(struct diff_options *o,
 		line[len++] = '\n';
 		line[len] = '\0';
 
-		emit_line(o, NULL, NULL, 1, 0, line, len);
+		emit_line(o, NULL, NULL, 1, 0, 0, line, len);
 	}
-	emit_line(o, NULL, NULL, 1, 0, "\n", 1);
+	emit_line(o, NULL, NULL, 1, 0, 0, "\n", 1);
 	free(data);
 }
 
@@ -2318,7 +2335,7 @@ static void emit_binary_diff(struct diff_options *o,
 {
 	const char *s = "GIT binary patch\n";
 	const int len = strlen(s);
-	emit_line(o, NULL, NULL, 1, 0, s, len);
+	emit_line(o, NULL, NULL, 1, 0, 0, s, len);
 	emit_binary_diff_body(o, one, two);
 	emit_binary_diff_body(o, two, one);
 }
@@ -2461,7 +2478,7 @@ static void builtin_diff(const char *name_a,
 		if (complete_rewrite &&
 		    (textconv_one || !diff_filespec_is_binary(one)) &&
 		    (textconv_two || !diff_filespec_is_binary(two))) {
-			emit_line(o, NULL, NULL, 0, 0, header.buf, header.len);
+			emit_line(o, NULL, NULL, 0, 0, 0, header.buf, header.len);
 			strbuf_reset(&header);
 			emit_rewrite_diff(name_a, name_b, one, two,
 						textconv_one, textconv_two, o);
@@ -2471,7 +2488,7 @@ static void builtin_diff(const char *name_a,
 	}
 
 	if (o->irreversible_delete && lbl[1][0] == '/') {
-		emit_line(o, NULL, NULL, 0, 0, header.buf, header.len);
+		emit_line(o, NULL, NULL, 0, 0, 0, header.buf, header.len);
 		strbuf_reset(&header);
 		goto free_ab_and_return;
 	} else if (!DIFF_OPT_TST(o, TEXT) &&
@@ -2482,11 +2499,11 @@ static void builtin_diff(const char *name_a,
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
@@ -2499,11 +2516,11 @@ static void builtin_diff(const char *name_a,
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
@@ -2523,7 +2540,7 @@ static void builtin_diff(const char *name_a,
 		const struct userdiff_funcname *pe;
 
 		if (must_show_header) {
-			emit_line(o, NULL, NULL, 0, 0, header.buf, header.len);
+			emit_line(o, NULL, NULL, 0, 0, 0, header.buf, header.len);
 			strbuf_reset(&header);
 		}
 
@@ -2540,6 +2557,7 @@ static void builtin_diff(const char *name_a,
 		ecbdata.label_path = lbl;
 		ecbdata.color_diff = want_color(o->use_color);
 		ecbdata.ws_rule = whitespace_rule(name_b);
+		o->ws_rule = ecbdata.ws_rule;
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
 		ecbdata.opt = o;
@@ -4514,7 +4532,7 @@ static void show_file_mode_name(struct diff_options *opt, const char *newdelete,
 
 	quote_c_style(fs->path, &sb, NULL, 0);
 	strbuf_addch(&sb, '\n');
-	emit_line(opt, NULL, NULL, 1, 0, sb.buf, sb.len);
+	emit_line(opt, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 	strbuf_release(&sb);
 }
 
@@ -4566,7 +4584,7 @@ static void diff_summary(struct diff_options *opt, struct diff_filepair *p)
 			strbuf_addstr(&sb, " rewrite ");
 			quote_c_style(p->two->path, &sb, NULL, 0);
 			strbuf_addf(&sb, " (%d%%)\n", similarity_index(p));
-			emit_line(opt, NULL, NULL, 1, 0, sb.buf, sb.len);
+			emit_line(opt, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
 		}
 		show_mode_change(opt, p, !p->score);
 		break;
@@ -4873,10 +4891,10 @@ void diff_flush(struct diff_options *options)
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
index 56d8dd036e..85948ed65a 100644
--- a/diff.h
+++ b/diff.h
@@ -186,6 +186,8 @@ struct diff_options {
 	void *output_prefix_data;
 
 	int diff_path_counter;
+
+	unsigned ws_rule;
 };
 
 void diff_emit_line(struct diff_options *o, const char *set, const char *reset,
-- 
2.13.0.18.g7d86cc8ba0

