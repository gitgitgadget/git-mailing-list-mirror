Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0515EC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD8B60462
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhG2TVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhG2TVl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 15:21:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7ABC061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:21:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l18so8228711wrv.5
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=YKT4OJUOh3lPVp9QmMZxDL/gtZTymaLksxeZlGVQqq8=;
        b=Qmd9RNm6QL/D4ydArJFYdZi5pyWows/8waV6FUxMpKblCn9sDY/nD2Gqjb1AV4nGXj
         JrER+BRBPH6cQYGaZLImsdflgIxCoh+yCCVb7vUpSjcPWALtvIUsP+0u8euU5hcYVayT
         /37ap7ULXGr68PWXuNbo5hCOIr5/8AfNvQiTn3b9ctmhwtlhN4CfFvwYyZmSFY2G7Tql
         +JrLEBW+vQzMUzefS9cC5kPw8Jvv5IsY6i1GFweIApnF5L8A+lUDBZQCPzhlyAQpfU0o
         uFIzlRc2N5l5NpCZa0XcLO+UUiZ94P5Br+5e7xKH0mQGwI+xvR86azg+cec+Y05ayQFN
         pCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=YKT4OJUOh3lPVp9QmMZxDL/gtZTymaLksxeZlGVQqq8=;
        b=b0KQUnm5/Y456ff1fKwO7iH9clsoTitfdEbzEKmSH3qvFnyGw6eHscX7mcvW1xb4K6
         cUZkNxs2fX+X67ctxHEi5BOY4+em2bMwY2AUmYVa3d0U5dIfj7Ye61rKjNBtamkeDK7g
         s2x3k0jVrzDAT0vCM01NSwPdtDGGuob6EjVhyFVmKB8fCLOlVROmueiix2Brl2IF5gJr
         eAwiziz+pbcOovgC/f59/NFVe2xL513FL0doq/7IxsaHI3z5/HHFNkFFZPd/xZR0f+c5
         5RuHPVC9tk54CLmgkCsgvsfpg5cMOwSRbhDvceBi0BI/qQa6GmPz4ElB3g9jBNaEtaQo
         uzoA==
X-Gm-Message-State: AOAM533jkKJYssQGWSpVvqeB1sqSa8tPViF950rNWvPhjhTyBQ4b5dEt
        5gjGmdmIcE1gvk1Y+HISO0aIkE93hWM=
X-Google-Smtp-Source: ABdhPJx0wIi3AYFxJmmD3lhGNP7jJpJXCU6yr7h0aYnb+b87xAUd2vEfq2z9jQ5aSf3EDo8Wo7BPFw==
X-Received: by 2002:adf:e0c4:: with SMTP id m4mr6569680wri.312.1627586495153;
        Thu, 29 Jul 2021 12:21:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e5sm5307047wrr.36.2021.07.29.12.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 12:21:34 -0700 (PDT)
Message-Id: <pull.1008.git.1627586493659.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 19:21:33 +0000
Subject: [PATCH] mingw: align symlinks-related rmdir() behavior with Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When performing a rebase, rmdir() is called on the folder .git/logs. On
Unix rmdir() exits without deleting anything in case .git/logs is a
symbolic link but the equivalent functions on Windows (_rmdir, _wrmdir
and RemoveDirectoryW) do not behave the same and remove the folder if it
is symlinked even if it is not empty.

This creates issues when folders in .git/ are symlinks which is
especially the case when git-repo[1] is used.

This commit updates mingw_rmdir() so that its behavior is the same as
Linux rmdir() in case of symbolic links.

This fixes https://github.com/git-for-windows/git/issues/2967

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1008%2Fdscho%2Ffix-rmdir-with-symlinks-on-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1008/dscho/fix-rmdir-with-symlinks-on-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1008

 compat/mingw.c    | 15 +++++++++++++++
 t/t3400-rebase.sh | 10 ++++++++++
 t/test-lib.sh     |  6 ++++++
 3 files changed, 31 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index aa647b367b0..685d3efa3c0 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -341,6 +341,21 @@ int mingw_rmdir(const char *pathname)
 {
 	int ret, tries = 0;
 	wchar_t wpathname[MAX_PATH];
+	struct stat st;
+
+	/*
+	* Contrary to Linux rmdir(), Windows' _wrmdir() and _rmdir()
+	* will remove the directory at the path if it is a symbolic link
+	* which leads to issues when symlinks are used in the .git folder
+	* (in the context of git-repo for instance). So before calling _wrmdir()
+	* we first check if the path is a symbolic link. If it is, we exit
+	* and return the same error as Linux rmdir() in this case (ENOTDIR).
+	*/
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
