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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362CAC433E8
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1395061991
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhCTAEn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 20:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhCTAEE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 20:04:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D32C061761
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k8so10733274wrc.3
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RjXqIGfs6xg6JMfPfkR6AO1ReuEMf1tdF6If1ZnSgZM=;
        b=R7mJs5a0OqDaxOX6HyKYOdUYSbUM2q/W4pgSKeRqmOn/mSi5BI9MdTGvrNljT0Rgwg
         8Y9YUw7j9FCnR2D7fhodCaDU2UCJIXUwKlQgbqqYICzj30qHyUtGcyfKt1EHXHwU0OLh
         6S+LSQOdsVkWwM9wVkPfHNO3t3dB/vFdVEV3I6igtYxGlQ0yYhwKPtR+TkNvcMSGCEzZ
         w3CSr8CiUwJEaHIi6WLPx2wPWDk22O4F4WUR6Yw+okSeKe3qGBTnSog6TFGW3YhqP9kq
         GdwtXK4MrTnmZGf43jG9BsbGsxBUITifLVQSpwv05Lc3cecIlHpRGAf2+II4NxAlOYpt
         frzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RjXqIGfs6xg6JMfPfkR6AO1ReuEMf1tdF6If1ZnSgZM=;
        b=niJAWLPdHu4MQOCY5rAg1ejkWfZeMg+iCKSiY8066zm3iSnr/zyEjBANZWGo3QpG4p
         L0/bFZuQqkKXlmdW3Ib5qJvmXUyftFFEX+ZQPwmyri9KBWSsU+cEJlJKEgHrPAmVvmT3
         TS0SL2LbleiW5PtMp0COFt0R8X7AxM5XQ9NHC6oCfnrYpvj48nwp8ZRFusjHgqnZ6d3I
         3Tfz37hWXNEyCnPBceyJvnDwO5hIAq9uhfM8ywvfWmYFovYYX/EOLNY40pPtxyRqiuCj
         mB2EcuHlbIN2wgdrltaHtwwxE5s3zDzN/fFd+G34AciErY+zlEtT8qiNU0ircNcbeFvC
         BOVQ==
X-Gm-Message-State: AOAM530/tIDZeoYrt3h5RPGqktHiT28jVFkyEJ3BK8ttTxg1e6JfRx/6
        c7xXKsX03iW8GCPEFEC2VHOy53EMZzo=
X-Google-Smtp-Source: ABdhPJxGhK1Lrircu2+YerirUIFU5hV9p85ywTkfNK+ySkJpSkifV5xZLfBUppQ0i9zH6qbTMWgUxg==
X-Received: by 2002:adf:f843:: with SMTP id d3mr6852521wrq.55.1616198642726;
        Fri, 19 Mar 2021 17:04:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f4sm8783214wrz.4.2021.03.19.17.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 17:04:02 -0700 (PDT)
Message-Id: <f9325647a9fca1471fead860c18db86aba34eb54.1616198636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
References: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
        <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 00:03:51 +0000
Subject: [PATCH v3 08/13] t: mark several submodule merging tests as fixed
 under merge-ort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
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

