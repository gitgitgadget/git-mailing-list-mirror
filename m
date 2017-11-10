Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16D59201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 01:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755468AbdKJBKS (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 20:10:18 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:49973 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755317AbdKJBKN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 20:10:13 -0500
Received: by mail-io0-f195.google.com with SMTP id n137so11887430iod.6
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 17:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QFPFSJbnMV4XYFhyOa+US6s1lIu+el9VdjD0xQ9LvlI=;
        b=qEdJ5GmciSbxtsHwF4k06aMDjHqo8q86REoedQJh/JQUEvdqOisb326TLQ2WK0p7TU
         GPgC3KPDXU9H220DiTsIQsbDF5jj3rCGE7idsbzT9xgyCQmjZxq5g48uPETneIAvx7IN
         YlmATmn7MFT0KryKaL3yTdjcMFIr138tEo4VfoljOgYtDj/C1JPkK645tw9OIWBNweVt
         3PLhFuvLqnGiwoCCaJDTYVJHh+bSoFCjkuCLzQjWDfysuU4rXx8y5k7Dusnn+whXfXnf
         oLC7iJOI+ntysgdZQ9FbS5RA2QDvFlhum9x+HYxqFZvQtJwnEnDFBqvkga4dG3I5Idcb
         5i1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QFPFSJbnMV4XYFhyOa+US6s1lIu+el9VdjD0xQ9LvlI=;
        b=cz9eHhGZ6zaxeTKhY9+tDaREAS925NvyAwA5ZoW+M8Nfj/upCZL0se0k1AcVswAMcl
         KrcBBj2WKRoozKM8y6DtndrG+NAnAqY0xig2OQd/W8oBsgtsbNKaKUscS6p3mGZGprRY
         GghtlCF7LAT8D5ccKtCq+5bBvy/pTDGS8xZ9uxgcFRXyVMImqb1KxyYNpDWW/oYxk3zK
         KwsYPqSdXkSsNNf2Q3MzSvFYr8twkLuF7mPw80jCC4ONyVHad6re393f+5satH6/0FM8
         RZ4u43e4ahFURHNGVlktx3QXjMRmLSl9v1ttVu1/0q/xeAtM8vgvpDWwIEunexs1yVcR
         GHMg==
X-Gm-Message-State: AJaThX5IPiywl75evcDKildfNzhufgJXDuRrnRfDbk8bkWNFNidchvi/
        CNtwLCsn+cvHyT++U7wVU8xlnaFHy04=
X-Google-Smtp-Source: AGs4zMawq8ZB3YCve0U6qfoFrq7H4KaItJnA2zIB41JJOvBtUuebWQZ2jX44aXpJ0WJxf+/vE9e78g==
X-Received: by 10.107.22.69 with SMTP id 66mr2923867iow.150.1510276211761;
        Thu, 09 Nov 2017 17:10:11 -0800 (PST)
Received: from localhost ([2620:0:100e:422:3816:f49a:2bf0:e33c])
        by smtp.gmail.com with ESMTPSA id p17sm3910776iod.40.2017.11.09.17.10.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Nov 2017 17:10:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] builtin/blame: dim uninteresting metadata
Date:   Thu,  9 Nov 2017 17:10:00 -0800
Message-Id: <20171110011002.10179-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171110011002.10179-1-sbeller@google.com>
References: <20171110011002.10179-1-sbeller@google.com>
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
index 5f0d62753d..85dfdc6a9b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1189,6 +1189,11 @@ color.status.<slot>::
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
index 67adaef4d8..d15e901357 100644
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
2.15.0.128.gcadd42da22

