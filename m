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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB23C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C397861444
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbhENScf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 14:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbhENSca (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 14:32:30 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F6EC06175F
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o6-20020a05600c4fc6b029015ec06d5269so235948wmq.0
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pAyAAv6l4SLCdrEeaFHhQFp08BencxoPH4VLlINqObY=;
        b=Dn0MYHe13HsK0uSFKBIBOt7KkWU6fMGjJaZ0QpHBGIx/VPMBdOIyOxuXVElkYGwdeD
         DfzqxiVSLyNCk0bb002lcTCvbEcj2KUVpWLqjxt2/ocNBdNz6ITn/Uio1cyXNrPsF5T+
         0m/JgndP2OTsdr4eUshDWJL3ZFHD3P0+CjIH5AqFhYb5cfl7W+CUtNWFAPZN88foJxCg
         d7hk87jjNU9GxkAlkRdcWn6XY9UNQtQShc5oN+yv0W1efjAwuCTk5hQ79bfQACcs0ZpU
         UWhfUhEZudOG7zxzEWm299d5PatfTNmg4TWIT4j50QvG1uMomXl74NZw0uYo50VbR2jS
         BYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pAyAAv6l4SLCdrEeaFHhQFp08BencxoPH4VLlINqObY=;
        b=JO6lK6EOio0XGSAFpvsAgc2AUnnCE6v7kC79/rjcFgXyW4OOy7rsBl3abNQGx17+a9
         5Pw17TjtOiSnlObPWSUApSnuVhzbrl5M1OKHABIQ29tuVRjg8GGkj1F51fM3aPb8DAFZ
         qdWcQncN7kF8zI1Qrql9koTr/meFMOiL+Azz111AzVxg+DCbrYsuNxyYT4wrDoZGKbcb
         qqkdSYJ/DIZvjjwzSquzYmBkimzMhlC9WBmbJSv+iSnY5BLG5qznctxWkQ732gKR4d+R
         nHdNbcWgLhDCNbj6HfsgyCwqqhAAdaz68EV2I6hV0hNAa8cGGDiaNMLnhK5bW1Gqtljk
         CX9w==
X-Gm-Message-State: AOAM531zOAlQ1TxVDOZ3G4Hzi6pH3pL5r0xuwOrp+vvNkz19p6Ucdi2S
        uJYrgMSqZRWA5cPvvsevOuM71XXuF30=
X-Google-Smtp-Source: ABdhPJy5p2ZCykh5Tqe72WY4LHhv9mg/hoNqPy2w1J7s1XO3DzFxseg/CcjRXMbkZIDFty2utQQlbg==
X-Received: by 2002:a05:600c:4fd3:: with SMTP id o19mr10488350wmq.17.1621017077351;
        Fri, 14 May 2021 11:31:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 61sm8008268wrm.52.2021.05.14.11.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 11:31:16 -0700 (PDT)
Message-Id: <a80b5a41153f07a58167be9c9759f3af3048cc5d.1621017072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
        <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 May 2021 18:31:03 +0000
Subject: [PATCH v3 04/12] t1092: add tests for status/add and sparse files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before moving to update 'git status' and 'git add' to work with sparse
indexes, add an explicit test that ensures the sparse-index works the
same as a normal sparse-checkout when the worktree contains directories
and files outside of the sparse cone.

Specifically, 'folder1/a' is a file in our test repo, but 'folder1' is
not in the sparse cone. When 'folder1/a' is modified, the file is not
shown as modified and adding it will fail. This is new behavior as of
a20f704 (add: warn when asked to update SKIP_WORKTREE entries,
2021-04-08). Before that change, these adds would be silently ignored.

Untracked files are fine: adding new files both with 'git add .' and
'git add folder1/' works just as in a full checkout. This may not be
entirely desirable, but we are not intending to change behavior at the
moment, only document it. A future change could alter the behavior to
be more sensible, and this test could be modified to satisfy the new
expected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 98257695979a..fba98d5484ae 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -238,6 +238,44 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
+test_expect_success 'status/add: outside sparse cone' '
+	init_repos &&
+
+	# adding a "missing" file outside the cone should fail
+	test_sparse_match test_must_fail git add folder1/a &&
+
+	# folder1 is at HEAD, but outside the sparse cone
+	run_on_sparse mkdir folder1 &&
+	cp initial-repo/folder1/a sparse-checkout/folder1/a &&
+	cp initial-repo/folder1/a sparse-index/folder1/a &&
+
+	test_sparse_match git status &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+	run_on_sparse ../edit-contents folder1/a &&
+	run_on_all ../edit-contents folder1/new &&
+
+	test_sparse_match git status --porcelain=v2 &&
+
+	# This "git add folder1/a" fails with a warning
+	# in the sparse repos, differing from the full
+	# repo. This is intentional.
+	test_sparse_match test_must_fail git add folder1/a &&
+	test_sparse_match test_must_fail git add --refresh folder1/a &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git add . &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git commit -m folder1/new &&
+
+	run_on_all ../edit-contents folder1/newer &&
+	test_all_match git add folder1/ &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git commit -m folder1/newer
+'
+
 test_expect_success 'checkout and reset --hard' '
 	init_repos &&
 
-- 
gitgitgadget

