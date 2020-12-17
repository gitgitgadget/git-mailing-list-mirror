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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C28C4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F7422CB3
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbgLQBHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 20:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731284AbgLQBHy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 20:07:54 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDE0C0617A6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:14 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id x22so4006935wmc.5
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fc317wPVuCV3lwh5JeHKTpiAnuns0cCAPb8JoDxm3Us=;
        b=oNPApUkgqqGitIZp+77Jq7LQekkpv5jODpaLQ8OrDEoe2qFzzvfaQPz/ndcdluQsmQ
         EYAXyr9JjnqwB332XGr8p4v4bNFEPCqezirygitfunr4xpKhu1EpCWveuWyyJJ7QCiDA
         l0eBJKq3CAs04i6rvqmfdOZoeWsX7/CNXuU4fiaJ0M5+tR3QZKRbcVWzVnPyTgyJ9SDb
         FFLxL/uzkzLLqJo4nN2Pje+s3Wy4yKg1o3nPmCijQhRJky9oNoK/JGC4kc5yjKIgWPlE
         dp5CX4+Poz9l9Q6N5DsW4rPNuJhrmb/M1vLaj0VCWDEO3kcdpL+cfTzCdsftnigDxxwQ
         ayVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fc317wPVuCV3lwh5JeHKTpiAnuns0cCAPb8JoDxm3Us=;
        b=eAqjneVSDz6UjUWUEH3PYCUAAduG0KGNFigMbEO9vCO0M4CzbJt3LgIufE9LVO0uyd
         z8sZe1pGt/0kkyYNtakLwar4HB3PowaXrM6smYaVEWn1ZRWR6SGIfbWskkXMQvqjwJ3a
         wzb0yBe6YfQowgsJvS8IiaIa93XMbkIdP49Izz8/2wXTgcYXJaX4jzCC2APdSb8mOwSD
         A150eKDSNS+tP+Z7hsQ0vA5sQgm1LZqzmN6DnyxxiP+0UjoSykGiY5E1EGOE+oZKrEGm
         wUs36pfTcAAy1YtMRSnhiW+8cftJ9bf9PrcjphylspXkCstWGeDToAFXkXNB/YKnB11R
         Gmjw==
X-Gm-Message-State: AOAM532XAImEAlggq9vPcjlUYtGlzBUbArtTnRqvWymWYd6XsisupPS3
        lDxTYlcvQs+88NomrbQ3ZHsUjEeRF9k=
X-Google-Smtp-Source: ABdhPJx0HhGO2dQLjO/96SBZaiQbshLQZ555owobMIcSIlMFFGO+7PWckma7XgA9t39YwDOaSOydVQ==
X-Received: by 2002:a7b:ce14:: with SMTP id m20mr5892374wmc.149.1608167232815;
        Wed, 16 Dec 2020 17:07:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y13sm488399wrl.63.2020.12.16.17.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 17:07:12 -0800 (PST)
Message-Id: <802e8f2cfd2cec86d54202a844665c222f868605.1608167230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.816.git.1608167230.gitgitgadget@gmail.com>
References: <pull.816.git.1608167230.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Dec 2020 01:07:00 +0000
Subject: [PATCH 01/11] t1400: use `main` as initial branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 3224b0f0bb7 (t1400: prepare for `main` being default branch name,
2020-10-23), we prepared t1400 for a time when the default initial
branch name would be `main`.

However, there is no need to wait that long: let's adjust the test
script to stop relying on a specific initial branch name by setting it
explicitly. This allows us to drop the `PREPARE_FOR_MAIN_BRANCH` prereq
from two test cases.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1400-update-ref.sh | 75 ++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 31b64be521d..6ee7d216fb8 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -8,7 +8,7 @@ test_description='Test git update-ref and basic ref logging'
 
 Z=$ZERO_OID
 
-m=refs/heads/master
+m=refs/heads/main
 n_dir=refs/heads/gu
 n=$n_dir/fixes
 outside=refs/foo
@@ -27,10 +27,11 @@ create_test_commits ()
 }
 
 test_expect_success setup '
+	git checkout --orphan main &&
 	create_test_commits "" &&
 	mkdir $bare &&
 	cd $bare &&
