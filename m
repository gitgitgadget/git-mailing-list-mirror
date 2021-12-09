Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8FDC433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhLIFMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhLIFMR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:12:17 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5897CC061353
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:08:43 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v11so7619060wrw.10
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=0Y92AcPl9i5jOHUve52BWUnyLpiq93mHRcumTu4au7E=;
        b=YS/emLGbagdsnhlVXzTkbPf+3YeWVCkn1c299oxDJWtzcseWfj4t8i+FD7TzMikxdy
         G5wh7Hz4QIqmaP8JGrAO4UfKnndFrqVX84szcOFTZ8Pl5U6wOyeU+dnJzrtEqO3pgCtn
         s11oegbOB7GbMNVBAA6VGdAFapYJF+y18jSaoPh4PjmVG7WL2arraoO/5mWyoObcXPxr
         yO7uSTciyMaSfkGLQXm9QTxNDJ1KVUSOJhsLAfc3ml9efjzcKtFVE1HVHIJhRqROT64o
         E12/2XQcirdNknFjCKuoVRnvzcwZRnQV3zPJjjVSE+DSzE2EQjsm/67T8earmtQwyP5l
         SZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=0Y92AcPl9i5jOHUve52BWUnyLpiq93mHRcumTu4au7E=;
        b=pmAuaw25ZTKADdtVIkjFeHW4etPFvVJhJEyqSE5WZO8j4w8Zy1oU6U00qY3nw5GMcg
         UOJ9rnEK5eXZCbp0UHxVxZWiBndq0LUjQTMpeHWFJAXPaZYaMxf8W7M0O6QNGO5ij7GU
         3M9EUl40Ie4YDbRSq29iSlCZ5j0oYJshM7NWM6WGxUrahmXJ1Q06iCbMJrgH/i2NzLv+
         SBg5FFVx71bMYil+qLHmN120M4T4xnsLOiV1GDOqKTnMpwTZfNTwpE3UV0jw0REXOwE5
         fDeUB0CoDFvRgKMzoH1/RYuMQz2+zA3WDpnGFz0e2TPfUFuQgGo5Sf+o0n1Do29OP486
         QomA==
X-Gm-Message-State: AOAM530a9ZUqwPbL+TsT/7OegpOdY4WtKKmR/CnloTsGm4TfpQwjOE2O
        yKOiCO7vaL9WOBwjRuRofUvxKuKO37Q=
X-Google-Smtp-Source: ABdhPJw4/xXw9BIZvlhOfNWrY1ZT36CypMFkrK7EXUlyGE22dPcqSjBjGkayCkbRyKQcjQZGFVOZag==
X-Received: by 2002:adf:f602:: with SMTP id t2mr3737951wrp.539.1639026521772;
        Wed, 08 Dec 2021 21:08:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm4519800wrs.88.2021.12.08.21.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:08:41 -0800 (PST)
Message-Id: <e75f6c3f9ad3a808a7013f7ece3e2966df641381.1639026515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
References: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
        <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 05:08:29 +0000
Subject: [PATCH v6 05/11] symlinks: do not include startup_info->original_cwd
 in dir removal
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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

Acked-by: Derrick Stolee <stolee@gmail.com>
Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
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

