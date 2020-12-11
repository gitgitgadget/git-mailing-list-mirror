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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3968C4167B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FBCB23F36
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437414AbgLKJKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 04:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437325AbgLKJJd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 04:09:33 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999A1C0613D3
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:08:52 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id t16so8225516wra.3
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uKzxYlth5/h5Z+r4ojWksiqQ0jpLKXXnqR8B6eOh0po=;
        b=e8sI0YH643dToADOjgrV5EdoLbweFtYmCKJ8KEvUcJhoYKUUWZlrUI9JRnhix6iARn
         NahkbyW8ivXi0IBvrgdtPSAhTB1Crl0Q+H5IrQ1IjgLhI6dHIdnlLGmBtP1PVAgrYadI
         NluWDoeMQD7x3OErgqxPDxoau+BHKTwwxCY1EQI4zgBiyxqvtjy+Qv5lTq7J6LFolCpD
         DB6KFPcu7J/0pajCWODJzEz6G/le3EGQ2P3O02VYs+qhpA+MtMsAsO1HV29zZZZFdD/P
         /xNDX2Yhsud2VQhmWlF3WUixOztN3vKxh+qHP8+PoCti5BODXNpVhoDUg8cdHlFdVCgD
         YtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uKzxYlth5/h5Z+r4ojWksiqQ0jpLKXXnqR8B6eOh0po=;
        b=PDS1EZ51vyyX/12ID55ZuLapQzei4xceQt3CTr3jxqS5vqVxMgIO6HENT5cZeeHcFT
         5c1ndgS1sHrbYbnFv9Fu4rukiZwLYn9HN2/LZDaUsMDt7YV7sDZSj2EYlv6lcj6+1/tn
         Jk1gMnp3yL1kGH4dxZ5IFs9rXQXSh4GOzOSBinNShTnm17LyzUaRyrlhOVznW38qFRFt
         Qg5QDsQx0EYt0tWGJx4vy6vF0lkn+eHVeKprtEUXrEMq0iB3fsoJZTLTgk9XNq3HxVIR
         VARbjAB4G6+IQtQzuOz52I4dlwpBKabRjGm3ca59WuXQoiJ8rjEhYlGX7qLclbwYlSxZ
         yVHw==
X-Gm-Message-State: AOAM532l8JotTQusFHMukh8kZyx6z0vcN0lR2WE78RlStV/4Rpy3ER4z
        c1bwEOVdN/t13kWloJNvuCri/8a+pQw=
X-Google-Smtp-Source: ABdhPJy6yLZ/0Q/rBjcmqmKjIhhzTyNEqtYagqlYsPfco8m0pYwI2dBdOMychLgvy5L5jGdy0/ngDA==
X-Received: by 2002:adf:a388:: with SMTP id l8mr12778421wrb.354.1607677731122;
        Fri, 11 Dec 2020 01:08:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q15sm13746063wrw.75.2020.12.11.01.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 01:08:50 -0800 (PST)
Message-Id: <428d8204894f668e925c640b2f72dc597164e706.1607677728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
        <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Dec 2020 09:08:40 +0000
Subject: [PATCH v2 1/9] diffcore-rename: rename num_create to num_destinations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Our main data structures are rename_src and rename_dst.  For counters of
these data structures, num_sources and num_destinations seem natural;
definitely more so than using num_create for the latter.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index d367a6d2443..15a98f566e4 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -434,7 +434,7 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
  * 1 if we need to disable inexact rename detection;
  * 2 if we would be under the limit if we were given -C instead of -C -C.
  */
-static int too_many_rename_candidates(int num_create,
+static int too_many_rename_candidates(int num_destinations,
 				      struct diff_options *options)
 {
 	int rename_limit = options->rename_limit;
@@ -447,17 +447,17 @@ static int too_many_rename_candidates(int num_create,
 	 * This basically does a test for the rename matrix not
 	 * growing larger than a "rename_limit" square matrix, ie:
 	 *
-	 *    num_create * num_src > rename_limit * rename_limit
+	 *    num_destinations * num_src > rename_limit * rename_limit
 	 */
 	if (rename_limit <= 0)
 		rename_limit = 32767;
-	if ((num_create <= rename_limit || num_src <= rename_limit) &&
-	    ((uint64_t)num_create * (uint64_t)num_src
+	if ((num_destinations <= rename_limit || num_src <= rename_limit) &&
+	    ((uint64_t)num_destinations * (uint64_t)num_src
 	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
 		return 0;
 
 	options->needed_rename_limit =
-		num_src > num_create ? num_src : num_create;
+		num_src > num_destinations ? num_src : num_destinations;
 
 	/* Are we running under -C -C? */
 	if (!options->flags.find_copies_harder)
@@ -469,8 +469,8 @@ static int too_many_rename_candidates(int num_create,
 			continue;
 		num_src++;
 	}
-	if ((num_create <= rename_limit || num_src <= rename_limit) &&
-	    ((uint64_t)num_create * (uint64_t)num_src
+	if ((num_destinations <= rename_limit || num_src <= rename_limit) &&
+	    ((uint64_t)num_destinations * (uint64_t)num_src
 	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
 		return 2;
 	return 1;
@@ -505,7 +505,7 @@ void diffcore_rename(struct diff_options *options)
 	struct diff_queue_struct outq;
 	struct diff_score *mx;
 	int i, j, rename_count, skip_unmodified = 0;
-	int num_create, dst_cnt;
+	int num_destinations, dst_cnt;
 	struct progress *progress = NULL;
 
 	if (!minimum_score)
@@ -570,13 +570,13 @@ void diffcore_rename(struct diff_options *options)
 	 * Calculate how many renames are left (but all the source
 	 * files still remain as options for rename/copies!)
 	 */
-	num_create = (rename_dst_nr - rename_count);
+	num_destinations = (rename_dst_nr - rename_count);
 
 	/* All done? */
-	if (!num_create)
+	if (!num_destinations)
 		goto cleanup;
 
-	switch (too_many_rename_candidates(num_create, options)) {
+	switch (too_many_rename_candidates(num_destinations, options)) {
 	case 1:
 		goto cleanup;
 	case 2:
@@ -593,7 +593,8 @@ void diffcore_rename(struct diff_options *options)
 				(uint64_t)rename_dst_nr * (uint64_t)rename_src_nr);
 	}
 
-	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_create), sizeof(*mx));
+	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_destinations),
+		     sizeof(*mx));
 	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
 		struct diff_filespec *two = rename_dst[i].two;
 		struct diff_score *m;
-- 
gitgitgadget

