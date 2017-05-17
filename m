Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22C632023D
	for <e@80x24.org>; Wed, 17 May 2017 02:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbdEQC7T (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:59:19 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33843 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752720AbdEQC7N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:59:13 -0400
Received: by mail-pf0-f178.google.com with SMTP id 9so49999790pfj.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pjutrxv8EMne7P/yrCRvUXrQMHOvUF7B5LspvSYqTRY=;
        b=bZnYFNBAss96lkvO6LB4ESPhd9TL/soVxdUjrSDpnGoKwg0DZkTq2ccw+h3dNC/kEd
         yQm4MglOC+V2S/YUV50lHn8UUK1PsZktEO+0kiSmvAqgqt2bNjksY4BAhFzJVQnfzorR
         pR+tFnKd3XuKX4r4mWxjgj/Yd+24MRinvIJj9rD1/NHIR22GqvagRrzYV9oIrqmMqspg
         ABZWzo69KESJgslJDQHcb3F3WQDrPlm/XLJKOuaA6s6lqEl4Vt8s7TetoNNSOKukp/2D
         fQGj+AdLa8ObueLMnmNddblL8rJZHI8mMdc2Buy6rSVi9kIKIQN4xZiIXXe1pE7zXBnr
         yiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pjutrxv8EMne7P/yrCRvUXrQMHOvUF7B5LspvSYqTRY=;
        b=o86nxZ2p+Hbf+4xQf3GHD48QqiE+jycg+YPgGs+LnFEFqefuYBi+R+pUkMTS5eAIVs
         +W9hyoXYj76N4ZW5tx9V9DkEStUyZD/btr2TMnb1kWx75K/UeSMuoTnQ/rQ8kKVKd4EQ
         tMmuqSWWEILsm3mol+Ad+NkDzDiyGDovizZ8ADtUJrK9wieD3HdTdwnyDaQLhpq1AJud
         bvO9A5B5GLCDa3vuCZnzLxlf5dWxYINcuFlU735WSNpvvpT3SnmCbsEHSEYuXxUlAASw
         AKESmcEb1qBYzwL94MLqZDN0EvE/u5xDooIsx7wq6XeDTY8RieTDy63XTkNnUeYwq+Cd
         syyw==
X-Gm-Message-State: AODbwcBkUMoznKa+EkKoTZFVCj+X4ZAjwKiwwQT1YL29M93oCFS1M6C1
        vYZgsghb1qqGMPOI
X-Received: by 10.84.224.70 with SMTP id a6mr1539936plt.38.1494989952711;
        Tue, 16 May 2017 19:59:12 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id t5sm668429pgt.19.2017.05.16.19.59.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:59:11 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 07/20] diff.c: inline emit_line_0 into emit_line
Date:   Tue, 16 May 2017 19:58:44 -0700
Message-Id: <20170517025857.32320-8-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517025857.32320-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170517025857.32320-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The argument list of emit_line_0 is just 2 more arguments that are
hard-coded in emit_line. Eliminate this intermediate function and
rename the remaining function by dropping the '_0'.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/diff.c b/diff.c
index 25735f03d2..3569857818 100644
--- a/diff.c
+++ b/diff.c
@@ -516,8 +516,8 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
-static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
-			int add_line_prefix, int sign, const char *line, int len)
+static void emit_line(struct diff_options *o, const char *set, const char *reset,
+		      int add_line_prefix, int sign, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
 	FILE *file = o->file;
@@ -547,12 +547,6 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 		fputc('\n', file);
 }
 
-static void emit_line(struct diff_options *o, const char *set, const char *reset,
-		      const char *line, int len)
-{
-	emit_line_0(o, set, reset, 1, 0, line, len);
-}
-
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
 {
 	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
@@ -581,13 +575,13 @@ static void emit_line_checked(const char *reset,
 	}
 
 	if (!ws)
-		emit_line_0(ecbdata->opt, set, reset, 1, sign, line, len);
+		emit_line(ecbdata->opt, set, reset, 1, sign, line, len);
 	else if (sign == '+' && new_blank_line_at_eof(ecbdata, line, len))
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(ecbdata->opt, ws, reset, 1, sign, line, len);
+		emit_line(ecbdata->opt, ws, reset, 1, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(ecbdata->opt, set, reset, 1, sign, "", 0);
+		emit_line(ecbdata->opt, set, reset, 1, sign, "", 0);
 		ws_check_emit(line, len, ecbdata->ws_rule,
 			      ecbdata->opt->file, set, reset, ws);
 	}
@@ -637,7 +631,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	if (len < 10 ||
 	    memcmp(line, atat, 2) ||
 	    !(ep = memmem(line + 2, len - 2, atat, 2))) {
-		emit_line(ecbdata->opt, context, reset, line, len);
+		emit_line(ecbdata->opt, context, reset, 1, 0, line, len);
 		return;
 	}
 	ep += 2; /* skip over @@ */
@@ -673,7 +667,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	strbuf_add(&msgbuf, line + len, org_len - len);
 	strbuf_complete_line(&msgbuf);
 
-	emit_line(ecbdata->opt, "", "", msgbuf.buf, msgbuf.len);
+	emit_line(ecbdata->opt, "", "", 1, 0, msgbuf.buf, msgbuf.len);
 	strbuf_release(&msgbuf);
 }
 
@@ -736,8 +730,8 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		const char *context = diff_get_color(ecb->color_diff,
 						     DIFF_CONTEXT);
 		putc('\n', ecb->opt->file);
-		emit_line_0(ecb->opt, context, reset, 1, '\\',
-			    nneof, strlen(nneof));
+		emit_line(ecb->opt, context, reset, 1, '\\',
+			  nneof, strlen(nneof));
 	}
 }
 
@@ -1335,7 +1329,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		}
 		diff_words_flush(ecbdata);
 		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
-			emit_line(o, context, reset, line, len);
+			emit_line(o, context, reset, 1, 0, line, len);
 			fputs("~\n", o->file);
 		} else {
 			/*
@@ -1347,7 +1341,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			      line++;
 			      len--;
 			}
-			emit_line(o, context, reset, line, len);
+			emit_line(o, context, reset, 1, 0, line, len);
 		}
 		return;
 	}
@@ -1370,7 +1364,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		/* incomplete line at the end */
 		ecbdata->lno_in_preimage++;
 		emit_line(o, diff_get_color(ecbdata->color_diff, DIFF_CONTEXT),
-			  reset, line, len);
+			  reset, 1, 0, line, len);
 		break;
 	}
 }
@@ -2182,7 +2176,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		fprintf(data->o->file, "%s%s:%d: %s.\n",
 			line_prefix, data->filename, data->lineno, err);
 		free(err);
-		emit_line(data->o, set, reset, line, 1);
+		emit_line(data->o, set, reset, 1, 0, line, 1);
 		ws_check_emit(line + 1, len - 1, data->ws_rule,
 			      data->o->file, set, reset, ws);
 	} else if (line[0] == ' ') {
@@ -4831,7 +4825,7 @@ void diff_flush(struct diff_options *options)
 			term[0] = options->line_termination;
 			term[1] = '\0';
 
-			emit_line(options, NULL, NULL, term, !!term[0]);
+			emit_line(options, NULL, NULL, 1, 0, term, !!term[0]);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
 				fputs(options->stat_sep, options->file);
-- 
2.13.0.18.g7d86cc8ba0

