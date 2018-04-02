Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F6341F404
	for <e@80x24.org>; Mon,  2 Apr 2018 22:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754757AbeDBWtP (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 18:49:15 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40032 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754709AbeDBWtN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 18:49:13 -0400
Received: by mail-pl0-f67.google.com with SMTP id x4-v6so6119482pln.7
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 15:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pPWo7PySWQ2NZhJlJZ0qtGgr9PtEwWXlgIC6XTDtzjs=;
        b=u+7msZ81lkmyQbe5+1WrvvyBAboKHWQtFb9ez2oGzRfRHwL7j+Wxhd+nlvQ+LmAPiH
         M0nKiuZxjyQxlZfi1RMkFzSGzy/O819shb3Gj1nF73VQPi2lHMwznCRdgjrdBD0VdzAl
         +5c/sRI9lcEopo7015350pe1L2aIUwoqdtuVKekJ+xtbrqar04AFYR3pKJzr8d7dzGfS
         FYXfSzhvGJ7jzs5E3fKQ4wTs4pw6twNgyFGHsOILQvFyFhRsN3dfrxw66eckkRw66nxR
         YUWCyONPg5LhaTLNudb5VIIPoDG/NSWYlABKwic9bWxkqZOK8yCPhHYHuHMy/Sk5EA2t
         0UXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pPWo7PySWQ2NZhJlJZ0qtGgr9PtEwWXlgIC6XTDtzjs=;
        b=NRI5AyFi0lHjwfncpuah1q6MsIULDn4ZV/WD9puHArUzwUkb6uhsMXbRFKHNGy2cEu
         O+m70OgPJ/4DVnOi9f5DL0pu5/4XuNL9dzHVlMgIbIwASJuoZXTJWGIVt2/Lhagb6o0n
         8xESBLGukR9IwBp767SMoUH/+pmS6BGmvwXkjOJ18ZXVEqAtg2aBA4EfzrBl7qFbTJX9
         R1BO/vawOykdKzyABcpGot9dqfEmMNgnrAuVhIzM2V/fkvIPsWlNcI6K+bq0wxwR0lE+
         7fpjouqF1/ASqyzYphgMi95UpzKpZP5PEcDOTofkDgm2GDIB50oU5/UbcSqHMW5VXXms
         A/Jg==
X-Gm-Message-State: AElRT7G6CKz5uYJUXPo4D5VW8f57NR1hKyC03rl9gPjiWa51M6AP2F/o
        Wcniq9//F3WDIu5ac6SgBGAssg==
X-Google-Smtp-Source: AIpwx4+yyVsAk9HRKxT8F/bA8v72+ByQ8f6QUtB/d7Tm0I01sRRWl9zXVUF23zKpPt3wFV9Rdmy0TA==
X-Received: by 10.99.112.17 with SMTP id l17mr7405747pgc.281.1522709352195;
        Mon, 02 Apr 2018 15:49:12 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id f6sm1805720pgo.54.2018.04.02.15.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 15:49:11 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com, jacob.keller@gmail.com,
        simon@ruderich.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/7] diff.c: refactor internal representation for coloring moved code
Date:   Mon,  2 Apr 2018 15:48:52 -0700
Message-Id: <20180402224854.86922-6-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180402224854.86922-1-sbeller@google.com>
References: <20180402224854.86922-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the time the move coloring was implemented we thought an enum of modes
is the best to configure this feature.  However as we want to tack on new
features, the enum would grow exponentially.

Refactor the code such that features are enabled via bits. Currently we can
* activate the move detection,
* enable the block detection on top, and
* enable the dimming inside a block, though this could be done without
  block detection as well (mode "plain, dimmed")

Choose the flags to not be at bit position 2,3,4 as the next patch
will occupy these.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 27 ++++++++++++++-------------
 diff.h | 17 ++++++++++-------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/diff.c b/diff.c
