Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 491071F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeDXVDr (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:03:47 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:46470 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDXVDl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:03:41 -0400
Received: by mail-pf0-f179.google.com with SMTP id h69so13291608pfe.13
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G4EGdNemOUJGHEevk951Bg4+n1Wo8F+1o5apn9FBZOY=;
        b=c9HUUHhNKU5NDLnPO7dXfzrntlw/zB48tobzGNtQCvZymWe14KK5hyPoJBGb1LnyS+
         GKGgXsjENX6q8xFFurkepbdfaQ2m0DVBKBIj1NGKpNIQWq10P+34zpod9FNkTyXwPrzr
         nwP7Xz0uEcJJjFU3ClUiFc0TvVtUuzkwQJW4oodbK8vU610pHz3vBzOcaIalpOveQeoi
         zU4bWHDcz5JKcs/Eu0o51ciQYnbV04CuHzSXjdUfg5CiBfGUwHSSaA07MFmt14BlyJgv
         ZyLavC8rD1MrT1pTZHbThilR/fG+GfaL264NBDr8xVwz+fjzNKcdHD6SY1U7gJaqSI8v
         bkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G4EGdNemOUJGHEevk951Bg4+n1Wo8F+1o5apn9FBZOY=;
        b=jigwwzMwsCG/l47YjmIx3LwtaqIXuFQY3aTfqgLj1kJUrohpYqPMsXo6AoLhA8lcN0
         9Dht4htTMzjfuoD1CmehIFkNdIbRGat44BOMnQUrs9HUXSrlOJWTE3w8wnUG07a+Wxls
         ZnPWb+wIqNLyGPaVjGuj2KNU/tbGWPLhsYhBpudB5UJX43zP0XqYmfMtyofB8WZY/go9
         8sOHVBU0dHQ5ELXUY15iTmkN3LJM8Dwh9Ms4AguzRO0ZNEqkIM5AG1XlH02xCdiao1Ub
         Zos/dRe5QvPt6ii48GwXAdIKQ3mlJXABuI4nBC8SfmrHSkidg3bzTXsDnNv1NULhmxbh
         dgOQ==
X-Gm-Message-State: ALQs6tBeP8M8FlRb6OWFrOLUYARGPjEOeqXy41W6mpQMoA/gYhSK12wU
        p21lpi3Yxs10F1jKuko/OhWR4YGQ6zY=
X-Google-Smtp-Source: AIpwx4/L7dcKSzKoeVXoXUdy68WF3IxvLG/F2xHRrfVYcyGl02q5Zc560SJalOfyJzpawBCl/JKSWQ==
X-Received: by 10.99.101.66 with SMTP id z63mr21551652pgb.383.1524603820245;
        Tue, 24 Apr 2018 14:03:40 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id h185sm5378752pfe.5.2018.04.24.14.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:03:39 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, simon@ruderich.org, avarab@gmail.com,
        jacob.keller@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/7] diff.c: add a blocks mode for moved code detection
Date:   Tue, 24 Apr 2018 14:03:28 -0700
Message-Id: <20180424210330.87861-6-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424210330.87861-1-sbeller@google.com>
References: <20180424210330.87861-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new "blocks" mode provides a middle ground between plain and zebra.
It is as intuitive (few colors) as plain, but still has the requirement
for a minimum of lines/characters to count a block as moved.

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
 (https://public-inbox.org/git/87o9j0uljo.fsf@evledraar.gmail.com/)
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/diff-options.txt |  8 ++++--
 diff.c                         |  6 +++--
 diff.h                         |  5 ++--
 t/t4015-diff-whitespace.sh     | 48 +++++++++++++++++++++++++++++++++-
 4 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e3a44f03cd..bb9f1b7cd8 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -276,10 +276,14 @@ plain::
 	that are added somewhere else in the diff. This mode picks up any
 	moved line, but it is not very useful in a review to determine
 	if a block of code was moved without permutation.
-zebra::
+blocks:
 	Blocks of moved text of at least 20 alphanumeric characters
 	are detected greedily. The detected blocks are
-	painted using either the 'color.diff.{old,new}Moved' color or
+	painted using either the 'color.diff.{old,new}Moved' color.
+	Adjacent blocks cannot be told apart.
+zebra::
+	Blocks of moved text are detected as in 'blocks' mode. The blocks
+	are painted using either the 'color.diff.{old,new}Moved' color or
 	'color.diff.{old,new}MovedAlternative'. The change between
 	the two colors indicates that a new block was detected.
 dimmed_zebra::
diff --git a/diff.c b/diff.c
index d1bae900cd..95c51c0b7d 100644
--- a/diff.c
+++ b/diff.c
@@ -271,6 +271,8 @@ static int parse_color_moved(const char *arg)
 		return COLOR_MOVED_NO;
 	else if (!strcmp(arg, "plain"))
 		return COLOR_MOVED_PLAIN;
+	else if (!strcmp(arg, "blocks"))
+		return COLOR_MOVED_BLOCKS;
 	else if (!strcmp(arg, "zebra"))
 		return COLOR_MOVED_ZEBRA;
 	else if (!strcmp(arg, "default"))
@@ -278,7 +280,7 @@ static int parse_color_moved(const char *arg)
 	else if (!strcmp(arg, "dimmed_zebra"))
 		return COLOR_MOVED_ZEBRA_DIM;
 	else
-		return error(_("color moved setting must be one of 'no', 'default', 'zebra', 'dimmed_zebra', 'plain'"));
+		return error(_("color moved setting must be one of 'no', 'default', 'blocks', 'zebra', 'dimmed_zebra', 'plain'"));
 }
 
 int git_diff_ui_config(const char *var, const char *value, void *cb)
