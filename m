Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AD5C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9573620747
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwzE3S3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgDGWL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:11:58 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:39301 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGWL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 18:11:58 -0400
Received: by mail-pf1-f202.google.com with SMTP id x189so3664483pfd.6
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 15:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xbnHtHtDrH2y9KBSX9107Uch0U5c+Fj0/bg20AFOJPU=;
        b=PwzE3S3Irf9+DzSTc++jeuN+pZVgJurKeYD0xAnvN+ZE5hYSsvKthukxA9IJ2T/EUs
         GvdJx7f04N1iZ+mKnQHnj7qXafH9zlZ69uwseSfpqoTJbX21gZZPy8vdu5XNna2SJcOP
         x+vOBjLWiNxnwEBJr/nK69jgPLhu4b7wMrJvwr3AOm0PlGeV4ca5c4HJDeJY0ZVCLCoA
         cUxibyelkPijnN21YWd1fbb/ExcZRniceS1p1j2MTu4ziGMp4xtuy4/VfCcXLRlz56i0
         mwiGBHRom2ZHjzWGodk4uaz+Ji8xQ1GYrYa7KrEhFNeWQhg+pZmaXDRqJfkd+wlIAKQE
         ex5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xbnHtHtDrH2y9KBSX9107Uch0U5c+Fj0/bg20AFOJPU=;
        b=i4fLCeWiT7y+O8J+gopxVpbiLiEhBpuKs9e9nHnt3K1P27l4UF6qoiotgw2lmWGo2M
         ax3OfGi3TM+jdGoPKlHK6pwvVVbNncoNTMxc42iuOQ3NXYbfYEIvclt5PAfGhFsiLgk7
         jlpFTBExcv4vxFgOPczmQCtNRfIYmNqAJ5Toj87ka1LrPbxzfW1bAX232xmIY/PRlApv
         vX3hnGuIrU7VGbTf7vZMc3XIpjANk2gyDyy8FQXBRwl6tD+K63Q9entFPRlepy7eXs6T
         2ifTDzITEaj3yBdZwPc+dD6tqYTcbxZROS6S0TlUV+fm2NtIEYuXk566pu0Fk+3ZMiHC
         IlPA==
X-Gm-Message-State: AGi0PuYcyJCU3vOfljgK8QIzgKcvdYBAHzep+zfhRKkEGwJQZ8zfx/vE
        nXeAqCgpOA02AqAE/upQcKMzB9v+k/GftXX0aaqCxmYLI6mhm6Iz8Uu/vg1TjXXozxFnB7vXKOH
        0F+qgBLMu/A8ge8IdD2i/zm7WoU/iBdkbbA4S8RUNt0FdESn8J7cWu2fBeWPYIgcW/o7REsDtG/
        ST
X-Google-Smtp-Source: APiQypLptkYaelI6i9Z/NFDzQ++jT06570CosvgJcDu6lS76h8uuUiQ8ooPPm2QllLyfifdvlBDgsFXvJQKwJtuknQ6i
X-Received: by 2002:a17:90a:c085:: with SMTP id o5mr1507015pjs.85.1586297515130;
 Tue, 07 Apr 2020 15:11:55 -0700 (PDT)
Date:   Tue,  7 Apr 2020 15:11:43 -0700
In-Reply-To: <cover.1586296510.git.jonathantanmy@google.com>
Message-Id: <ee3373bc6a27ee1c4015abc84b634c036048e3f0.1586296510.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200331020418.55640-1-jonathantanmy@google.com> <cover.1586296510.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v3 4/4] diff: restrict when prefetching occurs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, garimasigit@gmail.com,
        gitster@pobox.com, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 7fbbcb21b1 ("diff: batch fetching of missing blobs", 2019-04-08)
optimized "diff" by prefetching blobs in a partial clone, but there are
some cases wherein blobs do not need to be prefetched. In these cases,
any command that uses the diff machinery will unnecessarily fetch blobs.

diffcore_std() may read blobs when it calls the following functions:
 (1) diffcore_skip_stat_unmatch() (controlled by the config variable
     diff.autorefreshindex)
 (2) diffcore_break() and diffcore_merge_broken() (for break-rewrite
     detection)
 (3) diffcore_rename() (for rename detection)
 (4) diffcore_pickaxe() (for detecting addition/deletion of specified
     string)

