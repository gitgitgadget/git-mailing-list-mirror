Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC57EB64D8
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 23:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjFPXfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 19:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjFPXfM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 19:35:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5184E3AAD
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:35:03 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f8d258f203so10371565e9.1
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686958502; x=1689550502;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cw2ANqhRYJm1W1XPiRMKYg1p8yXdsm1zX4nKMtHqOHk=;
        b=LfVX8ZaQ9NLP5uQ/QYuxJnKUJQLzxPn21JOBbap4cdiofGQXPrvVe51oRkoNL6m7vx
         GDN/Fx9I3bfS0RA3RhJReclaFl14LkxtSwOJU+L+dxaR65zmBaYFZhd2/PbwXhMMNMEK
         TcF3nVcuPtXUjr1L/zmYToGmR+uKv3BKrCEE8r+EIKeuH36b5WlfnFe1rFsK7ADGKw8B
         1WuWQQGlNFa3+Do6RIDZjyiuJIosfC0PNS+heDqKoH4jMBWTnfUXA/DodQNo9o7HIdDM
         N3Pto2z6kS1XCp5V9eopW5B6wPxCg6qV/Y0Ts9dmE/2zCm93BruWVvTPkBn3luixgndh
         uyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686958502; x=1689550502;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cw2ANqhRYJm1W1XPiRMKYg1p8yXdsm1zX4nKMtHqOHk=;
        b=QRS3e/WdGYu8+SYKityBLC9Pyw25yIXo+kD8o4W9F/NHgw5VTj9YP9h46HnzO0PRuH
         +yyjCcf8wIc+VIcOLPCTuO8QR/XqGx3YFrix+btEEiDpYPqaik3YqsdrTLZBjrEsChvR
         le6VSshrZeKXH1cKCycXOvSZGPP5HRKLZkVLBbUmWqEZRiGrlNLMTRyCa4/icGAFqnda
         9mpHlGvCK/eoALTjfz40NNF3StQp0CdHPnySM/iJPKzavReDgGQ0XtBtQzKgi6d12VPU
         d7x/+qyB9Bk8kUx4NoSJxYY3A31F+ohrov0ht2pOCawBzOxcTkxT6ciZsWPtF/KgmCdE
         E9Dg==
X-Gm-Message-State: AC+VfDxhcMmVKVAkdoB+1lfQo4SpLS4zlGXpmQsxaZcXGCGrtS8iLmT3
        506t6JYCRkOYty0C7hhsqMg=
X-Google-Smtp-Source: ACHHUZ43HfgG+jJrlLYdywA59KLAoJLlOlrMQlE7GpymhmvWVr6zoJIvtC2F0t8WHGQwuE1JrCMi0Q==
X-Received: by 2002:a7b:ce8a:0:b0:3f7:e7d5:6123 with SMTP id q10-20020a7bce8a000000b003f7e7d56123mr2564942wmj.41.1686958501647;
        Fri, 16 Jun 2023 16:35:01 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id v25-20020a7bcb59000000b003f819dfa0ddsm3354880wmj.28.2023.06.16.16.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 16:35:01 -0700 (PDT)
Subject: [PATCH v2 5/5] tests: mark as passing with SANITIZE=leak
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
Message-ID: <66aae5a7-a2a2-2297-4249-d22fd070e91a@gmail.com>
Date:   Sat, 17 Jun 2023 01:35:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
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
promptly any new leak that may be introduced and triggered by them in
the future.

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
