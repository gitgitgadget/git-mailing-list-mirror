Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25F6C1975A
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 21:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66444206F9
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 21:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2jPnq5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgCVVOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 17:14:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36345 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgCVVOd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 17:14:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so8470905wrs.3
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 14:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CtEmaEgU7aGIcwqCVeJ7YIZOFW+FNF7BfX6MGqCqgSM=;
        b=f2jPnq5ygQzhwKcOiejCvLvuaYhJOnshDb/oc5RgQRESXLpiJr/WSVmCROgSJ4LWH6
         gJeK8PvElV8INwyAs2Zfe3+9HLWXiGaZWu5PneDchZgY1Jzc6RFLLbVaUTVhJeIo1mBJ
         zaRHoD87h5sfK7T5gWwJrEPw9Fwquj7fz0Ag8QIMLf6cHgxf9UzYgDQJSfGmGL5d8nmR
         dlVZ/OHjI547y5xZqnK9XaKAHQiR9w48el8SOYSq+Gat6n6Ky54E8qWyuPlYBihZI+3/
         98Ejt7f1teD6fpOniUP/ykihYn7bmBEGqYDEh+jijaT/UhfZOXrajjZ5latc44j1hASq
         weGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CtEmaEgU7aGIcwqCVeJ7YIZOFW+FNF7BfX6MGqCqgSM=;
        b=TG4u3UaH25Na9M6WDWLP/t9W3dKmaRe79gGUCxudBIZlkgu3/lUOEActjTomO/AHuC
         orefP6UdA3O0GIP4kGFnfz2WLhUXkFjXAsfEc1FLt396U1WYRN/zPrJcTyCbUwTISJA5
         FMI1RLIS5otZKnKAP75/e6X4jhrgv5mMNF3FyuR4dPjNFBQ3683tgqe7SyBOSdWzwu5K
         zx4MBAwu+GEj+ZP+yAI/YRmfDRRHmEZiNUbpBp9Lr4ZTtBW5N1k1ER4s53zmopc2V4GA
         gSD1YuoG0nBGa+X4m4F73qMnndLs7vfN/xi734V9U5DAinjdGOjmw181BXTPfmTrHGk/
         Zwhw==
X-Gm-Message-State: ANhLgQ0WN6CGXdddBokXgHQ1AYCRq22FS5LzY6D8Peh5kl449z6OpODx
        y7AsM4UAaTheCTJ7RnNGtKtMMbZB5/k=
X-Google-Smtp-Source: ADFU+vs8XtEBxixSKc3SERNLT6gbzP8YV3cO3Ud2lkf732xPNeq7dfvT/MgnAUHpUfvJzHEijE/a8A==
X-Received: by 2002:adf:dc4f:: with SMTP id m15mr26917592wrj.219.1584911670928;
        Sun, 22 Mar 2020 14:14:30 -0700 (PDT)
Received: from localhost.localdomain ([185.216.34.227])
        by smtp.gmail.com with ESMTPSA id a82sm2400256wmh.0.2020.03.22.14.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 14:14:30 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org, sunshine@sunshineco.com
Cc:     Andrei Rybak <rybak.a.v@gmail.com>
Subject: [PATCH v2 1/2] t9500: remove spaces after redirect operators
Date:   Sun, 22 Mar 2020 22:14:21 +0100
Message-Id: <20200322211422.15129-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200315180902.13750-1-rybak.a.v@gmail.com>
References: <20200315180902.13750-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For shell scripts, the usual convention is for there to be no space
after redirection operators, (e.g. `>file`, not `> file`). Remove these
spaces wherever they appear.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

A new patch from review by Eric Sunshine.

 t/t9500-gitweb-standalone-no-errors.sh | 70 +++++++++++++-------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index cc8d463e01..784df80858 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -53,7 +53,7 @@ test_expect_success \
 
 test_expect_success \
 	'Make initial commit' \
-	'echo "Not an empty file." > file &&
+	'echo "Not an empty file." >file &&
 	 git add file &&
 	 git commit -a -m "Initial commit." &&
 	 git branch b'
@@ -139,7 +139,7 @@ test_expect_success \
 
 test_expect_success \
 	'commitdiff(0): file added' \
-	'echo "New file" > new_file &&
+	'echo "New file" >new_file &&
 	 git add new_file &&
 	 git commit -a -m "File added." &&
 	 gitweb_run "p=.git;a=commitdiff"'
@@ -179,7 +179,7 @@ test_expect_success \
 
 test_expect_success \
 	'commitdiff(0): mode change and modified' \
-	'echo "New line" >> file2 &&
+	'echo "New line" >>file2 &&
 	 test_chmod +x file2 &&
 	 git commit -a -m "Mode change and modification." &&
 	 gitweb_run "p=.git;a=commitdiff"'
