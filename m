Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86BA320831
	for <e@80x24.org>; Fri, 23 Jun 2017 01:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754111AbdFWB3z (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:29:55 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35688 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754094AbdFWB3t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:49 -0400
Received: by mail-pf0-f177.google.com with SMTP id c73so16588011pfk.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kggcXNwi2az9L1R81g+S7EjyR5ubPxfO/KHVFgcD/+Y=;
        b=Y5NOfll9wD/p08xZ5Ao/T1GiYTScsDSY8RZ65fPObZWv270Ir2jjn95yaapFtnaf/m
         CjzP2smeJ6Y1x3mbhrwoy3uSHWbZ4qm/ukUC0Zq9fMXyO0+Ax02+yTTP+jmpJhWxBn5E
         V3UVUM18tUViu1VyavGfznMlNXVyxYNfodpz4Lk51lvmptLVEzp1uZPTlZmM8omrOIVm
         pIFodVrFe6SXO7h0XIyzoUdbusiKA4v2DfKO7Rx8CqmuCWwWuzuTuxqP9lEnQLcBxHDJ
         Q1e2oyzfhX5MeYT6LYQc0Fs0dK+XCi7TnKkayenGLO0tzkarqJequGS+hr8vP9u2FXb5
         rk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kggcXNwi2az9L1R81g+S7EjyR5ubPxfO/KHVFgcD/+Y=;
        b=hnIM8pfDeqF/JVoO99XaBju5oOMIrM5bq4VJqf6nYe3Mz4Iq9akPvt2X6t8b3puSVX
         xZ4869jnG72KLrnl2GhRyuKkL1LyswKEWfyyH8n6z0dlZYoZ7wlQeuUGFnKYqeWxaU2i
         PtcyDIYKrFMdzAVphS7w/6zBppv6orSvjiiKAvt22BNDCGhizKQm2tF+JBopD2AnT9MY
         CSEPSs2msYJVQOg4SnwVN/WlWxnhmP/CDgSbP9bolb5s/yXcGUtsSUdyGz9JlVyONy9n
         FxbPgU/6aO2tHcIRC9aJ9Uay6AKY5ZLXovcWhliDsS3Ub7wq1DqqxTCMtHsnfyFsPtzp
         FTyw==
X-Gm-Message-State: AKS2vOzbZONv+ZLrprA6EIiymwmGd2hTeJgsgbx0kHK+so/Zj3Nkviul
        mLB2vAX1cJNYP4JIQG9fhA==
X-Received: by 10.98.155.148 with SMTP id e20mr2779070pfk.149.1498181378335;
        Thu, 22 Jun 2017 18:29:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id z69sm6238789pff.0.2017.06.22.18.29.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 08/25] diff.c: migrate emit_line_checked to use emit_diff_symbol
Date:   Thu, 22 Jun 2017 18:29:02 -0700
Message-Id: <20170623012919.28693-9-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new flags field to emit_diff_symbol, that will be used by
context lines for:
* white space rules that are applicable (The first 12 bits)
  Take a note in cahe.c as well, when this ws rules are extended we have
  to fix the bits in the flags field.
* how the rules are evaluated (actually this double encodes the sign
  of the line, but the code is easier to keep this way, bits 13,14,15)
* if the line a blank line at EOF (bit 16)

The check if new lines need to be marked up as extra lines at the end of
file, is now done unconditionally. That should be ok, as
'new_blank_line_at_eof' has a quick early return.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h |   2 ++
 diff.c  | 116 +++++++++++++++++++++++++++++++++++++++++-----------------------
 diff.h  |   6 ++--
 3 files changed, 80 insertions(+), 44 deletions(-)

