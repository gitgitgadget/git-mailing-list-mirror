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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211D9C636C9
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0363F61009
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhGTUBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbhGTTeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 15:34:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D321C0613E3
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:14:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l6so102639wmq.0
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5TJJQI9b+HCPdsHvWdKITCwanVgfq0C2ILsyop3lM3o=;
        b=n9h/q0go8DPtKOWVpua+v1FPzs1beUhCnBIMgu42hCuId/BEHJX2akPOuNi7mLDTmN
         3rymWEMCjQ5Ek3UDvVZb/Lcj5f9kBhK2A1aIK4M5XNIAsaAnS/+XEfwdwRTMRmBcOa2Z
         C7xK4v7KtN+tFKw0LDRbCzDxDjvd8eN2cxuuXkCBTfl6BUKSvpxzDCoVhD7ta99Y3aE2
         Bob+vyVr6o4NK1ddoBuSiFiQLRd56PqbjmGBVYYa1uFF4wzPBbnw6/q9CC4O6zOkN7Wk
         Pm4yD17kh1KTchgJUijO1aHX8LKLvjNvfPh1qvTXae5kO6sLjZGjh6FtptZbGXxq7ySd
         Q6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5TJJQI9b+HCPdsHvWdKITCwanVgfq0C2ILsyop3lM3o=;
        b=Cr+ICzShMLmh/d6cqhqJzRJJN/fWWvceblvCN1GrvU+GTavpXdrrS1KflYTicHGBhg
         XdpfZywnBwv8vHaj6VIufE5gRVB/75O+80efTsMgkQoHJBQdlk8s640uHM5CsWwebVaR
         KFQDzoT7a0xSzQnyoZjGyEfGVhSJylqDKtT38sSv/z+F9G/UVaE0qWViv04IkOYihwV5
         Bv6MmObp7fXNBeMH10zJB6zn6tRv9YZN8LU/HONcxP99TDNfHyU7ptX3rG1DQK2UeeCL
         H/6pvFD61YDtcjDPm2iJyeJFHqbGJhWOF65omD/FKCEFzNrNyMPlT/HUmTelwhWgDSYm
         Q4Xw==
X-Gm-Message-State: AOAM533boDwLIGI9fTY608gj84x8jI/yK0RY2rt+1Pc7lAKQqLITxNYr
        zscGg0ZfuriZi6tVNrWhvoucAEJhtbg=
X-Google-Smtp-Source: ABdhPJxBKk7gM7+fsfl5jw99ZDkQ9pQk+mnugTGy3oBVKYNGFDwqX0X0ne/73TRk2hvwsaC5zk60uQ==
X-Received: by 2002:a7b:ca45:: with SMTP id m5mr33600781wml.46.1626812085811;
        Tue, 20 Jul 2021 13:14:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19sm3182915wmc.44.2021.07.20.13.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 13:14:45 -0700 (PDT)
Message-Id: <4b801c854fb7891a6530121281cff3f67451b283.1626812081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.1626812081.gitgitgadget@gmail.com>
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
        <pull.973.v2.git.1626812081.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 20:14:40 +0000
Subject: [PATCH v2 6/7] t1092: document bad 'git checkout' behavior
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add new branches to the test repo that demonstrate directory/file
conflicts in different ways. Since the directory 'folder1/' has
adjacent files 'folder1-', 'folder1.txt', and 'folder10' it causes
searches for 'folder1/' to land in a different place in the index than a
search for 'folder1'. This causes a change in behavior when working with
the df-conflict-1 and df-conflict-2 branches, whose only difference is
that the first uses 'folder1' as the conflict and the other uses
'folder2' which does not have these adjacent files.

We can extend two tests that compare the behavior across different 'git
checkout' commands, and we see already that the behavior will be
different in some cases and not in others. The difference between the
two test loops is that one uses 'git reset --hard' between iterations.

