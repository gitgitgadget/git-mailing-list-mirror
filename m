Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A09BB208CD
	for <e@80x24.org>; Wed, 16 Aug 2017 01:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753253AbdHPB1v (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 21:27:51 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:37273 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbdHPB1r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 21:27:47 -0400
Received: by mail-pg0-f49.google.com with SMTP id y129so16018802pgy.4
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 18:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=jkCLBq7ZwoAtQaqrfNqWHpKyoQThRwdMpM2O1y2K47A=;
        b=o/Lrydev4bXvXy+isBDtTJ28U46OwGOca/54Q9dPj9TRSrYEdUTWMPHVsWY+FLB+Ws
         XmGabLeUyufyG4qbqgd8bvOGsI1cUlJmoJIg+IFfvjbYVEpcJu0nIbrYtVB5U6Ym8pXn
         zPFC4ldcS0+2asTFDJ/J/st7GgKGOP8pBspqFgAvxoob48od/GRinJosyjYsOUKGSE/c
         dTDodSMqYam53+do5sMZBmcClUYVCZp/kZNDJDZIt2oii2yWryEWk+112aTbBABycseY
         qbDozkzkZDTWPCMvIjJlP7Tv2vfZ3SWHtLeidT0Loy/EuD8g1wn0Pt/jLmWYAMgSsGos
         cw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jkCLBq7ZwoAtQaqrfNqWHpKyoQThRwdMpM2O1y2K47A=;
        b=CEcZB29isafNoqjUpwv0barSAs1RbyX4z9JsqKfaV0Hp57lmWIsW3B98OhYj8IlVon
         Y6SR1XLMh+sa4vf+Hv2tZBq/cRhBXAEBWC8WRTDatWnLB6GLpf+oG/TL5COJLteKqNiV
         Sa5hGw8T4sMdI4ECC7toEHsBRJiXZZo8XiepyBVwS372392g6xkk46nenWWoy6ngrIaA
         naD8pKiLZcpaCKI26Mgj19pS3CR25X5Z7fk4IWwTOvb29CBKFmKGgxH2XM6DlMDakl0N
         1jS3cLTJi+HlEqTqiB/Ix02ZenqeaStxcJDdXWq6UtNtJ+rersbMDnmdJOT4SSGQEhqs
         XDXQ==
X-Gm-Message-State: AHYfb5jX80ioDnFFpFtV5iqOkckX4RATI9eVKZdoD4QjO5edj8iCCH3K
        OYh/06K8QFbHU/dRVzwOqw==
X-Received: by 10.84.129.45 with SMTP id 42mr67867plb.229.1502846866740;
        Tue, 15 Aug 2017 18:27:46 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k8sm621845pgf.33.2017.08.15.18.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 18:27:45 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v4 3/3] diff: define block by number of alphanumeric chars
Date:   Tue, 15 Aug 2017 18:27:39 -0700
Message-Id: <d9742acdf5fd863eca0fb4ca160f3b134750efbe.1502846454.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1502846454.git.jonathantanmy@google.com>
References: <cover.1502846454.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502846454.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com> <cover.1502846454.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing behavior of diff --color-moved=zebra does not define the
minimum size of a block at all, instead relying on a heuristic applied
later to filter out sets of adjacent moved lines that are shorter than 3
lines long. This can be confusing, because a block could thus be colored
as moved at the source but not at the destination (or vice versa),
depending on its neighbors.

Instead, teach diff that the minimum size of a block is 20 alphanumeric
characters, the same heuristic used by "git blame". This allows diff to
still exclude uninteresting lines appearing on their own (such as those
solely consisting of one or a few closing braces), as was the intention
of the adjacent-moved-line heuristic.

This requires a change in some tests in that some of their lines are no
longer considered to be part of a block, because they are too short.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/diff-options.txt |   8 +-
 diff.c                         |  28 +++--
 diff.h                         |   2 +-
 t/t4015-diff-whitespace.sh     | 226 ++++++++++++++++++++++++++++-------------
 4 files changed, 183 insertions(+), 81 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index bc52bd0b9..b8c881605 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -254,13 +254,11 @@ plain::
 	moved line, but it is not very useful in a review to determine
 	if a block of code was moved without permutation.
 zebra::
-	Blocks of moved code are detected greedily. The detected blocks are
+	Blocks of moved text of at least 20 alphanumeric characters
+	are detected greedily. The detected blocks are
 	painted using either the 'color.diff.{old,new}Moved' color or
 	'color.diff.{old,new}MovedAlternative'. The change between