diff --git a/cache.h b/cache.h
index e1f0e182ad..d2204bf6d1 100644
--- a/cache.h
+++ b/cache.h
@@ -2168,6 +2168,8 @@ void shift_tree_by(const struct object_id *, const struct object_id *, struct ob
 #define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
 #define WS_TAB_WIDTH_MASK        077
+/* All WS_* -- when extended, adapt diff.c emit_symbol */
+#define WS_RULE_MASK           07777
 extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
 extern unsigned parse_whitespace_rule(const char *);
diff --git a/diff.c b/diff.c
index b78f698cad..e7583efca3 100644
--- a/diff.c
+++ b/diff.c
@@ -560,17 +560,54 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_CONTEXT,
+	DIFF_SYMBOL_PLUS,
+	DIFF_SYMBOL_MINUS,
 	DIFF_SYMBOL_NO_LF_EOF,
 	DIFF_SYMBOL_CONTEXT_FRAGINFO,
 	DIFF_SYMBOL_CONTEXT_MARKER,
 	DIFF_SYMBOL_SEPARATOR
 };
+/*
+ * Flags for content lines:
+ * 0..12 are whitespace rules
+ * 13-15 are WSEH_NEW | WSEH_OLD | WSEH_CONTEXT
+ * 16 is marking if the line is blank at EOF
+ */
+#define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF (1<<16)
+#define DIFF_SYMBOL_CONTENT_WS_MASK (WSEH_NEW | WSEH_OLD | WSEH_CONTEXT | WS_RULE_MASK)
+
+static void emit_line_ws_markup(struct diff_options *o,
+				const char *set, const char *reset,
+				const char *line, int len, char sign,
+				unsigned ws_rule, int blank_at_eof)
+{
+	const char *ws = NULL;
+
+	if (o->ws_error_highlight & ws_rule) {
+		ws = diff_get_color_opt(o, DIFF_WHITESPACE);
+		if (!*ws)
+			ws = NULL;
+	}
+
+	if (!ws)
+		emit_line_0(o, set, reset, sign, line, len);
+	else if (blank_at_eof)
+		/* Blank line at EOF - paint '+' as well */
+		emit_line_0(o, ws, reset, sign, line, len);
+	else {
+		/* Emit just the prefix, then the rest. */
+		emit_line_0(o, set, reset, sign, "", 0);
+		ws_check_emit(line, len, ws_rule,
+			      o->file, set, reset, ws);
+	}
+}
 
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
-			     const char *line, int len)
+			     const char *line, int len, unsigned flags)
 {
 	static const char *nneof = " No newline at end of file\n";
-	const char *context, *reset;
+	const char *context, *reset, *set;
 	switch (s) {
 	case DIFF_SYMBOL_NO_LF_EOF:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
@@ -592,6 +629,25 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			diff_line_prefix(o),
 			o->line_termination);
 		break;
+	case DIFF_SYMBOL_CONTEXT:
+		set = diff_get_color_opt(o, DIFF_CONTEXT);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line_ws_markup(o, set, reset, line, len, ' ',
+				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
+		break;
+	case DIFF_SYMBOL_PLUS:
+		set = diff_get_color_opt(o, DIFF_FILE_NEW);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line_ws_markup(o, set, reset, line, len, '+',
+				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
+				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
+		break;
+	case DIFF_SYMBOL_MINUS:
+		set = diff_get_color_opt(o, DIFF_FILE_OLD);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line_ws_markup(o, set, reset, line, len, '-',
+				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -608,57 +664,31 @@ static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line
 	return ws_blank_line(line, len, ecbdata->ws_rule);
 }
 
-static void emit_line_checked(const char *reset,
-			      struct emit_callback *ecbdata,
-			      const char *line, int len,
-			      enum color_diff color,
-			      unsigned ws_error_highlight,
-			      char sign)
-{
-	const char *set = diff_get_color(ecbdata->color_diff, color);
-	const char *ws = NULL;
-
-	if (ecbdata->opt->ws_error_highlight & ws_error_highlight) {
-		ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
-		if (!*ws)
-			ws = NULL;
-	}
-
-	if (!ws)
-		emit_line_0(ecbdata->opt, set, reset, sign, line, len);
-	else if (sign == '+' && new_blank_line_at_eof(ecbdata, line, len))
-		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(ecbdata->opt, ws, reset, sign, line, len);
-	else {
-		/* Emit just the prefix, then the rest. */
-		emit_line_0(ecbdata->opt, set, reset, sign, "", 0);
-		ws_check_emit(line, len, ecbdata->ws_rule,
-			      ecbdata->opt->file, set, reset, ws);
-	}
-}
-
 static void emit_add_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
-	emit_line_checked(reset, ecbdata, line, len,
-			  DIFF_FILE_NEW, WSEH_NEW, '+');
+	unsigned flags = WSEH_NEW | ecbdata->ws_rule;
+	if (new_blank_line_at_eof(ecbdata, line, len))
+		flags |= DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF;
+
+	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_PLUS, line, len, flags);
 }
 
 static void emit_del_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
-	emit_line_checked(reset, ecbdata, line, len,
-			  DIFF_FILE_OLD, WSEH_OLD, '-');
+	unsigned flags = WSEH_OLD | ecbdata->ws_rule;
+	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_MINUS, line, len, flags);
 }
 
 static void emit_context_line(const char *reset,
 			      struct emit_callback *ecbdata,
 			      const char *line, int len)
 {
-	emit_line_checked(reset, ecbdata, line, len,
-			  DIFF_CONTEXT, WSEH_CONTEXT, ' ');
+	unsigned flags = WSEH_CONTEXT | ecbdata->ws_rule;
+	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_CONTEXT, line, len, flags);
 }
 
 static void emit_hunk_header(struct emit_callback *ecbdata,
@@ -682,7 +712,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	    memcmp(line, atat, 2) ||
 	    !(ep = memmem(line + 2, len - 2, atat, 2))) {
 		emit_diff_symbol(ecbdata->opt,
-				 DIFF_SYMBOL_CONTEXT_MARKER, line, len);
+				 DIFF_SYMBOL_CONTEXT_MARKER, line, len, 0);
 		return;
 	}
 	ep += 2; /* skip over @@ */
