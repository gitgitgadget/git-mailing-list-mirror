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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA48C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391BF613BD
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbhHXVzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbhHXVzf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:55:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46C1C0613CF
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso2860379wmb.2
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tDlSdtwCo5GDTbGHI77FRDcgSn8sGkTpZaUHwlUFMDM=;
        b=jKv0sm+H0f1tCULN/YSduVXFQVdePE6VBhz/sbaZxCi3rLcv1qm3S7xxn+CJDzvH/3
         mlIb99chdoNXnR+djqCm6P6LIczC2Jvaxg1ZAM1TvCxEp8ohD73MTLEzVnnf+epPvv7e
         GYs4H1jbxk0++10XqAcPzDd1W/4T7BYkrCDxfrDXE3xEPykdiuWEQ2+FCYHknVwuQ7tM
         fZqdZypi4pL9WWIyypVjX4ni0GnhutNVa74zY4JabXgGtoXt3uwBgs7Km5RN3APG8pSc
         k2IHcEd78z2HxtgAXVhmwKndrw2Wl2EwTEAmd08iinXXNTTt83iWTsycLsKtlrrIRGVe
         ZM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tDlSdtwCo5GDTbGHI77FRDcgSn8sGkTpZaUHwlUFMDM=;
        b=ZYAArCyV8AT2Pitt8x8S+IMYkQRVLJE9PKDLryCpnVuw338CPzxGJ/lIO0w0FpNhAv
         APbO3m4DAe349Qk8c0VV2S5L6j5jqPrNFWLkl/bYSdleFRRKUcpUT4JbORWMBnKxB8fD
         iPPj57pF/Iu5mkTWbh1sR+gGovOpONlGmlsi0noHXH3d5rtcrqCiOi1R+udT0FoqNq09
         WAgPzSgrnYu/hONUBTfdmH74P1NNr7XMMw8wPrvrlfWHF5e2h3n6vMRfNzi/utNpcWBY
         wGXbTcNfuja+O1AtBxdC+4IkD7IeSOdVtY5ThDjppJfuAhbI4jOM6KmHWwuVkrLLEfIQ
         l68g==
X-Gm-Message-State: AOAM530fHeuD/O0w9JCJBZe1nNJwNiiL6xlEE5sCN6AQRSwSQeWkL9Vn
        ivNOSyDbGjZxb4AU0cRvgQE/QR+JDfs=
X-Google-Smtp-Source: ABdhPJwIrwPY+Pjobw17VaIyHod9rWSmgN968lgPLvAy/DXBUeU06Nmvqa3haTRYPxz7/DacU7evdw==
X-Received: by 2002:a1c:7ece:: with SMTP id z197mr5818235wmc.141.1629842089367;
        Tue, 24 Aug 2021 14:54:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7sm3340448wmq.29.2021.08.24.14.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:54:49 -0700 (PDT)
Message-Id: <e80fcfa932cca394c5c8b349cafadb0754a594dd.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:54:37 +0000
Subject: [PATCH 05/13] add: fail when adding an untracked sparse file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The add_files() method in builtin/add.c takes a set of untracked files
that are being added by the input pathspec and inserts them into the
index. If these files are outside of the sparse-checkout cone, then they
gain the SKIP_WORKTREE bit at some point. However, this was not checked
before inserting into the index, so these files are added even though we
want to avoid modifying the index outside of the sparse-checkout cone.

Add a check within add_files() for these files and write the advice
about files outside of the sprase-checkout cone.

This behavior change modifies some existing tests within t1092. These
tests intended to document how a user could interact with the existing
behavior in place. Many of these tests need to be marked as expecting
failure. A future change will allow these tests to pass by adding a flag
to 'git add' that allows users to modify index entries outside of the
sparse-checkout cone.

The 'submodule handling' test is intended to document what happens to
directories that contain a submodule when the sparse index is enabled.
It is not trying to say that users should be able to add submodules
outside of the sparse-checkout cone, so that test can be modified to
avoid that operation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c                            | 14 ++++++++++
 t/t1092-sparse-checkout-compatibility.sh | 33 +++++++++++++++++-------
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 88a6c0c69fb..3a109276b74 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -443,6 +443,7 @@ static void check_embedded_repo(const char *path)
 static int add_files(struct dir_struct *dir, int flags)
 {
 	int i, exit_status = 0;
+	struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
 
 	if (dir->ignored_nr) {
 		fprintf(stderr, _(ignore_error));
@@ -456,6 +457,11 @@ static int add_files(struct dir_struct *dir, int flags)
 	}
 
 	for (i = 0; i < dir->nr; i++) {
+		if (!path_in_sparse_checkout(dir->entries[i]->name, &the_index)) {
+			string_list_append(&only_match_skip_worktree,
+					   dir->entries[i]->name);
+			continue;
+		}
 		if (add_file_to_index(&the_index, dir->entries[i]->name, flags)) {
 			if (!ignore_add_errors)
 				die(_("adding files failed"));
@@ -464,6 +470,14 @@ static int add_files(struct dir_struct *dir, int flags)
 			check_embedded_repo(dir->entries[i]->name);
 		}
 	}
+
+	if (only_match_skip_worktree.nr) {
+		advise_on_updating_sparse_paths(&only_match_skip_worktree);
+		exit_status = 1;
+	}
+
+	string_list_clear(&only_match_skip_worktree, 0);
+
 	return exit_status;
 }
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 23bee918260..962bece03e1 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -291,8 +291,6 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
-# NEEDSWORK: This documents current behavior, but is not a desirable
-# behavior (untracked files are handled differently than tracked).
 test_expect_success 'add outside sparse cone' '
 	init_repos &&
 