index 879b8a5d9d..2052a43f7a 100644
--- a/diff.c
+++ b/diff.c
@@ -260,7 +260,7 @@ static int parse_color_moved(const char *arg)
 {
 	switch (git_parse_maybe_bool(arg)) {
 	case 0:
-		return COLOR_MOVED_NO;
+		return 0;
 	case 1:
 		return COLOR_MOVED_DEFAULT;
 	default:
@@ -268,15 +268,17 @@ static int parse_color_moved(const char *arg)
 	}
 
 	if (!strcmp(arg, "no"))
-		return COLOR_MOVED_NO;
+		return 0;
 	else if (!strcmp(arg, "plain"))
-		return COLOR_MOVED_PLAIN;
+		return COLOR_MOVED_ENABLED;
 	else if (!strcmp(arg, "zebra"))
-		return COLOR_MOVED_ZEBRA;
+		return COLOR_MOVED_ENABLED | COLOR_MOVED_FIND_BLOCKS;
 	else if (!strcmp(arg, "default"))
 		return COLOR_MOVED_DEFAULT;
 	else if (!strcmp(arg, "dimmed_zebra"))
-		return COLOR_MOVED_ZEBRA_DIM;
+		return COLOR_MOVED_ENABLED |
+		       COLOR_MOVED_FIND_BLOCKS |
+		       COLOR_MOVED_DIMMED_BLOCKS;
 	else
 		return error(_("color moved setting must be one of 'no', 'default', 'zebra', 'dimmed_zebra', 'plain'"));
 }
@@ -794,7 +796,7 @@ static int shrink_potential_moved_blocks(struct moved_entry **pmb,
 }
 
 /*
- * If o->color_moved is COLOR_MOVED_PLAIN, this function does nothing.
+ * If o->color_moved is not set to find blocks, this function does nothing.
  *
  * Otherwise, if the last block has fewer alphanumeric characters than
  * COLOR_MOVED_MIN_ALNUM_COUNT, unset DIFF_SYMBOL_MOVED_LINE on all lines in
@@ -809,7 +811,7 @@ static int shrink_potential_moved_blocks(struct moved_entry **pmb,
 static void adjust_last_block(struct diff_options *o, int n, int block_length)
 {
 	int i, alnum_count = 0;
-	if (o->color_moved == COLOR_MOVED_PLAIN)
+	if (!(o->color_moved & COLOR_MOVED_FIND_BLOCKS))
 		return;
 	for (i = 1; i < block_length + 1; i++) {
 		const char *c = o->emitted_symbols->buf[n - i].line;
@@ -868,7 +870,7 @@ static void mark_color_as_moved(struct diff_options *o,
 
 		l->flags |= DIFF_SYMBOL_MOVED_LINE;
 
-		if (o->color_moved == COLOR_MOVED_PLAIN)
+		if (!(o->color_moved & COLOR_MOVED_FIND_BLOCKS))
 			continue;
 
 		/* Check any potential block runs, advance each or nullify */
@@ -4697,12 +4699,11 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--no-color"))
 		options->use_color = 0;
 	else if (!strcmp(arg, "--color-moved")) {
-		if (diff_color_moved_default)
-			options->color_moved = diff_color_moved_default;
-		if (options->color_moved == COLOR_MOVED_NO)
+		options->color_moved = diff_color_moved_default;
+		if (!options->color_moved)
 			options->color_moved = COLOR_MOVED_DEFAULT;
 	} else if (!strcmp(arg, "--no-color-moved"))
-		options->color_moved = COLOR_MOVED_NO;
+		options->color_moved = 0;
 	else if (skip_prefix(arg, "--color-moved=", &arg)) {
 		int cm = parse_color_moved(arg);
 		if (cm < 0)
@@ -5543,7 +5544,7 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 
 			add_lines_to_move_detection(o, &add_lines, &del_lines);
 			mark_color_as_moved(o, &add_lines, &del_lines);
-			if (o->color_moved == COLOR_MOVED_ZEBRA_DIM)
+			if (o->color_moved & COLOR_MOVED_DIMMED_BLOCKS)
 				dim_moved_lines(o);
 
 			hashmap_free(&add_lines, 0);
diff --git a/diff.h b/diff.h
index d29560f822..9542017986 100644
--- a/diff.h
+++ b/diff.h
@@ -205,13 +205,16 @@ struct diff_options {
 	int diff_path_counter;
 
 	struct emitted_diff_symbols *emitted_symbols;
-	enum {
-		COLOR_MOVED_NO = 0,
-		COLOR_MOVED_PLAIN = 1,
-		COLOR_MOVED_ZEBRA = 2,
-		COLOR_MOVED_ZEBRA_DIM = 3,
-	} color_moved;
-	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
+	unsigned color_moved;
+
+	#define COLOR_MOVED_ENABLED		(1 << 0)
+
+	#define COLOR_MOVED_FIND_BLOCKS		(1 << 1)
+	/* XDF_WHITESPACE_FLAGS regarding block detection are set at 2, 3, 4 */
+
+	#define COLOR_MOVED_DIMMED_BLOCKS	(1 << 23)
+
+	#define COLOR_MOVED_DEFAULT (COLOR_MOVED_ENABLED | COLOR_MOVED_FIND_BLOCKS)
 	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
 };
 
-- 
2.17.0.484.g0c8726318c-goog

