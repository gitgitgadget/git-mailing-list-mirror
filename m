Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B32F208A3
	for <e@80x24.org>; Fri, 23 Jun 2017 01:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754133AbdFWBaC (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:30:02 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35758 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753557AbdFWBaB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:30:01 -0400
Received: by mail-pf0-f178.google.com with SMTP id c73so16591362pfk.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=STSFo0JKwmporICUvEuYi24QQs0NT2WrkdnVWtm5hEw=;
        b=RwQPG/ITkrMtoLKz5HWx2pKi4ePhKfAz1CrPXX98EBK0OlPllPmH3XpmbMoG93OwDq
         59nnmXTN8Ze9GRvomuPWuJromRjYL98vIR375hhj7bHX37driPzq6Ua8E6XF0SUm9wiB
         dHoDm36VfKzUzBsexnHUcBmGLQBClW3hMBt5uq7BhLJ0+LWFrpri0O8VU0NdZ7YJmnzh
         3PBHOg7x1k0gWgIR/EE2anuL125HcQtecnN91KJ2IUsY6A/6UWAu1lzbIKyz0BG7ZZyy
         /NOYgaMavrpZMXqZmfWTv6C8iH3GE4W8xNRR+58MbGnHJjPLPBlYSnmM6WKkw3Z3udvv
         QHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=STSFo0JKwmporICUvEuYi24QQs0NT2WrkdnVWtm5hEw=;
        b=Jskz1vukfve4qGvgOjKBLYbXKD0amApJ9gIOoNwxbk+s0409SslLt9nfE7cGPjGlcy
         WfgOFMe3k0PitdaxExT7eanehUuEgsyiNADRJToHU+otdcbUARNEO8xQPYPKFFCCIheP
         eVAETyvK26dztyRFnK0pnI2BeLWU8NpZghqjokc5W/lF8kTpJFT58HKPEPNGBsE1h8dI
         +fKLz0fxFXuzOVZPXiyEEAXmg5yfpqB6jgbCCi1Q+Dn1iC6V0Fh4GON+BzHbQiXj7ukW
         RBSkuPevYZ8vTu+tSLDBY8Rze8O/fn6U6CIiiZyVyv6oQ0ANKekNqXM81YrOR/htLPwl
         Xcxw==
X-Gm-Message-State: AKS2vOz/i02ONpX/VEoC33Py1GCiiPRdfl0DiuHCTwflKg3qeGFfZ4w7
        dR5GZHsObaHhGqwO
X-Received: by 10.84.143.162 with SMTP id 31mr5987181plz.277.1498181399786;
        Thu, 22 Jun 2017 18:29:59 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id 197sm5894724pga.58.2017.06.22.18.29.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:59 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 24/25] diff.c: add dimming to moved line detection
Date:   Thu, 22 Jun 2017 18:29:18 -0700
Message-Id: <20170623012919.28693-25-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any lines inside a moved block of code are not interesting. Boundaries
of blocks are only interesting if they are next to another block of moved
code.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 color.h                    |   2 +
 diff.c                     | 139 ++++++++++++++++++++++++++++++++++++++++-----
 diff.h                     |   9 ++-
 t/t4015-diff-whitespace.sh | 124 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 259 insertions(+), 15 deletions(-)

diff --git a/color.h b/color.h
index 90627650fc..fd2b688dfb 100644
--- a/color.h
+++ b/color.h
@@ -42,6 +42,8 @@ struct strbuf;
 #define GIT_COLOR_BG_BLUE	"\033[44m"
 #define GIT_COLOR_BG_MAGENTA	"\033[45m"
 #define GIT_COLOR_BG_CYAN	"\033[46m"
+#define GIT_COLOR_FAINT		"\033[2m"
+#define GIT_COLOR_FAINT_ITALIC	"\033[2;3m"
 
 /* A special value meaning "no color selected" */
 #define GIT_COLOR_NIL "NIL"
diff --git a/diff.c b/diff.c
index 0eb744514f..82ace48c38 100644
--- a/diff.c
+++ b/diff.c
@@ -57,10 +57,14 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_YELLOW,	/* COMMIT */
 	GIT_COLOR_BG_RED,	/* WHITESPACE */
 	GIT_COLOR_NORMAL,	/* FUNCINFO */
