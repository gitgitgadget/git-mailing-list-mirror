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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5207FC433E6
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1498665290
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhCIAK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 19:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhCIAKD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 19:10:03 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38C4C06175F
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 16:10:02 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l12so13314640wry.2
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 16:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HfxVlplU/cnoYrBNq0JnG8uKRsCkGyRl+116KdStR84=;
        b=SyO7lgQBI3F1p+QbjW2ACuDpFyJsgX0OIHeRxsZLPJ8fP0zNaqGb/sUXS2Jh6uawx9
         pzZlpMxd36MRo761J59QRYvtVNWVlZb1KYVB4GtgSSq8fcLS+RISIC8Q9ikHtmN5x4HB
         /W+FfujqhQOQDnZso3AMu0dlH+J1S8qYiAoi/xbLsyGnPhHhPyUvZYEL48WdE6KSYTg4
         MeSEsL+dCtkm/JyTDxfxQ2GZfspVz6tXo/2OjyN6iVxdUzoWThqG23lHBr4Fz5dfWldn
         8cQf09e+9KZkJAPks1KKni9bERyVEBAamDivNV4LLm1fXwUw3F23vcJAJaA0KnPps/tN
         nKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HfxVlplU/cnoYrBNq0JnG8uKRsCkGyRl+116KdStR84=;
        b=tJbZ80gQxa4l2mwbINo09L6Ba0IgqIH9ClA/FK+geKJBQp/uxyaWhlQ1S1ymYTWPZQ
         WFeQOsY3rd1unsXzhR6BatRJkyXyFi97tsbmWCiI4BtFIUmOMdM+i6C6XkFPojBmBfMY
         4CPv0fjyrIxwnwbl+ulCKP75ly1HsvUlCIGzXvKmqUaJWDbTdzUhm3ecaYVMlqPMgTQ2
         QDH4Kp/dS/nu+YPWHHgiYKwYUgcXNMyUGU3dg4In73wSk8wXh8Q9seQoDBMqPJRmjrfk
         0/zyjIvGlWrJmLutJB+qIHnoW27BmiuasfwshDaWgx18IGkLVrPu6dKe/DvfpBZw3cQ2
         2eWg==
X-Gm-Message-State: AOAM5324cIzrv3X1J/fPgqKaIk8mXOYhedDvAPAuuJDm7l5flHZE0+yd
        f9QJO7wOVq1kHfQw0LuESSNw4S7GG4s=
X-Google-Smtp-Source: ABdhPJweKkSljX7oGO9Hi5+OCPAiWig2GpDkF8yfdm5jcKzvRZt6hLkqn/58OhiHVNULIvGHRZ8vmQ==
X-Received: by 2002:a5d:6807:: with SMTP id w7mr24902467wru.103.1615248601596;
        Mon, 08 Mar 2021 16:10:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a131sm1229344wmc.48.2021.03.08.16.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 16:10:01 -0800 (PST)
Message-Id: <dab8e3c6aee5a852ad46c569c0be729d64310ad9.1615248599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
        <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 00:09:52 +0000
Subject: [PATCH v2 1/8] diffcore-rename: enable filtering possible rename
 sources
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add the ability to diffcore_rename_extended() to allow external callers
to declare that they only need renames detected for a subset of source
files, and use that information to skip detecting renames for them.

There are two important pieces to this optimization that may not be
obvious at first glance:

  * We do not require callers to just filter the filepairs out
    to remove the non-relevant sources, because exact rename detection
    is fast and when it finds a match it can remove both a source and a
    destination whereas the relevant_sources filter can only remove a
    source.

  * We need to filter out the source pairs in a preliminary pass instead
    of adding a
       strset_contains(relevant_sources, one->path)
    check within the nested matrix loop.  The reason for that is if we
    have 30k renames, doing 30k * 30k = 900M strset_contains() calls
    becomes extraordinarily expensive and defeats the performance gains
    from this change; we only want to do 30k such calls instead.

If callers pass NULL for relevant_sources, that is special cases to
treat all sources as relevant.  Since all callers currently pass NULL,
this optimization does not yet have any effect.  Subsequent commits will
have merge-ort compute a set of relevant_sources to restrict which
sources we detect renames for, and have merge-ort pass that set of
relevant_sources to diffcore_rename_extended().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 26 +++++++++++++++++++-------
 diffcore.h        |  1 +
 merge-ort.c       |  1 +
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 1fe902ed2af0..7f6115fd9018 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -991,11 +991,12 @@ static int find_renames(struct diff_score *mx,
 	return count;
 }
 
