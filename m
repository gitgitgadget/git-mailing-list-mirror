Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18F591F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753589AbeADWkh (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:40:37 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34240 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753287AbeADWkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:40:16 -0500
Received: by mail-pg0-f66.google.com with SMTP id j4so1269759pgp.1
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 14:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H27y2j/s0gpGzTtCSkWtOfSwIRBt6qj1LfzyyBusGEI=;
        b=jmJH/t7E707oP0/SPvkq+/pGSJY8YQbujBh276Op1cgD1odG3W9n6QqEJR95UqHaQ7
         mawPzGBCvMREkZEga5y+KiPI4Arlfj3ymrQsKjDDscaNvHienM4D3N36TsnjxTYMN4cE
         3kQNyRANlFI3FXB1VmF7TT1t5to5Q3OfJv/sDHrCB8g3Jax5zvl7/h1vU7VoQY3OrHZX
         dW4JxJmYGiBMo1siOimcqrl7syuIK64ZmdR7rL1vu+rMOnUQkWro+WqBvr2Ua1cAuQtD
         XpsAyJFDwFGiN3fzCoytcPycVvHD27i52t1zCUYsx47JpuSeVukCxIEAfdGsSWqCSFi6
         ZXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H27y2j/s0gpGzTtCSkWtOfSwIRBt6qj1LfzyyBusGEI=;
        b=WR2kIijSIABSWg0kvW74ZtjHQGwH6Gyd0y4WWQr2snHZEZTDmdmJ/ajadZtFqDvRLX
         eMWspi4Az3HugozoVdf0QN8N2frRk+I//9UnghuoTVZCGpqQSzqJh03hV8e4nliR4y9a
         mDjGkLhTLdUUXB3gymXkx+iDvV+VuG8BJrBv0zPMOWSWsI73wZwJ/Tlnv51TFiXF3KQN
         It7b1RNpvYR/kjDyEq5F+2VDoAkAJ+pZjhcSkce+u4v9to3FN9Smj83uJN3lyMCBM8p0
         d/fKXeu7VmRr11p62yjc1+2hp9IIu8o2TJyCxWlgUVPF+8rF2pYEQFsgi9NXYSRRXyIG
         JJew==
X-Gm-Message-State: AKGB3mJg0COp/hyRSBoyLrw4VeLO0QUw/PE47ZWJZOh4rIg+LvkX8ckX
        2G6qW/lVw11XY0gFVSy02F957qMKQdo=
X-Google-Smtp-Source: ACJfBosoRtdh9Azn0gJcxSlPW29lSnMGsELDLHGOu0xML0ezlZh2KAmyvHzrZJwZYjsCAGyt3fZ77g==
X-Received: by 10.98.211.130 with SMTP id z2mr927248pfk.85.1515105615218;
        Thu, 04 Jan 2018 14:40:15 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 83sm10653347pfq.12.2018.01.04.14.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jan 2018 14:40:14 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, sunshine@sunshineco.com
Cc:     git@vger.kernel.org
Subject: [PATCHv3 3/4] builtin/blame: add option to color metadata fields separately
Date:   Thu,  4 Jan 2018 14:40:06 -0800
Message-Id: <20180104224007.214548-4-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac83678-goog
In-Reply-To: <20180104224007.214548-1-sbeller@google.com>
References: <20171110011002.10179-1-sbeller@google.com>
 <20180104224007.214548-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unlike the previous commit, this dims colors for each
metadata field individually.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/blame.c         | 83 ++++++++++++++++++++++++++++++++++++++++++++-----
 t/t8012-blame-colors.sh | 38 ++++++++++++++++++++++
 2 files changed, 113 insertions(+), 8 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 7b9c6e8676..60c8dadf4b 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -323,6 +323,7 @@ static const char *format_time(timestamp_t time, const char *tz_str,
 #define OUTPUT_SHOW_EMAIL	0400
 #define OUTPUT_LINE_PORCELAIN 	01000
 #define OUTPUT_COLOR_LINE	02000
+#define OUTPUT_COLOR_FIELDS	04000
 
 static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
 {
@@ -370,7 +371,56 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 		putchar('\n');
 }
 
-static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int opt)
+static int had_same_field_previously(int opt, int field,
+			  struct blame_entry *ent,
+			  struct blame_entry *prev)
+{
+	struct commit_info ci, prev_ci;
+
+	switch (field) {
+	case OUTPUT_SHOW_SCORE:
+		return ent->score == prev->score;
+	case OUTPUT_SHOW_NAME:
+		return prev->suspect &&
+			!strcmp(ent->suspect->path, prev->suspect->path);
+	case OUTPUT_SHOW_NUMBER:
+		return ent->s_lno == prev->s_lno + prev->num_lines - 1;
+
+	case OUTPUT_NO_AUTHOR:
+		get_commit_info(ent->suspect->commit, &ci, 1);
+		get_commit_info(prev->suspect->commit, &prev_ci, 1);
+		return ((opt & OUTPUT_SHOW_EMAIL) &&
+			!strcmp(ci.author_mail.buf, prev_ci.author_mail.buf)) ||
+			!strcmp(ci.author.buf, prev_ci.author.buf);
+	default:
+		BUG("unknown field");
+	}
+	return 0;
+}
+
+static void setup_field_color(int opt, int cnt, int field,
+			      struct blame_entry *ent,
+			      struct blame_entry *prev,
+			      const char **use_color,
+			      const char **reset_color)
+{
+	if (!(opt & OUTPUT_COLOR_FIELDS))
+		return;
+
+	if ((cnt > 0 ||
+	     (prev && had_same_field_previously(opt, field, ent, prev)))) {
+		*use_color = repeated_meta_color;
+		*reset_color = GIT_COLOR_RESET;
+	} else {
+		*use_color = "";
+		*reset_color = "";
+	}
+}
+
+static void emit_other(struct blame_scoreboard *sb,
+		       struct blame_entry *ent,
+		       struct blame_entry *prev,
+		       int opt)
 {
 	int cnt;
 	const char *cp;
@@ -414,18 +464,27 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 					   show_raw_time),
 			       ent->lno + 1 + cnt);
 		} else {
-			if (opt & OUTPUT_SHOW_SCORE)
+			if (opt & OUTPUT_SHOW_SCORE) {
+				setup_field_color(opt, cnt, OUTPUT_SHOW_SCORE,
+						  ent, prev, &color, &reset);
 				printf(" %s%*d %02d%s", color,
 				       max_score_digits, ent->score,
 				       ent->suspect->refcnt, reset);
-			if (opt & OUTPUT_SHOW_NAME)
+			}
+			if (opt & OUTPUT_SHOW_NAME) {
+				setup_field_color(opt, cnt, OUTPUT_SHOW_NAME,
+						   ent, prev, &color, &reset);
 				printf(" %s%-*.*s%s", color, longest_file,
 						      longest_file,
 						      suspect->path,
 						      reset);
-			if (opt & OUTPUT_SHOW_NUMBER)
+			}
+			if (opt & OUTPUT_SHOW_NUMBER) {
+				setup_field_color(opt, cnt, OUTPUT_SHOW_NUMBER,
+						  ent, prev, &color, &reset);
 				printf(" %s%*d%s", color, max_orig_digits,
 				       ent->s_lno + 1 + cnt, reset);
+			}
 			if (!(opt & OUTPUT_NO_AUTHOR)) {
 				const char *name;
 				int pad;
@@ -434,6 +493,8 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 				else
 					name = ci.author.buf;
 				pad = longest_author - utf8_strwidth(name);
+				setup_field_color(opt, cnt, OUTPUT_NO_AUTHOR,
+						  ent, prev, &color, &reset);
 				printf(" %s(%s%*s %10s%s", color,
 				       name, pad, "",
 				       format_time(ci.author_time,
@@ -459,7 +520,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 
 static void output(struct blame_scoreboard *sb, int option)
 {
-	struct blame_entry *ent;
+	struct blame_entry *ent, *prev = NULL;
 
 	if (option & OUTPUT_PORCELAIN) {
 		for (ent = sb->ent; ent; ent = ent->next) {
@@ -481,7 +542,8 @@ static void output(struct blame_scoreboard *sb, int option)
 		if (option & OUTPUT_PORCELAIN)
 			emit_porcelain(sb, ent, option);
 		else {
-			emit_other(sb, ent, option);
+			emit_other(sb, ent, prev, option);
+			prev = ent;
 		}
 	}
 }
@@ -699,6 +761,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
+		OPT_BIT(0, "color-fields", &output_option, N_("color redundant metadata fields from previous line differently"), OUTPUT_COLOR_FIELDS),
 
 		/*
 		 * The following two options are parsed by parse_revision_opt()
@@ -757,6 +820,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	revs.diffopt.flags.follow_renames = 0;
 	argc = parse_options_end(&ctx);
 
+	if ((output_option & OUTPUT_COLOR_LINE) &&
+	    (output_option & OUTPUT_COLOR_FIELDS))
+		die(_("cannot ask for colored lines and fields at the same time"));
+
 	if (incremental || (output_option & OUTPUT_PORCELAIN)) {
 		if (show_progress > 0)
 			die(_("--progress can't be used with --incremental or porcelain formats"));
@@ -960,8 +1027,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	if (!(output_option & OUTPUT_PORCELAIN)) {
 		find_alignment(&sb, &output_option);
-		if ((output_option & OUTPUT_COLOR_LINE) &&
-		    !repeated_meta_color)
+		if (!repeated_meta_color &&
+		    (output_option & (OUTPUT_COLOR_LINE | OUTPUT_COLOR_FIELDS)))
 			repeated_meta_color = GIT_COLOR_DARK;
 	}
 
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index a2b7090cef..18f9c9a16d 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -15,4 +15,42 @@ test_expect_success 'colored blame colors contiguous lines' '
 	test_line_count = 3 H.expect
 '
 
+test_expect_success 'colored blame colors continuous fields' '
+
+	git mv hello.c world.c &&
+	git commit -a -m "moved file" &&
+	cat <<-EOF >> world.c &&
+	void world()
+	{
+		puts("world");
+	}
+	EOF
+	git add world.c &&
+	GIT_AUTHOR_NAME="F" GIT_AUTHOR_EMAIL="F@test.git" \
+		git commit -m "forgot to add changes to moved file" &&
+
+	git blame --abbrev=12 --color-fields world.c >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+
+	grep "<BOLD;BLACK>hello.c" actual > colored_hello.expect &&
+	grep "hello.c" actual > all_hello.expect &&
+	test_line_count = 9 colored_hello.expect &&
+	test_line_count = 10 all_hello.expect &&
+
+	grep "<BOLD;BLACK>world.c" actual > colored_world.expect &&
+	grep "world.c" actual > all_world.expect &&
+	test_line_count = 3 colored_world.expect &&
+	test_line_count = 4 all_world.expect &&
+
+	grep "(F" actual > all_F.expect &&
+	grep "<BOLD;BLACK>(F" actual > colored_F.expect &&
+	test_line_count = 8 all_F.expect &&
+	test_line_count = 5 colored_F.expect &&
+
+	grep "(H" actual > all_H.expect &&
+	grep "<BOLD;BLACK>(H" actual > colored_H.expect &&
+	test_line_count = 5 all_H.expect &&
+	test_line_count = 3 colored_H.expect
+'
+
 test_done
-- 
2.16.0.rc0.223.g4a4ac83678-goog

