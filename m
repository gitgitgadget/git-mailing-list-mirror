Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9568C1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 11:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfKMLRY (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 06:17:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51573 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfKMLRY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 06:17:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id q70so1564643wme.1
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 03:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C9PWk3w9dDzKqH6LFt2ROeDWPIbdLQBhVge67IbRFX8=;
        b=QzY/1tsNuMZqJwOKuoKiK9lu+kpfoe43xKRN42B8+EhPR9jN/92/fA6lj0e2l5e9Ku
         QFB4vCQi1UiuvEZOLioWrXuwDmuq1uyC+lKsPfvmRO4iqDVKciUukzFm7w7C1olyPKNy
         kTtlVJipbM5cIouwCmB+t1OApbdWZe3J4p6/l6Zo5k6SjCpRtb9xpU3j5no+e0r6mJVQ
         0XIo+YAIYQjMM65q3mm28e70FiPihp+DSIS94bZAcgrt6zcd6AjSKKcSp15HOffVznWi
         2gIxN7ojfEJfNAf/66Hh3iTxhj34KMMfCxxlrtCfKex4+VdNmYUhHk1kMh/1JLGN95Iw
         cZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C9PWk3w9dDzKqH6LFt2ROeDWPIbdLQBhVge67IbRFX8=;
        b=aNHFZbwkIoNUS2L1X1WpP02p+H1EDXhY0VvXOjrmr5ah8d2Tb2H2wYB5ssm56o+P/m
         ViEaUherdikLvbvxpzpr8d3nOHexm/ejxlt6CEFWRXFDhTSgoxikccZ17qJN4+r9UyfX
         qtlmLkc04t7wh1knH9LjYkuIzssEUa//L48rEkglFCW1dP4icl+tzI3FImcEvTN0tmQB
         Ri2jHLarpackHSXSSYbZdqhmE4LIKdMGngQV1sGvTFirIhEuEOD4aQCRREjxhUJbJdAL
         ToHJsZraZ4U9/+vgXUjqQrpNdCr6PwHKnF14G8NN3xJpGmksr3dRqBqvroT7KWQl21WY
         49MA==
X-Gm-Message-State: APjAAAUzyKFxAIQwatT0h0J03ExCI9Ms9hlVWxgfMCQUD88j/14S5Zz1
        3rSNd/q01q9JtHQ/sm4jHJD6MKJP9J8=
X-Google-Smtp-Source: APXvYqwSaQJb2mV0mkvMz3vLL+IBsxWMTZv5WGpYNUyxHP0e6/+3JIXT3vUKGngcE8H9BPnMZyGuDA==
X-Received: by 2002:a1c:99cb:: with SMTP id b194mr2391592wme.100.1573643840445;
        Wed, 13 Nov 2019 03:17:20 -0800 (PST)
Received: from localhost ([62.253.227.125])
        by smtp.gmail.com with ESMTPSA id f67sm2070289wme.16.2019.11.13.03.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Nov 2019 03:17:19 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Grzegorz Rajchman <rayman17@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/2] t3903: avoid git commands inside command substitution
Date:   Wed, 13 Nov 2019 11:17:17 +0000
Message-Id: <20191113111718.21412-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.24.0.155.gd9f6f3b619
In-Reply-To: <20191111195641.GC3115@cat>
References: <20191111195641.GC3115@cat>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running git commands inside command substitution can hide errors.
Avoid doing so in t3903.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t3903-stash.sh | 99 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 30 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 392954d6dd..db7cc6e664 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -34,7 +34,7 @@ index 0cfbf08..00750ed 100644
 EOF
 
 test_expect_success 'parents of stash' '
-	test $(git rev-parse stash^) = $(git rev-parse HEAD) &&
+	test_cmp_rev stash^ HEAD &&
 	git diff stash^2..stash >output &&
 	test_cmp expect output
 '
@@ -68,8 +68,11 @@ test_expect_success 'apply stashed changes' '
 	git commit -m other-file &&
 	git stash apply &&
 	test 3 = $(cat file) &&
