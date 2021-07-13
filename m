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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D43C07E96
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 19:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC996128E
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 19:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhGMTgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 15:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbhGMTgG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 15:36:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3900EC0613E9
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 12:33:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f17so120628wrt.6
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IH+wXJBQVGwRASbH9nLVutMF1YTBqHdkkh0Trwn5GRI=;
        b=CMFhg/ROcw3K02h3cZ9efbnhS283L76M8x9nT2ajeuTw9aMCRnowt8bInJ7o3R3m9o
         ySlgPuVhu7fiSkksVW9FzT1gOWiZCLjG8Qi7O9tQeW2ctS6chCl8eR4GVVrB7U62NQGR
         XUqn5setqu89xKWH0XNvFIdnFu6ov/sFqEQLNpJrE2U4JrGV8th5uHx6Zy/xg10rZehQ
         6OkOTvIN3Hll8LT04V/b0QxDl8ivNSVleRg9ZJ0z7P724pJTirep39ScJ7cNKPoLTt0G
         EXx6MgWTGAQxvaBtMniP2afQ9ZvJ9jylEG22ABJZDtPlqt4qyQ0i6WvDncHyLrGVfdKJ
         LCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IH+wXJBQVGwRASbH9nLVutMF1YTBqHdkkh0Trwn5GRI=;
        b=U3Lqh2wm+rTcuV6YbijobHmWwA+kWdXF4mx6LzEtk9UvmfxUaZbsZvcgOsDku8mzwg
         uyFqkh4ET0pL1xIpI9BG6C1sekqgpdz7curisnS1WZRM4i7IvvDaN2la5uJ6TQZcsxoG
         2eYVwUPip8CYzb56Cw/bv8ldkURUlBwBSc5anYm3N3sFbSRBKCKI+DumuHQw+tqVoVOg
         YPPRmfV3bKqehMFhXA+0AhxfosOjUivrWMnN8SAGK95Q/wEu2YW9IdPr8qWx02CyXXIu
         /uiDyE8fGCgIIGrfe4LKk7KrGtnpN9cSpKYj782m1yFax/8IZcZX4JbWSXEDP7kMepMn
         JYXA==
X-Gm-Message-State: AOAM533eZMVu67jqGqmJDqe3COje4ZcehhpKx3Par8rEkcyVR290iXrv
        +3OgGL0IjZYFbq/iYhE1C76oLKdAczA=
X-Google-Smtp-Source: ABdhPJw6Ni3Ia3eKIZCU29UMJEqVNy1B9dEdwwSgczulLW3LkmX+0+5pPCahHAulwRFaiMcdBZPcqw==
X-Received: by 2002:adf:de84:: with SMTP id w4mr7936554wrl.104.1626204788898;
        Tue, 13 Jul 2021 12:33:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6sm10764427wrm.97.2021.07.13.12.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 12:33:08 -0700 (PDT)
Message-Id: <317553eadb68ce162b5ebea24045a9ca75342e91.1626204784.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
        <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Jul 2021 19:33:01 +0000
Subject: [PATCH v2 5/7] merge-ort: defer recursing into directories when merge
 base is matched
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When one side of history matches the merge base (including when the
merge base has no entry for the given directory), have
collect_merge_info_callback() defer recursing into the directory.  To
ensure those entries are eventually handled, add a call to
handled_deferred_entries() in collect_merge_info() after
traverse_trees() returns.

Note that the condition in collect_merge_info_callback() may look more
complicated than necessary at first glance;
renames->trivial_merges_okay[side] is always true until
handle_deferred_entries() is called, and possible_trivial_merges[side]
is always empty right now (and in the future won't be filled until
handle_deferred_entries() is called).  However, when
handle_deferred_entries() calls traverse_trees() for the relevant
deferred directories, those traverse_trees() calls will once again end
up in collect_merge_info_callback() for all the entries under those
subdirectories.  The extra conditions are there for such deferred cases
and will be used more as we do more with those variables.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index eb0e18d7546..bf0712d18a0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1141,8 +1141,35 @@ static int collect_merge_info_callback(int n,
 		struct tree_desc t[3];
 		void *buf[3] = {NULL, NULL, NULL};
 		const char *original_dir_name;
-		int i, ret;
+		int i, ret, side;
 
+		/*
+		 * Check for whether we can avoid recursing due to one side
+		 * matching the merge base.  The side that does NOT match is
+		 * the one that might have a rename destination we need.
+		 */
+		assert(!side1_matches_mbase || !side2_matches_mbase);
+		side = side1_matches_mbase ? MERGE_SIDE2 :
+			side2_matches_mbase ? MERGE_SIDE1 : MERGE_BASE;
+		if (filemask == 0 && (dirmask == 2 || dirmask == 4)) {
+			/*
+			 * Also defer recursing into new directories; set up a
+			 * few variables to let us do so.
+			 */
+			ci->match_mask = (7 - dirmask);
+			side = dirmask / 2;
+		}
+		if (renames->dir_rename_mask != 0x07 &&
+		    (side != MERGE_BASE) &&
+		    renames->trivial_merges_okay[side] &&
+		    !strset_contains(&renames->target_dirs[side], pi.string)) {
+			strintmap_set(&renames->possible_trivial_merges[side],
+				      pi.string, renames->dir_rename_mask);
+			renames->dir_rename_mask = prev_dir_rename_mask;
+			return mask;
+		}
+
+		/* We need to recurse */
 		ci->match_mask &= filemask;
 		newinfo = *info;
 		newinfo.prev = info;
@@ -1196,7 +1223,6 @@ static int collect_merge_info_callback(int n,
 	return mask;
 }
 
-MAYBE_UNUSED
 static int handle_deferred_entries(struct merge_options *opt,
 				   struct traverse_info *info)
 {
@@ -1285,6 +1311,8 @@ static int collect_merge_info(struct merge_options *opt,
 
 	trace2_region_enter("merge", "traverse_trees", opt->repo);
 	ret = traverse_trees(NULL, 3, t, &info);
+	if (ret == 0)
+		ret = handle_deferred_entries(opt, &info);
 	trace2_region_leave("merge", "traverse_trees", opt->repo);
 
 	return ret;
-- 
gitgitgadget