Instead of always prefetching blobs, teach diffcore_skip_stat_unmatch(),
diffcore_break(), and diffcore_rename() to prefetch blobs upon the first
read of a missing object. This covers (1), (2), and (3): to cover the
rest, teach diffcore_std() to prefetch if the output type is one that
includes blob data (and hence blob data will be required later anyway),
or if it knows that (4) will be run.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 diff.c                        | 73 ++++++++++++++++++++++++-----------
 diffcore-break.c              | 12 +++++-
 diffcore-rename.c             | 55 ++++++++++++++++++++++++--
 diffcore.h                    | 21 ++++++++++
 t/t4067-diff-partial-clone.sh | 48 +++++++++++++++++++++++
 5 files changed, 181 insertions(+), 28 deletions(-)

diff --git a/diff.c b/diff.c
index 8db981b906..d1ad6a3c4a 100644
--- a/diff.c
+++ b/diff.c
@@ -4034,10 +4034,18 @@ int diff_populate_filespec(struct repository *r,
 			 */
 			info.contentp = &s->data;
 
+		if (options && options->missing_object_cb) {
+			if (!oid_object_info_extended(r, &s->oid, &info,
+						      OBJECT_INFO_LOOKUP_REPLACE |
+						      OBJECT_INFO_SKIP_FETCH_OBJECT))
+				goto object_read;
+			options->missing_object_cb(options->missing_object_data);
+		}
 		if (oid_object_info_extended(r, &s->oid, &info,
 					     OBJECT_INFO_LOOKUP_REPLACE))
 			die("unable to read %s", oid_to_hex(&s->oid));
 
+object_read:
 		if (size_only || check_binary) {
 			if (size_only)
 				return 0;
@@ -6447,6 +6455,8 @@ static int diff_filespec_check_stat_unmatch(struct repository *r,
 {
 	struct diff_populate_filespec_options dpf_options = {
 		.check_size_only = 1,
+		.missing_object_cb = diff_queued_diff_prefetch,
+		.missing_object_data = r,
 	};
 
 	if (p->done_skip_stat_unmatch)
@@ -6523,9 +6533,9 @@ void diffcore_fix_diff_index(void)
 	QSORT(q->queue, q->nr, diffnamecmp);
 }
 
-static void add_if_missing(struct repository *r,
-			   struct oid_array *to_fetch,
-			   const struct diff_filespec *filespec)
+void diff_add_if_missing(struct repository *r,
+			 struct oid_array *to_fetch,
+			 const struct diff_filespec *filespec)
 {
 	if (filespec && filespec->oid_valid &&
 	    !S_ISGITLINK(filespec->mode) &&
@@ -6534,29 +6544,48 @@ static void add_if_missing(struct repository *r,
 		oid_array_append(to_fetch, &filespec->oid);
 }
 
-void diffcore_std(struct diff_options *options)
+void diff_queued_diff_prefetch(void *repository)
 {
-	if (options->repo == the_repository && has_promisor_remote()) {
-		/*
-		 * Prefetch the diff pairs that are about to be flushed.
-		 */
-		int i;
-		struct diff_queue_struct *q = &diff_queued_diff;
-		struct oid_array to_fetch = OID_ARRAY_INIT;
+	struct repository *repo = repository;
+	int i;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct oid_array to_fetch = OID_ARRAY_INIT;
 
-		for (i = 0; i < q->nr; i++) {
-			struct diff_filepair *p = q->queue[i];
-			add_if_missing(options->repo, &to_fetch, p->one);
-			add_if_missing(options->repo, &to_fetch, p->two);
-		}
-		/*
-		 * NEEDSWORK: Consider deduplicating the OIDs sent.
-		 */
-		promisor_remote_get_direct(options->repo,
-					   to_fetch.oid, to_fetch.nr);
-		oid_array_clear(&to_fetch);
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		diff_add_if_missing(repo, &to_fetch, p->one);
+		diff_add_if_missing(repo, &to_fetch, p->two);
 	}
 
+	/*
+	 * NEEDSWORK: Consider deduplicating the OIDs sent.
+	 */
+	promisor_remote_get_direct(repo, to_fetch.oid, to_fetch.nr);
+
+	oid_array_clear(&to_fetch);
+}
+
+void diffcore_std(struct diff_options *options)
+{
+	int output_formats_to_prefetch = DIFF_FORMAT_DIFFSTAT |
+		DIFF_FORMAT_NUMSTAT |
+		DIFF_FORMAT_PATCH |
+		DIFF_FORMAT_SHORTSTAT |
+		DIFF_FORMAT_DIRSTAT;
+
+	/*
+	 * Check if the user requested a blob-data-requiring diff output and/or
+	 * break-rewrite detection (which requires blob data). If yes, prefetch
+	 * the diff pairs.
+	 *
+	 * If no prefetching occurs, diffcore_rename() will prefetch if it
+	 * decides that it needs inexact rename detection.
+	 */
+	if (options->repo == the_repository && has_promisor_remote() &&
+	    (options->output_format & output_formats_to_prefetch ||
+	     options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
+		diff_queued_diff_prefetch(options->repo);
+
 	/* NOTE please keep the following in sync with diff_tree_combined() */
 	if (options->skip_stat_unmatch)
 		diffcore_skip_stat_unmatch(options);
diff --git a/diffcore-break.c b/diffcore-break.c
index e8f6322c6a..0d4a14964d 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "promisor-remote.h"
 
 static int should_break(struct repository *r,
 			struct diff_filespec *src,
@@ -49,6 +50,8 @@ static int should_break(struct repository *r,
 	unsigned long delta_size, max_size;
 	unsigned long src_copied, literal_added, src_removed;
 
+	struct diff_populate_filespec_options options = { 0 };
+
 	*merge_score_p = 0; /* assume no deletion --- "do not break"
 			     * is the default.
 			     */
@@ -62,8 +65,13 @@ static int should_break(struct repository *r,
 	    oideq(&src->oid, &dst->oid))
 		return 0; /* they are the same */
 
-	if (diff_populate_filespec(r, src, NULL) ||
-	    diff_populate_filespec(r, dst, NULL))
+	if (r == the_repository && has_promisor_remote()) {
+		options.missing_object_cb = diff_queued_diff_prefetch;
+		options.missing_object_data = r;
+	}
+
+	if (diff_populate_filespec(r, src, &options) ||
+	    diff_populate_filespec(r, dst, &options))
 		return 0; /* error but caught downstream */
 
 	max_size = ((src->size > dst->size) ? src->size : dst->size);
diff --git a/diffcore-rename.c b/diffcore-rename.c
index bf4c0b8740..99e63e90f8 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -1,4 +1,5 @@
 /*
+ *
  * Copyright (C) 2005 Junio C Hamano
  */
 #include "cache.h"
@@ -7,6 +8,7 @@
 #include "object-store.h"
 #include "hashmap.h"
 #include "progress.h"
+#include "promisor-remote.h"
 
 /* Table of rename/copy destinations */
 
@@ -128,10 +130,46 @@ struct diff_score {
 	short name_score;
 };
 
+struct prefetch_options {
+	struct repository *repo;
+	int skip_unmodified;
+};
+static void prefetch(void *prefetch_options)
+{
+	struct prefetch_options *options = prefetch_options;
+	int i;
+	struct oid_array to_fetch = OID_ARRAY_INIT;
+
+	for (i = 0; i < rename_dst_nr; i++) {
+		if (rename_dst[i].pair)
+			/*
+			 * The loop in diffcore_rename() will not need these
+			 * blobs, so skip prefetching.
+			 */
+			continue; /* already found exact match */
+		diff_add_if_missing(options->repo, &to_fetch,
+				    rename_dst[i].two);
+	}
+	for (i = 0; i < rename_src_nr; i++) {
+		if (options->skip_unmodified &&
+		    diff_unmodified_pair(rename_src[i].p))
+			/*
+			 * The loop in diffcore_rename() will not need these
+			 * blobs, so skip prefetching.
+			 */
+			continue;
+		diff_add_if_missing(options->repo, &to_fetch,
+				    rename_src[i].p->one);
+	}
+	promisor_remote_get_direct(options->repo, to_fetch.oid, to_fetch.nr);
+	oid_array_clear(&to_fetch);
+}
+
 static int estimate_similarity(struct repository *r,
 			       struct diff_filespec *src,
 			       struct diff_filespec *dst,
-			       int minimum_score)
+			       int minimum_score,
+			       int skip_unmodified)
 {
 	/* src points at a file that existed in the original tree (or
 	 * optionally a file in the destination tree) and dst points
@@ -151,6 +189,12 @@ static int estimate_similarity(struct repository *r,
 	struct diff_populate_filespec_options dpf_options = {
 		.check_size_only = 1
 	};
+	struct prefetch_options prefetch_options = {r, skip_unmodified};
+
+	if (r == the_repository && has_promisor_remote()) {
+		dpf_options.missing_object_cb = prefetch;
+		dpf_options.missing_object_data = &prefetch_options;
+	}
 
 	/* We deal only with regular files.  Symlink renames are handled
 	 * only when they are exact matches --- in other words, no edits
@@ -190,9 +234,11 @@ static int estimate_similarity(struct repository *r,
 	if (max_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
 		return 0;
 
-	if (!src->cnt_data && diff_populate_filespec(r, src, NULL))
+	dpf_options.check_size_only = 0;
+
+	if (!src->cnt_data && diff_populate_filespec(r, src, &dpf_options))
 		return 0;
-	if (!dst->cnt_data && diff_populate_filespec(r, dst, NULL))
+	if (!dst->cnt_data && diff_populate_filespec(r, dst, &dpf_options))
 		return 0;
 
 	if (diffcore_count_changes(r, src, dst,
@@ -569,7 +615,8 @@ void diffcore_rename(struct diff_options *options)
 
 			this_src.score = estimate_similarity(options->repo,
 							     one, two,
-							     minimum_score);
+							     minimum_score,
+							     skip_unmodified);
 			this_src.name_score = basename_same(one, two);
 			this_src.dst = i;
 			this_src.src = j;
diff --git a/diffcore.h b/diffcore.h
index 3b2020ce93..d2a63c5c71 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -65,9 +65,22 @@ void free_filespec(struct diff_filespec *);
 void fill_filespec(struct diff_filespec *, const struct object_id *,
 		   int, unsigned short);
 
+/*
+ * Prefetch the entries in diff_queued_diff. The parameter is a pointer to a
+ * struct repository.
+ */
+void diff_queued_diff_prefetch(void *repository);
+
 struct diff_populate_filespec_options {
 	unsigned check_size_only : 1;
 	unsigned check_binary : 1;
+
+	/*
+	 * If an object is missing, diff_populate_filespec() will invoke this
+	 * callback before attempting to read that object again.
+	 */
+	void (*missing_object_cb)(void *);
+	void *missing_object_data;
 };
 int diff_populate_filespec(struct repository *, struct diff_filespec *,
 			   const struct diff_populate_filespec_options *);
@@ -185,4 +198,12 @@ int diffcore_count_changes(struct repository *r,
 			   unsigned long *src_copied,
 			   unsigned long *literal_added);
 
+/*
+ * If filespec contains an OID and if that object is missing from the given
+ * repository, add that OID to to_fetch.
+ */
+void diff_add_if_missing(struct repository *r,
+			 struct oid_array *to_fetch,
+			 const struct diff_filespec *filespec);
+
 #endif
diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
index 4831ad35e6..c1ed1c2fc4 100755
--- a/t/t4067-diff-partial-clone.sh
+++ b/t/t4067-diff-partial-clone.sh
@@ -131,4 +131,52 @@ test_expect_success 'diff with rename detection batches blobs' '
 	test_line_count = 1 done_lines
 '
 
+test_expect_success 'diff does not fetch anything if inexact rename detection is not needed' '
+	test_when_finished "rm -rf server client trace" &&
+
+	test_create_repo server &&
+	echo a >server/a &&
+	printf "b\nb\nb\nb\nb\n" >server/b &&
+	git -C server add a b &&
+	git -C server commit -m x &&
+	mv server/b server/c &&
+	git -C server add c &&
+	git -C server commit -a -m x &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
+
+	# Ensure no fetches.
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff --raw -M HEAD^ HEAD &&
+	! test_path_exists trace
+'
+
+test_expect_success 'diff --break-rewrites fetches only if necessary, and batches blobs if it does' '
+	test_when_finished "rm -rf server client trace" &&
+
+	test_create_repo server &&
+	echo a >server/a &&
+	printf "b\nb\nb\nb\nb\n" >server/b &&
+	git -C server add a b &&
+	git -C server commit -m x &&
+	printf "c\nc\nc\nc\nc\n" >server/b &&
+	git -C server commit -a -m x &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
+
+	# Ensure no fetches.
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff --raw -M HEAD^ HEAD &&
+	! test_path_exists trace &&
+
+	# But with --break-rewrites, ensure that there is exactly 1 negotiation
+	# by checking that there is only 1 "done" line sent. ("done" marks the
+	# end of negotiation.)
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff --break-rewrites --raw -M HEAD^ HEAD &&
+	grep "git> done" trace >done_lines &&
+	test_line_count = 1 done_lines
+'
+
 test_done
-- 
2.26.0.292.g33ef6b2f38-goog