-	git init --bare &&
+	git init --bare -b main &&
 	create_test_commits "bare" &&
 	cd -
 '
@@ -264,7 +265,7 @@ test_expect_success "(not) changed .git/$m" '
 	! test $B = $(git show-ref -s --verify $m)
 '
 
-rm -f .git/logs/refs/heads/master
+rm -f .git/logs/refs/heads/main
 test_expect_success "create $m (logged by touch)" '
 	test_config core.logAllRefUpdates false &&
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
@@ -300,7 +301,7 @@ test_expect_success 'symref empty directory removal' '
 	git branch e1/e2/r1 HEAD &&
 	git branch e1/r2 HEAD &&
 	git checkout e1/e2/r1 &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	test_path_is_file .git/refs/heads/e1/e2/r1 &&
 	test_path_is_file .git/logs/refs/heads/e1/e2/r1 &&
 	git update-ref -d HEAD &&
@@ -364,68 +365,68 @@ test_expect_success 'set up for querying the reflog' '
 ed="Thu, 26 May 2005 18:32:00 -0500"
 gd="Thu, 26 May 2005 18:33:00 -0500"
 ld="Thu, 26 May 2005 18:43:00 -0500"
-test_expect_success 'Query "master@{May 25 2005}" (before history)' '
+test_expect_success 'Query "main@{May 25 2005}" (before history)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify "master@{May 25 2005}" >o 2>e &&
+	git rev-parse --verify "main@{May 25 2005}" >o 2>e &&
 	echo "$C" >expect &&
 	test_cmp expect o &&
-	echo "warning: log for '\''master'\'' only goes back to $ed" >expect &&
+	echo "warning: log for '\''main'\'' only goes back to $ed" >expect &&
 	test_i18ncmp expect e
 '
-test_expect_success 'Query master@{2005-05-25} (before history)' '
+test_expect_success 'Query main@{2005-05-25} (before history)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify master@{2005-05-25} >o 2>e &&
+	git rev-parse --verify main@{2005-05-25} >o 2>e &&
 	echo "$C" >expect &&
 	test_cmp expect o &&
-	echo "warning: log for '\''master'\'' only goes back to $ed" >expect &&
+	echo "warning: log for '\''main'\'' only goes back to $ed" >expect &&
 	test_i18ncmp expect e
 '
-test_expect_success 'Query "master@{May 26 2005 23:31:59}" (1 second before history)' '
+test_expect_success 'Query "main@{May 26 2005 23:31:59}" (1 second before history)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify "master@{May 26 2005 23:31:59}" >o 2>e &&
+	git rev-parse --verify "main@{May 26 2005 23:31:59}" >o 2>e &&
 	echo "$C" >expect &&
 	test_cmp expect o &&
-	echo "warning: log for '\''master'\'' only goes back to $ed" >expect &&
+	echo "warning: log for '\''main'\'' only goes back to $ed" >expect &&
 	test_i18ncmp expect e
 '
-test_expect_success 'Query "master@{May 26 2005 23:32:00}" (exactly history start)' '
+test_expect_success 'Query "main@{May 26 2005 23:32:00}" (exactly history start)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify "master@{May 26 2005 23:32:00}" >o 2>e &&
+	git rev-parse --verify "main@{May 26 2005 23:32:00}" >o 2>e &&
 	echo "$C" >expect &&
 	test_cmp expect o &&
 	test_must_be_empty e
 '
-test_expect_success 'Query "master@{May 26 2005 23:32:30}" (first non-creation change)' '
+test_expect_success 'Query "main@{May 26 2005 23:32:30}" (first non-creation change)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify "master@{May 26 2005 23:32:30}" >o 2>e &&
+	git rev-parse --verify "main@{May 26 2005 23:32:30}" >o 2>e &&
 	echo "$A" >expect &&
 	test_cmp expect o &&
 	test_must_be_empty e
 '
-test_expect_success 'Query "master@{2005-05-26 23:33:01}" (middle of history with gap)' '
+test_expect_success 'Query "main@{2005-05-26 23:33:01}" (middle of history with gap)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify "master@{2005-05-26 23:33:01}" >o 2>e &&
+	git rev-parse --verify "main@{2005-05-26 23:33:01}" >o 2>e &&
 	echo "$B" >expect &&
 	test_cmp expect o &&
 	test_i18ngrep -F "warning: log for ref $m has gap after $gd" e
 '
