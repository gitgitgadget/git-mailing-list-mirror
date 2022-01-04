Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0062C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 23:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbiADXFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 18:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiADXFC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 18:05:02 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0314C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 15:05:01 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so2277107wmb.0
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 15:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=h9TdNhufnhArtLALOCZcSjANJ8CFKvKDoriuOm5Tm40=;
        b=IB87SJEjAx8YhCmRUncr06YhRoFY0liK56Tv0S/+PEPMDEPgyJy5ilp7vbNjbuJzU4
         QiWBfZq3nb803ulASBYJeRI4Wd3GxtoO7M/rATIE2pODIEUCpzWBhayMi1OoAmssg+OA
         AC2jc4q9JxX8NgNMlfmIvPZp2j7/6gWl/d2uzfeGpZZtn2lrC2Y68KLgP8sACxQmKoTh
         cagWqdwOMiMhHrqLsECIANh/4IGLco3s7hPFtPZZ+WeCeNvzgSENTvmqAqa7tVKiRbPY
         Y5Frr61k/s3+ZcPLSuRN5WtX+QWkeMLeKJtPKaCsJ72kmCZgFHd5Pbk4Un2bhWkuI9aM
         hzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h9TdNhufnhArtLALOCZcSjANJ8CFKvKDoriuOm5Tm40=;
        b=Rmj1DS1YPfqeSgKdELXZyHcShXyOkLLrxXqiUQYhW9D7bCr6E3E3xh9HTEwCzUDVxn
         +rzJcCUsNfR/YhU48Wnr3K+qLMob4d/5nuRS8tSm6293gAdFykhQe7nKTSqOZSLjipto
         RYLLu7LFly0GnAxnDblcj55GUSdSzCw5Z+xkJVq6qLnCP0vIYnZJ4J57/cA/UCtsNhNw
         PsxCPmea9ven/hxgWeprHhx7PC1n8/b48FpckofkJsOJ9nRJ5YQp47No+GF3x8NCRKgQ
         g0dV41LHFvZ789fiRsZOCf97VpXc3rJ+uagtVR76GhMViulpsQ+Qskacq2x51GUGGbEy
         Kb+g==
X-Gm-Message-State: AOAM531fYqNlPl0NdLeSAIegBDIiTsSnekYRYjHP2J8XXTTyhrZnqNqw
        rfOCvdKh20tkt2vcFqhQLc95V0WfeHA=
X-Google-Smtp-Source: ABdhPJzJ0wYPWLTKmIMZwba0s33QlNK71D0t8355hIg11Q2qrRbkrNGg0D2m5PqCFnIRJEOueK5Urw==
X-Received: by 2002:a05:600c:a0a:: with SMTP id z10mr452165wmp.126.1641337500257;
        Tue, 04 Jan 2022 15:05:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm886976wmc.14.2022.01.04.15.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 15:04:59 -0800 (PST)
Message-Id: <pull.1180.git.git.1641337498996.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 23:04:58 +0000
Subject: [PATCH] stash: do not return before restoring untracked files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commit bee8691f19 ("stash: restore untracked files AFTER restoring
tracked files", 2021-09-10), we correctly identified that we should
restore changes to tracked files before attempting to restore untracked
files, and accordingly moved the code for restoring untracked files a
few lines down in do_apply_stash().  Unfortunately, the intervening
lines had some early return statements meaning that we suddenly stopped
restoring untracked files in some cases.

Even before the previous commit, there was another possible issue with
the current code -- a post-stash-apply 'git status' that was intended
to be run after restoring the stash was skipped when we hit a conflict
(or other error condition), which seems slightly inconsistent.

Fix both issues by saving the return status, and letting other
functionality run before returning.

Reported-by: AJ Henderson
Test-case-by: Randall S. Becker <randall.becker@nexbridge.ca>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    stash: do not return before restoring untracked files
    
    This fixes a regression in v2.34.1 relative to v2.33.0.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1180%2Fnewren%2Ffix-stash-restore-untracked-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1180/newren/fix-stash-restore-untracked-v1
Pull-Request: https://github.com/git/git/pull/1180

 builtin/stash.c  |  9 +++++----
 t/t3903-stash.sh | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 18c812bbe03..397210168da 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -561,18 +561,19 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		if (index)
 			fprintf_ln(stderr, _("Index was not unstashed."));
 
-		return ret;
+		goto restore_untracked;
 	}
 
 	if (has_index) {
 		if (reset_tree(&index_tree, 0, 0))
-			return -1;
+			ret = -1;
 	} else {
 		unstage_changes_unless_new(&c_tree);
 	}
 
+restore_untracked:
 	if (info->has_u && restore_untracked(&info->u_tree))
-		return error(_("could not restore untracked files from stash"));
+		ret = error(_("could not restore untracked files from stash"));
 
 	if (!quiet) {
 		struct child_process cp = CHILD_PROCESS_INIT;
@@ -592,7 +593,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		run_command(&cp);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int apply_stash(int argc, const char **argv, const char *prefix)
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 2c66cfbc3b7..2a7d8e511db 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1376,4 +1376,28 @@ test_expect_success 'git stash can pop directory -> file saved changes' '
 	)
 '
 
+test_expect_success 'restore untracked files even when we hit conflicts' '
+	git init restore_untracked_after_conflict &&
+	(
+		cd restore_untracked_after_conflict &&
+
+		echo hi >a &&
+		echo there >b &&
+		git add . &&
+		git commit -m first &&
+		echo hello >a &&
+		echo something >c &&
+
+		git stash push --include-untracked &&
+
+		echo conflict >a &&
+		git add a &&
+		git commit -m second &&
+
+		test_must_fail git stash pop &&
+
+		test_path_is_file c
+	)
+'
+
 test_done

base-commit: 2ae0a9cb8298185a94e5998086f380a355dd8907
-- 
gitgitgadget
