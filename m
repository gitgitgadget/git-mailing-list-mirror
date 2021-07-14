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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE2BC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CCA76128B
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbhGNNPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239364AbhGNNPj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:15:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59533C061762
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y21-20020a7bc1950000b02902161fccabf1so3882848wmi.2
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PBT0dVfRrVCp0TkoDEhnbxnEp4snxgTbqttbvBm9cM4=;
        b=H7kYDz4gr94b8Q9OzRTlB7xNJNLwrto2RAtGp1a3YCaH9Y5+P0/1eGgKwt1QeQAJ5F
         H7exY9ewG+kmEJg5Fk5pqM9xlQcx2qFV/tyyTFZr8reUH1Qne/zcbV8wmPtQeQYG0Kmt
         viVSKbCrxiLWhrKZnIf49Np/tB7sfNZ6f3xdqtgDA88MbUajDa91+EE8peJXHIqZHm6G
         ouUoaggDOMBGn/Ui2Brffm1hoA0xwpgTQNoCN6qyo9MtZ7ezwS6Wv6RK++Ut9zutA2d5
         w3tjLlohb3dE5j5D2QCMhfcBPZnQe/Jnir0s7/00yKHQad321wl6196OTWvjcEeQRYsF
         E++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PBT0dVfRrVCp0TkoDEhnbxnEp4snxgTbqttbvBm9cM4=;
        b=P7GV4bHgSqnY1QQcl4zc+jKNZW4CS5a/MHhQjkQPBrp6mPXbtVl0iGrgm6jftlibwc
         mPQGec0Z0HuQqvw9cmBLgJtj95Js0FrfRgRc/X6EhhaIpzr+eQx42vpZXkP91Bf8ID9R
         Go9+31opha30iZ0S64DoUFNfBw9fFCzC0eqT5GGyEnM1wdyDeF/sUP5qDwhHT1lfOr5y
         yL0mJFU2K6r0bCcJ9Nd4DTsN9+9Qlpim5pI0q7Z8uNrveTrw/+5RYL2puGt2l4MJQvZQ
         r9Sm/tnerS2VZ3u0SSAoHwzkhapholW5VO0O03AFHtSfCY7jRziw70uV71/4gRIVHJw1
         sxGg==
X-Gm-Message-State: AOAM532bWfTJTKiNjtstcO+8t7z8ui/10KzL4qCQ+tq/95RHKJdTYO+f
        wt3ovsYLeFgFvqhhi9EU/Edo0kYU7kQ=
X-Google-Smtp-Source: ABdhPJzvnX7mI3DmiaXRh8KC3hbgYQn7fWmknOTZkCCNF1A/2HSoFi/N6PwIKKk5gjgONnPHac5xug==
X-Received: by 2002:a05:600c:1c9f:: with SMTP id k31mr4053234wms.47.1626268365969;
        Wed, 14 Jul 2021 06:12:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l34sm6126892wms.45.2021.07.14.06.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:12:45 -0700 (PDT)
Message-Id: <cc83a0cd3079f1400bcb5405e914206fa422404f.1626268360.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
        <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:12:29 +0000
Subject: [PATCH v9 05/16] t1092: add tests for status/add and sparse files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de, Bagas Sanjaya <bagasdotme@gmail.com>,
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

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 0e71a623619..2269f44e033 100755
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