-	the two colors indicates that a new block was detected. If there
-	are fewer than 3 adjacent moved lines, they are not marked up
-	as moved, but the regular colors 'color.diff.{old,new}' will be
-	used.
+	the two colors indicates that a new block was detected.
 dimmed_zebra::
 	Similar to 'zebra', but additional dimming of uninteresting parts
 	of moved code is performed. The bordering lines of two adjacent
diff --git a/diff.c b/diff.c
index f598d8a3a..c50fcc7ea 100644
--- a/diff.c
+++ b/diff.c
@@ -864,19 +864,31 @@ static int shrink_potential_moved_blocks(struct moved_entry **pmb,
 /*
  * If o->color_moved is COLOR_MOVED_PLAIN, this function does nothing.
  *
- * Otherwise, if the last block has fewer lines than
- * COLOR_MOVED_MIN_BLOCK_LENGTH, unset DIFF_SYMBOL_MOVED_LINE on all lines in
+ * Otherwise, if the last block has fewer alphanumeric characters than
+ * COLOR_MOVED_MIN_ALNUM_COUNT, unset DIFF_SYMBOL_MOVED_LINE on all lines in
  * that block.
  *
  * The last block consists of the (n - block_length)'th line up to but not
  * including the nth line.
+ *
+ * NEEDSWORK: This uses the same heuristic as blame_entry_score() in blame.c.
+ * Think of a way to unify them.
  */
 static void adjust_last_block(struct diff_options *o, int n, int block_length)
 {
-	int i;
-	if (block_length >= COLOR_MOVED_MIN_BLOCK_LENGTH ||
-	    o->color_moved == COLOR_MOVED_PLAIN)
+	int i, alnum_count = 0;
+	if (o->color_moved == COLOR_MOVED_PLAIN)
 		return;
+	for (i = 1; i < block_length + 1; i++) {
+		const char *c = o->emitted_symbols->buf[n - i].line;
+		for (; *c; c++) {
+			if (!isalnum(*c))
+				continue;
+			alnum_count++;
+			if (alnum_count >= COLOR_MOVED_MIN_ALNUM_COUNT)
+				return;
+		}
+	}
 	for (i = 1; i < block_length + 1; i++)
 		o->emitted_symbols->buf[n - i].flags &= ~DIFF_SYMBOL_MOVED_LINE;
 }
@@ -923,7 +935,6 @@ static void mark_color_as_moved(struct diff_options *o,
 		}
 
 		l->flags |= DIFF_SYMBOL_MOVED_LINE;
-		block_length++;
 
 		if (o->color_moved == COLOR_MOVED_PLAIN)
 			continue;
@@ -953,8 +964,13 @@ static void mark_color_as_moved(struct diff_options *o,
 			}
 
 			flipped_block = (flipped_block + 1) % 2;
+
+			adjust_last_block(o, n, block_length);
+			block_length = 0;
 		}
 
+		block_length++;
+
 		if (flipped_block)
 			l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
 	}
diff --git a/diff.h b/diff.h
index 5755f465d..aca150ba2 100644
--- a/diff.h
+++ b/diff.h
@@ -195,7 +195,7 @@ struct diff_options {
 		COLOR_MOVED_ZEBRA_DIM = 3,
 	} color_moved;
 	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
