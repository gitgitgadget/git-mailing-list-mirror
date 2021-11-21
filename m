Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E432AC433EF
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 00:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhKUAuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 19:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbhKUAuK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 19:50:10 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C15AC06174A
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:06 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso10575293wmf.0
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qvnZz8QiNul7WHe0ZnCPt0rBbpsoLenQCIBGu6vkc6A=;
        b=D5z36zJKHbD3px3mPhwNpmKDbxPpTElrNeeoZkXclOMIc0kiQ58YGufhycOg7WdbrK
         Gg/wdOmywqoAPYFJPp6sU4dkSA5x0PF3dZydhFWdAfiFtvZFQRAIYhj/IEuLhJ5skvCx
         x9BUDIhP7L7HiNqaHxaCtiqM3/W/BM+HS4qHo7Ovg3UN16IA50P/fVZ1Jl4ls4AEeq6Q
         sgZxCY+srS6lHaGeRG7cKJy+8wK26Re9ed/2Onj8B5zKnJHU9D8BQ4p5cXxh+t0LfHki
         YS4FZeHYHwueScUcRT7tYte/Epui8Hf0PJVpyBUkgR/qGvYY3ycP/tGJ6dYU5JRjUF+i
         ITrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qvnZz8QiNul7WHe0ZnCPt0rBbpsoLenQCIBGu6vkc6A=;
        b=U77dPRyUYYVyrB/ZaYsIpXazXLNctc8HOcCilnHVzjtVDH1j9Fs/W7y3zw6WVOJb37
         xsqF3oVUEjPzmEz90hhMc5Id2L5p6W++CVw+ZGmRigYfyykyFrFexQTiW6UF0+pk2mgC
         pii3Ny6mEGa29aVEQfvAb8V9vsZzizyfVHeAwyeT8YrQ8+2HFkjplZ2k1x0q3MdvJZUx
         yakkCfJChgmA3ZhyK03cgIQ2ARMy/tB2egM5dKk3VC7HmyJgIUb/Hfg3rhdC163Imove
         R+t3sJlxEE5QCFjCoGuc84wL9SmgJ7Op6fPgENGI0ZZ6I3Y8L9/LY+H1BKGbne43NUrH
         Lkxw==
X-Gm-Message-State: AOAM5318v0Jk2Z3AcspjbY/ktYddmgPykukKRrw5WDcg+TDAkbAcYy2L
        C0sCwCt9/I13XaAmBN6kz5hmth77c3g=
X-Google-Smtp-Source: ABdhPJwsKUI//TxdSxeSc/yK/KKmzPSRo5EVUHAl2/DzC7C1HtHBHZa+egn58+RW04ellvfdKUuEiA==
X-Received: by 2002:a05:600c:24c:: with SMTP id 12mr14809098wmj.124.1637455624820;
        Sat, 20 Nov 2021 16:47:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k15sm4139988wrx.53.2021.11.20.16.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 16:47:04 -0800 (PST)
Message-Id: <8a69d2878c99e1b9321e57073d266cf797dc5630.1637455620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Nov 2021 00:46:57 +0000
Subject: [PATCH 5/8] symlinks: do not include current working directory in dir
 removal
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

symlinks has a pair of schedule_dir_for_removal() and
remove_scheduled_dirs() functions that ensure that directories made
empty by removing other files also themselves get removed.  However, we
want to exclude the current working directory and leave it around so
that subsequent git commands (and non-git commands) that the user runs
afterwards don't cause the user to get confused.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 symlinks.c           | 12 +++++++++++-
 t/t2501-cwd-empty.sh | 12 ++++++------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 5232d02020c..84622bedcde 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -275,11 +275,18 @@ static int threaded_has_dirs_only_path(struct cache_def *cache, const char *name
 
 static struct strbuf removal = STRBUF_INIT;
 
+static int cant_remove(char *dirname)
+{
+	if (the_cwd && !strcmp(dirname, the_cwd))
+		return 1;
+	return rmdir(dirname);
+}
+
 static void do_remove_scheduled_dirs(int new_len)
 {
 	while (removal.len > new_len) {
 		removal.buf[removal.len] = '\0';
-		if (rmdir(removal.buf))
+		if (cant_remove(removal.buf))
 			break;
 		do {
 			removal.len--;
@@ -293,6 +300,9 @@ void schedule_dir_for_removal(const char *name, int len)
 {
 	int match_len, last_slash, i, previous_slash;
 
+	if (the_cwd && !strcmp(name, the_cwd))
+		return;	/* Do not remove the current working directory */
+
 	match_len = last_slash = i =
 		longest_path_match(name, len, removal.buf, removal.len,
 				   &previous_slash);
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 526d8ec2ee3..b92e1a9bb16 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -24,7 +24,7 @@ test_expect_success setup '
 	git commit -m dirORfile
 '
 
-test_expect_failure 'checkout does not clean cwd incidentally' '
+test_expect_success 'checkout does not clean cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_path_is_dir foo/bar &&
 
@@ -53,7 +53,7 @@ test_expect_success 'checkout fails if cwd needs to be removed' '
 	test_path_is_dir dirORfile
 '
 
-test_expect_failure 'reset --hard does not clean cwd incidentally' '
+test_expect_success 'reset --hard does not clean cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_path_is_dir foo/bar &&
 
@@ -82,7 +82,7 @@ test_expect_success 'reset --hard fails if cwd needs to be removed' '
 	test_path_is_dir dirORfile
 '
 
-test_expect_failure 'merge does not remove cwd incidentally' '
+test_expect_success 'merge does not remove cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -109,7 +109,7 @@ test_expect_success 'merge fails if cwd needs to be removed' '
 	test_path_is_dir dirORfile
 '
 
-test_expect_failure 'cherry-pick does not remove cwd incidentally' '
+test_expect_success 'cherry-pick does not remove cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -136,7 +136,7 @@ test_expect_success 'cherry-pick fails if cwd needs to be removed' '
 	test_path_is_dir dirORfile
 '
 
-test_expect_failure 'rebase does not remove cwd incidentally' '
+test_expect_success 'rebase does not remove cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -163,7 +163,7 @@ test_expect_success 'rebase fails if cwd needs to be removed' '
 	test_path_is_dir dirORfile
 '
 
-test_expect_failure 'revert does not remove cwd incidentally' '
+test_expect_success 'revert does not remove cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
-- 
gitgitgadget

