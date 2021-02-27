Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8703CC433E0
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49FC464DF5
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhB0Abm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 19:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhB0Abf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 19:31:35 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D4CC061788
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:53 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a18so2002731wrc.13
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XQkS37T12dZlfsAoYAP4aoO+V29JAFmm6r72q1zdEEQ=;
        b=DneNLHwwdNrdwzfA34Kwb0WsTgxypLG9FSGyanqSuhGYUktEhftWHZOJ+dZCO4B/+x
         dmV9r4SKEN9qH508/WVScXAKCDjkF4wZLpkDQCfugvDIcJtfZYsnQghld46N8v981CmH
         s84DE/1GUjsuegzXAdahd6kmp6ZuIBQsG4Ur/+BEGhWY/8uz1v7NWTdIC4sQaUNaclo5
         6iOEOiFzj0b6x7mxSjPnCEXcpOdHRoBdppqQsB+80wDi7bWVuK/5ufsEcW8C8RSZOaED
         dcu/dsztVCf82LGRZwywLsijMsMnvdXQFHHnT+itqCgX3kTZFMQcxcXdZjOzlIY/mmWk
         74yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XQkS37T12dZlfsAoYAP4aoO+V29JAFmm6r72q1zdEEQ=;
        b=rkZu7VU9PTfLQ+djPNgamL1BVxF0U0F5Ph8wzGAfoDHyH/N4QZqzP43mVEP6OYJKjh
         YRWcodfc/1gB01TQid9H5or3salF4US069F5U2p4LAsADR1dwEOyYW1bFcbU2fo20o2p
         7W+UNfUucaZaOExO+CahWoMQVpEuYwUszXP7ztuY/WHGWzLYqX/S2i75JFQnEVPFADNY
         mnme6MeKTKXg8qHq8hRBJu2ZVs1Bp5JN7laMx3GcGrghlVhqUkllnnqLAIgMFt4DCy9t
         C0Szfyuxiaj7+O5xWCTnPDeP8Cg8hrl7WZKzzuZtrpbICzqwfPu2MUgThH7YdRoae8gF
         geVg==
X-Gm-Message-State: AOAM530/+4TWE+6VYJTiIphFd5s4c3o0De9G1djeT6++YOmRB0W77zuC
        hjMZvILpYEIlNghwwZqgX1iSfbiUu+M=
X-Google-Smtp-Source: ABdhPJwHxTtgAx8i24OfHfyS6ZVsA3ylUVCxkdzGCoFCShYTrExuodJ4DtQBUmCGQiLM+luIrKDqAQ==
X-Received: by 2002:a05:6000:181b:: with SMTP id m27mr4852329wrh.363.1614385852706;
        Fri, 26 Feb 2021 16:30:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w11sm15137409wru.3.2021.02.26.16.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 16:30:52 -0800 (PST)
Message-Id: <21b9cf1da30e41b4e4645a4db64f4e6d15c03518.1614385849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
References: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
        <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Feb 2021 00:30:41 +0000
Subject: [PATCH v4 03/10] diffcore-rename: add a mapping of destination names
 to their indices
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Compute a mapping of full filename to the index within rename_dst where
that filename is found, and store it in idx_map.  idx_possible_rename()
needs this to quickly finding an array entry in rename_dst given the
pathname.

While at it, add placeholder initializations for dir_rename_count and
dir_rename_guess; these will be more fully populated in subsequent
commits.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index edb0effb6ef4..8eeb8c73664c 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -380,6 +380,45 @@ static char *get_dirname(const char *filename)
 	return slash ? xstrndup(filename, slash - filename) : xstrdup("");
 }
 
+static void initialize_dir_rename_info(struct dir_rename_info *info)
+{
+	int i;
+
+	info->setup = 1;
+
+	strintmap_init_with_options(&info->idx_map, -1, NULL, 0);
+	strmap_init_with_options(&info->dir_rename_guess, NULL, 0);
+	info->dir_rename_count = NULL;
+
+	/*
+	 * Loop setting up both info->idx_map.
+	 */
+	for (i = 0; i < rename_dst_nr; ++i) {
+		/*
+		 * For non-renamed files, make idx_map contain mapping of
+		 *   filename -> index (index within rename_dst, that is)
+		 */
+		if (!rename_dst[i].is_rename) {
+			char *filename = rename_dst[i].p->two->path;
+			strintmap_set(&info->idx_map, filename, i);
+		}
+	}
+}
+
+static void cleanup_dir_rename_info(struct dir_rename_info *info)
+{
+	if (!info->setup)
+		return;
+
+	/* idx_map */
+	strintmap_clear(&info->idx_map);
+
+	/* dir_rename_guess */
+	strmap_clear(&info->dir_rename_guess, 1);
+
+	/* Nothing to do for dir_rename_count, yet */
+}
+
 static const char *get_basename(const char *filename)
 {
 	/*
@@ -858,6 +897,11 @@ void diffcore_rename(struct diff_options *options)
 		remove_unneeded_paths_from_src(want_copies);
 		trace2_region_leave("diff", "cull after exact", options->repo);
 
+		/* Preparation for basename-driven matching. */
+		trace2_region_enter("diff", "dir rename setup", options->repo);
+		initialize_dir_rename_info(&info);
+		trace2_region_leave("diff", "dir rename setup", options->repo);
+
 		/* Utilize file basenames to quickly find renames. */
 		trace2_region_enter("diff", "basename matches", options->repo);
 		rename_count += find_basename_matches(options,
@@ -1026,6 +1070,7 @@ void diffcore_rename(struct diff_options *options)
 		if (rename_dst[i].filespec_to_free)
 			free_filespec(rename_dst[i].filespec_to_free);
 
+	cleanup_dir_rename_info(&info);
 	FREE_AND_NULL(rename_dst);
 	rename_dst_nr = rename_dst_alloc = 0;
 	FREE_AND_NULL(rename_src);
-- 
gitgitgadget

