Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EAF120899
	for <e@80x24.org>; Mon, 14 Aug 2017 23:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbdHNX5z (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 19:57:55 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35234 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbdHNX5v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 19:57:51 -0400
Received: by mail-pg0-f46.google.com with SMTP id v189so56696000pgd.2
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 16:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1aInShmu94MTyUH2GG+14sJB4rkCWAo5Kc780k1rhnM=;
        b=AnhY/LAVREtUvk7zhB+5yucSZnMl0Sd+DeeDoTCOgblD8eJrXFpeO2C3Bk8ZVaJE9R
         WTHqH6IZ+xGDz0SbkkXEJtCPg7T3ofX8VIzMA9EpmbQT38G9uhRf6nYT+ua6Q1us6auk
         j5wcK455icoOc/zTr5RnYWI3lpqOY69O+TGpRbUULhBHS0CxIjYEDU5yxB1O7u2qh/JL
         6VDOBesIPwr+hvyjJ6EPFY7kxEU+ytKQX5mecs7PUpEe4fyR9cPQl7vBaFg1gXdQhFH0
         On1vk4UegI6SWP1f7N7sjBwglON5lQdz65VO1ellQgJj02cFD4ZP+fzcQr47oMgQtxZD
         OcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1aInShmu94MTyUH2GG+14sJB4rkCWAo5Kc780k1rhnM=;
        b=lElDtAGlO6kOI00wuCFt4JWJHZ4LyO0UKvuoE9DbBl6nLt/RJiuLgat4YJn+mYUOnz
         5N+MQQ1FkrLAVk8l/4x5IGLkuHH5DU3g1rERldwJcCx0LRa1La+KJ16hhsmTvAiH2vxQ
         hHyE5pryc4WRr3scFUf1UtuwoB115jCC8dqMNOXWHqrFET/gmblb6++yHG/lb+F/Wta+
         lvHuxrBTASpz0bAJQfPsKEs47u071R1+tdmEn/GApiOYo61U6WumT7U5GKKOnfAtUMtn
         iIJ0J8gasHubVWcXMYGoeZrgPE6u+IBDXGP3/2f7jWRGJFEMx9trXtCt6bBtypgExl5l
         oEAg==
X-Gm-Message-State: AHYfb5jdAd4Vy09VZgW2WV182UvOaJ3USmB7bjosJvNbNPi6rx59UGNR
        uAgz7kJX7by0/Vf1Ns6CuA==
X-Received: by 10.98.178.69 with SMTP id x66mr27259424pfe.267.1502755070204;
        Mon, 14 Aug 2017 16:57:50 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id 190sm15878796pfy.56.2017.08.14.16.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Aug 2017 16:57:49 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v3 3/3] diff: define block by number of non-space chars
Date:   Mon, 14 Aug 2017 16:57:43 -0700
Message-Id: <41a7ff674072559415f98b81ffde798d94aed2fc.1502754962.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1502754962.git.jonathantanmy@google.com>
References: <cover.1502754962.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502754962.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com> <cover.1502754962.git.jonathantanmy@google.com>
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

Instead, teach diff that the minimum size of a block is 10
non-whitespace characters. This allows diff to still exclude
uninteresting lines appearing on their own (such as those solely
consisting of one or a few closing braces), as was the intention of the
adjacent-moved-line heuristic.

This requires a change in the test "detect malicious moved code, inside
file" in that some of its lines are no longer considered to be part of a
block, because they are too short. The malicious move can still be
observed, however.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/diff-options.txt |  8 ++--
 diff.c                         | 27 +++++++++---
 diff.h                         |  2 +-
 t/t4015-diff-whitespace.sh     | 96 +++++++++++++++++++++++++++++++++++++++---
 4 files changed, 113 insertions(+), 20 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index bc52bd0b9..d0bdc849f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -254,13 +254,11 @@ plain::
 	moved line, but it is not very useful in a review to determine
 	if a block of code was moved without permutation.
 zebra::