@@ -300,7 +298,7 @@ test_expect_success 'add outside sparse cone' '
 	run_on_sparse ../edit-contents folder1/a &&
 	run_on_sparse ../edit-contents folder1/newfile &&
 	test_sparse_match test_must_fail git add folder1/a &&
-	test_sparse_match git add folder1/newfile
+	test_sparse_match test_must_fail git add folder1/newfile
 '
 
 test_expect_success 'commit including unstaged changes' '
@@ -331,7 +329,11 @@ test_expect_success 'commit including unstaged changes' '
 	test_all_match git status --porcelain=v2
 '
 
-test_expect_success 'status/add: outside sparse cone' '
+# NEEDSWORK: Now that 'git add folder1/new' fails, the changes being
+# attempted here fail for the sparse-checkout and sparse-index repos.
+# We must enable a way for adding files outside the sparse-checkout
+# done, even if it is by an optional flag.
+test_expect_failure 'status/add: outside sparse cone' '
 	init_repos &&
 
 	# folder1 is at HEAD, but outside the sparse cone
@@ -352,10 +354,9 @@ test_expect_success 'status/add: outside sparse cone' '
 	# Adding the path outside of the sparse-checkout cone should fail.
 	test_sparse_match test_must_fail git add folder1/a &&
 	test_sparse_match test_must_fail git add --refresh folder1/a &&
+	test_sparse_match test_must_fail git add folder1/new &&
 
-	# NEEDSWORK: Adding a newly-tracked file outside the cone succeeds
-	test_sparse_match git add folder1/new &&
-
+	# NEEDSWORK: behavior begins to deviate here.
 	test_all_match git add . &&
 	test_all_match git status --porcelain=v2 &&
 	test_all_match git commit -m folder1/new &&
@@ -511,7 +512,7 @@ test_expect_success 'merge, cherry-pick, and rebase' '
 # Right now, users might be using this flow to work through conflicts,
 # so any solution should present advice to users who try this sequence
 # of commands to follow whatever new method we create.
-test_expect_success 'merge with conflict outside cone' '
+test_expect_failure 'merge with conflict outside cone' '
 	init_repos &&
 
 	test_all_match git checkout -b merge-tip merge-left &&
@@ -525,12 +526,18 @@ test_expect_success 'merge with conflict outside cone' '
 	test_all_match git status --porcelain=v2 &&
 
 	# 2. Add the file with conflict markers
+	# NEEDSWORK: Even though the merge conflict removed the
+	# SKIP_WORKTREE bit from the index entry for folder1/a, we should
+	# warn that this is a problematic add.
 	test_all_match git add folder1/a &&
 	test_all_match git status --porcelain=v2 &&
 
 	# 3. Rename the file to another sparse filename and
 	#    accept conflict markers as resolved content.
 	run_on_all mv folder2/a folder2/z &&
+	# NEEDSWORK: This mode now fails, because folder2/z is
+	# outside of the sparse-checkout cone and does not match an
+	# existing index entry with the SKIP_WORKTREE bit cleared.
 	test_all_match git add folder2 &&
 	test_all_match git status --porcelain=v2 &&
 
@@ -539,7 +546,7 @@ test_expect_success 'merge with conflict outside cone' '
 	test_all_match git rev-parse HEAD^{tree}
 '
 
-test_expect_success 'cherry-pick/rebase with conflict outside cone' '
+test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
 	init_repos &&
 
 	for OPERATION in cherry-pick rebase
@@ -556,11 +563,17 @@ test_expect_success 'cherry-pick/rebase with conflict outside cone' '
 		test_all_match git status --porcelain=v2 &&
 
 		# 2. Add the file with conflict markers
+		# NEEDSWORK: Even though the merge conflict removed the
+		# SKIP_WORKTREE bit from the index entry for folder1/a, we should
+		# warn that this is a problematic add.
 		test_all_match git add folder1/a &&
 		test_all_match git status --porcelain=v2 &&
 
 		# 3. Rename the file to another sparse filename and
 		#    accept conflict markers as resolved content.
+		# NEEDSWORK: This mode now fails, because folder2/z is
+		# outside of the sparse-checkout cone and does not match an
+		# existing index entry with the SKIP_WORKTREE bit cleared.
 		run_on_all mv folder2/a folder2/z &&
 		test_all_match git add folder2 &&
 		test_all_match git status --porcelain=v2 &&
@@ -638,6 +651,7 @@ test_expect_success 'clean' '
 test_expect_success 'submodule handling' '
 	init_repos &&
 
+	test_sparse_match git sparse-checkout add modules &&
 	test_all_match mkdir modules &&
 	test_all_match touch modules/a &&
 	test_all_match git add modules &&
@@ -647,6 +661,7 @@ test_expect_success 'submodule handling' '
 	test_all_match git commit -m "add submodule" &&
 
 	# having a submodule prevents "modules" from collapse
+	test_sparse_match git sparse-checkout set deep/deeper1 &&
 	test-tool -C sparse-index read-cache --table >cache &&
 	grep "100644 blob .*	modules/a" cache &&
 	grep "160000 commit $(git -C initial-repo rev-parse HEAD)	modules/sub" cache
-- 
gitgitgadget

