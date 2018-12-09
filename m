Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F014E20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbeLIKpe (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:34 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:34393 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeLIKp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:26 -0500
Received: by mail-lj1-f174.google.com with SMTP id u6-v6so7105586ljd.1
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GmQWBlkX2c2mVq6xoOFl3/GJUV9UR/BikheMU/SkTkc=;
        b=EprG+UDS+vE7KkjMWxjeaDeldPJk47/0JWQxIdj77exeF7aZAnssWoCMRw1KfzCr6d
         +9si7nLQE9Ncdn9f1XJURx9MPvam13oQIPg3YRQ/EP1zzeVHUXbl0vRmvB1fVshkot98
         1xgO33gdRjEZomxM/npceFoBAIpiS6dgJmvbki3BKhlRNP6guxIIy3g5pWONxM3EDa2n
         kI21BsmU1ZTIHVsSQmP/ybUksEimXA1KHCLV5XzoAeXt8oea9iebZYmDcaLPenf9fTZ8
         SDlGNWl4n90ynY0xERVl59SF4mmU0LzH3gqdAhwDaQCAIA7UuxHD97S4s2Nd/YQ95fP7
         Ta9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GmQWBlkX2c2mVq6xoOFl3/GJUV9UR/BikheMU/SkTkc=;
        b=SCdB/Kva4mPwYs3xFUUcS0O2jAJS8G1AIjx1ly6bCAGYMOWA4EKNfv9FWsjEFy4meF
         q187Rmcwaj36ROFW+ueNeh4PPRLDq1sibjydvXp8L44H7xlGaEhOlLCSMaDf8E8TS+n+
         LZ26elNnSgEdcVhONQImn2vnuXAo0kczsi2x6UKUfkIG3OUxEGcqB2qMKLpRj4IxCi0W
         if+v0b8fL2GzC9PuQ2vm5QsID7sSB+O0v7mx8wBd9jwpm4wmmP3vJdF9xS6g8cEl63Pn
         eZQ3bo5zSTVajcylQAtRHasBK6tj8RpXLePCyhGClUmSfMdhQ7ISk8FqnSnaJ/PexzdL
         fGAQ==
X-Gm-Message-State: AA+aEWbnKzZL85dc8DSgIOJIW+Kz/ry4oyORoCTQWLdtvgh5D2UVHPMd
        CwPKy566813z7DW9uJWMRJZz2jOq
X-Google-Smtp-Source: AFSGD/UM1fnjHZAUlZOztAi7lgclj/2Jad+HDfYNlgGwzdMXRof9q79AxnKCDVd4o4rcgOIPED1PKQ==
X-Received: by 2002:a2e:84ca:: with SMTP id q10-v6mr4816667ljh.65.1544352322887;
        Sun, 09 Dec 2018 02:45:22 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:22 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 20/24] reset --hard: keep backup of overwritten files
Date:   Sun,  9 Dec 2018 11:44:15 +0100
Message-Id: <20181209104419.12639-21-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/reset.c       |  2 ++
 merge-recursive.c     |  2 +-
 t/t2080-backup-log.sh | 14 +++++++++
 unpack-trees.c        | 70 +++++++++++++++++++++++++++++++++----------
 unpack-trees.h        |  3 +-
 5 files changed, 74 insertions(+), 17 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 58166964f8..517a27dce5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -67,6 +67,8 @@ static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 		break;
 	case HARD:
 		opts.update = 1;
+		repo_config_get_bool(the_repository, "core.backupLog",
+				     &opts.keep_backup);
 		/* fallthrough */
 	default:
 		opts.reset = 1;
diff --git a/merge-recursive.c b/merge-recursive.c
index acc2f64a4e..10a9d3180a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -896,7 +896,7 @@ static int was_dirty(struct merge_options *o, const char *path)
 
 	ce = index_file_exists(o->unpack_opts.src_index,
 			       path, strlen(path), ignore_case);
