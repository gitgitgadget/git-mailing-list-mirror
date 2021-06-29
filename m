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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60170C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A6EE61CE5
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhF2CHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhF2CHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:07:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF65C061768
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:04:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g7so19090275wri.7
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0UG3JvnANj8n21Qt83opuTu+nCqIMnauASnFCxaQri4=;
        b=VrS3rgNld0bAw9sg8rqhGLX2CmoO140VKd/tDbFcbZO+Hod4KsLn0W1dmY+Ty7xPfe
         Y4N/YngBk5K+rdTb8Nb8Jvib2Mki46FqzJCDDzDhtg6dwHDZiCAHDkN3y3jb5VKHSuZV
         UHF6DTlmGYnagzrROm5vNWF1Lp3Dm/zAs11cjI3OKcYs9mwWNxRiPQAftPNdLTmR6gBM
         SmyLJ6gZ/B6wNyWUC58oEW0C6bopWe4RbA9Ag61ieuxVipLh0NRX/0+1Q92EH8uoZe/J
         TlMEHkkqgDwRLwN9NHmPR0AlAdFXXxsiWy6QvsJM7MpDHtPzmwtkAEvoNKEb9iAzE5wv
         qxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0UG3JvnANj8n21Qt83opuTu+nCqIMnauASnFCxaQri4=;
        b=CpHzSo9S/9m2AfVxviizGWD5cFqlFXMfRhr93CD8nR2+cip11R2tqHlxB/ylXJZarA
         MggN9MLNmABBJGysMpc2CltaUnR55Xgd11sPmOwbZ1Q1EBgBLt0hf6OpL1tFV4LwCiVt
         KXWrun6V7QasFhyPT0ogElKpjiwdUeVnDoL+WWy3cYQMvIVEBytv+D06yW1ZHgN99cCI
         Df2zZA9jKSRjGIkw7gsgB3BCN0wFLAYpxDOaEW5Vb4B05KgUOa/f+Ic+o6zsbfiETfGv
         BOs4N5JaF25OnX726VLBxdwyRaG2AHN+BaosthyQYPsDXk+elmoyqBZs9WAuBy0kSSeX
         fMXw==
X-Gm-Message-State: AOAM532qgK1XkY4UHWWGoJ9iPqpjjFI07REEF1OdskTTjeIqZ20hKQkK
        7IoSoXVJVXRoFvpFjD7LyX8muz8JVlQ=
X-Google-Smtp-Source: ABdhPJygZ292atiG47Yf169lgf1byvU3hSV6mgVsl+bIDLM45T8oHctGhBQTG9TWHjNO6FEyerRrqw==
X-Received: by 2002:a5d:6106:: with SMTP id v6mr29607384wrt.278.1624932297836;
        Mon, 28 Jun 2021 19:04:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s18sm16886203wrw.33.2021.06.28.19.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:04:57 -0700 (PDT)
Message-Id: <e94ffa07d4671c4f2ab87ab0a1abba53b5906678.1624932293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
        <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:04:42 +0000
Subject: [PATCH v7 05/16] t1092: add tests for status/add and sparse files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
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
index 363d605c209..3f61e5686b5 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -254,6 +254,44 @@ test_expect_success 'add, commit, checkout' '
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

