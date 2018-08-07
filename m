Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81800208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 23:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeHHBXW (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 21:23:22 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:32977 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeHHBXV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 21:23:21 -0400
Received: by mail-ua0-f201.google.com with SMTP id z12-v6so316812uao.0
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 16:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xAR/ygMoYdhOkpA1sGg2x4QPtAN+1jVhs0hKBNU0x/g=;
        b=vqvQ4OP71mSeiSH9JnHf7r3PcnDoGvoDcBUkDuS7Dus2SIZEBbC103JrVVO0kbhSBn
         3vCb7Kvj8QwrMmGj2QP66IX1TwVoD+5vAT4nyao3VXKc77FFSr0G6kU3f0PgveVBPfzl
         50AgxUymIm/H0wrENmLXAzHx2vUY9IabWb3fqYXCsQBgG2Jej9F+IilZ2yB5tZTGksS9
         zQXMIUwWNMmvTBDr2Ly8FXaEN6aBquAKkNqlsPRWr17FPAC51ey43i7ANnrKzZdRtNll
         TA3G++CJvl9d2SwrlWuPmJyC4bTe2DOXN+F5L1Fn/nGiBCtJ0EU0pCAo4apRxWcuQCyf
         UPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xAR/ygMoYdhOkpA1sGg2x4QPtAN+1jVhs0hKBNU0x/g=;
        b=I+rZZs8dBYQhKil9LWxcHsYOQnxNHYmKLcIjwG0ToYREKo+EZqi0fhS+riWID0+/ly
         QZ5DSYEMQPK1AmE98PnPBeuBnG1uYnMuYd9jrMGBWROElgSkumxd5zkhM+7s6an+rrpM
         m50lgm/Tue6bcCqTuedCBaDOzHlh/9Y8dcrtZL5CQP4riHtqFW4BGVCgnmRifOj7fTAO
         PYBg/T/AfisvCt4+kfHZMbLhf8jtUak8xityDW8cmb4fEIjW+hBOQR1BF0FkUvuKE3ne
         xEXi/ToLVqyfiNgbCNtrum9tYahebLC+QBghPwz4dBLxlGNVTDvN+OnhaO7YGNEmKeBv
         2yog==
X-Gm-Message-State: AOUpUlF/qE3qqagPeA/BvAwy9Ci8KfvfJrWNUsoVFGIRUuakRmLITGJ5
        KjC0mmU3Gue8Hu1j8fvNkkPXXwvWzASYlUrhV3wUm+8Mkf5iITFMlwChpv7w2tlki3PziQqz9XG
        gR/S/6fTz8esWlTH1uZTcXGMj2P8LpXOzP1l8MV+HjfB2cjRIhfox2Po9Uw==
X-Google-Smtp-Source: AA+uWPyTkN/JZnmU8h+pN7qeuifq58r/JV29e3u4ApxF5Kp8lDj8aENxdoUgAthPXxOkLV6QqigTx37iP5E=
X-Received: by 2002:a1f:b42:: with SMTP id 63-v6mr265171vkl.24.1533683201251;
 Tue, 07 Aug 2018 16:06:41 -0700 (PDT)
Date:   Tue,  7 Aug 2018 16:06:37 -0700
Message-Id: <20180807230637.247200-1-bmwill@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [RFC] submodule: munge paths to submodule git directories
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 0383bbb901 (submodule-config: verify submodule names as paths,
2018-04-30) introduced some checks to ensure that submodule names don't
include directory traversal components (e.g. "../").

This addresses the vulnerability identified in 0383bbb901 but the root
cause is that we use submodule names to construct paths to the
submodule's git directory.  What we really should do is munge the
submodule name before using it to construct a path.

Introduce a function "strbuf_submodule_gitdir()" which callers can use
to build a path to a submodule's gitdir.  This allows for a single
location where we can munge the submodule name (by url encoding it)
before using it as part of a path.

Signed-off-by: Brandon Williams <bmwill@google.com>
---

Using submodule names as is continues to be not such a good idea.  Maybe
we could apply something like this to stop using them as is.  url
encoding seems like the easiest approach, but I've also heard
suggestions that would could use the SHA1 of the submodule name.

Any thoughts?

 builtin/submodule--helper.c      | 10 ++++--
 dir.c                            |  2 +-
 repository.c                     |  3 +-
 submodule.c                      | 57 +++++++++++++++++++++++---------
 submodule.h                      |  3 ++
 t/t7400-submodule-basic.sh       |  2 +-
 t/t7406-submodule-update.sh      | 21 ++++--------
 t/t7410-submodule-checkout-to.sh |  6 ++--
 8 files changed, 65 insertions(+), 39 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index bd250ca216..37b7353167 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1122,18 +1122,24 @@ static int add_possible_reference_from_superproject(
 	 * standard layout with .git/(modules/<name>)+/objects
 	 */
 	if (ends_with(alt->path, "/objects")) {
+		struct repository alternate;
 		char *sm_alternate;
 		struct strbuf sb = STRBUF_INIT;
 		struct strbuf err = STRBUF_INIT;
 		strbuf_add(&sb, alt->path, strlen(alt->path) - strlen("objects"));
 
+		repo_init(&alternate, sb.buf, NULL);
+
 		/*
 		 * We need to end the new path with '/' to mark it as a dir,
 		 * otherwise a submodule name containing '/' will be broken
 		 * as the last part of a missing submodule reference would
 		 * be taken as a file name.
 		 */
-		strbuf_addf(&sb, "modules/%s/", sas->submodule_name);
+		strbuf_reset(&sb);
+		strbuf_submodule_gitdir(&sb, &alternate, sas->submodule_name);
+		strbuf_addch(&sb, '/');
+		repo_clear(&alternate);
 
 		sm_alternate = compute_alternate_path(sb.buf, &err);
 		if (sm_alternate) {
@@ -1246,7 +1252,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_submodule_helper_usage,
 				   module_clone_options);
 
-	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
+	strbuf_submodule_gitdir(&sb, the_repository, name);
 	sm_gitdir = absolute_pathdup(sb.buf);
 	strbuf_reset(&sb);
 
diff --git a/dir.c b/dir.c
index fe9bf58e4c..3463a5e0a5 100644
--- a/dir.c
+++ b/dir.c
@@ -3052,7 +3052,7 @@ static void connect_wt_gitdir_in_nested(const char *sub_worktree,
 		strbuf_reset(&sub_wt);
 		strbuf_reset(&sub_gd);
 		strbuf_addf(&sub_wt, "%s/%s", sub_worktree, sub->path);
-		strbuf_addf(&sub_gd, "%s/modules/%s", sub_gitdir, sub->name);
+		strbuf_submodule_gitdir(&sub_gd, &subrepo, sub->name);
 
 		connect_work_tree_and_git_dir(sub_wt.buf, sub_gd.buf, 1);
 	}
diff --git a/repository.c b/repository.c
index 02fe884603..15fabbd08d 100644
--- a/repository.c
+++ b/repository.c
@@ -194,8 +194,7 @@ int repo_submodule_init(struct repository *submodule,
 		 * submodule would not have a worktree.
 		 */
 		strbuf_reset(&gitdir);
-		strbuf_repo_git_path(&gitdir, superproject,
-				     "modules/%s", sub->name);
+		strbuf_submodule_gitdir(&gitdir, superproject, sub->name);
 
 		if (repo_init(submodule, gitdir.buf, NULL)) {
 			ret = -1;
diff --git a/submodule.c b/submodule.c
index 939d6870ec..1d571845e8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1625,20 +1625,22 @@ int submodule_move_head(const char *path,
 				absorb_git_dir_into_superproject("", path,
 					ABSORB_GITDIR_RECURSE_SUBMODULES);
 		} else {
-			char *gitdir = xstrfmt("%s/modules/%s",
-				    get_git_common_dir(), sub->name);
-			connect_work_tree_and_git_dir(path, gitdir, 0);
-			free(gitdir);
+			struct strbuf gitdir = STRBUF_INIT;
+			strbuf_submodule_gitdir(&gitdir, the_repository,
+						sub->name);
+			connect_work_tree_and_git_dir(path, gitdir.buf, 0);
+			strbuf_release(&gitdir);
 
 			/* make sure the index is clean as well */
 			submodule_reset_index(path);
 		}
 
 		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
-			char *gitdir = xstrfmt("%s/modules/%s",
-				    get_git_common_dir(), sub->name);
-			connect_work_tree_and_git_dir(path, gitdir, 1);
-			free(gitdir);
+			struct strbuf gitdir = STRBUF_INIT;
+			strbuf_submodule_gitdir(&gitdir, the_repository,
+						sub->name);
+			connect_work_tree_and_git_dir(path, gitdir.buf, 1);
+			strbuf_release(&gitdir);
 		}
 	}
 
@@ -1711,7 +1713,7 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 						      const char *path)
 {
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
-	const char *new_git_dir;
+	struct strbuf new_gitdir = STRBUF_INIT;
 	const struct submodule *sub;
 
 	if (submodule_uses_worktrees(path))
@@ -1729,10 +1731,10 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 	if (!sub)
 		die(_("could not lookup name for submodule '%s'"), path);
 
-	new_git_dir = git_path("modules/%s", sub->name);
-	if (safe_create_leading_directories_const(new_git_dir) < 0)
-		die(_("could not create directory '%s'"), new_git_dir);
-	real_new_git_dir = real_pathdup(new_git_dir, 1);
+	strbuf_submodule_gitdir(&new_gitdir, the_repository, sub->name);
+	if (safe_create_leading_directories_const(new_gitdir.buf) < 0)
+		die(_("could not create directory '%s'"), new_gitdir.buf);
+	real_new_git_dir = real_pathdup(new_gitdir.buf, 1);
 
 	fprintf(stderr, _("Migrating git directory of '%s%s' from\n'%s' to\n'%s'\n"),
 		get_super_prefix_or_empty(), path,
@@ -1743,6 +1745,7 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 	free(old_git_dir);
 	free(real_old_git_dir);
 	free(real_new_git_dir);
+	strbuf_release(&new_gitdir);
 }
 
 /*
@@ -1763,6 +1766,7 @@ void absorb_git_dir_into_superproject(const char *prefix,
 	/* Not populated? */
 	if (!sub_git_dir) {
 		const struct submodule *sub;
+		struct strbuf sub_gitdir = STRBUF_INIT;
 
 		if (err_code == READ_GITFILE_ERR_STAT_FAILED) {
 			/* unpopulated as expected */
@@ -1784,8 +1788,9 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		sub = submodule_from_path(the_repository, &null_oid, path);
 		if (!sub)
 			die(_("could not lookup name for submodule '%s'"), path);
-		connect_work_tree_and_git_dir(path,
-			git_path("modules/%s", sub->name), 0);
+		strbuf_submodule_gitdir(&sub_gitdir, the_repository, sub->name);
+		connect_work_tree_and_git_dir(path, sub_gitdir.buf, 0);
+		strbuf_release(&sub_gitdir);
 	} else {
 		/* Is it already absorbed into the superprojects git dir? */
 		char *real_sub_git_dir = real_pathdup(sub_git_dir, 1);
@@ -1933,9 +1938,29 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
 			goto cleanup;
 		}
 		strbuf_reset(buf);
-		strbuf_git_path(buf, "%s/%s", "modules", sub->name);
+		strbuf_submodule_gitdir(buf, the_repository, sub->name);
 	}
 
 cleanup:
 	return ret;
 }
+
+void strbuf_submodule_gitdir(struct strbuf *buf, struct repository *r,
+			     const char *submodule_name)
+{
+	int modules_len;
+
+	strbuf_git_common_path(buf, r, "modules/");
+	modules_len = buf->len;
+	strbuf_addstr(buf, submodule_name);
+
+	/*
+	 * If the submodule gitdir already exists using the old location then
+	 * return that.
+	 */
+	if (!access(buf->buf, F_OK))
+		return;
+
+	strbuf_setlen(buf, modules_len);
+	strbuf_addstr_urlencode(buf, submodule_name, 1);
+}
diff --git a/submodule.h b/submodule.h
index 7856b8a0b3..b56f89740d 100644
--- a/submodule.h
+++ b/submodule.h
@@ -114,6 +114,9 @@ extern int push_unpushed_submodules(struct oid_array *commits,
  */
 int submodule_to_gitdir(struct strbuf *buf, const char *submodule);
 
+void strbuf_submodule_gitdir(struct strbuf *buf, struct repository *r,
+			     const char *submodule_name);
+
 #define SUBMODULE_MOVE_HEAD_DRY_RUN (1<<0)
 #define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
 extern int submodule_move_head(const char *path,
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 812db137b8..fce164484d 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -932,7 +932,7 @@ test_expect_success 'recursive relative submodules stay relative' '
 		cd clone2 &&
 		git submodule update --init --recursive &&
 		echo "gitdir: ../.git/modules/sub3" >./sub3/.git_expect &&
-		echo "gitdir: ../../../.git/modules/sub3/modules/dirdir/subsub" >./sub3/dirdir/subsub/.git_expect
+		echo "gitdir: ../../../.git/modules/sub3/modules/dirdir%2fsubsub" >./sub3/dirdir/subsub/.git_expect
 	) &&
 	test_cmp clone2/sub3/.git_expect clone2/sub3/.git &&
 	test_cmp clone2/sub3/dirdir/subsub/.git_expect clone2/sub3/dirdir/subsub/.git
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 9e0d31700e..c4e94c168d 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -777,12 +777,8 @@ test_expect_success 'submodule add places git-dir in superprojects git-dir' '
 	(cd super &&
 	 mkdir deeper &&
 	 git submodule add ../submodule deeper/submodule &&
-	 (cd deeper/submodule &&
-	  git log > ../../expected
-	 ) &&
-	 (cd .git/modules/deeper/submodule &&
-	  git log > ../../../../actual
-	 ) &&
+	 git -C deeper/submodule log >expected &&
+	 git -C .git/modules/deeper%2fsubmodule log >actual &&
 	 test_cmp actual expected
 	)
 '
@@ -795,12 +791,9 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir' '
 	(cd super2 &&
 	 git submodule init deeper/submodule &&
 	 git submodule update &&
-	 (cd deeper/submodule &&
-	  git log > ../../expected
-	 ) &&
-	 (cd .git/modules/deeper/submodule &&
-	  git log > ../../../../actual
-	 ) &&
+
+	 git -C deeper/submodule log >expected &&
+	 git -C .git/modules/deeper%2fsubmodule log >actual &&
 	 test_cmp actual expected
 	)
 '
@@ -815,9 +808,7 @@ test_expect_success 'submodule add places git-dir in superprojects git-dir recur
 	  git commit -m "added subsubmodule" &&
 	  git push origin :
 	 ) &&
-	 (cd .git/modules/deeper/submodule/modules/subsubmodule &&
-	  git log > ../../../../../actual
-	 ) &&
+	 git -C .git/modules/deeper%2fsubmodule/modules/subsubmodule log >actual &&
 	 git add deeper/submodule &&
 	 git commit -m "update submodule" &&
 	 git push origin : &&
diff --git a/t/t7410-submodule-checkout-to.sh b/t/t7410-submodule-checkout-to.sh
index 1acef32647..c408e9010a 100755
--- a/t/t7410-submodule-checkout-to.sh
+++ b/t/t7410-submodule-checkout-to.sh
@@ -35,8 +35,10 @@ test_expect_success 'checkout main' \
     (cd clone/main &&
 	git worktree add "$base_path/default_checkout/main" "$rev1_hash_main")'
 
-test_expect_failure 'can see submodule diffs just after checkout' \
-    '(cd default_checkout/main && git diff --submodule master"^!" | grep "file1 updated")'
+test_expect_success 'can see submodule diffs just after checkout' '
+	git -C default_checkout/main diff --submodule master"^!" >out &&
+	grep "file1 updated" out
+'
 
 test_expect_success 'checkout main and initialize independed clones' \
     'mkdir fully_cloned_submodule &&
-- 
2.18.0.597.ga71716f1ad-goog

