Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D85E61F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbeHIAkM (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:40:12 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:56019 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIAkL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:40:11 -0400
Received: by mail-oi0-f74.google.com with SMTP id u11-v6so3566161oif.22
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wWHy7aP0qZogJmz6HlqHLfSYoxW65BQ7w9uhrA17k5c=;
        b=B90kNGXuy98+sQBQi/fxuvVB7ocCqsXLW4YimgxzwWLRw0L29/CpUJZEXuivXSt51y
         q+idFsUo0d3RiodAVwafaIUIr2tSc+YeyNHGYy6haDA92z5f/K4v6VQqv2kGx2j6eg4y
         Rw3PrEsxY18GsZ4s3MlH6cFAYgsEhfyCFD255NGLYLx5pM3u5ddLc2+LAyIDlDjIdvcb
         Cy/6zFrWWAnZ69ycie0u0lWEUz/G9HikN/ymVbnabWlavrJ/4iJcCroJe/aefdmlZLBA
         pcs3uu0RohGMv+4d3liyLEQiN4s1a+1wGSS7PSRvjcG0MGAfb1IFZ1WqPuxk6XYMbj2S
         KFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wWHy7aP0qZogJmz6HlqHLfSYoxW65BQ7w9uhrA17k5c=;
        b=op5w2Q24HbYO4ipFSq9CGf9EihfbiEV78Hy683cNGCabhV/8wUGGlZO4UB9Dioljqn
         yLkl97Ldk/XArpvWcwXGCMO87H4GnVJJwqBMKwmL70ZL49JP7IECCN5RaIhQNHSJcIS9
         TlYQTt8nZdAnA+gvfuIjNPBK9f5TkLdOaLrCUomAjZLEtvD3IsMERZu7zLkrND9vl4Ww
         iJAveJrqTVzYyKfa3R75q4obeYos5Sbeep8HMOY+S9oZBptMOyduKZYajdTL7HdLJkOO
         wbY+3PknMJQwcsRNiUQEKDP+HCuIVKRkktls1k+HUD6q4fPC16YYAVgys+5qnXJMaVDo
         X+iQ==
X-Gm-Message-State: AOUpUlE8dDAj4rH2X0clammrajBbh0xpoHLvOx5/4riJmlOZdMCd2pSF
        Oiyd4vjixra24fAjTwoHlzacyO5Semb/R9wp/Z5yXj4iGKpn1XJuJO1HcOkjc/r6b6rmply+hHU
        aX31/iUrjUYGw/J9NhcMWGDrmMM9rq4edz7M88nnftJWuOp0ivliZm9LLC+by
X-Google-Smtp-Source: AA+uWPx3EMjePfBdGE/5lTwQZ+fu5R8ly9elF6cpz5fIPW4gK+H4H9QeVvkM2LhqmVt0BytPmkfuYLyMcG7M
X-Received: by 2002:aca:4dca:: with SMTP id a193-v6mr2726824oib.24.1533766710316;
 Wed, 08 Aug 2018 15:18:30 -0700 (PDT)
Date:   Wed,  8 Aug 2018 15:17:51 -0700
In-Reply-To: <20180808221752.195419-1-sbeller@google.com>
Message-Id: <20180808221752.195419-10-sbeller@google.com>
Mime-Version: 1.0
References: <20180808221752.195419-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 09/10] submodule: fetch in submodules git directory instead of
 in worktree
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch started as a refactoring to make 'get_next_submodule' more
readable, but upon doing so, I realized that git-fetch actually doesn't
need to be run in the worktree. So let's run it in the git dir instead.

That should pave the way towards fetching submodules that are currently
not checked out.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c                 | 43 ++++++++++++++++++++++++++-----------
 t/t5526-fetch-submodules.sh |  7 +++++-
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/submodule.c b/submodule.c
index 21757e32908..ec7ea6f8c2d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -481,6 +481,12 @@ void prepare_submodule_repo_env(struct argv_array *out)
 			 DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
+static void prepare_submodule_repo_env_in_gitdir(struct argv_array *out)
+{
+	prepare_submodule_repo_env_no_git_dir(out);
+	argv_array_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
+}
+
 /* Helper function to display the submodule header line prior to the full
  * summary output. If it can locate the submodule objects directory it will
  * attempt to lookup both the left and right commits and put them into the
@@ -1227,6 +1233,27 @@ static int get_fetch_recurse_config(const struct submodule *submodule,
 	return spf->default_option;
 }
 
+static const char *get_submodule_git_dir(struct repository *r, const char *path)
+{
+	struct repository subrepo;
+	const char *ret;
+
+	if (repo_submodule_init(&subrepo, r, path)) {
+		/* no entry in .gitmodules? */
+		struct strbuf gitdir = STRBUF_INIT;
+		strbuf_repo_worktree_path(&gitdir, r, "%s/.git", path);
+		if (repo_init(&subrepo, gitdir.buf, NULL)) {
+			strbuf_release(&gitdir);
+			return NULL;
+		}
+	}
+
+	ret = xstrdup(subrepo.gitdir);
+	repo_clear(&subrepo);
+
+	return ret;
+}
+
 static int get_next_submodule(struct child_process *cp,
 			      struct strbuf *err, void *data, void **task_cb)
 {
@@ -1234,8 +1261,6 @@ static int get_next_submodule(struct child_process *cp,
 	struct submodule_parallel_fetch *spf = data;
 
 	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
-		struct strbuf submodule_path = STRBUF_INIT;
-		struct strbuf submodule_git_dir = STRBUF_INIT;
 		struct strbuf submodule_prefix = STRBUF_INIT;
 		const struct cache_entry *ce = spf->r->index->cache[spf->count];
 		const char *git_dir, *default_argv;
@@ -1273,16 +1298,12 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 		}
 
-		strbuf_repo_worktree_path(&submodule_path, spf->r, "%s", ce->name);
-		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
 		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
-		git_dir = read_gitfile(submodule_git_dir.buf);
-		if (!git_dir)
-			git_dir = submodule_git_dir.buf;
-		if (is_directory(git_dir)) {
+		git_dir = get_submodule_git_dir(spf->r, ce->name);
+		if (git_dir) {
 			child_process_init(cp);
-			cp->dir = strbuf_detach(&submodule_path, NULL);
-			prepare_submodule_repo_env(&cp->env_array);
+			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+			cp->dir = git_dir;
 			cp->git_cmd = 1;
 			if (!spf->quiet)
 				strbuf_addf(err, "Fetching submodule %s%s\n",
@@ -1294,8 +1315,6 @@ static int get_next_submodule(struct child_process *cp,
 			argv_array_push(&cp->args, submodule_prefix.buf);
 			ret = 1;
 		}
-		strbuf_release(&submodule_path);
-		strbuf_release(&submodule_git_dir);
 		strbuf_release(&submodule_prefix);
 		if (ret) {
 			spf->count++;
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 0f730d77815..4437cb17698 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -567,7 +567,12 @@ test_expect_success 'fetching submodule into a broken repository' '
 
 	test_must_fail git -C dst status &&
 	test_must_fail git -C dst diff &&
-	test_must_fail git -C dst fetch --recurse-submodules
+
+	# git-fetch cannot find the git directory of the submodule,
+	# so it will do nothing, successfully, as it cannot distinguish between
+	# this broken submodule and a submodule that was just set active but
+	# not cloned yet
+	git -C dst fetch --recurse-submodules
 '
 
 test_expect_success "fetch new commits when submodule got renamed" '
-- 
2.18.0.597.ga71716f1ad-goog

