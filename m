Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E29C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21FE16108B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhGTJ6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbhGTJ4E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:56:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF27C0613E6
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id y21-20020a7bc1950000b02902161fccabf1so1199308wmi.2
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OIRnvnQJGMfH9gMZnEIvJzcVGWMzhMT6d8yFwXGSxog=;
        b=WGhM9b1ZpWKH0pSq0ZL0vvK6Qh7j+s4CH3InY97qZ2uXnZHIOP1EyvvpZ90nyYBDdX
         WXt4ObnLEBAWSdqvtQsAG/MM8lglefOFUhVE41gxQ7gOQWpiec12soVzDh6wLShFZIRJ
         wVQG7DHoo5G7DB4C5LiaIL0EnDMcQgWlXXcfiED6UosOSQM5qkNNA1jq6TjMwDPc5QQ/
         LNiYSETRumVbS08yWdtNOM2vzjRHCPzNU5sG07XKl20u4H1cueNgKulC0rq6UgQD4FA8
         jjQ9fIf91l0zTK20X3moBOvilBNZa3jjspFgiakvjpcWLv8IyjKx3LyzIaAz4yTlO+7D
         9CcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OIRnvnQJGMfH9gMZnEIvJzcVGWMzhMT6d8yFwXGSxog=;
        b=GxBQL55H/BnTABs/+CKmBHJUoEgKwdd4+t3dzlZ39E1vPR6Q0A6pkfseStqZV4k5KM
         d6kyUY4awyetV1M3Zod23u5hIApPHIT2ObDxy40zsniZn5kiMZOvsVYSdwXQv+gfuRv4
         oo8Lf/GEI7LjfAy/a56wyrasOXUim5KegeVDFAmfTZixrwJt+uinRQKV05EiRTUqTi8q
         dkhrVCVx2fZL8sjbNE2wAW/eAnEZzUmOGJ4Tuu+z4+blTd7oSXbfLuUNMACNXn5wLzN0
         nPgeTbJ46SJoE+xPPYlE01PGcxqkmsa+EHmyFGvvk3FP6BsqwnMHBv5bT6Uu9XtC5Mn8
         NXkA==
X-Gm-Message-State: AOAM530Shy2lD8Vvl7mRP0BMGW0Xwqjbhq2sxG3X3+qCpnBIM5RPyVuu
        wHqBjUbjVdhSL624rBQbLwNw7joe9B0=
X-Google-Smtp-Source: ABdhPJxcwgJa7u8k97XmAvYfDdM3uXQhabr20cJ1x6ZX2KVPHOwfECta6lrLGJQDzBrZGSedorg+fw==
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr30760487wml.74.1626777397216;
        Tue, 20 Jul 2021 03:36:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14sm23517755wrj.66.2021.07.20.03.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:36:36 -0700 (PDT)
Message-Id: <5512145c70ff47e9ab239f4f896498edf4c16745.1626777393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
        <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 10:36:24 +0000
Subject: [PATCH v2 03/12] diff --color-moved: avoid false short line matches
 and bad zerba coloring
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When marking moved lines it is possible for a block of potential
matched lines to extend past a change in sign when there is a sequence
of added lines whose text matches the text of a sequence of deleted
and added lines. Most of the time either `match` will be NULL or
`pmb_advance_or_null()` will fail when the loop encounters a change of
sign but there are corner cases where `match` is non-NULL and
`pmb_advance_or_null()` successfully advances the moved block despite
the change in sign.

One consequence of this is highlighting a short line as moved when it
should not be. For example

-moved line  # Correctly highlighted as moved
+short line  # Wrongly highlighted as moved
 context
+moved line  # Correctly highlighted as moved
+short line
 context
-short line

The other consequence is coloring a moved addition following a moved
deletion in the wrong color. In the example below the first "+moved
line 3" should be highlighted as newMoved not newMovedAlternate.

-moved line 1 # Correctly highlighted as oldMoved
-moved line 2 # Correctly highlighted as oldMovedAlternate
+moved line 3 # Wrongly highlighted as newMovedAlternate
 context      # Everything else is highlighted correctly
+moved line 2
+moved line 3
 context
+moved line 1
-moved line 3

These false matches are more likely when using --color-moved-ws with
the exception of --color-moved-ws=allow-indentation-change which ties
the sign of the current whitespace delta to the sign of the line to
avoid this problem. The fix is to check that the sign of the new line
being matched is the same as the sign of the line that started the
block of potential matches.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c                     | 17 ++++++----
 t/t4015-diff-whitespace.sh | 65 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index cb068f8258c..2b51b77fd20 100644
