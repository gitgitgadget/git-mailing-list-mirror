Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5766D1F51C
	for <e@80x24.org>; Thu, 17 May 2018 19:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeEQTrP (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 15:47:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35169 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeEQTrL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 15:47:11 -0400
Received: by mail-pf0-f195.google.com with SMTP id x9-v6so2589246pfm.2
        for <git@vger.kernel.org>; Thu, 17 May 2018 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Lvy5dW8ebvm78w0/Z+fGCG54GbCaZIVYB6GAbK2qT0=;
        b=X6JwaRxGnN/13C4/QwwZ2ncVT4+wj9CzXBa7QcFYWArSAcgT/lx5ETQAqJTcRb80q4
         deAMTRtosNqI5OZaXXD72fP1p7VNcVUYfiSdPsQ7k1dbexiVbPBVRgJEpZQfQ5ou+OS6
         guyCcvw6QlujzOsKCrr96ozuTu0xYEhpJQDIpw6R5gtfmURQIRoVPtFTjj3gXyuoZIYL
         70+OlYixICVE4IetS3X4NT8xfeMF8jCfHrHd9iNhR4bh2ic252BFPpFoWbcQHx27XHez
         wFqS5n20WNxeqNFpfOhGskqJx+9u2Z5afwBLv1Rg20H3LmG4t1VeGsGhzhaAkGy0vUPT
         BkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Lvy5dW8ebvm78w0/Z+fGCG54GbCaZIVYB6GAbK2qT0=;
        b=UUqZi2tvtslZaxDGDrYg6037+zMyDjluHoa8aHJ3w5wtqR2oGoPaWHmlRLbfCLol4v
         m84caFlkvUEeSWgTTOYXVLkuxUSADRNPd291TPBFhELGSZ/dgWtkhsPWNEytmr4HvMZ3
         nWK9+V5xcpUbBsCxgrQBctzAjyxUOxtGJH7ZLAzWx976h8BVsPWfKoKNm6agZjrK5ARH
         jITWdDkkbu1gP0QJIu4+hPzqpP/8wa0QdTjndhs7wGioMi+NEMJkddqFfdkIjX6wXFuh
         alxgCSL58AlSpf6HpykYniMW5KM1wNyv//H1C0j3iC8IZc3N0xK0jvvYRIewurDv18tT
         8n5g==
X-Gm-Message-State: ALKqPwe5qa99QQu/OyUAmESzMwVg48FZSZiC4ekq9jiIvpldLs4TkSlU
        xc4JU9vJSqsXn2xRqPf/yHg4hw==
X-Google-Smtp-Source: AB8JxZqfVXnImOPFGv7TpMSOwBmxOLT2Oh2fvyV+yeTDZY9z/zYMIoYawoVA2LYOldkXgsKCbhdL8g==
X-Received: by 2002:a65:644a:: with SMTP id s10-v6mr3742713pgv.236.1526586430661;
        Thu, 17 May 2018 12:47:10 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id q15-v6sm835473pgc.33.2018.05.17.12.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 12:47:09 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com
Subject: [PATCH 5/8] diff.c: add a blocks mode for moved code detection
Date:   Thu, 17 May 2018 12:46:50 -0700
Message-Id: <20180517194653.48928-6-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517194653.48928-1-sbeller@google.com>
References: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
 <20180517194653.48928-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt |  8 ++++--
 diff.c                         |  6 +++--
 diff.h                         |  5 ++--
 t/t4015-diff-whitespace.sh     | 48 +++++++++++++++++++++++++++++++++-
 4 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e3a44f03cdc..bb9f1b7cd82 100644
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
index d1bae900cdc..95c51c0b7df 100644
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
index d29560f822c..7bd4f182c33 100644
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
index 17df491a3ab..45091abb192 100755
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
2.17.0.582.gccdcbd54c44.dirty

