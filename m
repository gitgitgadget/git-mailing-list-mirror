Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CC3C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhK2XNb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbhK2XMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:12:54 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99324C0800C0
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:19 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i12so15894701wmq.4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VjVsjqkKW2AcjZ/LGGCOVMDvESt8awlrR3m5upgoJcw=;
        b=MDvBjMNpnVRO+R/SdvR1HdTo9l2x6N1ZPrmPeSiD3tzbMM/C5lNw/HPLO+mImCavFN
         RKaaN/nky3fSYaQCWKDx3iL1Az3foRvtyWixFCvuU5GeVocQ5i1KKedooomrdivsQc6f
         w+mCUNTT/H330FFa4YX4al0RS0gL0zQFTCTD9JoMl9VLQIVdWZleNBNyLhS7vOv5nWzn
         7H8utT8Q0riY7gStRODRSEX977XaKq5k994irvjLsucKyba2/XUSgIaC7SCSFvlHtViA
         YQaQxbrUzPC2swid6bEEYQgLj6QwYRINg8l+r5KF2JD1BjPvwBP5vzOXwi33ClKi+3YC
         0dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VjVsjqkKW2AcjZ/LGGCOVMDvESt8awlrR3m5upgoJcw=;
        b=VkXroBFp+mbR4PrRi+90Ph8Z8z8AaOCrh3SA9DQKHvwO6owHr6iAbT2HnwOtmUEBHV
         eMX6VJj5wL3vUXhR4vKwu4cL+cEj/eoLEx/tp8AUSA5dxTPS2qWgB+WV1r0AOxVdx5NV
         1KQfPXPO8NhvOG4863DhMi+gl+XuQdVW8iITqB6exCWduViq4AJljOOGJjzv6CtASLH6
         x0Pqiq64o3vQgO9hT9hLDeY2uJSRluoq+841Mz/PibRBmtyp3TGhjrN2+v+gncUgoF+n
         RU6R/ycIZ8UiDCLafGrKhWrTfhbtRyd8QOvCGc65Eyx1zzEFbNOHVsuiPiTS6WDDwZ5u
         x5jQ==
X-Gm-Message-State: AOAM532ZvyFQA33CYQpOXVFXMoCsMfZRm1/5SC/zGnATROTdVnQoy0VO
        yMihDfGOjV0f5a6C+uOQZ65da859wsc=
X-Google-Smtp-Source: ABdhPJwh75w7y1SLahWnI+f2hXmUL8be27Z+jNeMWeUj101RMoDEcnVBAS928oKE2EK+8tZ/xw8HqQ==
X-Received: by 2002:a1c:7e04:: with SMTP id z4mr859831wmc.134.1638225438009;
        Mon, 29 Nov 2021 14:37:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm15018827wrt.36.2021.11.29.14.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:37:17 -0800 (PST)
Message-Id: <41a82eff41e0500a6fca9672f8acec1794cdaf55.1638225434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
References: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
        <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 22:37:06 +0000
Subject: [PATCH v4 03/11] unpack-trees: refuse to remove
 startup_info->original_cwd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In the past, when a directory needs to be removed to make room for a
file, we have always errored out when that directory contains any
untracked (but not ignored) files.  Add an extra condition on that: also
error out if the directory is the current working directory we inherited
from our parent process.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2501-cwd-empty.sh | 20 +++++++-------------
 unpack-trees.c       | 17 +++++++++++++----
 unpack-trees.h       |  1 +
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index fd83fe921d5..55081f5c980 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -113,7 +113,7 @@ test_expect_success 'checkout does not clean cwd incidentally' '
 '
 
 test_expect_success 'checkout fails if cwd needs to be removed' '
-	test_required_dir_removal failure git checkout fd_conflict
+	test_required_dir_removal success git checkout fd_conflict
 '
 
 test_expect_success 'reset --hard does not clean cwd incidentally' '