-	#define COLOR_MOVED_MIN_BLOCK_LENGTH 3
+	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
 };
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 6ae62a6bf..12d182dc1 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1101,9 +1101,9 @@ test_expect_success 'detect malicious moved code, inside file' '
 	<BRED>-{<RESET>
 	<BLUE>-if (!u->is_allowed_foo)<RESET>
 	<BLUE>-return;<RESET>
-	<BRED>-foo(u);<RESET>
-	<BLUE>-}<RESET>
-	<BLUE>-<RESET>
+	<RED>-foo(u);<RESET>
+	<RED>-}<RESET>
+	<RED>-<RESET>
 	 int main()<RESET>
 	 {<RESET>
 	 foo();<RESET>
@@ -1117,11 +1117,11 @@ test_expect_success 'detect malicious moved code, inside file' '
 	 <RESET>
 	<BGREEN>+<RESET><BGREEN>int secure_foo(struct user *u)<RESET>
 	<BGREEN>+<RESET><BGREEN>{<RESET>
-	<YELLOW>+<RESET><YELLOW>foo(u);<RESET>
+	<GREEN>+<RESET><GREEN>foo(u);<RESET>
 	<BGREEN>+<RESET><BGREEN>if (!u->is_allowed_foo)<RESET>
 	<BGREEN>+<RESET><BGREEN>return;<RESET>
-	<YELLOW>+<RESET><YELLOW>}<RESET>
-	<YELLOW>+<RESET>
+	<GREEN>+<RESET><GREEN>}<RESET>
+	<GREEN>+<RESET>
 	 int another_function()<RESET>
 	 {<RESET>
 	 bar();<RESET>
@@ -1182,9 +1182,9 @@ test_expect_success 'plain moved code, inside file' '
 test_expect_success 'detect permutations inside moved code -- dimmed_zebra' '
 	git reset --hard &&
 	cat <<-\EOF >lines.txt &&
-		line 1
-		line 2
-		line 3
+		long line 1
+		long line 2
+		long line 3
 		line 4
 		line 5
 		line 6
@@ -1195,9 +1195,9 @@ test_expect_success 'detect permutations inside moved code -- dimmed_zebra' '
 		line 11
 		line 12
 		line 13
-		line 14
-		line 15
-		line 16
+		long line 14
+		long line 15
+		long line 16
 	EOF
 	git add lines.txt &&
 	git commit -m "add poetry" &&
@@ -1208,12 +1208,12 @@ test_expect_success 'detect permutations inside moved code -- dimmed_zebra' '
 		line 7
 		line 8
 		line 9
-		line 1
-		line 2
-		line 3
-		line 14
-		line 15
-		line 16
+		long line 1
+		long line 2
+		long line 3
+		long line 14
+		long line 15
+		long line 16
 		line 10
 		line 11
 		line 12
@@ -1227,35 +1227,36 @@ test_expect_success 'detect permutations inside moved code -- dimmed_zebra' '
 	test_config color.diff.newMovedDimmed "normal cyan" &&
 	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
 	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
-	git diff HEAD --no-renames --color-moved=dimmed_zebra| test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved=dimmed_zebra |
+		grep -v "index" |
+		test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
-	<BOLD>index 47ea9c3..ba96a38 100644<RESET>
 	<BOLD>--- a/lines.txt<RESET>
 	<BOLD>+++ b/lines.txt<RESET>
 	<CYAN>@@ -1,16 +1,16 @@<RESET>
-	<BMAGENTA>-line 1<RESET>
-	<BMAGENTA>-line 2<RESET>
-	<BMAGENTA>-line 3<RESET>
+	<BMAGENTA>-long line 1<RESET>
+	<BMAGENTA>-long line 2<RESET>
+	<BMAGENTA>-long line 3<RESET>
 	 line 4<RESET>
 	 line 5<RESET>
 	 line 6<RESET>
 	 line 7<RESET>
 	 line 8<RESET>
 	 line 9<RESET>
-	<BCYAN>+<RESET><BCYAN>line 1<RESET>
-	<BCYAN>+<RESET><BCYAN>line 2<RESET>
-	<CYAN>+<RESET><CYAN>line 3<RESET>
-	<YELLOW>+<RESET><YELLOW>line 14<RESET>
-	<BYELLOW>+<RESET><BYELLOW>line 15<RESET>
-	<BYELLOW>+<RESET><BYELLOW>line 16<RESET>
+	<BCYAN>+<RESET><BCYAN>long line 1<RESET>
+	<BCYAN>+<RESET><BCYAN>long line 2<RESET>
+	<CYAN>+<RESET><CYAN>long line 3<RESET>
+	<YELLOW>+<RESET><YELLOW>long line 14<RESET>
+	<BYELLOW>+<RESET><BYELLOW>long line 15<RESET>
+	<BYELLOW>+<RESET><BYELLOW>long line 16<RESET>
 	 line 10<RESET>
 	 line 11<RESET>
 	 line 12<RESET>
 	 line 13<RESET>
-	<BMAGENTA>-line 14<RESET>
-	<BMAGENTA>-line 15<RESET>
-	<BMAGENTA>-line 16<RESET>
+	<BMAGENTA>-long line 14<RESET>
+	<BMAGENTA>-long line 15<RESET>
+	<BMAGENTA>-long line 16<RESET>
 	EOF
 	test_cmp expected actual
 '
@@ -1270,35 +1271,36 @@ test_expect_success 'cmd option assumes configured colored-moved' '
 	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
 	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
 	test_config diff.colorMoved zebra &&
-	git diff HEAD --no-renames --color-moved| test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved |
+		grep -v "index" |
+		test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
-	<BOLD>index 47ea9c3..ba96a38 100644<RESET>
 	<BOLD>--- a/lines.txt<RESET>
 	<BOLD>+++ b/lines.txt<RESET>
 	<CYAN>@@ -1,16 +1,16 @@<RESET>
-	<MAGENTA>-line 1<RESET>
-	<MAGENTA>-line 2<RESET>
-	<MAGENTA>-line 3<RESET>
+	<MAGENTA>-long line 1<RESET>
+	<MAGENTA>-long line 2<RESET>
+	<MAGENTA>-long line 3<RESET>
 	 line 4<RESET>
 	 line 5<RESET>
 	 line 6<RESET>
 	 line 7<RESET>
 	 line 8<RESET>
 	 line 9<RESET>
-	<CYAN>+<RESET><CYAN>line 1<RESET>
-	<CYAN>+<RESET><CYAN>line 2<RESET>
-	<CYAN>+<RESET><CYAN>line 3<RESET>
-	<YELLOW>+<RESET><YELLOW>line 14<RESET>
-	<YELLOW>+<RESET><YELLOW>line 15<RESET>
-	<YELLOW>+<RESET><YELLOW>line 16<RESET>
+	<CYAN>+<RESET><CYAN>long line 1<RESET>
+	<CYAN>+<RESET><CYAN>long line 2<RESET>
+	<CYAN>+<RESET><CYAN>long line 3<RESET>
+	<YELLOW>+<RESET><YELLOW>long line 14<RESET>
+	<YELLOW>+<RESET><YELLOW>long line 15<RESET>
+	<YELLOW>+<RESET><YELLOW>long line 16<RESET>
 	 line 10<RESET>
 	 line 11<RESET>
 	 line 12<RESET>
 	 line 13<RESET>
-	<MAGENTA>-line 14<RESET>
-	<MAGENTA>-line 15<RESET>
-	<MAGENTA>-line 16<RESET>
+	<MAGENTA>-long line 14<RESET>
+	<MAGENTA>-long line 15<RESET>
+	<MAGENTA>-long line 16<RESET>
 	EOF
 	test_cmp expected actual
 '
@@ -1324,16 +1326,16 @@ line 1
 line 2
 line 3
 line 4
-line 5
-line 6
-line 7
+long line 5
+long line 6
+long line 7
 EOF
 	git add lines.txt &&
 	git commit -m "add poetry" &&
 	cat <<\EOF >lines.txt &&
-	line 5
-	line 6
-	line 7
+	long line 5
+	long line 6
+	long line 7
 line 1
 line 2
 line 3
@@ -1341,48 +1343,50 @@ line 4
 EOF
 	test_config color.diff.oldMoved "magenta" &&
 	test_config color.diff.newMoved "cyan" &&
-	git diff HEAD --no-renames --color-moved| test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved |
+		grep -v "index" |
+		test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
-	<BOLD>index 734156d..eb89ead 100644<RESET>
 	<BOLD>--- a/lines.txt<RESET>
 	<BOLD>+++ b/lines.txt<RESET>
 	<CYAN>@@ -1,7 +1,7 @@<RESET>
-	<GREEN>+<RESET>	<GREEN>line 5<RESET>
-	<GREEN>+<RESET>	<GREEN>line 6<RESET>
-	<GREEN>+<RESET>	<GREEN>line 7<RESET>
+	<GREEN>+<RESET>	<GREEN>long line 5<RESET>
+	<GREEN>+<RESET>	<GREEN>long line 6<RESET>
+	<GREEN>+<RESET>	<GREEN>long line 7<RESET>
 	 line 1<RESET>
 	 line 2<RESET>
 	 line 3<RESET>
 	 line 4<RESET>
-	<RED>-line 5<RESET>
-	<RED>-line 6<RESET>
-	<RED>-line 7<RESET>
+	<RED>-long line 5<RESET>
+	<RED>-long line 6<RESET>
+	<RED>-long line 7<RESET>
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames -w --color-moved| test_decode_color >actual &&
+	git diff HEAD --no-renames -w --color-moved |
+		grep -v "index" |
+		test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
-	<BOLD>index 734156d..eb89ead 100644<RESET>
 	<BOLD>--- a/lines.txt<RESET>
 	<BOLD>+++ b/lines.txt<RESET>
 	<CYAN>@@ -1,7 +1,7 @@<RESET>
-	<CYAN>+<RESET>	<CYAN>line 5<RESET>
-	<CYAN>+<RESET>	<CYAN>line 6<RESET>
-	<CYAN>+<RESET>	<CYAN>line 7<RESET>
+	<CYAN>+<RESET>	<CYAN>long line 5<RESET>
+	<CYAN>+<RESET>	<CYAN>long line 6<RESET>
+	<CYAN>+<RESET>	<CYAN>long line 7<RESET>
 	 line 1<RESET>
 	 line 2<RESET>
 	 line 3<RESET>
 	 line 4<RESET>
-	<MAGENTA>-line 5<RESET>
-	<MAGENTA>-line 6<RESET>
-	<MAGENTA>-line 7<RESET>
+	<MAGENTA>-long line 5<RESET>
+	<MAGENTA>-long line 6<RESET>
+	<MAGENTA>-long line 7<RESET>
 	EOF
 	test_cmp expected actual
 '
 
-test_expect_success '--color-moved block at end of diff output respects MIN_BLOCK_LENGTH' '
+test_expect_success '--color-moved block at end of diff output respects MIN_ALNUM_COUNT' '
 	git reset --hard &&
 	>bar &&
 	cat <<-\EOF >foo &&
@@ -1419,6 +1423,90 @@ test_expect_success '--color-moved block at end of diff output respects MIN_BLOC
 	test_cmp expected actual
 '
 
+test_expect_success '--color-moved respects MIN_ALNUM_COUNT' '
+	git reset --hard &&
+	cat <<-\EOF >foo &&
+	nineteen chars 456789
+	irrelevant_line
+	twenty chars 234567890
+	EOF
+	>bar &&
+	git add foo bar &&
+	git commit -m x &&
+
+	cat <<-\EOF >foo &&
+	irrelevant_line
+	EOF
+	cat <<-\EOF >bar &&
+	twenty chars 234567890
+	nineteen chars 456789
+	EOF
+
+	git diff HEAD --color-moved=zebra --no-renames |
+		grep -v "index" |
+		test_decode_color >actual &&
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/bar b/bar<RESET>
+	<BOLD>--- a/bar<RESET>
+	<BOLD>+++ b/bar<RESET>
+	<CYAN>@@ -0,0 +1,2 @@<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>twenty chars 234567890<RESET>
+	<GREEN>+<RESET><GREEN>nineteen chars 456789<RESET>
+	<BOLD>diff --git a/foo b/foo<RESET>
+	<BOLD>--- a/foo<RESET>
+	<BOLD>+++ b/foo<RESET>
+	<CYAN>@@ -1,3 +1 @@<RESET>
+	<RED>-nineteen chars 456789<RESET>
+	 irrelevant_line<RESET>
+	<BOLD;MAGENTA>-twenty chars 234567890<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
+test_expect_success '--color-moved treats adjacent blocks as separate for MIN_ALNUM_COUNT' '
+	git reset --hard &&
+	cat <<-\EOF >foo &&
+	7charsA
+	irrelevant_line
+	7charsB
+	7charsC
+	EOF
+	>bar &&
+	git add foo bar &&
+	git commit -m x &&
+
+	cat <<-\EOF >foo &&
+	irrelevant_line
+	EOF
+	cat <<-\EOF >bar &&
+	7charsB
+	7charsC
+	7charsA
+	EOF
+
+	git diff HEAD --color-moved=zebra --no-renames | grep -v "index" | test_decode_color >actual &&
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/bar b/bar<RESET>
+	<BOLD>--- a/bar<RESET>
+	<BOLD>+++ b/bar<RESET>
+	<CYAN>@@ -0,0 +1,3 @@<RESET>
+	<GREEN>+<RESET><GREEN>7charsB<RESET>
+	<GREEN>+<RESET><GREEN>7charsC<RESET>
+	<GREEN>+<RESET><GREEN>7charsA<RESET>
+	<BOLD>diff --git a/foo b/foo<RESET>
+	<BOLD>--- a/foo<RESET>
+	<BOLD>+++ b/foo<RESET>
+	<CYAN>@@ -1,4 +1 @@<RESET>
+	<RED>-7charsA<RESET>
+	 irrelevant_line<RESET>
+	<RED>-7charsB<RESET>
+	<RED>-7charsC<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
 test_expect_success 'move detection with submodules' '
 	test_create_repo bananas &&
 	echo ripe >bananas/recipe &&
-- 
2.14.1.480.gb18f417b89-goog