Further, we isolate the behavior of creating a staged change within a
directory and then checking out a branch where that directory is
replaced with a file. A full checkout behaves differently across these
two cases, while a sparse-checkout cone behaves consistently. In both
cases, the behavior is wrong. In one case, the staged change is dropped
entirely. The other case the staged change is kept, replacing the file
at that location, but none of the other files in the directory are kept.

Likely, the correct behavior in this case is to reject the checkout and
report the conflict, leaving HEAD in its previous location. None of the
cases behave this way currently. Use comments to demonstrate that the
tested behavior is only a documentation of the current, incorrect
behavior to ensure we do not _accidentally_ change it. Instead, we would
prefer to change it on purpose with a future change.

At this point, the sparse-index does not handle these 'git checkout'
commands correctly. Or rather, it _does_ reject the 'git checkout' when
we have the staged change, but for the wrong reason. It also rejects the
'git checkout' commands when there is no staged change and we want to
replace a directory with a file. A fix for that unstaged case will
follow in the next change, but that will make the sparse-index agree
with the full checkout case in these documented incorrect behaviors.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 142 ++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 2 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index fde3b41aba8..79b4a8ce199 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -95,6 +95,25 @@ test_expect_success 'setup' '
 		git add . &&
 		git commit -m "rename deep/deeper1/... to folder1/..." &&
 
+		git checkout -b df-conflict-1 base &&
+		rm -rf folder1 &&
+		echo content >folder1 &&
+		git add . &&
+		git commit -m "dir to file" &&
+
+		git checkout -b df-conflict-2 base &&
+		rm -rf folder2 &&
+		echo content >folder2 &&
+		git add . &&
+		git commit -m "dir to file" &&
+
+		git checkout -b fd-conflict base &&
+		rm a &&
+		mkdir a &&
+		echo content >a/a &&
+		git add . &&
+		git commit -m "file to dir" &&
+
 		git checkout -b deepest base &&
 		echo "updated deepest" >deep/deeper1/deepest/a &&
 		git commit -a -m "update deepest" &&
@@ -358,10 +377,16 @@ test_expect_success 'diff --staged' '
 	test_all_match git diff --staged
 '
 
+# NEEDSWORK: sparse-checkout behaves differently from full-checkout when
+# running this test with 'df-conflict-2' after 'df-conflict-1'.
 test_expect_success 'diff with renames and conflicts' '
 	init_repos &&
 
-	for branch in rename-out-to-out rename-out-to-in rename-in-to-out
+	for branch in rename-out-to-out \
+		      rename-out-to-in \
+		      rename-in-to-out \
+		      df-conflict-1 \
+		      fd-conflict
 	do
 		test_all_match git checkout rename-base &&
 		test_all_match git checkout $branch -- . &&
@@ -371,10 +396,15 @@ test_expect_success 'diff with renames and conflicts' '
 	done
 '
 
+# NEEDSWORK: the sparse-index fails to move HEAD across a directory/file
+# conflict such as when checking out df-conflict-1 and df-conflict2.
 test_expect_success 'diff with directory/file conflicts' '
 	init_repos &&
 
-	for branch in rename-out-to-out rename-out-to-in rename-in-to-out
+	for branch in rename-out-to-out \
+		      rename-out-to-in \
+		      rename-in-to-out \
+		      fd-conflict
 	do
 		git -C full-checkout reset --hard &&
 		test_sparse_match git reset --hard &&
@@ -606,4 +636,112 @@ test_expect_success 'add everything with deep new file' '
 	test_all_match git status --porcelain=v2
 '
 
