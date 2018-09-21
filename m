Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 963C01F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeIVE1r (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:27:47 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:45940 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbeIVE1r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 00:27:47 -0400
Received: by mail-qk1-f201.google.com with SMTP id d194-v6so14237331qkb.12
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 15:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=foxYFSc8HbnA0pX8j2OReCVPNgnCu5bvkqDoawxm18s=;
        b=T5WAELPlxu1KptWdkDjxP0g8ZY/UVurfTIAMdsl4PR8zu3IYm44nnc1HmooDLRWd1j
         ruNiqNCn3jzz+Rw6Q6GpF90cYdACk4J3I68jnnwLhdFvndCnAXNaKosdbdpJ5/K9EElu
         BW+8bqXE7CFRgEBedFWmOcsrzh0ISM/U0+EWJ6Hlv6YH9tY9YNQvvp9XUKi0rMtmRlEO
         rc/SECI/63h/XQkEh5c49Vtq+ChujR8x0tEhQQ0vGnIDykW5IN44z5HLJZ0R30ufVLWX
         jX3PqSSWlxuH/nuw5XIGvsTTGAwqHRGeVh2Pf4gPJ8nb1Lmu71N5Gn5VnZwDGKUgA94n
         6nEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=foxYFSc8HbnA0pX8j2OReCVPNgnCu5bvkqDoawxm18s=;
        b=dCmGVgyrenSAvgWpFloET0eDk/xClua+WyY0l7cMOk4NDUOvvIoSr1ESwnElKYcwOm
         3vrtbJcM/ZjwQj8syPuxSTkLYF4gXVcSxiWRx1Q/4k8ZVptBiSRK5GpSssNJRKCs6dWY
         V7AKhGi6Vy6DAf/1BPTiJ0NYCTkWHVoFbi317bBJN3VY+lSIzn2KaF+pKSCk1tAwK4yd
         tytyFZiO45HLXSIB5EDCMFS15OpkiuvohRH4NPWU88GX0+l1afJNXYCcy0CfwFQCYkSC
         +G4egw31SHocvOgtprwc7RKQAtZUDLBFgEw5ERb2VLvKoeYR/91yDe12yR8R6adWyA3I
         X6Vw==
X-Gm-Message-State: ABuFfoitnaZ1EgpseraceZtWS7ZvfOPBPEK0IUeQjtWdiO6ajsQurSiH
        MtFJFxZMvBYLzD7+v4cn4zJ4qX2SJWYFzx3hYrEj1dW6KPfqH6LLSFFzM5UxPQQ02tHzzNu5WsU
        GHUsoG28Tu4dUfTd3SN4bibSutAW3jwdKPgnGpgHSlDD9NIUlGurSnWG70iyY
X-Google-Smtp-Source: ACcGV63PzMkdpyzO7jilf6GaAMNMExGnXmS20gOI4Ebfk8jNzLGRVvWpPcZMk1k77+m93qP0DK4WCCI+U8vf
X-Received: by 2002:a0c:d892:: with SMTP id q18-v6mr2022706qvj.43.1537569410146;
 Fri, 21 Sep 2018 15:36:50 -0700 (PDT)
Date:   Fri, 21 Sep 2018 15:35:56 -0700
In-Reply-To: <20180921223558.65055-1-sbeller@google.com>
Message-Id: <20180921223558.65055-7-sbeller@google.com>
Mime-Version: 1.0
References: <20180921223558.65055-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 6/8] submodule: fetch in submodules git directory instead of
 in worktree
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch started as a refactoring to make 'get_next_submodule' more
readable, but upon doing so, I realized that "git fetch" of the submodule
actually doesn't need to be run in the submodules worktree. So let's run
it in its git dir instead.

That should pave the way towards fetching submodules that are currently
not checked out.