-	GIT_COLOR_MAGENTA,	/* OLD_MOVED */
-	GIT_COLOR_BLUE,		/* OLD_MOVED ALTERNATIVE */
-	GIT_COLOR_CYAN,		/* NEW_MOVED */
-	GIT_COLOR_YELLOW,	/* NEW_MOVED ALTERNATIVE */
+	GIT_COLOR_BOLD_MAGENTA,	/* OLD_MOVED */
+	GIT_COLOR_BOLD_BLUE,	/* OLD_MOVED ALTERNATIVE */
+	GIT_COLOR_FAINT,	/* OLD_MOVED_DIM */
+	GIT_COLOR_FAINT_ITALIC,	/* OLD_MOVED_ALTERNATIVE_DIM */
+	GIT_COLOR_BOLD_CYAN,	/* NEW_MOVED */
+	GIT_COLOR_BOLD_YELLOW,	/* NEW_MOVED ALTERNATIVE */
+	GIT_COLOR_FAINT,	/* NEW_MOVED_DIM */
+	GIT_COLOR_FAINT_ITALIC,	/* NEW_MOVED_ALTERNATIVE_DIM */
 };
 
 static NORETURN void die_want_option(const char *option_name)
@@ -90,10 +94,18 @@ static int parse_diff_color_slot(const char *var)
 		return DIFF_FILE_OLD_MOVED;
 	if (!strcasecmp(var, "oldmovedalternative"))
 		return DIFF_FILE_OLD_MOVED_ALT;
+	if (!strcasecmp(var, "oldmoveddimmed"))
+		return DIFF_FILE_OLD_MOVED_DIM;
+	if (!strcasecmp(var, "oldmovedalternativedimmed"))
+		return DIFF_FILE_OLD_MOVED_ALT_DIM;
 	if (!strcasecmp(var, "newmoved"))
 		return DIFF_FILE_NEW_MOVED;
 	if (!strcasecmp(var, "newmovedalternative"))
 		return DIFF_FILE_NEW_MOVED_ALT;
+	if (!strcasecmp(var, "newmoveddimmed"))
+		return DIFF_FILE_NEW_MOVED_DIM;
+	if (!strcasecmp(var, "newmovedalternativedimmed"))
+		return DIFF_FILE_NEW_MOVED_ALT_DIM;
 	return -1;
 }
 
@@ -250,6 +262,8 @@ static int parse_color_moved(const char *arg)
 		return COLOR_MOVED_PLAIN;
 	else if (!strcmp(arg, "zebra"))
 		return COLOR_MOVED_ZEBRA;
+	else if (!strcmp(arg, "dimmed_zebra"))
+		return COLOR_MOVED_ZEBRA_DIM;
 	else
 		return -1;
 }
