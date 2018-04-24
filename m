Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEE961F424
	for <e@80x24.org>; Tue, 24 Apr 2018 00:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932665AbeDXAJL (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 20:09:11 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34865 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932615AbeDXAJI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 20:09:08 -0400
Received: by mail-pg0-f67.google.com with SMTP id j11so9496520pgf.2
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 17:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=toilbbohjX0RVlH6eSA7SZq57+Latu0OBZRKNGvMNx0=;
        b=PsXlzmxC/NWAPqYAbZzWvTEuCBi2IxBA7+ir1uKnTWcOyGwIHDt2O8ByuBfxoo35Ez
         8gTGmR12D69ClSmOMMH/luAOcyRJWzItrMxWLBZ8UOKp/PWWMwsVRUGByqsbMweE9gAB
         Av4FKTkV2VPQacE62Z9vstqWxGBtZfgx4xMyDCk9BgdBAf0Ei/vdtfWZex5xUIKZbdPB
         uEYvSp6vRk/miAYWi7ZOKfw8NWfrAsegOnuU/yuxAEueyk/BoNtwDU3/TBwnz32ujFrc
         IDvezxu2y1jHyk+/Thi6KlHM09jFYHH2d1pp4XJPBJ4c20xk3bMA09ParUdJfQrgQ4B+
         0vWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=toilbbohjX0RVlH6eSA7SZq57+Latu0OBZRKNGvMNx0=;
        b=K75sya7NtE+mG09+1SvWd3xMsANh4aWTgoMEA2TCcOiJrKXZ+QbcW7SXVy/y4ud/ET
         NeTfeouzBg3n2suDg8iU9QYVTQP8haVUE/Z4zRxzGvo/dx/ork/h4ozklYw/xXd0xVct
         XDII3W/cUnLhoxD+jW0C9le++ArKRu4BceRtKkmZKM1RGMwXoXQND0RZvNa7bwqGLjqc
         gsaeBuSKil4QZDpZdfO5TyO71GUMYwAbPa8AoqchSCfQPRzqyvJ9ThBj4G9q0KD84IJW
         I8R9TGETfJSvKBxoKsUhIevEq6hSTn/yfwS2mtOfgQ3QV4ERBINyv62gOvl3WOB5F/JT
         WK7A==
X-Gm-Message-State: ALQs6tD6WttkFDqtk7GCwVT6B9o9vF9bNHGS/YX3Cl0ldmih0ajYT5lS
        D/iyPNPItDvw1VOk+8kuOlXQIqJZP1o=
X-Google-Smtp-Source: AIpwx4/kTbvmvkPuimQ2P19Hd2IZHSS3Q1mPkpnVk/dRxcFP1OigN0EOl5qUey8orRVVCP1anvRI2Q==
X-Received: by 2002:a17:902:a24:: with SMTP id 33-v6mr22874558plo.72.1524528546824;
        Mon, 23 Apr 2018 17:09:06 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id a15sm23691312pgd.25.2018.04.23.17.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 17:09:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] builtin/blame: dim uninteresting metadata lines
Date:   Mon, 23 Apr 2018 17:08:58 -0700
Message-Id: <20180424000900.175235-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424000900.175235-1-sbeller@google.com>
References: <20180424000900.175235-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using git-blame lots of lines contain redundant information, for
example in hunks that consist of multiple lines, the metadata (commit
name, author, date) are repeated. A reader may not be interested in those,
so offer an option to color the information that is repeated from the
previous line differently. Traditionally, we use CYAN for lines that
are less interesting than others (e.g. hunk header), so go with that.

The command line option '--color-lines' will trigger the coloring of
repeated lines, and the config option 'color.blame.colorLines' is
provided to select the color. Setting the config option doesn't imply
that repeated lines are colored. A later patch will introduce a config
to enable this mode by default.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt |  5 +++++
 builtin/blame.c          | 39 +++++++++++++++++++++++++++++++++++----
 t/t8012-blame-colors.sh  | 19 +++++++++++++++++++
 3 files changed, 59 insertions(+), 4 deletions(-)
 create mode 100755 t/t8012-blame-colors.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..9445a3a548 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1218,6 +1218,11 @@ color.status.<slot>::
 	status short-format), or
 	`unmerged` (files which have unmerged changes).
 
+color.blame.repeatedLines::
+	Use the customized color for the part of git-blame output that
+	is repeated meta information per line (such as commit id,
+	author name, date and timezone). Defaults to cyan.
+
 color.ui::
 	This variable determines the default value for variables such
 	as `color.diff` and `color.grep` that control the use of color
diff --git a/builtin/blame.c b/builtin/blame.c
index db38c0b307..4d5fc64880 100644
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
+				color = NULL;
+				reset = NULL;
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
@@ -607,6 +625,12 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		parse_date_format(value, &blame_date_mode);
 		return 0;
 	}
+	if (!strcmp(var, "color.blame.repeatedlines")) {
+		if (color_parse_mem(value, strlen(value), repeated_meta_color))
+			warning(_("invalid color '%s' in color.blame.repeatedLines"),
+				value);
+		return 0;
+	}
 
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
@@ -690,6 +714,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
+		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
 
 		/*
 		 * The following two options are parsed by parse_revision_opt()
@@ -949,8 +974,14 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
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
index 0000000000..98a22a3c8d
--- /dev/null
+++ b/t/t8012-blame-colors.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='colored git blame'
+. ./test-lib.sh
+
+PROG='git blame -c'
+. "$TEST_DIRECTORY"/annotate-tests.sh
+
+test_expect_success 'colored blame colors contiguous lines' '
+	git -c color.blame.repeatedLines=yellow blame --color-lines --abbrev=12 hello.c >actual.raw &&
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
2.17.0.441.gb46fe60e1d-goog

