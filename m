Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1E0C64E90
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD3F2078D
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o54JXi9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgK2HoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgK2HoN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:44:13 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730AAC0613D2
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:27 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id f190so12327545wme.1
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gy/Ul4mnZ7gWvitV4aXNcvdTXFp79UiZbsQWtGrz1KM=;
        b=o54JXi9INuYk1jRiDf66lkSFzi3gx8Xj24muabY9h0j7Jgd3DehB0cGBMDw7Ys/qbd
         2ZcuqAahBx+e1rzJ6ZGmpXcVosm5yEcQbrrqSt8J4QOf5aVgfuvdxqNKuftfZySmTUgi
         hVsu6XQQ92jdFc9shmG/DO+kCKZagY6lq61yowF5vWpfGTZU92N33VRwirLH4SJzO/m4
         vbnfowj0g36JRDT9mUHV4yN976yd8LjMuv/CClaV6s4nzrcHqFCSvwxH2ViMzBQ3+er4
         Hu8+IjU5Ldf9zPqvUiMuOlEUPLtI1AIBaGF1sxezSoyEKZkbtPZPBhYU6JzpXxvSFVRJ
         pA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gy/Ul4mnZ7gWvitV4aXNcvdTXFp79UiZbsQWtGrz1KM=;
        b=bYLrRcidTYuUowispZyEp4c0Xd4Rg9w5YqI2UfsmW5F3d9eFGsVL0YPWZDPDQLk2v4
         JKH1g6hR/CJBndEDL828hFUBSUuKp4Z88wedO73efHLIdBrQneQpj6vzve9C0p61ToFl
         /5YwrbVkooqPzG3mgpAekR7LVgulUHRGbi+hM3OGjJevcLsCM6TlHw6PQFcJHxlCPDju
         2CGF2S9hYc5gKIbIkVDGKTliIUP8swKNNcPgC4LmLDSFzf6LpHACmWQc6lsEG6xaj+IT
         Rrl4bqZ6vDOCyWtOaBBNrH0DZk8l3X3/tAAM+16mUNnaHL7vNj8SbBPplzgKea+EBb3A
         UEMg==
X-Gm-Message-State: AOAM531ruxmcq/TXuGQC+xSAk17NYb+9v4lXcUE7Zlmn7U95SCRQFvKx
        6P7PwbzvyrX2/JDGTYtmtjLKnYDtofU=
X-Google-Smtp-Source: ABdhPJxd+U5x1UhGv3nRlc1AKCNiSHO2AeVJ35BbDeQzelSIiQloKuulssmkz6mzTX9bpBIVpjjeTw==
X-Received: by 2002:a1c:f017:: with SMTP id a23mr16944157wmb.56.1606635805930;
        Sat, 28 Nov 2020 23:43:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13sm22428063wrm.24.2020.11.28.23.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 23:43:25 -0800 (PST)
Message-Id: <2568ec92c6d96dc51aff4a411900eaec8d32ce27.1606635803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 07:43:04 +0000
Subject: [PATCH 01/20] merge-ort: setup basic internal data structures
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Set up some basic internal data structures.  The only carry-over from
merge-recursive.c is call_depth, though needed_rename_limit will be
added later.

The central piece of data will definitely be the strmap "paths", which
will map every relevant pathname under consideration to either a
merged_info or a conflict_info.  ("conflicted" is a strmap that is a
subset of "paths".)

merged_info contains all relevant information for a non-conflicted
entry.  conflict_info contains a merged_info, plus any additional
information about a conflict such as the higher orders stages involved
and the names of the paths those came from (handy once renames get
involved).  If an entry remains conflicted, the merged_info portion of a
conflict_info will later be filled with whatever version of the file
should be placed in the working directory (e.g. an as-merged-as-possible
variation that contains conflict markers).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index b487901d3e..bb37fdf838 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -17,6 +17,143 @@
 #include "cache.h"
 #include "merge-ort.h"
 