-	Blocks of moved code are detected greedily. The detected blocks are
+	Blocks of moved text of at least 10 non-whitespace characters
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
index f598d8a3a..305ce4126 100644
--- a/diff.c
+++ b/diff.c
@@ -864,19 +864,28 @@ static int shrink_potential_moved_blocks(struct moved_entry **pmb,
 /*
  * If o->color_moved is COLOR_MOVED_PLAIN, this function does nothing.
  *
- * Otherwise, if the last block has fewer lines than
- * COLOR_MOVED_MIN_BLOCK_LENGTH, unset DIFF_SYMBOL_MOVED_LINE on all lines in
- * that block.
+ * Otherwise, if the last block has fewer non-space characters than
+ * COLOR_MOVED_MIN_NON_SPACE_COUNT, unset DIFF_SYMBOL_MOVED_LINE on all lines
+ * in that block.
  *
  * The last block consists of the (n - block_length)'th line up to but not
  * including the nth line.
  */
 static void adjust_last_block(struct diff_options *o, int n, int block_length)
 {
-	int i;
-	if (block_length >= COLOR_MOVED_MIN_BLOCK_LENGTH ||
-	    o->color_moved == COLOR_MOVED_PLAIN)
+	int i, non_space_count = 0;
+	if (o->color_moved == COLOR_MOVED_PLAIN)
 		return;
+	for (i = 1; i < block_length + 1; i++) {
+		const char *c = o->emitted_symbols->buf[n - i].line;
+		for (; *c; c++) {
+			if (isspace(*c))
+				continue;
+			non_space_count++;
+			if (non_space_count >= COLOR_MOVED_MIN_NON_SPACE_COUNT)
+				return;
+		}
+	}
 	for (i = 1; i < block_length + 1; i++)
 		o->emitted_symbols->buf[n - i].flags &= ~DIFF_SYMBOL_MOVED_LINE;
 }
@@ -923,7 +932,6 @@ static void mark_color_as_moved(struct diff_options *o,
 		}
 
 		l->flags |= DIFF_SYMBOL_MOVED_LINE;
-		block_length++;
 
 		if (o->color_moved == COLOR_MOVED_PLAIN)
 			continue;
@@ -953,8 +961,13 @@ static void mark_color_as_moved(struct diff_options *o,
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
index 5755f465d..9e2fece5b 100644
--- a/diff.h
+++ b/diff.h
@@ -195,7 +195,7 @@ struct diff_options {
 		COLOR_MOVED_ZEBRA_DIM = 3,
 	} color_moved;
 	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
-	#define COLOR_MOVED_MIN_BLOCK_LENGTH 3
+	#define COLOR_MOVED_MIN_NON_SPACE_COUNT 10
 };
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 6f7758e5c..d8e7b77b9 100755
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
@@ -1382,7 +1382,7 @@ EOF
 	test_cmp expected actual
 '
 
-test_expect_success '--color-moved block at end of diff output respects MIN_BLOCK_LENGTH' '
+test_expect_success '--color-moved block at end of diff output respects MIN_NON_SPACE_COUNT' '
 	git reset --hard &&
 	>bar &&
 	cat <<-\EOF >foo &&
@@ -1417,6 +1417,88 @@ test_expect_success '--color-moved block at end of diff output respects MIN_BLOC
 	test_cmp expected actual
 '
 
+test_expect_success '--color-moved respects MIN_NON_SPACE_COUNT' '
+	git reset --hard &&
+	cat <<-\EOF >foo &&
+	nine chars
+	irrelevant_line
+	ten chars__
+	EOF
+	>bar &&
+	git add foo bar &&
+	git commit -m x &&
+
+	cat <<-\EOF >foo &&
+	irrelevant_line
+	EOF
+	cat <<-\EOF >bar &&
+	ten chars__
+	nine chars
+	EOF
+
+	git diff HEAD --color-moved=zebra --no-renames | grep -v "index" | test_decode_color >actual &&
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/bar b/bar<RESET>
+	<BOLD>--- a/bar<RESET>
+	<BOLD>+++ b/bar<RESET>
+	<CYAN>@@ -0,0 +1,2 @@<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>ten chars__<RESET>
+	<GREEN>+<RESET><GREEN>nine chars<RESET>
+	<BOLD>diff --git a/foo b/foo<RESET>
+	<BOLD>--- a/foo<RESET>
+	<BOLD>+++ b/foo<RESET>
+	<CYAN>@@ -1,3 +1 @@<RESET>
+	<RED>-nine chars<RESET>
+	 irrelevant_line<RESET>
+	<BOLD;MAGENTA>-ten chars__<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
+test_expect_success '--color-moved treats adjacent blocks as separate for MIN_NON_SPACE_COUNT' '
+	git reset --hard &&
+	cat <<-\EOF >foo &&
+	lin1
+	irrelevant_line
+	lin2
+	lin3
+	EOF
+	>bar &&
+	git add foo bar &&
+	git commit -m x &&
+
+	cat <<-\EOF >foo &&
+	irrelevant_line
+	EOF
+	cat <<-\EOF >bar &&
+	lin2
+	lin3
+	lin1
+	EOF
+
+	git diff HEAD --color-moved=zebra --no-renames | grep -v "index" | test_decode_color >actual &&
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/bar b/bar<RESET>
+	<BOLD>--- a/bar<RESET>
+	<BOLD>+++ b/bar<RESET>
+	<CYAN>@@ -0,0 +1,3 @@<RESET>
+	<GREEN>+<RESET><GREEN>lin2<RESET>
+	<GREEN>+<RESET><GREEN>lin3<RESET>
+	<GREEN>+<RESET><GREEN>lin1<RESET>
+	<BOLD>diff --git a/foo b/foo<RESET>
+	<BOLD>--- a/foo<RESET>
+	<BOLD>+++ b/foo<RESET>
+	<CYAN>@@ -1,4 +1 @@<RESET>
+	<RED>-lin1<RESET>
+	 irrelevant_line<RESET>
+	<RED>-lin2<RESET>
+	<RED>-lin3<RESET>
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

