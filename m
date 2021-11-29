Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA04C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 19:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhK2TjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 14:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbhK2Tg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 14:36:57 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC46DC09B13F
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:52:49 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u1so37779153wru.13
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+dch2aTLAv85TXXA5lgJ4m8qNH4dps5WqL8q9u/O5kk=;
        b=Fg71+/Bz75h/TbYRloiE0H2jhF106Pu0WGL1EeYXQB7EY7griarSlZSq2zY8GYaTc+
         +J/W+nQHdeihcPgc24yGLOh26tuGEH1+kiT4H7KMYI5Htu5AfLAjD/Yj9LyG/NenzZdf
         TCfxO5ZVSYWdN/0fkyNMOCOrfsq1J1g+IJxCO0jgriAVO+5iy2VOQlx3S3rVvxNEVulj
         EzhzZFnB/h3GBv1KnyXO2vmvBTOWy2XpGw3q2wU+AA/Lt1EPvivqZUeAmdZOUz7oHCOi
         xu9L0PvdCAYCc7aA3yZTj89yu5GrVP4dqF3/pyUaiVBbYBk7OWJ+oKjrwUPprHFTyoUQ
         Tg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+dch2aTLAv85TXXA5lgJ4m8qNH4dps5WqL8q9u/O5kk=;
        b=uf2/oWVdM3+xHgrpMKR5leX1/yYlJ6wZq7BNkP/tFJouvqz+EaoJP5Fw9OpNOKmoeO
         Hvlb8C0hBT0Qmy/oOxyIX5sMuxjfiKP5O7sUnAArAjzKTdknYbykxRKlINnWeT4l2IKy
         Watjbujq/KW2JEvSq6PceKw+i76pDM03O2YqIHjFGBbpDbuw1u5BSHfoukk84aJcYShr
         Kps8R8L/E6QMNiL7JXiHSpVv3oBWk0mni1k6hV0Za1E+rc2lv0EQQWd+ILnPUKV23QmO
         8Ard9GrRgKjo6UsmNle8coqST29rh0wTNn+KhS3AVxKEVGwzHGOHSIwZstA7Ccop03k5
         rCXg==
X-Gm-Message-State: AOAM53101kKuA6bv9vaZjCEk5QBmQ/R4bTaDUAxZnW3aqRI6XXMuUyO3
        1NwD2AbR3y3lctF+JPtv65g4fXJiTGM=
X-Google-Smtp-Source: ABdhPJzf//UVq5fjn6nTNkSX2Kq/OFE8kwhR2yhHxU+QXtaxv2mcPmIkOQC+B4Ton5Y/FBvw4YSDYg==
X-Received: by 2002:a05:6000:1043:: with SMTP id c3mr34737374wrx.64.1638201168299;
        Mon, 29 Nov 2021 07:52:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b197sm14977525wmb.24.2021.11.29.07.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:52:47 -0800 (PST)
Message-Id: <65b0eafd27c76a8b4ced38a5521413c1c23fc2bf.1638201164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
References: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
        <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 15:52:40 +0000
Subject: [PATCH v6 5/8] reset: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Disable `command_requires_full_index` repo setting and add
`ensure_full_index` guards around code paths that cannot yet use sparse
directory index entries. `reset --soft` does not modify the index, so no
compatibility changes are needed for it to function without expanding the
index. For all other reset modes (`--mixed`, `--hard`, `--keep`, `--merge`),
the full index is expanded to prevent cache tree corruption and invalid
variable accesses.

Additionally, the `read_cache()` check verifying an uncorrupted index is
moved after argument parsing and preparing the repo settings. The index is
not used by the preceding argument handling, but `read_cache()` must be run
*after* enabling sparse index for the command (so that the index is not
expanded unnecessarily) and *before* using the index for reset (so that it
is verified as uncorrupted).

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c | 10 +++++++---
 cache-tree.c    |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index e441b6601b9..0ac0de7dc97 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -180,6 +180,7 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.flags.override_submodule_config = 1;
 	opt.repo = the_repository;
 
+	ensure_full_index(&the_index);
 	if (do_diff_cache(tree_oid, &opt))
 		return 1;
 	diffcore_std(&opt);
@@ -257,9 +258,6 @@ static void parse_args(struct pathspec *pathspec,
 	}
 	*rev_ret = rev;
 
-	if (read_cache() < 0)
-		die(_("index file corrupt"));
-
 	parse_pathspec(pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
 		       (patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0),
@@ -405,6 +403,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (intent_to_add && reset_type != MIXED)
 		die(_("-N can only be used with --mixed"));
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
 	 * the index file to the tree object we are switching to. */
diff --git a/cache-tree.c b/cache-tree.c
index 90919f9e345..9be19c85b66 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -776,6 +776,7 @@ void prime_cache_tree(struct repository *r,
 	cache_tree_free(&istate->cache_tree);
 	istate->cache_tree = cache_tree();
 
+	ensure_full_index(istate);
 	prime_cache_tree_rec(r, istate->cache_tree, tree);
 	istate->cache_changed |= CACHE_TREE_CHANGED;
 	trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);
-- 
gitgitgadget

