Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DACC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613FE60F36
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhHBVHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 17:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhHBVHp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 17:07:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150D5C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 14:07:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z4so23001613wrv.11
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 14:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=CY7dZbCkTId0Nn1uoaiusprLnL9qcynN0l7hBBLxjUU=;
        b=L43q6k7pO/Ck5pUYPbGQqj4kFXWXFLW3b36oD6/dGs3r2SN0ouhlUouaeoD0UaRpiz
         Zu4UroyStQDWs9RuM/KbpYk4WFnch/Nt1ELalpjOLfO1Z7TPi2A8eaUDAb7vYP6yVP0Q
         CpUgVWUptMxXbkdIxMXZr+E39SWO+waKMQB/KTKTbgFuUZPJTPfDuW/zNh9yr9dI+2Dd
         CPBynyhgdnFYDFO+KbPl4zioQ8f1K8FNEWO3mM9F70YSj71ZHjHH/6ggA8ehEgkOfwn6
         XIXJSl8SqnIyBXqNCFReT1H9dy7wLgbAIamRoRMF3QUR2Nsz/7jhe5hB22EQrLRx3ct4
         iaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=CY7dZbCkTId0Nn1uoaiusprLnL9qcynN0l7hBBLxjUU=;
        b=bm2lnVM6vzT7g/PGO5YPjWbiqEg3/9uhOgJMwP68UYBV8tqj/2mWZTMQbL907J9Jhp
         xE8mukl0ZeCKr6a33GEkKQUcSYXNMsxrEglBTvNV8OyrJ7EUmSDPmu7Gj9PQsGtsX48Q
         7Xo2Bx4QdbdaVbY2BOwzQ03xoUa8YxMsHOUMcV+ri+/9jKhawbf16LlohXPF0HEf2uq7
         Ue6LNkThvLcR0zZOK9K7I7TxAezlt6teAJK9U5gJZl6r+2ZXSCdyg8T/rQX3E/unLP1a
         0J8cvn4OEAdkUF95xPFYVI2CqpfTgdB2B7BClyJY72mTm3wgydvRJMFnjt3G8xXvfo/U
         nfHw==
X-Gm-Message-State: AOAM530G0AWCla+EN6IRK01zdQr9m2D1s4CpbyiG9aisjZtIx3xhvbam
        ZX93TQZFLLkg+Fg44t9E0wfwp5t/YDY=
X-Google-Smtp-Source: ABdhPJzSQftX8WBzAajAsj4vI3+kJZoW8HAZn3c9G6PyQAkfItDHUT/mSahFtW9ZvXDFaGsHP1QDpA==
X-Received: by 2002:adf:ef4d:: with SMTP id c13mr19529078wrp.281.1627938452685;
        Mon, 02 Aug 2021 14:07:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6sm8610126wme.6.2021.08.02.14.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:07:32 -0700 (PDT)
Message-Id: <pull.1008.v2.git.1627938451247.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.1627586493659.gitgitgadget@gmail.com>
References: <pull.1008.git.1627586493659.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 21:07:30 +0000
Subject: [PATCH v2] mingw: align symlinks-related rmdir() behavior with Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Thomas=20B=C3=A9tous?= <tomspycell@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Thomas=20B=C3=A9tous?= <tomspycell@gmail.com>

When performing a rebase, rmdir() is called on the folder .git/logs. On
Unix rmdir() exits without deleting anything in case .git/logs is a
symbolic link but the equivalent functions on Windows (_rmdir, _wrmdir
and RemoveDirectoryW) do not behave the same and remove the folder if it
is symlinked even if it is not empty.

This creates issues when folders in .git/ are symlinks which is
especially the case when git-repo[1] is used: It replaces `.git/logs/`
with a symlink.

One such issue is that the _target_ of that symlink is removed e.g.
during a `git rebase`, where `delete_reflog("REBASE_HEAD")` will not
only try to remove `.git/logs/REBASE_HEAD` but then recursively try to
remove the parent directories until an error occurs, a technique that
obviously relies on `rmdir()` refusing to remove a symlink.

This was reported in https://github.com/git-for-windows/git/issues/2967.

This commit updates mingw_rmdir() so that its behavior is the same as
Linux rmdir() in case of symbolic links.

To verify that Git does not regress on the reported issue, this patch
adds a regression test for the `git rebase` symptom, even if the same
`rmdir()` behavior is quite likely to cause potential problems in other
Git commands as well.

[1]: git-repo is a python tool built on top of Git which helps manage
many Git repositories. It stores all the .git/ folders in a central
place by taking advantage of symbolic links.
More information: https://gerrit.googlesource.com/git-repo/

