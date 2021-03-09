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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AA9C433E6
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242DE6528C
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhCIGZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 01:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhCIGYu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 01:24:50 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA84AC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 22:24:49 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h98so13885029wrh.11
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 22:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nZUKeGnNFRF3r6KguNhsE8AYlzwtAyHtm9VlL4qyA2s=;
        b=pLQwm9m9/6PJ6mcJDvP9WZMyU4ocZkhq+6Xkf+rUKjsmxohmQZVabuCjDkfZGePFdS
         6vdJCTi6okW2FoSp1b+oHjC35W8UkZDTDMoc+GK9X2r8e/uG/svfZuNrcLYEW1ysbUzD
         d7OIGcMXrNwC3gvyj8KIeALvXpbe/0BECpx+QP5RKhIdu7Nd+VRqxAJwmCFLl2bBL9Z2
         KOeHeUwwCTNokUigdqAhBliROEd0HRwW76Ngzt7RX8cWALcGoSZKb3FE8JoMhDFtKKsu
         2H6EUvl6ysx1n2ycdUMZ4IVkKk/m+DZBvnzUGQ0GwgrGk0arFCwR7JoMJilFM8K8x16+
         JM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nZUKeGnNFRF3r6KguNhsE8AYlzwtAyHtm9VlL4qyA2s=;
        b=X0nxcPfC+TeLea+IN+5oRGr3+bxQh9gt0bb6PKpi/y1n85rLsv2xpf95qWfNDCeS74
         EWj8A0vn/m0AW4xhVOZul9LtQCw1AYjbNck2QhrLhOPPRp26xC8s3gxedIN52WLCpuN4
         xmDhhiiR7RdONl+2tVz+EHq7Jd8EXo8GGIN7+Go9RXk44Gf+E8IoIfeECENAGhmGsqsC
         RKQR8iemZoypajAqqrnE7FFPxoOC3EyDS8eApigX3NSV6tiTMTG+eaP9zVQWDRdBWgoe
         9vWolBEuUABPR4UDwzq2iP6fjj2tlGL6PbQPbRBj5HBiOE4AiEbiHpAFOqXXT4dWxuF2
         k5QQ==
X-Gm-Message-State: AOAM530WBFurIFbN2h6T62+SGnSdbG3kZ7C1A6Q/m/jLjo8rVI8Q4GB5
        nkCiD+VUGvbN0RXgxF3g6KAC9d4jwto=
X-Google-Smtp-Source: ABdhPJxbTCQnwTEg5vHJbL8GjPfE6FWwASnxTgBWXmo3M7hZb8uxWnKJm9WTRXRalUkat7aHr3r3tA==
X-Received: by 2002:adf:a1d8:: with SMTP id v24mr25387975wrv.378.1615271088484;
        Mon, 08 Mar 2021 22:24:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm2467015wmd.27.2021.03.08.22.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 22:24:48 -0800 (PST)
Message-Id: <3ca16a5e3466914c1c7efa79843395a4dfc3c3f1.1615271086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
        <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 06:24:36 +0000
Subject: [PATCH v2 01/10] merge-ort: use STABLE_QSORT instead of QSORT where
 required
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

rename/rename conflict handling depends on the fact that if both sides
renamed the same path, that the one on the MERGE_SIDE1 will appear first
in the combined diff_queue_struct passed to process_renames().  Since we
add all pairs from MERGE_SIDE1 to combined first, and then all pairs
from MERGE_SIDE2, and then sort based on filename, this will only be
true if the sort used is stable.  This was found due to the fact that
Mac, unlike Linux, apparently has a system-defined qsort that is not
stable.

While we are at it, review the other callers of QSORT and add comments
about why they can remain as calls to QSORT instead of being modified
to call STABLE_QSORT.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 603d30c52170..5309488fd9d8 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2289,7 +2289,7 @@ static int detect_and_process_renames(struct merge_options *opt,
 	clean &= collect_renames(opt, &combined, MERGE_SIDE2,
 				 &renames->dir_renames[1],
 				 &renames->dir_renames[2]);
-	QSORT(combined.queue, combined.nr, compare_pairs);
+	STABLE_QSORT(combined.queue, combined.nr, compare_pairs);
 	trace2_region_leave("merge", "directory renames", opt->repo);
 
 	trace2_region_enter("merge", "process renames", opt->repo);
@@ -2415,6 +2415,7 @@ static void write_tree(struct object_id *result_oid,
 	 */
 	relevant_entries.items = versions->items + offset;
 	relevant_entries.nr = versions->nr - offset;
+	/* No need for STABLE_QSORT -- filenames must be unique */
 	QSORT(relevant_entries.items, relevant_entries.nr, tree_entry_order);
 
 	/* Pre-allocate some space in buf */
@@ -3190,6 +3191,11 @@ static int record_conflicted_index_entries(struct merge_options *opt,
 	 * entries we added to the end into their right locations.
 	 */
 	remove_marked_cache_entries(index, 1);
+	/*
+	 * No need for STABLE_QSORT -- cmp_cache_name_compare sorts primarily
+	 * on filename and secondarily on stage, and (name, stage #) are a
+	 * unique tuple.
+	 */
 	QSORT(index->cache, index->cache_nr, cmp_cache_name_compare);
 
 	return errs;
-- 
gitgitgadget

