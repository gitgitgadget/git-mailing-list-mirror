Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA2FC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 19:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B51A206F8
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 19:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EsMIvKgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389567AbgDBTTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:19:31 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45057 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732937AbgDBTTa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 15:19:30 -0400
Received: by mail-pf1-f201.google.com with SMTP id a188so3804533pfa.12
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 12:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nJH+XkRCLKStzMVeqrYC5JZuRAXjYrckIk0im04C90w=;
        b=EsMIvKgv1lg4Ixe0jHa0stHnCRUj26d3i+3IxacTaH0Tz4hTKqeJlRXoQHOsUSYVVa
         1mjpQYZr2b02G65B0iA03PwecF+trY5mDbwKH3gWAWPYEIUGKfE7FnSoFEAjz7BNLz0R
         wg4pDTKPm8ZuRcBP7JB/Pk12v/Yyed3F7oHLfWl6tUHgqo/+EN7a0tsp7pM5G8HIKh0R
         X/Pvw3CBaiWkd3H9bOg4chogkIqXsi08KTmYCaKRNVllgl6dysBISPDBcozHo4uZm5HU
         PSqZP+h5NOXPB6r/DeKL4YjvyEbNgiQEV2+XySJnJLlv8rHUiDGYpd44z93Y9agq/U4f
         YPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nJH+XkRCLKStzMVeqrYC5JZuRAXjYrckIk0im04C90w=;
        b=QVaxpwbjQnrftVeOe2uTcpuvLuvrjKZOQZK9/9jiLxs4/fl2RI6nxRkw1s187v3VPk
         Pz0EnDhBHnoqngYZbvn7bTJX3YHCMNHgpyEiq0Qs14FEHktegrOtDKH8rR9Tmm73PcyU
         N79TET0G380TfNSnyHE3YuSMPzuFXMPnZglq2tBl/fgBoJ5mMcXA5e/0xewLk7qzpx3h
         wAN8DMVldbM8mh4NZRwQ+Sf/aCdLLfwtYPNzPRofGuX09ItJueKJa9CdN2JmFh4GBOj9
         vpqATRUP7/YLl7JFtVeKUbhz9WH6hVPHp54gMKDe6ups5zBV9f/U1/YcT7mIZNjWZ1ck
         Eafg==
X-Gm-Message-State: AGi0PuZO5QBSclfAYhp5QL3J4WuMPXnpTmCngISm58GArgfupVe6WulD
        Pe8WlGREjtR96d/fKfRHQoIUmBdlPBu2gN62dWATVMGvOhxR0DMFwMKYDs8tqHh3pb+kCG5+v11
        PbciS56RCvHlAUyi3EfBNmMqcpe2loZzmebQvA5QDeGwNY6J3pe13babErQHj5YRXZheZYPUJBK
        Fj
X-Google-Smtp-Source: APiQypLRnBcGE7G/09AYwrSdktT/zs0Ib0SSZg23iJFm3kjhRGSemS3N5ffa2VgGnlsCPABKSmAeM+JHetWkG1fi+iln
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr5572898pjq.100.1585855168698;
 Thu, 02 Apr 2020 12:19:28 -0700 (PDT)
Date:   Thu,  2 Apr 2020 12:19:17 -0700
In-Reply-To: <cover.1585854639.git.jonathantanmy@google.com>
Message-Id: <a3322cdedf019126305fcead5918d523a1b2dfbc.1585854639.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200331020418.55640-1-jonathantanmy@google.com> <cover.1585854639.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v2 2/2] diff: restrict when prefetching occurs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        stolee@gmail.com, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 7fbbcb21b1 ("diff: batch fetching of missing blobs", 2019-04-08)
optimized "diff" by prefetching blobs in a partial clone, but there are
some cases wherein blobs do not need to be prefetched. In particular, if
(1) no blob data is included in the output of the diff, (2)
break-rewrite detection is not requested, and (3) no inexact rename
detection is needed, then no blobs are read at all.

Therefore, in such a case, do not prefetch. Change diffcore_std() to
only prefetch if (1) and/or (2) is not true (currently, it always
prefetches); change diffcore_rename() to prefetch if (3) is not true and
no prefetch has yet occurred.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 diff.c                        | 38 +++++++++++++++++++--------
 diffcore-rename.c             | 37 ++++++++++++++++++++++++++-
 diffcore.h                    | 10 +++++++-
 t/t4067-diff-partial-clone.sh | 48 +++++++++++++++++++++++++++++++++++
 4 files changed, 121 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index f01b4d91b8..857f02f481 100644
