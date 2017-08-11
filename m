Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F26F20899
	for <e@80x24.org>; Fri, 11 Aug 2017 22:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753850AbdHKWt1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 18:49:27 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35438 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753638AbdHKWtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 18:49:25 -0400
Received: by mail-pg0-f44.google.com with SMTP id v189so20565421pgd.2
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4FrYmnpbuNpXmDTJwORcjKiN9GeKTv+mQ0icHLuHMx8=;
        b=MEHc3tsb/Dcd8R/vSQ8toCRxO9MXRvYI/BmKBGDqYW6ape6q2licf6tLVlCqMwzkSR
         yNe1tVjvMr++YKdUPXR2UtRPEKISw5u72EnjIy8Hq80bnfVDExbpLli/CX1g228h2VfL
         B0pu/50oTTDL4MwC8o+4dJkLi7pzs1OtQqbQjytAeAhA2sc77Q0p2jK11uzLEYIFE1LD
         28RrFCDEKcTpu35Itwrr5O6B/eFtRTOR17nL3/afglHAwO1taYaPBvYct+LfwTiD9G5x
         wekFv6mBcgA6L3mXG0l5fuQAbPG22S2wnUzJ3BGnQF/sn1MDQsMamF5pj5jxOTM/KNTK
         B1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4FrYmnpbuNpXmDTJwORcjKiN9GeKTv+mQ0icHLuHMx8=;
        b=EVcekAGFjLjGsVr24c5lkpXXp7kkOFC7D0HsiS5Y/apDYTBHooRMw6jbSraUWq+s6H
         tf/uh09c1/uIVWgiY5ug5AvTBG6qRbhJxdeD51j1jYF5KrqGIuLHST0kXu1kT8rhpDCB
         EqnIxu8bCK3y5wkW92NDV25mBJCGcNtU9BSi5IXpw8XhSMTEfb3IjoLp2Efgxgd/bsZT
         D7q5A7OE5eU7XaBdZGS8EdEVau5A3hu6k63zic7C3UkOxv1USJoMxJPYDSCKjIs7RHuF
         Nwcrn7pvF3WmXZubr1Fzs42qGgg8a3PoO7uAS6RNnMHiZxA9YbL6ViJLOUe07gyMz3g2
         3lUA==
X-Gm-Message-State: AHYfb5hKqi5nzTez+wHRdpMg39QjfKPEZSlshjU39f/ctWYWfnOSqDN2
        mnHSpvch6eLdX1rea5boyg==
X-Received: by 10.98.71.88 with SMTP id u85mr14806551pfa.185.1502491764103;
        Fri, 11 Aug 2017 15:49:24 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id j9sm3780502pfk.30.2017.08.11.15.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Aug 2017 15:49:23 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: [RFC PATCH 3/3] diff: check MIN_BLOCK_LENGTH at start of new block
Date:   Fri, 11 Aug 2017 15:49:16 -0700
Message-Id: <16707a12715ea60e05b00f4eb887ee99cd4d7b71.1502491372.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502491372.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502491372.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When noticing that the current line is not the continuation of the
current block, but the start of a new one, mark_color_as_moved() does
not check the length of the current block. Perform that check.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 diff.c                     |  6 +++++-
 t/t4015-diff-whitespace.sh | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 95620b130..04fc0d65d 100644
--- a/diff.c
+++ b/diff.c
@@ -920,7 +920,6 @@ static void mark_color_as_moved(struct diff_options *o,
 		}
 
 		l->flags |= DIFF_SYMBOL_MOVED_LINE;
-		block_length++;
 
 		if (o->color_moved == COLOR_MOVED_PLAIN)
 			continue;
@@ -950,8 +949,13 @@ static void mark_color_as_moved(struct diff_options *o,
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
index 6f7758e5c..401dc8f08 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1015,7 +1015,7 @@ test_expect_success 'detect moved code, complete file' '
 	test_cmp expected actual
 '
 
-test_expect_success 'detect malicious moved code, inside file' '
+test_expect_failure 'detect malicious moved code, inside file' '
 	test_config color.diff.oldMoved "normal red" &&
 	test_config color.diff.newMoved "normal green" &&
 	test_config color.diff.oldMovedAlternative "blue" &&
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
2.14.0.434.g98096fd7a8-goog

