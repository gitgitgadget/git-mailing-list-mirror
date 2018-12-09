Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B807020A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbeLIKp1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:27 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33051 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeLIKpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so7135456ljd.0
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q+i1g1CSDo15aJWy//eJaXGeBr7p8Dl0AteDxjzmyx4=;
        b=ArXtyNrodcQKOAXGZm4XE2b4Ua77hjxU301VUiZDNaeFolpXOuZwm1QqZUf3boUmm0
         mz6H1sRyfUUPp0rrCeB5Si31ZumOupfZW9MQL1AXifoJHoUsqo3XCypo9nq/vZrQl8VP
         /pAWEvHn/CkTOXk76o10XP8Xx6vDofMy9C3twnpsU61Io8WDw9O4xVLrznlr+YKP8wEW
         L3bgPJn2Ky+LPyjwXhCDt99AjdOT3iobIctj7IsbsxUjA7G299T0UupzZBECP/Cq+NhD
         5t8Si0fp460+IQHwQLHeayheSBHGNgdLUmWRmaanHKfkNo3uv2AqqrjHb6S9/hoL+Zjl
         3fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q+i1g1CSDo15aJWy//eJaXGeBr7p8Dl0AteDxjzmyx4=;
        b=QodW9gm2PwDZKVsiDa/LDSKF1tX5HPcAJ+wTiKY7tE8H58KbkmngzvouljoCUu/Jw8
         AwKM9rftv9qZZuODHqP3+zZS6vT1IanrpGS1uXMppH2JPvAVA5hYAza6sT2la01Dopq3
         j+5iOwFhSHKfcN74GxN3rvaIWpMT5mv5HZ4Dt3mrLTAp9DqkMfUEAaC1Xy5fM7z4/qyb
         Trxy6g3aJ5qLyAsvZ0xkrzJQvs8ivquuZ0jgzrhYfgjgvhN3LlsOLaRNyISZ2jbQpQag
         bnj0PMejHQwomXACVv+XEWy8Bg/PybxGgiO/hK9xd5gXqIOedkkZSAkkScJQcoTnGjJ1
         Jjww==
X-Gm-Message-State: AA+aEWZGv6wZXjhoTjOGvKheHawKOVztl0NyZJdMi52DQcClRdcQiyaf
        4djiKfO5kQSTtcN0vlS0PgDiV2zh
X-Google-Smtp-Source: AFSGD/W/iNeU7uRAQ1urBLN7Y0uTPJ+yecOqLgBwdDuUDFliaSZ22u5donh+hB0SQ2DjSLuwFSsWzA==
X-Received: by 2002:a2e:2909:: with SMTP id u9-v6mr4925864lje.28.1544352321863;
        Sun, 09 Dec 2018 02:45:21 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:21 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/24] unpack-trees.c: keep backup of ignored files being overwritten
Date:   Sun,  9 Dec 2018 11:44:14 +0100
Message-Id: <20181209104419.12639-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <20181209104419.12639-1-pclouds@gmail.com>
References: <20181209104419.12639-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ignored files are usually machine generated (e.g. *.o) and not worth
keeping, so when a merge or branch switch happens and need to
overwrite them, we just go ahead and do it. Occasionally though
ignored files _can_ have valuable content.

We will likely have a separate mechanism to protect these "precious"
ignored files, but a surprise is still a surprise. Keep a backup of
ignored files when they are overwritten (until we are explicitly told
"rubbish" by said mechanism). This lets the user recover the content
and start telling git that the file is precious so it won't happen
again.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c    |  2 ++
 merge.c               |  2 ++
 t/t2080-backup-log.sh | 21 ++++++++++++
 unpack-trees.c        | 77 +++++++++++++++++++++++++++++++++++--------
 unpack-trees.h        |  3 ++
 5 files changed, 92 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index acdafc6e4c..b5e27a5f6d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -620,6 +620,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			topts.dir = xcalloc(1, sizeof(*topts.dir));
 			topts.dir->flags |= DIR_SHOW_IGNORED;
 			setup_standard_excludes(topts.dir);