--- a/diff.c
+++ b/diff.c
@@ -6494,9 +6494,9 @@ void diffcore_fix_diff_index(void)
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
@@ -6507,24 +6507,42 @@ static void add_if_missing(struct repository *r,
 
 void diffcore_std(struct diff_options *options)
 {
-	if (options->repo == the_repository && has_promisor_remote()) {
-		/*
-		 * Prefetch the diff pairs that are about to be flushed.
-		 */
+	int prefetched = 0;
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
+	     (!options->found_follow && options->break_opt != -1))) {
 		int i;
 		struct diff_queue_struct *q = &diff_queued_diff;
 		struct oid_array to_fetch = OID_ARRAY_INIT;
 
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			add_if_missing(options->repo, &to_fetch, p->one);
-			add_if_missing(options->repo, &to_fetch, p->two);
+			diff_add_if_missing(options->repo, &to_fetch, p->one);
+			diff_add_if_missing(options->repo, &to_fetch, p->two);
 		}
+
+		prefetched = 1;
+
 		/*
 		 * NEEDSWORK: Consider deduplicating the OIDs sent.
 		 */
 		promisor_remote_get_direct(options->repo,
 					   to_fetch.oid, to_fetch.nr);
+
 		oid_array_clear(&to_fetch);
 	}
 
@@ -6537,7 +6555,7 @@ void diffcore_std(struct diff_options *options)
 			diffcore_break(options->repo,
 				       options->break_opt);
 		if (options->detect_rename)
-			diffcore_rename(options);
+			diffcore_rename(options, prefetched);
 		if (options->break_opt != -1)
 			diffcore_merge_broken();
 	}
diff --git a/diffcore-rename.c b/diffcore-rename.c
index e189f407af..79ac1b4bee 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -7,6 +7,7 @@
 #include "object-store.h"
 #include "hashmap.h"
 #include "progress.h"
+#include "promisor-remote.h"
 
 /* Table of rename/copy destinations */
 
@@ -448,7 +449,7 @@ static int find_renames(struct diff_score *mx, int dst_cnt, int minimum_score, i
 	return count;
 }
 
-void diffcore_rename(struct diff_options *options)
+void diffcore_rename(struct diff_options *options, int prefetched)
 {
 	int detect_rename = options->detect_rename;
 	int minimum_score = options->rename_score;
@@ -538,6 +539,40 @@ void diffcore_rename(struct diff_options *options)
 		break;
 	}
 
+	if (!prefetched) {
+		/*
+		 * At this point we know there's actual work to do: we have rename
+		 * destinations that didn't find an exact match, and we have potential
+		 * sources. So we'll have to do inexact rename detection, which
+		 * requires looking at the blobs.
+		 *
+		 * If we haven't already prefetched, it's worth pre-fetching
+		 * them as a group now.
+		 */
+		int i;
+		struct oid_array to_fetch = OID_ARRAY_INIT;
+
+		for (i = 0; i < rename_dst_nr; i++) {
+			if (rename_dst[i].pair)
+				continue; /* already found exact match */
+			diff_add_if_missing(options->repo, &to_fetch, rename_dst[i].two);
+		}
+		for (i = 0; i < rename_src_nr; i++) {
+			if (skip_unmodified &&
+			    diff_unmodified_pair(rename_src[i].p))
+				/*
+				 * The "for" loop below will not need these
+				 * blobs, so skip prefetching.
+				 */
+				continue;
+			diff_add_if_missing(options->repo, &to_fetch, rename_src[i].p->one);
+		}
+		if (to_fetch.nr)
+			promisor_remote_get_direct(options->repo,
+						   to_fetch.oid, to_fetch.nr);
+		oid_array_clear(&to_fetch);
+	}
+
 	if (options->show_rename_progress) {
 		progress = start_delayed_progress(
 				_("Performing inexact rename detection"),
diff --git a/diffcore.h b/diffcore.h
index 7c07347e42..d7af6ab018 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -144,7 +144,7 @@ struct diff_filepair *diff_queue(struct diff_queue_struct *,
 void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
 void diffcore_break(struct repository *, int);
-void diffcore_rename(struct diff_options *);
+void diffcore_rename(struct diff_options *, int prefetched);
 void diffcore_merge_broken(void);
 void diffcore_pickaxe(struct diff_options *);
 void diffcore_order(const char *orderfile);
@@ -182,4 +182,12 @@ int diffcore_count_changes(struct repository *r,
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

