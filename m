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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83055C2BBCA
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F86123F38
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437420AbgLKJKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 04:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437392AbgLKJKN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 04:10:13 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AADFC0617A6
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:08:57 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r3so8246970wrt.2
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n5Juu5PL0YoW+NlcBtXZ8308O94SMFa4fjKIyTcHubs=;
        b=RBxruUUPYSUaaDN4ENL0SVCj8FjSegd04/vd4A2kGvvXQKrGcELTp4ijfAaZqjIfIh
         TzjhWn7U+6eDZTPtyhOdsfGAoBvQsoYrAgWn57QRBAuUMeWuUUvaRNtS7nOiVGRdy/Oz
         fJ7GZz9+kXplwapuivwJYtvp+dBXIXClstE/9+DyTP3xTa/+VvWPJC5VtrktGpnxyqPO
         SaIAvaNMj/RilucGT8T3enS3wNtCi+pdqpNSFzRY65GcIz7GrZ8oZ6IW68j9TlMs1cFK
         HF5stHJcmZxQCJ9cCF3ujppHgHz8xISGvO8d3fRHXph9C4vi3Etsosu6CbRDVzxZ50ey
         rt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n5Juu5PL0YoW+NlcBtXZ8308O94SMFa4fjKIyTcHubs=;
        b=nUgbWZJPCAquZTvLDpYqA66/ILFdjp2N0JjjswcB4QWARbm9Uesj5Ct4OF5cchT3dQ
         OqzgcRKQ5FApwrxPIQd2yWwMiAk+lJ6lXG15FmaWxxogI4t9L4afWpZEZZzqSk4qcqDY
         j7GzT036iaFsXf9r1BLpuUgIZWqjC7ywhl4e6XDxWTklMZbH63flGCddPVyZmDsyNqyL
         gwGtDp/4VozjlEA/mApxINAxw6oIUomoBGMMGBMuCfCV83WGhnvsfR2MFdeLQwp+wAv9
         Ix855zqcqhAiXWPsBO81h+ho1AzKNd11/HBLnH9T+E0HJDTa6tQSS9K+KFXzACRbhAbA
         wHsA==
X-Gm-Message-State: AOAM531F5fPUmJl3CTf1HwAbdaH7wJu/cf9KS2zlveplEHwd3bbh6pw0
        CvWAnCfqBLYm6lg31NtIJhhrvUQOg2U=
X-Google-Smtp-Source: ABdhPJxF0GEnrJGY5/ZrqgH0148ljOMZQnvVt/HrP/tZtFaQMNcF1AeUuIZtdU6HT9KfvRFhCKwKlA==
X-Received: by 2002:adf:9104:: with SMTP id j4mr13403789wrj.198.1607677735695;
        Fri, 11 Dec 2020 01:08:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm12146453wma.32.2020.12.11.01.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 01:08:55 -0800 (PST)
Message-Id: <8db27892c598a3976c0742e23563f1d360b8dee1.1607677728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
        <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Dec 2020 09:08:45 +0000
Subject: [PATCH v2 6/9] t4058: explore duplicate tree entry handling in a bit
 more detail
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

While creating the last commit, I found a number of other cases where
git would segfault when faced with trees that have duplicate entries.
None of these segfaults are in the diffcore-rename code (they all occur
in cache-tree and unpack-trees).  Further, to my knowledge, no one has
ever been adversely affected by these bugs, and given that it has been
15 years and folks have fixed a few other issues with historical
duplicate entries (as noted in the last commit), I am not sure we will
ever run into anyone having problems with these.  So I am not sure these
are worth fixing, but it doesn't hurt to at least document these
failures in the same test file that is concerned with duplicate tree
entries.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4058-diff-duplicates.sh | 67 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/t/t4058-diff-duplicates.sh b/t/t4058-diff-duplicates.sh
index bd685089561..ad3f37d388d 100755
--- a/t/t4058-diff-duplicates.sh
+++ b/t/t4058-diff-duplicates.sh
@@ -119,4 +119,71 @@ test_expect_success 'diff-tree FROM duplicate tree, with renames' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create a few commits' '
+	git commit-tree -m "Duplicate Entries" two^{tree} >commit_id &&
+	git branch base $(cat commit_id) &&
+
+	git commit-tree -p $(cat commit_id) -m "Just one" three^{tree} >up &&
+	git branch update $(cat up) &&
+
+	git commit-tree -p $(cat up) -m "Back to weird" two^{tree} >final &&
+	git branch final $(cat final) &&
+
+	rm commit_id up final
+'
+
+test_expect_failure 'git read-tree does not segfault' '
+	test_when_finished rm .git/index.lock &&
+	test_might_fail git read-tree --reset base
+'
+
+test_expect_failure 'reset --hard does not segfault' '
+	test_when_finished rm .git/index.lock &&
+	git checkout base &&
+	test_might_fail git reset --hard
+'
+
+test_expect_failure 'git diff HEAD does not segfault' '
+	git checkout base &&
+	GIT_TEST_CHECK_CACHE_TREE=false &&
+	git reset --hard &&
+	test_might_fail git diff HEAD
+'
+
+test_expect_failure 'can switch to another branch when status is empty' '
+	git clean -ffdqx &&
+	git status --porcelain -uno >actual &&
+	test_must_be_empty actual &&
+	git checkout update
+'
+
+test_expect_success 'forcibly switch to another branch, verify status empty' '
+	git checkout -f update &&
+	git status --porcelain -uno >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'fast-forward from non-duplicate entries to duplicate' '
+	git merge final
+'
+
+test_expect_failure 'clean status, switch branches, status still clean' '
+	git status --porcelain -uno >actual &&
+	test_must_be_empty actual &&
+	git checkout base &&
+	git status --porcelain -uno >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'switch to base branch and force status to be clean' '
+	git checkout base &&
+	GIT_TEST_CHECK_CACHE_TREE=false git reset --hard &&
+	git status --porcelain -uno >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_failure 'fast-forward from duplicate entries to non-duplicate' '
+	git merge update
+'
+
 test_done
-- 
gitgitgadget

