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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5061EC11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A37061CCE
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhF2ByZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhF2ByQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:54:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C83C061760
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j1so23627856wrn.9
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7JZLdoqa+U8o4yiwGgoo7PP+W0UjuNrjA0Zez9LhlL0=;
        b=UKlX1EVg+Amzc0bavReHXEq/CoGdPXtM96g21GHuvN08CPXmqz4ielAymdTz/qJSl6
         oVU7V+3cfhAHVo6dtWAAC888DBjj8mME0DFTOiP5XBxJvf1HuVHjVjRYbQbOTIWWAvr0
         /soqNbEeVnZcEthrLXCWqGoHavpE+oU8sx1sXV/qIP5q21pTYs5mxhW1HxPVnqrQfLAz
         lg8kE08FLzP98qDoyUUYQv8qBjHeX15n5iRxgzqw2UisGLHGg44SBbwZYJifavjOf6XV
         jm7cnP4G/r4sSU5ZDE9aNucWJE5coklFFyw84VTJhwJsZfy/UkQc0NLojhYtolM352g9
         xRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7JZLdoqa+U8o4yiwGgoo7PP+W0UjuNrjA0Zez9LhlL0=;
        b=sqCB2pMeJMwI+9vLup2h95laa91Nsm/vaPX711xqmBss3pY49ot5RT3sWTe6Dnry4A
         aaQ/e1AUs9rRgtiF2v7HwbboQVdbQhJS/FEmZljYDdRSvxKVtg3yDubGR1TsFUoIyTkQ
         LvPvVHuGdOT4QVHVK4sNb15cMWxQA+qYiAW3rfeHkp6Qxym+C3xTluxLwvcMIBqsjUbN
         ZbIvel0mfOvuNjiFBM9JVSJDfPkXnwlC+OUPi1/tj9HLES2+b74gKUMMV9MEdGZt05gB
         Jwrv1zeWi6ZIuPIOuV6x13bmRWKwUoPddOPg8uLmOcpMS3hkzZRM1YRmZJMyOsX1VToC
         WFDA==
X-Gm-Message-State: AOAM531FYgZumPxjXQ/28/atSuO9PiG3T47Y88Jk1vlfxjs02peZBs0d
        xXvoQ6tHepp/RjnQ5HUlpfRWXlfZnWI=
X-Google-Smtp-Source: ABdhPJzQNrofL23pa5lWLRVFYwaFB6PvWMrApQ52FfK6MvGBcguCoRTy5dXK18qv7RylBPEAyFkrcg==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr7109560wrn.114.1624931506965;
        Mon, 28 Jun 2021 18:51:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s18sm16862439wrw.33.2021.06.28.18.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:51:46 -0700 (PDT)
Message-Id: <701ac0e8ff6331284e63047bceed98d1219daa47.1624931502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
References: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
        <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 01:51:33 +0000
Subject: [PATCH v6 05/14] t1092: add tests for status/add and sparse files
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
index 4a7b48e8d3f..7c78e40b861 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -251,6 +251,44 @@ test_expect_success 'add, commit, checkout' '
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

