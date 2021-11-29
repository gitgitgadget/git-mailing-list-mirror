Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B74C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbhK2XNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237504AbhK2XMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:12:54 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21125C0800E6
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:21 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so13428652wmd.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gKqn3x76Ww+gfRjsPu/xHCfgS67G1ymu/qVlq7O7Om8=;
        b=hy/5Dwy6uTYXC9pwtUod9PWAKSTJXNAaFW7DcDb3Z/mJiAe5Oz4AFYouKqxXamdic6
         F1c20WLeYviUYaF5tAVFKdHYBPsrU1vVtfhC0NQPmGGNqvzBkdkMSUG/DgIfiP0RZVDA
         EgTkHvNwqFX8GJ35lAYlQHBTEFsGL6grg/HkZ5nenzUq8ozfBNTC6Wt86ihGKjIlPi5O
         rch+/Mtdb2bQDRSf60jvTadUjd7+pDFItVyOvtl1TAhumaSfgSdssQaiWcyAd1z8SnCI
         do00AUPwRrNP4znsSwqES4ZidG0ANHM3aCUuzsrAjOXmWPCcp6FCFBO2uZc63KzhQbLe
         gyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gKqn3x76Ww+gfRjsPu/xHCfgS67G1ymu/qVlq7O7Om8=;
        b=wfytqbuoJylfZVtBghrgfq+0ce+zTLjtlQ+otRIBhmsADuWqpyh2ZkL2mN1Ih+mF9D
         Otlc/64bY1O0sQO+xl7Xu2PObqskbLgNpdru6bkI3DQiMday+ppAu+lvQj2TpUhzk2FP
         76ejqazHdXeSHua2Y80fEj7R1yVPLkR1F0YsIb0fzWwpxbwQOeS/yROPCIVrWYMA5Woo
         7bd7oy7hd7IZ9crcTISIRWP/K0E72mUs0FZa4wQShd9+rVvJeijSRWvh+js9F01I/rdM
         ieqb9ZkwhF+uGtc1i0sZDE7X/eQx5GC9xHRSumjyekYK2JaHcxePWzXj24OMln5E52XB
         rj4g==
X-Gm-Message-State: AOAM531balUwZf/4gpVvso8mZg2ZoqsOi8jz+lisPS06uz+K6N/kXd4c
        WY/pK3a935O336H5MoO+nY8jk6W7UzI=
X-Google-Smtp-Source: ABdhPJwMlPg2bdrSAJMx3ZYA0F7OFhg2mrLf2aN4J8qQ+Sp9qvv13WE9ULDKOb48UMQeiuekfn+rZg==
X-Received: by 2002:a1c:f70c:: with SMTP id v12mr878664wmh.18.1638225439586;
        Mon, 29 Nov 2021 14:37:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 21sm530706wmj.18.2021.11.29.14.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:37:19 -0800 (PST)
Message-Id: <f444a541da44c9fb16d9d3dea37f85cfc0c2edcf.1638225434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
References: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
        <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 22:37:08 +0000
Subject: [PATCH v4 05/11] symlinks: do not include startup_info->original_cwd
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
index 10e4654042c..50619de10aa 100755
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

