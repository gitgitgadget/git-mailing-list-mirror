Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA6FC43457
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FBE7223BE
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2iIxO8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbgJSTbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgJSTbt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 15:31:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D98C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x7so1035830wrl.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/EnYefy9FtBroImVDVpDBZju4wSiIiy3qgJ3y+deKaY=;
        b=N2iIxO8AwgyOt/n25stlCbDFWqTo0Rb9ZScNNjBzjl4PdIrLqfq99J86ZHgbg8g+a1
         iFBfkahfEgDz2QSTsVgmsm4LOKl+6xQhRtIHlrDqv1ukTW6sqm24Q5tFTbQ0e0aJa04N
         pAbtk+QWfg/8JH4d2gXNNTRnjTS2HuddmAL6Z+L7G0lejrXbHxx5V+IFC2E3vUYbbXOU
         qlDUhe23Sy68X7d0eKW4AIcSSmzF08CU+BjgT+3tSyB7ofXGmuPVtX7lRqY6hqOnVeVp
         FdgHTS84Cv6tuBKXHEZ3J5juryM+qO3pKyZ+uJEMVQl117Cf8Pz4OyfHhCGv9ReFws7f
         dZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/EnYefy9FtBroImVDVpDBZju4wSiIiy3qgJ3y+deKaY=;
        b=HqFUkbB8ZRbKay9YfTGOQtXxdJPQYVlM2hewHJcFjfCByTPbxPeFriDkSPpzl0O7c8
         D/XDXmx94+Q5WTY6/jIMlZNl3mrNMV0yFCFOlNW5mnGsq2yoa1NYbKspyUlDVbv6VjK/
         eosGPCjEQaZcDlrjzmp4nt1O/nGU7mR2iP4bVmT7WJ+OnaHddqWV+h+4wvlL9FWKcj87
         XnMzjIXtMd5FfhBU0TH4RKg/OcHZctRlAac0kVDndmwxuHzh1oWV4t44KirePAOLpL69
         TlUveXXU190oRFOjn+RMxa64FPdCRjPB1GdyoVDkOqnbUZLRSPBt2071nmGAtyi2ZPDH
         hNhA==
X-Gm-Message-State: AOAM532uOI9QxnDU83U3uEL/fFqZVvFW1awV+sfZCNoC7ZJJXxByKLPb
        Ps1wGO1ZSNcZO2uzh3BSTbKwyrlvqFU=
X-Google-Smtp-Source: ABdhPJxeLi7GpMzP1WxGAG4KuvI19kvhV7GFq27m8KH5kB+UYhxA/Tuw/Pm+Z9iZBaJnS76G6gvKjQ==
X-Received: by 2002:a5d:608f:: with SMTP id w15mr798706wrt.183.1603135908070;
        Mon, 19 Oct 2020 12:31:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x64sm686861wmg.33.2020.10.19.12.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:31:47 -0700 (PDT)
Message-Id: <d9469202c2dda238882150452fac1aa7fc7fbfec.1603135902.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.git.1603135902.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 19:31:34 +0000
Subject: [PATCH 03/10] tests: start moving to a different default main branch
 name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To allow for an incremental conversion to a new default main branch
name, let's introduce `GIT_TEST_DEFAULT_MAIN_BRANCH_NAME`. This
environment variable can be set at the top of each converted test
script, overriding the default main branch name to use when initializing
new repositories (or cloning empty repositories).

Note: the `GIT_TEST_DEFAULT_MAIN_BRANCH_NAME` is _not_ intended to be
used manually; many tests require a specific main branch name and cannot
simply work with another one. This `GIT_TEST_*` variable is meant purely
for the transitional period while the entire test suite is converted to
use `main` as the initial branch name by default.

