Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D745DC43331
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B842E652AD
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhCIGZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 01:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCIGYx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 01:24:53 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79424C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 22:24:53 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e10so13889897wro.12
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 22:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RjXqIGfs6xg6JMfPfkR6AO1ReuEMf1tdF6If1ZnSgZM=;
        b=mjzLrv3H78GtT6naKkBeSvUswbSH1SwriLA9kVdOniwuuqkEPEpTZMz56N7nXK23Tz
         MlRu90mMFf+Oe4INJVOUWnESD6zlVOgFN0lQmKoq3O7wh+niWnGHaqEPpjjqfR0XMo6q
         h6fkwZ+TBLPsIQ5ET11L+whh98HKNyXgHGDihUx12OhyREAijMwO/5JDOKqV9VskCuQg
         ldpezjyNWrJIQ6aRQpieU2lD/bn4lbqHLsyz9crbicfRo5w41b7d7tfBWc+NG5W9DmnL
         eHXnXJ2fWYPhewtbOuWBGEyuDOQZRfJg3/CHp5BOPwZ28+xR0tmOm1ZzTG7C9fx3+elv
         GkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RjXqIGfs6xg6JMfPfkR6AO1ReuEMf1tdF6If1ZnSgZM=;
        b=c14KWq72hzq6PGrY8DV6BKiuQbqPletPbEvsCtcjRQmbqfeXSsoKtoCqRWUYi4kfeF
         KH8BUAWDTvlQ2swEBvRWCW03fKB3uVisjzvon0fXxY7eyTF8PVghE7yuu1zMQqabwH9T
         MujgqveF59puQOErllBuQ5P7u/AxIDqmIXsvfLiv+DoSGM8oJRDnlZL+cI1THVW4nLol
         Lz5Fy1JrtIaVOjm3um/wfnBke3A7Z4FNnOg0t1isiA1EUTidvr7eKgbC4rLxAV1howVH
         GvFZqyLKuB3IX5PC2b3JesFuZBOFzOQPquQxtGPsNbL257mZw4djFrOWl/7kKhBGYQ6w
         BNvg==
X-Gm-Message-State: AOAM532OSk0pF7XXuInaFCPS7nf3vHG+51F7tlVAd9mCx4oDarXfHE2I
        3dpnLjpgXYt1LLpbEFPTC6RatyWklrc=
X-Google-Smtp-Source: ABdhPJxMPvnXf328c4hP7EnkRt0esdTKPrMySNfkCmZzpsfowY3d13TtNI5gYmzxrSsH6wAPRn0rrA==
X-Received: by 2002:adf:e603:: with SMTP id p3mr26746900wrm.360.1615271092314;
        Mon, 08 Mar 2021 22:24:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q15sm22667286wrr.58.2021.03.08.22.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 22:24:52 -0800 (PST)
Message-Id: <fcce88c5ac3d317007fd2435f97a9264810e9a22.1615271086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
        <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 06:24:43 +0000
Subject: [PATCH v2 08/10] t: mark several submodule merging tests as fixed
 under merge-ort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

merge-ort handles submodules (and directory/file conflicts in general)
differently than merge-recursive does; it basically puts all the special
handling for different filetypes into one place in the codebase instead
of needing special handling for different filetypes in many different
code paths.  This one code path in merge-ort could perhaps use some work
still (there are still test_expect_failure cases in the testsuite), but
it passes all the tests that merge-recursive does as well as 12
additional ones that merge-recursive fails.  Mark those 12 tests as
test_expect_success under merge-ort.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3512-cherry-pick-submodule.sh              | 7 +++++--
 t/t3513-revert-submodule.sh                   | 5 ++++-
 t/t5572-pull-submodule.sh                     | 7 +++++--
 t/t6437-submodule-merge.sh                    | 5 +++--
 t/t6438-submodule-directory-file-conflicts.sh | 7 +++++--
 5 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodule.sh
index 822f2d4bfbd5..c657840db33b 100755
--- a/t/t3512-cherry-pick-submodule.sh
+++ b/t/t3512-cherry-pick-submodule.sh
@@ -8,8 +8,11 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
-KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
+if test "$GIT_TEST_MERGE_ALGORITHM" != ort
+then
+	KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
+	KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
+fi
 test_submodule_switch "cherry-pick"
 
 test_expect_success 'unrelated submodule/file conflict is ignored' '
diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index a759f12cbb1d..74cd96e58223 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -30,7 +30,10 @@ git_revert () {
 	git revert HEAD
 }
 
-KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
+if test "$GIT_TEST_MERGE_ALGORITHM" != ort
+then
+	KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
+fi
 test_submodule_switch_func "git_revert"
 
 test_done
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 29537f4798ef..4f92a116e1f0 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -42,8 +42,11 @@ git_pull_noff () {
 	$2 git pull --no-ff
 }
 
-KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
+if test "$GIT_TEST_MERGE_ALGORITHM" != ort
+then
+	KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
+	KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
+fi
 test_submodule_switch_func "git_pull_noff"
 
 test_expect_success 'pull --recurse-submodule setup' '
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 0f92bcf326c8..e5e89c2045e7 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -6,6 +6,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-merge.sh
 
 #
 # history
@@ -328,7 +329,7 @@ test_expect_success 'setup file/submodule conflict' '
 	)
 '
 
-test_expect_failure 'file/submodule conflict' '
+test_expect_merge_algorithm failure success 'file/submodule conflict' '
 	test_when_finished "git -C file-submodule reset --hard" &&
 	(
 		cd file-submodule &&
@@ -437,7 +438,7 @@ test_expect_failure 'directory/submodule conflict; keep submodule clean' '
 	)
 '
 
-test_expect_failure !FAIL_PREREQS 'directory/submodule conflict; should not treat submodule files as untracked or in the way' '
+test_expect_merge_algorithm failure success !FAIL_PREREQS 'directory/submodule conflict; should not treat submodule files as untracked or in the way' '
 	test_when_finished "git -C directory-submodule/path reset --hard" &&
 	test_when_finished "git -C directory-submodule reset --hard" &&
 	(
diff --git a/t/t6438-submodule-directory-file-conflicts.sh b/t/t6438-submodule-directory-file-conflicts.sh
index 04bf4be7d792..8df67a0ef99d 100755
--- a/t/t6438-submodule-directory-file-conflicts.sh
+++ b/t/t6438-submodule-directory-file-conflicts.sh
@@ -12,8 +12,11 @@ test_submodule_switch "merge --ff"
 
 test_submodule_switch "merge --ff-only"
 
-KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
+if test "$GIT_TEST_MERGE_ALGORITHM" != ort
+then
+	KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
+	KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
+fi
 test_submodule_switch "merge --no-ff"
 
 test_done
-- 
gitgitgadget

