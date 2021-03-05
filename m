Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E96C433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5BE864FF0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhCEAzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhCEAzl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 19:55:41 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AF1C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 16:55:41 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 7so258918wrz.0
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 16:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nZUKeGnNFRF3r6KguNhsE8AYlzwtAyHtm9VlL4qyA2s=;
        b=Vr+8Uz4ec2XdYc2ugDQMf888cIElFoq+BLW9ZWFpV2r0TtAGWpcihn7RzhybcnqhFO
         3obybpUFLT3vDLF7BWFmMy1YDSAHiF8PhFTQOfRhdkEdIhMpQaKFCssti6QLO7/bbIZ/
         HA2jeS8GZh/k4rl5+CB3yxel1SobXJt6I1G7QDbYP6nm6e/4VJ4oOoat1WW+WxqT2TbK
         0gLdTYMacfM6GGy/RgqBr1mf+z0ZAhX8MCqxvNy18jyvHSL0yul3FiTeylnGIp6MOXlP
         c0Rt/Dr9hkXutyuI4VKhD8PTwsd9oL4xk5mqoXY9NfWugqubh5hzK6PuiIIyiCeC44mo
         5/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nZUKeGnNFRF3r6KguNhsE8AYlzwtAyHtm9VlL4qyA2s=;
        b=OOIkYSCXGyCOYHBhVCxRjKQQPM4TvTG9Mo4QYQ+MCPkC7QDO/6PddcOpyaFYGIZlTg
         Wu3HX/x1D9ddF0pSabzgVuFYIse56B8jLLfZGCopB5Xbt8TOVz72JvrVmzX1Js1LZ74O
         ILgFR9f3GR+aBKP5V6oj9wvCb/s+RsT0o4vSkeL1C5+/DO6ygXItcZLp/QnUQvk1cPwi
         lDcvCfsU65560p6fgYNtX1KjY0tIGmd4C5cKv93mNXveMu+D3P4Ux5OuCyPBSz8+oALf
         Yzcdmb9Brwe6ici5duWKTKPED3KkKQ6RGIRrivWEKk2MjVTNpAQN1V246/vpUEC7h4PM
         h1/w==
X-Gm-Message-State: AOAM533DOPM4CXlJy2Dy5tNTrRlfnbAhv45oKREonWvVjRuk1iek7nFj
        spmzikXfFLtl/prSoK+eF0XyF5bGB7c=
X-Google-Smtp-Source: ABdhPJyApWQp9i/lIhgZsVElpLthag03EbgRGVbjtt+b2/z5xqENXwJiBsrSVl3A3IHBPqPO8INVNg==
X-Received: by 2002:a5d:6b45:: with SMTP id x5mr6320148wrw.415.1614905739916;
        Thu, 04 Mar 2021 16:55:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm1665860wry.90.2021.03.04.16.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 16:55:39 -0800 (PST)
Message-Id: <3ca16a5e3466914c1c7efa79843395a4dfc3c3f1.1614905738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Mar 2021 00:55:27 +0000
Subject: [PATCH 01/11] merge-ort: use STABLE_QSORT instead of QSORT where
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

