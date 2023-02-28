Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ED8C64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 18:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjB1S5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 13:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjB1S5B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 13:57:01 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4BE301AA
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 10:56:57 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id v15-20020a17090a458f00b0023816b2f381so2622065pjg.2
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 10:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8okqx69KRhetVgOni9lfppGj+2TmeavnXyZbZcLi3fg=;
        b=NahEo1xSXCTyA2XvtQP/69P5J79VW6qlUq7b9fjNUDvTdmla5n/GKaSQQathX4MEqr
         xgyXQj8OZ3ErE1zAnLlNWmPPDLxVM7FEl5oWslAswLDhmqHEDrSUykB2dSxLIuLcgveN
         3df/RrOOkqI3I1dvTCJdwblN/xGNHYusbW2w8H/nMTelLy/RPSJ8yLJMeYIsFVVuXQHI
         H4staSKskczZlsunjhyGndSYpdwz2uUZ1ija+ry07jfh9a8QUP+98asPnSLUISW5BkJx
         LeJKBWSFz1xFH9QKU5GKXx+wlSQ1XzeDwyLhnywKLazjPJZtu4ynHOr3wuUIFdyy203b
         0xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8okqx69KRhetVgOni9lfppGj+2TmeavnXyZbZcLi3fg=;
        b=Puh1PqhoV4HBvkFaKFNQTn1qfG39CP7wrsMt5BHO/ERW3Pst12lIVM9kutws8I8D/l
         7sHmMsvpW0pIyw8yBI4Cl1DN5jRPXmrEElU/tC3tiJloRXPQYiNnVKvlkre8TbbLVmPg
         M8nZLdVzHqvDDe5nvhJAlqndp6vUoZ6ynLzP3csuc74F1IIlcS/ybAYwSfAa8J8I3Q6W
         GA95d+V+AdcMi4mLxuVcVd/MClaofx6EckpMzpjgyi6x+jxl0Ye05e2/SB3NYkgt2X45
         L6/ULvKI2Xfe2AFAYrXRdr5iJzQlzSMEM5GdDmkAGeYQ+DjhAif8PqUzRZZorMJbz/Je
         JX9w==
X-Gm-Message-State: AO0yUKXMPqymURSIkKDXPS7lKYUhbPcoQ+xMuesRRI7Gpqx9Iz4pIZKN
        KgkbS6w4/OwoAG015ENpdB4AXYTkj3FcrNt08u08AAF1HgRoq2qFqrxJbs3Jk5uKLfnR/PgjFqg
        syYMISuARDR5q1fix9h20E7F5Fc7mAqy6IoAIz9CLvq+G/mRWlNOMNQQa3hifTDZ5wQ==
X-Google-Smtp-Source: AK7set/R6EQKOQ7L2suV/ofv0YmiIONQ5V7GVsy/aUcLPLSYh96pcVgzA+IEzp6X8Bt7cvYYrWXL1ck7gMOeB1A=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:f782:b0:19a:7bd4:5b0d with SMTP
 id q2-20020a170902f78200b0019a7bd45b0dmr1327087pln.8.1677610617050; Tue, 28
 Feb 2023 10:56:57 -0800 (PST)
Date:   Tue, 28 Feb 2023 18:56:41 +0000
In-Reply-To: <20230228185253.2356546-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230228185642.2357806-5-calvinwan@google.com>
Subject: [PATCH v2 5/6] tests: remove duplicate .gitmodules path
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, steadmon@google.com,
        peff@peff.net, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Swapping `git add <submodule>` to `git submodule add <submodule>`
in a previous patch created a .gitmodules file with multiple
submodules pointing to the same path in certain tests. Fix tests
so that they are run on the original added submodule rather than
a separate manually configured submodule.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 t/t4027-diff-submodule.sh |  41 ++++++--------
 t/t7508-status.sh         | 114 +++++++++++++++-----------------------
 2 files changed, 62 insertions(+), 93 deletions(-)

diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 2ee9f18b38..ce335534b9 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -127,36 +127,33 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)
 	git config diff.ignoreSubmodules dirty &&
 	git diff HEAD >actual &&
 	test_must_be_empty actual &&