-	dirty = verify_uptodate(ce, &o->unpack_opts) != 0;
+	dirty = verify_uptodate(ce, &o->unpack_opts, NULL) != 0;
 	return dirty;
 }
 
diff --git a/t/t2080-backup-log.sh b/t/t2080-backup-log.sh
index a283528912..901755ce93 100755
--- a/t/t2080-backup-log.sh
+++ b/t/t2080-backup-log.sh
@@ -211,4 +211,18 @@ test_expect_success 'overwritten ignored file is backed up' '
 	)
 '
 
+test_expect_success 'overwritten out-of-date file is backed up' '
+	git init overwrite-outofdate &&
+	(
+		cd overwrite-outofdate &&
+		test_commit haha &&
+		NEW=$(git hash-object haha.t) &&
+		echo bad >>haha.t &&
+		OLD=$(git hash-object haha.t) &&
+		git -c core.backupLog reset --hard &&
+		echo "$OLD $NEW $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $test_tick -0700	haha.t" >expected &&
+		test_cmp expected .git/worktree.bkl
+	)
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 8d7273af2b..221869b47c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1715,7 +1715,8 @@ static int same(const struct cache_entry *a, const struct cache_entry *b)
  */
 static int verify_uptodate_1(const struct cache_entry *ce,
 			     struct unpack_trees_options *o,
-			     enum unpack_trees_error_types error_type)
+			     enum unpack_trees_error_types error_type,
+			     struct object_id *old_hash)
 {
 	struct stat st;
 
@@ -1727,10 +1728,16 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 	 * if this entry is truly up-to-date because this file may be
 	 * overwritten.
 	 */
-	if ((ce->ce_flags & CE_VALID) || ce_skip_worktree(ce))
+	if ((ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
 		; /* keep checking */
-	else if (o->reset || ce_uptodate(ce))
+	} else if (o->reset) {
+		if (o->keep_backup && old_hash && !lstat(ce->name, &st))
+			index_path(NULL, old_hash, ce->name, &st,
+				   HASH_WRITE_OBJECT);
+		return 0;
+	} else if (ce_uptodate(ce)) {
 		return 0;
+	}
 
 	if (!lstat(ce->name, &st)) {
 		int flags = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE;
@@ -1764,17 +1771,20 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 }
 
 int verify_uptodate(const struct cache_entry *ce,
-		    struct unpack_trees_options *o)
+		    struct unpack_trees_options *o,
+		    struct object_id *old_hash)
 {
+	if (o->keep_backup && old_hash)
+		oidclr(old_hash);
 	if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTREE))
 		return 0;
