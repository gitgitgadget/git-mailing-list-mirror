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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635DFC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36719611F1
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244036AbhDWVfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 17:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhDWVfH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 17:35:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BF5C06174A
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:34:28 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t14-20020a05600c198eb029012eeb3edfaeso1917063wmq.2
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Gng4CVH/clzaTPsSsOU7C34qQU1voJ+7k7GV9EFJ3C8=;
        b=cnkyodKP+XwuKRX2KnBn30DAr2D0K1UZdnAg3FbGO1ZWukZ+4vYft9m9KB/kT5VTlH
         lrg0kqasupA12brg+zw1Eou7LNCQvC3PEsJEIKTqigDt5yVKOc3S4XhfUTD4F+lXsJ7g
         wnP18f/nxMBAF7v3ELQm3TacdRJz3okcyrPQjErFh8hK88mbEMrnP0ADvtcdEMH/tGia
         A1XCiB4r6JSpWTHHFxsiTyVC6+j615+1ZC5pVIdwIC1iCdGPrRbcS3wZXa49Cdv6P/LW
         FeBpi8/ZfgJUWFipKn7ReTw8WsoPk17YVPMUAuWjMob7/AZ0BBFsesx5jkgspG1NJ8O8
         2BeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Gng4CVH/clzaTPsSsOU7C34qQU1voJ+7k7GV9EFJ3C8=;
        b=uh25RXIhYUHygm2VYSKxZRfS/DVOBv2ZObfPgZvKCgjb80YWNXJZ4nk0u1NdPr5SWH
         Q1SeuvDB94O5Vu+h279rk0Z2m9635CTrTnf7tEeMNNtmua1Lgu1t/x8qLULvH1meLUmh
         cHjg/cs4H4mC/tfXO35Em11Kk7YN4hJIDtRXZTqs/A8cTciyAWZe3uyfrHxvLO7Ip9iV
         YE/aJBAMZj4XxzFuTn40t0ofuO4kJeE1YE7VbzGGz/9BZ34Ilij8uu4zr6GXkmjqINYC
         NXVd9s/PEkIIuX71rMdJfg/IgWJPGZ+OWqVW2rfuVcilAzlX20EyHsWNKJMKHlO7WnEn
         hHTA==
X-Gm-Message-State: AOAM530uGMQIJyzvJMU30hedAn0ds4ULO2dBFBNXawLtcknsvfOj/Nif
        +7YdYHlTqPdH1e4CYK/UdoHwfu4hwW8=
X-Google-Smtp-Source: ABdhPJy110TiOmdxDQfRg1/6CyUAPTBtJoypE1BVIazQ7NZXlYSb7YhdNJsPasBcR045OqutFxUrHg==
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr6254851wmj.53.1619213667471;
        Fri, 23 Apr 2021 14:34:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17sm10842051wmq.30.2021.04.23.14.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 14:34:27 -0700 (PDT)
Message-Id: <3bac9edae7d82ef9fdabbe2f3959e574f79f1dd0.1619213665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
        <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Apr 2021 21:34:18 +0000
Subject: [PATCH v2 1/8] t1092: add tests for status/add and sparse files
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
not in the sparse cone. When 'folder1/a' is modified, the file
'folder1/a' is shown as modified, but adding it fails. This is new
behavior as of a20f704 (add: warn when asked to update SKIP_WORKTREE
entries, 2021-04-08). Before that change, these adds would be silently
ignored.

Untracked files are fine: adding new files both with 'git add .' and
'git add folder1/' works just as in a full checkout. This may not be
entirely desirable, but we are not intending to change behavior at the
moment, only document it. A future change could alter the behavior to
be more sensible, and this test could be modified to satisfy the new
expected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 40 ++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 12e6c453024f..0ec487acd283 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -232,6 +232,46 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
+test_expect_success 'status/add: outside sparse cone' '
+	init_repos &&
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
+	run_on_all ../edit-contents folder1/a &&
+	run_on_all ../edit-contents folder1/new &&
+
+	test_sparse_match git status --porcelain=v2 &&
+
+	# This "git add folder1/a" is completely ignored
+	# by the sparse-checkout repos. It causes the
+	# full repo to have a different staged environment.
+	#
+	# This is not a desirable behavior, but this test
+	# ensures that the sparse-index is not the cause
+	# of a behavior change.
+	test_sparse_match test_must_fail git add folder1/a &&
+	test_sparse_match test_must_fail git add --refresh folder1/a &&
+	git -C full-checkout checkout HEAD -- folder1/a &&
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

