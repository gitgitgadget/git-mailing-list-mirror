Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F706C678D4
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 22:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCBWDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 17:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCBWDb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 17:03:31 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F4A5942B
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 14:03:07 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id s21-20020a632155000000b004fc1f5c8a4dso98885pgm.11
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 14:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RVcHRxuNeHDNfJVOwxlgeyrSJLnyl430+ZUW4qkzWu8=;
        b=YWTLwywQ8hmVaq3dZ+pyQUDBX1Vqo9QRv13ZzLZQ+Z19W6aAt3XEIsIAr4ro+I6G4f
         D4mdgfgITnjmq4OLHOGai5Wq56OwZD0MaYHWLc+Av+eK+MCnmqPs0HAxBo2liIcMRa07
         UyUQO44LlZhO2ys6t7+ylB5g3qCEoQiogJruWD82C8L0ZwG4luh5XdjHQXNxKM4ylkUd
         8nRvMBLGy6+Qi7RA+BU4F3Vg2uKlaG4/t/VITYebT102sNhPRc1SfRiiDA4rKAkukVmA
         i654W2tP2ljOLJOUJjjvPMNaDIf0wdIKLrwS1ycIdjkeyQbOYDp2UkOa6x98Wa+rp61Y
         TyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVcHRxuNeHDNfJVOwxlgeyrSJLnyl430+ZUW4qkzWu8=;
        b=At5oVQo1MkaRnPywrDCe1dL9Lazy0wvWuZguZt4e5320JdqdKlYSb7eSE5nluA/5pq
         GzmrdYzLkWl8AOYT7Be68wAWgfVJTM5PXO8XXhaQTy3I6Sq0mLvfRTlW/nHAzq839GRn
         TgJM/p5/m5Upx6ssx0kfMnnJeN+SrbQj7WKAVr1Ry8I+Bsof4jrgtp6XpqyEtYWvqjjU
         ttDb+0GYNSyVW1ygInrOgppIj9O0e0j44IutYFGuOuUn7STnRBIlBAG8gbz74zAT5IwP
         0DPx3TJxKVCxInhcpVkbnsHwsdIj8SiaYBgAg+iQZCla6sp/jy07nfoDFrqP5r1IFCAU
         BSmQ==
X-Gm-Message-State: AO0yUKXMw2Om8MZ7w+uGQGLbGyg+ZbigCi4MbReSVW4vCJU45cOXReR8
        mSJdViQcErXewe2qJFki62hau0zEcW8OsOqs0IOskYLUCmSF1BRCsw6NTzzI3dMdaZ8ram36kvw
        40hQ9eXdQ2LGzgX0kCL30jBR5Sttxcsy+tbOu5RJKiheQvBOmF5yro9c+T9hl4iHTQA==
X-Google-Smtp-Source: AK7set/7VSfxIxjtbPHxwH3p3n6nrbgFLzKLnzIJDWPi1A0Dwh9gTQKN5jHYxC4MRj+UvpyypIQeoZRwHZ7ogbU=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:788c:0:b0:503:20b9:5d88 with SMTP id
 t134-20020a63788c000000b0050320b95d88mr3932945pgc.4.1677794584449; Thu, 02
 Mar 2023 14:03:04 -0800 (PST)
Date:   Thu,  2 Mar 2023 22:02:49 +0000
In-Reply-To: <20230302215237.1473444-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230209000212.1892457-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230302220251.1474923-4-calvinwan@google.com>
Subject: [PATCH v9 4/6] submodule: refactor is_submodule_modified()
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor out submodule status logic and error messages that will be
used in a future patch.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule.c | 65 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/submodule.c b/submodule.c
index 768d4b4cd7..426074cebb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -28,6 +28,10 @@ static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static int initialized_fetch_ref_tips;
 static struct oid_array ref_tips_before_fetch;
 static struct oid_array ref_tips_after_fetch;
+#define STATUS_PORCELAIN_START_ERROR \
+	N_("could not run 'git status --porcelain=2' in submodule %s")
+#define STATUS_PORCELAIN_FAIL_ERROR \
+	N_("'git status --porcelain=2' failed in submodule %s")
 
 /*
  * Check if the .gitmodules file is unmerged. Parsing of the .gitmodules file
@@ -1870,6 +1874,40 @@ int fetch_submodules(struct repository *r,
 	return spf.result;
 }
 
+static int verify_submodule_git_directory(const char *path)
+{
+	const char *git_dir;
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "%s/.git", path);
+	git_dir = read_gitfile(buf.buf);
+	if (!git_dir)
+		git_dir = buf.buf;
+	if (!is_git_directory(git_dir)) {
+		if (is_directory(git_dir))
+			die(_("'%s' not recognized as a git repository"), git_dir);
+		strbuf_release(&buf);
+		/* The submodule is not checked out, so it is not modified */
+		return 0;
+	}
+	strbuf_release(&buf);
+	return 1;
+}
+
+static void prepare_status_porcelain(struct child_process *cp,
+			     const char *path, int ignore_untracked)
+{
+	strvec_pushl(&cp->args, "status", "--porcelain=2", NULL);
+	if (ignore_untracked)
+		strvec_push(&cp->args, "-uno");
+
+	prepare_submodule_repo_env(&cp->env);
+	cp->git_cmd = 1;
+	cp->no_stdin = 1;
+	cp->out = -1;
+	cp->dir = path;
+}
+
 static int parse_status_porcelain(char *str, size_t len,
 				  unsigned *dirty_submodule,
 				  int ignore_untracked)
@@ -1915,33 +1953,14 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	struct strbuf buf = STRBUF_INIT;
 	FILE *fp;
 	unsigned dirty_submodule = 0;
-	const char *git_dir;
 	int ignore_cp_exit_code = 0;
 
-	strbuf_addf(&buf, "%s/.git", path);
-	git_dir = read_gitfile(buf.buf);
-	if (!git_dir)
-		git_dir = buf.buf;
-	if (!is_git_directory(git_dir)) {
-		if (is_directory(git_dir))
-			die(_("'%s' not recognized as a git repository"), git_dir);
-		strbuf_release(&buf);
-		/* The submodule is not checked out, so it is not modified */
+	if (!verify_submodule_git_directory(path))
 		return 0;
-	}
-	strbuf_reset(&buf);
-
-	strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
-	if (ignore_untracked)
-		strvec_push(&cp.args, "-uno");
 
-	prepare_submodule_repo_env(&cp.env);
-	cp.git_cmd = 1;
-	cp.no_stdin = 1;
-	cp.out = -1;
-	cp.dir = path;
+	prepare_status_porcelain(&cp, path, ignore_untracked);
 	if (start_command(&cp))
-		die(_("Could not run 'git status --porcelain=2' in submodule %s"), path);
+		die(_(STATUS_PORCELAIN_START_ERROR), path);
 
 	fp = xfdopen(cp.out, "r");
 	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
@@ -1956,7 +1975,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	fclose(fp);
 
 	if (finish_command(&cp) && !ignore_cp_exit_code)
-		die(_("'git status --porcelain=2' failed in submodule %s"), path);
+		die(_(STATUS_PORCELAIN_FAIL_ERROR), path);
 
 	strbuf_release(&buf);
 	return dirty_submodule;
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

