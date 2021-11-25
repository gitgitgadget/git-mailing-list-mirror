Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC02C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 08:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353806AbhKYIpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 03:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353422AbhKYInR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 03:43:17 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE64BC0613DD
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:26 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s13so9935022wrb.3
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dosfbg1Z3obof3TXY/qdvWfkxJgZjSOuMMd8JDUYq6Q=;
        b=PZePRTlS5XJ6Mo3Nvqgq8wStxW5SgqiWIbqwoCyB59rjsfKxvC7QvZ+CKSnCCYQTah
         K803ylbTAq2LB4k7H24HDzMeKk1dq7d9rZsLgrMxhYvASZDPMsIiPnjafg8Hf5TQDIm/
         9cyvfmaIy/1RdVeP9c9lW3SrNmqzlpq1nR7EReuBRfLwKaO9m9gujm5yHG7p4D/Xg/yZ
         tcWn/4MfiWpGKJtdedJw8VodIqp7B60UVXDG88fXi9I56Mw5WtupLtOeDNKG8H4kZj9Q
         1t/ymmIOIh0PycwiagIN6oYHYDENXjV80d/+WEOlnkrX0x9CoEuCXi1Z07Pe+MJmaaGm
         1DUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dosfbg1Z3obof3TXY/qdvWfkxJgZjSOuMMd8JDUYq6Q=;
        b=qMTcTl1X0n/RYrEUopN0vWu66vsTH5pNy70NbvLZ+ZTliReksaCQchrf4kcMFidSWZ
         TBST/SMCysGtnuPVyEqIm4ljrZoOoOC7ZP9GEMyWcMLPiqz4FCvHoM+w5BFFzDh0vfov
         NbK9tpklOiH7SiuvDhISdpDAqUw6KtQzmU95XC7zazFhuboDK+GgX7UuDurWOfXmDvl9
         cisdbNAsyzM8NzHarjbtkEtatDVI07fOxTthgK77DLYBhV9D2msjOFpA5uaZVxbGHhxF
         FnhItCwGkWe9zss3PHbBKP4nc/mh2ubNchImlWyqnRpWe3STPtaQ2H4Zzd+44fqA8Vub
         XK7A==
X-Gm-Message-State: AOAM530VYwWSKxcBO1MfnQB2HyqokXipf9TRT7IwdZcNqREgK7+43yhJ
        KrxLfG1r+9unBr6nbcC9FEWFUqbkGyQ=
X-Google-Smtp-Source: ABdhPJyjzZLs+tKycaPrqB+bea/23CPdesUbmh5NbGUGLRgEXCyrknRy2tMPXPkqgWTliT2t9YvUXA==
X-Received: by 2002:a5d:4989:: with SMTP id r9mr4660785wrq.14.1637829565263;
        Thu, 25 Nov 2021 00:39:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i17sm2543923wmq.48.2021.11.25.00.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 00:39:24 -0800 (PST)
Message-Id: <01ce9444daeafe7a11265956b847f92233f5d028.1637829556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
        <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 08:39:13 +0000
Subject: [PATCH v2 6/9] clean: do not attempt to remove
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
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c      | 47 +++++++++++++++++++++++++++++++++++---------
 t/t2501-cwd-empty.sh |  2 +-
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 98a2860409b..68c8d593c77 100644
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
@@ -231,16 +235,39 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
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
+		 * path and realpath are absolute; for comparison, we want
+		 * startup_info->original_cwd to be an absolute path too.  We
+		 * can use strbuf_realpath for this.  Also, if original_cwd
+		 * started out as the empty string, then it corresponded to
+		 * the top of the worktree, which is protected by other means
+		 * so we just leave it blank.
+		 */
+		 if (*startup_info->original_cwd)
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
 
@@ -250,6 +277,8 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 			printf(dry_run ?  _(msg_would_remove) : _(msg_remove), dels.items[i].string);
 	}
 out:
+	strbuf_release(&realpath);
+	strbuf_release(&real_ocwd);
 	strbuf_release(&quoted);
 	string_list_clear(&dels, 0);
 	return ret;
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index b92e1a9bb16..20e1b6adede 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -218,7 +218,7 @@ test_expect_failure 'apply does not remove cwd incidentally' '
 	test_path_is_dir subdir
 '
 
-test_expect_failure 'clean does not remove cwd incidentally' '
+test_expect_success 'clean does not remove cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
-- 
gitgitgadget