We also introduce the `PREPARE_FOR_MAIN_BRANCH` prereq that determines
whether the default main branch name is `main`, and adjust a couple of
test functions to use it. This prereq will be used to temporarily
disable a couple test cases to allow for adjusting the test script
incrementally. Once an entire test is adjusted, we will adjust the test
so that it is run with `GIT_TEST_DEFAULT_MAIN_BRANCH_NAME=main`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 refs.c                    |  5 ++++-
 t/lib-submodule-update.sh |  2 +-
 t/t0001-init.sh           | 13 ++++++++++---
 t/t5606-clone-options.sh  |  3 +++
 t/test-lib.sh             |  7 +++++++
 5 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index fa01153151..392f0bbf68 100644
--- a/refs.c
+++ b/refs.c
@@ -567,8 +567,11 @@ char *repo_default_branch_name(struct repository *r)
 	const char *config_key = "init.defaultbranch";
 	const char *config_display_key = "init.defaultBranch";
 	char *ret = NULL, *full_ref;
+	const char *env = getenv("GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME");
 
-	if (repo_config_get_string(r, config_key, &ret) < 0)
+	if (env && *env)
+		ret = xstrdup(env);
+	else if (repo_config_get_string(r, config_key, &ret) < 0)
 		die(_("could not retrieve `%s`"), config_display_key);
 
 	if (!ret)
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 87a759149f..bd3fa3c6da 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -144,7 +144,7 @@ create_lib_submodule_repo () {
 		git checkout -b valid_sub1 &&
 		git revert HEAD &&
 
-		git checkout master
+		git checkout "${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}"
 	)
 }
 
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 2f7c3dcd0f..69a320489f 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -553,14 +553,21 @@ test_expect_success '--initial-branch' '
 
 test_expect_success 'overridden default initial branch name (config)' '
 	test_config_global init.defaultBranch nmb &&
-	git init initial-branch-config &&
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= git init initial-branch-config &&
 	git -C initial-branch-config symbolic-ref HEAD >actual &&
 	grep nmb actual
 '
 
+test_expect_success 'overridden default main branch name (env)' '
+	test_config_global init.defaultBranch nmb &&
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=env git init main-branch-env &&
+	git -C main-branch-env symbolic-ref HEAD >actual &&
+	grep env actual
+'
+
 test_expect_success 'invalid default branch name' '
-	test_config_global init.defaultBranch "with space" &&
-	test_must_fail git init initial-branch-invalid 2>err &&
+	test_must_fail env GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME="with space" \
+		git init initial-branch-invalid 2>err &&
 	test_i18ngrep "invalid branch name" err
 '
 
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index e69427f881..856eebf222 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -37,6 +37,7 @@ test_expect_success 'redirected clone -v does show progress' '
 
 test_expect_success 'chooses correct default initial branch name' '
 	git init --bare empty &&
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
 	git -c init.defaultBranch=up clone empty whats-up &&
 	test refs/heads/up = $(git -C whats-up symbolic-ref HEAD) &&
 	test refs/heads/up = $(git -C whats-up config branch.up.merge)
@@ -51,9 +52,11 @@ test_expect_success 'guesses initial branch name correctly' '
 
 	git -c init.defaultBranch=none init --bare no-head &&
 	git -C initial-branch push ../no-head guess abc &&
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
 	git clone no-head is-it2 &&
 	test_must_fail git -C is-it2 symbolic-ref refs/remotes/origin/HEAD &&
 	git -C no-head update-ref --no-deref HEAD refs/heads/guess &&
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
 	git -c init.defaultBranch=guess clone no-head is-it3 &&
 	test refs/remotes/origin/guess = \
 		$(git -C is-it3 symbolic-ref refs/remotes/origin/HEAD)
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ef31f40037..6b35070d22 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1702,3 +1702,10 @@ test_lazy_prereq SHA1 '
 test_lazy_prereq REBASE_P '
 	test -z "$GIT_TEST_SKIP_REBASE_P"
 '
+# Special-purpose prereq for transitioning to a new default branch name:
+# Some tests need more than just a mindless (case-preserving) s/master/main/g
+# replacement. The non-trivial adjustments are guarded behind this
+# prerequisite, acting kind of as a feature flag
+test_lazy_prereq PREPARE_FOR_MAIN_BRANCH '
+	test "$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME" = main
+'
-- 
gitgitgadget

