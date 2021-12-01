Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA18C433FE
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 06:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346993AbhLAGo2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 01:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346971AbhLAGoW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 01:44:22 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA9EC06174A
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:41:01 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u1so49748908wru.13
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y6e6DJjOLA76Rnh6opqKzqo0Sbz1NZ457xgX99zBAhY=;
        b=R51+nWmBYVs/j0BMv9fnAfo2ZcCj3c/Dr21yprGN19OvONsgkWrjAfJeoRfKbkOj7g
         twJygJtckBrYoXi2+2omCZt5WSOXl2aTeSlnRnHtitdLfMeQ9aIYhY+ZkrETgl1W80mm
         j4epGkRBkmJxw1dDwspd37imcJJDz5Qw9pQv4D3+NAzgmiPDq89h09FhtjLI+SsijpKu
         rQqpVVcOl9mrbpvLipxvMggwGhk4e9gEYdy25CNVZCeWcVQOt1S5e99+XwRQsgs6uk/N
         m63j88/jhmQN1p3/I1AFBZa/+O5G7UY+Lw25xFsDMo+spszN23q2UWDNaXjm4/rVNzUV
         h0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y6e6DJjOLA76Rnh6opqKzqo0Sbz1NZ457xgX99zBAhY=;
        b=VktpgQ/SKm6Llfur7qO28lr8Sa8LxHtHZkd7cBmXZcj2B8BJP2LaBazvxdijk4hKkL
         sze/5R2SXS1NMRmAMG44MZIOgFc97pOpbpA6oX4dF+B/gifBHIW31jp061RAP17kAZw9
         QgZJZ6vfY7P9Uo2YZVdjL/9b/kgIHd4J7RODaFVkWlYzu++szKyCGDzz7BSDL+Yz4ahg
         jzxERw8K6mqWaOEfA2DTVQaemPuv5zKAuRsKFHIeWfwT66TvAnHHKrplPxlnm67037ck
         8vuDhZyUbPHBzgboFhhCdeuxRpBc5kgT1jaF0czva4aAevluv+dEmCcH4M1QT2+Tc3+8
         Ts2g==
X-Gm-Message-State: AOAM531gz7HiGpO0yGK7X/JUul742noc9FgDrHsvhcC6mq2Y++1+xjDg
        ihZHQHRQqsk9EOTO7+koMd4qnDfIdLE=
X-Google-Smtp-Source: ABdhPJxG857IelJsEv8L/6l/wIsmtkzPWd70S18qV5xVEVukdnFBKMTiVcDACc2FJdZX2c6t+8Kkkg==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr4427793wro.461.1638340860367;
        Tue, 30 Nov 2021 22:41:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b11sm142wmj.35.2021.11.30.22.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 22:41:00 -0800 (PST)
Message-Id: <66ef6b4d9432d3725b48c19179bbf3095092e00e.1638340854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
        <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 06:40:48 +0000
Subject: [PATCH v5 05/11] symlinks: do not include startup_info->original_cwd
 in dir removal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

symlinks has a pair of schedule_dir_for_removal() and
remove_scheduled_dirs() functions that ensure that directories made
empty by removing other files also themselves get removed.  However, we
want to exclude startup_info->original_cwd and leave it around.  This
avoids the user getting confused by subsequent git commands (and non-git
commands) that would otherwise report confusing messages about being
unable to read the current working directory.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 symlinks.c           |  8 +++++++-
 t/t2501-cwd-empty.sh | 10 +++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 5232d02020c..c667baa949b 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -279,7 +279,9 @@ static void do_remove_scheduled_dirs(int new_len)
 {
 	while (removal.len > new_len) {
 		removal.buf[removal.len] = '\0';
-		if (rmdir(removal.buf))
+		if ((startup_info->original_cwd &&
+		     !strcmp(removal.buf, startup_info->original_cwd)) ||
+		    rmdir(removal.buf))
 			break;
 		do {
 			removal.len--;
@@ -293,6 +295,10 @@ void schedule_dir_for_removal(const char *name, int len)
 {
 	int match_len, last_slash, i, previous_slash;
 
+	if (startup_info->original_cwd &&
+	    !strcmp(name, startup_info->original_cwd))
+		return;	/* Do not remove the current working directory */
+
 	match_len = last_slash = i =
 		longest_path_match(name, len, removal.buf, removal.len,
 				   &previous_slash);
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 5af1fec6fec..e4502d24d57 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -109,7 +109,7 @@ test_required_dir_removal () {
 }
 
 test_expect_success 'checkout does not clean cwd incidentally' '
-	test_incidental_dir_removal failure git checkout init
+	test_incidental_dir_removal success git checkout init
 '
 
 test_expect_success 'checkout fails if cwd needs to be removed' '
@@ -117,7 +117,7 @@ test_expect_success 'checkout fails if cwd needs to be removed' '
 '
 
 test_expect_success 'reset --hard does not clean cwd incidentally' '
-	test_incidental_dir_removal failure git reset --hard init
+	test_incidental_dir_removal success git reset --hard init
 '
 
 test_expect_success 'reset --hard fails if cwd needs to be removed' '
@@ -125,7 +125,7 @@ test_expect_success 'reset --hard fails if cwd needs to be removed' '
 '
 
 test_expect_success 'merge does not clean cwd incidentally' '
-	test_incidental_dir_removal failure git merge reverted
+	test_incidental_dir_removal success git merge reverted
 '
 
 # This file uses some simple merges where
@@ -158,7 +158,7 @@ test_expect_success 'merge fails if cwd needs to be removed' '
 '
 
 test_expect_success 'cherry-pick does not clean cwd incidentally' '
-	test_incidental_dir_removal failure git cherry-pick reverted
+	test_incidental_dir_removal success git cherry-pick reverted
 '
 
 test_expect_success 'cherry-pick fails if cwd needs to be removed' '
@@ -174,7 +174,7 @@ test_expect_success 'rebase fails if cwd needs to be removed' '
 '
 
 test_expect_success 'revert does not clean cwd incidentally' '
-	test_incidental_dir_removal failure git revert HEAD
+	test_incidental_dir_removal success git revert HEAD
 '
 
 test_expect_success 'revert fails if cwd needs to be removed' '
-- 
gitgitgadget

