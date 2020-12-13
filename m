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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38283C4361B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D95CC22D72
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391436AbgLMIFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgLMIFL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:05:11 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF15C0613D3
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:31 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 91so13249916wrj.7
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wexj9gd+qsmT1DDQD7Wmh03jp7SfOBdvrUOJZ+r+Qfc=;
        b=NivFQyeVZ3544hruaH02lLtxdV8viaSg55W53YlddHn8bJFHlyoA8Q3IAswd+pe8fE
         sLHob7X6jI6+r00AwSUFqAjLsvK9ix5pmniZ4h8lvqz3wz68V0OQgaIsDl9xA8RXIMPA
         Y+J78NSYwYKJj4OljZEMydm3wCEDwbIIHlp0dtdOGrG4yyDNOhjTce8HY92IScyzjp4c
         2k84O+BsTwYx0PcD/HCK5wMycpBDDv4RTUGS63u8t2Pmeyw+zMEYENjA8pSBqk/G7EL0
         Dyp9qAudM1faeIj5kWXbCHfssQhn9A8htqK7R5amkJBmnkbQ/VuhKTSmxx8MVuH6ZOde
         ghgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wexj9gd+qsmT1DDQD7Wmh03jp7SfOBdvrUOJZ+r+Qfc=;
        b=XELO/svGBrFE8mJaAA9FbBimFxKYBwLlmouNjMiCxUpbicgZri3pM9T1GVP2WEjgQZ
         CiktWbnYjQ2J0lEtS3z/yAJkF4/mpoRWvUzoovOnUz+ITtYb+vBgIbe/dIqU3pM4yYLv
         It27G20jSsSPXNd7n9DMzdqa9Ysqm0qI5JgISa+y2lx80M8Cji8fYN4UCanymWWLkckq
         Wsxsi92d5lvkRGiMZ92F+ra2uLLwEbSFKAPcY2j9oybS8pGIO/e45nkWCjhWqEdNijp5
         +HKfwCmcdoJ/csUUIfK76C4O/6Pekb4IIyN6wygzrif5sDXEJ7xIksqTbGUINsNY3LGv
         XfxQ==
X-Gm-Message-State: AOAM532xvjH8pfgeXqCe9B5OUOTJjUqHAmQRMvfng/uSrvuRo/5tyvaC
        9HZSb+3l+3+7J0iY3pNjiauD8LQb8ns=
X-Google-Smtp-Source: ABdhPJwAi2jPt11gM1a7vVK0r5B+ppOtKeuJ4NETN0bbO3ZoEgDizE4UXJwnnBd1aoR2Rf/fo9bPYQ==
X-Received: by 2002:adf:80d0:: with SMTP id 74mr2211971wrl.110.1607846669868;
        Sun, 13 Dec 2020 00:04:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u85sm23072518wmu.43.2020.12.13.00.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:29 -0800 (PST)
Message-Id: <518dde86966cba9aba211f933e74672fba95509a.1607846667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
        <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:08 +0000
Subject: [PATCH v3 01/20] merge-ort: setup basic internal data structures
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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
 merge-ort.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index b487901d3ec..3325c9c0a2c 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -17,6 +17,153 @@
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
+	 * For filemask and dirmask, the ith bit corresponds to whether the
+	 * ith entry is a file (filemask) or a directory (dirmask).  Thus,
+	 * filemask & dirmask is always zero, and filemask | dirmask is at
+	 * most 7 but can be less when a path does not appear as either a
+	 * file or a directory on at least one side of history.
+	 *
+	 * Note that these masks are related to enum merge_side, as the ith
+	 * entry corresponds to side i.
+	 *
+	 * These values come from a traverse_trees() call; more info may be
+	 * found looking at tree-walk.h's struct traverse_info,
+	 * particularly the documentation above the "fn" member (note that
+	 * filemask = mask & ~dirmask from that documentation).
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

