Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 917161F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932253AbeFZHcf (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:32:35 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35348 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbeFZHbG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:06 -0400
Received: by mail-io0-f196.google.com with SMTP id q4-v6so15019545iob.2
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B9rN42AA/VMEuS1OqzecX3rhebBlNiPYkJZUcdxcJ+s=;
        b=CTqa8fhnGLktPxZE6vE1X+X4mAS8Kzs2w2/JPBzn9HLEhyC4FYXTD8GEmpHBdxaBHn
         Jvfi6DbvacA/9y0rLS50sruvp5VlhtE+T7fh0ItY3U+yrMMyp3jQTfSZBWSyQ6/zXn4O
         rqJyJ6l+HjfMU+TBPwsOEtT0i/bcGCnVbI7MCh/Cgn7EjgqRr0J292Em+zbYOI1CPnKM
         vQ+McW1/qFO2fFQjKjaIN9HtcOknBh/Q3BkfekJUDKweowDF5Z4Z3l0sOxdadcXT7Qmi
         P86DbFfMAGg/gkjydPRZrlZf6yg4WQFfLAVDxgcAQhRl1eFSAKOokxEAlggXekchlZVR
         DdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=B9rN42AA/VMEuS1OqzecX3rhebBlNiPYkJZUcdxcJ+s=;
        b=VaOXB6GN4d6KCtPW+zkWf7pXtBOCxuA0wBRhz3hH3AOY3+ii2d/a6m8yGSzF/yM7D2
         8i5jIpDlyL8mLGsxshpNzUvdOchcEGnUXR6LrpPe/ysr4nXLE71cJR89zYMdMukl8jRJ
         QeGpf1NIEjG6tZZx1Ujsj9SY73nQl4KCOGEmJdVeok2HyJXYNL5rkl/Mo+hjAivr20bV
         PInDsKsOGvql/Xwyn/ezwOQIlKqTYgl1pi8mxTAbjW/KfnlYVaGc9kbuQMsevN5n1dkP
         +jLPqdvPTgsd8Qs3sAHvIsxxgQtlkqgv0Iwu2XnEkgCgsMdsn1HZJd5OQbG3I0iEcG11
         hQlA==
X-Gm-Message-State: APt69E0umwGzc08ACAewwgdnoupv9Hy8iO9zTOr0X0l/R5u9xs5RnJQH
        ZK2ueMWmxumc6CSb0h6zliNwOw==
X-Google-Smtp-Source: AAOMgpdprviUMEN7YE9cRl9DT5qhyBjs/VtoA9qbTfavfawN19Oqa0nIdyU3p7sH0Rsj/oXHjtPxVw==
X-Received: by 2002:a6b:7517:: with SMTP id l23-v6mr268895ioh.89.1529998265722;
        Tue, 26 Jun 2018 00:31:05 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.31.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:31:05 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 16/29] t: use test_might_fail() instead of manipulating exit code manually
Date:   Tue, 26 Jun 2018 03:29:48 -0400
Message-Id: <20180626073001.6555-17-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests manually coerce the exit code of invoked commands to
"success" when they don't care if the command succeeds or fails since
failure of those commands should not cause the test to fail overall.
Such manual management predates the invention of test_might_fail().

An upcoming change will teach --chain-lint to check the &&-chain inside
subshells. This sort of manual exit code manipulation will trip up
--chain-lint due to the intentional break in the &&-chain. Therefore,
replace manual exit code management with test_might_fail() and a normal
&&-chain.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1507-rev-parse-upstream.sh | 6 +++---
 t/t1700-split-index.sh        | 2 +-
 t/t4012-diff-binary.sh        | 6 ++----
 t/t5400-send-pack.sh          | 4 ++--
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 93c77eac45..349f6e10af 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -123,9 +123,9 @@ test_expect_success 'checkout -b new my-side@{u} forks from the same' '
 
 test_expect_success 'merge my-side@{u} records the correct name' '
 (
-	cd clone || exit
-	git checkout master || exit
-	git branch -D new ;# can fail but is ok
+	cd clone &&
+	git checkout master &&
+	test_might_fail git branch -D new &&
 	git branch -t new my-side@{u} &&
 	git merge -s ours new@{u} &&
 	git show -s --pretty=tformat:%s >actual &&
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 1e81b33b2e..39133bcbc8 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -435,7 +435,7 @@ test_expect_success 'writing split index with null sha1 does not write cache tre
 	commit=$(git commit-tree $tree -p HEAD <msg) &&
 	git update-ref HEAD "$commit" &&
 	GIT_ALLOW_NULL_SHA1=1 git reset --hard &&
-	(test-tool dump-cache-tree >cache-tree.out || true) &&
+	test_might_fail test-tool dump-cache-tree >cache-tree.out &&
 	test_line_count = 0 cache-tree.out
 '
 
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 0a8af76aab..6579c81216 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -102,10 +102,8 @@ test_expect_success 'apply binary patch' '
 
 test_expect_success 'diff --no-index with binary creation' '
 	echo Q | q_to_nul >binary &&
-	(: hide error code from diff, which just indicates differences
-	 git diff --binary --no-index /dev/null binary >current ||
-	 true
-	) &&
+	# hide error code from diff, which just indicates differences
+	test_might_fail git diff --binary --no-index /dev/null binary >current &&
 	rm binary &&
 	git apply --binary <current &&
 	echo Q >expected &&
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 911eae1bf7..f1932ea431 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -86,7 +86,7 @@ test_expect_success 'push can be used to delete a ref' '
 test_expect_success 'refuse deleting push with denyDeletes' '
 	(
 	    cd victim &&
-	    ( git branch -D extra || : ) &&
+	    test_might_fail git branch -D extra &&
 	    git config receive.denyDeletes true &&
 	    git branch extra master
 	) &&
@@ -119,7 +119,7 @@ test_expect_success 'override denyDeletes with git -c receive-pack' '
 test_expect_success 'denyNonFastforwards trumps --force' '
 	(
 	    cd victim &&
-	    ( git branch -D extra || : ) &&
+	    test_might_fail git branch -D extra &&
 	    git config receive.denyNonFastforwards true
 	) &&
 	victim_orig=$(cd victim && git rev-parse --verify master) &&
-- 
2.18.0.419.gfe4b301394

