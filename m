Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE368C433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 08:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352552AbhKYIpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 03:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349940AbhKYInU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 03:43:20 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B45C0613F2
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r8so9865925wra.7
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RGvrnPwWwB0Ncvh15JyDu5EBYtb49RovOM1fmup/hwY=;
        b=Jxw8Exx3ApeDH4epOZn+d+bmfMngPgjGxcQD/8Loffg23xIveUzln845Ekd0vA/AWU
         uej0F8hEpP1uJTURpTPVFrpBIXL2tQutqV9rF5ZfcnIswyhKYvr+4hxmeTszb0gGA8zc
         os7ljszn21h+CWcT6V66dl5fxAcTPdVqx/FBoK3RJWSIUKhjEVEXc5KrfYtRHnVnd/wp
         BCKegVjRdN/sxr52fkq0JyPl/2PszRVknE6Hivd0fcV9WaWKJyY0TY/eAHb087vKpFlN
         9apWK3gCq92fx9bRWK+Q0X32x69v9+wVGjk1xcdujhx+j91RXLSubz9GDNQmYdYG14Kn
         I6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RGvrnPwWwB0Ncvh15JyDu5EBYtb49RovOM1fmup/hwY=;
        b=TU7nvYFTEKS3YFASAfyyqknvZRm5HCphlGjEA59WAjzyb+QJovQ1XG2gUjVQgp7Epq
         gBJo38iORMjnY76glnJ97kAkZf4LQr6dQ81mvbdEGZ6sksfJ/NWkEAuXH94Xz5A1aTNe
         XeOCrmKxDR9MZKzlUFqqiU/yu8KqKjzxle44aUEX0tkSWRQakCwaXkVVOGd46eGoR+h1
         CINaSjpoV+zsbnvCyitubWoiVm78hxjfQyMcxVKAaqo38J26rCZQ9AJkNN5L/LqNs8pJ
         1lQcdTJz823fL3dRKzJ/AgEkEEzI7Qu/IK9u3aJl16+vkNfIqj5qSvNPmpK/5x8Oz2s+
         K+Cw==
X-Gm-Message-State: AOAM532OEy5vnMKHxHiYIwRrvPbuVD9r3mOKeIOeHTRpeeNFwCaTqtTD
        HfiFR3yXA5iDO3eE7++3uzXqkC4JCps=
X-Google-Smtp-Source: ABdhPJwFR8vdLZWO0b1liNK8K63bXsWXOt6pVCfAmfnrNEorYFfxEjjlMDWn5rzDr0nErL7HzNd+fA==
X-Received: by 2002:adf:8b1e:: with SMTP id n30mr4580354wra.75.1637829566835;
        Thu, 25 Nov 2021 00:39:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4sm2121232wrv.94.2021.11.25.00.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 00:39:26 -0800 (PST)
Message-Id: <1815f18592b240145000b04d19645f31ea72823e.1637829556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
        <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 08:39:15 +0000
Subject: [PATCH v2 8/9] dir: avoid incidentally removing the original_cwd in
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
 dir.c                | 3 +++
 dir.h                | 6 +++++-
 t/t2501-cwd-empty.sh | 4 ++--
 3 files changed, 10 insertions(+), 3 deletions(-)

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
index ff4e7cd89fa..4362e7b15e5 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -191,7 +191,7 @@ test_expect_success 'revert fails if cwd needs to be removed' '
 	test_path_is_dir dirORfile
 '
 
-test_expect_failure 'rm does not remove cwd incidentally' '
+test_expect_success 'rm does not remove cwd incidentally' '
 	test_when_finished "git reset --hard" &&
 	git checkout foo/bar/baz &&
 
@@ -205,7 +205,7 @@ test_expect_failure 'rm does not remove cwd incidentally' '
 	test_path_is_dir foo
 '
 
-test_expect_failure 'apply does not remove cwd incidentally' '
+test_expect_success 'apply does not remove cwd incidentally' '
 	test_when_finished "git reset --hard" &&
 	git checkout foo/bar/baz &&
 
-- 
gitgitgadget