+			repo_config_get_bool(the_repository, "core.backupLog",
+					     &topts.keep_backup);
 		}
 		tree = parse_tree_indirect(old_branch_info->commit ?
 					   &old_branch_info->commit->object.oid :
diff --git a/merge.c b/merge.c
index 91008f7602..9f20305d7a 100644
--- a/merge.c
+++ b/merge.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "lockfile.h"
@@ -85,6 +86,7 @@ int checkout_fast_forward(struct repository *r,
 		dir.flags |= DIR_SHOW_IGNORED;
 		setup_standard_excludes(&dir);
 		opts.dir = &dir;
+		repo_config_get_bool(r, "core.backupLog", &opts.keep_backup);
 	}
 
 	opts.head_idx = 1;
diff --git a/t/t2080-backup-log.sh b/t/t2080-backup-log.sh
index 710df1ec8b..a283528912 100755
--- a/t/t2080-backup-log.sh
+++ b/t/t2080-backup-log.sh
@@ -190,4 +190,25 @@ test_expect_success 'deleted reflog is kept' '
 	grep ^$OLD .git/common/gitdir.bkl
 '
 
+test_expect_success 'overwritten ignored file is backed up' '
+	git init overwrite-ignore &&
+	(
+		cd overwrite-ignore &&
+		echo ignored-overwritten >ignored &&
+		NEW=$(git hash-object ignored) &&
+		git add ignored &&
+		git commit -m ignored &&
+		git rm --cached ignored &&
+		echo /ignored >.gitignore &&
+		git add .gitignore &&
+		git commit -m first-commit-no-ignored &&
+		echo precious >ignored &&
+		OLD=$(git hash-object ignored) &&
+		test_tick &&
+		git -c core.backupLog=true checkout --detach HEAD^ &&
+		echo "$OLD $NEW $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $test_tick -0700	ignored" >expected &&
+		test_cmp expected .git/worktree.bkl
+	)
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 7570df481b..8d7273af2b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,6 +1,7 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "argv-array.h"
+#include "backup-log.h"
 #include "repository.h"
 #include "config.h"
 #include "dir.h"
@@ -191,6 +192,23 @@ void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
 	memset(opts->msgs, 0, sizeof(opts->msgs));
 }
 
+static void make_backup(const struct cache_entry *ce,
+			const struct object_id *old_hash,
+			const struct object_id *new_hash,
+			struct unpack_trees_options *o)
+{
+	struct object_id null_hash;
+
+	if (!o->keep_backup || is_null_oid(old_hash))
+		return;
+
+	if (!new_hash) {
+		oidclr(&null_hash);
+		new_hash = &null_hash;
+	}
+	bkl_append(&o->backup_log, ce->name, old_hash, new_hash);
+}
+
 static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 			 unsigned int set, unsigned int clear)
 {
@@ -462,6 +480,9 @@ static int check_updates(struct unpack_trees_options *o)
 	if (o->clone)
 		report_collided_checkout(index);
 
+	if (o->backup_log.len)
+		bkl_write(git_path("worktree.bkl"), &o->backup_log);
+
 	trace_performance_leave("check_updates");
 	return errs != 0;
 }
@@ -1460,7 +1481,8 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 
 static int verify_absent(const struct cache_entry *,
 			 enum unpack_trees_error_types,
-			 struct unpack_trees_options *);
+			 struct unpack_trees_options *,
+			 struct object_id *);
 /*
  * N-way merge "len" trees.  Returns 0 on success, -1 on failure to manipulate the
  * resulting index, -2 on failure to reflect the changes to the work tree.
@@ -1489,6 +1511,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		free(sparse);
 	}
 
+	strbuf_init(&o->backup_log, 0);
+	if (!o->update)
+		o->keep_backup = 0;
+
 	memset(&o->result, 0, sizeof(o->result));
 	o->result.initialized = 1;
 	o->result.timestamp.sec = o->src_index->timestamp.sec;
@@ -1596,7 +1622,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			 * correct CE_NEW_SKIP_WORKTREE
 			 */
 			if (ce->ce_flags & CE_ADDED &&
-			    verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o)) {
+			    verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o, NULL)) {
 				if (!o->show_all_errors)
 					goto return_failed;
 				ret = -1;
@@ -1646,6 +1672,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->src_index = NULL;
 
 done:
+	strbuf_release(&o->backup_log);
 	trace_performance_leave("unpack_trees");
 	clear_exclude_list(&el);
 	return ret;
@@ -1880,7 +1907,8 @@ static int icase_exists(struct unpack_trees_options *o, const char *name, int le
 static int check_ok_to_remove(const char *name, int len, int dtype,
 			      const struct cache_entry *ce, struct stat *st,
 			      enum unpack_trees_error_types error_type,
-			      struct unpack_trees_options *o)
+			      struct unpack_trees_options *o,
+			      struct object_id *old_hash)
 {
 	const struct cache_entry *result;
 
@@ -1895,12 +1923,16 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;
 
 	if (o->dir &&
-	    is_excluded(o->dir, o->src_index, name, &dtype))
+	    is_excluded(o->dir, o->src_index, name, &dtype)) {
+		if (o->keep_backup && old_hash)
+			index_path(NULL, old_hash, name, st,
+				   HASH_WRITE_OBJECT);
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
 		 * overwrite it.
 		 */
 		return 0;
+	}
 	if (S_ISDIR(st->st_mode)) {
 		/*
 		 * We are checking out path "foo" and
@@ -1935,7 +1967,8 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
  */
 static int verify_absent_1(const struct cache_entry *ce,
 			   enum unpack_trees_error_types error_type,
-			   struct unpack_trees_options *o)
+			   struct unpack_trees_options *o,
+			   struct object_id *old_hash)
 {
 	int len;
 	struct stat st;
@@ -1960,7 +1993,7 @@ static int verify_absent_1(const struct cache_entry *ce,
 								NULL, o);
 			else
 				ret = check_ok_to_remove(path, len, DT_UNKNOWN, NULL,
-							 &st, error_type, o);
+							 &st, error_type, o, old_hash);
 		}
 		free(path);
 		return ret;
