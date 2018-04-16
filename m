Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 339891F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbeDPWKE (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:10:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42313 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752310AbeDPWKC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:10:02 -0400
Received: by mail-pf0-f193.google.com with SMTP id o16so11171798pfk.9
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sx78fKWp8VC5OGk2kGEUvLRfNEWV/VNKlDaGpxqu+wk=;
        b=CdbhVD97uCjV4tuBASlffNWlLsQqAZWxKcuccXE4tG+WMF3wfRsjJbjyWTRiAfYrTv
         MXvepzr1C0l8cO/6kONae8LCCmY4YDbU/aCPR//UfyK2TDVWXKMt6oPAxAMbnEfS8aOA
         LdRpxeWG2eXdO5JPalnsxbvGyclrLSioVWftndO6HdrpQiJ22OQ06wSwpkU9uqUuaujL
         jww5yIduTVUPM+VcdRKgmiu9Idf0C4uLUpqF33uqY11g2hVxsBNLMKQZxJYHssbvMeGe
         AmTlmWIdK+ldRUK9RzylIyFQ6z2ne/3yI7z7OyeM0O0SNJG6nUBnb34Hwu4W5wRJzQ6l
         JF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sx78fKWp8VC5OGk2kGEUvLRfNEWV/VNKlDaGpxqu+wk=;
        b=BDjiVvdPoh3u4g+eVZgtDh6eM3lyUfUN71w8khewekj2+49rKmSev4OzDZQrTM7HqK
         7OMZ0PjbniTfRhg5pG8/llhAnToTRjDKPZvCjs1lxbUuozsnETyDHEFaLXGVfvT4qGmD
         e7bhsxsXE79ukBdO5F5zT/vGlRhzssiJnt/oquQrF7Keytrkdt2ewSLUUJs1uNXZ8Rcg
         xZLjJU1BbteHJO9fxAfIgeOBW0mcKZmEq9fXm/Fesya7Ko4RkCIaIs7NT092EzK6uccJ
         c7rkd/rE/qvZUE39+C4mhuwgTvmwZdNAid7ioGT4QukVzDdtTC+HQzTIrg8kobUpazwB
         Ju3w==
X-Gm-Message-State: ALQs6tBwOdgZRV7oE/4AO2IpBlO/diZEv3E0uZX4e837AlvN4Mhor9qp
        N3J/NuuGfomPsKcxPNLy8HEVJQp1Q4U=
X-Google-Smtp-Source: AIpwx4+XF8o0I51CCl7CerrmqZaUxXbS3G43uPA3u5SmQTvn3F6bN9Y24OtHAh7PvmPLW9MqJKujtQ==
X-Received: by 10.99.110.198 with SMTP id j189mr14036583pgc.71.1523916601130;
        Mon, 16 Apr 2018 15:10:01 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id r23sm6393663pfh.33.2018.04.16.15.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 15:10:00 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] builtin/blame: highlight recently changed lines
Date:   Mon, 16 Apr 2018 15:09:55 -0700
Message-Id: <20180416220955.46163-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180416220955.46163-1-sbeller@google.com>
References: <20180416220955.46163-1-sbeller@google.com>
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
 Documentation/config.txt | 18 ++++++++++
 builtin/blame.c          | 78 +++++++++++++++++++++++++++++++++++++++-
 t/t8012-blame-colors.sh  | 25 +++++++++++++
 3 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a223232263..acc456e1fd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1223,6 +1223,24 @@ color.blame.repeatedMeta::
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
index b49fee70a9..9b1021f10d 100644
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
 #define OUTPUT_LINE_PORCELAIN 	01000
 #define OUTPUT_COLOR_LINE	02000
+#define OUTPUT_HEATED_LINES	04000
 
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
+static void setup_default_colors_heated_lines(void)
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
@@ -384,6 +443,12 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
 
 	cp = blame_nth_line(sb, ent->lno);
+
+	if (opt & OUTPUT_HEATED_LINES) {
+		determine_line_heat(ent, &color);
+		reset = GIT_COLOR_RESET;
+	}
+
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
 		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
@@ -451,7 +516,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			       max_digits, ent->lno + 1 + cnt);
 		}
 		if (!(opt & OUTPUT_ANNOTATE_COMPAT) &&
-		    (opt & OUTPUT_COLOR_LINE))
+		    (opt & (OUTPUT_COLOR_LINE | OUTPUT_HEATED_LINES)))
 			fputs(reset, stdout);
 		do {
 			ch = *cp++;
@@ -636,6 +701,11 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		*output_option |= OUTPUT_COLOR_LINE;
 		return 0;
 	}
+	if (!strcmp(var, "color.blame.highlightrecent")) {
+		parse_color_fields(value);
+		*output_option |= OUTPUT_HEATED_LINES;
+		return 0;
+	}
 
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
@@ -720,6 +790,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
+		OPT_BIT(0, "heated-lines", &output_option, N_("color lines by age"), OUTPUT_HEATED_LINES),
 
 		/*
 		 * The following two options are parsed by parse_revision_opt()
@@ -744,6 +815,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	unsigned int range_i;
 	long anchor;
 
+	setup_default_colors_heated_lines();
 	git_config(git_blame_config, &output_option);
 	init_revisions(&revs, NULL);
 	revs.date_mode = blame_date_mode;
@@ -779,6 +851,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	revs.diffopt.flags.follow_renames = 0;
 	argc = parse_options_end(&ctx);
 
+	if ((output_option & OUTPUT_COLOR_LINE) &&
+	    (output_option & OUTPUT_HEATED_LINES))
+		die(_("cannot ask for colored lines and heated lines at the same time"));
+
 	if (incremental || (output_option & OUTPUT_PORCELAIN)) {
 		if (show_progress > 0)
 			die(_("--progress can't be used with --incremental or porcelain formats"));
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index bb0fe20e76..d6b2932bf8 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -26,4 +26,29 @@ test_expect_success 'colored blame colors contiguous lines via config' '
 	test_line_count = 3 H.expect
 '
 
+test_expect_success 'heated line coloring for old code' '
+	git blame --heated-lines hello.c >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	grep "<BLUE>" <actual >colored &&
+	test_line_count = 10 colored
+'
+
+test_expect_success 'heated line coloring' '
+	cat >>hello.c <<-EOF &&
+		void qfunc();
+	EOF
+	git add hello.c &&
+	GIT_AUTHOR_DATE="" git commit -m "new commit" &&
+
+	git blame --heated-lines hello.c >actual.raw &&
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