-	return verify_uptodate_1(ce, o, ERROR_NOT_UPTODATE_FILE);
+	return verify_uptodate_1(ce, o, ERROR_NOT_UPTODATE_FILE, old_hash);
 }
 
 static int verify_uptodate_sparse(const struct cache_entry *ce,
 				  struct unpack_trees_options *o)
 {
-	return verify_uptodate_1(ce, o, ERROR_SPARSE_NOT_UPTODATE_FILE);
+	return verify_uptodate_1(ce, o, ERROR_SPARSE_NOT_UPTODATE_FILE, NULL);
 }
 
 /*
@@ -1862,8 +1872,11 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 		 * removed.
 		 */
 		if (!ce_stage(ce2)) {
-			if (verify_uptodate(ce2, o))
+			struct object_id old_hash;
+
+			if (verify_uptodate(ce2, o, &old_hash))
 				return -1;
+			make_backup(ce2, &old_hash, NULL, o);
 			add_entry(o, ce2, CE_REMOVE, 0);
 			invalidate_ce_path(ce, o);
 			mark_ce_used(ce2, o);
@@ -1973,8 +1986,13 @@ static int verify_absent_1(const struct cache_entry *ce,
 	int len;
 	struct stat st;
 
-	if (o->index_only || o->reset || !o->update)
+	if (o->index_only || o->reset || !o->update) {
+		if (o->reset && o->keep_backup &&
+		    old_hash && !lstat(ce->name, &st))
+			index_path(NULL, old_hash, ce->name, &st,
+				   HASH_WRITE_OBJECT);
 		return 0;
+	}
 
 	len = check_leading_path(ce->name, ce_namelen(ce));
 	if (!len)
@@ -2092,10 +2110,12 @@ static int merged_entry(const struct cache_entry *ce,
 			copy_cache_entry(merge, old);
 			update = 0;
 		} else {
-			if (verify_uptodate(old, o)) {
+			struct object_id old_hash;
+			if (verify_uptodate(old, o, &old_hash)) {
 				discard_cache_entry(merge);
 				return -1;
 			}
+			make_backup(old, &old_hash, &merge->oid, o);
 			/* Migrate old flags over */
 			update |= old->ce_flags & (CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
 			invalidate_ce_path(old, o);
@@ -2124,18 +2144,20 @@ static int deleted_entry(const struct cache_entry *ce,
 			 const struct cache_entry *old,
 			 struct unpack_trees_options *o)
 {
+	struct object_id old_hash;
+
 	/* Did it exist in the index? */
 	if (!old) {
-		struct object_id old_hash;
-
 		if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED,
 				  o, &old_hash))
 			return -1;
 		make_backup(ce, &old_hash, NULL, o);
 		return 0;
 	}
-	if (!(old->ce_flags & CE_CONFLICTED) && verify_uptodate(old, o))
+	if (!(old->ce_flags & CE_CONFLICTED) &&
+	    verify_uptodate(old, o, &old_hash))
 		return -1;
+	make_backup(ce, &old_hash, NULL, o);
 	add_entry(o, ce, CE_REMOVE, 0);
 	invalidate_ce_path(ce, o);
 	return 1;
@@ -2305,8 +2327,16 @@ int threeway_merge(const struct cache_entry * const *stages,
 	 * conflict resolution files.
 	 */
 	if (index) {
-		if (verify_uptodate(index, o))
+		struct object_id old_hash;
+
+		if (verify_uptodate(index, o, &old_hash))
 			return -1;
+		/*
+		 * A new conflict appears. We could make a backup from
+		 * worktree version to stage 2 or 3. But neither makes much
+		 * sense. Make a deletion backup instead.
+		 */
+		make_backup(index, &old_hash, NULL, o);
 	}
 
 	o->nontrivial_merge = 1;
@@ -2447,16 +2477,26 @@ int oneway_merge(const struct cache_entry * const *src,
 		return deleted_entry(old, old, o);
 
 	if (old && same(old, a)) {
+		struct object_id old_hash;
 		int update = 0;
+
+		oidclr(&old_hash);
 		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old)) {
 			struct stat st;
+
 			if (lstat(old->name, &st) ||
-			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
+			    ie_match_stat(o->src_index, old, &st,
+					  CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
 				update |= CE_UPDATE;
+
+			if (update & CE_UPDATE && o->keep_backup)
+				index_path(NULL, &old_hash, old->name, &st,
+					   HASH_WRITE_OBJECT);
 		}
 		if (o->update && S_ISGITLINK(old->ce_mode) &&
-		    should_update_submodules() && !verify_uptodate(old, o))
+		    should_update_submodules() && !verify_uptodate(old, o, NULL))
 			update |= CE_UPDATE;
+		make_backup(old, &old_hash, &old->oid, o);
 		add_entry(o, old, update, 0);
 		return 0;
 	}
diff --git a/unpack-trees.h b/unpack-trees.h
index e2a64e2401..a453def564 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -93,7 +93,8 @@ int unpack_trees(unsigned n, struct tree_desc *t,
 		 struct unpack_trees_options *options);
 
 int verify_uptodate(const struct cache_entry *ce,
-		    struct unpack_trees_options *o);
+		    struct unpack_trees_options *o,
+		    struct object_id *old_hash);
 
 int threeway_merge(const struct cache_entry * const *stages,
 		   struct unpack_trees_options *o);
-- 
2.20.0.rc2.486.g9832c05c3d

