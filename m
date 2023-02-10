Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599ECC05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 08:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjBJIB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 03:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjBJIB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 03:01:26 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F7E7AE3D
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 00:01:25 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id bx22so4455520pjb.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 00:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C8dyx7fZkeOXLxLbx3HlXaHO/u6L7Jf5tRRsam328PA=;
        b=cK5u8D8j0GgM9YE2BrgE+RUJIZwNy81mxfGv3mA8mkiDTKzSoRbiOw0kn2IQ10NCUL
         pgZ2qBILLfK08sJSAjFXCj2rxUptk/lEewX01/jcQPGlwHbR6Y1iarxwM72WQXDeH+Sg
         rqLisyzbc9j4qAVjwJ5q1gmU2FnIvfepCI4UimqRlBbFRW3l/4QviXj//YUgqeQammHw
         X8INwxNlPNezRIIgXU14H2bI1kuglU3QgfINPln7M4ZXzSv2SnF5GBNP5jppLsoSo/he
         mfx67cWCu3B5yN7ExUmGcWcreG2SETzS/BnnwFV8u8UdaGwUxWwNnyRNJLNG8tvTENm9
         IBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8dyx7fZkeOXLxLbx3HlXaHO/u6L7Jf5tRRsam328PA=;
        b=xvjA1oQyLPHl7EZPZxO8r/qqvfbcB/7BNPBI/LzpbPUKqv/l7tQZJjKGUzcFVt+J3E
         ImMk1AMWRD9DdHVuowluZVnHw9oJtWtVJIPTkk0QbcrkQuLCGVvyESW42FQ0Sw9AIInz
         0OsW1Jpf/mAC7eZH4XGRFKi7L9dd/g8D8wRzUhZ3McA9tKkJq5NPRpgaDL6VW1khYknF
         sv0V/QuydYDiIS636Y9E975WSAYYIdiyy2gJgGjgrhMk9KcVLQnWgz3wRn3ECbp5ctdh
         bTYOIurLZ9XmJXUlh1i3csCl+SsVrESoVIkQ+ZB0SHWGQt61FPa+7Mg3bPAVvbWv4Sgf
         b5sQ==
X-Gm-Message-State: AO0yUKUoSnAII5nrC2xfIf+xuuYoNmg0EH7sYgmNeU+fhuwJNMr5j/Q0
        y+3Bzm13dNLRw1GdZw9UpkASloujJBt89Q==
X-Google-Smtp-Source: AK7set9lJDeFHP5G6JHwQj7mBrGKzxRb0Eb0St7jP2/SPph/kNVrOk8HFy+04loU8Lq7HzwznZcUiA==
X-Received: by 2002:a17:903:11d1:b0:198:eaac:4643 with SMTP id q17-20020a17090311d100b00198eaac4643mr17194040plh.4.1676016084456;
        Fri, 10 Feb 2023 00:01:24 -0800 (PST)
Received: from localhost.localdomain ([2405:201:6805:20dd:94a9:fa14:fe37:b9ef])
        by smtp.gmail.com with ESMTPSA id jm15-20020a17090304cf00b001994a0f3380sm2747082plb.265.2023.02.10.00.01.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Feb 2023 00:01:23 -0800 (PST)
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
To:     git@vger.kernel.org
Cc:     Vinayak Dev <vinayakdev.sci@gmail.com>
Subject: [RFC][GSoC][PATCH] t9160: Change test -(d | f) to test_path_is_*
Date:   Fri, 10 Feb 2023 13:31:10 +0530
Message-Id: <20230210080110.32983-1-vinayakdev.sci@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes test -d and test -f commands in
t/t9160-git-svn-preserve-empty-dirs.sh to test_path_is_dir and
test_path_is_file respectively, which are helper functions defined in
t/test-lib-functions.sh

Signed-off-by: Vinayak Dev <vinayakdev.sci@gmail.com>


vinayakdsci (1):
  Change test -(d | f) to corresponding test_path_*

 t/t9160-git-svn-preserve-empty-dirs.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)


diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
index 36c6b1a12f..963b081a1c 100755
--- a/t/t9160-git-svn-preserve-empty-dirs.sh
+++ b/t/t9160-git-svn-preserve-empty-dirs.sh
@@ -61,15 +61,15 @@ test_expect_success 'clone svn repo with --preserve-empty-dirs' '
 
 # "$GIT_REPO"/1 should only contain the placeholder file.
 test_expect_success 'directory empty from inception' '
-	test -f "$GIT_REPO"/1/.gitignore &&
+	test_path_is_file "$GIT_REPO"/1/.gitignore &&
 	test $(find "$GIT_REPO"/1 -type f | wc -l) = "1"
 '
 
 # "$GIT_REPO"/2 and "$GIT_REPO"/3 should only contain the placeholder file.
 test_expect_success 'directory empty from subsequent svn commit' '
-	test -f "$GIT_REPO"/2/.gitignore &&
+	test_path_is_file "$GIT_REPO"/2/.gitignore &&
 	test $(find "$GIT_REPO"/2 -type f | wc -l) = "1" &&
-	test -f "$GIT_REPO"/3/.gitignore &&
+	test_path_is_file "$GIT_REPO"/3/.gitignore &&
 	test $(find "$GIT_REPO"/3 -type f | wc -l) = "1"
 '
 
@@ -77,7 +77,7 @@ test_expect_success 'directory empty from subsequent svn commit' '
 # generated for every sub-directory at some point in the repo's history.
 test_expect_success 'add entry to previously empty directory' '
 	test $(find "$GIT_REPO"/4 -type f | wc -l) = "1" &&
-	test -f "$GIT_REPO"/4/a/b/c/foo
+	test_path_is_file "$GIT_REPO"/4/a/b/c/foo
 '
 
 # The HEAD~2 commit should not have introduced .gitignore placeholder files.
@@ -108,8 +108,8 @@ test_expect_success 'placeholder namespace conflict with file' '
 # "$GIT_REPO"/6/.placeholder should be a directory, and the "$GIT_REPO"/6 tree
 # should only contain one file: the placeholder.
 test_expect_success 'placeholder namespace conflict with directory' '
-	test -d "$GIT_REPO"/6/.placeholder &&
-	test -f "$GIT_REPO"/6/.placeholder/.placeholder &&
+	test_path_is_dir "$GIT_REPO"/6/.placeholder &&
+	test_path_is_file "$GIT_REPO"/6/.placeholder/.placeholder &&
 	test $(find "$GIT_REPO"/6 -type f | wc -l) = "1"
 '
 
@@ -134,18 +134,18 @@ test_expect_success 'second set of svn commits and rebase' '
 # Check that --preserve-empty-dirs and --placeholder-file flag state
 # stays persistent over multiple invocations.
 test_expect_success 'flag persistence during subsqeuent rebase' '
-	test -f "$GIT_REPO"/7/.placeholder &&
+	test_path_is_file "$GIT_REPO"/7/.placeholder &&
 	test $(find "$GIT_REPO"/7 -type f | wc -l) = "1"
 '
 
 # Check that placeholder files are properly removed when unnecessary,
 # even across multiple invocations.
 test_expect_success 'placeholder list persistence during subsqeuent rebase' '
-	test -f "$GIT_REPO"/1/file1.txt &&
+	test_path_is_file "$GIT_REPO"/1/file1.txt &&
 	test $(find "$GIT_REPO"/1 -type f | wc -l) = "1" &&
 
-	test -f "$GIT_REPO"/5/file1.txt &&
-	test -f "$GIT_REPO"/5/.placeholder &&
+	test_path_is_file "$GIT_REPO"/5/file1.txt &&
+	test_path_is_file "$GIT_REPO"/5/.placeholder &&
 	test $(find "$GIT_REPO"/5 -type f | wc -l) = "2"
 '
 
-- 
2.39.1
