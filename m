Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7D3C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbhK2XNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbhK2XMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:12:54 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9F5C0800EF
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:21 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p18so15877164wmq.5
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OZqLOTMx91bPn6Wg6p6TbKGeTgXMiLOWko6q9yWSkLE=;
        b=UfDlKt6Lg9YnGW7NzhW5uBDhKRHLugEbzGuuRHI39leSkExCJbgMIC7CzCwh1VX3tC
         Wx5Jzdqb9IaGAHm14k1s8G7Spmgu/tnuIIUvZJL5BvrWLf5nSvxmoon7VbIkCJpsnuhu
         AX9ZtIFaisHRs2ozMGwZnzU75KuPDOj41d+uwPCwfTx21eOtAvaxFKwyBKD5z2SroGVs
         EVXpN+KykKPyELP5FjZjsqWcAQr8VZaaP0Uouxsdu8CcDYLxHtSFUKaQ3KbjCs4KJPr9
         Whdq8Zajj+Ze+HCZSjjxF6wor7MLsp5soJULUJKSCiF+iBWPd7FkUqqT/ML1j6o5crHG
         3FWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OZqLOTMx91bPn6Wg6p6TbKGeTgXMiLOWko6q9yWSkLE=;
        b=b58elODZ3n/G69d28P3HDjTE4uAVxRWKarHCFmNQHlgC1pUlE847q1rxL5HySScb/V
         +Wy9mg6c08bNXftpZWitU7Gn5XVqTJipRiQ44sYszo0FIdolhkhLx74XTphD0EYKQP+j
         gorx4bHEQG1p7XK9vXt3uxSNrXwJmymHHDXhHAfzv8XcOHQxgkle6EfmMc6apzq8vXLy
         KjPBmbJnkYKduV4FCbrwvibeo6QdJ05mk3WeKW2oYtR6maLCy4CEje+ArL/lMrIz7DrQ
         GlHrBuYpvNO6IWdL8Kw115QngsIa2Z0yMerydgfUkEgreM261U5cLGSLa0xaBrux7IRH
         hkvw==
X-Gm-Message-State: AOAM530c00+aKTAU2Qi9QLnmmXB0D2ukWapIWq7IZIwrXrxc/mVN5qMN
        YYc/WemHpgQvJCDwgZ6m1xwTRBn+kXQ=
X-Google-Smtp-Source: ABdhPJz425CrUnIgY6v5ne/ihcZF7YLTiAmGmXzSJwHwsqM5H7C/bxU75E+zILWSPvA9RmAXVixhHQ==
X-Received: by 2002:a05:600c:5125:: with SMTP id o37mr833469wms.81.1638225440314;
        Mon, 29 Nov 2021 14:37:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a22sm524605wme.19.2021.11.29.14.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:37:19 -0800 (PST)
Message-Id: <1990e36bb4121c6b79cee4b646f6adc7ad3f3424.1638225434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
References: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
        <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 22:37:09 +0000
Subject: [PATCH v4 06/11] clean: do not attempt to remove
 startup_info->original_cwd
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c      | 44 +++++++++++++++++++++++++++++++++++---------
 t/t2501-cwd-empty.sh |  5 +++--
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 98a2860409b..3ff02bbbffe 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -36,6 +36,8 @@ static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
 static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
 static const char *msg_warn_remove_failed = N_("failed to remove %s");
 static const char *msg_warn_lstat_failed = N_("could not lstat %s\n");
+static const char *msg_skip_cwd = N_("Refusing to remove current working directory\n");
+static const char *msg_would_skip_cwd = N_("Would refuse to remove current working directory\n");
 
 enum color_clean {
 	CLEAN_COLOR_RESET = 0,
@@ -153,6 +155,8 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 {
 	DIR *dir;
 	struct strbuf quoted = STRBUF_INIT;
+	struct strbuf realpath = STRBUF_INIT;
+	struct strbuf real_ocwd = STRBUF_INIT;
 	struct dirent *e;
 	int res = 0, ret = 0, gone = 1, original_len = path->len, len;
 	struct string_list dels = STRING_LIST_INIT_DUP;
@@ -231,16 +235,36 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	strbuf_setlen(path, original_len);
 
 	if (*dir_gone) {
-		res = dry_run ? 0 : rmdir(path->buf);
-		if (!res)
-			*dir_gone = 1;
-		else {
-			int saved_errno = errno;
-			quote_path(path->buf, prefix, &quoted, 0);
-			errno = saved_errno;
-			warning_errno(_(msg_warn_remove_failed), quoted.buf);
+		/*
+		 * Normalize path components in path->buf, e.g. change '\' to
+		 * '/' on Windows.
+		 */
+		strbuf_realpath(&realpath, path->buf, 1);
+
+		/*
+		 * path and realpath are absolute; for comparison, we would
+		 * like to transform startup_info->original_cwd to an absolute
+		 * path too.
+		 */
+		 if (startup_info->original_cwd)
+			 strbuf_realpath(&real_ocwd,
+					 startup_info->original_cwd, 1);
+
+		if (!strbuf_cmp(&realpath, &real_ocwd)) {
+			printf("%s", dry_run ? _(msg_would_skip_cwd) : _(msg_skip_cwd));
 			*dir_gone = 0;
-			ret = 1;
+		} else {
+			res = dry_run ? 0 : rmdir(path->buf);
+			if (!res)
+				*dir_gone = 1;
+			else {
+				int saved_errno = errno;
+				quote_path(path->buf, prefix, &quoted, 0);
+				errno = saved_errno;
+				warning_errno(_(msg_warn_remove_failed), quoted.buf);
+				*dir_gone = 0;
+				ret = 1;
+			}
 		}
 	}
 
@@ -250,6 +274,8 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 			printf(dry_run ?  _(msg_would_remove) : _(msg_remove), dels.items[i].string);
 	}
 out:
+	strbuf_release(&realpath);
+	strbuf_release(&real_ocwd);
 	strbuf_release(&quoted);
 	string_list_clear(&dels, 0);
 	return ret;
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 50619de10aa..6ab82e05d98 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -230,8 +230,9 @@ test_incidental_untracked_dir_removal () {
 }
 
 test_expect_success 'clean does not remove cwd incidentally' '
-	test_incidental_untracked_dir_removal failure \
-		git -C .. clean -fd -e warnings . >warnings
+	test_incidental_untracked_dir_removal success \
+		git -C .. clean -fd -e warnings . >warnings &&
+	grep "Refusing to remove current working directory" warnings
 '
 
 test_expect_success 'stash does not remove cwd incidentally' '
-- 
gitgitgadget

