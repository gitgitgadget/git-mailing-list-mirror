Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79ADE201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753108AbdF3Ux6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:53:58 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35395 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753138AbdF3Uxu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:50 -0400
Received: by mail-pf0-f170.google.com with SMTP id c73so72475181pfk.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uCNgFyA1Lpzyv+3ifX0T2p+A+d072cnX5Ts0DG2v680=;
        b=qoyLR3fHRgRTgUqAYb4Cgk+vXDZELUVrl690moxV7nEVjOz5DCI6TlJaH+ja9CiDqo
         1yJE0V5mKeBJCdzumT1W5/UgXtR3b+yk4g0ch2zpA7jehHcuQjjknKptrHPqFobHbuDL
         YSUjHG2aGiGnYPYvJndkVh8ge/jz5yLgrXXYiHLPXn9uSmRYiCmMZVn+mRpmJraPt6/H
         3pr9z07MC5XCUsp/cKsCQtKDpvVYCv/ewTZlyqtPcfd0/aRgwI4WuiRD7JYx1A2kRtFX
         z2d4UQ9a6eZMu5l0Prmx4epZ1IhjLF+tHS0lDW7+M5/hDgkooN5c6v5ZfIpfRyZuqEFy
         AcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uCNgFyA1Lpzyv+3ifX0T2p+A+d072cnX5Ts0DG2v680=;
        b=BhjVzuY7x/hM2ifFNaykCc440QZIQB6ounRTS9ikC691vS9y6JLGs5SmbkXay2Ugao
         m9QHPfq3s9F8SZNiZO1q/XG2YWMlthd/vOeDGZOEgdWepwfPj1iKWSUh5C6mxYEoZc30
         NDHaseCE6RdS8RmPtSnXKJw58mNRf1EkFndYIoIArqIlX+AboWPY9x0xGd1KlAukV6Vs
         8r+WOfihGyfaArsm5KZTrVTLAEDlaHhKXG4uIrHLavlwAmjtuwurL42N5GxzgIJQxW/c
         ZjggaBRaty1O2rKVfJ5Ucl5/O1MCNkhxP8WJ9ryN4xMmCF7zph2A0kRiSv+wDaf47ysE
         myxQ==
X-Gm-Message-State: AKS2vOzIkqF1OpEZy6SHP72zKurzijBLiKJ0C8rxTx073rUmM6sp4Ga8
        77FQBY3p1CVYCihD+UotsQ==
X-Received: by 10.98.160.133 with SMTP id p5mr24094247pfl.226.1498856024715;
        Fri, 30 Jun 2017 13:53:44 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id u9sm20974466pfd.56.2017.06.30.13.53.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:44 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 24/25] diff.c: add dimming to moved line detection
Date:   Fri, 30 Jun 2017 13:53:09 -0700
Message-Id: <20170630205310.7380-25-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630205310.7380-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630205310.7380-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any lines inside a moved block of code are not interesting. Boundaries
of blocks are only interesting if they are next to another block of moved
code.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 color.h                    |   2 +
 diff.c                     | 132 +++++++++++++++++++++++++++++++++++++++++----
 diff.h                     |   9 +++-
 t/t4015-diff-whitespace.sh | 124 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 254 insertions(+), 13 deletions(-)

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
index 79ea592388..4af73a7e0c 100644
--- a/diff.c
+++ b/diff.c
@@ -58,10 +58,14 @@ static char diff_colors[][COLOR_MAXLEN] = {
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
@@ -91,10 +95,18 @@ static int parse_diff_color_slot(const char *var)
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
 
@@ -262,8 +274,10 @@ static int parse_color_moved(const char *arg)
 		return COLOR_MOVED_ZEBRA;
 	else if (!strcmp(arg, "default"))
 		return COLOR_MOVED_DEFAULT;
+	else if (!strcmp(arg, "dimmed_zebra"))
+		return COLOR_MOVED_ZEBRA_DIM;
 	else
-		return error(_("color moved setting must be one of 'no', 'default', 'zebra', 'plain'"));
+		return error(_("color moved setting must be one of 'no', 'default', 'zebra', 'dimmed_zebra', 'plain'"));
 }
 
 int git_diff_ui_config(const char *var, const char *value, void *cb)
@@ -649,6 +663,7 @@ enum diff_symbol {
 #define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF	(1<<16)
 #define DIFF_SYMBOL_MOVED_LINE			(1<<17)
 #define DIFF_SYMBOL_MOVED_LINE_ALT		(1<<18)
+#define DIFF_SYMBOL_MOVED_LINE_UNINTERESTING	(1<<19)
 #define DIFF_SYMBOL_CONTENT_WS_MASK (WSEH_NEW | WSEH_OLD | WSEH_CONTEXT | WS_RULE_MASK)
 
 /*
@@ -933,6 +948,67 @@ static void mark_color_as_moved(struct diff_options *o,
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
@@ -1007,24 +1083,56 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
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
@@ -5420,6 +5528,8 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 
 			add_lines_to_move_detection(o, &add_lines, &del_lines);
 			mark_color_as_moved(o, &add_lines, &del_lines);
+			if (o->color_moved == COLOR_MOVED_ZEBRA_DIM)
+				dim_moved_lines(o);
 
 			hashmap_free(&add_lines, 0);
 			hashmap_free(&del_lines, 0);
diff --git a/diff.h b/diff.h
index 4cfd609c54..5755f465de 100644
--- a/diff.h
+++ b/diff.h
@@ -192,6 +192,7 @@ struct diff_options {
 		COLOR_MOVED_NO = 0,
 		COLOR_MOVED_PLAIN = 1,
 		COLOR_MOVED_ZEBRA = 2,
+		COLOR_MOVED_ZEBRA_DIM = 3,
 	} color_moved;
 	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
 	#define COLOR_MOVED_MIN_BLOCK_LENGTH 3
@@ -218,8 +219,12 @@ enum color_diff {
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
index d1d7b99990..c3b697411a 100755
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
2.13.0.31.g9b732c453e

