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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1065C07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 04:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B440B611C1
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 04:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhGUDoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 23:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhGUDnd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 23:43:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CD2C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 21:24:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o30-20020a05600c511eb029022e0571d1a0so191466wms.5
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 21:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YPuuJ1bhGSPcZEGk8NahRAMUPLm1QrFuQIqBcJIMtRA=;
        b=d0/nEIatA9NUyTMvPC0exf0kb69o15g9lu3e1+tv+iRx4oggo9noPR534rg3zC46zY
         GOBJCtlRgIQ8oIXhVL/5PAriWZUyRSboWRiu31NK2M+0qiIrMUfOCepPFvmy0rkWPJkQ
         8uvf3sDMX6+gO14HBmllN4up9YS/C9Y4dL2I2qwRf8eLyBSl9IbiraDoLro6jTNv7mYh
         Im25EJyzy6JBBflMF9IfwRzuu1UecRWIgAK3pzbGAWLAAr6eVLoayZiC+4bjnolZkPF2
         qhFbN6vMD5LfZ34IzRx6JLm/HpSvzT4YHLPTECUHO2QkvkCaPJRWpTm7miujyTbGzvd8
         7byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YPuuJ1bhGSPcZEGk8NahRAMUPLm1QrFuQIqBcJIMtRA=;
        b=s+9QxBF9O+vBYH6FuqLjJxfrPKk7lPbj0n49ROl1C3QzY/4rJByI1zZeVmGhMpZBib
         mY///5caW8I+QFDuy5Uq42DawLqrMqtC6NoTDJ+jOIttrfbXvSjQMjF/mR9MLoH13e+i
         fct2lZiO/SnlzP6LXw5aU1IkhqTQd8x3SeC/cPJnT17a2yJ1l6A93IdqQBjoR4RHiHVo
         fGRjEpTLU3J6CneftbBr22C93Wj5dD3Rb6+tsTUJuKcujzwiwBtYkJbLj5gxfylpzx6y
         hGrht//3qj07S4GnxMnz1b818VhPAMwB9tf40bdSm7nuydz9cpryqxFMl754ulaAfgLu
         i7mQ==
X-Gm-Message-State: AOAM530vewg6rad3u2rHiJDnT6dmUwywIz+KZeWi2zT66BZFj3ITyBJV
        NM1p4ZK1jy/8w14U9n0mjO97nLo86ZQ=
X-Google-Smtp-Source: ABdhPJxQ7BeeUFVJMxAQ/uTbTgaQ8gPdaIoUKE2SUwKqUDVGCq87xexQDoy2P2Ic3L9QkDww+4AOMQ==
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr18954426wmj.44.1626841448868;
        Tue, 20 Jul 2021 21:24:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm26456600wrv.20.2021.07.20.21.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 21:24:08 -0700 (PDT)
Message-Id: <5b01c118f10ec78eb77a696fa20a88038dfc28c9.1626841444.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v4.git.1626841444.gitgitgadget@gmail.com>
References: <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
        <pull.988.v4.git.1626841444.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 04:24:02 +0000
Subject: [PATCH v4 5/7] merge-ort: defer recursing into directories when merge
 base is matched
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
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

Acked-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index f0a07684df6..dbccf8c62e2 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1147,8 +1147,36 @@ static int collect_merge_info_callback(int n,
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
+		    side != MERGE_BASE &&
+		    renames->deferred[side].trivial_merges_okay &&
+		    !strset_contains(&renames->deferred[side].target_dirs,
+				     pi.string)) {
+			strintmap_set(&renames->deferred[side].possible_trivial_merges,
+				      pi.string, renames->dir_rename_mask);
+			renames->dir_rename_mask = prev_dir_rename_mask;
+			return mask;
+		}
+
+		/* We need to recurse */
 		ci->match_mask &= filemask;
 		newinfo = *info;
 		newinfo.prev = info;
@@ -1202,7 +1230,6 @@ static int collect_merge_info_callback(int n,
 	return mask;
 }
 
-MAYBE_UNUSED
 static int handle_deferred_entries(struct merge_options *opt,
 				   struct traverse_info *info)
 {
@@ -1291,6 +1318,8 @@ static int collect_merge_info(struct merge_options *opt,
 
 	trace2_region_enter("merge", "traverse_trees", opt->repo);
 	ret = traverse_trees(NULL, 3, t, &info);
+	if (ret == 0)
+		ret = handle_deferred_entries(opt, &info);
 	trace2_region_leave("merge", "traverse_trees", opt->repo);
 
 	return ret;
-- 
gitgitgadget

