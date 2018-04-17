Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09F971F404
	for <e@80x24.org>; Tue, 17 Apr 2018 21:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeDQVbB (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 17:31:01 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46209 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752841AbeDQVa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 17:30:59 -0400
Received: by mail-pf0-f193.google.com with SMTP id h69so12755437pfe.13
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 14:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1DyuTDCMldqidIl+UOIY7ehqxncsW4G5oq2PvB6FrUo=;
        b=Yus1ou+ZasbvVdG6p6DWKPxv+6D5Ra+FhtwukeL96xPD07R6+Hh8qdf99JqamsxN3A
         D8YT9TspDOlLymlVh5zXpYVk9JKgLL1lj/ANP43ngkCz0ni4pqMh5V5upk4baN501atR
         40zXpgN0+fhmU5fXSw5aLu1u0M4o3761S1tqi19Oe7VCFZb+Sx1+p+nH8KtTr9duMsVX
         JRuYYpgSOAO1O0P0cqxsiIRMyNBEioUc54i8pzzbmkU1ALgPsSGhTsvxdaDh35Y1Pq7V
         OM1oeMbCUBwUmeFuK/lsJiFFxWAQgs6gI/a06mnIJNarqv3dUzjoMnjscUWxvZ7RYOSU
         gOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1DyuTDCMldqidIl+UOIY7ehqxncsW4G5oq2PvB6FrUo=;
        b=FaNuiTbp9Lf3T57tBqwDFMw1kikvSsaV8yewVzhiTcqhx+dKYGA6uPSBDwHRMzY+B6
         FOkurQGUg+VfHOgXnH4ZAFOODQl6ETbYmZFot4eI2zyMtmZrpeCA3wdP2IQkhmGf6zW6
         kHnUwxEUuZHiRztuoVGHvYFUGdrfs3gQ1j8RPKHZYD7dA5EaDF1Fhe6cdRNB2ZcwtrSs
         rvsB0qAzgq1yjY2jrRZbA6HwNbhd/uOZRYgEljeZuBqV+wEyZTIQXvFdqqBH1j2suO+P
         TpxarI51ZG4CeXgoLR54T6zNDeXB7LT6fIvKPN26Xl3czONvm7jWERuMh5U6V4hqKVjS
         AtVw==
X-Gm-Message-State: ALQs6tDWPZM+sBoV2z6jD8EsItgK7MmecqzCaDdnfOLt+IBrLP1vTuTh
        uwe/3WWae8S61Xpm0rqQdwahp3FK84Q=
X-Google-Smtp-Source: AIpwx4/OoXFIaiNtk5TxxxBxo4CsPp0rZEQJwEXcLpEURy1wN1p1Ta4EEj0/oYadn2PoydMxbTX1LQ==
X-Received: by 10.98.139.7 with SMTP id j7mr3423471pfe.28.1524000658191;
        Tue, 17 Apr 2018 14:30:58 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y6sm36024800pfg.121.2018.04.17.14.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 14:30:57 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH 1/2] builtin/blame: dim uninteresting metadata lines
Date:   Tue, 17 Apr 2018 14:30:48 -0700
Message-Id: <20180417213049.118995-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <CAGZ79kYjV6Wpzymx1phL7EC3BxdWr5gitCOdE6=fJFFnz4zYiA@mail.gmail.com>
References: <CAGZ79kYjV6Wpzymx1phL7EC3BxdWr5gitCOdE6=fJFFnz4zYiA@mail.gmail.com>
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
 t/t8012-blame-colors.sh  | 29 +++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 4 deletions(-)
 create mode 100755 t/t8012-blame-colors.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..8128eee4f9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1218,6 +1218,11 @@ color.status.<slot>::
 	status short-format), or
 	`unmerged` (files which have unmerged changes).
 
+color.blame.repeatedMeta::
+	Use the customized color for the part of git-blame output that
+	is repeated meta information per line (such as commit id,
+	author name, date and timezone). Defaults to cyan.
+
 color.ui::
 	This variable determines the default value for variables such
 	as `color.diff` and `color.grep` that control the use of color
diff --git a/builtin/blame.c b/builtin/blame.c
index db38c0b307..5190ff5df3 100644
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
+#define OUTPUT_LINE_PORCELAIN	01000
+#define OUTPUT_COLOR_LINE	02000
 
 static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
 {
@@ -375,6 +378,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 	struct commit_info ci;
 	char hex[GIT_MAX_HEXSZ + 1];
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
+	const char *color = NULL, *reset = NULL;
 
 	get_commit_info(suspect->commit, &ci, 1);
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
@@ -384,6 +388,18 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 		char ch;
 		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
 
+		if (opt & OUTPUT_COLOR_LINE) {
+			if (cnt > 0) {
+				color = repeated_meta_color;
+				reset = GIT_COLOR_RESET;
+			} else  {
+				color = "";
+				reset = "";
+			}
+		}
+		if (color)
+			fputs(color, stdout);
+
 		if (suspect->commit->object.flags & UNINTERESTING) {
 			if (blank_boundary)
 				memset(hex, ' ', length);
@@ -433,6 +449,8 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			printf(" %*d) ",
 			       max_digits, ent->lno + 1 + cnt);
 		}
+		if (reset)
+			fputs(reset, stdout);
 		do {
 			ch = *cp++;
 			putchar(ch);
@@ -585,6 +603,8 @@ static const char *add_prefix(const char *prefix, const char *path)
 
 static int git_blame_config(const char *var, const char *value, void *cb)
 {
+	int *output_option = cb;
+
 	if (!strcmp(var, "blame.showroot")) {
 		show_root = git_config_bool(var, value);
 		return 0;
@@ -607,6 +627,13 @@ static int git_blame_config(const char *var, const char *value, void *cb)
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
@@ -690,6 +717,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
+		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
 
 		/*
 		 * The following two options are parsed by parse_revision_opt()
@@ -949,8 +977,14 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	blame_coalesce(&sb);
 
-	if (!(output_option & OUTPUT_PORCELAIN))
+	if (!(output_option & OUTPUT_PORCELAIN)) {
 		find_alignment(&sb, &output_option);
+		if (!*repeated_meta_color &&
+		    (output_option & OUTPUT_COLOR_LINE))
+			strcpy(repeated_meta_color, GIT_COLOR_CYAN);
+	}
+	if (output_option & OUTPUT_ANNOTATE_COMPAT)
+		output_option &= ~OUTPUT_COLOR_LINE;
 
 	output(&sb, output_option);
 	free((void *)sb.final_buf);
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
new file mode 100755
index 0000000000..9fc32ff813
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
+	grep "<CYAN>" <actual >darkened &&
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

