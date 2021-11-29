Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D913BC433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbhK2XNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbhK2XMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:12:54 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68C4C041F5B
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:23 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso18021536wmr.4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dOK9d4q4VPBp3MD/lk9mA3LQNhm2bUeQvP1B87NE0Wk=;
        b=IH+H0ojeD6GMyTTX+Q29DRHtoQWB8qc7H68dlegxtnxGoFgNpWCSkD6K0PV7Hz5frh
         cGkHpaMKj21n/T5acjEObZjN3IiKMYlflutq58c7MsVRm/O0yEFqfedRaCf1d+eJnFcR
         WSqMG5ALHKhmXYAoDT/0FMmNVoS6kVhHAuwvNLIOpc+caktK80CSeS74OW7toc1/BEQX
         BpTTqAW4ds889jxjUm7STb1cR0Bnim6UUr0fcYLGgVm05TwdgDgxArmeTZnVunZCIgQl
         LbVL1pwJZcSNe0lh3zk/RCQSI2UXk8DNF/0Eq79AA5wjDnfuGUj6Vs443ZjhQJwb2Hyt
         Skjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dOK9d4q4VPBp3MD/lk9mA3LQNhm2bUeQvP1B87NE0Wk=;
        b=FzmbubhH9+01R7HwnQBBgDwPVmh7Wgi74p+hpOgUHmblbWiJecr8xAU1i84KHnPhJy
         pHnyHLgOlYP1IRp2K81iNIuOHeSDwB8pBFTN9q7Qwl3WT+kP6dk0p7y8iBkYOn0tRjig
         6UQORZuUPCmC6Tg9100qny9gtrBvx+oaITCaJpBJPwg0mPOSJY63nn6UAs+jWK9gNMbj
         pvaMZzzM3UUHOacKbD/eTN32KZepsSnGE5fxRvcQPEK9ZI0SloXZeWr7HrAEDAwIspuP
         nt2hzFqG+zTdNH/j4HUoFrq+jMvxptujSkCldAEpuy6befKl32QZwEdRRhxjn7PwsrNQ
         Cf5g==
X-Gm-Message-State: AOAM530FjRegw/C7F7gRhCfZHAAomPAUaIGK4Rv1Zaw/PxXQhYxJ9zRD
        IvNNbYF1lLCPtvX6/P74eqU0FmLMxT0=
X-Google-Smtp-Source: ABdhPJxbso7G2nOY9Ke28SVp5gmckDG3q9NtlyRWn3oB4d5lpwbZoZ+ZgetRugheaeAQDJ3ewyHjmQ==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr872721wmh.104.1638225442311;
        Mon, 29 Nov 2021 14:37:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 21sm530775wmj.18.2021.11.29.14.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:37:22 -0800 (PST)
Message-Id: <834031be9e04f590d219d33250699200db3c85c4.1638225434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
References: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
        <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 22:37:12 +0000
Subject: [PATCH v4 09/11] dir: avoid incidentally removing the original_cwd in
 remove_path()
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

Modern git often tries to avoid leaving empty directories around when
removing files.  Originally, it did not bother.  This behavior started
with commit 80e21a9ed809 (merge-recursive::removeFile: remove empty
directories, 2005-11-19), stating the reason simply as:

    When the last file in a directory is removed as the result of a
    merge, try to rmdir the now-empty directory.

This was reimplemented in C and renamed to remove_path() in commit
e1b3a2cad7 ("Build-in merge-recursive", 2008-02-07), but was still
internal to merge-recursive.

This trend towards removing leading empty directories continued with
commit d9b814cc97f1 (Add builtin "git rm" command, 2006-05-19), which
stated the reasoning as:

    The other question is what to do with leading directories. The old
    "git rm" script didn't do anything, which is somewhat inconsistent.
    This one will actually clean up directories that have become empty
    as a result of removing the last file, but maybe we want to have a
    flag to decide the behaviour?

remove_path() in dir.c was added in 4a92d1bfb784 (Add remove_path: a
function to remove as much as possible of a path, 2008-09-27), because
it was noted that we had two separate implementations of the same idea
AND both were buggy.  It described the purpose of the function as

    a function to remove as much as possible of a path

Why remove as much as possible?  Well, at the time we probably would
have said something like:

  * removing leading directories makes things feel tidy
  * removing leading directories doesn't hurt anything so long as they
    had no files in them.

But I don't believe those reasons hold when the empty directory happens
to be the current working directory we inherited from our parent
process.  Leaving the parent process in a deleted directory can cause
user confusion when subsequent processes fail: any git command, for
example, will immediately fail with

    fatal: Unable to read current working directory: No such file or directory

Other commands may similarly get confused.  Modify remove_path() so that
the empty leading directories it also deletes does not include the
current working directory we inherited from our parent process.  I have
looked through every caller of remove_path() in the current codebase to
make sure that all should take this change.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                |  3 +++
 dir.h                |  6 +++++-
 t/t2501-cwd-empty.sh | 12 ++++--------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index 94489298f4c..97d6b71c872 100644
--- a/dir.c
+++ b/dir.c
@@ -3327,6 +3327,9 @@ int remove_path(const char *name)
 		slash = dirs + (slash - name);
 		do {
 			*slash = '\0';
+			if (startup_info->original_cwd &&
+			    !strcmp(startup_info->original_cwd, dirs))
+				break;
 		} while (rmdir(dirs) == 0 && (slash = strrchr(dirs, '/')));
 		free(dirs);
 	}
diff --git a/dir.h b/dir.h
index 83f46c0fb4c..d6a5d03bec2 100644
--- a/dir.h
+++ b/dir.h
@@ -504,7 +504,11 @@ int get_sparse_checkout_patterns(struct pattern_list *pl);
  */
 int remove_dir_recursively(struct strbuf *path, int flag);
 
-/* tries to remove the path with empty directories along it, ignores ENOENT */
+/*
+ * Tries to remove the path, along with leading empty directories so long as
+ * those empty directories are not startup_info->original_cwd.  Ignores
+ * ENOENT.
+ */
 int remove_path(const char *path);
 
 int fspathcmp(const char *a, const char *b);
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index e2586a63eca..30b8ffaa11b 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -182,12 +182,12 @@ test_expect_success 'revert fails if cwd needs to be removed' '
 '
 
 test_expect_success 'rm does not clean cwd incidentally' '
-	test_incidental_dir_removal failure git rm bar/baz.t
+	test_incidental_dir_removal success git rm bar/baz.t
 '
 
 test_expect_success 'apply does not remove cwd incidentally' '
 	git diff HEAD HEAD~1 >patch &&
-	test_incidental_dir_removal failure git apply ../patch
+	test_incidental_dir_removal success git apply ../patch
 '
 
 test_incidental_untracked_dir_removal () {
@@ -271,12 +271,8 @@ test_expect_success '`rm -rf dir` even with only tracked files will remove somet
 	) &&
 
 	test_path_is_missing a/b/c/tracked &&
-	## We would prefer if a/b was still present, though empty, since it
-	## was the current working directory
-	#test_path_is_dir a/b
-	## But the current behavior is that it not only deletes the directory
-	## a/b as requested, but also goes and deletes a
-	test_path_is_missing a
+	test_path_is_missing a/b/c &&
+	test_path_is_dir a/b
 '
 
 test_expect_success 'git version continues working from a deleted dir' '
-- 
gitgitgadget