--- a/diff.c
+++ b/diff.c
@@ -1142,7 +1142,7 @@ static void mark_color_as_moved(struct diff_options *o,
 	struct moved_block *pmb = NULL; /* potentially moved blocks */
 	int pmb_nr = 0, pmb_alloc = 0;
 	int n, flipped_block = 0, block_length = 0;
-	enum diff_symbol last_symbol = 0;
+	enum diff_symbol moved_symbol = DIFF_SYMBOL_BINARY_DIFF_HEADER;
 
 
 	for (n = 0; n < o->emitted_symbols->nr; n++) {
@@ -1168,7 +1168,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			flipped_block = 0;
 		}
 
-		if (!match) {
+		if (pmb_nr && (!match || l->s != moved_symbol)) {
 			int i;
 
 			adjust_last_block(o, n, block_length);
@@ -1177,12 +1177,13 @@ static void mark_color_as_moved(struct diff_options *o,
 			pmb_nr = 0;
 			block_length = 0;
 			flipped_block = 0;
-			last_symbol = l->s;
+		}
+		if (!match) {
+			moved_symbol = DIFF_SYMBOL_BINARY_DIFF_HEADER;
 			continue;
 		}
 
 		if (o->color_moved == COLOR_MOVED_PLAIN) {
-			last_symbol = l->s;
 			l->flags |= DIFF_SYMBOL_MOVED_LINE;
 			continue;
 		}
@@ -1214,11 +1215,16 @@ static void mark_color_as_moved(struct diff_options *o,
 			}
 
 			if (adjust_last_block(o, n, block_length) &&
-			    pmb_nr && last_symbol == l->s)
+			    pmb_nr && moved_symbol == l->s)
 				flipped_block = (flipped_block + 1) % 2;
 			else
 				flipped_block = 0;
 
+			if (pmb_nr)
+				moved_symbol = l->s;
+			else
+				moved_symbol = DIFF_SYMBOL_BINARY_DIFF_HEADER;
+
 			block_length = 0;
 		}
 
@@ -1228,7 +1234,6 @@ static void mark_color_as_moved(struct diff_options *o,
 			if (flipped_block && o->color_moved != COLOR_MOVED_BLOCKS)
 				l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
 		}
-		last_symbol = l->s;
 	}
 	adjust_last_block(o, n, block_length);
 
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 920114cd795..3119a59f071 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1514,6 +1514,71 @@ test_expect_success 'zebra alternate color is only used when necessary' '
 	test_cmp expected actual
 '
 
+test_expect_success 'short lines of opposite sign do not get marked as moved' '
+	cat >old.txt <<-\EOF &&
+	this line should be marked as moved
+	unchanged
+	unchanged
+	unchanged
+	unchanged
+	too short
+	this line should be marked as oldMoved newMoved
+	this line should be marked as oldMovedAlternate newMoved
+	unchanged 1
+	unchanged 2
+	unchanged 3
+	unchanged 4
+	this line should be marked as oldMoved newMoved/newMovedAlternate
+	EOF
+	cat >new.txt <<-\EOF &&
+	too short
+	unchanged
+	unchanged
+	this line should be marked as moved
+	too short
+	unchanged
+	unchanged
+	this line should be marked as oldMoved newMoved/newMovedAlternate
+	unchanged 1
+	unchanged 2
+	this line should be marked as oldMovedAlternate newMoved
+	this line should be marked as oldMoved newMoved/newMovedAlternate
+	unchanged 3
+	this line should be marked as oldMoved newMoved
+	unchanged 4
+	EOF
+	test_expect_code 1 git diff --no-index --color --color-moved=zebra \
+		old.txt new.txt >output && cat output &&
+	grep -v index output | test_decode_color >actual &&
+	cat >expect <<-\EOF &&
+	<BOLD>diff --git a/old.txt b/new.txt<RESET>
+	<BOLD>--- a/old.txt<RESET>
+	<BOLD>+++ b/new.txt<RESET>
+	<CYAN>@@ -1,13 +1,15 @@<RESET>
+	<BOLD;MAGENTA>-this line should be marked as moved<RESET>
+	<GREEN>+<RESET><GREEN>too short<RESET>
+	 unchanged<RESET>
+	 unchanged<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>this line should be marked as moved<RESET>
+	<GREEN>+<RESET><GREEN>too short<RESET>
+	 unchanged<RESET>
+	 unchanged<RESET>
+	<RED>-too short<RESET>
+	<BOLD;MAGENTA>-this line should be marked as oldMoved newMoved<RESET>
+	<BOLD;BLUE>-this line should be marked as oldMovedAlternate newMoved<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>this line should be marked as oldMoved newMoved/newMovedAlternate<RESET>
+	 unchanged 1<RESET>
+	 unchanged 2<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>this line should be marked as oldMovedAlternate newMoved<RESET>
+	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>this line should be marked as oldMoved newMoved/newMovedAlternate<RESET>
+	 unchanged 3<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>this line should be marked as oldMoved newMoved<RESET>
+	 unchanged 4<RESET>
+	<BOLD;MAGENTA>-this line should be marked as oldMoved newMoved/newMovedAlternate<RESET>
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'cmd option assumes configured colored-moved' '
 	test_config color.diff.oldMoved "magenta" &&
 	test_config color.diff.newMoved "cyan" &&
-- 
gitgitgadget