@@ -144,23 +144,17 @@ test_expect_success 'merge fails if cwd needs to be removed; recursive friendly'
 	(
 		cd dirORfile &&
 
-		# We would rather this failed, but we test for existing
-		# rather than desired behavior
-		git merge fd_conflict 2>../error
+		test_must_fail git merge fd_conflict 2>../error
 	) &&
 
-	## Here is the behavior we would rather have:
-	#test_path_is_dir dirORfile &&
-	#grep "Refusing to remove the current working directory" error
-	## But instead we test for existing behavior
-	test_path_is_file dirORfile &&
-	test_must_be_empty error
+	test_path_is_dir dirORfile &&
+	grep "Refusing to remove the current working directory" error
 '
 
 GIT_TEST_MERGE_ALGORITHM=ort
 
 test_expect_success 'merge fails if cwd needs to be removed' '
-	test_required_dir_removal failure git merge fd_conflict
+	test_required_dir_removal success git merge fd_conflict
 '
 
 test_expect_success 'cherry-pick does not clean cwd incidentally' '
@@ -168,7 +162,7 @@ test_expect_success 'cherry-pick does not clean cwd incidentally' '
 '
 
 test_expect_success 'cherry-pick fails if cwd needs to be removed' '
-	test_required_dir_removal failure git cherry-pick fd_conflict
+	test_required_dir_removal success git cherry-pick fd_conflict
 '
 
 test_expect_success 'rebase does not clean cwd incidentally' '
@@ -184,7 +178,7 @@ test_expect_success 'revert does not clean cwd incidentally' '
 '
 
 test_expect_success 'revert fails if cwd needs to be removed' '
-	test_required_dir_removal failure git revert undo_fd_conflict
+	test_required_dir_removal success git revert undo_fd_conflict
 '
 
 test_expect_success 'rm does not clean cwd incidentally' '
diff --git a/unpack-trees.c b/unpack-trees.c
index 89ca95ce90b..6bc16f3a714 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -36,6 +36,9 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
 	/* ERROR_NOT_UPTODATE_DIR */
 	"Updating '%s' would lose untracked files in it",
 
+	/* ERROR_CWD_IN_THE_WAY */
+	"Refusing to remove '%s' since it is the current working directory.",
+
 	/* ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN */
 	"Untracked working tree file '%s' would be overwritten by merge.",
 
@@ -131,6 +134,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	msgs[ERROR_NOT_UPTODATE_DIR] =
 		_("Updating the following directories would lose untracked files in them:\n%s");
 
+	msgs[ERROR_CWD_IN_THE_WAY] =
+		_("Refusing to remove the current working directory:\n%s");
+
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("The following untracked working tree files would be removed by checkout:\n%%s"
@@ -2146,10 +2152,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 		cnt++;
 	}
 
-	/*
-	 * Then we need to make sure that we do not lose a locally
-	 * present file that is not ignored.
-	 */
+	/* Do not lose a locally present file that is not ignored. */
 	pathbuf = xstrfmt("%.*s/", namelen, ce->name);
 
 	memset(&d, 0, sizeof(d));
@@ -2160,6 +2163,12 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	free(pathbuf);
 	if (i)
 		return add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
+
+	/* Do not lose startup_info->original_cwd */
+	if (startup_info->original_cwd &&
+	    !strcmp(startup_info->original_cwd, ce->name))
+		return add_rejected_path(o, ERROR_CWD_IN_THE_WAY, ce->name);
+
 	return cnt;
 }
 
diff --git a/unpack-trees.h b/unpack-trees.h
index 71ffb7eeb0c..efb9edfbb27 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -19,6 +19,7 @@ enum unpack_trees_error_types {
 	ERROR_WOULD_OVERWRITE = 0,
 	ERROR_NOT_UPTODATE_FILE,
 	ERROR_NOT_UPTODATE_DIR,
+	ERROR_CWD_IN_THE_WAY,
 	ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN,
 	ERROR_WOULD_LOSE_UNTRACKED_REMOVED,
 	ERROR_BIND_OVERLAP,
-- 
gitgitgadget

