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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E21C433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99006008E
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbhEUMB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 08:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbhEUMBM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 08:01:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EC7C06138A
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j14so19071960wrq.5
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pAyAAv6l4SLCdrEeaFHhQFp08BencxoPH4VLlINqObY=;
        b=O9Aey+dMZuvoPa/GLKjYM1UuiSUTX1c/Pv0gbc+dmJE00AUbvcT3A/Mu2SQib3/Xxu
         ZztK3zWz73DAUVY7qA9u6QcK1pXQ5GyGorR0fnB87OsszCXbv4xmyGQ68e+dH3TtcCKC
         pErH5Qt6bSdNDgpbYYDRGrfqfQpEdY/WBqGLkCS+5TDXHI7xNXBjFjGNX6SiToCgWHrC
         ufkBDU6UTLanGoSczQmB7B7QZ8UBTi2qPsYajCOEF413BuEKNUGsSI/oNvH33CQcaIb6
         +/v1KiOfKD7+9b4VcRGmJPJgHvPILrPu5JFEoXm4VwlNd81qCmY9fZywtYHQIjteq8T5
         sveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pAyAAv6l4SLCdrEeaFHhQFp08BencxoPH4VLlINqObY=;
        b=iElzx4IYqnfmQUI86nCm4RLnqSU7ANegbi3jyLyYnGopMwq+/aUxliSTABP1QgUw79
         Ei0WEUjss+5BEgSUnvvX9opk/s/HN0mGrwW2JQvjILsAm6Amjk3zWPT+bsE4TCRnmKps
         bUTjciUgIR88rOMUxb6huVu1eIsT7V4KmoUKV5Hk4qWv0yQ3fBvBgogYVvANkLje5vzc
         /9e7Lkj0YtXoC457129ZLgUwlyhku0YUKlwBADxkvlcu2xQbUJIeoS9in0X93zQePcGg
         MaQ4gQYqCIxk8OIIoPNkKvxKMSRTYDpQpOVklxlvrtkYiAyWecb0iYwvMLGAu3AubTpR
         ufRA==
X-Gm-Message-State: AOAM531ychIrGPlxldK9PbV5K+Y6I2PhgAv2cal/SV6Sv3GvI1RXc/FO
        RvFE7qBdgyqO8alOrB4xwdtUi4f3o3o=
X-Google-Smtp-Source: ABdhPJyjd1rH9CnYVnR4bplmzMtsIq+v5qdWmpWNZZNoLRYLgvl3cDv8TNgFtQn9Zx4dS4nDYOlTKQ==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr9283367wru.94.1621598385999;
        Fri, 21 May 2021 04:59:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm1867288wrt.97.2021.05.21.04.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 04:59:45 -0700 (PDT)
Message-Id: <a80b5a41153f07a58167be9c9759f3af3048cc5d.1621598382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
References: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
        <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 May 2021 11:59:33 +0000
Subject: [PATCH v4 04/12] t1092: add tests for status/add and sparse files
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

