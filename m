Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBDED1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 21:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754779AbdL1VED (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 16:04:03 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:38575 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754759AbdL1VEB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 16:04:01 -0500
Received: by mail-io0-f195.google.com with SMTP id 87so35272308ior.5
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 13:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P35rgS/vPyrTcwqP+zEa5v4Us8jwwqU8eyuDi1f8PXg=;
        b=YEFOHZ48LCj13q1s4acdtWXh0CXHurxXj6W4s1xJPM/ghRzAKsEiAvHALOiWxWd8p3
         vMO/lYJtqVacf/OcUU4ml1Dy9l8bjLu80tKqu9C8TJn+0gaAVDjmjlg69U08ZqMnDh+W
         0ZGsYBAchvEdCC5mBHbkQ33CwPcTDz1Zlxg9UZ6bq4wnCMITjFYm0f4O6Wqtabef2Saz
         blxxVjgfmpcBYWnoDVExoWAOMQ8T+pujGiwPhx2OoqXbPIeX53Nx3vp/ybYq4KVqTYVu
         1YgTshESNINZplrfnreQGQ3hoIbXlCfEMAm8dZufZNjdDw4cnlQQMEufYrCVvidzTu/K
         t+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P35rgS/vPyrTcwqP+zEa5v4Us8jwwqU8eyuDi1f8PXg=;
        b=V+kNZXRuImIk91ivBaS1Wl2Q90mGNOb4k8uQKQCsqJm3xEwRkhf4OEBKq1Dan1W8it
         RFkrwDFN4lxTbVpNf+JZUE3h7fIIVkov15l8dJmEZ5Y8Z+PAUEFEWG/ApDvfeahU2W1h
         QYl+rifnAksyc84i5XLkaw2JES0Oj2GIl6XhzMZNQBLjnLZYsC0QYGC8PXIafFqS/0N0
         e/37rPwF0mS7K3E6HUDKQvT3aRKyrIQ+3OXfPdkgmX+JinNesd/F4AqsdPZRPppN3KGJ
         4QB1v+/WmboVCAy2mSosjlLDeKvYRvy5SfCywvPGv7Dcq0vioRmCpfolehKDhkywDU5t
         GsLw==
X-Gm-Message-State: AKGB3mK6btb3ROkuFf5YvTm5QtJGTBSkY0okquOZT8Pl4hQBQY7gnWsy
        7DtcECoVyI7qC3YFrqWbM6yihRNUbuY=
X-Google-Smtp-Source: ACJfBouJZhpQ7Km5VHa/CUvpIcIFcjGsbyCyTW3nYCo/2tIqh9ukKA7d7g3LUZZDJDboIHvKuTzfRA==
X-Received: by 10.107.104.20 with SMTP id d20mr16019286ioc.238.1514495040361;
        Thu, 28 Dec 2017 13:04:00 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id o66sm8115496iod.87.2017.12.28.13.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2017 13:03:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] builtin/blame: dim uninteresting metadata
Date:   Thu, 28 Dec 2017 13:03:43 -0800
Message-Id: <20171228210345.205300-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171228210345.205300-1-sbeller@google.com>
References: <20171228210345.205300-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using git-blame lots of lines contain redundant information, for
example in hunks that consist of multiple lines, the metadata (commit
name, author, date) are repeated. A reader may not be interested in those,
so offer an option to color the information that is repeated from the
previous line differently.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt |  5 ++++
 builtin/blame.c          | 68 ++++++++++++++++++++++++++++++++++++++----------
 color.h                  |  1 +
 t/t8012-blame-colors.sh  | 18 +++++++++++++
 4 files changed, 78 insertions(+), 14 deletions(-)
 create mode 100755 t/t8012-blame-colors.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b18c0f97fe..2c211b6e7d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1216,6 +1216,11 @@ color.status.<slot>::
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
index 005f55aaa2..09afb4d3ea 100644
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
+static char *repeated_meta_color;
 
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
@@ -367,6 +370,28 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 		putchar('\n');
 }
 