@@ -637,6 +651,7 @@ enum diff_symbol {
 #define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF	(1<<16)
 #define DIFF_SYMBOL_MOVED_LINE			(1<<17)
 #define DIFF_SYMBOL_MOVED_LINE_ALT		(1<<18)
+#define DIFF_SYMBOL_MOVED_LINE_UNINTERESTING	(1<<19)
 #define DIFF_SYMBOL_CONTENT_WS_MASK (WSEH_NEW | WSEH_OLD | WSEH_CONTEXT | WS_RULE_MASK)
 
 /*
@@ -890,6 +905,67 @@ static void mark_color_as_moved(struct diff_options *o,
 	free(pmb);
 }
 
+#define DIFF_SYMBOL_MOVED_LINE_ZEBRA_MASK \
+  (DIFF_SYMBOL_MOVED_LINE | DIFF_SYMBOL_MOVED_LINE_ALT)
+static void dim_moved_lines(struct diff_options *o)
+{
+	int n;
+	for (n = 0; n < o->emitted_symbols->nr; n++) {
+		struct emitted_diff_symbol *prev = (n != 0) ?
+				&o->emitted_symbols->buf[n - 1] : NULL;
+		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
+		struct emitted_diff_symbol *next =
+				(n < o->emitted_symbols->nr - 1) ?
+				&o->emitted_symbols->buf[n + 1] : NULL;
+
+		/* Not a plus or minus line? */
+		if (l->s != DIFF_SYMBOL_PLUS && l->s != DIFF_SYMBOL_MINUS)
+			continue;
+
+		/* Not a moved line? */
+		if (!(l->flags & DIFF_SYMBOL_MOVED_LINE))
+			continue;
+
+		/*
+		 * If prev or next are not a plus or minus line,
+		 * pretend they don't exist
+		 */
+		if (prev && prev->s != DIFF_SYMBOL_PLUS &&
+			    prev->s != DIFF_SYMBOL_MINUS)
+			prev = NULL;
+		if (next && next->s != DIFF_SYMBOL_PLUS &&
+			    next->s != DIFF_SYMBOL_MINUS)
+			next = NULL;
+
+		/* Inside a block? */
+		if ((prev &&
+		    (prev->flags & DIFF_SYMBOL_MOVED_LINE_ZEBRA_MASK) ==
+		    (l->flags & DIFF_SYMBOL_MOVED_LINE_ZEBRA_MASK)) &&
+		    (next &&
+		    (next->flags & DIFF_SYMBOL_MOVED_LINE_ZEBRA_MASK) ==
+		    (l->flags & DIFF_SYMBOL_MOVED_LINE_ZEBRA_MASK))) {
+			l->flags |= DIFF_SYMBOL_MOVED_LINE_UNINTERESTING;
+			continue;
+		}
+
+		/* Check if we are at an interesting bound: */
+		if (prev && (prev->flags & DIFF_SYMBOL_MOVED_LINE) &&
+		    (prev->flags & DIFF_SYMBOL_MOVED_LINE_ALT) !=
+		       (l->flags & DIFF_SYMBOL_MOVED_LINE_ALT))
+			continue;
+		if (next && (next->flags & DIFF_SYMBOL_MOVED_LINE) &&
+		    (next->flags & DIFF_SYMBOL_MOVED_LINE_ALT) !=
+		       (l->flags & DIFF_SYMBOL_MOVED_LINE_ALT))
+			continue;
+
+		/*
+		 * The boundary to prev and next are not interesting,
+		 * so this line is not interesting as a whole
+		 */
+		l->flags |= DIFF_SYMBOL_MOVED_LINE_UNINTERESTING;
+	}
+}
+
 static void emit_line_ws_markup(struct diff_options *o,
 				const char *set, const char *reset,
 				const char *line, int len, char sign,
@@ -964,24 +1040,56 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
-		if (flags & DIFF_SYMBOL_MOVED_LINE_ALT)
+		switch (flags & (DIFF_SYMBOL_MOVED_LINE |
+				 DIFF_SYMBOL_MOVED_LINE_ALT |
+				 DIFF_SYMBOL_MOVED_LINE_UNINTERESTING)) {
+		case DIFF_SYMBOL_MOVED_LINE |
+		     DIFF_SYMBOL_MOVED_LINE_ALT |
+		     DIFF_SYMBOL_MOVED_LINE_UNINTERESTING:
+			set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED_ALT_DIM);
+			break;
+		case DIFF_SYMBOL_MOVED_LINE |
+		     DIFF_SYMBOL_MOVED_LINE_ALT:
 			set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED_ALT);
-		else if (flags & DIFF_SYMBOL_MOVED_LINE)
+			break;
+		case DIFF_SYMBOL_MOVED_LINE |
+		     DIFF_SYMBOL_MOVED_LINE_UNINTERESTING:
+			set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED_DIM);
+			break;
+		case DIFF_SYMBOL_MOVED_LINE:
 			set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED);
-		else
+			break;
+		default:
 			set = diff_get_color_opt(o, DIFF_FILE_NEW);
+		}
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		emit_line_ws_markup(o, set, reset, line, len, '+',
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
 	case DIFF_SYMBOL_MINUS:
-		if (flags & DIFF_SYMBOL_MOVED_LINE_ALT)
+		switch (flags & (DIFF_SYMBOL_MOVED_LINE |
+				 DIFF_SYMBOL_MOVED_LINE_ALT |
+				 DIFF_SYMBOL_MOVED_LINE_UNINTERESTING)) {
+		case DIFF_SYMBOL_MOVED_LINE |
+		     DIFF_SYMBOL_MOVED_LINE_ALT |
+		     DIFF_SYMBOL_MOVED_LINE_UNINTERESTING:
+			set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED_ALT_DIM);
+			break;
+		case DIFF_SYMBOL_MOVED_LINE |
+		     DIFF_SYMBOL_MOVED_LINE_ALT:
 			set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED_ALT);