-test_expect_success 'Query "master@{2005-05-26 23:38:00}" (middle of history)' '
+test_expect_success 'Query "main@{2005-05-26 23:38:00}" (middle of history)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify "master@{2005-05-26 23:38:00}" >o 2>e &&
+	git rev-parse --verify "main@{2005-05-26 23:38:00}" >o 2>e &&
 	echo "$Z" >expect &&
 	test_cmp expect o &&
 	test_must_be_empty e
 '
-test_expect_success 'Query "master@{2005-05-26 23:43:00}" (exact end of history)' '
+test_expect_success 'Query "main@{2005-05-26 23:43:00}" (exact end of history)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify "master@{2005-05-26 23:43:00}" >o 2>e &&
+	git rev-parse --verify "main@{2005-05-26 23:43:00}" >o 2>e &&
 	echo "$E" >expect &&
 	test_cmp expect o &&
 	test_must_be_empty e
 '
-test_expect_success 'Query "master@{2005-05-28}" (past end of history)' '
+test_expect_success 'Query "main@{2005-05-28}" (past end of history)' '
 	test_when_finished "rm -f o e" &&
-	git rev-parse --verify "master@{2005-05-28}" >o 2>e &&
+	git rev-parse --verify "main@{2005-05-28}" >o 2>e &&
 	echo "$D" >expect &&
 	test_cmp expect o &&
 	test_i18ngrep -F "warning: log for ref $m unexpectedly ended on $ld" e
@@ -467,14 +468,14 @@ test_expect_success 'git commit logged updates' '
 '
 unset h_TEST h_OTHER h_FIXED h_MERGED
 
-test_expect_success 'git cat-file blob master:F (expect OTHER)' '
-	test OTHER = $(git cat-file blob master:F)
+test_expect_success 'git cat-file blob main:F (expect OTHER)' '
+	test OTHER = $(git cat-file blob main:F)
 '
-test_expect_success 'git cat-file blob master@{2005-05-26 23:30}:F (expect TEST)' '
-	test TEST = $(git cat-file blob "master@{2005-05-26 23:30}:F")
+test_expect_success 'git cat-file blob main@{2005-05-26 23:30}:F (expect TEST)' '
+	test TEST = $(git cat-file blob "main@{2005-05-26 23:30}:F")
 '
-test_expect_success 'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER)' '
-	test OTHER = $(git cat-file blob "master@{2005-05-26 23:42}:F")
+test_expect_success 'git cat-file blob main@{2005-05-26 23:42}:F (expect OTHER)' '
+	test OTHER = $(git cat-file blob "main@{2005-05-26 23:42}:F")
 '
 
 # Test adding and deleting pseudorefs
@@ -586,21 +587,21 @@ test_expect_success 'stdin fails on unknown command' '
 '
 
 test_expect_success 'stdin fails on unbalanced quotes' '
-	echo "create $a \"master" >stdin &&
+	echo "create $a \"main" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: badly quoted argument: \\\"master" err
+	grep "fatal: badly quoted argument: \\\"main" err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'stdin fails on invalid escape' '
+test_expect_success 'stdin fails on invalid escape' '
 	echo "create $a \"ma\zn\"" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
 	grep "fatal: badly quoted argument: \\\"ma\\\\zn\\\"" err
 '
 
 test_expect_success 'stdin fails on junk after quoted argument' '
-	echo "create \"$a\"master" >stdin &&
+	echo "create \"$a\"main" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: unexpected character after quoted argument: \\\"$a\\\"master" err
+	grep "fatal: unexpected character after quoted argument: \\\"$a\\\"main" err
 '
 
 test_expect_success 'stdin fails create with no ref' '
@@ -710,7 +711,7 @@ test_expect_success 'stdin succeeds with quoted argument' '
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'stdin succeeds with escaped character' '
+test_expect_success 'stdin succeeds with escaped character' '
 	git update-ref -d $a &&
 	echo "create $a \"ma\\151n\"" >stdin &&
 	git update-ref --stdin <stdin &&
-- 
gitgitgadget