+static inline void colors_unset(const char **use_color, const char **reset_color)
+{
+	*use_color = "";
+	*reset_color = "";
+}
+
+static inline void colors_set(const char **use_color, const char **reset_color)
+{
+	*use_color = repeated_meta_color;
+	*reset_color = GIT_COLOR_RESET;
+}
+
+static void setup_line_color(int opt, int cnt,
+			     const char **use_color,
+			     const char **reset_color)
+{
+	colors_unset(use_color, reset_color);
+
+	if ((opt & OUTPUT_COLOR_LINE) && cnt > 0)
+		colors_set(use_color, reset_color);
+}
+
 static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int opt)
 {
 	int cnt;
@@ -383,6 +408,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
 		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
+		const char *col, *rcol;
 
 		if (suspect->commit->object.flags & UNINTERESTING) {
 			if (blank_boundary)
@@ -393,7 +419,8 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			}
 		}
 
-		printf("%.*s", length, hex);
+		setup_line_color(opt, cnt, &col, &rcol);
+		printf("%s%.*s%s", col, length, hex, rcol);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
 			const char *name;
 			if (opt & OUTPUT_SHOW_EMAIL)
@@ -406,16 +433,17 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			       ent->lno + 1 + cnt);
 		} else {
 			if (opt & OUTPUT_SHOW_SCORE)
-				printf(" %*d %02d",
+				printf(" %s%*d %02d%s", col,
 				       max_score_digits, ent->score,
-				       ent->suspect->refcnt);
+				       ent->suspect->refcnt, rcol);
 			if (opt & OUTPUT_SHOW_NAME)
-				printf(" %-*.*s", longest_file, longest_file,
-				       suspect->path);
+				printf(" %s%-*.*s%s", col, longest_file,
+						      longest_file,
+						      suspect->path,
+						      rcol);
 			if (opt & OUTPUT_SHOW_NUMBER)
-				printf(" %*d", max_orig_digits,
-				       ent->s_lno + 1 + cnt);
-
+				printf(" %s%*d%s", col, max_orig_digits,
+				       ent->s_lno + 1 + cnt, rcol);
 			if (!(opt & OUTPUT_NO_AUTHOR)) {
 				const char *name;
 				int pad;
@@ -424,11 +452,12 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 				else
 					name = ci.author.buf;
 				pad = longest_author - utf8_strwidth(name);
-				printf(" (%s%*s %10s",
+				printf(" %s(%s%*s %10s%s", col,
 				       name, pad, "",
 				       format_time(ci.author_time,
 						   ci.author_tz.buf,
-						   show_raw_time));
+						   show_raw_time),
+				       rcol);
 			}
 			printf(" %*d) ",
 			       max_digits, ent->lno + 1 + cnt);
@@ -607,6 +636,12 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		parse_date_format(value, &blame_date_mode);
 		return 0;
 	}
+	if (!strcmp(var, "color.blame.repeatedmeta")) {
+		if (color_parse_mem(value, strlen(value), repeated_meta_color))
+			warning(_("ignore invalid color '%s' in color.blame.repeatedMeta"),
+				value);
+		return 0;
+	}
 
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
@@ -681,6 +716,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
+		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line"), OUTPUT_COLOR_LINE),
 
 		/*
 		 * The following two options are parsed by parse_revision_opt()
@@ -940,8 +976,12 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	blame_coalesce(&sb);
 
-	if (!(output_option & OUTPUT_PORCELAIN))
+	if (!(output_option & OUTPUT_PORCELAIN)) {
 		find_alignment(&sb, &output_option);
+		if ((output_option & OUTPUT_COLOR_LINE) &&
+		    !repeated_meta_color)
+			repeated_meta_color = GIT_COLOR_DARK;
+	}
 
 	output(&sb, output_option);
 	free((void *)sb.final_buf);
diff --git a/color.h b/color.h
index 6cd632c0d8..fce5588df9 100644
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
index 0000000000..b2de03b777
--- /dev/null
+++ b/t/t8012-blame-colors.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+
+test_description='colored git blame'
+. ./test-lib.sh
+
+PROG='git blame -c'
+. "$TEST_DIRECTORY"/annotate-tests.sh
+
+test_expect_success 'colored blame colors continuous lines' '
+	git blame --abbrev=12 --color-lines hello.c >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	grep "<BOLD;BLACK>(F" actual > F.expect &&
+	grep "<BOLD;BLACK>(H" actual > H.expect &&
+	test_line_count = 2 F.expect &&
+	test_line_count = 3 H.expect
+'
+
+test_done
-- 
2.15.1.620.gb9897f4670-goog

