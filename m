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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16368C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA3EF227C3
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440276AbgLNQX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbgLNQXG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 11:23:06 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B25C06179C
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:47 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id y17so16995179wrr.10
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lTMgcVB6vgszaz4Tdvquin0z9C4VpWH2bLbPz0t6/YU=;
        b=pAHsLTsSKOWcgvyqt4rJWiBgrZQZ7Q3O7iQDJgSu17Qfqyy6cfhQLdZB7gzrZzy/wV
         4q/PHsAro7X96oV3ktwN+zng/XT9YMprzPDgvHATNjS7FG2rNsAvfQ4rPZf71zlQi4m/
         q/O+QoPNkHeIoCPAA1Q6gLJ2vRVlAdMjzjKd6Z1/Z5WJckjVn9kebPeyBSrEGngFxNWq
         kFYOHQfkU3OozYDaQGPCxRBVHzFk2g2yHfK+SA77R3XCLp6uJE+b6KKWOES6kpStxvul
         Anxr6tVrdajCgECXzVdarSgrQhaBQj7wxaW+UrsR57JyPYp4kWvLULoGCKjiufJ8br71
         ho4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lTMgcVB6vgszaz4Tdvquin0z9C4VpWH2bLbPz0t6/YU=;
        b=NR2JqbnliCL8MdZuvCUMzZx0ru6uf/BTuxKH+RE+yxDu4m/GAQtPdfuKfP7aiq0Zz+
         Goe0f5k4ZNrfTnBV4OpHg1veujSh7wGUgcJ3e+Vrw/WqFoN7USnPdV6+jPNhXkKik7kW
         iE+93A8NArHlRCYsFtc/xUDjvobmi/SW4Xa0XCHXDMdawH5rZC2lzUmLvhHdGwPRNIwU
         VlB5vwR0A03f22TNgvlE73sMu9Fk28H7suNN6UXBBMFIKMpa4pluICS9blujgl5JqQq1
         hUX8RDbroAL0l0GusCvzjB5eL8bc1dYkh4DK2lnXwMg2h5UODNT2MGhxCKCItFy4dcuK
         xQiw==
X-Gm-Message-State: AOAM531dtJOKWnilnzVhlHxF8n+fLTL1XyrXXb99RuY+q20tZL6JjyR7
        mY4iwoQ3RFYPBt7jEqsYNRqFXms3tmY=
X-Google-Smtp-Source: ABdhPJyg128KYtjvs6hYFZH8AMvW1WNpMhm2ZU4CsI4YAmGa/xZBWhZavSxoLUJ/hqCLtfyETpZaow==
X-Received: by 2002:a5d:674b:: with SMTP id l11mr11282121wrw.247.1607962905973;
        Mon, 14 Dec 2020 08:21:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a144sm31704058wmd.47.2020.12.14.08.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 08:21:45 -0800 (PST)
Message-Id: <9382dc4d50b3cf675d607cf5d39be08542d8147e.1607962900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
        <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Dec 2020 16:21:33 +0000
Subject: [PATCH v2 04/11] merge-ort: implement compare_pairs() and
 collect_renames()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 66f84d39b43..10550c542b8 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -652,7 +652,10 @@ static int process_renames(struct merge_options *opt,
 
 static int compare_pairs(const void *a_, const void *b_)
 {
-	die("Not yet implemented.");
+	const struct diff_filepair *a = *((const struct diff_filepair **)a_);
+	const struct diff_filepair *b = *((const struct diff_filepair **)b_);
+
+	return strcmp(a->one->path, b->one->path);
 }
 
 /* Call diffcore_rename() to compute which files have changed on given side */
@@ -698,7 +701,35 @@ static int collect_renames(struct merge_options *opt,
 			   struct diff_queue_struct *result,
 			   unsigned side_index)
 {
-	die("Not yet implemented.");
+	int i, clean = 1;
+	struct diff_queue_struct *side_pairs;
+	struct rename_info *renames = &opt->priv->renames;
+
+	side_pairs = &renames->pairs[side_index];
+
+	for (i = 0; i < side_pairs->nr; ++i) {
+		struct diff_filepair *p = side_pairs->queue[i];
+
+		if (p->status != 'R') {
+			diff_free_filepair(p);
+			continue;
+		}
+
+		/*
+		 * p->score comes back from diffcore_rename_extended() with
+		 * the similarity of the renamed file.  The similarity is
+		 * was used to determine that the two files were related
+		 * and are a rename, which we have already used, but beyond
+		 * that we have no use for the similarity.  So p->score is
+		 * now irrelevant.  However, process_renames() will need to
+		 * know which side of the merge this rename was associated
+		 * with, so overwrite p->score with that value.
+		 */
+		p->score = side_index;
+		result->queue[result->nr++] = p;
+	}
+
+	return clean;
 }
 
 static int detect_and_process_renames(struct merge_options *opt,
-- 
gitgitgadget