@@ -197,14 +197,14 @@ propter nomen suum.
 EOF
 	 git commit -a -m "File added." &&
 	 git mv file2 file3 &&
-	 echo "Propter nomen suum." >> file3 &&
+	 echo "Propter nomen suum." >>file3 &&
 	 git commit -a -m "File rename and modification." &&
 	 gitweb_run "p=.git;a=commitdiff"'
 
 test_expect_success \
 	'commitdiff(0): renamed, mode change and modified' \
 	'git mv file3 file2 &&
-	 echo "Propter nomen suum." >> file2 &&
+	 echo "Propter nomen suum." >>file2 &&
 	 test_chmod +x file2 &&
 	 git commit -a -m "File rename, mode change and modification." &&
 	 gitweb_run "p=.git;a=commitdiff"'
@@ -213,8 +213,8 @@ test_expect_success \
 # commitdiff testing (taken from t4114-apply-typechange.sh)
 
 test_expect_success 'setup typechange commits' '
-	echo "hello world" > foo &&
-	echo "hi planet" > bar &&
+	echo "hello world" >foo &&
+	echo "hi planet" >bar &&
 	git update-index --add foo bar &&
 	git commit -m initial &&
 	git branch initial &&
@@ -223,18 +223,18 @@ test_expect_success 'setup typechange commits' '
 	git commit -m "foo symlinked to bar" &&
 	git branch foo-symlinked-to-bar &&
 	rm -f foo &&
-	echo "how far is the sun?" > foo &&
+	echo "how far is the sun?" >foo &&
 	git update-index foo &&
 	git commit -m "foo back to file" &&
 	git branch foo-back-to-file &&
 	rm -f foo &&
 	git update-index --remove foo &&
 	mkdir foo &&
-	echo "if only I knew" > foo/baz &&
+	echo "if only I knew" >foo/baz &&
 	git update-index --add foo/baz &&
 	git commit -m "foo becomes a directory" &&
 	git branch "foo-becomes-a-directory" &&
-	echo "hello world" > foo/baz &&
+	echo "hello world" >foo/baz &&
 	git update-index foo/baz &&
 	git commit -m "foo/baz is the original foo" &&
 	git branch foo-baz-renamed-from-foo
@@ -324,7 +324,7 @@ test_expect_success 'commitdiff(1): removal of incomplete line' '
 test_expect_success \
 	'Create a merge' \
 	'git checkout b &&
-	 echo "Branch" >> b &&
+	 echo "Branch" >>b &&
 	 git add b &&
 	 git commit -a -m "On branch" &&
 	 git checkout master &&
@@ -342,26 +342,26 @@ test_expect_success \
 test_expect_success \
 	'Prepare large commit' \
 	'git checkout b &&
-	 echo "To be changed" > 01-change &&
-	 echo "To be renamed" > 02-pure-rename-from &&
-	 echo "To be deleted" > 03-delete &&
-	 echo "To be renamed and changed" > 04-rename-from &&
-	 echo "To have mode changed" > 05-mode-change &&
-	 echo "File to symlink" > 06-file-or-symlink &&
-	 echo "To be changed and have mode changed" > 07-change-mode-change	&&
+	 echo "To be changed" >01-change &&
+	 echo "To be renamed" >02-pure-rename-from &&
+	 echo "To be deleted" >03-delete &&
+	 echo "To be renamed and changed" >04-rename-from &&
+	 echo "To have mode changed" >05-mode-change &&
+	 echo "File to symlink" >06-file-or-symlink &&
+	 echo "To be changed and have mode changed" >07-change-mode-change	&&
 	 git add 0* &&
 	 git commit -a -m "Prepare large commit" &&
-	 echo "Changed" > 01-change &&
+	 echo "Changed" >01-change &&
 	 git mv 02-pure-rename-from 02-pure-rename-to &&
 	 git rm 03-delete && rm -f 03-delete &&
-	 echo "A new file" > 03-new &&
+	 echo "A new file" >03-new &&
 	 git add 03-new &&
 	 git mv 04-rename-from 04-rename-to &&
-	 echo "Changed" >> 04-rename-to &&
+	 echo "Changed" >>04-rename-to &&
 	 test_chmod +x 05-mode-change &&
 	 rm -f 06-file-or-symlink &&
 	 test_ln_s_add 01-change 06-file-or-symlink &&
-	 echo "Changed and have mode changed" > 07-change-mode-change	&&
+	 echo "Changed and have mode changed" >07-change-mode-change	&&
 	 test_chmod +x 07-change-mode-change &&
 	 git commit -a -m "Large commit" &&
 	 git checkout master'
