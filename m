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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972E2C433FE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B86E60F6F
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244685AbhIMPrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245524AbhIMPqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:46:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47157C0A8896
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d21so7591042wra.12
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l/Jg8R6yAzj1NDGUukkEEPk+umccBmF3EC0FZvsVKYg=;
        b=S8tcvt9btxWDSGmXyRTKQp143Ti6vYXo04i9PxrBkzWTGqgQ/NNnrDsiOXzhi4/soR
         aMadZNVB6gBriZwnM/4hLZ3f0qUyY9y8dcSWd7koEbR55Z/wmR3B8Swl6trkJ28ybnvK
         nIAKWLtr+9k+MhER+yulCkwP2gX23LkWI5gqPxKpywt6yz2jRSNE+VAQUOF4JYoXz9F8
         UwzRvijm3eiFZFKvhLqIG7cjG6D5xv2x5xIhQxY9l48d4mS/MZt0Eo1WIb+RlXg6EXMr
         /CwJYPF3EwoZ40UqT8MokMbNbXracbdmBCahg62ItBtPFveKCOUdc5QtL4lAP1KviuiW
         92qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l/Jg8R6yAzj1NDGUukkEEPk+umccBmF3EC0FZvsVKYg=;
        b=nFct5lmz635qF3kJx0L2lg7kyqmxsbYOKwsD3CJkz9pyyWuuTxzRoRlkna0RMMW1S6
         xyx7CxD0d7fHtwLZstc5jyG+MBfCpxFlnOkntUc0yCylpiA1Uzu4XKTc/aP+3ciWGk+b
         dnk1XsYeHEW1lavobSYfoC9soUpqgP1OW51ym2IUpR1HdN1MfIJQBWyzatLG/t2bEA/8
         rO4Oz4PQ3TLBJPi8jhtoouMAqdz+WEdrca+GevYPa+XBVkl/3EhT69HCfk79vlrjpU1j
         kRgka/rwAqqVE11ZvixmDF9ODQZuiDuZu+Lnw+U8zh6Wu0vemsABI8O8v6sTORkZ0LES
         XrQg==
X-Gm-Message-State: AOAM531QqmiEs4DhQbztPKUOdTkPhVkHPnxFDrlg7sQDyezbfE/JCEHD
        PxyYQWAqwQ+9CNp4S4yb48dxCR+PqqA=
X-Google-Smtp-Source: ABdhPJwYqJwt33JAj1KkGr5WsrXZS5bNLK0nxTZFhCgJe+YSY1PuouVp6xgvJMps4tWAVzhy/nAm8w==
X-Received: by 2002:adf:9bdb:: with SMTP id e27mr13005869wrc.162.1631546371912;
        Mon, 13 Sep 2021 08:19:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7sm9656282wrr.27.2021.09.13.08.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 08:19:31 -0700 (PDT)
Message-Id: <fd55a3196b16a2746cdf8ba374c0bbe1bc78ecbc.1631546362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
        <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Sep 2021 15:19:18 +0000
Subject: [PATCH v2 07/11] t3407: rework rebase --quit tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

9512177b68 ("rebase: add --quit to cleanup rebase, leave everything
else untouched", 2016-11-12) seems to have copied the --abort tests
but added two separate tests for the two rebase backends rather than
adding a single test into the existing testrebase() function.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index f8264449b6c..162112ba5ea 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -86,31 +86,21 @@ testrebase() {
 		test_must_fail git rebase --abort -v &&
 		git rebase --abort
 	'
+
+	test_expect_success "rebase$type --quit" '
+		test_when_finished "git symbolic-ref HEAD refs/heads/to-rebase" &&
+		# Clean up the state from the previous one
+		git reset --hard pre-rebase &&
+		test_must_fail git rebase$type main &&
+		test_path_is_dir $state_dir &&
+		head_before=$(git rev-parse HEAD) &&
+		git rebase --quit &&
+		test_cmp_rev HEAD $head_before &&
+		test_path_is_missing .git/rebase-apply
+	'
 }
 
 testrebase " --apply" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 
-test_expect_success 'rebase --apply --quit' '
-	# Clean up the state from the previous one
-	git reset --hard pre-rebase &&
-	test_must_fail git rebase --apply main &&
-	test_path_is_dir .git/rebase-apply &&
-	head_before=$(git rev-parse HEAD) &&
-	git rebase --quit &&
-	test_cmp_rev HEAD $head_before &&
-	test_path_is_missing .git/rebase-apply
-'
-
-test_expect_success 'rebase --merge --quit' '
-	# Clean up the state from the previous one
-	git reset --hard pre-rebase &&
-	test_must_fail git rebase --merge main &&
-	test_path_is_dir .git/rebase-merge &&
-	head_before=$(git rev-parse HEAD) &&
-	git rebase --quit &&
-	test_cmp_rev HEAD $head_before &&
-	test_path_is_missing .git/rebase-merge
-'
-
 test_done
-- 
gitgitgadget