-static void remove_unneeded_paths_from_src(int detecting_copies)
+static void remove_unneeded_paths_from_src(int detecting_copies,
+					   struct strset *interesting)
 {
 	int i, new_num_src;
 
-	if (detecting_copies)
+	if (detecting_copies && !interesting)
 		return; /* nothing to remove */
 	if (break_idx)
 		return; /* culling incompatible with break detection */
@@ -1022,12 +1023,18 @@ static void remove_unneeded_paths_from_src(int detecting_copies)
 	 *      from rename_src here.
 	 */
 	for (i = 0, new_num_src = 0; i < rename_src_nr; i++) {
+		struct diff_filespec *one = rename_src[i].p->one;
+
 		/*
 		 * renames are stored in rename_dst, so if a rename has
 		 * already been detected using this source, we can just
 		 * remove the source knowing rename_dst has its info.
 		 */
-		if (rename_src[i].p->one->rename_used)
+		if (!detecting_copies && one->rename_used)
+			continue;
+
+		/* If we don't care about the source path, skip it */
+		if (interesting && !strset_contains(interesting, one->path))
 			continue;
 
 		if (new_num_src < i)
@@ -1040,6 +1047,7 @@ static void remove_unneeded_paths_from_src(int detecting_copies)
 }
 
 void diffcore_rename_extended(struct diff_options *options,
+			      struct strset *relevant_sources,
 			      struct strset *dirs_removed,
 			      struct strmap *dir_rename_count)
 {
@@ -1060,6 +1068,8 @@ void diffcore_rename_extended(struct diff_options *options,
 	want_copies = (detect_rename == DIFF_DETECT_COPY);
 	if (dirs_removed && (break_idx || want_copies))
 		BUG("dirs_removed incompatible with break/copy detection");
+	if (break_idx && relevant_sources)
+		BUG("break detection incompatible with source specification");
 	if (!minimum_score)
 		minimum_score = DEFAULT_RENAME_SCORE;
 
@@ -1127,9 +1137,10 @@ void diffcore_rename_extended(struct diff_options *options,
 		/*
 		 * Cull sources:
 		 *   - remove ones corresponding to exact renames
+		 *   - remove ones not found in relevant_sources
 		 */
 		trace2_region_enter("diff", "cull after exact", options->repo);
-		remove_unneeded_paths_from_src(want_copies);
+		remove_unneeded_paths_from_src(want_copies, relevant_sources);
 		trace2_region_leave("diff", "cull after exact", options->repo);
 	} else {
 		/* Determine minimum score to match basenames */
@@ -1148,7 +1159,7 @@ void diffcore_rename_extended(struct diff_options *options,
 		 *   - remove ones involved in renames (found via exact match)
 		 */
 		trace2_region_enter("diff", "cull after exact", options->repo);
-		remove_unneeded_paths_from_src(want_copies);
+		remove_unneeded_paths_from_src(want_copies, NULL);
 		trace2_region_leave("diff", "cull after exact", options->repo);
 
 		/* Preparation for basename-driven matching. */
@@ -1167,9 +1178,10 @@ void diffcore_rename_extended(struct diff_options *options,
 		/*
 		 * Cull sources, again:
 		 *   - remove ones involved in renames (found via basenames)
+		 *   - remove ones not found in relevant_sources
 		 */
 		trace2_region_enter("diff", "cull basename", options->repo);
-		remove_unneeded_paths_from_src(want_copies);
+		remove_unneeded_paths_from_src(want_copies, relevant_sources);
 		trace2_region_leave("diff", "cull basename", options->repo);
 	}
 
@@ -1342,5 +1354,5 @@ void diffcore_rename_extended(struct diff_options *options,
 
 void diffcore_rename(struct diff_options *options)
 {
-	diffcore_rename_extended(options, NULL, NULL);
+	diffcore_rename_extended(options, NULL, NULL, NULL);
 }
diff --git a/diffcore.h b/diffcore.h
index c6ba64abd198..737c93a6cc79 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -166,6 +166,7 @@ void partial_clear_dir_rename_count(struct strmap *dir_rename_count);
 void diffcore_break(struct repository *, int);
 void diffcore_rename(struct diff_options *);
 void diffcore_rename_extended(struct diff_options *options,
+			      struct strset *relevant_sources,
 			      struct strset *dirs_removed,
 			      struct strmap *dir_rename_count);
 void diffcore_merge_broken(void);
diff --git a/merge-ort.c b/merge-ort.c
index 467404cc0a35..aba0b9fa54c3 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2029,6 +2029,7 @@ static void detect_regular_renames(struct merge_options *opt,
 	diff_queued_diff = renames->pairs[side_index];
 	trace2_region_enter("diff", "diffcore_rename", opt->repo);
 	diffcore_rename_extended(&diff_opts,
+				 NULL,
 				 &renames->dirs_removed[side_index],
 				 &renames->dir_rename_count[side_index]);
 	trace2_region_leave("diff", "diffcore_rename", opt->repo);
-- 
gitgitgadget

