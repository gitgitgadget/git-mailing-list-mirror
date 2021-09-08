Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D09C433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC6161154
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348552AbhIHJue (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 05:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347816AbhIHJud (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 05:50:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258D8C061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 02:49:26 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i3so1232652wmq.3
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EDztBiw0+ZbyfUI/B7a79CljlOr/ZRUEAk2iSYSmG1A=;
        b=f3REcNjTOgL/exJwrTHqXYD+9bQc4QxwWFu8GeGOGnTtHABsadNmquDWxWwbdyRuW7
         fVJ+dwnLBeBM/F/R5D8noOUE0uNjRpqeFK5UnMvNNuCUJ79LkjaaaGzJb7gLs9OWwUST
         xIhtMSHkMw9WoLfGBAbBi3Xh3TjWvL1GG2UNTzvjj/vK3LqoSU7Wh7eVi0Cj8PkwciaY
         KCYWM8UVvrUs3K6jEgXn8z4QdF4hSHnxLvsUQyXM68cK8HSMEAfs/eSKBUPTXT/oJyvx
         bSXBJ71pEqgRuPBq6WnYJ1Xt918kYGdgSeXmttxz4s1Rh/EdoPpzJHvuVzxgLC0B0bas
         FhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EDztBiw0+ZbyfUI/B7a79CljlOr/ZRUEAk2iSYSmG1A=;
        b=igu3i8U2p4ul1q48b+Cp+Tt4iJzGuAAAccbClzmDCoIJDXZhFYJaJgLDWx+CysX17Q
         6cAA1rqtu2Rn/77NApm9ULSiNtXwf2qPx5frCn/wWd5cJ4deXe72V7QOIFlCbQzs1Mi9
         lSDOg7WLq6+/008TZz14leso5d+wfROPG/axWXm5c/DnOH9QLBsfnJxA+Yl+yT2WLlrw
         K0Y5DCGC9x5K6xQkhJAHoiK1dW5nASZ7bWF0hHJYqNTap1HnFZnKJP5KG+WHFtGypp3j
         5Qm2oeFbO58XJvAsblE378c3vW+fJN8wDlXcOGMW/YPX9Gs7uvwLJwB5mVzTxibfid4E
         nlnw==
X-Gm-Message-State: AOAM532X6iLLerMVxpMJY8H8Q37uzpin5o+ZuTF7g7JnZclQ1p++/eMe
        qVk/SeMB1xdvLUuYUb44ODZ9Ley0kqY=
X-Google-Smtp-Source: ABdhPJzCS4iz2uk4vDc8lmqLanR++zrCXztPX0HGrA+ZIrJxA3eTbq+sWfhlbTF48EjTSsCqVEso5g==
X-Received: by 2002:a05:600c:5c1:: with SMTP id p1mr2538669wmd.151.1631094564748;
        Wed, 08 Sep 2021 02:49:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9sm1631176wmi.44.2021.09.08.02.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 02:49:24 -0700 (PDT)
Message-Id: <0f5992e8caba424e484524252a303a00e108df34.1631094563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 09:49:12 +0000
Subject: [PATCH 01/11] t3407: run tests in $TEST_DIRECTORY
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Commit 97b88dd58c ("git-rebase.sh: Fix --merge --abort failures when
path contains whitespace", 2008-05-04) started running these tests in
a subdirectory with a space in its name. At that time $TEST_DIRECTORY
did not contain a space but shortly after in 4a7aaccd83 ("Rename the
test trash directory to contain spaces.", 2008-05-04) $TEST_DIRECTORY
was changed to contain a space so we no longer need to run these tests
in a subdirectory.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 7c381fbc89a..c747bd31d76 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -7,13 +7,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-### Test that we handle space characters properly
-work_dir="$(pwd)/test dir"
-
 test_expect_success setup '
-	mkdir -p "$work_dir" &&
-	cd "$work_dir" &&
-	git init &&
 	echo a > a &&
 	git add a &&
 	git commit -m a &&
@@ -37,7 +31,6 @@ testrebase() {
 	dotest=$2
 
 	test_expect_success "rebase$type --abort" '
-		cd "$work_dir" &&
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
@@ -48,7 +41,6 @@ testrebase() {
 	'
 
 	test_expect_success "rebase$type --abort after --skip" '
-		cd "$work_dir" &&
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
@@ -61,7 +53,6 @@ testrebase() {
 	'
 
 	test_expect_success "rebase$type --abort after --continue" '
-		cd "$work_dir" &&
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
@@ -77,7 +68,6 @@ testrebase() {
 	'
 
 	test_expect_success "rebase$type --abort does not update reflog" '
-		cd "$work_dir" &&
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		git reflog show to-rebase > reflog_before &&
@@ -89,7 +79,6 @@ testrebase() {
 	'
 
 	test_expect_success 'rebase --abort can not be used with other options' '
-		cd "$work_dir" &&
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
@@ -103,7 +92,6 @@ testrebase " --apply" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 
 test_expect_success 'rebase --apply --quit' '
-	cd "$work_dir" &&
 	# Clean up the state from the previous one
 	git reset --hard pre-rebase &&
 	test_must_fail git rebase --apply main &&
@@ -115,7 +103,6 @@ test_expect_success 'rebase --apply --quit' '
 '
 
 test_expect_success 'rebase --merge --quit' '
-	cd "$work_dir" &&
 	# Clean up the state from the previous one
 	git reset --hard pre-rebase &&
 	test_must_fail git rebase --merge main &&
-- 
gitgitgadget

