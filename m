Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B8A71F406
	for <e@80x24.org>; Thu, 28 Dec 2017 21:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754813AbdL1VEG (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 16:04:06 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:39009 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754759AbdL1VEE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 16:04:04 -0500
Received: by mail-io0-f177.google.com with SMTP id g70so26899220ioj.6
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 13:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MeM834fXIpUE7/6HY4DZ/5glLaEXrzGsOkWgTPNerZw=;
        b=Hn9s7bMvZBUh74eccjm+pgdU1SMNTCAJH07cJBgT7TgZ8VWtfyGJePck5spE+mLd/w
         CA8+vRw1xhNTO1X2BtUnYCA5cAI5eR5MLFEdsICRdQ3daev+vYjvz6TWk9Biwz02TCBC
         LxpX9EYW89MFK7JI0K2Tt/BWhEQR3P0hribBpf9WqBUQc3xV1wkrff5yMVh0nJHzKgfF
         m5ptA2s68dcq7f43hde2kraPqO2QogEUlKGghYZa4M//rpZxbp0E+RSxdvzHe/JhRsrX
         hAQez840Afjq6Ux3OVE4rd4mzJARpiQ3s9rgjVkbTK+CBIl6Yd5mT4VTlkketOpAQY5W
         GLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MeM834fXIpUE7/6HY4DZ/5glLaEXrzGsOkWgTPNerZw=;
        b=qusAINTmkCyCaKeAIx/KmcwgScQYPLS8e4q54UFXq214lAonDAXJH+0oEcFHLMEy6L
         DLLGDWQJ/zH/IMnLphRMsDwavTyowhQXl8f4mrSK9m+GOyNr8hVEOiTv/JTVHPwxWRzW
         yGCO4IwYXiEB5tQlBQLLKIh32qP3TXlQWcbKo8wQ2zANkDkoM4T6UJH5X8jRZcxe63fb
         0LLXNm7KCRQYQPxZKlFmBf0fuJtYT2MLmT9g/rXeQ4797xFqoUnmKWIqteBWua53MsnH
         ooX3ntsBoExhi5TkGKzknLLIYI09kuqncRbnc8dq2FehoqgUV4BGnJ6mBEEtocNx6qQw
         sQvA==
X-Gm-Message-State: AKGB3mJHPvQmkXVAK9ulfOSIJk+28j1v/sY9SKL1wNkr2u3qK4Q7Ievl
        niuq8OOz1dNkp9SWDo0kojUGmbRO1WY=
X-Google-Smtp-Source: ACJfBos2w2fVT/AL+nKc1YxwbdClbZvfy1o8/7/ub/fPh7RB3j1wB6/fAcKS0/kgiJNx+58KKO6+Cg==
X-Received: by 10.107.183.5 with SMTP id h5mr36519478iof.25.1514495043327;
        Thu, 28 Dec 2017 13:04:03 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id k23sm12350687iti.22.2017.12.28.13.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2017 13:04:02 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] builtin/blame: highlight recently changed lines
Date:   Thu, 28 Dec 2017 13:03:45 -0800
Message-Id: <20171228210345.205300-5-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171228210345.205300-1-sbeller@google.com>
References: <20171228210345.205300-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Choose a different color for dates and imitate a 'temperature cool down'
for the dates.

Originally I had planned to have the temperature cooldown dependent on
the age of the project or file for example, as that might scale better,
but that can be added on top of this commit, e.g. instead of giving a
date, you could imagine giving a percentage that would be the linearly
interpolated between now and the beginning of the file.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt | 18 ++++++++++++
 builtin/blame.c          | 74 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2c211b6e7d..52f27b2ced 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1221,6 +1221,24 @@ color.blame.repeatedMeta::
 	is repeated meta information per line (such as commit id,
 	author name, date and timezone). Defaults to dark gray.
 
+color.blame.highlightRecent::
+	This can be used to color the author and date of a blame line.
+	This overrides `color.blame.repeatedMeta` setting, which colors
+	repetitions.
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
index 39e8c0b222..b23e98e2ac 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -24,6 +24,7 @@
 #include "dir.h"
 #include "progress.h"
 #include "blame.h"
+#include "string-list.h"
 
 static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
 
@@ -324,6 +325,7 @@ static const char *format_time(timestamp_t time, const char *tz_str,
 #define OUTPUT_LINE_PORCELAIN 	01000
 #define OUTPUT_COLOR_LINE	02000
 #define OUTPUT_COLOR_FIELDS	04000
+#define OUTPUT_HEATED_LINES	010000
 
 static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
 {
@@ -436,6 +438,61 @@ static void setup_line_color(int opt, int cnt,
 		colors_set(use_color, reset_color);
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
+static void setup_default_colorfield(void)
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
 static void emit_other(struct blame_scoreboard *sb,
 		       struct blame_entry *ent,
 		       struct blame_entry *prev,
@@ -443,6 +500,7 @@ static void emit_other(struct blame_scoreboard *sb,
 {
 	int cnt;
 	const char *cp;
+	const char *heatcolor = NULL;
 	struct blame_origin *suspect = ent->suspect;
 	struct commit_info ci;
 	char hex[GIT_MAX_HEXSZ + 1];
@@ -452,6 +510,10 @@ static void emit_other(struct blame_scoreboard *sb,
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
 
 	cp = blame_nth_line(sb, ent->lno);
+
+	if (opt & OUTPUT_HEATED_LINES)
+		determine_line_heat(ent, &heatcolor);
+
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
 		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
@@ -503,6 +565,7 @@ static void emit_other(struct blame_scoreboard *sb,
 			if (!(opt & OUTPUT_NO_AUTHOR)) {
 				const char *name;
 				int pad;
+				int hcolor = opt & OUTPUT_HEATED_LINES;
 				if (opt & OUTPUT_SHOW_EMAIL)
 					name = ci.author_mail.buf;
 				else
@@ -510,7 +573,10 @@ static void emit_other(struct blame_scoreboard *sb,
 				pad = longest_author - utf8_strwidth(name);
 				setup_field_color(opt, cnt, OUTPUT_NO_AUTHOR,
 						  ent, prev, &col, &rcol);
-				printf(" %s(%s%*s %10s%s", col,
+				if (hcolor)
+					rcol = GIT_COLOR_RESET;
+				printf(" %s(%s%*s %10s%s",
+				       hcolor ? heatcolor : col,
 				       name, pad, "",
 				       format_time(ci.author_time,
 						   ci.author_tz.buf,
@@ -701,6 +767,10 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 				value);
 		return 0;
 	}
+	if (!strcmp(var, "color.blame.highlightrecent")) {
+		parse_color_fields(value);
+		return 0;
+	}
 
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
@@ -777,6 +847,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line"), OUTPUT_COLOR_LINE),
 		OPT_BIT(0, "color-fields", &output_option, N_("color redundant metadata fields from previous line"), OUTPUT_COLOR_FIELDS),
+		OPT_BIT(0, "heated-lines", &output_option, N_("color lines by date"), OUTPUT_HEATED_LINES),
 
 		/*
 		 * The following two options are parsed by parse_revision_opt()
@@ -801,6 +872,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	unsigned int range_i;
 	long anchor;
 
+	setup_default_colorfield();
 	git_config(git_blame_config, &output_option);
 	init_revisions(&revs, NULL);
 	revs.date_mode = blame_date_mode;
-- 
2.15.1.620.gb9897f4670-goog

