Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAC2C433EF
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 20:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhLLUOy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 15:14:54 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:37608 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhLLUOk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 15:14:40 -0500
Received: by mail-wr1-f41.google.com with SMTP id d9so23885682wrw.4
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 12:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Hb9sZG/7rV8eqrc9iMSGGoFJgWWBwIkeu/72xJFOAo=;
        b=ASpAzVBm+Lr37Ddfazvu+/6N18qfWYnlCcF56HfYGarNELXuiZHxUOiRkGRw3Er9OD
         BJ8evdlKg6zXUwf8zZ9Xsl335leqEMzEHQ9FLh69WTHa/qeGj9n7waCH/gZpP0g4oDNm
         VnbO4j9updQpcb6LYgy6+vaD/o0fx0WYAv3P/jDezSJbKS2Y5nzkFwkDBK/f3pStRUv2
         FixwXoN5OAnucULKyjPtWdG94ZnnWG5VVBr/vbw2oN+5FiHZCddESV555YokzEU9d72/
         SaWieSiAxMtbieKZiaveojTnoZI07C+cgaAxfuuGGubEHRz0HZUcQSQzHdNRFJiYcZrx
         EtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Hb9sZG/7rV8eqrc9iMSGGoFJgWWBwIkeu/72xJFOAo=;
        b=eNCs1Xk2atH2ZFzsrSIX7qk4wT/zXK35FsDs/ojMiLgP71CMAd6RLcF30GISrTpTbX
         X8eOyRXzGkWhzWa2yQ1vOJufGribiwaMO68tBV9eAB8SzZR6F7260Mg0PVTDg0gznrGB
         byEaRDq/2kFdca/X9UXwRoYpTb+Ji33/m6tUblGq3bal6qRBy2oljH3UmmtaBKuR8lgn
         dhbFHkrGG1pLlddKH7wZjwywj71DU7hK1u0bHyyTj1D/zAiOxYhi0c2ARG8tF1gu2Lhv
         /j2X/DPmKdrgkDXoYHc7l6q6avSjCRG22UaUFZrl3R6hRqmWuvZIh3AzBgNftpktqQOx
         HqZQ==
X-Gm-Message-State: AOAM5317NVGuOO8rgSfPLrpBksxS8sWQm8k3D5lNoijdVKPgLjYA0raG
        Wn0OHaXo5CSi6M0X0K8Jl5iuSxrxi5R2kg==
X-Google-Smtp-Source: ABdhPJw+7WBPwI2H0hzPlpFE6N0+ZzmGylDIIGqR3OBFtPEy/WTEp48plu+LlwxoVZsPMNCVE7VJdA==
X-Received: by 2002:a05:6000:15cd:: with SMTP id y13mr11843410wry.605.1639340019319;
        Sun, 12 Dec 2021 12:13:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay21sm4824336wmb.7.2021.12.12.12.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:13:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/13] test-lib: create test data with "git init --no-template" (almost)
Date:   Sun, 12 Dec 2021 21:13:17 +0100
Message-Id: <patch-07.13-9402fb23b40-20211212T201308Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gb1392dd1877
In-Reply-To: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change "t/test-lib.sh" to set the newly added
"GIT_NO_TEMPLATE_DIR=true" option in the environment, which makes any
"git init" invocation take the equivalent of a "--no-template" option,
unless explicitly overridden by config or CLI option.

Well, "almost". We're also adding a test-only
"GIT_TEST_BARE_TEMPLATE=true", when it's set we'll interpret
"GIT_NO_TEMPLATE_DIR=true" as meaning no template, except for empty
"hooks" and "branches" directories.

This is because we've added various implicit dependencies on having
these created by "git init". In subsequent commits we'll address some
of those. More on that below.

The code being added here in "builtin/init-db.c" doesn't require
careful review, since this lazy_mkdir_strbuf_or_die_setlen() function
and the "no_template" condition will be gone in a few commits as we
fix up a few tests to create their own "hooks" and "branches"
directories.

This change reduces the I/O the test suite generates by quite a
bit. Before this running it with --debug (so that trash is retained)
results in ~770MB of trash* (according to "du -shc"), after it's
reduced to around 590M, so almost 1/4 bytes we wrote were the same
sample hooks and other repetitive data. The number of files created
went down from ~151k to ~110k, which around the same reduction
of (more than) 1/4.

This will also make our tests more reliable as we're now forced to
check whether our software works with any arbitrary --template that
may be in use in the wild, as opposed to our relatively "fat" current
default.

On the "more on that below", these are the directories we're
creating (only in the test suite) for now:

- "hooks": Removing it will be relatively simple, mostly a matter of a
  few tests needing a "mkdir .git/hooks", or the tests assume that
  they'll need to explicitly disable .git/hooks.

- "branches": Similarly trivial. The last attempt to get rid of it was
  aborted in c8a58ac5a52 (Revert "Don't create the $GIT_DIR/branches
  directory on init", 2009-10-31), but only a couple of tests files
  depend on it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/init-db.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 t/t0001-init.sh   | 19 ++++++++-----------
 t/test-lib.sh     |  6 ++++--
 wrap-for-bin.sh   |  4 +---
 4 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index fcf538193c8..8dddb47bdc4 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -93,10 +93,36 @@ static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
 	}
 }
 
