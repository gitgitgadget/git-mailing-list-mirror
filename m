Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41E681F404
	for <e@80x24.org>; Tue, 17 Apr 2018 21:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbeDQVbG (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 17:31:06 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43428 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752762AbeDQVbA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 17:31:00 -0400
Received: by mail-pf0-f193.google.com with SMTP id j11so6215529pff.10
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 14:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zjLh7I5ynjTEmm11MzsdjAET2jgVp+vzoi+dwJDxXJc=;
        b=rOSJ2h8Blr9eQZ4fp2ibzYHazKyMowm3YReKZDwND9AVGBW2ep76DS0OsPzy+SCt7h
         hb1z7IKGDoX/okVYYhKKlrNHIrun87PbtcGdgYGB/nDuKvfACVVxjd2tawtol4XYiyB1
         ab9as/vX0KqkFomBAgVz4mOpM6Cyygg2aAGVDAwpcouY9YotS8mOig+yPv/N7KoLvdIg
         H/iaODH3pvbzyQtNTELe9MvP23d3hHfhvIJF6woFVffendGS/9E+4XzLb2octESF4YqK
         lMj0QaGJLxXQwawZN5ft/jdkpBnZ4liDej+xq1nrMG/B8C6PCVE9Uek8zk5W1VpbOl53
         PVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zjLh7I5ynjTEmm11MzsdjAET2jgVp+vzoi+dwJDxXJc=;
        b=HJM1jvcqRq3Q2kKzFWjJPxI91lcX7aay7Z6H3D6NWPGuMt2qYtGKHMytg3rUolih1m
         ZWFUdvjORyJL7BaZGmUVzVB32GVvLyxwiAfhWyAGuvAi9NNzRB7+xlaz3huq5NOndN3H
         rpWu//9BZGaF0qLr68B5KWICjD8eDBDNf/i8GnlZnUBUHR6s3uu7ZXeYTuYBYo0YIirA
         t3FqZLolowEB4GQKAA7boOyhPi6+Ue0FGvTDrPiqouc12AYmqG7HVSSYZ9kA85qIEPuv
         eOyUXg6xqfvvAl9SZeHG20pPe7jDvl7Xv3w0eFmroSCdcY4vGpOXZopGao/V/WR+kx7Z
         OPtA==
X-Gm-Message-State: ALQs6tDmJuQxXVBM+rBabzkmfkTUiCxT1/1S7F73zfP/uDCqDp5+c6dq
        bQBhEPbmYo5Rj1a4L1zrzT2rt64uXDQ=
X-Google-Smtp-Source: AIpwx4+Ce91boj1+U8H1yMgWi8/fRh7K/AgS/05iVDUNBuczSbp64IonGYhTVvyumn8ZuXNguY2MCA==
X-Received: by 10.101.96.141 with SMTP id t13mr3110647pgu.222.1524000659372;
        Tue, 17 Apr 2018 14:30:59 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y7sm3170152pfy.55.2018.04.17.14.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 14:30:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH 2/2] builtin/blame: highlight recently changed lines
Date:   Tue, 17 Apr 2018 14:30:49 -0700
Message-Id: <20180417213049.118995-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180417213049.118995-1-sbeller@google.com>
References: <CAGZ79kYjV6Wpzymx1phL7EC3BxdWr5gitCOdE6=fJFFnz4zYiA@mail.gmail.com>
 <20180417213049.118995-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Choose a different color for dates and imitate a 'temperature cool down'
depending upon age.

Originally I had planned to have the temperature cooldown dependent on
the age of the project or file for example, as that might scale better,
but that can be added on top of this commit, e.g. instead of giving a
date, you could imagine giving a percentage that would be the linearly
interpolated between now and the beginning of the file.

Signed-off-by: Stefan Beller <sbeller@google.com>

# Conflicts:
#	builtin/blame.c
---
 Documentation/config.txt | 17 +++++++++
 builtin/blame.c          | 81 ++++++++++++++++++++++++++++++++++++++--
 t/t8012-blame-colors.sh  | 25 +++++++++++++
 3 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8128eee4f9..eae88be662 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1223,6 +1223,23 @@ color.blame.repeatedMeta::
 	is repeated meta information per line (such as commit id,
 	author name, date and timezone). Defaults to cyan.
 
+color.blame.highlightRecent::
+	This can be used to color the metadata of a blame line depending
+	on age of the line.
++
+This setting should be set to a comma-separated list of color and date settings,
+starting and ending with a color, the dates should be set from oldest to newest.
+The metadata will be colored given the colors if the the line was introduced
+before the given timestamp, overwriting older timestamped colors.
++
+Instead of an absolute timestamp relative timestamps work as well, e.g.
+2.weeks.ago is valid to address anything older than 2 weeks.
++
+It defaults to "blue,12 month ago,white,1 month ago,red", which colors
+everything older than one year blue, recent changes between one month and
+one year old are kept white, and lines introduced within the last month are
+colored red.
+
 color.ui::
 	This variable determines the default value for variables such
 	as `color.diff` and `color.grep` that control the use of color
diff --git a/builtin/blame.c b/builtin/blame.c
index 5190ff5df3..53999df511 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -24,6 +24,7 @@
 #include "dir.h"
 #include "progress.h"
 #include "blame.h"
+#include "string-list.h"
 
 static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
 
