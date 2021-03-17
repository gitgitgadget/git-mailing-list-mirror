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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5B5C433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5715D64F2A
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhCQV2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhCQV2J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:28:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9474C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t9so3297344wrn.11
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=skoEo4SWYtUg71kvRBx6/BANdZpAEw7WB2wFqMP+Wc4=;
        b=RcswWThEorqqZHi4opmg2JaqGqens24L1HZXgMZa7RwUQyoJCIoLbREo18Zb2jcnxm
         DWoEqXNWM1/CNhpeqH1lXm6kqcWcu4/iERJXR6mRjEejhLFBzvSln0J6z37j1ZVo9HtX
         bB3JwKyR28joyeWhJlc+uw15gwH59DdtIk1PKZgpf5Hq9npQ/vwDImno+TKX4LpCbMff
         iV2EMdjdOK+x3xIyIz2J1Ewj0EKKUNUMDeg2/0+xG8q78u7ox7WyCB3kxD0IduvQb5Zl
         LWeetQQOymRui/F1za2udgFLCRo9dal0yBJRb6lRqbzyzgLnf46DiYV6nBmB7m74p3L9
         oA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=skoEo4SWYtUg71kvRBx6/BANdZpAEw7WB2wFqMP+Wc4=;
        b=W0yo473oruMHUz8NsxtWTJQxKLZ+t+mJlGlw73kk7B5kHB5oiVERIwqpPa5sZzmx7I
         EzxDd5lgIcO0Jf5q8FQrwYQ81sZOrC+ZObD3lwxT285FWh04BSJjM3WqiA/r/PW8nXa1
         6sOhM96rR+Io7evXbJ9TDjLqHw18Pi7M1mijSSPkN7ImZdUD1MrIWNFAu5HUpWAT5yQH
         vOSsNqqewL1ly0szvGN7LyMfnqwWrIZrv0xQMh8DgiqSjWZXJNyGEBhuXCgl/SVXFyO4
         R2Mqgmux7r5hhwCFdCigQgqOLiiJt4vVeRZlczWtRc4np4seAMDB4hkEMlizrogi+2a5
         Jn1w==
X-Gm-Message-State: AOAM532xxlf3sTmhqawOjGVIp52GZLow50QGQct0BDLwxeSdLSo8NH9H
        XuSzwE0RSOV6geYR2ACJ5ACxusSiCnE=
X-Google-Smtp-Source: ABdhPJwTHRvYIb8i0T1zoAylpYMIsLafaRM6cx6PdFYWUHweqDsQGupHlM2X/u/7R5Q9X61B2oGvyA==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr6206844wru.78.1616016487653;
        Wed, 17 Mar 2021 14:28:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o11sm201171wrq.74.2021.03.17.14.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:28:07 -0700 (PDT)
Message-Id: <e223f842748c797a3df967321de7650aba3a9801.1616016485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
        <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 21:27:53 +0000
Subject: [PATCH v2 01/13] merge-ort: use STABLE_QSORT instead of QSORT where
 required
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
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
index 7f5750ce6ab0..34a91c435737 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2405,7 +2405,7 @@ static int detect_and_process_renames(struct merge_options *opt,
 	clean &= collect_renames(opt, &combined, MERGE_SIDE2,
 				 &renames->dir_renames[1],
 				 &renames->dir_renames[2]);
-	QSORT(combined.queue, combined.nr, compare_pairs);
+	STABLE_QSORT(combined.queue, combined.nr, compare_pairs);
 	trace2_region_leave("merge", "directory renames", opt->repo);
 
 	trace2_region_enter("merge", "process renames", opt->repo);
@@ -2550,6 +2550,7 @@ static void write_tree(struct object_id *result_oid,
 	 */
 	relevant_entries.items = versions->items + offset;
 	relevant_entries.nr = versions->nr - offset;
+	/* No need for STABLE_QSORT -- filenames must be unique */
 	QSORT(relevant_entries.items, relevant_entries.nr, tree_entry_order);
 
 	/* Pre-allocate some space in buf */
@@ -3325,6 +3326,11 @@ static int record_conflicted_index_entries(struct merge_options *opt,
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

