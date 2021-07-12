Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76860C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6355D611C1
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbhGLR6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbhGLR6v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:58:51 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15AEC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id w13so11969402wmc.3
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TF6o2tbbkpnAZzSCB71Xp9b8sR9m4FQKmWDgSsgnvdk=;
        b=WDbHDurPjMRt+CnfLgfPx+bp/JnVbp65GhxryifOMR0mpOBg7Yinm0SxzBkfoTW6IJ
         9vr2UbE1YnEYwQe/qD3OlxHWiMCpbFL8LBPUJmPhxZutSNSthdC7PU/2XBL28pZbZG5Z
         IacK4fsOhT2OXmisj26bS/keBYLpiDg8SrJvFmjxKmQROdLk0UVaovd+CyrSVXK/K5zX
         iE7W90bqStsYd/eooyo7ETYgcG8V0QdXjZczXnDPe6Yzx4upKAQHh1C2JDhbumIFyMEN
         OsA4CR6WiSaqNcaxQf6mSok69gh9II9UZpDHmlon/SQLNd9FqvMAnVPwVAZ/j/L+lTQ8
         R5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TF6o2tbbkpnAZzSCB71Xp9b8sR9m4FQKmWDgSsgnvdk=;
        b=FLxv8Ctbw1k5+faHraiEozAw4KJKoLk2Etu25cWKK6nc6bvfkDSSdbei5W5ccRYWkP
         Wbxay+n8cPCDpJB009OR9p+Vcnxn4A4OMT7PB42hLW365f8NYQ0ycWqBsL396TmPfw/0
         1gY0rjDYbT6aXSkKL6CIWHYJa6yyEB8YhHwactBqed0MesxCEu7g0kXE6vdbQjz568Px
         X7Ln8ptBcLfFm/dxWdJwWsPkTtOoLU+xDTjlH0Vi5jPdjZkeuJhXIm9ghARnBRq/Ikxt
         4l2WFrOsTpMebydICWdc3U8wSaBUNAXzNmGVWJb4ZIK+Gdfmkpuk5h/bxqgiTMJihu9A
         cprw==
X-Gm-Message-State: AOAM532M0OByVpioceieIs4xXD2IL1F7u1kAEjl4QN58Pkn2rAoEpAw0
        LsVwZPR1Yv2xEcqSoq3VltrXmjH3HnI=
X-Google-Smtp-Source: ABdhPJxv6NqacRTcPH9HZak6H9/3n3hL8uMj+/N/AjIyNcKBURCQ+Bxg768+aGQBiZaJ/5rNCpY3UQ==
X-Received: by 2002:a05:600c:1911:: with SMTP id j17mr447805wmq.172.1626112561464;
        Mon, 12 Jul 2021 10:56:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm13882007wrh.16.2021.07.12.10.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:56:01 -0700 (PDT)
Message-Id: <95ddd3abe4e5c85e4c911ba6c2d4bd86099085b4.1626112556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
References: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
        <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 17:55:46 +0000
Subject: [PATCH v8 05/15] t1092: add tests for status/add and sparse files
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

