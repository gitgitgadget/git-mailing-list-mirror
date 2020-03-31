Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B123C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 02:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF102072D
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 02:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKtSo1ZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgCaCEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 22:04:23 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:54976 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgCaCEX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 22:04:23 -0400
Received: by mail-pl1-f201.google.com with SMTP id p8so14588624plr.21
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 19:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dO5sVnEW5hwbi+dAh6D9pHgoDe16/xynZ+5FIN9mYLI=;
        b=pKtSo1ZSk2cngoddEgh9XepZ8gMQ2sYhPSP9bLjEj1jUr7Cwh78U7NFBmN/26RKtU1
         faNOBSGBbTosJprGVg2MP6sgiJgDx3wpEcJIlGvqSVhj5TeiHkj4C1Vf9rhEz2xP0Xdo
         yDWM5YPwo0F3KEondfkekNFET6HqYXVXiWiq7FZg+L7ZPuWmRrH15wBNrb7UdbWv5JWr
         mWIVdMgDcAs+Y41evM1/0n03jYPxW7RQRxQ1nO8Ir+vzZFbfqPJO6utDZPOSo1qFAA15
         n1dInwMLbs0wcJYh8TLS8nvqB08tMDjHwXXlepzF1u97NIbLjYF6hhR7Dikf70n4pNXi
         m/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dO5sVnEW5hwbi+dAh6D9pHgoDe16/xynZ+5FIN9mYLI=;
        b=Ibx61rdusH00SGNV6y5AkP/UyLtCJR9Idyha3Wkock2JfppH8cZGklaeuK9gNRbPX+
         HMe/r2fEwItP7Ix3grr5cjAUxNaGY4dRxjYS5d1aDIdgQ8TJcD5IXaeeqjUhbf50LNTR
         TMUEfD9YKD4QqKMzUGDCt8+ne+TDJzMxAms6XnHtM83JXa23g3mgclv5TEk99PxicAHK
         RoUZ7o557bkLLHpjx+dtj80aFQ4zqkDbPQMbU1bYjNO6boxpGZ6jpWD/Mp+KbqFp4x1M
         7bezNK2FSKHiP/SI9pS022BdZKbfa+UrINHkRgOP+ZuYbRwCwPwwgcIIpP+NGzlS8eW8
         2Pzw==
X-Gm-Message-State: AGi0PuY2HOPmGkvd5m7otj+cgcoKDtPTpVn/Lm82Qqx7Rq9fDZSC5FUO
        x46o6lNEB8th79xyZQ0q3F77cxoYKlTk8jlKyb6rEnSuic3LrMWCsuvXracqcIXApyl+TWqA8ZL
        tBHHeWtBQme8j2WuTF/MD7+Q5xWuwHAz6M+p4XYT7cooS2ghb5NmhH/yyiS5aZeciy0L6pISI3j
        lo
X-Google-Smtp-Source: APiQypLZNQfIQoCH+KiNDSdyppwK9QQqBterw/QuKzn/Ax+jw5CfP/H9HXrd/kp/wHjM+SOaF9CDmgEXcO6v7Fl9srWJ
X-Received: by 2002:a17:90a:e003:: with SMTP id u3mr1127553pjy.157.1585620261439;
 Mon, 30 Mar 2020 19:04:21 -0700 (PDT)
Date:   Mon, 30 Mar 2020 19:04:18 -0700
Message-Id: <20200331020418.55640-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH] diff: restrict when prefetching occurs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
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
I decided to revisit [1] because at $DAYJOB there was a new case that
required this. I used Peff's code from [2] for the rebase part, and also
automatically prefetch if blob data will be included in the output of
the diff and/or break-rewrite detection is requested.

[1] https://lore.kernel.org/git/20200128213508.31661-1-jonathantanmy@google.com/
[2] https://lore.kernel.org/git/20200130055136.GA2184413@coredump.intra.peff.net/
---
 diff.c                        | 26 +++++++++++++++----
 diffcore-rename.c             | 40 +++++++++++++++++++++++++++-
 diffcore.h                    |  2 +-
 t/t4067-diff-partial-clone.sh | 49 +++++++++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 1010d806f5..19c5d638d6 100644
--- a/diff.c
+++ b/diff.c
@@ -6507,10 +6507,24 @@ static void add_if_missing(struct repository *r,
 
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
@@ -6520,6 +6534,8 @@ void diffcore_std(struct diff_options *options)
 			add_if_missing(options->repo, &to_fetch, p->one);
 			add_if_missing(options->repo, &to_fetch, p->two);
 		}
+		prefetched = 1;
+
 		if (to_fetch.nr)
 			/*
 			 * NEEDSWORK: Consider deduplicating the OIDs sent.
@@ -6538,7 +6554,7 @@ void diffcore_std(struct diff_options *options)
 			diffcore_break(options->repo,
 				       options->break_opt);
 		if (options->detect_rename)
-			diffcore_rename(options);
+			diffcore_rename(options, prefetched);
 		if (options->break_opt != -1)
 			diffcore_merge_broken();
 	}
diff --git a/diffcore-rename.c b/diffcore-rename.c
index e189f407af..962565f066 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -7,6 +7,7 @@
 #include "object-store.h"
 #include "hashmap.h"
 #include "progress.h"
+#include "promisor-remote.h"
 
 /* Table of rename/copy destinations */
 
@@ -448,7 +449,18 @@ static int find_renames(struct diff_score *mx, int dst_cnt, int minimum_score, i
 	return count;
 }
 
-void diffcore_rename(struct diff_options *options)
+static void add_if_missing(struct repository *r,
+			   struct oid_array *to_fetch,
+			   const struct diff_filespec *filespec)
+{
+	if (filespec && filespec->oid_valid &&
+	    !S_ISGITLINK(filespec->mode) &&
+	    oid_object_info_extended(r, &filespec->oid, NULL,
+				     OBJECT_INFO_FOR_PREFETCH))
+		oid_array_append(to_fetch, &filespec->oid);
+}
+
+void diffcore_rename(struct diff_options *options, int prefetched)
 {
 	int detect_rename = options->detect_rename;
 	int minimum_score = options->rename_score;
@@ -538,6 +550,32 @@ void diffcore_rename(struct diff_options *options)
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
+			add_if_missing(options->repo, &to_fetch, rename_dst[i].two);
+		}
+		for (i = 0; i < rename_src_nr; i++)
+			add_if_missing(options->repo, &to_fetch, rename_src[i].p->one);
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
index 7c07347e42..9f69506574 100644
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
diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
index 4831ad35e6..7acb64727d 100755
--- a/t/t4067-diff-partial-clone.sh
+++ b/t/t4067-diff-partial-clone.sh
@@ -131,4 +131,53 @@ test_expect_success 'diff with rename detection batches blobs' '
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
+	rm server/b &&
+	printf "b\nb\nb\nb\nb\n" >server/c &&
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
2.26.0.rc2.310.g2932bb562d-goog

