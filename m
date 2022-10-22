Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FBCC04A95
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 19:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJVTER (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 15:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJVTEP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 15:04:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C668B16250E
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 12:04:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l14so2656773wrw.2
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pLSLxx+SFr3nAop7mHE63Ou2wbPGNtqlEccpkuJSRoQ=;
        b=C0dF0TItpoF5bB7X6QjyvvtGjw8ebQn8WM6lFCfpHULoK3o0TbO5yE6NUSfAqUf5R+
         QcG2k/kMWyg/wSyUZCq+5nhbrDlk/lGsLsQfI/MrOGLW2ELAJQ6KOjOlb+nhMv/Nys45
         v33//1DbCxnXFkWOpS38qcGD12PEtI/pta6iY/ZE1BSvS+8VgRkk+abnHMsjRlsSnI1s
         NygRuOk4HFaUSdXxaqM9yhBHpX65K9gBFkWWys/WxFtks9XWNi0MV6VW9bf5AQWK/PgV
         5fnCHVNNq0FZ/jIop5adDmOrZ6deyAm5D1u7QEraKXf6xF9HFstTSjakz/hkP+/NPLFO
         wP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLSLxx+SFr3nAop7mHE63Ou2wbPGNtqlEccpkuJSRoQ=;
        b=B5Q13on7O+CTWlI5yvLkYZn/gp6PJLjQ/DJ/8/V7xMdBacj0hRbkqNace2Ub2L8MNt
         wZwyKZkI9lxthvo9YionBkmQ4GDMvzj5ajiuaqLr4Bw/FWymdimkWfI6x2M8dfeb7i4Q
         b3LqKRYugKBCD6fZ3qGZaICtp+Wl078wJfRNp9op1Y7cy8CkSqAN7O/avDtyENOU5n5V
         /JOVRKkqPuyKlcepZVdFJSWQLJNRekAqiKeh6lSTgwaYjWGsNCk89/NejU+GN6NzpIDx
         Y7Ch/3TOISR/AYRymYIm/6aHPp4FK2bXK69UknkJBzafbbWaNgP0Y1NikbbIEcopeH3L
         tjOA==
X-Gm-Message-State: ACrzQf3+DThSA715zpZgH/hKQ4KNDYZbDIUUvEhHD7vTx3ynKs/93lH5
        uefB09SGs6yx8BIATPcACiQDeZNizng=
X-Google-Smtp-Source: AMsMyM46J4ZgzUQX+2qgzOKQeC+4YfHWU3xrvkyGHjuStaZ9Q+DuD1u07DekW0Ki3dYtH3lTkS95IA==
X-Received: by 2002:a5d:4cc2:0:b0:22e:372d:9c9 with SMTP id c2-20020a5d4cc2000000b0022e372d09c9mr16197137wrt.576.1666465451909;
        Sat, 22 Oct 2022 12:04:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4-20020adf8b04000000b00231893bfdc7sm23906381wra.2.2022.10.22.12.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 12:04:11 -0700 (PDT)
Message-Id: <pull.1391.git.1666465450590.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Oct 2022 19:04:10 +0000
Subject: [PATCH] merge-ort: fix bug with dir rename vs change dir to symlink
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Stefano Rivera <stefano@rivera.za.net>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When changing a directory to a symlink on one side of history, and
renaming the parent of that directory to a different directory name
on the other side, e.g. with this kind of setup:

    Base commit: Has a file named dir/subdir/file
    Side1:       Rename dir/ -> renamed-dir/
    Side2:       delete dir/subdir/file, add dir/subdir as symlink

Then merge-ort was running into an assertion failure:

    git: merge-ort.c:2622: apply_directory_rename_modifications: Assertion `ci->dirmask == 0' failed

merge-recursive did not have as obvious an issue handling this case,
likely because we never fixed it to handle the case from commit
902c521a35 ("t6423: more involved directory rename test", 2020-10-15)
where we need to be careful about nested renames when a directory rename
occurs (dir/ -> renamed-dir/ implies dir/subdir/ ->
renamed-dir/subdir/).  However, merge-recursive does have multiple
problems with this testcase:

  * Incorrect stages for the file: merge-recursive omits the stage in
    the index corresponding to the base stage, making `git status`
    report "added by us" for renamed-dir/subdir/file instead of the
    expected "deleted by them".

  * Poor directory/file conflict handling: For the renamed-dir/subdir
    symlink, instead of reporting a file/directory conflict as
    expected, it reports "Error: Refusing to lose untracked file at
    renamed-dir/subdir".  This is a lie because there is no untracked
    file at that location.  It then does the normal suboptimal
    merge-recursive thing of having the symlink be tracked in the index
    at a location where it can't be written due to D/F conflicts
    (namely, renamed-dir/subdir), but writes it to the working tree at
    a different location as a new untracked file (namely,
    renamed-dir/subdir~B^0)

Technically, these problems don't prevent the user from resolving the
merge if they can figure out to ignore the confusion, but because both
pieces of output are quite confusing I don't want to modify the test
to claim the recursive also passes it even if it doesn't have the bug
that ort did.

So, fix the bug in ort by splitting the conflict_info for "dir/subdir"
into two, one for the directory part, one for the file (i.e. symlink)
part, since the symlink is being renamed by directory rename detection.
The directory part is needed for proper nesting, since there are still
conflict_info fields for files underneath it (though those are marked
as is_null, they are still present until the entries are processed,
and the entry processing wants every non-toplevel entry to have a
parent directory).

Reported-by: Stefano Rivera <stefano@rivera.za.net>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    merge-ort: fix bug with dir rename vs change dir to symlink
    
    This fixes the bug reported over here:
    https://lore.kernel.org/git/20220916124234.h57p67mwywzok23s@haydn.kardiogramm.net/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1391%2Fnewren%2Fdir-rename-vs-symlink-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1391/newren/dir-rename-vs-symlink-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1391

 merge-ort.c                         | 36 +++++++++++++++++--
 t/t6423-merge-rename-directories.sh | 56 +++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 99dcee2db8a..d846960e130 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2619,8 +2619,40 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 	}
 
 	assert(ci->filemask == 2 || ci->filemask == 4);
-	assert(ci->dirmask == 0);
-	strmap_remove(&opt->priv->paths, old_path, 0);
+	assert(ci->dirmask == 0 || ci->dirmask == 1);
+	if (ci->dirmask == 0)
+		strmap_remove(&opt->priv->paths, old_path, 0);
+	else {
+		/*
+		 * This file exists on one side, but we still had a directory
+		 * at the old location that we can't remove until after
+		 * processing all paths below it.  So, make a copy of ci in
+		 * new_ci and only put the file information into it.
+		 */
+		new_ci = mem_pool_calloc(&opt->priv->pool, 1, sizeof(*new_ci));
+		memcpy(new_ci, ci, sizeof(*ci));
+		assert(!new_ci->match_mask);
+		new_ci->dirmask = 0;
+		new_ci->stages[1].mode = 0;
+		oidcpy(&new_ci->stages[1].oid, null_oid());
+
+		/*
+		 * Now that we have the file information in new_ci, make sure
+		 * ci only has the directory information.
+		 */
+		ci->filemask = 0;
+		ci->merged.clean = 1;
+		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
+			if (ci->dirmask & (1 << i))
+				continue;
+			/* zero out any entries related to files */
+			ci->stages[i].mode = 0;
+			oidcpy(&ci->stages[i].oid, null_oid());
+		}
+
+		// Now we want to focus on new_ci, so reassign ci to it
+		ci = new_ci;
+	}
 
 	branch_with_new_path   = (ci->filemask == 2) ? opt->branch1 : opt->branch2;
 	branch_with_dir_rename = (ci->filemask == 2) ? opt->branch2 : opt->branch1;
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index a4941878fe2..944de75b805 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5304,6 +5304,62 @@ test_expect_merge_algorithm failure success '12l (A into B): Rename into each ot
 	)
 '
 
+# Testcase 12m, Directory rename, plus change of parent dir to symlink
+#   Commit O:  dir/subdir/file
+#   Commit A:  renamed-dir/subdir/file
+#   Commit B:  dir/subdir
+#   In words:
+#     A: dir/subdir/ -> renamed-dir/subdir
+#     B: delete dir/subdir/file, add dir/subdir as symlink
+#
+#   Expected: CONFLICT (rename/delete): renamed-dir/subdir/file,
+#             CONFLICT (file location): renamed-dir/subdir vs. dir/subdir
+#             CONFLICT (directory/file): renamed-dir/subdir symlink has
+#                                        renamed-dir/subdir in the way
+
+test_setup_12m () {
+	git init 12m &&
+	(
+		cd 12m &&
+
+		mkdir -p dir/subdir &&
+		echo 1 >dir/subdir/file &&
+		git add . &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git switch A &&
+		git mv dir/ renamed-dir/ &&
+		git add . &&
+		git commit -m "A" &&
+
+		git switch B &&
+		git rm dir/subdir/file &&
+		mkdir dir &&
+		ln -s /dev/null dir/subdir &&
+		git add . &&
+		git commit -m "B"
+	)
+}
+
+test_expect_merge_algorithm failure success '12m: Change parent of renamed-dir to symlink on other side' '
+	test_setup_12m &&
+	(
+		cd 12m &&
+
+		git checkout -q A^0 &&
+
+		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 &&
+
+		test_stdout_line_count = 3 git ls-files -s &&
+		test_stdout_line_count = 2 ls -1 renamed-dir &&
+		test_path_is_missing dir
+	)
+'
+
 ###########################################################################
 # SECTION 13: Checking informational and conflict messages
 #

base-commit: 79f2338b3746d23454308648b2491e5beba4beff
-- 
gitgitgadget