-	git config --add -f .gitmodules submodule.subname.ignore none &&
-	git config --add -f .gitmodules submodule.subname.path sub &&
+	git config --add -f .gitmodules submodule.sub.ignore none &&
 	git commit -m "Update .gitmodules" .gitmodules &&
 	git diff HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual.body &&
-	git config -f .gitmodules submodule.subname.ignore all &&
-	git config -f .gitmodules submodule.subname.path sub &&
+	git config -f .gitmodules submodule.sub.ignore all &&
 	git commit -m "Update .gitmodules" .gitmodules &&
 	git diff HEAD >actual2 &&
 	test_must_be_empty actual2 &&
-	git config -f .gitmodules submodule.subname.ignore untracked &&
+	git config -f .gitmodules submodule.sub.ignore untracked &&
 	git commit -m "Update .gitmodules" .gitmodules &&
 	git diff HEAD >actual3 &&
 	sed -e "1,/^@@/d" actual3 >actual3.body &&
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual3.body &&
-	git config -f .gitmodules submodule.subname.ignore dirty &&
+	git config -f .gitmodules submodule.sub.ignore dirty &&
 	git commit -m "Update .gitmodules" .gitmodules &&
 	git diff HEAD >actual4 &&
 	test_must_be_empty actual4 &&
-	git config submodule.subname.ignore none &&
-	git config submodule.subname.path sub &&
+	git config submodule.sub.ignore none &&
+	git config submodule.sub.path sub &&
 	git diff HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual.body &&
-	git config --remove-section submodule.subname &&
-	git config --remove-section -f .gitmodules submodule.subname &&
+	git config --unset submodule.sub.ignore &&
 	git config --unset diff.ignoreSubmodules &&
 	git reset --hard pristine-gitmodules
 '
@@ -194,27 +191,24 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
 '
 
 test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match) [.gitmodules]' '
-	git config --add -f .gitmodules submodule.subname.ignore all &&
-	git config --add -f .gitmodules submodule.subname.path sub &&
+	git config --add -f .gitmodules submodule.sub.ignore all &&
 	git commit -m "Update .gitmodules" .gitmodules &&
 	git diff HEAD >actual2 &&
 	test_must_be_empty actual2 &&
-	git config -f .gitmodules submodule.subname.ignore untracked &&
+	git config -f .gitmodules submodule.sub.ignore untracked &&
 	git commit -m "Update .gitmodules" .gitmodules &&
 	git diff HEAD >actual3 &&
 	test_must_be_empty actual3 &&
-	git config -f .gitmodules submodule.subname.ignore dirty &&
+	git config -f .gitmodules submodule.sub.ignore dirty &&
 	git commit -m "Update .gitmodules" .gitmodules &&
 	git diff HEAD >actual4 &&
 	test_must_be_empty actual4 &&
-	git config submodule.subname.ignore none &&
-	git config submodule.subname.path sub &&
+	git config submodule.sub.ignore none &&
 	git diff HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual.body &&
-	git config --remove-section submodule.subname &&
-	git config --remove-section -f .gitmodules submodule.subname &&
+	git config --unset submodule.sub.ignore &&
 	git reset --hard pristine-gitmodules
 '
 
@@ -236,22 +230,19 @@ test_expect_success 'git diff between submodule commits [.gitmodules]' '
 	sed -e "1,/^@@/d" actual >actual.body &&
 	expect_from_to >expect.body $subtip $subprev &&
 	test_cmp expect.body actual.body &&
-	git config --add -f .gitmodules submodule.subname.ignore dirty &&
-	git config --add -f .gitmodules submodule.subname.path sub &&
+	git config --add -f .gitmodules submodule.sub.ignore dirty &&
 	git diff HEAD^..HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
 	expect_from_to >expect.body $subtip $subprev &&
 	test_cmp expect.body actual.body &&
-	git config -f .gitmodules submodule.subname.ignore all &&
+	git config -f .gitmodules submodule.sub.ignore all &&
 	git diff HEAD^..HEAD >actual &&
 	test_must_be_empty actual &&
