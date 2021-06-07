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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9344EC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F414610E7
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhFGMga (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhFGMg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:36:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4246C061787
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 05:34:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso10060951wmj.2
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 05:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+ogwDcxCEiMKWorMKe+xR/DrERNlwwf/QahOIWiecqg=;
        b=QSjv1EubhE26f5fDtYxN+e/O8iWIUVRELRZZ4rO35v5Azzy3ErSnI2WTD9HAp3rwNs
         7dQam7kYV4t3uvwK8qVId07dx+EBW4uDkib781fAvLv71elUOjIO7CSyuQbJr+QpLozP
         EUji080RYa8zxYd6TN/dJhV9b7RjSEhwTkS3J8PqojRkiYWhmmrJbCB8FE3aGmui2mWV
         2mAl0MU5A7kFv3WIoTMkCdfxAAgZ+5QMJtV6bnUKl44Schsr5yPizeq6LwC2XYwfF30o
         VddHeDfTCFUIXAtaW3LVQRi2rqV0X2V478+W4qzX/EFsJ64cKoRM5NXJw/xGuT+UxRNB
         YqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+ogwDcxCEiMKWorMKe+xR/DrERNlwwf/QahOIWiecqg=;
        b=YpIqdjqCYbJlFxtUwStjJd4Fm9W+3qboOijwpqRpMN8K+rCqL+Gs/infcpMINYWeah
         y4g1cQwY3MGQfs3puWgTBCU+5OdMTsuiMX7h2qMB2p5Pet30tuuLaM8Vra0AaNYQMRK8
         pOkVvIcdoKxMMTMb479543TnifqzQNi8TmjsvCaKB+HhFeCQbt35b2TKOXrc+dSaSDMi
         CPRMMgNCpe8Nq6lFwhQv9OfCQgfdqiTRfeygJOeD7SpQDkmIqU475sMinFNKgp8US5xH
         PM/J9RFN7HkTfO0cA4BZZEfUZpyEV1Capic8FQeZ8srAW3Se4zVNgAMSMPGcgOPzHii/
         tDYA==
X-Gm-Message-State: AOAM530RpjVn8rw8T1b2MS2fTeIF/KQg2X7P4LzxkAPOiX6ub+3AGPBQ
        ct1DLjgqGuJgUe5iHRKsQKIgxmYzdhY=
X-Google-Smtp-Source: ABdhPJyKVGJ3Ch+8mVxmQX6S8hLAVHz1Pdb+hQj+tikVaqJtxtW28Wq6a1sqcBR6kk02WFox92emmA==
X-Received: by 2002:a7b:c394:: with SMTP id s20mr12182505wmj.33.1623069257292;
        Mon, 07 Jun 2021 05:34:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9sm10808467wrn.54.2021.06.07.05.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:34:17 -0700 (PDT)
Message-Id: <856346b72f7988eed6fe41cc7f1221a221442c98.1623069252.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
        <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 12:34:03 +0000
Subject: [PATCH v5 05/14] t1092: add tests for status/add and sparse files
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
index 014a507d8b06..851a83388e4b 100755
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

