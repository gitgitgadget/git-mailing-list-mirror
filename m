Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E88F4201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932373AbdERTix (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:38:53 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34745 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757500AbdERTiE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:38:04 -0400
Received: by mail-pf0-f177.google.com with SMTP id 9so28527517pfj.1
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pjutrxv8EMne7P/yrCRvUXrQMHOvUF7B5LspvSYqTRY=;
        b=J20pJDXu3obcnb3w38hjqbluf+wKS+NSan7q7nLGwlTl93zcJYhPpK+8lJLO1K767m
         P1ZVLDTdBqZIxnFoTWzrYnh0ovExUK4jC2uUiZTWk0yXe6vXMLnIC11KXp826u35Sy0H
         mnftVMyn1jAJJuPUCnYpwuktt7airRr/YYX4q6Re87EjeI4SXlMQlgVqqBmxy55CFiyL
         8FzcByu7n8tXwWmmJ3kKJ8yZLxMM6oqY6XZ14RC8cl5zS3yBtZ3iNCxYPRXt7XCXGHzR
         slY809iYH9194dCk3AdnLeAE/6iJU0Z1h5myxtLC0i/pZ7bM1CbNWqus7FBAl/VZW1OJ
         XTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pjutrxv8EMne7P/yrCRvUXrQMHOvUF7B5LspvSYqTRY=;
        b=j/Xr0SrICtKdlNRprK8V4Fz5ZRYnBjjcXh+jdSuQgKVlMlKwnd2vXICogUlmmnB51H
         XNwViZsqkbOkIYjWnrt9EG4lu0MH9lNWZ53M51Yt2JF+A0BvFJ0Y0ZcjVJnwoTcGSOsh
         kec23AENNY8XqGFBJUBpZO1Hh5P3AQ3NjCvkBHIZiTv3YObNkPeTJIWg6LOEwGm1BKYT
         XWj1ue0o40tLNgc80/0ZhOb2QxbVYFKcSDzHLMyE6/2teGx//PLO99n/GuWoHLN63HZv
         VohhjNWGNUneM/q/+cTmBB3nep9aar9Odof4+Md/2U0qQEFjkJInWkPyWNRoYyvATc1E
         E1Sw==
X-Gm-Message-State: AODbwcArjUxnctb8n3ehX47vP5BL3gNv1by58JQg8VMb9zXtL6cCe0Iw
        Hf/U3WxVodiG+4At
X-Received: by 10.84.149.102 with SMTP id b35mr6768601plh.151.1495136283079;
        Thu, 18 May 2017 12:38:03 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7013:588c:5765:703d])
        by smtp.gmail.com with ESMTPSA id i68sm13319470pfi.72.2017.05.18.12.38.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:38:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: [PATCHv3 07/20] diff.c: inline emit_line_0 into emit_line
Date:   Thu, 18 May 2017 12:37:33 -0700
Message-Id: <20170518193746.486-8-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170518193746.486-1-sbeller@google.com>
References: <20170517025857.32320-1-sbeller@google.com>
 <20170518193746.486-1-sbeller@google.com>
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

