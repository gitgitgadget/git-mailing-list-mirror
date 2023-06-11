Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9501C77B7A
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 18:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjFKSvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 14:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKSvC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 14:51:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21872E6A
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:51:01 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30fba11b1ceso842564f8f.1
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686509459; x=1689101459;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESAayQ9bQ4JcZ0vr59LHuaCLZ8diClxReSMyTOUmjKc=;
        b=jzZ5AEawdmg5JFb9Pz0EIlV6C2G5S3A+sSjo8lOTP3klA5Ma6QhgQ19FPsyRtqSn4K
         0cX6ptnZwLDEOEeQezZZ4fpJ45I2Q+N/j7JDaVZqN7X0i9RmxHVOTsjCtqfBGrmPpTTs
         xgbZiOV5fhvTX0L5dpKxpbycEc1ZHqsbQUyHLsWcm2aB/hA4TdnG7aStgw0zclLy798K
         f5FMhy1U2tjWmhkM7vmeYCgHbW6DpKQFNXXhieo48pNQlsqKzSgfH0ytL3UTQrCPv1Ii
         zDHStmk/oNTZui2I73dbMcfz59T4WdcJel7/p+xyeUQDKgkFDjV5Gg1M/aWlIeBUAXAF
         epcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686509459; x=1689101459;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESAayQ9bQ4JcZ0vr59LHuaCLZ8diClxReSMyTOUmjKc=;
        b=FeH8dsT4xpXj4zGHvZhuH7lzLpII/kitIdXQbDJhmmHj04FQfut/5ZuiLm1OyboiCy
         ciXHxDv62jiow/ZU5PfS0axj+H0asCyndemZJnCelDJ060k0VOJThT4XUlqFshjMFoKR
         xP/rmpXHSe5NkGQJJ1vtx+kAUuqKhZVvuA7rzGJgOU5gwZIOmJLZzIItzqXKF7xcetQh
         c8ZRwmibtNqdm7Vv1CJBPQpK2XussYFC8ELdC1zhxIpYbyrBDDPVaKMFy9638aTjlyhR
         B3w6/91/dELyRB/HbFzwVX3fvATyQ/iIOdDbIQOB7/uMf6NSbhLgRMFNxWVksx3y6bj+
         YIdw==
X-Gm-Message-State: AC+VfDwYGy6o2xmR9P6qVNlDYitM5exTxp2KG6ZCiDDFe/kRoHJS0oz+
        DyQrZS19r07khMu0ZdITGhFWs3yFf8k=
X-Google-Smtp-Source: ACHHUZ6/6fCPqWbWFz9zC9GlqEz0xNz7/Cy9Nq/jcpFgxn9yPgLPYxHNbbffglWqm/kU+/kqzpKQWg==
X-Received: by 2002:adf:e484:0:b0:30a:e589:689a with SMTP id i4-20020adfe484000000b0030ae589689amr3797994wrm.18.1686509459486;
        Sun, 11 Jun 2023 11:50:59 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000008700b0030fa166d8a1sm7722405wrx.34.2023.06.11.11.50.59
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 11:50:59 -0700 (PDT)
Subject: [PATCH 11/11] tests: mark as passing with SANITIZE=leak
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Message-ID: <32527a42-ed33-cfd0-60dc-03ccc679ba20@gmail.com>
Date:   Sun, 11 Jun 2023 20:50:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests listed below, since previous commits, no longer trigger any
leak.

   + t1507-rev-parse-upstream.sh
   + t1508-at-combinations.sh
   + t1514-rev-parse-push.sh
   + t2027-checkout-track.sh
   + t3200-branch.sh
   + t3204-branch-name-interpretation.sh
   + t5404-tracking-branches.sh
   + t5517-push-mirror.sh
   + t5525-fetch-tagopt.sh
   + t6040-tracking-info.sh
   + t7508-status.sh

Let's mark them with "TEST_PASSES_SANITIZE_LEAK=true" to notice and fix
promptly any new leak that may be introduced and triggered by them, in
the future.

As a reference, the list has been formed using:

  $ GIT_TEST_PASSING_SANITIZE_LEAK=check make SANITIZE=leak test

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t1507-rev-parse-upstream.sh         | 1 +
 t/t1508-at-combinations.sh            | 1 +
 t/t1514-rev-parse-push.sh             | 1 +
 t/t2027-checkout-track.sh             | 1 +
 t/t3200-branch.sh                     | 1 +
 t/t3204-branch-name-interpretation.sh | 1 +
 t/t5404-tracking-branches.sh          | 1 +
 t/t5517-push-mirror.sh                | 1 +
 t/t5525-fetch-tagopt.sh               | 1 +
 t/t6040-tracking-info.sh              | 1 +
 t/t7508-status.sh                     | 1 +
 11 files changed, 11 insertions(+)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index cb9ef7e329..b9af6b3ac0 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -5,6 +5,7 @@ test_description='test <branch>@{upstream} syntax'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 87a4286414..e841309d0e 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -4,6 +4,7 @@ test_description='test various @{X} syntax combinations together'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check() {
diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
index d868a08110..a835a196aa 100755
--- a/t/t1514-rev-parse-push.sh
+++ b/t/t1514-rev-parse-push.sh
@@ -4,6 +4,7 @@ test_description='test <branch>@{push} syntax'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 resolve () {
diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
index dca35aa3e3..a8bbc60954 100755
--- a/t/t2027-checkout-track.sh
+++ b/t/t2027-checkout-track.sh
@@ -5,6 +5,7 @@ test_description='tests for git branch --track'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 98b6c8ac34..daf1666df7 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -8,6 +8,7 @@ test_description='git branch assorted tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index 3399344f25..594e3e43e1 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -9,6 +9,7 @@ This script aims to check the behavior of those corner cases.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 expect_branch() {
diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
index cc07889667..51737eeafe 100755
--- a/t/t5404-tracking-branches.sh
+++ b/t/t5404-tracking-branches.sh
@@ -5,6 +5,7 @@ test_description='tracking branch update checks for git push'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index a448e169bd..6d4944a728 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -5,6 +5,7 @@ test_description='pushing to a mirror repository'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 D=$(pwd)
diff --git a/t/t5525-fetch-tagopt.sh b/t/t5525-fetch-tagopt.sh
index 45815f7378..3a28f1ded5 100755
--- a/t/t5525-fetch-tagopt.sh
+++ b/t/t5525-fetch-tagopt.sh
@@ -2,6 +2,7 @@
 
 test_description='tagopt variable affects "git fetch" and is overridden by commandline.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 setup_clone () {
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index a313849406..7ddbd96e58 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -5,6 +5,7 @@ test_description='remote tracking stats'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 advance () {
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index aed07c5b62..4c1f03e609 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -5,6 +5,7 @@
 
 test_description='git status'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
-- 
2.40.1