-	git config submodule.subname.ignore dirty &&
-	git config submodule.subname.path sub &&
+	git config submodule.sub.ignore dirty &&
 	git diff  HEAD^..HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
 	expect_from_to >expect.body $subtip $subprev &&
-	git config --remove-section submodule.subname &&
-	git config --remove-section -f .gitmodules submodule.subname &&
+	git config --unset submodule.sub.ignore &&
 	git reset --hard pristine-gitmodules
 '
 
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 5808339997..3d934bfb86 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1154,8 +1154,7 @@ test_expect_success '.gitmodules ignore=untracked suppresses submodules with unt
 	test_config diff.ignoreSubmodules dirty &&
 	git status >output &&
 	test_cmp expect output &&
-	git config --add -f .gitmodules submodule.subname.ignore untracked &&
-	git config --add -f .gitmodules submodule.subname.path sm &&
+	git config --add -f .gitmodules submodule.sm.ignore untracked &&
 	cat > expect-modified-gitmodules << EOF &&
 On branch main
 Your branch and '\''upstream'\'' have diverged,
@@ -1187,18 +1186,16 @@ Untracked files:
 EOF
 	git status >output &&
 	test_cmp expect-modified-gitmodules output &&
-	git config -f .gitmodules  --remove-section submodule.subname
+	git config -f .gitmodules --unset submodule.sm.ignore
 '
 
 test_expect_success '.git/config ignore=untracked suppresses submodules with untracked content' '
-	git config --add -f .gitmodules submodule.subname.ignore none &&
-	git config --add -f .gitmodules submodule.subname.path sm &&
-	git config --add submodule.subname.ignore untracked &&
-	git config --add submodule.subname.path sm &&
+	git config --add -f .gitmodules submodule.sm.ignore none &&
+	git config --add submodule.sm.ignore untracked &&
 	git status >output &&
 	test_cmp expect-modified-gitmodules output &&
-	git config --remove-section submodule.subname &&
-	git config --remove-section -f .gitmodules submodule.subname
+	git config --unset submodule.sm.ignore &&
+	git config -f .gitmodules --unset submodule.sm.ignore
 '
 
 test_expect_success '--ignore-submodules=dirty suppresses submodules with untracked content' '
@@ -1210,22 +1207,19 @@ test_expect_success '.gitmodules ignore=dirty suppresses submodules with untrack
 	test_config diff.ignoreSubmodules dirty &&
 	git status >output &&
 	! test -s actual &&
-	git config --add -f .gitmodules submodule.subname.ignore dirty &&
-	git config --add -f .gitmodules submodule.subname.path sm &&
+	git config --add -f .gitmodules submodule.sm.ignore dirty &&
 	git status >output &&
 	test_cmp expect-modified-gitmodules output &&
-	git config -f .gitmodules  --remove-section submodule.subname
+	git config -f .gitmodules --unset submodule.sm.ignore
 '
 
 test_expect_success '.git/config ignore=dirty suppresses submodules with untracked content' '
-	git config --add -f .gitmodules submodule.subname.ignore none &&
-	git config --add -f .gitmodules submodule.subname.path sm &&
-	git config --add submodule.subname.ignore dirty &&
-	git config --add submodule.subname.path sm &&
+	git config --add -f .gitmodules submodule.sm.ignore none &&
+	git config --add submodule.sm.ignore dirty &&
 	git status >output &&
 	test_cmp expect-modified-gitmodules output &&
-	git config --remove-section submodule.subname &&
-	git config -f .gitmodules  --remove-section submodule.subname
+	git config --unset submodule.sm.ignore &&
+	git config -f .gitmodules --unset submodule.sm.ignore
 '
 
 test_expect_success '--ignore-submodules=dirty suppresses submodules with modified content' '
@@ -1235,22 +1229,19 @@ test_expect_success '--ignore-submodules=dirty suppresses submodules with modifi
 '
 
 test_expect_success '.gitmodules ignore=dirty suppresses submodules with modified content' '
-	git config --add -f .gitmodules submodule.subname.ignore dirty &&
-	git config --add -f .gitmodules submodule.subname.path sm &&
+	git config --add -f .gitmodules submodule.sm.ignore dirty &&
 	git status >output &&
 	test_cmp expect-modified-gitmodules output &&
