Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C952B1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeDPWKC (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:10:02 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44706 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeDPWKA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:10:00 -0400
Received: by mail-pl0-f68.google.com with SMTP id s13-v6so3551491plq.11
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wkJwRvd08I+9qprLNadKeFHebbWse9dIB086s7sdkH0=;
        b=Zihl7I76nGf9zQd82nStVlp9UivyGfLBANsqFUQZH4wy24R4kvy4smyw39klYPqzLH
         ZqvuTgTXY12Pzo2hl9d7v6pH6L68Hp0xPWE+G94amWlAYxh60wncx6i1Aut5J+KMGYBv
         kcZwXDbIcVTdgJs4SvXjXahTt6CTYXxb9/HgYe4Ndo+7kCHOYeZGf7eHWzdjpXZlBxyg
         4w9OIRAiMCRCi5plr5jf83e2ozgy5LhFlx200Fboz09tSMD2AyNFaZx55wNkNj3KSFko
         6KpO2aw5R0DoOGrX2R6N3SSjBW4oAtb/JVTuZc+T5PtGzAGh21IS9it7i/YHA5gLuM5d
         RnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wkJwRvd08I+9qprLNadKeFHebbWse9dIB086s7sdkH0=;
        b=bod41QOkiSwvp+rVq+2A0K97ekW9rLNFJHIYzMzKTReVXrskWcmOlCZaSIZi2vReV7
         4KTTI//aTfXXWKbW6/jAMdd8ZUHEfI6IXlE7zqcloyMKRkFFGPoZE9RWhWY+C/4RFHIh
         +P7y+pwqkboDMTplTbHz9hSl66oPv71ZG5ean9pOncNRulvRBGjtZmzEyDbDNcnxPlCr
         lzhx+ojvEMkgXulFXvbuXylTMUsVA00IN843Qgo/+hRMQ6y4NGaZ8USsohPknT97KjXK
         6l6tHgvbJ/knCeObwfOJZqkN0NGSHhK+jTsLnAITZsxXW+ruhiAVG3hkjnrWZ27LTrKx
         7tKQ==
X-Gm-Message-State: ALQs6tCQ8dugcQ6oJKbQabs5HH0JPZnq/EIB1im2E6OjTDTTSjk1Kq8E
        XXHirHnU09YCyjxxsCtVi8uj7hfCSAI=
X-Google-Smtp-Source: AIpwx49INY9rLSsqAiKWbnAAwteh78xShuxywC9ZpabqKYyZfEr/gQp4opRTJXV1HNSzgjyJKqc5bg==
X-Received: by 2002:a17:902:bc84:: with SMTP id bb4-v6mr6102207plb.8.1523916599680;
        Mon, 16 Apr 2018 15:09:59 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id g72sm6691834pfg.60.2018.04.16.15.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 15:09:59 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] builtin/blame: dim uninteresting metadata lines
Date:   Mon, 16 Apr 2018 15:09:54 -0700
Message-Id: <20180416220955.46163-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180416220955.46163-1-sbeller@google.com>
References: <20180416220955.46163-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using git-blame lots of lines contain redundant information, for
example in hunks that consist of multiple lines, the metadata (commit
name, author, date) are repeated. A reader may not be interested in those,
so offer an option to color the information that is repeated from the
previous line differently. Both the command line option '--color-lines'
as well as a config option 'color.blame.colorLines' is provided.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt |  5 +++++
 builtin/blame.c          | 42 ++++++++++++++++++++++++++++++++++++----
 color.h                  |  1 +
 t/t8012-blame-colors.sh  | 29 +++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 4 deletions(-)
 create mode 100755 t/t8012-blame-colors.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..a223232263 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1218,6 +1218,11 @@ color.status.<slot>::
 	status short-format), or
 	`unmerged` (files which have unmerged changes).
 
+color.blame.repeatedMeta::
+	Use the customized color for the part of git-blame output that
+	is repeated meta information per line (such as commit id,
+	author name, date and timezone). Defaults to dark gray.
+
 color.ui::
 	This variable determines the default value for variables such
 	as `color.diff` and `color.grep` that control the use of color
diff --git a/builtin/blame.c b/builtin/blame.c
index db38c0b307..b49fee70a9 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -7,6 +7,7 @@
 
 #include "cache.h"
 #include "config.h"
+#include "color.h"
 #include "builtin.h"
 #include "commit.h"
 #include "diff.h"
@@ -46,6 +47,7 @@ static int xdl_opts;
 static int abbrev = -1;
 static int no_whole_file_rename;
 static int show_progress;
+static char repeated_meta_color[COLOR_MAXLEN];
 
 static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
