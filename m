Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC074201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 01:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755505AbdKJBKV (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 20:10:21 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:53111 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755342AbdKJBKR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 20:10:17 -0500
Received: by mail-it0-f66.google.com with SMTP id j140so12998982itj.1
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 17:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u6BzD/7rGGr4GCIsC/pkn3vHCFCtiDWsG7Ua+hZ44Qw=;
        b=ctSotBhrisI4C2TTnMmYj7clnfAQjQjQhBYObJviLKPeFS1RuNGJe0OX1dF1fJOsuZ
         UNxBiipVJiJEKvbiDwHfSaDOwaxH7dVFXhU4X9+AbHg3W4d1W5AphHnwAKub6PP12NqA
         gAPw+6T/vbisxipXWbXyYYULLh4tplwtqELWPtJ1KmlVjD+y8Qn8CGy0zljHyyblG9jY
         aAjxd7xDGcC+Pxalhl9NCvxhJqcj0yN6Y+XXOuetM/IRb2aDp4pp5jCrmlN7KEjnMFs0
         vSTZzgfjjn88GAUpg0Lt9xZrcrTYi7KB5p51Nw3hheLThAydwC1NwOVAXqMwX+IttcJK
         PYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u6BzD/7rGGr4GCIsC/pkn3vHCFCtiDWsG7Ua+hZ44Qw=;
        b=a8gKeG9MdIrMtTfosA83wkOCg3EVopqrgnqatHNWy9qPo84vSJGg0DzhrAbjcHbV3W
         qN/JtXr1EguDFqeBKcgav//LjfwXpBcQQgcXoNcPaT93AnEC5e+bQAFD96PzSrBqv6Mi
         RqeenTzFozmGpADZmsy2/Lv0SOBLiqG8HauXV9JRsRkoCmuSXAQM1PuTdQ+mrfgnWoHx
         ptihA2vmDs0gccYboghSz9cxrcWtxAf0RlP5eRpJXnOdD2t9oF1w1NJfZu4acjN2B6om
         BtfdROu8tk1y7ustQPXnY78A5cI4DMbdGS6DbG9Th/Y2eK37vItg+D0eQKnqGBOZK93b
         I94Q==
X-Gm-Message-State: AJaThX5//GyJET0VRfRrydQ3OMrJp3bDqRxuSQ4VKtpWosVe5br5gHCs
        RcGVPhKiflZVz7WYn3BoHmk5+C1CZXI=
X-Google-Smtp-Source: AGs4zMZ31kSQVtsJcALkE9ojSyNm8nzn8dTkYmsPaqB+nOXfwVXDwbdxI1whRbOSxpRjYkoKcY9BRQ==
X-Received: by 10.36.122.1 with SMTP id a1mr2470830itc.30.1510276215411;
        Thu, 09 Nov 2017 17:10:15 -0800 (PST)
Received: from localhost ([2620:0:100e:422:3816:f49a:2bf0:e33c])
        by smtp.gmail.com with ESMTPSA id z133sm154476itb.10.2017.11.09.17.10.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Nov 2017 17:10:14 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] builtin/blame: highlight recently changed lines
Date:   Thu,  9 Nov 2017 17:10:02 -0800
Message-Id: <20171110011002.10179-5-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171110011002.10179-1-sbeller@google.com>
References: <20171110011002.10179-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Choose a different color for dates and imitate a 'temperature cool down'
for the dates.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt | 20 +++++++++++++
 builtin/blame.c          | 74 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 85dfdc6a9b..7d2efc5ad6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1194,6 +1194,26 @@ color.blame.repeatedMeta::
 	is repeated meta information per line (such as commit id,
 	author name, date and timezone). Defaults to dark gray.
 
+color.blame.highlightRecent::
+	This can be used to color the author and date of a blame line.
+	This overrides `color.blame.repeatedMeta` setting, which colors
+	repetitions.
++
+	This setting should be set to a comma-separated list of
+	color and date settings, starting and ending with a color, the dates
+	should be set from oldest to newest.
+	The metadata will be colored given the colors if the the line was
+	introduced before the given timestamp, overwriting older timestamped
+	colors.
++
+	Instead of an absolute timestamp relative timestamps work as
+	well, e.g. 2.weeks.ago is valid to address anything older than 2 weeks.
++
+	It defaults to "blue,12 month ago,white,1 month ago,red",
+	which colors everything older than one year blue, recent changes between
+	one month and one year old are kept white, and lines introduced within
+	the last month are colored red.
+
 color.ui::
 	This variable determines the default value for variables such
 	as `color.diff` and `color.grep` that control the use of color
diff --git a/builtin/blame.c b/builtin/blame.c
index 9d460597a2..e157ee3864 100644
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
2.15.0.128.gcadd42da22

