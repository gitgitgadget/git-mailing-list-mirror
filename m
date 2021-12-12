Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20529C433F5
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 20:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhLLUPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 15:15:04 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:37630 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhLLUOr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 15:14:47 -0500
Received: by mail-wr1-f54.google.com with SMTP id d9so23885974wrw.4
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 12:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=crvzi5MgDRQKaqvgUTxA/3FcxLa9nPBL9QF8SBCXNSo=;
        b=EFO7stsavzTNxo35EFocQm8r1LA1iVkRUZ4JVMp8mjACElmyp4Z0tfYLDJ31GriTIA
         bcRymyKs86IGA/rtxukw2V8V/w43BlTSIGhsrE/wzpoHWSimqbqZW1WhHaH8/TR8tZp3
         qUeBcgQxXJpJV2bFDgXyLjeyXu4TWI3ED8sa+4iIywwyRQXA6VIyAYoHG6ZRkHsBM17J
         WxLXr4sWYBDt8gQ8oI9cPp5Z9eQUEZ0jWt+4EDaSTK0V1nQtRwtgG1Ku/R721cz1gMO0
         QKVGAGqDH6KQc4l6cW9OnYNdbdgN4HUlN6J7fGzLwNLGd10agh6S61+AK6qyOjf8QW1J
         Hxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=crvzi5MgDRQKaqvgUTxA/3FcxLa9nPBL9QF8SBCXNSo=;
        b=tTI2GtEn0x02e/AG7YoLP24+7kGohvUcwvU9XNJxbqTixkuVFQjZflWhhoS8fuYkHT
         AmU2mu3akGMBrqvn7SjR3RNsZr2POmx+i7LZ5CYwDGujB+PU52hViGNsC10O9qHYvO40
         jbSPKKtl3AGHvtIm7OynSIR6Y1lDcukpmnwyhuxtMtfs77LQA2w2PfQGxAc+RUT7A32/
         R45A7DPgq/SeWupQgtcLSsSR+W2BPmZO8dqVC+DS8w1rjN/YVNhJRJIgESgsxZqvUcO+
         wTv+EpjB1tqK/Vo/Pvrqrz53hcyWm3lChLIr4nwH4/O9d2cHvtW9KaV+DEeXinRABkEk
         vCMg==
X-Gm-Message-State: AOAM533c7zTLmXNa8sY37tfNNbpVpUQQtThgB1Bk++sCRj5pqjHuMoQa
        FD5v0h7O70Sa4fg3GWlBGnO1KYeU2r6+hg==
X-Google-Smtp-Source: ABdhPJx61VHttf37GoZc+RBe6iHRca2xQoBB+CT5JsGbxmLHEzlvRMYx4dyN/jNtoo625M59iiHlzA==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr26619671wrn.349.1639340025827;
        Sun, 12 Dec 2021 12:13:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay21sm4824336wmb.7.2021.12.12.12.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:13:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/13] tests: don't depend on template-created .git/hooks
Date:   Sun, 12 Dec 2021 21:13:23 +0100
Message-Id: <patch-13.13-d021a5981a1-20211212T201308Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gb1392dd1877
In-Reply-To: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "write_hook" wrapper to implicitly "mkdir -p
.git/hooks" (or equivalent), and stop having copy_templates() make the
"hooks" directory. One test in "t5516-fetch-push.sh" won't need to
move our hooks out of the way anymore.

As with a preceding change to drop the dependency on the
template-created "branches" we can now stop depending on the template
having created the "hooks" directory for us.

Since this was the last special-case handled by the
"lazy_mkdir_strbuf_or_die_setlen()" function added earlier in this
series we can remove that special-case and the
"GIT_TEST_BARE_TEMPLATE" handling.

The choice to not use "mkdir -p" in "write_hook" is deliberate. We're
being a bit stricter in not potentially creating N leading
directories, but also not failing on the second "write_hook"
invocation in a repository as a simple "mkdir" without "-p" would.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/init-db.c           | 39 +------------------------------------
 t/t5516-fetch-push.sh       |  4 +---
 t/t7450-bad-git-dotfiles.sh |  1 +
 t/test-lib-functions.sh     |  4 ++++
 t/test-lib.sh               |  3 +--
 5 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 3700a6b854e..0301b8f613e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -93,36 +93,10 @@ static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
 	}
 }
 