-	git config -f .gitmodules  --remove-section submodule.subname
+	git config -f .gitmodules --unset submodule.sm.ignore
 '
 
 test_expect_success '.git/config ignore=dirty suppresses submodules with modified content' '
-	git config --add -f .gitmodules submodule.subname.ignore none &&
-	git config --add -f .gitmodules submodule.subname.path sm &&
-	git config --add submodule.subname.ignore dirty &&
-	git config --add submodule.subname.path sm &&
+	git config --add -f .gitmodules submodule.sm.ignore none &&
+	git config --add submodule.sm.ignore dirty &&
 	git status >output &&
 	test_cmp expect-modified-gitmodules output &&
-	git config --remove-section submodule.subname &&
-	git config -f .gitmodules  --remove-section submodule.subname
+	git config --unset submodule.sm.ignore &&
+	git config -f .gitmodules --unset submodule.sm.ignore
 '
 
 test_expect_success "--ignore-submodules=untracked doesn't suppress submodules with modified content" '
@@ -1289,8 +1280,7 @@ EOF
 '
 
 test_expect_success ".gitmodules ignore=untracked doesn't suppress submodules with modified content" '
-	git config --add -f .gitmodules submodule.subname.ignore untracked &&
-	git config --add -f .gitmodules submodule.subname.path sm &&
+	git config --add -f .gitmodules submodule.sm.ignore untracked &&
 	cat > expect-modified-gitmodules << EOF &&
 On branch main
 Your branch and '\''upstream'\'' have diverged,
@@ -1324,18 +1314,16 @@ Untracked files:
 EOF
 	git status >output &&
 	test_cmp expect-modified-gitmodules output &&
-	git config -f .gitmodules  --remove-section submodule.subname
+	git config -f .gitmodules --unset submodule.sm.ignore
 '
 
 test_expect_success ".git/config ignore=untracked doesn't suppress submodules with modified content" '
-	git config --add -f .gitmodules submodule.subname.ignore none &&
-	git config --add -f .gitmodules submodule.subname.path sm &&
-	git config --add submodule.subname.ignore untracked &&
-	git config --add submodule.subname.path sm &&
+	git config --add -f .gitmodules submodule.sm.ignore none &&
+	git config --add submodule.sm.ignore untracked &&
 	git status >output &&
 	test_cmp expect-modified-gitmodules output &&
-	git config --remove-section submodule.subname &&
-	git config -f .gitmodules  --remove-section submodule.subname
+	git config --unset submodule.sm.ignore &&
+	git config -f .gitmodules --unset submodule.sm.ignore
 '
 
 head2=$(cd sm && git commit -q -m "2nd commit" foo && git rev-parse --short=7 --verify HEAD)
@@ -1415,22 +1403,19 @@ Untracked files:
 	untracked
 
 EOF
-	git config --add -f .gitmodules submodule.subname.ignore untracked &&
-	git config --add -f .gitmodules submodule.subname.path sm &&
+	git config --add -f .gitmodules submodule.sm.ignore untracked &&
 	git status >output &&
 	test_cmp expect-modified-gitmodules output &&
-	git config -f .gitmodules  --remove-section submodule.subname
+	git config -f .gitmodules --unset submodule.sm.ignore
 '
 
 test_expect_success ".git/config ignore=untracked doesn't suppress submodule summary" '
-	git config --add -f .gitmodules submodule.subname.ignore none &&
-	git config --add -f .gitmodules submodule.subname.path sm &&
-	git config --add submodule.subname.ignore untracked &&
-	git config --add submodule.subname.path sm &&
+	git config --add -f .gitmodules submodule.sm.ignore none &&
+	git config --add submodule.sm.ignore untracked &&
 	git status >output &&
 	test_cmp expect-modified-gitmodules output &&
-	git config --remove-section submodule.subname &&
-	git config -f .gitmodules  --remove-section submodule.subname
+	git config --unset submodule.sm.ignore &&
+	git config -f .gitmodules --unset submodule.sm.ignore
 '
 
 test_expect_success "--ignore-submodules=dirty doesn't suppress submodule summary" '