+static void lazy_mkdir_strbuf_or_die_setlen(struct strbuf *path, size_t oldlen,
+					    const char *dir)
+{
+	strbuf_addstr(path, dir);
+	if (mkdir(path->buf, 0777) < 0) {
+		int saved_errno = errno;
+		struct stat st;
+
+		/*
+		 * Unfortunately there's no EEXIST_{DIR,FILE}, and
+		 * we'd like to pass these only if the path is already
+		 * what we want it to be, not if it's a normal.
+		 */
+		if (lstat(path->buf, &st))
+			die_errno(_("cannot stat '%s'"), path->buf);
+		else if (S_ISDIR(st.st_mode))
+			goto cleanup;
+
+		errno = saved_errno;
+		die_errno(_("cannot mkdir '%s'"), path->buf);
+	}
+cleanup:
+	strbuf_setlen(path, oldlen);
+}
+
 static void copy_templates(int no_template, const char *template_dir,
 			   const char *init_template_dir)
 {
 	struct strbuf path = STRBUF_INIT;
+	size_t len;
 	struct strbuf template_path = STRBUF_INIT;
 	size_t template_len;
 	struct repository_format template_format = REPOSITORY_FORMAT_INIT;
@@ -108,7 +134,7 @@ static void copy_templates(int no_template, const char *template_dir,
 		return;
 	if (!template_dir && !init_template_dir &&
 	    git_env_bool(GIT_NO_TEMPLATE_DIR_ENVIRONMENT, 0))
-		return;
+		goto no_template;
 	if (!template_dir)
 		template_dir = getenv(TEMPLATE_DIR_ENVIRONMENT);
 	if (!template_dir)
@@ -157,6 +183,19 @@ static void copy_templates(int no_template, const char *template_dir,
 	strbuf_release(&path);
 	strbuf_release(&template_path);
 	clear_repository_format(&template_format);
+	return;
+no_template:
+	if (!git_env_bool("GIT_TEST_BARE_TEMPLATE", 0))
+		return;
+
+	strbuf_addstr(&path, get_git_common_dir());
+	strbuf_complete(&path, '/');
+	len = path.len;
+
+	lazy_mkdir_strbuf_or_die_setlen(&path, len, "hooks");
+	lazy_mkdir_strbuf_or_die_setlen(&path, len, "branches");
+
+	strbuf_release(&path);
 }
 
 /*
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 39cf132e9a0..a91de28aadc 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -235,7 +235,7 @@ test_expect_success 'init with --template' '
 
 test_expect_success 'init with --template (blank)' '
 	git init template-plain &&
-	test_path_is_file template-plain/.git/info/exclude &&
+	test_path_is_dir template-plain/.git/info &&
 	git init --template= template-blank &&
 	test_path_is_missing template-blank/.git/info/exclude
 '
@@ -246,19 +246,12 @@ no_templatedir_env () {
 	export NO_SET_GIT_TEMPLATE_DIR
 }
 
-init_no_templatedir_env () {
-	(
-		no_templatedir_env &&
-		git init "$1"
-	)
-}
-
 test_expect_success 'init with init.templatedir set' '
 	mkdir templatedir-source &&
 	echo Content >templatedir-source/file &&
 	test_config_global init.templatedir "${HOME}/templatedir-source" &&
 
-	init_no_templatedir_env templatedir-set &&
+	git init templatedir-set &&
 	test_cmp templatedir-source/file templatedir-set/.git/file
 '
 
@@ -267,7 +260,7 @@ test_expect_success 'init with init.templatedir using ~ expansion' '
 	echo Content >templatedir-source/file &&
 	test_config_global init.templatedir "~/templatedir-source" &&
 
-	init_no_templatedir_env templatedir-expansion &&
+	git init templatedir-expansion &&
 	test_cmp templatedir-source/file templatedir-expansion/.git/file
 '
 
@@ -563,15 +556,19 @@ test_expect_success 'remote init from does not use config from cwd' '
 '
 
 test_expect_success 're-init from a linked worktree' '
-	git init main-worktree &&
 	(
+		git init main-worktree &&
+
 		cd main-worktree &&
 		test_commit first &&
 		git worktree add ../linked-worktree &&
+		>empty &&
+		cp empty .git/info/exclude &&
 		mv .git/info/exclude expected-exclude &&
 		cp .git/config expected-config &&
 		find .git/worktrees -print | sort >expected &&
 		git -C ../linked-worktree init &&
+		cp empty .git/info/exclude &&
 		test_cmp expected-exclude .git/info/exclude &&
 		test_cmp expected-config .git/config &&
 		find .git/worktrees -print | sort >actual &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 57efcc5e97a..bd09d691da3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1355,11 +1355,13 @@ else # normal case, use ../bin-wrappers only unless $with_dashes:
 		PATH="$GIT_BUILD_DIR:$GIT_BUILD_DIR/t/helper:$PATH"
 	fi
 fi
-GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
+GIT_NO_TEMPLATE_DIR=true
+GIT_TEST_BARE_TEMPLATE=true
+export GIT_NO_TEMPLATE_DIR GIT_TEST_BARE_TEMPLATE
 GIT_CONFIG_NOSYSTEM=1
 GIT_ATTR_NOSYSTEM=1
 GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/.."
-export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM GIT_CEILING_DIRECTORIES
+export PATH GIT_EXEC_PATH GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM GIT_CEILING_DIRECTORIES
 
 if test -z "$GIT_TEST_CMP"
 then
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index 95851b85b6b..26efe0b60ac 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -7,10 +7,8 @@
 # @@BUILD_DIR@@ and @@PROG@@.
 
 GIT_EXEC_PATH='@@BUILD_DIR@@'
-if test -n "$NO_SET_GIT_TEMPLATE_DIR"
+if test -z "$GIT_TEMPLATE_DIR" && test -z "$GIT_NO_TEMPLATE_DIR"
 then
-	unset GIT_TEMPLATE_DIR
-else
 	GIT_TEMPLATE_DIR='@@BUILD_DIR@@/templates/blt'
 	export GIT_TEMPLATE_DIR
 fi
-- 
2.34.1.1020.gb1392dd1877

