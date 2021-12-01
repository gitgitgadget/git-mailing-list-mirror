Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92968C433FE
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 06:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346994AbhLAGoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 01:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347000AbhLAGo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 01:44:26 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA66EC061746
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:41:05 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o13so49667574wrs.12
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NVS9Dp5+YJg1nqvyFdPabzvn/3e2CRXuuPNq1nJlnK0=;
        b=gJxio3gs+u8GgtMZHzSF9XgRd8jHfJmdbPSNlzxGfWYv51X9aAGL6auD6ZmCIw61kM
         H7X5KwmT5uuQNCQyl42YzptH28uJZV+StWFITPdpo1nRfLWkrtKzMUvtIepICtDNZiwQ
         PIr5FFi34WRHYhI2XA/Da3PbD1AIVu9DzER1J9ANT+7D4DkQ/BJr3W74tBO+Cjv/doYv
         GsZShfEravasQgwxR+pDMm5UOCKG2GI+4asVdTYvSq3b2pgVkdsoaw1y/uwu38WGMbuM
         t3936OlNN0Q6aQz0A73StcAvFK8juXBnGPkl8Lv+Avc2P+5yTifpg6iqYBuMYhTvkN1O
         x9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NVS9Dp5+YJg1nqvyFdPabzvn/3e2CRXuuPNq1nJlnK0=;
        b=Z53scW9ne0Y8oR3LbYkLo2vjmUfa3e2CgucbCJgij7DswhTvf6EEAIWWcRAs2iXbqr
         s03CC460RCjdBGterqIjOTcDYmCvRPjgADkH369s1SmqTdG2E1uzk09577sGCYwtiRWd
         uDlecZSLAGVrotpskZ368hq78s6ph5mdeO7Hav+x6nqqZPHKlhJB4qxsiw4y8E9z98ct
         5emmhXdPF5wFvC6mO2jru4/YlBoJspr/G+9nghkBP/4MUBpL0EJhLlNY71ncw/r1jiuU
         8fIyZ+kYSQn74/KoVXpRUDylt6Wadttk44Yr+b46YL9l//Jx3ow1XTNuMthC52QbhV8P
         /8JA==
X-Gm-Message-State: AOAM533TheySFMi8wmhlkQpCfn3BFO1xspcMsEfNxxGK3QbTumNLd66e
        +HOZgzs35oZKg646MXDQnbFHPN5BlS8=
X-Google-Smtp-Source: ABdhPJwv8GaBEEDT+uqgWrZhKA1RwXgcXCNHRgymdE8aynXsdL4lvJhSdydcp9D5lm/uuEaBUEf3ww==
X-Received: by 2002:adf:dd87:: with SMTP id x7mr4586891wrl.158.1638340863591;
        Tue, 30 Nov 2021 22:41:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8sm18599955wrh.54.2021.11.30.22.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 22:41:03 -0800 (PST)
Message-Id: <23dfc3e399d4a66fc6ae7ad9cff477a95a125587.1638340854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
        <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 06:40:52 +0000
Subject: [PATCH v5 09/11] dir: avoid incidentally removing the original_cwd in
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