-	test 1 = $(git show :file) &&
-	test 1 = $(git show HEAD:file)
+	echo 1 >expect &&
+	git show :file >actual &&
+	test_cmp expect actual &&
+	git show HEAD:file >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'apply stashed changes (including index)' '
@@ -80,8 +83,12 @@ test_expect_success 'apply stashed changes (including index)' '
 	git commit -m other-file &&
 	git stash apply --index &&
 	test 3 = $(cat file) &&
-	test 2 = $(git show :file) &&
-	test 1 = $(git show HEAD:file)
+	echo 2 >expect &&
+	git show :file >actual &&
+	test_cmp expect actual &&
+	echo 1 >expect &&
+	git show HEAD:file >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'unstashing in a subdirectory' '
@@ -107,8 +114,11 @@ test_expect_success 'drop top stash' '
 	test_cmp expected actual &&
 	git stash apply &&
 	test 3 = $(cat file) &&
-	test 1 = $(git show :file) &&
-	test 1 = $(git show HEAD:file)
+	echo 1 >expect &&
+	git show :file >actual &&
+	test_cmp expect actual &&
+	git show HEAD:file >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'drop middle stash' '
@@ -118,17 +128,24 @@ test_expect_success 'drop middle stash' '
 	echo 9 >file &&
 	git stash &&
 	git stash drop stash@{1} &&
-	test 2 = $(git stash list | wc -l) &&
+	git stash list >output &&
+	test_line_count = 2 output &&
 	git stash apply &&
 	test 9 = $(cat file) &&
-	test 1 = $(git show :file) &&
-	test 1 = $(git show HEAD:file) &&
+	echo 1 >expect &&
+	git show :file >actual &&
+	test_cmp expect actual &&
+	git show HEAD:file >actual &&
+	test_cmp expect actual &&
 	git reset --hard &&
 	git stash drop &&
 	git stash apply &&
 	test 3 = $(cat file) &&
-	test 1 = $(git show :file) &&
-	test 1 = $(git show HEAD:file)
+	echo 1 >expect &&
+	git show :file >actual &&
+	test_cmp expect actual &&
+	git show HEAD:file >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'drop middle stash by index' '
@@ -138,26 +155,37 @@ test_expect_success 'drop middle stash by index' '
 	echo 9 >file &&
 	git stash &&
 	git stash drop 1 &&
-	test 2 = $(git stash list | wc -l) &&
+	git stash list >output &&
+	test_line_count = 2 output &&
 	git stash apply &&
 	test 9 = $(cat file) &&
-	test 1 = $(git show :file) &&
-	test 1 = $(git show HEAD:file) &&
+	echo 1 >expect &&
+	git show :file >actual &&
+	test_cmp expect actual &&
+	git show HEAD:file >actual &&
+	test_cmp expect actual &&
 	git reset --hard &&
 	git stash drop &&
 	git stash apply &&
 	test 3 = $(cat file) &&
-	test 1 = $(git show :file) &&
-	test 1 = $(git show HEAD:file)
+	echo 1 >expect &&
+	git show :file >actual &&
+	test_cmp expect actual &&
+	git show HEAD:file >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'stash pop' '
 	git reset --hard &&
 	git stash pop &&
 	test 3 = $(cat file) &&
-	test 1 = $(git show :file) &&
-	test 1 = $(git show HEAD:file) &&
-	test 0 = $(git stash list | wc -l)
+	echo 1 >expect &&
+	git show :file >actual &&
+	test_cmp expect actual &&
+	git show HEAD:file >actual &&
+	test_cmp expect actual &&
+	git stash list >output &&
+	test_must_be_empty output
 '
 
 cat >expect <<EOF
@@ -207,8 +235,10 @@ test_expect_success 'stash branch' '
 	echo baz >file &&
 	git commit file -m second &&
 	git stash branch stashbranch &&