@@ -1438,22 +1423,19 @@ test_expect_success "--ignore-submodules=dirty doesn't suppress submodule summar
 	test_cmp expect output
 '
 test_expect_success ".gitmodules ignore=dirty doesn't suppress submodule summary" '
-	git config --add -f .gitmodules submodule.subname.ignore dirty &&
-	git config --add -f .gitmodules submodule.subname.path sm &&
+	git config --add -f .gitmodules submodule.sm.ignore dirty &&
 	git status >output &&
 	test_cmp expect-modified-gitmodules output &&
-	git config -f .gitmodules  --remove-section submodule.subname
+	git config -f .gitmodules --unset submodule.sm.ignore
 '
 
 test_expect_success ".git/config ignore=dirty doesn't suppress submodule summary" '
-	git config --add -f .gitmodules submodule.subname.ignore none &&
-	git config --add -f .gitmodules submodule.subname.path sm &&
-	git config --add submodule.subname.ignore dirty &&
-	git config --add submodule.subname.path sm &&
+	git config --add -f .gitmodules submodule.sm.ignore none &&
+	git config --add submodule.sm.ignore dirty &&
 	git status >output &&
 	test_cmp expect-modified-gitmodules output &&
-	git config --remove-section submodule.subname &&
-	git config -f .gitmodules  --remove-section submodule.subname
+	git config --unset submodule.sm.ignore &&
+	git config -f .gitmodules --unset submodule.sm.ignore
 '
 
 cat > expect << EOF
@@ -1552,22 +1534,19 @@ Untracked files:
 	untracked
 
 EOF
-	git config --add -f .gitmodules submodule.subname.ignore all &&
-	git config --add -f .gitmodules submodule.subname.path sm &&
+	git config --add -f .gitmodules submodule.sm.ignore all &&
 	git status > output &&
 	test_cmp expect output &&
-	git config -f .gitmodules  --remove-section submodule.subname
+	git config -f .gitmodules --unset submodule.sm.ignore
 '
 
 test_expect_success '.git/config ignore=all suppresses unstaged submodule summary' '
-	git config --add -f .gitmodules submodule.subname.ignore none &&
-	git config --add -f .gitmodules submodule.subname.path sm &&
-	git config --add submodule.subname.ignore all &&
-	git config --add submodule.subname.path sm &&
+	git config --add -f .gitmodules submodule.sm.ignore none &&
+	git config --add submodule.sm.ignore all &&
 	git status > output &&
 	test_cmp expect output &&
-	git config --remove-section submodule.subname &&
-	git config -f .gitmodules  --remove-section submodule.subname
+	git config --unset submodule.sm.ignore &&
+	git config -f .gitmodules --unset submodule.sm.ignore
 '
 
 test_expect_success 'setup of test environment' '
@@ -1633,9 +1612,8 @@ test_expect_success 'Restore default test environment' '
 '
 
 test_expect_success 'git commit will commit a staged but ignored submodule' '
-	git config --add -f .gitmodules submodule.subname.ignore all &&
-	git config --add -f .gitmodules submodule.subname.path sm &&
-	git config --add submodule.subname.ignore all &&
+	git config --add -f .gitmodules submodule.sm.ignore all &&
+	git config --add submodule.sm.ignore all &&
 	git status -s --ignore-submodules=dirty >output &&
 	test_i18ngrep "^M. sm" output &&
 	GIT_EDITOR="echo hello >>\"\$1\"" &&
@@ -1676,8 +1654,8 @@ test_expect_success 'git commit -m will commit a staged but ignored submodule' '
 	git commit -uno -m message &&
 	git status -s --ignore-submodules=dirty >output &&
 	test_i18ngrep ! "^M. sm" output &&
-	git config --remove-section submodule.subname &&
-	git config -f .gitmodules  --remove-section submodule.subname
+	git config --unset submodule.sm.ignore &&
+	git config -f .gitmodules --unset submodule.sm.ignore
 '
 
 test_expect_success 'show stash info with "--show-stash"' '
-- 
2.39.2.722.g9855ee24e9-goog