-		else if (flags & DIFF_SYMBOL_MOVED_LINE)
+			break;
+		case DIFF_SYMBOL_MOVED_LINE |
+		     DIFF_SYMBOL_MOVED_LINE_UNINTERESTING:
+			set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED_DIM);
+			break;
+		case DIFF_SYMBOL_MOVED_LINE:
 			set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED);
-		else
+			break;
+		default:
 			set = diff_get_color_opt(o, DIFF_FILE_OLD);
+		}
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		emit_line_ws_markup(o, set, reset, line, len, '-',
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
@@ -4534,9 +4642,12 @@ int diff_opt_parse(struct diff_options *options,
 	}
 	else if (!strcmp(arg, "--no-color"))
 		options->use_color = 0;
-	else if (!strcmp(arg, "--color-moved"))
-		options->color_moved = COLOR_MOVED_ZEBRA;
-	else if (!strcmp(arg, "--no-color-moved"))
+	else if (!strcmp(arg, "--color-moved")) {
+		if (diff_color_moved_default)
+			options->color_moved = diff_color_moved_default;
+		if (options->color_moved == COLOR_MOVED_NO)
+			options->color_moved = COLOR_MOVED_ZEBRA_DIM;
+	} else if (!strcmp(arg, "--no-color-moved"))
 		options->color_moved = COLOR_MOVED_NO;
 	else if (skip_prefix(arg, "--color-moved=", &arg)) {
 		int cm = parse_color_moved(arg);
@@ -5381,6 +5492,8 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 
 			add_lines_to_move_detection(o, &add_lines, &del_lines);
 			mark_color_as_moved(o, &add_lines, &del_lines);
+			if (o->color_moved == COLOR_MOVED_ZEBRA_DIM)
+				dim_moved_lines(o);
 
 			hashmap_free(&add_lines, 0);
 			hashmap_free(&del_lines, 0);
diff --git a/diff.h b/diff.h
index 1aae8738ca..98abd75521 100644
--- a/diff.h
+++ b/diff.h
@@ -192,6 +192,7 @@ struct diff_options {
 		COLOR_MOVED_NO = 0,
 		COLOR_MOVED_PLAIN = 1,
 		COLOR_MOVED_ZEBRA = 2,
+		COLOR_MOVED_ZEBRA_DIM = 3,
 	} color_moved;
 };
 
@@ -216,8 +217,12 @@ enum color_diff {
 	DIFF_FUNCINFO = 8,
 	DIFF_FILE_OLD_MOVED = 9,
 	DIFF_FILE_OLD_MOVED_ALT = 10,
-	DIFF_FILE_NEW_MOVED = 11,
-	DIFF_FILE_NEW_MOVED_ALT = 12
+	DIFF_FILE_OLD_MOVED_DIM = 11,
+	DIFF_FILE_OLD_MOVED_ALT_DIM = 12,
+	DIFF_FILE_NEW_MOVED = 13,
+	DIFF_FILE_NEW_MOVED_ALT = 14,
+	DIFF_FILE_NEW_MOVED_DIM = 15,
+	DIFF_FILE_NEW_MOVED_ALT_DIM = 16
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 1ca16435d6..ae8c686f3c 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1179,6 +1179,130 @@ test_expect_success 'plain moved code, inside file' '
 	test_cmp expected actual
 '
 
+test_expect_success 'detect permutations inside moved code -- dimmed_zebra' '
+	git reset --hard &&
+	cat <<-\EOF >lines.txt &&
+		line 1
+		line 2
+		line 3
+		line 4
+		line 5
+		line 6
+		line 7
+		line 8
+		line 9
+		line 10
+		line 11
+		line 12
+		line 13
+		line 14
+		line 15
+		line 16
+	EOF
+	git add lines.txt &&
+	git commit -m "add poetry" &&
+	cat <<-\EOF >lines.txt &&
+		line 4
+		line 5
+		line 6
+		line 7
+		line 8
+		line 9
+		line 1
+		line 2
+		line 3
+		line 14
+		line 15
+		line 16
+		line 10
+		line 11
+		line 12
+		line 13
+	EOF
+	test_config color.diff.oldMoved "magenta" &&
+	test_config color.diff.newMoved "cyan" &&
+	test_config color.diff.oldMovedAlternative "blue" &&
+	test_config color.diff.newMovedAlternative "yellow" &&
+	test_config color.diff.oldMovedDimmed "normal magenta" &&
+	test_config color.diff.newMovedDimmed "normal cyan" &&
+	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
+	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
+	git diff HEAD --no-renames --color-moved=dimmed_zebra| test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
+	<BOLD>index 47ea9c3..ba96a38 100644<RESET>
+	<BOLD>--- a/lines.txt<RESET>
+	<BOLD>+++ b/lines.txt<RESET>
+	<CYAN>@@ -1,16 +1,16 @@<RESET>
+	<BMAGENTA>-line 1<RESET>
+	<BMAGENTA>-line 2<RESET>
+	<BMAGENTA>-line 3<RESET>
+	 line 4<RESET>
+	 line 5<RESET>
+	 line 6<RESET>
+	 line 7<RESET>
+	 line 8<RESET>
+	 line 9<RESET>
+	<BCYAN>+<RESET><BCYAN>line 1<RESET>
+	<BCYAN>+<RESET><BCYAN>line 2<RESET>
+	<CYAN>+<RESET><CYAN>line 3<RESET>
+	<YELLOW>+<RESET><YELLOW>line 14<RESET>
+	<BYELLOW>+<RESET><BYELLOW>line 15<RESET>
+	<BYELLOW>+<RESET><BYELLOW>line 16<RESET>
+	 line 10<RESET>
+	 line 11<RESET>
+	 line 12<RESET>
+	 line 13<RESET>
+	<BMAGENTA>-line 14<RESET>
+	<BMAGENTA>-line 15<RESET>
+	<BMAGENTA>-line 16<RESET>
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'cmd option assumes configured colored-moved' '
+	test_config color.diff.oldMoved "magenta" &&
+	test_config color.diff.newMoved "cyan" &&
+	test_config color.diff.oldMovedAlternative "blue" &&
+	test_config color.diff.newMovedAlternative "yellow" &&
+	test_config color.diff.oldMovedDimmed "normal magenta" &&
+	test_config color.diff.newMovedDimmed "normal cyan" &&
+	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
+	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
+	test_config diff.colorMoved zebra &&
+	git diff HEAD --no-renames --color-moved| test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
+	<BOLD>index 47ea9c3..ba96a38 100644<RESET>
+	<BOLD>--- a/lines.txt<RESET>
+	<BOLD>+++ b/lines.txt<RESET>
+	<CYAN>@@ -1,16 +1,16 @@<RESET>
+	<MAGENTA>-line 1<RESET>
+	<MAGENTA>-line 2<RESET>
+	<MAGENTA>-line 3<RESET>
+	 line 4<RESET>
+	 line 5<RESET>
+	 line 6<RESET>
+	 line 7<RESET>
+	 line 8<RESET>
+	 line 9<RESET>
+	<CYAN>+<RESET><CYAN>line 1<RESET>
+	<CYAN>+<RESET><CYAN>line 2<RESET>
+	<CYAN>+<RESET><CYAN>line 3<RESET>
+	<YELLOW>+<RESET><YELLOW>line 14<RESET>
+	<YELLOW>+<RESET><YELLOW>line 15<RESET>
+	<YELLOW>+<RESET><YELLOW>line 16<RESET>
+	 line 10<RESET>
+	 line 11<RESET>
+	 line 12<RESET>
+	 line 13<RESET>
+	<MAGENTA>-line 14<RESET>
+	<MAGENTA>-line 15<RESET>
+	<MAGENTA>-line 16<RESET>
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'no effect from --color-moved with --word-diff' '
 	cat <<-\EOF >text.txt &&
 	Lorem Ipsum is simply dummy text of the printing and typesetting industry.
-- 
2.12.2.575.gb14f27f917

