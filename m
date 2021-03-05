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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D79C433E9
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B74A6500D
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhCEAzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhCEAzp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 19:55:45 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8EDC061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 16:55:45 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u16so256089wrt.1
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 16:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kFAR3lPFyTOoA/h/2yvQnPWqUxpbDTIwz7iQYMsYeSA=;
        b=GB65Nh9o/rMET0qkI2IvMc40Mv1gt/M0TM7VP1WfHvhtlP06nMa5Va4jtO4qbHuEvX
         +fCNZNIHaoN36LwfxNO4MUOD0Tca76JZtE5xzgFpFXTXyXZ9ijP8Dix7MeI7UMXeLfVU
         LTHcbAqOasyNwA7sGZcnSxNvwFtUd6tJ6WenqEW6Yh2jtIJ1RnhmSm1kc+TiljprVUAa
         I8iaDlxc2IBCkWbdZKBB7prpBdVJTLhtlrHfQXv7Pu4+874GfEQQrJSEhUtG+BJZakvm
         j7H9pmLcjgUmtGjBl3SJccakW5r3vcX4sCpF6HIXeeiXr0CmQfYBUrKHrHx4SBWEtXzt
         6c+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kFAR3lPFyTOoA/h/2yvQnPWqUxpbDTIwz7iQYMsYeSA=;
        b=QmDFudihxm9LTP06zc9D1cLR4eXZN3nIpaS88Py+9dz3LeN/RAMSvX/ZmXWzdFAxM+
         7LTAUe4aUS2aAezSwqHOXyKl6qtluSjrGRGUvp7WVUU4CE8LA42d3S5SUTf+odI0WSRj
         tUdQA8/yYwZVahRl/9slW0R4BUdsuFI/YAnDEqETkxOqdOYfecNVCnClKVaec/T/omXl
         4tIIupHyYs3sFVGoM95JEEyvQFyjw1+44VtYz4sERISlbaTHQJMN3e675LLVK+AYxSh8
         jbQw6vC3L83CqfJ67JCdNvVmVWEMnsNy5Sxn2uuYwzpE4W4ulWzs8tQIDSq9gbvy/0iQ
         4zbQ==
X-Gm-Message-State: AOAM5320fqwq6735g8YqkRE/D8kXKXVwfyN/IJVjo31H13lANAljRVPd
        OVRWOkvzjoI9RkrEUtLG8f9aMvfBH8Q=
X-Google-Smtp-Source: ABdhPJyf6oCkWdi9Azm6M1GD8bNuNioOpQ21HLydiSZY/SMK5T5rvA0iJ446wANpkSorIlV08NeinA==
X-Received: by 2002:a05:6000:1788:: with SMTP id e8mr6638602wrg.171.1614905744310;
        Thu, 04 Mar 2021 16:55:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm1474970wrt.21.2021.03.04.16.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 16:55:44 -0800 (PST)
Message-Id: <95a6c0abe558f6fe2c570602650b4511d33296b2.1614905738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Mar 2021 00:55:35 +0000
Subject: [PATCH 09/11] t: mark several submodule merging tests as fixed under
 merge-ort
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
 t/t3512-cherry-pick-submodule.sh              | 9 +++++++--
 t/t3513-revert-submodule.sh                   | 7 ++++++-
 t/t5572-pull-submodule.sh                     | 9 +++++++--
 t/t6437-submodule-merge.sh                    | 5 +++--
 t/t6438-submodule-directory-file-conflicts.sh | 9 +++++++--
 5 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodule.sh
index 822f2d4bfbd5..eb7a47b9d98a 100755
--- a/t/t3512-cherry-pick-submodule.sh
+++ b/t/t3512-cherry-pick-submodule.sh
@@ -8,8 +8,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
-KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
+if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+then
+	:  # No special additional KNOWN_FAILURE knobs to set
+else
+	KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
+	KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
+fi
 test_submodule_switch "cherry-pick"
 
 test_expect_success 'unrelated submodule/file conflict is ignored' '
diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index a759f12cbb1d..1f8157ad5ba5 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -30,7 +30,12 @@ git_revert () {
 	git revert HEAD
 }
 
-KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
+if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+then
+	:  # No special additional KNOWN_FAILURE knobs to set
+else
+	KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
+fi
 test_submodule_switch_func "git_revert"
 
 test_done
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 29537f4798ef..4b4495613d04 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -42,8 +42,13 @@ git_pull_noff () {
 	$2 git pull --no-ff
 }
 
-KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
+if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+then
+	:  # No special additional KNOWN_FAILURE knobs to set
+else
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
index 04bf4be7d792..abfa59d3684c 100755
--- a/t/t6438-submodule-directory-file-conflicts.sh
+++ b/t/t6438-submodule-directory-file-conflicts.sh
@@ -12,8 +12,13 @@ test_submodule_switch "merge --ff"
 
 test_submodule_switch "merge --ff-only"
 
-KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
+if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+then
+	:  # No special additional KNOWN_FAILURE knobs to set
+else
+	KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
+	KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
+fi
 test_submodule_switch "merge --no-ff"
 
 test_done
-- 
gitgitgadget

