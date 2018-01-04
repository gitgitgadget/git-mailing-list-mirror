Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53A571F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753377AbeADWkR (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:40:17 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37812 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753199AbeADWkO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:40:14 -0500
Received: by mail-pg0-f65.google.com with SMTP id o13so1263768pgp.4
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 14:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P1NEQuxOsKiJSd9UWmor58yfsEI8D3ishurNn5rJqvQ=;
        b=fmvdrijBLCY7SZB/d26s2mIb3J647ghtvXsH5MV6qnz7lFlLfeZsLuGXn3tesF/z6O
         OhJcR7Zr92mieapT2ZecBvafm9chrCghaNAWFK/GB1y4IdRuecajWtabsmDBDJxmQPuD
         akdEt+SEgIqPN+npH0QxGeYlZUUW+FCweCzsvflY2M1d72V7GaG9dpr45QWtkSQf3kYn
         WpnUUT0o1RBzIzFbFhy7WS0eQ98uQzfNnSBS+ahhuvGQKkqFiOOyhS6uMQxjlEtfRjOz
         Qbc2altP7SknqetNMmhyE5gXCfROFf+GhT9MlYM9+IZK4kQkMnHKSD2ukuvQG08xvG7j
         5whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P1NEQuxOsKiJSd9UWmor58yfsEI8D3ishurNn5rJqvQ=;
        b=gBiy2bAn9DDUSds789v3ZLecp/7fPlCBaZ0RVgijUuo/3sbz5jSMAlbzgOyRbc31ZB
         Sq/7znDYwM03BZ5q6kYqU6RE6vAV/NSZqOyUtw6y+BMvSq2FjXGzGKAE48Du8Tsph1oW
         jPUwDrmGWZmq5hjWPnilQ2qiNsLpmjZFc/wHtB3YyrPxa6OkCyuJfod9nrDo3ltYbPwT
         B+uHtz2ZUJ+otv1lDHvjMEZy/1tv/7yUiZ0VA8YBySOfzMsh9WS1ROdExPLyXAQoQU9Z
         uwYc9Q6bqm/IsIrygtAJBI5cx6iG5PHD6kied7cZkMUYKIg1+DKOfcxJ+x0iBHBvOwrN
         jfjQ==
X-Gm-Message-State: AKGB3mIX4LBXThGk5sdSQkIYuzfDpuzWsA+md8sCYdExLM7lI3DMMOuZ
        lSGtGiykM33AxkEt5JoAbijobg==
X-Google-Smtp-Source: ACJfBotEo/oXHl8Pl8TwcfkrxfTRUeEXrErzGkMxEs2GYUGf7gSOnhQ9ImhvF++EqHnS8VsGFOo82A==
X-Received: by 10.99.125.5 with SMTP id y5mr835860pgc.362.1515105613770;
        Thu, 04 Jan 2018 14:40:13 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e8sm10504527pfk.6.2018.01.04.14.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jan 2018 14:40:13 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, sunshine@sunshineco.com
Cc:     git@vger.kernel.org
Subject: [PATCHv3 2/4] builtin/blame: dim uninteresting metadata
Date:   Thu,  4 Jan 2018 14:40:05 -0800
Message-Id: <20180104224007.214548-3-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac83678-goog
In-Reply-To: <20180104224007.214548-1-sbeller@google.com>
References: <20171110011002.10179-1-sbeller@google.com>
 <20180104224007.214548-1-sbeller@google.com>
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
 Documentation/config.txt |  5 +++++
 builtin/blame.c          | 50 ++++++++++++++++++++++++++++++++++--------------
 color.h                  |  1 +
 t/t8012-blame-colors.sh  | 18 +++++++++++++++++
 4 files changed, 60 insertions(+), 14 deletions(-)
 create mode 100755 t/t8012-blame-colors.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 64c1dbba94..45749a574d 100644
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
index 005f55aaa2..7b9c6e8676 100644
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
@@ -383,6 +386,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
 		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
+		const char *color = "", *reset = "";
 
 		if (suspect->commit->object.flags & UNINTERESTING) {
 			if (blank_boundary)
@@ -393,7 +397,12 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			}
 		}
 
-		printf("%.*s", length, hex);
+		if ((opt & OUTPUT_COLOR_LINE) && cnt > 0) {
+			color = repeated_meta_color;
+			reset = GIT_COLOR_RESET;
+		}
+
+		printf("%s%.*s%s", color, length, hex, reset);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
 			const char *name;
 			if (opt & OUTPUT_SHOW_EMAIL)
@@ -406,16 +415,17 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			       ent->lno + 1 + cnt);
 		} else {
 			if (opt & OUTPUT_SHOW_SCORE)
-				printf(" %*d %02d",
+				printf(" %s%*d %02d%s", color,
 				       max_score_digits, ent->score,
-				       ent->suspect->refcnt);
+				       ent->suspect->refcnt, reset);
 			if (opt & OUTPUT_SHOW_NAME)
-				printf(" %-*.*s", longest_file, longest_file,
-				       suspect->path);
+				printf(" %s%-*.*s%s", color, longest_file,
+						      longest_file,
+						      suspect->path,
+						      reset);
 			if (opt & OUTPUT_SHOW_NUMBER)
-				printf(" %*d", max_orig_digits,
-				       ent->s_lno + 1 + cnt);
-
+				printf(" %s%*d%s", color, max_orig_digits,
+				       ent->s_lno + 1 + cnt, reset);
 			if (!(opt & OUTPUT_NO_AUTHOR)) {
 				const char *name;
 				int pad;
@@ -424,11 +434,12 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 				else
 					name = ci.author.buf;
 				pad = longest_author - utf8_strwidth(name);
-				printf(" (%s%*s %10s",
+				printf(" %s(%s%*s %10s%s", color,
 				       name, pad, "",
 				       format_time(ci.author_time,
 						   ci.author_tz.buf,
-						   show_raw_time));
+						   show_raw_time),
+				       reset);
 			}
 			printf(" %*d) ",
 			       max_digits, ent->lno + 1 + cnt);
@@ -607,6 +618,12 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		parse_date_format(value, &blame_date_mode);
 		return 0;
 	}
+	if (!strcmp(var, "color.blame.repeatedmeta")) {
+		if (color_parse_mem(value, strlen(value), repeated_meta_color))
+			warning(_("invalid color '%s' in color.blame.repeatedMeta"),
+				value);
+		return 0;
+	}
 
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
@@ -681,6 +698,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
+		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
 
 		/*
 		 * The following two options are parsed by parse_revision_opt()
@@ -940,8 +958,12 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
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
index 2e768a10c6..2df2f86698 100644
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
index 0000000000..a2b7090cef
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
+test_expect_success 'colored blame colors contiguous lines' '
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
2.16.0.rc0.223.g4a4ac83678-goog

