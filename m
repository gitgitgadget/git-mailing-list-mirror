Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEA8C433EF
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 00:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhKUAuR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 19:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbhKUAuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 19:50:09 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AC1C061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:05 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w29so25282037wra.12
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7uwKibAxpKQ7iPujXJcM6AnuiMkYSv9Z39P/Lfd4iUY=;
        b=QEIkcCJO42H+54IntS9gFfTh2tU5zmBman4EVuxtZPv2UXzz/Is1MHIPCMWoKBXoc5
         esDKhsjBR75dKgnbDUDlIQwXx00oLwRv9d4V6fDpG9oCaXCM8Yp7xKnHwb//30YrgB1x
         EScwusqDaUieDQUYuYHfSnclqgYy0EkIcTPpiUZJu2zP6iZtTdzBmDcAjxVMGg12TkMs
         D1tlsFAyRfafoIrM4qDvQAvPZwxHmF1YueHqRfTd6KFYS/Sunl7MHfumWI0oI6qQCiIo
         DWThvzMSvdnIQA8q/OrQJQrPs8JfjMI33uieynsw9VmGhjaSuEm2BboUuccp0+fvM3cL
         gXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7uwKibAxpKQ7iPujXJcM6AnuiMkYSv9Z39P/Lfd4iUY=;
        b=8P7UZULa63oAabTwqbNCLEDlyCPrTr62TRDnylfLGhHywpuUoPIyaW/QrskXZe6pRn
         nny3W6/CM28nuJsdjbVw4k0teIVy6aWcnR0KjCjIsiSqla9UZivlJG3m+owPr0Xfz3ao
         3Bif8GN+imjYH1iWyCvrAGRXIxqE2wr62qr3RmOzkSeRmgIDoC9iKjrszd+yk3grpl1m
         Vmjb+/T2mhBO84qxdX/te7FbmVWxLg6CS1slhfSa//4bqJHPkd160C2E7ExgpsRcO5Ve
         EpbXD0um9Jz+AUki8/3sYTSAaxn4O0ZC6Vx65i5suYp3nUqctBHpGaBA1FwOVrOeFUi0
         2BjA==
X-Gm-Message-State: AOAM532b8jDtkQiDnVW0swGXPETiuL358mjSYhX/yhztJuXwMKB+jj7l
        LVCdKocLQC7vl8W5IFf9EhINlFsJEGI=
X-Google-Smtp-Source: ABdhPJwoy7gn/I8cGsAwjfe8Vmvd7O2ziODWaSzplDX1+lpFyMlFbE8vw22jLTfakjRXtOjiwyoERw==
X-Received: by 2002:a5d:47a1:: with SMTP id 1mr22002203wrb.436.1637455623594;
        Sat, 20 Nov 2021 16:47:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg12sm2489473wmb.5.2021.11.20.16.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 16:47:03 -0800 (PST)
Message-Id: <94bf468be0972ce3d6037e6688749cab01269b14.1637455620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Nov 2021 00:46:55 +0000
Subject: [PATCH 3/8] unpack-trees: refuse to remove the current working
 directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In the past, when a directory needs to be removed to make room for a
file, we have always errored out when that directory contains any
untracked (but not ignored) files.  Add an extra condition on that: also
error out if the directory is the current working directory.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2501-cwd-empty.sh | 10 +++++-----
 unpack-trees.c       | 16 ++++++++++++----
 unpack-trees.h       |  1 +
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 5dfb456a691..212676d71c3 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -38,7 +38,7 @@ test_expect_failure 'checkout does not clean cwd incidentally' '
 	test_path_is_dir foo
 '
 
-test_expect_failure 'checkout fails if cwd needs to be removed' '
+test_expect_success 'checkout fails if cwd needs to be removed' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -95,7 +95,7 @@ test_expect_failure 'merge does not remove cwd incidentally' '
 	test_path_is_dir subdir
 '
 
-test_expect_failure 'merge fails if cwd needs to be removed' '
+test_expect_success 'merge fails if cwd needs to be removed' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -122,7 +122,7 @@ test_expect_failure 'cherry-pick does not remove cwd incidentally' '
 	test_path_is_dir subdir
 '
 
-test_expect_failure 'cherry-pick fails if cwd needs to be removed' '
+test_expect_success 'cherry-pick fails if cwd needs to be removed' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -149,7 +149,7 @@ test_expect_failure 'rebase does not remove cwd incidentally' '
 	test_path_is_dir subdir
 '
 
-test_expect_failure 'rebase fails if cwd needs to be removed' '
+test_expect_success 'rebase fails if cwd needs to be removed' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -176,7 +176,7 @@ test_expect_failure 'revert does not remove cwd incidentally' '
 	test_path_is_dir subdir
 '
 
-test_expect_failure 'revert fails if cwd needs to be removed' '
+test_expect_success 'revert fails if cwd needs to be removed' '
 	git checkout fd_conflict &&
 	git revert HEAD &&
 	test_when_finished "git clean -fdx" &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 89ca95ce90b..8879b8d6c8c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -36,6 +36,9 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
 	/* ERROR_NOT_UPTODATE_DIR */
 	"Updating '%s' would lose untracked files in it",
 
+	/* ERROR_CWD_IN_THE_WAY */
+	"Refusing to remove '%s' since it is the current working directory.",
+
 	/* ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN */
 	"Untracked working tree file '%s' would be overwritten by merge.",
 
@@ -131,6 +134,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	msgs[ERROR_NOT_UPTODATE_DIR] =
 		_("Updating the following directories would lose untracked files in them:\n%s");
 
+	msgs[ERROR_CWD_IN_THE_WAY] =
+		_("Refusing to remove the current working directory:\n%s");
+
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("The following untracked working tree files would be removed by checkout:\n%%s"
@@ -2146,10 +2152,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 		cnt++;
 	}
 
-	/*
-	 * Then we need to make sure that we do not lose a locally
-	 * present file that is not ignored.
-	 */
+	/* Do not lose a locally present file that is not ignored. */
 	pathbuf = xstrfmt("%.*s/", namelen, ce->name);
 
 	memset(&d, 0, sizeof(d));
@@ -2160,6 +2163,11 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	free(pathbuf);
 	if (i)
 		return add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
+
+	/* Do not lose the current working directory. */
+	if (the_cwd && !strcmp(the_cwd, ce->name))
+		return add_rejected_path(o, ERROR_CWD_IN_THE_WAY, ce->name);
+
 	return cnt;
 }
 
diff --git a/unpack-trees.h b/unpack-trees.h
index 71ffb7eeb0c..efb9edfbb27 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -19,6 +19,7 @@ enum unpack_trees_error_types {
 	ERROR_WOULD_OVERWRITE = 0,
 	ERROR_NOT_UPTODATE_FILE,
 	ERROR_NOT_UPTODATE_DIR,
+	ERROR_CWD_IN_THE_WAY,
 	ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN,
 	ERROR_WOULD_LOSE_UNTRACKED_REMOVED,
 	ERROR_BIND_OVERLAP,
-- 
gitgitgadget

