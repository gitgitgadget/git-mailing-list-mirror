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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B01CC4320E
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A30260FE7
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhGaR1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 13:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhGaR1u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 13:27:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A527AC0613CF
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c16so15692613wrp.13
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yzkzbi/Slg3JVOXhChvUByogsyK3fYn9Uf+8FgTW9dE=;
        b=GnFRTSRunx2P9y7EslAKqBSLmIK+D2XC8Tb7MZKjWtNapjESVLsM91QO8JXOc2GN2j
         GPMWS7xDRXd3BxCwI7mmvFSMJFckLad6b6PVSOYNLXVB3H4+9ptXy+MNmbjqJMM/jqnU
         D86NP0TsoPwYV91CQR1V85K+7oDhbmdZKAGl82oTZ97J1qlVVw+5OzCh0e6mSUWW1ln4
         s7QLfZLZyMf379U/5riUsGSjz9ZWF/uSBwDyYxB1hJHaaUqlVEuLrtcW+VBcDNXkMEWU
         nSX9eqK/ICA7CsjQ2n0lXiUAUe7eKM8cXKTXOmAYrgHWPlb4Q54jUWd5woMSVqMCQWDV
         e7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yzkzbi/Slg3JVOXhChvUByogsyK3fYn9Uf+8FgTW9dE=;
        b=DsHk1OcPgC4R561D6NYMpXOsqUh/ZgNEU1VrINo4sAJJi8sbah+PzoKNrXeUUtJZyY
         Kb8I7hA2ITvrp3J4AMDkI8zAz66+3cIMxri/PhnHDbhH7UJnNdHXjqUwnmOxvlJ6TuEx
         LMK8svRnERoRFshkEzF7Ysh9ZcKBJx4n+lZCWiFEtfMYnqgYuPMKEErCFZShFhKXcUr6
         lZMxx98y/FmGoVNgBLuwEFrL//nr9DRLtOkaIRP1AR0VqW4CESSYURv5/VDF4FAlmM1r
         Ej4mCDPUZy102PRSQBUW4iJP/Phxku5GOFY4L4fUekQdL2WJHSc+qWKWAKRZl7OH/n1h
         TRgA==
X-Gm-Message-State: AOAM531xqpln9VsdOcSYoav6IokswBo4S0bByo4y6qtx3bvcJY243CSC
        0ju1mv8920AurlxsSY35/ofSLerhX4U=
X-Google-Smtp-Source: ABdhPJwgMw/zvtQ73BL9nf4S0LXbF34xKpyJxxMLQ9qiGYhxu5TrpFVH/Ygoe+0dh8pjUjqDD4ew8Q==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr9153112wrj.18.1627752461306;
        Sat, 31 Jul 2021 10:27:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4sm4989680wmq.7.2021.07.31.10.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:27:40 -0700 (PDT)
Message-Id: <e075d985f269cdbf1fc67c99584b85d07538d603.1627752458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
References: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
        <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Jul 2021 17:27:30 +0000
Subject: [PATCH v4 1/9] merge-ort: rename str{map,intmap,set}_func()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In order to make it clearer that these three variables holding a
function refer to functions that will clear the strmap/strintmap/strset,
rename them to str{map,intmap,set}_clear_func().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index e75b524153e..401a40247a3 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -519,11 +519,11 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 {
 	struct rename_info *renames = &opti->renames;
 	int i;
-	void (*strmap_func)(struct strmap *, int) =
+	void (*strmap_clear_func)(struct strmap *, int) =
 		reinitialize ? strmap_partial_clear : strmap_clear;
-	void (*strintmap_func)(struct strintmap *) =
+	void (*strintmap_clear_func)(struct strintmap *) =
 		reinitialize ? strintmap_partial_clear : strintmap_clear;
-	void (*strset_func)(struct strset *) =
+	void (*strset_clear_func)(struct strset *) =
 		reinitialize ? strset_partial_clear : strset_clear;
 
 	/*
@@ -534,14 +534,14 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	 * to deallocate them.
 	 */
 	free_strmap_strings(&opti->paths);
-	strmap_func(&opti->paths, 1);
+	strmap_clear_func(&opti->paths, 1);
 
 	/*
 	 * All keys and values in opti->conflicted are a subset of those in
 	 * opti->paths.  We don't want to deallocate anything twice, so we
 	 * don't free the keys and we pass 0 for free_values.
 	 */
-	strmap_func(&opti->conflicted, 0);
+	strmap_clear_func(&opti->conflicted, 0);
 
 	/*
 	 * opti->paths_to_free is similar to opti->paths; we created it with
@@ -559,24 +559,24 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 
 	/* Free memory used by various renames maps */
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; ++i) {
-		strintmap_func(&renames->dirs_removed[i]);
-		strmap_func(&renames->dir_renames[i], 0);
-		strintmap_func(&renames->relevant_sources[i]);
+		strintmap_clear_func(&renames->dirs_removed[i]);
+		strmap_clear_func(&renames->dir_renames[i], 0);
+		strintmap_clear_func(&renames->relevant_sources[i]);
 		if (!reinitialize)
 			assert(renames->cached_pairs_valid_side == 0);
 		if (i != renames->cached_pairs_valid_side &&
 		    -1 != renames->cached_pairs_valid_side) {
-			strset_func(&renames->cached_target_names[i]);
-			strmap_func(&renames->cached_pairs[i], 1);
-			strset_func(&renames->cached_irrelevant[i]);
+			strset_clear_func(&renames->cached_target_names[i]);
+			strmap_clear_func(&renames->cached_pairs[i], 1);
+			strset_clear_func(&renames->cached_irrelevant[i]);
 			partial_clear_dir_rename_count(&renames->dir_rename_count[i]);
 			if (!reinitialize)
 				strmap_clear(&renames->dir_rename_count[i], 1);
 		}
 	}
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; ++i) {
-		strintmap_func(&renames->deferred[i].possible_trivial_merges);
-		strset_func(&renames->deferred[i].target_dirs);
+		strintmap_clear_func(&renames->deferred[i].possible_trivial_merges);
+		strset_clear_func(&renames->deferred[i].target_dirs);
 		renames->deferred[i].trivial_merges_okay = 1; /* 1 == maybe */
 	}
 	renames->cached_pairs_valid_side = 0;
-- 
gitgitgadget

