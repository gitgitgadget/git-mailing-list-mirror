Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9C820756
	for <e@80x24.org>; Thu, 19 Jan 2017 11:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752422AbdASLl4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 06:41:56 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34607 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbdASLlv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 06:41:51 -0500
Received: by mail-pf0-f193.google.com with SMTP id y143so3227303pfb.1
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 03:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ApidoFRcK1soTTgomwLOdIUhVXyEWzyEh+jMkpqJVw=;
        b=lU/LuXfdLIVrZFeySTELHoGvc0/iD8shHOHpi5Wmc9nGWmB6RhD2weSH8ivYgRK7sQ
         qW1FQfOrqdZ737iX5n5CMw6c6VJDDqocsjFLs7Jo9qi1/5/U4N+kGpqmmRXUUD124Ana
         3O7ObK0AL79gHQc10xPpTIXyrM++hAMKAbzK63wEfVgB+iZIbjfsEyNZaZHvEEbZUDyv
         lwaYBOLVaM0PTz8zME38YxPi13zdW2Ex9jQ7ygAKKXH7QXr0bEOd/huUwJMYP95JzJ3O
         0XVhMJQMHQEvTswPB9Ok64fq9MbK0mgHshKnLcStds/aYoTwP76ABhCJl1vmJ99s+spA
         V78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ApidoFRcK1soTTgomwLOdIUhVXyEWzyEh+jMkpqJVw=;
        b=g0NRJR+GWerKv9chvTs0eWKsCq7laQxd2tCOulRZgangHuPKrHAHO/vxP7adY9tfph
         jH7dfDu3SSofQyrdaosAAnOe2zDAzpukj2aa1vt1khgSGOAQ/vgpnHF1prF2CyJdcgL/
         PK1M6UOtbGrOL35NR0CGOBMi4WMHRcfqPjwzpd1LaHUPIkxuqsz1x3DaADEbnnbAYi9o
         sfmFnlxFd9RjRj1au7zBZGujq6pnPRBHDMLheQOSL+25y9baIYn07wTbORa9hr0F2JtN
         4PDCKVAmFrcaqax3StqaLlb79ApOAd5IV5TifEBmQi6yNyr/Je7QfKMpHF0TiZ5ZfnCl
         v8Nw==
X-Gm-Message-State: AIkVDXK1+jvdkATSz4ZZODxQluKFg/2AH5/4V2/dUCGGThw33X9WnUoL5UAR8G1k0wi5OA==
X-Received: by 10.99.229.17 with SMTP id r17mr9840516pgh.81.1484826110856;
        Thu, 19 Jan 2017 03:41:50 -0800 (PST)
Received: from ash ([115.72.179.24])
        by smtp.gmail.com with ESMTPSA id o24sm8129310pfj.78.2017.01.19.03.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jan 2017 03:41:50 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 19 Jan 2017 18:41:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 3/3] log --graph: customize the graph lines with config log.graphColors
Date:   Thu, 19 Jan 2017 18:41:23 +0700
Message-Id: <20170119114123.23784-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20170119114123.23784-1-pclouds@gmail.com>
References: <20170109103258.25341-1-pclouds@gmail.com>
 <20170119114123.23784-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you have a 256 colors terminal (or one with true color support), then
the predefined 12 colors seem limited. On the other hand, you don't want
to draw graph lines with every single color in this mode because the two
colors could look extremely similar. This option allows you to hand pick
the colors you want.

Even with standard terminal, if your background color is neither black
or white, then the graph line may match your background and become
hidden. You can exclude your background color (or simply the colors you
hate) with this.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt |  4 ++++
 graph.c                  | 42 +++++++++++++++++++++++++++++++++++++++---
 t/t4202-log.sh           | 22 ++++++++++++++++++++++
 3 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0bcb679..33a007b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2003,6 +2003,10 @@ log.follow::
 	i.e. it cannot be used to follow multiple files and does not work well
 	on non-linear history.
 
+log.graphColors::
+	A list of colors, separated by commas, that can be used to draw
+	history lines in `git log --graph`.
+
 log.showRoot::
 	If true, the initial commit will be shown as a big creation event.
 	This is equivalent to a diff against an empty tree.
diff --git a/graph.c b/graph.c
index dd17201..822d40a 100644
--- a/graph.c
+++ b/graph.c
@@ -4,6 +4,7 @@
 #include "graph.h"
 #include "diff.h"
 #include "revision.h"
+#include "argv-array.h"
 
 /* Internal API */
 
@@ -62,6 +63,26 @@ enum graph_state {
 static const char **column_colors;
 static unsigned short column_colors_max;
 
+static void parse_graph_colors_config(struct argv_array *colors, const char *string)
+{
+	const char *end, *start;
+
+	start = string;
+	end = string + strlen(string);
+	while (start < end) {
+		const char *comma = strchrnul(start, ',');
+		char color[COLOR_MAXLEN];
+
+		if (!color_parse_mem(start, comma - start, color))
+			argv_array_push(colors, color);
+		else
+			warning(_("ignore invalid color '%.*s' in log.graphColors"),
+				(int)(comma - start), start);
+		start = comma + 1;
+	}
+	argv_array_push(colors, GIT_COLOR_RESET);
+}
+
 void graph_set_column_colors(const char **colors, unsigned short colors_max)
 {
 	column_colors = colors;
@@ -207,9 +228,24 @@ struct git_graph *graph_init(struct rev_info *opt)
 {
 	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
 
-	if (!column_colors)
-		graph_set_column_colors(column_colors_ansi,
-					column_colors_ansi_max);
+	if (!column_colors) {
+		struct argv_array ansi_colors = {
+			column_colors_ansi,
+			column_colors_ansi_max + 1
+		};
+		struct argv_array *colors = &ansi_colors;
+		char *string;
+
+		if (!git_config_get_string("log.graphcolors", &string)) {
+			static struct argv_array custom_colors = ARGV_ARRAY_INIT;
+			argv_array_clear(&custom_colors);
+			parse_graph_colors_config(&custom_colors, string);
+			free(string);
+			colors = &custom_colors;
+		}
+		/* graph_set_column_colors takes a max-index, not a count */
+		graph_set_column_colors(colors->argv, colors->argc - 1);
+	}
 
 	graph->commit = NULL;
 	graph->revs = opt;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index e2db47c..0aeabed 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -313,6 +313,28 @@ test_expect_success 'log --graph with merge' '
 	test_cmp expect actual
 '
 
+cat > expect.colors <<\EOF
+*   Merge branch 'side'
+<BLUE>|<RESET><CYAN>\<RESET>
+<BLUE>|<RESET> * side-2
+<BLUE>|<RESET> * side-1
+* <CYAN>|<RESET> Second
+* <CYAN>|<RESET> sixth
+* <CYAN>|<RESET> fifth
+* <CYAN>|<RESET> fourth
+<CYAN>|<RESET><CYAN>/<RESET>
+* third
+* second
+* initial
+EOF
+
+test_expect_success 'log --graph with merge with log.graphColors' '
+	test_config log.graphColors ",, blue,invalid-color, cyan, red  , " &&
+	git log --color=always --graph --date-order --pretty=tformat:%s |
+		test_decode_color | sed "s/ *\$//" >actual &&
+	test_cmp expect.colors actual
+'
+
 test_expect_success 'log --raw --graph -m with merge' '
 	git log --raw --graph --oneline -m master | head -n 500 >actual &&
 	grep "initial" actual
-- 
2.8.2.524.g6ff3d78