@@ -323,6 +324,7 @@ static const char *format_time(timestamp_t time, const char *tz_str,
 #define OUTPUT_SHOW_EMAIL	0400
 #define OUTPUT_LINE_PORCELAIN	01000
 #define OUTPUT_COLOR_LINE	02000
+#define OUTPUT_SHOW_AGE_WITH_COLOR	04000
 
 static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
 {
@@ -370,6 +372,63 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 		putchar('\n');
 }
 
+static struct color_field {
+	timestamp_t hop;
+	char col[COLOR_MAXLEN];
+} *colorfield;
+static int colorfield_nr, colorfield_alloc;
+
+static void parse_color_fields(const char *s)
+{
+	struct string_list l = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	enum { EXPECT_DATE, EXPECT_COLOR } next = EXPECT_COLOR;
+
+	colorfield_nr = 0;
+
+	/* Ideally this would be stripped and split at the same time? */
+	string_list_split(&l, s, ',', -1);
+	ALLOC_GROW(colorfield, colorfield_nr + 1, colorfield_alloc);
+
+	for_each_string_list_item(item, &l) {
+		switch (next) {
+		case EXPECT_DATE:
+			colorfield[colorfield_nr].hop = approxidate(item->string);
+			next = EXPECT_COLOR;
+			colorfield_nr++;
+			ALLOC_GROW(colorfield, colorfield_nr + 1, colorfield_alloc);
+			break;
+		case EXPECT_COLOR:
+			if (color_parse(item->string, colorfield[colorfield_nr].col))
+				die(_("expecting a color: %s"), item->string);
+			next = EXPECT_DATE;
+			break;
+		}
+	}
+
+	if (next == EXPECT_COLOR)
+		die (_("must end with a color"));
+
+	colorfield[colorfield_nr].hop = TIME_MAX;
+}
+
+static void setup_default_color_by_age(void)
+{
+	parse_color_fields("blue,12 month ago,white,1 month ago,red");
+}
+
+static void determine_line_heat(struct blame_entry *ent, const char **dest_color)
+{
+	int i = 0;
+	struct commit_info ci;
+	get_commit_info(ent->suspect->commit, &ci, 1);
+
+	while (i < colorfield_nr && ci.author_time > colorfield[i].hop)
+		i++;
+
+	*dest_color = colorfield[i].col;
+}
+
 static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int opt)
 {
 	int cnt;
@@ -378,12 +437,19 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 	struct commit_info ci;
 	char hex[GIT_MAX_HEXSZ + 1];
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
-	const char *color = NULL, *reset = NULL;
+	const char *default_color = NULL, *color = NULL, *reset = NULL;
 
 	get_commit_info(suspect->commit, &ci, 1);
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
 
 	cp = blame_nth_line(sb, ent->lno);
+
+	if (opt & OUTPUT_SHOW_AGE_WITH_COLOR) {
+		determine_line_heat(ent, &default_color);
+		color = default_color;
+		reset = GIT_COLOR_RESET;
+	}
+
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
 		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
@@ -393,8 +459,8 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 				color = repeated_meta_color;
 				reset = GIT_COLOR_RESET;
 			} else  {
-				color = "";
-				reset = "";
+				color = default_color ? default_color : "";
+				reset = default_color ? GIT_COLOR_RESET : "";
 			}
 		}
 		if (color)
@@ -634,6 +700,11 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		*output_option |= OUTPUT_COLOR_LINE;
 		return 0;
 	}
+	if (!strcmp(var, "color.blame.highlightrecent")) {
+		parse_color_fields(value);
+		*output_option |= OUTPUT_SHOW_AGE_WITH_COLOR;
+		return 0;
+	}
 
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
@@ -718,6 +789,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
+		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
 
 		/*
 		 * The following two options are parsed by parse_revision_opt()
@@ -742,6 +814,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	unsigned int range_i;
 	long anchor;
 
+	setup_default_color_by_age();
 	git_config(git_blame_config, &output_option);
 	init_revisions(&revs, NULL);
 	revs.date_mode = blame_date_mode;
@@ -984,7 +1057,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			strcpy(repeated_meta_color, GIT_COLOR_CYAN);
 	}
 	if (output_option & OUTPUT_ANNOTATE_COMPAT)
-		output_option &= ~OUTPUT_COLOR_LINE;
+		output_option &= ~(OUTPUT_COLOR_LINE | OUTPUT_SHOW_AGE_WITH_COLOR);
 
 	output(&sb, output_option);
 	free((void *)sb.final_buf);
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index 9fc32ff813..6f6be6c5dc 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -26,4 +26,29 @@ test_expect_success 'colored blame colors contiguous lines via config' '
 	test_line_count = 3 H.expect
 '
 
+test_expect_success 'color by age consistently colors old code' '
+	git blame --color-by-age hello.c >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	grep "<BLUE>" <actual >colored &&
+	test_line_count = 10 colored
+'
+
+test_expect_success 'blame color by age: new code is different' '
+	cat >>hello.c <<-EOF &&
+		void qfunc();
+	EOF
+	git add hello.c &&
+	GIT_AUTHOR_DATE="" git commit -m "new commit" &&
+
+	git blame --color-by-age hello.c >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+
+	grep "<BLUE>" <actual >colored &&
+	test_line_count = 10 colored &&
+
+	grep "<RED>" <actual >colored &&
+	test_line_count = 1 colored &&
+	grep qfunc colored
+'
+
 test_done
-- 
2.17.0.484.g0c8726318c-goog

