Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293C8C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 09:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 004E7613AA
	for <git@archiver.kernel.org>; Tue,  4 May 2021 09:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhEDJ2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 05:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhEDJ2d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 05:28:33 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0427C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 02:27:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l13so6975077wru.11
        for <git@vger.kernel.org>; Tue, 04 May 2021 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=z2PMiL9T3aEDO+8w0tZ82b+LKvYK/O2KJoahh/X2jxQ=;
        b=dk3eU40EWl71AI8aHblwja5wkUer10O0tIjLGjnOzovx4/l1hlFHrzVpZJF9YSSeyg
         o6xzQUPm634y18i39hTmEZaDFsEA8AA5KlYKaJy1CAEIG3VRrhpBtczlOxdvIqyGPi0o
         nMFAf605ghocypFOt3LDwG5G7Ku+MjB9JHe6ac4Hv/YFyvBKT++vvKQ6/SoqBwlRPr6Q
         qS8nf0eTBeSfYOAQk/CkZ2tVH6X4dZDhFiEou3fALo3RnOzIkNyZaK80S+aLjyktwpwP
         2CRErJMwjB+v0m6LoenGBOinQEct5v5ugMhZKx21OwvnpE9/R1bUJHquq7OFP/uKJBcM
         +NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z2PMiL9T3aEDO+8w0tZ82b+LKvYK/O2KJoahh/X2jxQ=;
        b=rAWG2RnjGOVOElDvZdxIjwCFwZf2s5sozKhSn8kvdDV8HIb6h/xmT4mxKa/2M9Qkl4
         mSj29iTX0B/AGcerX8adghv8t3iUYBYzQLnBtYWpZ4O0s14C6Hpkp8dJogqSHmkzKjMM
         +1XNMDT3MWBzA9j/UFhtmq2GHx4VSZKM1cIKHueJAAkHQvtmPLLzDKDXZRb94cnwlwMr
         Am7zupdkObbwt6jGeQ5zcTNeWId8zsxumoDYrzVUNVzf4GZNN8+/Vxx6fIWpizQpT830
         4crV9f+KlbhEfoy5kKLcqe0mT6nbKQ9Ultgo03TScj95WqtfWskhsYXX5obafphX5Jn3
         e/Bw==
X-Gm-Message-State: AOAM532X4uASU3f7QBXsrra4KkupjSrisH19yFnuzmZY8HnSZ4sybDXr
        6rvSOZvl3+uxvQgaDs/mkod1Q9yMXGU=
X-Google-Smtp-Source: ABdhPJyLPKdTZlqy7YRsTemMuqa5ifXlzc89dGtONYUVOdjKHzJRprjZR+Ho0ig9IFE7yzOeon5ggQ==
X-Received: by 2002:a5d:58e1:: with SMTP id f1mr29621230wrd.375.1620120456110;
        Tue, 04 May 2021 02:27:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2sm1881865wmg.38.2021.05.04.02.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 02:27:35 -0700 (PDT)
Message-Id: <pull.947.git.1620120455364.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 09:27:34 +0000
Subject: [PATCH] word diff: handle zero length matches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If find_word_boundaries() encounters a zero length match (which can be
caused by matching a newline or using '*' instead of '+' in the regex)
we stop splitting the input into words which generates an inaccurate
diff. To fix this increment the start point when there is a zero
length match and try a new match. This is safe as posix regular
expressions always return the longest available match so a zero length
match means there are no longer matches available from the current
position.

Commit bf82940dbf1 (color-words: enable REG_NEWLINE to help user,
2009-01-17) prevented matching newlines in negated character classes
but it is still possible for the user to have an explicit newline
match in the regex which could cause a zero length match.

One could argue that having explicit newline matches or using '*'
rather than '+' are user errors but it seems to be better to work
round them than produce inaccurate diffs.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    word diff: handle zero length matches
    
    If find_word_boundaries() encounters a zero length match (which can be
    caused by matching a newline or using '*' instead of '+' in the regex)
    we stop splitting the input into words which generates an inaccurate
    diff. To fix this increment the start point when there is a zero length
    match and try a new match.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-947%2Fphillipwood%2Fwip%2Fword-diff-zero-length-matches-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-947/phillipwood/wip/word-diff-zero-length-matches-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/947

 diff.c                | 10 +++++++---
 t/t4034-diff-words.sh |  5 +++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 4acccd9d7edb..c8b1d724349c 100644
--- a/diff.c
+++ b/diff.c
@@ -2053,7 +2053,7 @@ static void fn_out_diff_words_aux(void *priv,
 static int find_word_boundaries(mmfile_t *buffer, regex_t *word_regex,
 		int *begin, int *end)
 {
-	if (word_regex && *begin < buffer->size) {
+	while (word_regex && *begin < buffer->size) {
 		regmatch_t match[1];
 		if (!regexec_buf(word_regex, buffer->ptr + *begin,
 				 buffer->size - *begin, 1, match, 0)) {
@@ -2061,9 +2061,13 @@ static int find_word_boundaries(mmfile_t *buffer, regex_t *word_regex,
 					'\n', match[0].rm_eo - match[0].rm_so);
 			*end = p ? p - buffer->ptr : match[0].rm_eo + *begin;
 			*begin += match[0].rm_so;
-			return *begin >= *end;
+			if (*begin == *end)
+				(*begin)++;
+			else
+				return *begin > *end;
+		} else {
+			return -1;
 		}
-		return -1;
 	}
 
 	/* find the next word */
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index ee7721ab9135..561c582d1615 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -184,6 +184,11 @@ test_expect_success 'word diff with a regular expression' '
 	word_diff --color-words="[a-z]+"
 '
 
+test_expect_success 'word diff with zero length matches' '
+	cp expect.letter-runs-are-words expect &&
+	word_diff --color-words="[a-z${LF}]*"
+'
+
 test_expect_success 'set up a diff driver' '
 	git config diff.testdriver.wordRegex "[^[:space:]]" &&
 	cat <<-\EOF >.gitattributes

base-commit: 7e391989789db82983665667013a46eabc6fc570
-- 
gitgitgadget
