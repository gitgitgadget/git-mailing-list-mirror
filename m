Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30AFB20899
	for <e@80x24.org>; Mon, 14 Aug 2017 21:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbdHNVb0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 17:31:26 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35245 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbdHNVbW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 17:31:22 -0400
Received: by mail-pg0-f50.google.com with SMTP id v189so54835295pgd.2
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=iD6RU6joU0Wi+DwoHROkFy4kuKjj4utOcrjoV8IOgGA=;
        b=SnvZnuHCVnloBLaF+wvT4w6ry99bZeG6ja81U3fPmJVUW54VNt7ePS3cJAEYgrUhWC
         iYzn2EIMD545aCeYII73ZL6hJgalHs4zUEhRCt92CVq+Xmgb2RKrt/lkSHTf1HrE1Rad
         jgm7tA9UqCfUBVDDnQAg4g7A56L+gBDPPLxp2TicH/Wwj3IWyx6qFM9U+WohWbhOylxi
         vvlvZaQ7Bfg8pbqa//U8ynSeAMtcKZ3SBvFGoD/SQhmiMSvHxqkxZheXX8oNFMM1VzPP
         UbPiywoGx8MnG5cHgDEnJQsW4sYTdwHJU3rbJiApiu1ig9a64H8TXFHRZlnXdYfcMc19
         LDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=iD6RU6joU0Wi+DwoHROkFy4kuKjj4utOcrjoV8IOgGA=;
        b=nyDpSd/L/Zk+V9ujGALjUpjM6l+PfmIXBEKCml9SsP0ibkBfVpJX9o52X5whOhhF9Y
         jPD3KixkoLXU0+CIFiDJvCOAVP+ydUE/vY22+M86emciB/+n7Moq6oLiuxxhqxziacPe
         +dtFFzXtL+n3Clmjo9HvUKiZkE9Xfdab3dyxMofefAjZA+P0o/P/+12+Kjsr3m1yru5g
         +HqV2CzJbmqxnA/XmndN58UDnZaJHnjfRzx67ITYYHae9J2r3ADY781Wy7m/o10ZRxTh
         Yz/kOGWywHmT0JrnFqunruNsHKP38NLkSTy4GOGDXS2dbk7kCyzZdAcU05cUKO/hAVzL
         5RWA==
X-Gm-Message-State: AHYfb5jlacBVZpMHbNhuUmW5hqhDahPpr9IaZkk7mHyONLcoNICF7gm9
        ryW00GN9iwG/nsWsgf0Ovw==
X-Received: by 10.98.75.148 with SMTP id d20mr26766741pfj.48.1502746281242;
        Mon, 14 Aug 2017 14:31:21 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id e63sm5570016pfc.24.2017.08.14.14.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Aug 2017 14:31:20 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v2 3/3] diff: check MIN_BLOCK_LENGTH at start of new block
Date:   Mon, 14 Aug 2017 14:31:12 -0700
Message-Id: <288c6c29d212088175b13074dba23c9dbdaa2c67.1502745892.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1502745892.git.jonathantanmy@google.com>
References: <cover.1502745892.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502745892.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com> <cover.1502745892.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing documentation states "If there are fewer than 3 adjacent
moved lines, they are not marked up as moved", which is ambiguous as to
whether "adjacent moved lines" must be adjacent both at the source and
at the destination, or be adjacent merely at the source or merely at the
destination. The behavior of the current code takes the latter
interpretation, but the behavior of blocks being conceptually painted as
blocks and then "unpainted" as lines is confusing to me.

Therefore, clarify the ambiguity in the documentation in the stricter
direction - a block is completely painted or not at all - and update the
code accordingly.

This requires a change in the test "detect malicious moved code, inside
file" in that the malicious change is now marked without the move
colors (because the blocks involved are too small), contrasting with
the subsequent test where the non-malicious change is marked with move
colors.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/diff-options.txt |  6 ++--
 diff.c                         |  6 +++-
 t/t4015-diff-whitespace.sh     | 71 +++++++++++++++++++++++++++++++++---------
 3 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index bc52bd0b9..1ee3ca3f6 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -257,10 +257,10 @@ zebra::
 	Blocks of moved code are detected greedily. The detected blocks are
 	painted using either the 'color.diff.{old,new}Moved' color or
 	'color.diff.{old,new}MovedAlternative'. The change between
-	the two colors indicates that a new block was detected. If there
-	are fewer than 3 adjacent moved lines, they are not marked up
+	the two colors indicates that a new block was detected. If a block
+	has fewer than 3 adjacent moved lines, it is not marked up
 	as moved, but the regular colors 'color.diff.{old,new}' will be
