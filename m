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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4658EC432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB7E613CD
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbhHXVzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238063AbhHXVzg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:55:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D197C0613D9
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e5so16784887wrp.8
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8dFQrDagHAvPHfySdjImTPILlQLOjQlQyL3J8ZnSfx4=;
        b=kSt4uSr8O1NIeyzMuCqJnmbLtJdPp8P5oVbBaOtk0Z2f89wdcxQGpqPgEUtwXGg8P3
         mZOsBl44rLTo2qmOJO4j4g+5f5ThX6A7zBJ9LI9QxjAh4Hwxqck0CzWaYOqd3qqzPe/n
         Z6HxldZaQuNdpSJhoH0LqoGbQ2C5cEvmPufaXd/Qtx2DwJORjFNlJaj/rFnVHsemK37B
         79NK5YsAJJoMfxUAuCMgWH9kmtYmcoVzccPkb/ZrKbiKwAI1U7QOoALUnc9fkp5FBcd1
         yRegcU1xsOWbA41LYGNzIcrZ0q6iszsy+F7253T/K97SRZeV8OJ3Sm5e45ZWxksewRwu
         J9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8dFQrDagHAvPHfySdjImTPILlQLOjQlQyL3J8ZnSfx4=;
        b=qDXgYceiqWvNeoGKaEdeK2QOyX2XAL7Xr6ZjU2+quRPoXBOCahH4LxEpPiHZpCTA5Q
         a65/t9vr4rJQ8DDoHJhK0auBaT9gJxC5XbF2e62rX+3ve0x0SQFCPyWtGpfgA8Rtt2E/
         RWRSgg+vkRQtJxIEkyJHSxZaTlRj3/RuGACYy9WB3HPM2UkbhTcbzvwkSTa2y9KdGe0z
         0KF3FTuC191aV42biVT0Qaaodte+wm9VKoG5ritMMaSTWGo7IausTlsenbXoDrgyXQzU
         Ll13qCmbKPCdUEK0DGFzWCZokZnpgzmQW3F0/tLC75JXv+IqVvWfMHbZS5Uczy2+BiNA
         Uodw==
X-Gm-Message-State: AOAM530UxYiw2KETKS4FnYSHTJuGda3cc+ogizHDdlxUTscgXr4v6akZ
        S5mt4lQz+l57haevEy5xZg6/Fiwq7tE=
X-Google-Smtp-Source: ABdhPJyvMhtTz3P/5281FkAIUFh/LBsKef+ioCvc7FgIk2NGVNwDCizHiS34lEH8bqwrtreNjZPtpw==
X-Received: by 2002:a5d:4d8e:: with SMTP id b14mr21325368wru.422.1629842089931;
        Tue, 24 Aug 2021 14:54:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm1345866wro.51.2021.08.24.14.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:54:49 -0700 (PDT)
Message-Id: <eeba97ad492307302637faf33f6bf6ae8965faa3.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:54:38 +0000
Subject: [PATCH 06/13] add: skip paths that are outside sparse-checkout cone
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

When 'git add' adds a tracked file that is outside of the
sparse-checkout cone, it checks the SKIP_WORKTREE bit to see if the file
exists outside of the sparse-checkout cone. This is usually correct,
except in the case of a merge conflict outside of the cone.

Modify add_pathspec_matched_against_index() to be more careful about
pathes by checking the sparse-checkout patterns in addition to the
SKIP_WORKTREE bit. This causes 'git add' to no longer allow files
outside of the cone that removed the SKIP_WORKTREE bit due to a merge
conflict.

With only this change, users will only be able to add the file after
adding the file to the sparse-checkout cone. A later change will allow
users to force adding even though the file is outside of the
sparse-checkout cone.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 pathspec.c                               | 3 ++-
 t/t1092-sparse-checkout-compatibility.sh | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 44306fdaca2..0e6e60fdc5a 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -39,7 +39,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 		return;
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
-		if (sw_action == PS_IGNORE_SKIP_WORKTREE && ce_skip_worktree(ce))
+		if (sw_action == PS_IGNORE_SKIP_WORKTREE &&
+		    (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate)))
 			continue;
 		ce_path_match(istate, ce, pathspec, seen);
 	}
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 962bece03e1..c2a4eec548d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -529,7 +529,7 @@ test_expect_failure 'merge with conflict outside cone' '
 	# NEEDSWORK: Even though the merge conflict removed the
 	# SKIP_WORKTREE bit from the index entry for folder1/a, we should
 	# warn that this is a problematic add.
-	test_all_match git add folder1/a &&
+	test_sparse_match test_must_fail git add folder1/a &&
 	test_all_match git status --porcelain=v2 &&
 
 	# 3. Rename the file to another sparse filename and
@@ -538,7 +538,7 @@ test_expect_failure 'merge with conflict outside cone' '
 	# NEEDSWORK: This mode now fails, because folder2/z is
 	# outside of the sparse-checkout cone and does not match an
 	# existing index entry with the SKIP_WORKTREE bit cleared.
-	test_all_match git add folder2 &&
+	test_sparse_match test_must_fail git add folder2 &&
 	test_all_match git status --porcelain=v2 &&
 
 	test_all_match git merge --continue &&
@@ -566,7 +566,7 @@ test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
 		# NEEDSWORK: Even though the merge conflict removed the
 		# SKIP_WORKTREE bit from the index entry for folder1/a, we should
 		# warn that this is a problematic add.
-		test_all_match git add folder1/a &&
+		test_sparse_match test_must_fail git add folder1/a &&
 		test_all_match git status --porcelain=v2 &&
 
 		# 3. Rename the file to another sparse filename and
@@ -575,7 +575,7 @@ test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
 		# outside of the sparse-checkout cone and does not match an
 		# existing index entry with the SKIP_WORKTREE bit cleared.
 		run_on_all mv folder2/a folder2/z &&
-		test_all_match git add folder2 &&
+		test_sparse_match test_must_fail git add folder2 &&
 		test_all_match git status --porcelain=v2 &&
 
 		test_all_match git $OPERATION --continue &&
-- 
gitgitgadget