@@ -1975,17 +2008,20 @@ static int verify_absent_1(const struct cache_entry *ce,
 
 		return check_ok_to_remove(ce->name, ce_namelen(ce),
 					  ce_to_dtype(ce), ce, &st,
-					  error_type, o);
+					  error_type, o, old_hash);
 	}
 }
 
 static int verify_absent(const struct cache_entry *ce,
 			 enum unpack_trees_error_types error_type,
-			 struct unpack_trees_options *o)
+			 struct unpack_trees_options *o,
+			 struct object_id *old_hash)
 {
+	if (o->keep_backup && old_hash)
+		oidclr(old_hash);
 	if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTREE))
 		return 0;
-	return verify_absent_1(ce, error_type, o);
+	return verify_absent_1(ce, error_type, o, old_hash);
 }
 
 static int verify_absent_sparse(const struct cache_entry *ce,
@@ -1996,7 +2032,7 @@ static int verify_absent_sparse(const struct cache_entry *ce,
 	if (orphaned_error == ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN)
 		orphaned_error = ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN;
 
-	return verify_absent_1(ce, orphaned_error, o);
+	return verify_absent_1(ce, orphaned_error, o, NULL);
 }
 
 static int merged_entry(const struct cache_entry *ce,
@@ -2007,6 +2043,8 @@ static int merged_entry(const struct cache_entry *ce,
 	struct cache_entry *merge = dup_cache_entry(ce, &o->result);
 
 	if (!old) {
+		struct object_id old_hash;
+
 		/*
 		 * New index entries. In sparse checkout, the following
 		 * verify_absent() will be delayed until after
@@ -2023,10 +2061,15 @@ static int merged_entry(const struct cache_entry *ce,
 		merge->ce_flags |= CE_NEW_SKIP_WORKTREE;
 
 		if (verify_absent(merge,
-				  ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o)) {
+				  ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN,
+				  o, &old_hash)) {
 			discard_cache_entry(merge);
 			return -1;
 		}
+		if (o->keep_backup)
+			bkl_append(&o->backup_log, merge->name,
+				   &old_hash, &merge->oid);
+
 		invalidate_ce_path(merge, o);
 
 		if (submodule_from_ce(ce)) {
@@ -2083,8 +2126,12 @@ static int deleted_entry(const struct cache_entry *ce,
 {
 	/* Did it exist in the index? */
 	if (!old) {
-		if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, o))
+		struct object_id old_hash;
+
+		if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED,
+				  o, &old_hash))
 			return -1;
+		make_backup(ce, &old_hash, NULL, o);
 		return 0;
 	}
 	if (!(old->ce_flags & CE_CONFLICTED) && verify_uptodate(old, o))
@@ -2236,8 +2283,12 @@ int threeway_merge(const struct cache_entry * const *stages,
 			if (index)
 				return deleted_entry(index, index, o);
 			if (ce && !head_deleted) {
-				if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, o))
+				struct object_id old_hash;
+
+				if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED,
+						  o, &old_hash))
 					return -1;
+				make_backup(ce, &old_hash, NULL, o);
 			}
 			return 0;
 		}
diff --git a/unpack-trees.h b/unpack-trees.h
index 0135080a7b..e2a64e2401 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -60,6 +60,7 @@ struct unpack_trees_options {
 		     exiting_early,
 		     show_all_errors,
 		     dry_run;
+	int keep_backup;
 	const char *prefix;
 	int cache_bottom;
 	struct dir_struct *dir;
@@ -83,6 +84,8 @@ struct unpack_trees_options {
 	struct index_state *src_index;
 	struct index_state result;
 
+	struct strbuf backup_log;
+
 	struct exclude_list *el; /* for internal use */
 };
 
-- 
2.20.0.rc2.486.g9832c05c3d

