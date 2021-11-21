Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6478CC433FE
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 00:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbhKUAuW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 19:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237292AbhKUAuL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 19:50:11 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA83C061756
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u1so25278214wru.13
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fCdjzoDdlkgCxhufNCKzSpaLeuUqZfQCiQ4S923ZeGA=;
        b=VnexvILYI+SrcGt11AZ6y0Gz1Llt1WgbV+mcRxptmeHgnOXscGeGUsn3LTwHKpInR8
         hHDQRFK4JNHVmkiGqxLADWnlluzGZuO357vgHKGZ1fnI9zzYJWOtp5FzJ51zYzujnwPi
         fU8KKsMJH/ShSUU/Or1wsHteEiLCi9cmhZhqa505mZWammtrFnBbrqksoPvZp90jYMf7
         A/mbij/PzyjCbtujn+9RC/QHDThxqXQUJFr+hGcYGf7AhP0aipsNOnaOzccE/0Ocg0h4
         x+exLsX9JBbNXiI2wvywcmjMfJGnH004f0vYZfBUmU8MsCBvPhTwQS2zdJwKe8IItfTE
         mO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fCdjzoDdlkgCxhufNCKzSpaLeuUqZfQCiQ4S923ZeGA=;
        b=1ORjtGsgPrkNb+bhITcxJ3HH2Af4TFSxvqN0xyri8v2rY3ZUAsdQVq8XTfAlwKqzcO
         PNYdq8fZDnfodTc1f5ym7wSzh8f56u6RPsPAi6fquLf5sxc1Kjk2Y8pprZwY4p0e8CUL
         uipxXHOvccJ0eFqVJhI7bG78GZpbOyA6niXyiLjsTgXSRVs84i5ZL+UESpdCiKC9k1wc
         Xr0BkosUowcjph27s57rspGZHNh/yrDKUfiObyQUx93L9zVD37+MEMbyGCywxap7RG6b
         wfxbj/Ga64s0FbaGqnEfXKejkhlLAWZeqB4Zf+52jSdyVBb/UTaZtQo0Xpc0pCcY5l4o
         S9Xg==
X-Gm-Message-State: AOAM5307CspyMQXwuyJo4agfdFjeXJDualJFWMshBb6VsSnyTZbOmSpm
        BwbcJ74E4cr9PZ21ZnYs4HqG26hFbpY=
X-Google-Smtp-Source: ABdhPJwkRJgQkppvgUUoKZ40DcEakvOf4S6rrxukdxa4uncQE4PeXdAmyM6PdtHZ2TxxdqVODYz5+g==
X-Received: by 2002:a05:6000:15c6:: with SMTP id y6mr22322919wry.422.1637455625406;
        Sat, 20 Nov 2021 16:47:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15sm16057633wmh.13.2021.11.20.16.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 16:47:05 -0800 (PST)
Message-Id: <69bcaf0aab28fec145742f7183b1d89b12eaf0f9.1637455620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Nov 2021 00:46:58 +0000
Subject: [PATCH 6/8] clean: do not attempt to remove current working directory
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c      | 29 ++++++++++++++++++++---------
 t/t2501-cwd-empty.sh |  2 +-
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 98a2860409b..17d54be57b7 100644
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
@@ -231,16 +233,25 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
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
+		int prefixlen = prefix ? strlen(prefix) : 0;
+		if (prefix &&
+		    path->len == prefixlen + 2 &&
+		    !strncmp(path->buf, prefix, prefixlen) &&
+		    !strcmp(path->buf + prefixlen, "./")) {
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

