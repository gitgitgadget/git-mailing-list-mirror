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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBA2C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D03661244
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhFNNHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbhFNNHF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 09:07:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2796EC061766
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 06:04:53 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l2so14516561wrw.6
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 06:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oeHexxVeu4DZVMW4mceeMP2Rbpdm9rd5hWzuFjjwvwg=;
        b=TAraV2onBuPe1CvD+P8UBtOMmVhqMwdFz+Wk4ePYU69zi3Djg8NqXAhgFkQ3z+OHvD
         Avpo1ZHQ9evpN9poyTioQPD9n7WHx6FwkBXMCVBeyuCnwUizg9iPqPGlvWkXzKLaDMdr
         ZsFfJqwJFWpq6x6M3YyqxRAGLQPrZNT0QGfLH4jwqtnnCCSgI5em4QFjfzNSwPS1LwZb
         APcFLHr9mY59j08/dLF6UgJERwE0PHAEJz0o3CxqeyW7XgpR2HhQJhJvfrABVXsZBsdc
         QfUZF/wp3KfWUT6qJ3C/DfYrB7E5cNanaNo+Dt/cgV0G/32kngN2m5be3UfnJqQkI2OQ
         m6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oeHexxVeu4DZVMW4mceeMP2Rbpdm9rd5hWzuFjjwvwg=;
        b=VpD1FnocufxJuffiK95IzdN1R+ZbCOHMisbeTyrkqDhKQm12LzkXim0nIZxuZM2c/C
         Vwev6p6Y20dbNc9VwYwSb3gZLYQJ+dskYp3CBq0YF6lnC2M2mSXPh/seHn78d/bClIew
         T7x0l/xYzWeAj0UIAoO2q4RuzInlB6R5OzW4gTDCLzzZ4f5iNDFOtEV5ad5NVewXdgUy
         oHS8SAoan2/v2xgG/WPhAvrYrb87YWvVY266BW2W35Xm0qqxKHbbTrSz0zjykf12Uca+
         K1xV2YPmetW2grw9yTL/dncahRcVG+YEVvAPSNWK4BGbI3IxBU2tnX7OPcauS+Xzg/pT
         k/5g==
X-Gm-Message-State: AOAM53162TQoceC354GbkA22fsqd7zp3jfIhMxXAlfkAY6ONzF7PD73s
        YxqyRrW/QDa681hv7e0k0oApPM5bBGE=
X-Google-Smtp-Source: ABdhPJzdB4VO4hxHNQjNd/YzczdUQwV5p1h/1hcmc2b/p9UPLxPLFPm0vC7mRuRn9jbbMcyKbGg4qg==
X-Received: by 2002:a5d:4744:: with SMTP id o4mr12567451wrs.354.1623675891761;
        Mon, 14 Jun 2021 06:04:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm19579761wrc.0.2021.06.14.06.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 06:04:51 -0700 (PDT)
Message-Id: <3d02a0a91a086417f9dec4823255f50644e3aa87.1623675889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.git.1623675888.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 13:04:40 +0000
Subject: [PATCH 02/10] diff --color-moved: avoid false short line matches and
 bad zerba coloring
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
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
index cb068f8258c0..a0c43a104768 100644
--- a/diff.c
+++ b/diff.c
@@ -1142,7 +1142,7 @@ static void mark_color_as_moved(struct diff_options *o,
 	struct moved_block *pmb = NULL; /* potentially moved blocks */
 	int pmb_nr = 0, pmb_alloc = 0;
 	int n, flipped_block = 0, block_length = 0;
-	enum diff_symbol last_symbol = 0;
+	enum diff_symbol moved_symbol = 0;
 
 
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
+			moved_symbol = 0;
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
+				moved_symbol = 0;
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
index 920114cd795c..3119a59f071d 100755
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