@@ -444,7 +444,7 @@ test_expect_success \
 test_expect_success \
 	'logs: history (implicit HEAD, deleted file)' \
 	'git checkout master &&
-	 echo "to be deleted" > deleted_file &&
+	 echo "to be deleted" >deleted_file &&
 	 git add deleted_file &&
 	 git commit -m "Add file to be deleted" &&
 	 git rm deleted_file &&
@@ -522,7 +522,7 @@ test_expect_success \
 	'. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 	 test_when_finished "GIT_AUTHOR_NAME=\"A U Thor\"" &&
 	 test_when_finished "GIT_COMMITTER_NAME=\"C O Mitter\"" &&
-	 echo "UTF-8" >> file &&
+	 echo "UTF-8" >>file &&
 	 git add file &&
 	 git commit -F "$TEST_DIRECTORY"/t3900/1-UTF-8.txt &&
 	 gitweb_run "p=.git;a=commit"'
@@ -532,7 +532,7 @@ test_expect_success \
 	'. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 	 test_when_finished "GIT_AUTHOR_NAME=\"A U Thor\"" &&
 	 test_when_finished "GIT_COMMITTER_NAME=\"C O Mitter\"" &&
-	 echo "ISO-8859-1" >> file &&
+	 echo "ISO-8859-1" >>file &&
 	 git add file &&
 	 test_config i18n.commitencoding ISO-8859-1 &&
 	 git commit -F "$TEST_DIRECTORY"/t3900/ISO8859-1.txt &&
@@ -675,8 +675,8 @@ test_expect_success \
 
 test_expect_success \
 	'README.html with non-ASCII characters (utf-8)' \
-	'echo "<b>UTF-8 example:</b><br />" > .git/README.html &&
-	 cat "$TEST_DIRECTORY"/t3900/1-UTF-8.txt >> .git/README.html &&
+	'echo "<b>UTF-8 example:</b><br />" >.git/README.html &&
+	 cat "$TEST_DIRECTORY"/t3900/1-UTF-8.txt >>.git/README.html &&
 	 gitweb_run "p=.git;a=summary"'
 
 # ----------------------------------------------------------------------
@@ -704,7 +704,7 @@ test_expect_success HIGHLIGHT \
 test_expect_success HIGHLIGHT \
 	'syntax highlighting (highlighted, shell script)' \
 	'git config gitweb.highlight yes &&
-	 echo "#!/usr/bin/sh" > test.sh &&
+	 echo "#!/usr/bin/sh" >test.sh &&
 	 git add test.sh &&
 	 git commit -m "Add test.sh" &&
 	 gitweb_run "p=.git;a=blob;f=test.sh"'
@@ -712,7 +712,7 @@ test_expect_success HIGHLIGHT \
 test_expect_success HIGHLIGHT \
 	'syntax highlighting (highlighter language autodetection)' \
 	'git config gitweb.highlight yes &&
-	 echo "#!/usr/bin/perl" > test &&
+	 echo "#!/usr/bin/perl" >test &&
 	 git add test &&
 	 git commit -m "Add test" &&
 	 gitweb_run "p=.git;a=blob;f=test"'
@@ -729,11 +729,11 @@ test_expect_success \
 	'git init --bare foo.git &&
 	 git --git-dir=foo.git --work-tree=. add file &&
 	 git --git-dir=foo.git --work-tree=. commit -m "Initial commit" &&
-	 echo "foo" > foo.git/description &&
+	 echo "foo" >foo.git/description &&
 	 mkdir -p foo &&
 	 (cd foo &&
 	  git clone --shared --bare ../foo.git foo-forked.git &&
-	  echo "fork of foo" > foo-forked.git/description)'
+	  echo "fork of foo" >foo-forked.git/description)'
 
 test_expect_success \
 	'forks: projects list' \
@@ -754,8 +754,8 @@ EOF
 test_expect_success \
 	'ctags: tag cloud in projects list' \
 	'mkdir .git/ctags &&
-	 echo "2" > .git/ctags/foo &&
-	 echo "1" > .git/ctags/bar &&
+	 echo "2" >.git/ctags/foo &&
+	 echo "1" >.git/ctags/bar &&
 	gitweb_run'
 
 test_expect_success \
@@ -769,8 +769,8 @@ test_expect_success \
 test_expect_success \
 	'ctags: malformed tag weights' \
 	'mkdir -p .git/ctags &&
-	 echo "not-a-number" > .git/ctags/nan &&
-	 echo "not-a-number-2" > .git/ctags/nan2 &&
+	 echo "not-a-number" >.git/ctags/nan &&
+	 echo "not-a-number-2" >.git/ctags/nan2 &&
 	 echo "0.1" >.git/ctags/floating-point &&
 	 gitweb_run'
 
-- 
2.25.1

