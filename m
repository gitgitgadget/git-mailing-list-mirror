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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298F1C4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011E322D74
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbgLQBIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 20:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730661AbgLQBIf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 20:08:35 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B65AC061257
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:20 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id g25so2933363wmh.1
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V7iEskZRu2XLZHFLJ5MWpIVX13qVIZzHMOlNM/+qDew=;
        b=VnoyuAObF5jRVlVsth7AdjAhnFhhKMB2mqEBvb0GLnnM18dq3J/id/BmmguHW94JeT
         l+E4ZDMvIBOHSUeflGMcyXsl1sMOiqF080MdUyqN0R151JgRuaR6txSUB9Az9OSAopOM
         6sAbEuiBwfRzAJ95nf/dwhYfMQ1n8b32hPl8nUPAC+MZPWxRdKqwsasKuQP7GFZ4UTga
         xBw00rn2zC7C5QrSVIq9ORYrRAEgPP6QlFz8WwLiaZXbzMvVC1C/jsBUogNcgCgKKwNB
         fqPI7QMyr3PH8Ryjmha9KYe2nLuRJUsjfYip7o17bOaiSuzSWvqwWA3Um4VrCvg9ufx3
         3GCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V7iEskZRu2XLZHFLJ5MWpIVX13qVIZzHMOlNM/+qDew=;
        b=aZyT8CfUYplnslTOtoevrdROG2w4jOjaRi0L8Lo1tM8r0XhaZ3NiOT4sd6po9CAVVV
         7UFAI3GmHta7Zt53lbmr+Fcad45A9Sb6iI3EHPjS8aWOibwqhVnlXzYd+dXdCiz1oIeE
         Dj7irzqqvuXY6N3xKrWU6E2U9idv+LeoIvsEBopg08/H2JMwEXtsVLBvoPCPuRMA4a7s
         Ig+Q2jgxzedW+lHm1eAsyxZrxG21NF5Nb948g9UunGnUNmKpcz+FaZ1KD98LvPwCzHTQ
         dD4iqeUVjHOc01VkIKTp28xG1KQiGGqKS+0GYX2xrarE2gpx+dgi3SnXcsf769bGUdwy
         VROQ==
X-Gm-Message-State: AOAM532/kpS1Ernmq186noyuUxG3JIsLqpFHsCQlgws8OuqjyWiHP9Sz
        flIsXt1oMqt4HNC/YYPE6bldghhWrCw=
X-Google-Smtp-Source: ABdhPJxLjk4jcNr17fJ0xMBQDGj9uvssC0a8EshNvWamF6knEbKfHLUHOl7aAi/QF8FvUkubEKacRg==
X-Received: by 2002:a1c:6856:: with SMTP id d83mr6055037wmc.119.1608167238529;
        Wed, 16 Dec 2020 17:07:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k10sm5203068wrq.38.2020.12.16.17.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 17:07:18 -0800 (PST)
Message-Id: <e87b344df47d9a1f46ed41c2c387ada83f356ab0.1608167230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.816.git.1608167230.gitgitgadget@gmail.com>
References: <pull.816.git.1608167230.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Dec 2020 01:07:07 +0000
Subject: [PATCH 08/11] t5703: use `main` as initial branch name
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

In 97cf8d50b59 (t5703: adjust a test case for the upcoming default
branch name, 2020-10-23), we prepared this test script for a world when
the default initial branch name would be `main`.