+# NEEDSWORK: 'git checkout' behaves incorrectly in the case of
+# directory/file conflicts, even without sparse-checkout. Use this
+# test only as a documentation of the incorrect behavior, not a
+# measure of how it _should_ behave.
+test_expect_success 'checkout behaves oddly with df-conflict-1' '
+	init_repos &&
+
+	test_sparse_match git sparse-checkout disable &&
+
+	write_script edit-content <<-\EOF &&
+	echo content >>folder1/larger-content
+	git add folder1
+	EOF
+
+	run_on_all ../edit-content &&
+	test_all_match git status --porcelain=v2 &&
+
+	git -C sparse-checkout sparse-checkout init --cone &&
+	git -C sparse-index sparse-checkout init --cone --sparse-index &&
+
+	test_all_match git status --porcelain=v2 &&
+
+	# This checkout command should fail, because we have a staged
+	# change to folder1/larger-content, but the destination changes
+	# folder1 to a file.
+	git -C full-checkout checkout df-conflict-1 \
+		1>full-checkout-out \
+		2>full-checkout-err &&
+	git -C sparse-checkout checkout df-conflict-1 \
+		1>sparse-checkout-out \
+		2>sparse-checkout-err &&
+
+	# NEEDSWORK: the sparse-index case refuses to change HEAD here,
+	# but for the wrong reason.
+	test_must_fail git -C sparse-index checkout df-conflict-1 \
+		1>sparse-index-out \
+		2>sparse-index-err &&
+
+	# Instead, the checkout deletes the folder1 file and adds the
+	# folder1/larger-content file, leaving all other paths that were
+	# in folder1/ as deleted (without any warning).
+	cat >expect <<-EOF &&
+	D	folder1
+	A	folder1/larger-content
+	EOF
+	test_cmp expect full-checkout-out &&
+	test_cmp expect sparse-checkout-out &&
+
+	# stderr: Switched to branch df-conflict-1
+	test_cmp full-checkout-err sparse-checkout-err
+'
+
+# NEEDSWORK: 'git checkout' behaves incorrectly in the case of
+# directory/file conflicts, even without sparse-checkout. Use this
+# test only as a documentation of the incorrect behavior, not a
+# measure of how it _should_ behave.
+test_expect_success 'checkout behaves oddly with df-conflict-2' '
+	init_repos &&
+
+	test_sparse_match git sparse-checkout disable &&
+
+	write_script edit-content <<-\EOF &&
+	echo content >>folder2/larger-content
+	git add folder2
+	EOF
+
+	run_on_all ../edit-content &&
+	test_all_match git status --porcelain=v2 &&
+
+	git -C sparse-checkout sparse-checkout init --cone &&
+	git -C sparse-index sparse-checkout init --cone --sparse-index &&
+
+	test_all_match git status --porcelain=v2 &&
+
+	# This checkout command should fail, because we have a staged
+	# change to folder1/larger-content, but the destination changes
+	# folder1 to a file.
+	git -C full-checkout checkout df-conflict-2 \
+		1>full-checkout-out \
+		2>full-checkout-err &&
+	git -C sparse-checkout checkout df-conflict-2 \
+		1>sparse-checkout-out \
+		2>sparse-checkout-err &&
+
+	# NEEDSWORK: the sparse-index case refuses to change HEAD
+	# here, but for the wrong reason.
+	test_must_fail git -C sparse-index checkout df-conflict-2 \
+		1>sparse-index-out \
+		2>sparse-index-err &&
+
+	# The full checkout deviates from the df-conflict-1 case here!
+	# It drops the change to folder1/larger-content and leaves the
+	# folder1 path as-is on disk.
+	test_must_be_empty full-checkout-out &&
+
+	# In the sparse-checkout case, the checkout deletes the folder1
+	# file and adds the folder1/larger-content file, leaving all other
+	# paths that were in folder1/ as deleted (without any warning).
+	cat >expect <<-EOF &&
+	D	folder2
+	A	folder2/larger-content
+	EOF
+	test_cmp expect sparse-checkout-out &&
+
+	# Switched to branch df-conflict-1
+	test_cmp full-checkout-err sparse-checkout-err
+'
+
 test_done
-- 
gitgitgadget

