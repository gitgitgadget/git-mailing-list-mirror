Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D921F1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbeJKFOx (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:14:53 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:55028 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeJKFOx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:14:53 -0400
Received: by mail-qt1-f202.google.com with SMTP id i64-v6so6606152qtb.21
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5j5hT2IBgig73JxDXYFZtw/2y/EKtMsQ1QXXNgx+0qg=;
        b=RBatzevfjUiZSYPfXjmotUSJgw9M0qBRnuM+1vrX2VgxuXRDqCwtNgCCczBvyoNbWe
         /vMcoxbnR8VNZ8oPsi1oRdimImVux2X/ZDoMalNveOrRmKbeGwz+4XuS4DmGjAz79B29
         j7Da/YB7O+x+TNoPusAkLWPzUs8yow4skJLr7W/SP7LJGe9Pi0ZQ8Twz3CESlXKhDriH
         qu44mhcaZ3yeAmXfLhFP6nx6ePYBIAdfr5PBn6WGKNeyBRGHLW37FpaMtsf/2Cx+eGfM
         VnIOcn6mUoHtgsX7Y9v1vmLxTUxAPgEiU+kNNKJzCbXqvFCevxbaoGhSNCDP651TOlCt
         Zb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5j5hT2IBgig73JxDXYFZtw/2y/EKtMsQ1QXXNgx+0qg=;
        b=bIZFupZ1fCa0uISNMjWFkdLkjhrdAlwzSr29kTNnvzrqMp/Uo8QW3X9sSRSSnlU7Md
         bzoto0XrLNwmFK++PcZIiDeKNrOnkdVVdZVFd8JWmYCv7XcEMblJCgOLJC/Trv0zQSYi
         yHjakIZFB5OI3hSsBZ7oCFPiEZAfnKFz9PYse6dPNT0xy4sjjdLsNOxZNv3spt3y/r3n
         QUwmmc/oQlvA3O7Npt/loKse7Nlsph27BvLEsulhmrpRJQFU3He7RYJCKnPU9N2qN8qG
         rI1R11RFMDkg40c1mwqud246nYMHl+UYTeK7LNhssT8Nbwz3r2mr+h8RDJ+JvV+EW8Jn
         aZpw==
X-Gm-Message-State: ABuFfojETYwXK8PGEVGQxsmsDqwcm72zClc265ojc3zZvcbYOo1h3vlP
        N5QS7PFTmYIZbn2MEEpNcPkuk5cMpiygpK5F/Scg3rIY+5ycoHqFhGdYifStZgJAS5onqs55kHO
        dqERbREUIkp1rNANiokeGcLuVdczewca2LLXrHzN73nbIRjot7RTwG8buiRwA
X-Google-Smtp-Source: ACcGV61seMsOtim08TMHfIqVQgQtkSQpiZafxe+Qpi9+rpW+a4EkyGfoQZWzMRwqz6W79CqX5iPZ2Wi1SdEq
X-Received: by 2002:ac8:2397:: with SMTP id q23-v6mr1895001qtq.55.1539208247465;
 Wed, 10 Oct 2018 14:50:47 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:50:06 -0700
In-Reply-To: <20181010215008.233529-1-sbeller@google.com>
Message-Id: <20181010215008.233529-8-sbeller@google.com>
Mime-Version: 1.0
References: <20181010215008.233529-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH v5 7/9] submodule: fetch in submodules git directory instead
 of in worktree
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
 submodule.c                 | 51 +++++++++++++++++++++++++++----------
 t/t5526-fetch-submodules.sh |  7 ++++-
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/submodule.c b/submodule.c
index dd478ed70b..3f791f2277 100644
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
@@ -1227,6 +1233,29 @@ static int get_fetch_recurse_config(const struct submodule *submodule,
 	return spf->default_option;
 }
 
+static struct repository *get_submodule_repo_for(struct repository *r,
+						 const struct submodule *sub)
+{
+	struct repository *ret = xmalloc(sizeof(*ret));
+
+	if (repo_submodule_init(ret, r, sub)) {
+		/*
+		 * No entry in .gitmodules? Technically not a submodule,
+		 * but historically we supported repositories that happen to be
+		 * in-place where a gitlink is. Keep supporting them.
+		 */
+		struct strbuf gitdir = STRBUF_INIT;
+		strbuf_repo_worktree_path(&gitdir, r, "%s/.git", sub->path);
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
@@ -1234,12 +1263,11 @@ static int get_next_submodule(struct child_process *cp,
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
@@ -1274,16 +1302,12 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 		}
 
-		strbuf_repo_worktree_path(&submodule_path, spf->r, "%s", ce->name);
-		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
 		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
-		git_dir = read_gitfile(submodule_git_dir.buf);
-		if (!git_dir)
-			git_dir = submodule_git_dir.buf;
-		if (is_directory(git_dir)) {
+		repo = get_submodule_repo_for(spf->r, submodule);
+		if (repo) {
 			child_process_init(cp);
-			cp->dir = strbuf_detach(&submodule_path, NULL);
-			prepare_submodule_repo_env(&cp->env_array);
+			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+			cp->dir = xstrdup(repo->gitdir);
 			cp->git_cmd = 1;
 			if (!spf->quiet)
 				strbuf_addf(err, "Fetching submodule %s%s\n",
@@ -1293,10 +1317,11 @@ static int get_next_submodule(struct child_process *cp,
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
index 6c2f9b2ba2..42692219a1 100755
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
2.19.0

