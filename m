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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6DCC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E5A6148E
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbhGADsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 23:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhGADsw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 23:48:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB956C0613A2
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:46:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l8so6190377wry.13
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IH+wXJBQVGwRASbH9nLVutMF1YTBqHdkkh0Trwn5GRI=;
        b=cJ3qtlQUIda5EMjpycBMLYTAIFsXia54r7MEIWOFCGG5L7n8Cp4KehhMgvFZtAw+i3
         n695+6/T9PfkdMSK7wVvtQPBLvMupVe/4m+Q4q2OO7gZep981Zt6sNZa/apKjz/+c574
         HWXzpe/uDxs365dDz/AWJMIgGW6neE19HiUofZcy68j5T+EzM5Sz7Rn0wnRE3LPrC1X8
         Ia1C6dkTZ5XfHDA69ZRUDfXOnTvKKc6VOs4qKt3W/kIG9LbwjRL749HT2S47Xut6p7xF
         c+82MFjixh/MOSqFqvmRFC21qJbDw8B/ieFdgCh5Za4FITLZq4HLJU4A7eUgI6NYjV/n
         h/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IH+wXJBQVGwRASbH9nLVutMF1YTBqHdkkh0Trwn5GRI=;
        b=Mn9ngHfnpAtcCZvdHksfWRf2SLYKkRRkdejg00vzeVhWIweDZYdRL1Xpd2ey4PoDqg
         dfASBHxiAY/xAOdYzptzDrfK+ZcFfCBLHYHdn3ubxdt8/cPKfiIWZgrMZBXn2GCihqYG
         TklZK0cpfhMCPk9LY86iVqEGF3PIK2MqvpwweZhYN8QxNB1N7geTqBf0W6wkamBQrkH3
         4Yxtdarhd91IDGkvcsHiihLdFHr3E5kWeN1RyZaxz/mA5VAQE75/WgUdh9MV8bp+SIGM
         NYylHqQQKjF4R0S3jn5trFp/19Z0N7EsE9xfqWLrNeDV1l0SVOn7dybpwsYshA80vAwW
         CpZQ==
X-Gm-Message-State: AOAM532jcMAl15wnMECWXUCO3r/grR4m/YPqbZxsbQy3ynM54cCaswWz
        4+CfYpGwsIhdt5pPwShyJkuLQ/CrBF0=
X-Google-Smtp-Source: ABdhPJweBUNEXi5BzNPNmtJTF9HreFrEbUtXIcv0OK1lWnltWFP93gnuOxAmZPAiuqxJjcubRLmjRg==
X-Received: by 2002:adf:f482:: with SMTP id l2mr24755412wro.276.1625111181464;
        Wed, 30 Jun 2021 20:46:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s62sm8182876wms.13.2021.06.30.20.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 20:46:21 -0700 (PDT)
Message-Id: <317553eadb68ce162b5ebea24045a9ca75342e91.1625111177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.git.1625111177.gitgitgadget@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 03:46:15 +0000
Subject: [PATCH 5/7] merge-ort: defer recursing into directories when merge
 base is matched
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
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