This patch leaks the cp->dir in get_next_submodule, as any further
callback in run_processes_parallel doesn't have access to the child
process any more. In an early iteration of this patch, the function
get_submodule_repo_for directly returned the string containing the
git directory, which would be a better design choice for this patch.

However the next patch both fixes the memory leak of cp->dir and also has
a use case for using the full repository handle of the submodule, so
it makes sense to introduce the get_submodule_repo_for here already.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c                 | 47 +++++++++++++++++++++++++++----------
 t/t5526-fetch-submodules.sh |  7 +++++-
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/submodule.c b/submodule.c
index 209680ec076..8829e8d4eff 100644
--- a/submodule.c
+++ b/submodule.c
@@ -482,6 +482,12 @@ void prepare_submodule_repo_env(struct argv_array *out)
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
@@ -1228,6 +1234,25 @@ static int get_fetch_recurse_config(const struct submodule *submodule,
 	return spf->default_option;
 }
 
+static struct repository *get_submodule_repo_for(struct repository *r,
+						 const char *path)
+{
+	struct repository *ret = xmalloc(sizeof(*ret));
+
+	if (repo_submodule_init(ret, r, path)) {
+		/* no entry in .gitmodules? */
+		struct strbuf gitdir = STRBUF_INIT;
+		strbuf_repo_worktree_path(&gitdir, r, "%s/.git", path);
+		if (repo_init(ret, gitdir.buf, NULL)) {
+			strbuf_release(&gitdir);
+			return NULL;
+		}
+		strbuf_release(&gitdir);
+	}
+
+	return ret;
+}
+
 static int get_next_submodule(struct child_process *cp,
 			      struct strbuf *err, void *data, void **task_cb)
 {
@@ -1235,12 +1260,11 @@ static int get_next_submodule(struct child_process *cp,
 	struct submodule_parallel_fetch *spf = data;
 
 	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
-		struct strbuf submodule_path = STRBUF_INIT;
-		struct strbuf submodule_git_dir = STRBUF_INIT;
 		struct strbuf submodule_prefix = STRBUF_INIT;
 		const struct cache_entry *ce = spf->r->index->cache[spf->count];
-		const char *git_dir, *default_argv;
+		const char *default_argv;
 		const struct submodule *submodule;
+		struct repository *repo;
 		struct submodule default_submodule = SUBMODULE_INIT;
 
 		if (!S_ISGITLINK(ce->ce_mode))
@@ -1275,16 +1299,12 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 		}
 
-		strbuf_repo_worktree_path(&submodule_path, spf->r, "%s", ce->name);
-		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
 		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
-		git_dir = read_gitfile(submodule_git_dir.buf);
-		if (!git_dir)
-			git_dir = submodule_git_dir.buf;
-		if (is_directory(git_dir)) {
+		repo = get_submodule_repo_for(spf->r, ce->name);
+		if (repo) {
 			child_process_init(cp);
-			cp->dir = strbuf_detach(&submodule_path, NULL);
-			prepare_submodule_repo_env(&cp->env_array);
+			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+			cp->dir = xstrdup(repo->gitdir);
 			cp->git_cmd = 1;
 			if (!spf->quiet)
 				strbuf_addf(err, "Fetching submodule %s%s\n",
@@ -1294,10 +1314,11 @@ static int get_next_submodule(struct child_process *cp,
 			argv_array_push(&cp->args, default_argv);
 			argv_array_push(&cp->args, "--submodule-prefix");
 			argv_array_push(&cp->args, submodule_prefix.buf);
+
+			repo_clear(repo);
+			free(repo);
 			ret = 1;
 		}
-		strbuf_release(&submodule_path);
-		strbuf_release(&submodule_git_dir);
 		strbuf_release(&submodule_prefix);
 		if (ret) {
 			spf->count++;
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 6c2f9b2ba26..42692219a1a 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -566,7 +566,12 @@ test_expect_success 'fetching submodule into a broken repository' '
 
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
2.19.0.444.g18242da7ef-goog