@@ -718,7 +748,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	strbuf_add(&msgbuf, line + len, org_len - len);
 	strbuf_complete_line(&msgbuf);
 	emit_diff_symbol(ecbdata->opt,
-			 DIFF_SYMBOL_CONTEXT_FRAGINFO, msgbuf.buf, msgbuf.len);
+			 DIFF_SYMBOL_CONTEXT_FRAGINFO, msgbuf.buf, msgbuf.len, 0);
 	strbuf_release(&msgbuf);
 }
 
@@ -777,7 +807,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		data += len;
 	}
 	if (!endp)
-		emit_diff_symbol(ecb->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0);
+		emit_diff_symbol(ecb->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0, 0);
 }
 
 static void emit_rewrite_diff(const char *name_a,
@@ -4774,6 +4804,10 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 {
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
+
+	if (WSEH_NEW & WS_RULE_MASK)
+		die("BUG: WS rules bit mask overlaps with diff symbol flags");
+
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (check_pair_status(p))
@@ -4866,7 +4900,7 @@ void diff_flush(struct diff_options *options)
 
 	if (output_format & DIFF_FORMAT_PATCH) {
 		if (separator) {
-			emit_diff_symbol(options, DIFF_SYMBOL_SEPARATOR, NULL, 0);
+			emit_diff_symbol(options, DIFF_SYMBOL_SEPARATOR, NULL, 0, 0);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
 				fputs(options->stat_sep, options->file);
diff --git a/diff.h b/diff.h
index 5be1ee77a7..8483ca0991 100644
--- a/diff.h
+++ b/diff.h
@@ -148,9 +148,9 @@ struct diff_options {
 	int abbrev;
 	int ita_invisible_in_index;
 /* white-space error highlighting */
-#define WSEH_NEW 1
-#define WSEH_CONTEXT 2
-#define WSEH_OLD 4
+#define WSEH_NEW (1<<12)
+#define WSEH_CONTEXT (1<<13)
+#define WSEH_OLD (1<<14)
 	unsigned ws_error_highlight;
 	const char *prefix;
 	int prefix_length;
-- 
2.12.2.575.gb14f27f917