@@ -316,10 +318,11 @@ static const char *format_time(timestamp_t time, const char *tz_str,
 #define OUTPUT_PORCELAIN	010
 #define OUTPUT_SHOW_NAME	020
 #define OUTPUT_SHOW_NUMBER	040
-#define OUTPUT_SHOW_SCORE      0100
-#define OUTPUT_NO_AUTHOR       0200
+#define OUTPUT_SHOW_SCORE	0100
+#define OUTPUT_NO_AUTHOR	0200
 #define OUTPUT_SHOW_EMAIL	0400
-#define OUTPUT_LINE_PORCELAIN 01000
+#define OUTPUT_LINE_PORCELAIN 	01000
+#define OUTPUT_COLOR_LINE	02000
 
 static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
 {
@@ -375,6 +378,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 	struct commit_info ci;
 	char hex[GIT_MAX_HEXSZ + 1];
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
+	const char *color = "", *reset = "";
 
 	get_commit_info(suspect->commit, &ci, 1);
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
@@ -384,6 +388,19 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 		char ch;
 		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
 
+		if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
+			if (opt & OUTPUT_COLOR_LINE) {
+				if (cnt > 0) {
+					color = repeated_meta_color;
+					reset = GIT_COLOR_RESET;
+				} else  {
+					color ="";
+					reset = "";
+				}
+			}
+			fputs(color, stdout);
+		}
+
 		if (suspect->commit->object.flags & UNINTERESTING) {
 			if (blank_boundary)
 				memset(hex, ' ', length);
@@ -433,6 +450,9 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			printf(" %*d) ",
 			       max_digits, ent->lno + 1 + cnt);
 		}
+		if (!(opt & OUTPUT_ANNOTATE_COMPAT) &&
+		    (opt & OUTPUT_COLOR_LINE))
+			fputs(reset, stdout);
 		do {
 			ch = *cp++;
 			putchar(ch);
@@ -585,6 +605,8 @@ static const char *add_prefix(const char *prefix, const char *path)
 
 static int git_blame_config(const char *var, const char *value, void *cb)
 {
+	int *output_option = cb;
+
 	if (!strcmp(var, "blame.showroot")) {
 		show_root = git_config_bool(var, value);
 		return 0;
@@ -607,6 +629,13 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		parse_date_format(value, &blame_date_mode);
 		return 0;
 	}
+	if (!strcmp(var, "color.blame.repeatedlines")) {
+		if (color_parse_mem(value, strlen(value), repeated_meta_color))
+			warning(_("invalid color '%s' in color.blame.repeatedLines"),
+				value);
+		*output_option |= OUTPUT_COLOR_LINE;
+		return 0;
+	}
 
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
@@ -690,6 +719,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
+		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
 
 		/*
 		 * The following two options are parsed by parse_revision_opt()
@@ -949,8 +979,12 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	blame_coalesce(&sb);
 
-	if (!(output_option & OUTPUT_PORCELAIN))
+	if (!(output_option & OUTPUT_PORCELAIN)) {
 		find_alignment(&sb, &output_option);
+		if (!*repeated_meta_color &&
+		    (output_option & OUTPUT_COLOR_LINE))
+			strcpy(repeated_meta_color, GIT_COLOR_DARK);
+	}
 
 	output(&sb, output_option);
 	free((void *)sb.final_buf);
diff --git a/color.h b/color.h
index cd0bcedd08..196be16058 100644
--- a/color.h
+++ b/color.h
@@ -30,6 +30,7 @@ struct strbuf;
 #define GIT_COLOR_BLUE		"\033[34m"
 #define GIT_COLOR_MAGENTA	"\033[35m"
 #define GIT_COLOR_CYAN		"\033[36m"
+#define GIT_COLOR_DARK		"\033[1;30m"
 #define GIT_COLOR_BOLD_RED	"\033[1;31m"
 #define GIT_COLOR_BOLD_GREEN	"\033[1;32m"
 #define GIT_COLOR_BOLD_YELLOW	"\033[1;33m"
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
new file mode 100755
index 0000000000..bb0fe20e76
--- /dev/null
+++ b/t/t8012-blame-colors.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description='colored git blame'
+. ./test-lib.sh
+
+PROG='git blame -c'
+. "$TEST_DIRECTORY"/annotate-tests.sh
+
+test_expect_success 'colored blame colors contiguous lines' '
+	git blame --abbrev=12 --color-lines hello.c >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	grep "<BOLD;BLACK>" <actual >darkened &&
+	grep "(F" darkened > F.expect &&
+	grep "(H" darkened > H.expect &&
+	test_line_count = 2 F.expect &&
+	test_line_count = 3 H.expect
+'
+
+test_expect_success 'colored blame colors contiguous lines via config' '
+	git -c color.blame.repeatedLines=yellow blame --abbrev=12 hello.c >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	grep "<YELLOW>" <actual >darkened &&
+	grep "(F" darkened > F.expect &&
+	grep "(H" darkened > H.expect &&
+	test_line_count = 2 F.expect &&
+	test_line_count = 3 H.expect
+'
+
+test_done
-- 
2.17.0.484.g0c8726318c-goog