-	used.
+	used instead.
 dimmed_zebra::
 	Similar to 'zebra', but additional dimming of uninteresting parts
 	of moved code is performed. The bordering lines of two adjacent
diff --git a/diff.c b/diff.c
index f598d8a3a..20b784736 100644
--- a/diff.c
+++ b/diff.c
@@ -923,7 +923,6 @@ static void mark_color_as_moved(struct diff_options *o,
 		}
 
 		l->flags |= DIFF_SYMBOL_MOVED_LINE;
-		block_length++;
 
 		if (o->color_moved == COLOR_MOVED_PLAIN)
 			continue;
@@ -953,8 +952,13 @@ static void mark_color_as_moved(struct diff_options *o,
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
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 6f7758e5c..d0613a189 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1097,13 +1097,13 @@ test_expect_success 'detect malicious moved code, inside file' '
 	 printf("World\n");<RESET>
 	 }<RESET>
 	 <RESET>
-	<BRED>-int secure_foo(struct user *u)<RESET>
-	<BRED>-{<RESET>
-	<BLUE>-if (!u->is_allowed_foo)<RESET>
-	<BLUE>-return;<RESET>
-	<BRED>-foo(u);<RESET>
-	<BLUE>-}<RESET>
-	<BLUE>-<RESET>
+	<RED>-int secure_foo(struct user *u)<RESET>
+	<RED>-{<RESET>
+	<RED>-if (!u->is_allowed_foo)<RESET>
+	<RED>-return;<RESET>
+	<RED>-foo(u);<RESET>
+	<RED>-}<RESET>
+	<RED>-<RESET>
 	 int main()<RESET>
 	 {<RESET>
 	 foo();<RESET>
@@ -1115,13 +1115,13 @@ test_expect_success 'detect malicious moved code, inside file' '
 	 printf("Hello World, but different\n");<RESET>
 	 }<RESET>
 	 <RESET>
-	<BGREEN>+<RESET><BGREEN>int secure_foo(struct user *u)<RESET>
-	<BGREEN>+<RESET><BGREEN>{<RESET>
-	<YELLOW>+<RESET><YELLOW>foo(u);<RESET>
-	<BGREEN>+<RESET><BGREEN>if (!u->is_allowed_foo)<RESET>
-	<BGREEN>+<RESET><BGREEN>return;<RESET>
-	<YELLOW>+<RESET><YELLOW>}<RESET>
-	<YELLOW>+<RESET>
+	<GREEN>+<RESET><GREEN>int secure_foo(struct user *u)<RESET>
+	<GREEN>+<RESET><GREEN>{<RESET>
+	<GREEN>+<RESET><GREEN>foo(u);<RESET>
+	<GREEN>+<RESET><GREEN>if (!u->is_allowed_foo)<RESET>
+	<GREEN>+<RESET><GREEN>return;<RESET>
+	<GREEN>+<RESET><GREEN>}<RESET>
+	<GREEN>+<RESET>
 	 int another_function()<RESET>
 	 {<RESET>
 	 bar();<RESET>
@@ -1417,6 +1417,49 @@ test_expect_success '--color-moved block at end of diff output respects MIN_BLOC
 	test_cmp expected actual
 '
 
+test_expect_success '--color-moved treats adjacent blocks as separate for MIN_BLOCK_LENGTH' '
+	git reset --hard &&
+	cat <<-\EOF >foo &&
+	line1
+	irrelevant_line
+	line2
+	line3
+	EOF
+	>bar &&
+	git add foo bar &&
+	git commit -m x &&
+
+	cat <<-\EOF >foo &&
+	irrelevant_line
+	EOF
+	cat <<-\EOF >bar &&
+	line2
+	line3
+	line1
+	EOF
+
+	git diff HEAD --color-moved=zebra --no-renames | grep -v "index" | test_decode_color >actual &&
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/bar b/bar<RESET>
+	<BOLD>--- a/bar<RESET>
+	<BOLD>+++ b/bar<RESET>
+	<CYAN>@@ -0,0 +1,3 @@<RESET>
+	<GREEN>+<RESET><GREEN>line2<RESET>
+	<GREEN>+<RESET><GREEN>line3<RESET>
+	<GREEN>+<RESET><GREEN>line1<RESET>
+	<BOLD>diff --git a/foo b/foo<RESET>
+	<BOLD>--- a/foo<RESET>
+	<BOLD>+++ b/foo<RESET>
+	<CYAN>@@ -1,4 +1 @@<RESET>
+	<RED>-line1<RESET>
+	 irrelevant_line<RESET>
+	<RED>-line2<RESET>
+	<RED>-line3<RESET>
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