+#include "strmap.h"
+
+struct merge_options_internal {
+	/*
+	 * paths: primary data structure in all of merge ort.
+	 *
+	 * The keys of paths:
+	 *   * are full relative paths from the toplevel of the repository
+	 *     (e.g. "drivers/firmware/raspberrypi.c").
+	 *   * store all relevant paths in the repo, both directories and
+	 *     files (e.g. drivers, drivers/firmware would also be included)
+	 *   * these keys serve to intern all the path strings, which allows
+	 *     us to do pointer comparison on directory names instead of
+	 *     strcmp; we just have to be careful to use the interned strings.
+	 *
+	 * The values of paths:
+	 *   * either a pointer to a merged_info, or a conflict_info struct
+	 *   * merged_info contains all relevant information for a
+	 *     non-conflicted entry.
+	 *   * conflict_info contains a merged_info, plus any additional
+	 *     information about a conflict such as the higher orders stages
+	 *     involved and the names of the paths those came from (handy
+	 *     once renames get involved).
+	 *   * a path may start "conflicted" (i.e. point to a conflict_info)
+	 *     and then a later step (e.g. three-way content merge) determines
+	 *     it can be cleanly merged, at which point it'll be marked clean
+	 *     and the algorithm will ignore any data outside the contained
+	 *     merged_info for that entry
+	 *   * If an entry remains conflicted, the merged_info portion of a
+	 *     conflict_info will later be filled with whatever version of
+	 *     the file should be placed in the working directory (e.g. an
+	 *     as-merged-as-possible variation that contains conflict markers).
+	 */
+	struct strmap paths;
+
+	/*
+	 * conflicted: a subset of keys->values from "paths"
+	 *
+	 * conflicted is basically an optimization between process_entries()
+	 * and record_conflicted_index_entries(); the latter could loop over
+	 * ALL the entries in paths AGAIN and look for the ones that are
+	 * still conflicted, but since process_entries() has to loop over
+	 * all of them, it saves the ones it couldn't resolve in this strmap
+	 * so that record_conflicted_index_entries() can iterate just the
+	 * relevant entries.
+	 */
+	struct strmap conflicted;
+
+	/*
+	 * current_dir_name: temporary var used in collect_merge_info_callback()
+	 *
+	 * Used to set merged_info.directory_name; see documentation for that
+	 * variable and the requirements placed on that field.
+	 */
+	const char *current_dir_name;
+
+	/* call_depth: recursion level counter for merging merge bases */
+	int call_depth;
+};
+
+struct version_info {
+	struct object_id oid;
+	unsigned short mode;
+};
+
+struct merged_info {
+	/* if is_null, ignore result.  otherwise result has oid & mode */
+	struct version_info result;
+	unsigned is_null:1;
+
+	/*
+	 * clean: whether the path in question is cleanly merged.
+	 *
+	 * see conflict_info.merged for more details.
+	 */
+	unsigned clean:1;
+
+	/*
+	 * basename_offset: offset of basename of path.
+	 *
+	 * perf optimization to avoid recomputing offset of final '/'
+	 * character in pathname (0 if no '/' in pathname).
+	 */
+	size_t basename_offset;
+
+	 /*
+	  * directory_name: containing directory name.
+	  *
+	  * Note that we assume directory_name is constructed such that
+	  *    strcmp(dir1_name, dir2_name) == 0 iff dir1_name == dir2_name,
+	  * i.e. string equality is equivalent to pointer equality.  For this
+	  * to hold, we have to be careful setting directory_name.
+	  */
+	const char *directory_name;
+};
+
+struct conflict_info {
+	/*
+	 * merged: the version of the path that will be written to working tree
+	 *
+	 * WARNING: It is critical to check merged.clean and ensure it is 0
+	 * before reading any conflict_info fields outside of merged.
+	 * Allocated merge_info structs will always have clean set to 1.
+	 * Allocated conflict_info structs will have merged.clean set to 0
+	 * initially.  The merged.clean field is how we know if it is safe
+	 * to access other parts of conflict_info besides merged; if a
+	 * conflict_info's merged.clean is changed to 1, the rest of the
+	 * algorithm is not allowed to look at anything outside of the
+	 * merged member anymore.
+	 */
+	struct merged_info merged;
+
+	/* oids & modes from each of the three trees for this path */
+	struct version_info stages[3];
+
+	/* pathnames for each stage; may differ due to rename detection */
+	const char *pathnames[3];
+
+	/* Whether this path is/was involved in a directory/file conflict */
+	unsigned df_conflict:1;
+
+	/*
+	 * For filemask and dirmask, see tree-walk.h's struct traverse_info,
+	 * particularly the documentation above the "fn" member.  Note that
+	 * filemask = mask & ~dirmask from that documentation.
+	 */
+	unsigned filemask:3;
+	unsigned dirmask:3;
+
+	/*
+	 * Optimization to track which stages match, to avoid the need to
+	 * recompute it in multiple steps. Either 0 or at least 2 bits are
+	 * set; if at least 2 bits are set, their corresponding stages match.
+	 */
+	unsigned match_mask:3;
+};
+
 void merge_switch_to_result(struct merge_options *opt,
 			    struct tree *head,
 			    struct merge_result *result,
-- 
gitgitgadget

