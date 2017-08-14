Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CBBB20899
	for <e@80x24.org>; Mon, 14 Aug 2017 23:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbdHNX5w (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 19:57:52 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36547 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752651AbdHNX5u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 19:57:50 -0400
Received: by mail-pg0-f47.google.com with SMTP id i12so5906335pgr.3
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=f8m4a5sOMOJwaQZb98iDeifNSmrIvLo1JNNIUfZohUA=;
        b=E9mc8GD6fZsZczvqBLQNpGa/jGphLThdKCaKf/Ic7tA6bJYTagiWMQ8TUY0t7j/xFa
         jBEoFISWxbdOb+g/xICi7l43xsSRa4Eq53eg7oMW/6k8TLflEQy/Meipz/gl8xuNmoRP
         kA9HM6iZYJnBeiCoxaYc4Zb3u1AyBkfLKXARDjLPDXkwvk/n3IlPzSmAOF209mxibZ2E
         5715PwjAG/Eqb2iDGN1oiSKBbHHQHByfzI1D2O5YZQzVNEUkL6rmYoP3UVXw2Ia7986x
         C8zVsXEa7CDHsN7YgsNSY/MOdS21f13CFs5+V5ORt/zDdNCMYspxBwS9PNPjNYh7uP6n
         UEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=f8m4a5sOMOJwaQZb98iDeifNSmrIvLo1JNNIUfZohUA=;
        b=tR04nMLUMl1TgG+solkFR8L4IGoZdSBGRHyUS8nisbjj+g3gryuzBqKfnMN4C8IFgs
         wv32IDyREemjliHzUDD3oL6TD66b+ZnurHKgdo8SxMlFxUp6dKJiy5JJVmzlnV9ojgt8
         /yHqpsjLUCWudaDSQkrxZt83iCpMaf8lTdmGMBmbi+YotN6kEr9wlfglcIkNfCZZZ4w7
         HbFVLxICOXA3O7DPExvhyfIyHANphMN8Jklfi/3bNXhYDEMc9fUX/mEBBVX7CQiJra5W
         8Y3JWtUKt5nQF/IK4hAIwJqwmtJ4TaRM5+S/j98Tt6sNF0jc9z+k3RGRadx4kTBmH8df
         4xyA==
X-Gm-Message-State: AHYfb5jrnmdyIE3mimKgxSEdx6jW+b879iMoSxRrj4cqPSWcFuAKy69n
        b4kqG8rEgbCjeGk41HzKAQ==
X-Received: by 10.98.130.206 with SMTP id w197mr26306090pfd.310.1502755068958;
        Mon, 14 Aug 2017 16:57:48 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id 190sm15878796pfy.56.2017.08.14.16.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Aug 2017 16:57:48 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v3 2/3] diff: respect MIN_BLOCK_LENGTH for last block
Date:   Mon, 14 Aug 2017 16:57:42 -0700
Message-Id: <f40ad82d3dde63a63e3fcd973f832692509ac162.1502754962.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1502754962.git.jonathantanmy@google.com>
References: <cover.1502754962.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502754962.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com> <cover.1502754962.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, MIN_BLOCK_LENGTH is only checked when diff encounters a line
that does not belong to the current block. In particular, this means
that MIN_BLOCK_LENGTH is not checked after all lines are encountered.

Perform that check.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 diff.c                     | 29 ++++++++++++++++++++++-------
 t/t4015-diff-whitespace.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 23311f9c0..f598d8a3a 100644
--- a/diff.c
+++ b/diff.c
@@ -861,6 +861,26 @@ static int shrink_potential_moved_blocks(struct moved_entry **pmb,
 	return rp + 1;
 }
 
+/*
+ * If o->color_moved is COLOR_MOVED_PLAIN, this function does nothing.
+ *
+ * Otherwise, if the last block has fewer lines than
+ * COLOR_MOVED_MIN_BLOCK_LENGTH, unset DIFF_SYMBOL_MOVED_LINE on all lines in
+ * that block.
+ *
+ * The last block consists of the (n - block_length)'th line up to but not
+ * including the nth line.
+ */
+static void adjust_last_block(struct diff_options *o, int n, int block_length)
+{
+	int i;
+	if (block_length >= COLOR_MOVED_MIN_BLOCK_LENGTH ||
+	    o->color_moved == COLOR_MOVED_PLAIN)
+		return;
+	for (i = 1; i < block_length + 1; i++)
+		o->emitted_symbols->buf[n - i].flags &= ~DIFF_SYMBOL_MOVED_LINE;
+}
+
 /* Find blocks of moved code, delegate actual coloring decision to helper */
 static void mark_color_as_moved(struct diff_options *o,
 				struct hashmap *add_lines,
@@ -896,13 +916,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		}
 
 		if (!match) {
-			if (block_length < COLOR_MOVED_MIN_BLOCK_LENGTH &&
-			    o->color_moved != COLOR_MOVED_PLAIN) {
-				for (i = 1; i < block_length + 1; i++) {
-					l = &o->emitted_symbols->buf[n - i];
-					l->flags &= ~DIFF_SYMBOL_MOVED_LINE;
-				}
-			}
+			adjust_last_block(o, n, block_length);
 			pmb_nr = 0;
 			block_length = 0;
 			continue;
@@ -944,6 +958,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		if (flipped_block)
 			l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
 	}
+	adjust_last_block(o, n, block_length);
 
 	free(pmb);
 }
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index c3b697411..6f7758e5c 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1382,6 +1382,41 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success '--color-moved block at end of diff output respects MIN_BLOCK_LENGTH' '
+	git reset --hard &&
+	>bar &&
+	cat <<-\EOF >foo &&
+	irrelevant_line
+	line1
+	EOF
+	git add foo bar &&
+	git commit -m x &&
+
+	cat <<-\EOF >bar &&
+	line1
+	EOF
+	cat <<-\EOF >foo &&
+	irrelevant_line
+	EOF
+
+	git diff HEAD --color-moved=zebra --no-renames | grep -v "index" | test_decode_color >actual &&
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/bar b/bar<RESET>
+	<BOLD>--- a/bar<RESET>
+	<BOLD>+++ b/bar<RESET>
+	<CYAN>@@ -0,0 +1 @@<RESET>
+	<GREEN>+<RESET><GREEN>line1<RESET>
+	<BOLD>diff --git a/foo b/foo<RESET>
+	<BOLD>--- a/foo<RESET>
+	<BOLD>+++ b/foo<RESET>
+	<CYAN>@@ -1,2 +1 @@<RESET>
+	 irrelevant_line<RESET>
+	<RED>-line1<RESET>
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

