Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7891FC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhLIFMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhLIFMT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:12:19 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3F7C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:08:46 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t18so7615888wrg.11
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=seIEJ6zhu/KAJ/GrHHnuR0swJdCwvN6+EL9Kq8qhtDQ=;
        b=nqZt5gL389D9Yocmp1OAX9b5pyHfuPDctrj/zvv27fNvzKeg7crwpFbMoPJkebVomI
         nkP1HL7w6e68NAU3fjzFxvuv2Xm37N9NMJhzTK5GrXV0RIKOXpi/G7FrI3FB3D1A8fk0
         IiLvWiWPKXuKfKCUzfTQHTeKtcZGRyF4rVR1gx5WGvfw+psjneA02SH7mUrZUDryYp8b
         F2RutGK2f1YToXLfO8E7C2McM0nr5LAUgXx66YVz6+5P8vOQ+dzeMB4C76J5LX0IINUc
         kZHI1Xn84gSoYLvC6R8NXVnosX1Pkc86dMTa6vjpHfNBOYKHCM1salmm342nrFz1+nDN
         oADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=seIEJ6zhu/KAJ/GrHHnuR0swJdCwvN6+EL9Kq8qhtDQ=;
        b=BS77p5uUq0zcN10SQvBiKRd/6d5uiu63gwEa4ecwPhByl6r3tHjARqOfFU6nYhxaLY
         TVOGQlQ0jB+GHUJyBO/eDFwHociqUZG7tsAgiS2985vyBj+xnBcVfaHRwsFlATDXDzly
         XWhWGgZ/ApHrMamDLkYY+TTerEZ+S8U7Q7bC+v0ztP9bnHrPLO/T2QIuYCqudvruiA1R
         HW0O5486w9JVoAvyWgOrGBdrnNpIDNFTa/ua2JRGTMqRm3FKo/MmU53AJwJwcKzMk1XX
         oeLvXhtmyYmwVpOvMj7kewOMgdMBuICcKFNHll4HgPCvj+n1lORttDjLGGuM4ol1sYAs
         O/iA==
X-Gm-Message-State: AOAM533qe6tAE0tneRBU4wNj6eVbJgtsG1DpdyySNcCgioW/tZ9W/yzl
        amipn5dbigz19AJkWtOGcaSsLOUE9Yk=
X-Google-Smtp-Source: ABdhPJw2+JfxOgmSK7B37s9mhIZZckQCh8es0C8WfKtial7t7yzuYL+HgQ6HHvWxv95PW5h6FyD1Xg==
X-Received: by 2002:a5d:6dab:: with SMTP id u11mr3778190wrs.46.1639026524951;
        Wed, 08 Dec 2021 21:08:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7sm4502598wru.51.2021.12.08.21.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:08:44 -0800 (PST)
Message-Id: <1a66b1a238688c091124434865580d00317bf491.1639026515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
References: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
        <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 05:08:33 +0000
Subject: [PATCH v6 09/11] dir: avoid incidentally removing the original_cwd in
 remove_path()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
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

Acked-by: Derrick Stolee <stolee@gmail.com>
Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
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
index be9ef903bd4..ce2efb9d30a 100755
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

