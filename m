Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D25C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 12:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A661D61249
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 12:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhFQMpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 08:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbhFQMpw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 08:45:52 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDE2C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 05:43:43 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id u190so1058422pgd.8
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 05:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Svm5WK4+R2Twyi2iXhPRazie4UqxEdTGLl3+BJKcY0s=;
        b=HPm1fgpAGDFz2BcKOznkG3AEd77LVfS/1q2x5U8bWF4J95KTrob4Y97PUojtDWNXIP
         +eUXLGytshu3jZWOzm2oDOTm5j7U+if+JQERaTZxqC1vt0n3lAkGCAIqoDs4Ly6eF4vM
         WC0YIMQ0QwYJkjkYRzuBaxo1s+Ngq+DzB96usDcbs51cPhb+dmaZlck8dC+IkQj4XSs6
         LZRDc4L6fXnYwOd4RnWKLGfTcMpiEAF5Dvdc234aUDMtgmgRitsKJNKMIv+xiI+hynAE
         XGq+E+SW79YHeAu4Rtx8GMvA1qIk8xe8HxYnc3jT1PDXiy+LlfLXZDc4FBhjaaPBOaOR
         a6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Svm5WK4+R2Twyi2iXhPRazie4UqxEdTGLl3+BJKcY0s=;
        b=T6WIUOd6rPG8sElJyagrw7/dq3hx7P5DsbPSL1XZ8qqmkCTgxZOwAPe5FyfPd2aA7u
         sYtK8aaSw6n8DbSSFU+xutzi88uhx7mroyYi8lGMNd1wo6JqBbNKoaN5VGlwjHoEf4ls
         QILz5m6QT4VToA136iWUa5Vh//XA+dwDcTT3blZmeKZ6J5MzdijNCWDJsTbcuPO3t+zy
         huI0FrGZdVINcu0s3zLkHazE1CExMznCDPqOh2Z61FrOEH+CZ93Ii9AaOkZJ0QnVkFks
         zu+BJFXnYogpqcm92OFjskrLAXV+/NyKO4387wdUss2jXpGirFaFJYf0YnFDya8VjWEB
         ym9Q==
X-Gm-Message-State: AOAM530+nSr1W7SNGsAXnebjNckxXQi/73UO1jI+yprZ8NCeuCL7YYPx
        ESrZeXWuZkgWyF2zhJqBJc0=
X-Google-Smtp-Source: ABdhPJzGBRvvxH7blAP3ffWPC8FMeefLUToeh1InDcyzgK4qisEf2AEnK+7Awvj8TIqlBj3gHyiCgw==
X-Received: by 2002:a65:52cb:: with SMTP id z11mr4844869pgp.201.1623933823236;
        Thu, 17 Jun 2021 05:43:43 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.154])
        by smtp.gmail.com with ESMTPSA id t143sm6532247pgb.93.2021.06.17.05.43.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jun 2021 05:43:42 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 2/2] test: create repo using test_create_repo
Date:   Thu, 17 Jun 2021 20:43:31 +0800
Message-Id: <20210617124331.17888-2-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc0.27.g7b1e85181b
In-Reply-To: <20210617124331.17888-1-zhiyou.jx@alibaba-inc.com>
References: <20210617124331.17888-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When creating new repository, function "test_create_repo" uses env
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME as default branch.  Replace
"git-init" with "test_create_repo" in t5411, t5548 and t6020 to create
repository with specific default branch.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5411-proc-receive-hook.sh | 4 ++--
 t/t5548-push-porcelain.sh    | 7 +++++--
 t/t6020-bundle-misc.sh       | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index 98b0e81208..7148e5ab7e 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -18,8 +18,8 @@ setup_upstream_and_workbench () {
 	test_expect_success "setup upstream and workbench" '
 		rm -rf upstream.git &&
 		rm -rf workbench &&
-		git init --bare upstream.git &&
-		git init workbench &&
+		test_create_repo --bare upstream.git &&
+		test_create_repo workbench &&
 		create_commits_in workbench A B &&
 		(
 			cd workbench &&
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index 5a761f3642..8725b00a68 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -4,6 +4,9 @@
 #
 test_description='Test git push porcelain output'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # Create commits in <repo> and assign each commit's oid to shell variables
@@ -61,8 +64,8 @@ setup_upstream_and_workbench () {
 	# Workbench after setup : main(A)
 	test_expect_success "setup upstream repository and workbench" '
 		rm -rf upstream.git workbench &&
-		git init --bare upstream.git &&
-		git init workbench &&
+		test_create_repo --bare upstream.git &&
+		test_create_repo workbench &&
 		create_commits_in workbench A B &&
 		(
 			cd workbench &&
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 881f72fd44..4ad98a3385 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -315,7 +315,7 @@ test_expect_success 'create bundle 2 - has prerequisites' '
 '
 
 test_expect_success 'fail to verify bundle without prerequisites' '
-	git init --bare test1.git &&
+	test_create_repo --bare test1.git &&
 
 	cat >expect <<-\EOF &&
 	error: Repository lacks these prerequisite commits:
-- 
2.32.0.rc0.27.g7b1e85181b