-static void lazy_mkdir_strbuf_or_die_setlen(struct strbuf *path, size_t oldlen,
-					    const char *dir)
-{
-	strbuf_addstr(path, dir);
-	if (mkdir(path->buf, 0777) < 0) {
-		int saved_errno = errno;
-		struct stat st;
-
-		/*
-		 * Unfortunately there's no EEXIST_{DIR,FILE}, and
-		 * we'd like to pass these only if the path is already
-		 * what we want it to be, not if it's a normal.
-		 */
-		if (lstat(path->buf, &st))
-			die_errno(_("cannot stat '%s'"), path->buf);
-		else if (S_ISDIR(st.st_mode))
-			goto cleanup;
-
-		errno = saved_errno;
-		die_errno(_("cannot mkdir '%s'"), path->buf);
-	}
-cleanup:
-	strbuf_setlen(path, oldlen);
-}
-
 static void copy_templates(int no_template, const char *template_dir,
 			   const char *init_template_dir)
 {
 	struct strbuf path = STRBUF_INIT;
-	size_t len;
 	struct strbuf template_path = STRBUF_INIT;
 	size_t template_len;
 	struct repository_format template_format = REPOSITORY_FORMAT_INIT;
@@ -134,7 +108,7 @@ static void copy_templates(int no_template, const char *template_dir,
 		return;
 	if (!template_dir && !init_template_dir &&
 	    git_env_bool(GIT_NO_TEMPLATE_DIR_ENVIRONMENT, 0))
-		goto no_template;
+		return;
 	if (!template_dir)
 		template_dir = getenv(TEMPLATE_DIR_ENVIRONMENT);
 	if (!template_dir)
@@ -184,17 +158,6 @@ static void copy_templates(int no_template, const char *template_dir,
 	strbuf_release(&template_path);
 	clear_repository_format(&template_format);
 	return;
-no_template:
-	if (!git_env_bool("GIT_TEST_BARE_TEMPLATE", 0))
-		return;
-
-	strbuf_addstr(&path, get_git_common_dir());
-	strbuf_complete(&path, '/');
-	len = path.len;
-
-	lazy_mkdir_strbuf_or_die_setlen(&path, len, "hooks");
-
-	strbuf_release(&path);
 }
 
 /*
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index fd355ae48c6..20677c84117 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -28,8 +28,7 @@ mk_empty () {
 	(
 		cd "$repo_name" &&
 		git init &&
-		git config receive.denyCurrentBranch warn &&
-		mv .git/hooks .git/hooks-disabled
+		git config receive.denyCurrentBranch warn
 	)
 }
 
@@ -61,7 +60,6 @@ mk_test_with_hooks() {
 	mk_test "$@" &&
 	(
 		cd "$repo_name" &&
-		mkdir .git/hooks &&
 
 		write_hook pre-receive <<-'EOF' &&
 		cat - >>pre-receive.actual
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 41706c1c9ff..425440d40b7 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -54,6 +54,7 @@ test_expect_success 'add evil submodule' '
 
 	mkdir modules &&
 	cp -r .git/modules/evil modules &&
+	mkdir modules/evil/hooks &&
 	write_script modules/evil/hooks/post-checkout <<-\EOF &&
 	echo >&2 "RUNNING POST CHECKOUT"
 	EOF
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 3786d39ccab..75fa312f3e9 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -573,6 +573,10 @@ write_hook () {
 	done &&
 	git_dir=$(git -C "$indir" rev-parse --absolute-git-dir) &&
 	hook_dir="$git_dir/hooks" &&
+	if ! test -d "$hook_dir"
+	then
+		mkdir "$hook_dir"
+	fi &&
 	hook_file="$hook_dir/$1"
 	write_script "$hook_file"
 }
diff --git a/t/test-lib.sh b/t/test-lib.sh
index bd09d691da3..3abd51464e6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1356,8 +1356,7 @@ else # normal case, use ../bin-wrappers only unless $with_dashes:
 	fi
 fi
 GIT_NO_TEMPLATE_DIR=true
-GIT_TEST_BARE_TEMPLATE=true
-export GIT_NO_TEMPLATE_DIR GIT_TEST_BARE_TEMPLATE
+export GIT_NO_TEMPLATE_DIR
 GIT_CONFIG_NOSYSTEM=1
 GIT_ATTR_NOSYSTEM=1
 GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/.."
-- 
2.34.1.1020.gb1392dd1877