However, there is no need to wait for that: let's adjust the test script
to stop relying on a specific initial branch name by setting it
explicitly. This allows us to drop the `PREPARE_FOR_MAIN_BRANCH` prereq
from one test case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5703-upload-pack-ref-in-want.sh | 65 +++++++++++++++---------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index b46940b725b..eab966985b7 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -38,12 +38,13 @@ write_command () {
 
 # c(o/foo) d(o/bar)
 #        \ /
-#         b   e(baz)  f(master)
+#         b   e(baz)  f(main)
 #          \__  |  __/
 #             \ | /
 #               a
 test_expect_success 'setup repository' '
 	test_commit a &&
+	git branch -M main &&
 	git checkout -b o/foo &&
 	test_commit b &&
 	test_commit c &&
@@ -51,7 +52,7 @@ test_expect_success 'setup repository' '
 	test_commit d &&
 	git checkout -b baz a &&
 	test_commit e &&
-	git checkout master &&
+	git checkout main &&
 	test_commit f
 '
 
@@ -88,7 +89,7 @@ test_expect_success 'invalid want-ref line' '
 test_expect_success 'basic want-ref' '
 	oid=$(git rev-parse f) &&
 	cat >expected_refs <<-EOF &&
-	$oid refs/heads/master
+	$oid refs/heads/main
 	EOF
 	git rev-parse f >expected_commits &&
 
@@ -97,7 +98,7 @@ test_expect_success 'basic want-ref' '
 	$(write_command fetch)
 	0001
 	no-progress
-	want-ref refs/heads/master
+	want-ref refs/heads/main
 	have $oid
 	done
 	0000
@@ -135,7 +136,7 @@ test_expect_success 'multiple want-ref lines' '
 test_expect_success 'mix want and want-ref' '
 	oid=$(git rev-parse f) &&
 	cat >expected_refs <<-EOF &&
-	$oid refs/heads/master
+	$oid refs/heads/main
 	EOF
 	git rev-parse e f >expected_commits &&
 
@@ -143,7 +144,7 @@ test_expect_success 'mix want and want-ref' '
 	$(write_command fetch)
 	0001
 	no-progress
-	want-ref refs/heads/master
+	want-ref refs/heads/main
 	want $(git rev-parse e)
 	have $(git rev-parse a)
 	done
@@ -182,7 +183,7 @@ LOCAL_PRISTINE="$(pwd)/local_pristine"
 # $REPO
 # c(o/foo) d(o/bar)
 #        \ /
-#         b   e(baz)  f(master)
+#         b   e(baz)  f(main)
 #          \__  |  __/
 #             \ | /
 #               a
@@ -193,10 +194,10 @@ LOCAL_PRISTINE="$(pwd)/local_pristine"
 #		.
 #		.
 #		|
-#		a(master)
+#		a(main)
 test_expect_success 'setup repos for fetching with ref-in-want tests' '
 	(
-		git init "$REPO" &&
+		git init -b main "$REPO" &&
 		cd "$REPO" &&
 		test_commit a &&
 
@@ -209,7 +210,7 @@ test_expect_success 'setup repos for fetching with ref-in-want tests' '
 		test_commit_bulk --id=s 33 &&
 
 		# Add novel commits to upstream
-		git checkout master &&
+		git checkout main &&
 		cd "$REPO" &&
 		git checkout -b o/foo &&
 		test_commit b &&
@@ -218,7 +219,7 @@ test_expect_success 'setup repos for fetching with ref-in-want tests' '
 		test_commit d &&
 		git checkout -b baz a &&
 		test_commit e &&
-		git checkout master &&
+		git checkout main &&
 		test_commit f
 	) &&
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
@@ -245,12 +246,12 @@ test_expect_success 'fetching multiple refs' '
 
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch origin master baz &&
+	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch origin main baz &&
 
-	git -C "$REPO" rev-parse "master" "baz" >expected &&
-	git -C local rev-parse refs/remotes/origin/master refs/remotes/origin/baz >actual &&
+	git -C "$REPO" rev-parse "main" "baz" >expected &&
+	git -C local rev-parse refs/remotes/origin/main refs/remotes/origin/baz >actual &&
 	test_cmp expected actual &&
-	grep "want-ref refs/heads/master" log &&
+	grep "want-ref refs/heads/main" log &&
 	grep "want-ref refs/heads/baz" log
 '
 
@@ -261,13 +262,13 @@ test_expect_success 'fetching ref and exact OID' '
 	cp -r "$LOCAL_PRISTINE" local &&
 	oid=$(git -C "$REPO" rev-parse b) &&
 	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch origin \
-		master "$oid":refs/heads/actual &&
+		main "$oid":refs/heads/actual &&
 
-	git -C "$REPO" rev-parse "master" "b" >expected &&
-	git -C local rev-parse refs/remotes/origin/master refs/heads/actual >actual &&
+	git -C "$REPO" rev-parse "main" "b" >expected &&
+	git -C local rev-parse refs/remotes/origin/main refs/heads/actual >actual &&
 	test_cmp expected actual &&
 	grep "want $oid" log &&
-	grep "want-ref refs/heads/master" log
+	grep "want-ref refs/heads/main" log
 '
 
 test_expect_success 'fetching with wildcard that does not match any refs' '
@@ -301,7 +302,7 @@ LOCAL_PRISTINE="$(pwd)/local_pristine"
 
 test_expect_success 'setup repos for change-while-negotiating test' '
 	(
-		git init "$REPO" &&
+		git init -b main "$REPO" &&
 		cd "$REPO" &&
 		>.git/git-daemon-export-ok &&
 		test_commit m1 &&
@@ -316,7 +317,7 @@ test_expect_success 'setup repos for change-while-negotiating test' '
 		test_commit_bulk --id=s 33 &&
 
 		# Add novel commits to upstream
-		git checkout master &&
+		git checkout main &&
 		cd "$REPO" &&
 		test_commit m2 &&
 		test_commit m3 &&
@@ -342,7 +343,7 @@ test_expect_success 'server is initially ahead - no ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant false &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master $(test_oid numeric) &&
+	inconsistency main $(test_oid numeric) &&
 	test_must_fail git -C local fetch 2>err &&
 	test_i18ngrep "fatal: remote error: upload-pack: not our ref" err
 '
@@ -351,11 +352,11 @@ test_expect_success 'server is initially ahead - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master $(test_oid numeric) &&
+	inconsistency main $(test_oid numeric) &&
 	git -C local fetch &&
 
-	git -C "$REPO" rev-parse --verify master >expected &&
-	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
+	git -C "$REPO" rev-parse --verify main >expected &&
+	git -C local rev-parse --verify refs/remotes/origin/main >actual &&
 	test_cmp expected actual
 '
 
@@ -363,11 +364,11 @@ test_expect_success 'server is initially behind - no ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant false &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master "master^" &&
+	inconsistency main "main^" &&
 	git -C local fetch &&
 
-	git -C "$REPO" rev-parse --verify "master^" >expected &&
-	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
+	git -C "$REPO" rev-parse --verify "main^" >expected &&
+	git -C local rev-parse --verify refs/remotes/origin/main >actual &&
 	test_cmp expected actual
 '
 
@@ -375,15 +376,15 @@ test_expect_success 'server is initially behind - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master "master^" &&
+	inconsistency main "main^" &&
 	git -C local fetch &&
 
-	git -C "$REPO" rev-parse --verify "master" >expected &&
-	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
+	git -C "$REPO" rev-parse --verify "main" >expected &&
+	git -C local rev-parse --verify refs/remotes/origin/main >actual &&
 	test_cmp expected actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'server loses a ref - ref in want' '
+test_expect_success 'server loses a ref - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-- 
gitgitgadget