-	test refs/heads/stashbranch = $(git symbolic-ref HEAD) &&
-	test $(git rev-parse HEAD) = $(git rev-parse master^) &&
+	echo "refs/heads/stashbranch" >expect3 &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect3 actual &&
+	test_cmp_rev HEAD master^ &&
 	git diff --cached >output &&
 	test_cmp expect output &&
 	git diff >output &&
@@ -217,7 +247,8 @@ test_expect_success 'stash branch' '
 	git commit -m alternate\ second &&
 	git diff master..stashbranch >output &&
 	test_cmp output expect2 &&
-	test 0 = $(git stash list | wc -l)
+	git stash list >output &&
+	test_must_be_empty output
 '
 
 test_expect_success 'apply -q is quiet' '
@@ -242,7 +273,9 @@ test_expect_success 'pop -q --index works and is quiet' '
 	git add file &&
 	git stash save --quiet &&
 	git stash pop -q --index >output.out 2>&1 &&
-	test foo = "$(git show :file)" &&
+	echo foo >expect &&
+	git show :file >actual &&
+	test_cmp expect actual &&
 	test_must_be_empty output.out
 '
 
@@ -500,7 +533,8 @@ test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
 	git stash branch stash-branch ${STASH_ID} &&
 	test_when_finished "git reset --hard HEAD && git checkout master &&
 	git branch -D stash-branch" &&
-	test $(git ls-files --modified | wc -l) -eq 1
+	git ls-files --modified >output &&
+	test_line_count = 1 output
 '
 
 test_expect_success 'stash branch - stashes on stack, stash-like argument' '
@@ -516,7 +550,8 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
 	git stash branch stash-branch ${STASH_ID} &&
 	test_when_finished "git reset --hard HEAD && git checkout master &&
 	git branch -D stash-branch" &&
-	test $(git ls-files --modified | wc -l) -eq 1
+	git ls-files --modified >actual &&
+	test_line_count = 1 actual
 '
 
 test_expect_success 'stash branch complains with no arguments' '
@@ -638,7 +673,8 @@ test_expect_success 'drop: fail early if specified stash is not a stash ref' '
 	git stash &&
 	echo bar >file &&
 	git stash &&
-	test_must_fail git stash drop $(git rev-parse stash@{0}) &&
+	stash=$(git rev-parse stash@{0}) &&
+	test_must_fail git stash drop $stash &&
 	git stash pop &&
 	test bar = "$(cat file)" &&
 	git reset --hard HEAD
@@ -652,7 +688,8 @@ test_expect_success 'pop: fail early if specified stash is not a stash ref' '
 	git stash &&
 	echo bar >file &&
 	git stash &&
-	test_must_fail git stash pop $(git rev-parse stash@{0}) &&
+	stash=$(git rev-parse stash@{0}) &&
+	test_must_fail git stash pop $stash &&
 	git stash pop &&
 	test bar = "$(cat file)" &&
 	git reset --hard HEAD
@@ -789,7 +826,7 @@ test_expect_success 'stash where working directory contains "HEAD" file' '
 	git stash &&
 	git diff-files --quiet &&
 	git diff-index --cached --quiet HEAD &&
-	test "$(git rev-parse stash^)" = "$(git rev-parse HEAD)" &&
+	test_cmp_rev stash^ HEAD &&
 	git diff stash^..stash >output &&
 	test_cmp expect output
 '
@@ -807,7 +844,9 @@ test_expect_success 'store updates stash ref and reflog' '
 	git reset --hard &&
 	test_path_is_missing bazzy &&
 	git stash store -m quuxery $STASH_ID &&
-	test $(git rev-parse stash) = $STASH_ID &&
+	echo $STASH_ID >expect &&
+	git rev-parse stash >actual &&
+	test_cmp expect actual &&
 	git reflog --format=%H stash| grep $STASH_ID &&
 	git stash pop &&
 	grep quux bazzy
-- 
2.24.0.155.gd9f6f3b619