Signed-off-by: Thomas Bétous <tomspycell@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    mingw: support the git-repo tool better
    
    This addresses an issue, originally reported at
    https://github.com/git-for-windows/git/issues/2967, where the git-repo
    tool [https://gerrit.googlesource.com/git-repo/] replaces folders in
    .git/ with symlinks and mingw_rmdir() erroneously removes the symlink
    target directory's contents.
    
    Changes since v1:
    
     * Fixed the authorship
     * Augmented the commit message to elaborate on what the issues are,
       concretely, with the current behavior of mingw_rmdir()
     * Added an explanation to the commit message as to what happens during
       a git rebase that would trigger the rmdir() code path to misbehave
     * Adjusted the code comment to talk specifically about the
       remove_path() caller and why we want to align with Linux' rmdir()
       behavior

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1008%2Fdscho%2Ffix-rmdir-with-symlinks-on-windows-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1008/dscho/fix-rmdir-with-symlinks-on-windows-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1008

Range-diff vs v1:

 1:  c5a7fe0007f ! 1:  0a9cb1bcc14 mingw: align symlinks-related rmdir() behavior with Linux
     @@
       ## Metadata ##
     -Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
     +Author: Thomas Bétous <tomspycell@gmail.com>
      
       ## Commit message ##
          mingw: align symlinks-related rmdir() behavior with Linux
     @@ Commit message
          is symlinked even if it is not empty.
      
          This creates issues when folders in .git/ are symlinks which is
     -    especially the case when git-repo[1] is used.
     +    especially the case when git-repo[1] is used: It replaces `.git/logs/`
     +    with a symlink.
     +
     +    One such issue is that the _target_ of that symlink is removed e.g.
     +    during a `git rebase`, where `delete_reflog("REBASE_HEAD")` will not
     +    only try to remove `.git/logs/REBASE_HEAD` but then recursively try to
     +    remove the parent directories until an error occurs, a technique that
     +    obviously relies on `rmdir()` refusing to remove a symlink.
     +
     +    This was reported in https://github.com/git-for-windows/git/issues/2967.
      
          This commit updates mingw_rmdir() so that its behavior is the same as
          Linux rmdir() in case of symbolic links.
      
     -    This fixes https://github.com/git-for-windows/git/issues/2967
     +    To verify that Git does not regress on the reported issue, this patch
     +    adds a regression test for the `git rebase` symptom, even if the same
     +    `rmdir()` behavior is quite likely to cause potential problems in other
     +    Git commands as well.
      
          [1]: git-repo is a python tool built on top of Git which helps manage
          many Git repositories. It stores all the .git/ folders in a central
     @@ compat/mingw.c: int mingw_rmdir(const char *pathname)
      +	struct stat st;
      +
      +	/*
     -+	* Contrary to Linux rmdir(), Windows' _wrmdir() and _rmdir()
     -+	* will remove the directory at the path if it is a symbolic link
     -+	* which leads to issues when symlinks are used in the .git folder
     -+	* (in the context of git-repo for instance). So before calling _wrmdir()
     -+	* we first check if the path is a symbolic link. If it is, we exit
     -+	* and return the same error as Linux rmdir() in this case (ENOTDIR).
     -+	*/
     ++	 * Contrary to Linux' `rmdir()`, Windows' _wrmdir() and _rmdir()
     ++	 * (and `RemoveDirectoryW()`) will attempt to remove the target of a
     ++	 * symbolic link (if it points to a directory).
     ++	 *
     ++	 * This behavior breaks the assumption of e.g. `remove_path()` which
     ++	 * upon successful deletion of a file will attempt to remove its parent
     ++	 * directories recursively until failure (which usually happens when
     ++	 * the directory is not empty).
     ++	 *
     ++	 * Therefore, before calling `_wrmdir()`, we first check if the path is
     ++	 * a symbolic link. If it is, we exit and return the same error as
     ++	 * Linux' `rmdir()` would, i.e. `ENOTDIR`.
     ++	 */
      +	if (!mingw_lstat(pathname, &st) && S_ISLNK(st.st_mode)) {
      +		errno = ENOTDIR;
      +		return -1;


 compat/mingw.c    | 21 +++++++++++++++++++++
 t/t3400-rebase.sh | 10 ++++++++++
 t/test-lib.sh     |  6 ++++++
 3 files changed, 37 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index aa647b367b0..9e0cd1e097f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -341,6 +341,27 @@ int mingw_rmdir(const char *pathname)
 {
 	int ret, tries = 0;
 	wchar_t wpathname[MAX_PATH];
+	struct stat st;
+
+	/*
+	 * Contrary to Linux' `rmdir()`, Windows' _wrmdir() and _rmdir()
+	 * (and `RemoveDirectoryW()`) will attempt to remove the target of a
+	 * symbolic link (if it points to a directory).
+	 *
+	 * This behavior breaks the assumption of e.g. `remove_path()` which
+	 * upon successful deletion of a file will attempt to remove its parent
+	 * directories recursively until failure (which usually happens when
+	 * the directory is not empty).
+	 *
+	 * Therefore, before calling `_wrmdir()`, we first check if the path is
+	 * a symbolic link. If it is, we exit and return the same error as
+	 * Linux' `rmdir()` would, i.e. `ENOTDIR`.
+	 */
+	if (!mingw_lstat(pathname, &st) && S_ISLNK(st.st_mode)) {
+		errno = ENOTDIR;
+		return -1;
+	}
+
 	if (xutftowcs_path(wpathname, pathname) < 0)
 		return -1;
 
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 0bb88aa982b..23dbd3c82ed 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -406,4 +406,14 @@ test_expect_success 'refuse to switch to branch checked out elsewhere' '
 	test_i18ngrep "already checked out" err
 '
 
+test_expect_success MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs is a symlink' '
+	git checkout main &&
+	mv .git/logs actual_logs &&
+	cmd //c "mklink /D .git\logs ..\actual_logs" &&
+	git rebase -f HEAD^ &&
+	test -L .git/logs &&
+	rm .git/logs &&
+	mv actual_logs .git/logs
+'
+
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index adaf03543e8..73f6d645b66 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1513,6 +1513,12 @@ test_lazy_prereq SYMLINKS '
 	ln -s x y && test -h y
 '
 
+test_lazy_prereq SYMLINKS_WINDOWS '
+	# test whether symbolic links are enabled on Windows
+	test_have_prereq MINGW &&
+	cmd //c "mklink y x" &> /dev/null && test -h y
+'
+
 test_lazy_prereq FILEMODE '
 	test "$(git config --bool core.filemode)" = true
 '

base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
-- 
gitgitgadget