@@ -903,7 +905,7 @@ static void mark_color_as_moved(struct diff_options *o,
 
 		block_length++;
 
-		if (flipped_block)
+		if (flipped_block && o->color_moved != COLOR_MOVED_BLOCKS)
 			l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
 	}
 	adjust_last_block(o, n, block_length);
diff --git a/diff.h b/diff.h
index d29560f822..7bd4f182c3 100644
--- a/diff.h
+++ b/diff.h
@@ -208,8 +208,9 @@ struct diff_options {
 	enum {
 		COLOR_MOVED_NO = 0,
 		COLOR_MOVED_PLAIN = 1,
-		COLOR_MOVED_ZEBRA = 2,
-		COLOR_MOVED_ZEBRA_DIM = 3,
+		COLOR_MOVED_BLOCKS = 2,
+		COLOR_MOVED_ZEBRA = 3,
+		COLOR_MOVED_ZEBRA_DIM = 4,
 	} color_moved;
 	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
 	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 17df491a3a..45091abb19 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1223,7 +1223,7 @@ test_expect_success 'plain moved code, inside file' '
 	test_cmp expected actual
 '
 
-test_expect_success 'detect permutations inside moved code -- dimmed_zebra' '
+test_expect_success 'detect blocks of moved code' '
 	git reset --hard &&
 	cat <<-\EOF >lines.txt &&
 		long line 1
@@ -1271,6 +1271,52 @@ test_expect_success 'detect permutations inside moved code -- dimmed_zebra' '
 	test_config color.diff.newMovedDimmed "normal cyan" &&
 	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
 	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
+
+	git diff HEAD --no-renames --color-moved=blocks --color |
+		grep -v "index" |
+		test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
+	<BOLD>--- a/lines.txt<RESET>
+	<BOLD>+++ b/lines.txt<RESET>
+	<CYAN>@@ -1,16 +1,16 @@<RESET>
+	<MAGENTA>-long line 1<RESET>
+	<MAGENTA>-long line 2<RESET>
+	<MAGENTA>-long line 3<RESET>
+	 line 4<RESET>
+	 line 5<RESET>
+	 line 6<RESET>
+	 line 7<RESET>
+	 line 8<RESET>
+	 line 9<RESET>
+	<CYAN>+<RESET><CYAN>long line 1<RESET>
+	<CYAN>+<RESET><CYAN>long line 2<RESET>
+	<CYAN>+<RESET><CYAN>long line 3<RESET>
+	<CYAN>+<RESET><CYAN>long line 14<RESET>
+	<CYAN>+<RESET><CYAN>long line 15<RESET>
+	<CYAN>+<RESET><CYAN>long line 16<RESET>
+	 line 10<RESET>
+	 line 11<RESET>
+	 line 12<RESET>
+	 line 13<RESET>
+	<MAGENTA>-long line 14<RESET>
+	<MAGENTA>-long line 15<RESET>
+	<MAGENTA>-long line 16<RESET>
+	EOF
+	test_cmp expected actual
+
+'
+
+test_expect_success 'detect permutations inside moved code -- dimmed_zebra' '
+	# reuse setup from test before!
+	test_config color.diff.oldMoved "magenta" &&
+	test_config color.diff.newMoved "cyan" &&
+	test_config color.diff.oldMovedAlternative "blue" &&
+	test_config color.diff.newMovedAlternative "yellow" &&
+	test_config color.diff.oldMovedDimmed "normal magenta" &&
+	test_config color.diff.newMovedDimmed "normal cyan" &&
+	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
+	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
 	git diff HEAD --no-renames --color-moved=dimmed_zebra --color |
 		grep -v "index" |
 		test_decode_color >actual &&
-- 
2.17.0.441.gb46fe60e1d-goog

