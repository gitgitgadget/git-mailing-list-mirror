Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45E661F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeADWkU (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:40:20 -0500
Received: from mail-pl0-f51.google.com ([209.85.160.51]:41151 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeADWkR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:40:17 -0500
Received: by mail-pl0-f51.google.com with SMTP id g2so1888566pli.8
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 14:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qmT86JjI37dDEvnOvt935Y8cNiMz/xY9HktaM9n/vCc=;
        b=cmrt0m5vEq0hvniQ7zEf1W4P5HgJW/FcU0esjIVGA0AdT82CpIH5t2FVCPtqwbmmWb
         aArKn8wfsg9n5KpnN7RE32qm0sDPKLyvagnP3OCAmbU/9h8jGiUyPDtmnt5BmbYmUGd3
         a9F43xewsrQ3SoGKIQqkNwdtkl/zHZXCAQBdsPluq2C6/EmuGn/thSDgk5MSibN+2wkV
         ENOhKqSZE9VuYGRKd3RL/9lmm9hpV0YUhGQ3W9EQT82f+RD7tVBxwFFB5jE5wMn5x8Vk
         uAk99tRVpTyWCFk9AiIrbSBTCyvE7mFCoKmDASNxo3L56Sw4jO7NO3IyXgI2gBagR/Ja
         OtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qmT86JjI37dDEvnOvt935Y8cNiMz/xY9HktaM9n/vCc=;
        b=JufkEx/h9vm8JlsdKIdww2Oz7Bp/gjBMdAOV73rQSj3qTkm4V/oGDVx5GMtwjV6kTr
         XxwwZjkMvBbNu6IDb2PnrTZyhR4Gqs/jXgMs6cdx6Sih9hLXOK3rpWtZyhO89lkVA/jZ
         69br6loLwU0gsEdp0mTP7XdImYR2KFYKMhT+/BTcdzPcTAE1dT/R4vF2XHFM/NiFJ18n
         rEXO3vPIJWuFO7nNY43HzEOHV+Cu9Ibc3vu3w/95FrBYRErrh1ZJGc391TWIjRbxoSu5
         LBVbopV7xjEGOOh2lkTDNi9ovpzhXaqgpQ2EgOy7QVfYMStg2G7g1lJPiS2S06P7LLqX
         KkKA==
X-Gm-Message-State: AKGB3mJVFAImpAvwryYWpmGoABmAnAI0jaT1VZiiB7lC7b4mVN/awjzq
        FDNC2kGrsddUYK7WHH972iYvbg==
X-Google-Smtp-Source: ACJfBovDV8eM8feqDrvw5LZLYObh6yB53QdKV9kuLbNt1JIwwNa814umKXz5scxT2DTl5u2s+YabWA==
X-Received: by 10.84.248.135 with SMTP id q7mr951996pll.159.1515105616637;
        Thu, 04 Jan 2018 14:40:16 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id q22sm11147145pfj.94.2018.01.04.14.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jan 2018 14:40:16 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, sunshine@sunshineco.com
Cc:     git@vger.kernel.org
Subject: [PATCHv3 4/4] builtin/blame: highlight recently changed lines
Date:   Thu,  4 Jan 2018 14:40:07 -0800
Message-Id: <20180104224007.214548-5-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac83678-goog
In-Reply-To: <20180104224007.214548-1-sbeller@google.com>
References: <20171110011002.10179-1-sbeller@google.com>
 <20180104224007.214548-1-sbeller@google.com>
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
---
 Documentation/config.txt | 18 ++++++++++++
 builtin/blame.c          | 74 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 45749a574d..aa967ce3ed 100644
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
index 60c8dadf4b..3d444e66b3 100644
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
@@ -417,6 +419,61 @@ static void setup_field_color(int opt, int cnt, int field,
 	}
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
@@ -424,6 +481,7 @@ static void emit_other(struct blame_scoreboard *sb,
 {
 	int cnt;
 	const char *cp;
+	const char *heatcolor = NULL;
 	struct blame_origin *suspect = ent->suspect;
 	struct commit_info ci;
 	char hex[GIT_MAX_HEXSZ + 1];
@@ -433,6 +491,10 @@ static void emit_other(struct blame_scoreboard *sb,
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
 
 	cp = blame_nth_line(sb, ent->lno);
+
+	if (opt & OUTPUT_HEATED_LINES)
+		determine_line_heat(ent, &heatcolor);
+
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
 		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
@@ -488,6 +550,7 @@ static void emit_other(struct blame_scoreboard *sb,
 			if (!(opt & OUTPUT_NO_AUTHOR)) {
 				const char *name;
 				int pad;
+				int hcolor = opt & OUTPUT_HEATED_LINES;
 				if (opt & OUTPUT_SHOW_EMAIL)
 					name = ci.author_mail.buf;
 				else
@@ -495,7 +558,10 @@ static void emit_other(struct blame_scoreboard *sb,
 				pad = longest_author - utf8_strwidth(name);
 				setup_field_color(opt, cnt, OUTPUT_NO_AUTHOR,
 						  ent, prev, &color, &reset);
-				printf(" %s(%s%*s %10s%s", color,
+				if (hcolor)
+					reset = GIT_COLOR_RESET;
+				printf(" %s(%s%*s %10s%s",
+				       hcolor ? heatcolor : color,
 				       name, pad, "",
 				       format_time(ci.author_time,
 						   ci.author_tz.buf,
@@ -686,6 +752,10 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 				value);
 		return 0;
 	}
+	if (!strcmp(var, "color.blame.highlightrecent")) {
+		parse_color_fields(value);
+		return 0;
+	}
 
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
@@ -762,6 +832,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
 		OPT_BIT(0, "color-fields", &output_option, N_("color redundant metadata fields from previous line differently"), OUTPUT_COLOR_FIELDS),
+		OPT_BIT(0, "heated-lines", &output_option, N_("color lines by age"), OUTPUT_HEATED_LINES),
 
 		/*
 		 * The following two options are parsed by parse_revision_opt()
@@ -786,6 +857,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	unsigned int range_i;
 	long anchor;
 
+	setup_default_colorfield();
 	git_config(git_blame_config, &output_option);
 	init_revisions(&revs, NULL);
 	revs.date_mode = blame_date_mode;
-- 
2.16.0.rc0.223.g4a4ac83678-goog

