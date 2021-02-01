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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EC8C433E9
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5CF864D9E
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhBAMsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 07:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhBAMsN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 07:48:13 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D6FC0613D6
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 04:47:33 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c12so16428217wrc.7
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 04:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UFgqZr9rawQ7Afq2fqGeJV+gn8BBK9vi8PqUK9wxD7Q=;
        b=raLvy1jxuiHcrRgowewubCvNmRYyndJbO5d5kx/lE1/uW+waqIsNeuBwI64EUj/5bc
         JThVMYEnqaxvYmJH53gAToduj0av8SJXKkoxCYMS2Z12uOmgLLMaoYsyvySuPmgEOYvT
         F24wxq1b+NM8b1TG+wxrp9FHE9QPFWyRnzAG92xIwJRKONr+pW7SxvpgaTizcYkbdwAc
         GoVyds870L8uVceZ0SMq619szjF3lpULfufMZRUA6lwuPVRcT1WgZ0Z/fL4QxZaq6ltv
         QsvqRHXIYVGx4Ep2aOyXyrb72mbcns+htR4jm7YBZenW2tStndVdD3VyGOsOWNzJNpWt
         reAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UFgqZr9rawQ7Afq2fqGeJV+gn8BBK9vi8PqUK9wxD7Q=;
        b=q6hyDue/ZCPVOeBKW3WmkF3DiCElMyV5wl1JPhT1Fg/mzhmupSBHgjHAfwiSro1KRU
         9DMoYMbpL8VNyyTJHiWSlr+LTpCMDIqqRamljjO6bxlZGwOZa7K3+W3NayKUV1VhM/Oa
         mJftubW1EpNQyaK69e8oGwE6NkvpWvUilLrV7Y2RdgDJoNf0Jh/RDVGQSmAJNPJOQal5
         aL+rZ0ncShNNE2YfoG+wja/T+pXZsv+f7AsAcoR/u4BTuUrycCosBxv/WAr3BGAVgSPP
         TU9nHP999oD6ou6AZfz+EEFYgsJ/pOPqYMdQaIGYzaTy3VcbqmrdbP8HM0uw2xJL6eTM
         6JCw==
X-Gm-Message-State: AOAM530ctIJv7MB/gwK89nbJG95ZRJtp/7GU/pIotnRsQEG2jXLU7MB8
        nZ42Sn5MXU32u/h+Gbyh5XKZL0Ng70o=
X-Google-Smtp-Source: ABdhPJxRWVe74/ulerE4X7x4dJtboQWcPtfRc9o4bXArUb1ELn2QvO6YJKqxYnsUILugBE1xpqAF4w==
X-Received: by 2002:a5d:4f87:: with SMTP id d7mr17682272wru.385.1612183651657;
        Mon, 01 Feb 2021 04:47:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6sm27554257wrs.71.2021.02.01.04.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 04:47:31 -0800 (PST)
Message-Id: <009f64b53c9567a94a52d1607e3ea0456776c9e1.1612183647.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
        <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 12:47:25 +0000
Subject: [PATCH v2 3/5] commit-reach: move compare_commits_by_gen
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, me@ttaylorr.com,
        peff@peff.net, gitster@pobox.com,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Move this earlier in the file so it can be used by more methods.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 053676e51d0..7bf52e94429 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -17,6 +17,21 @@
 
 static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT);
 
+static int compare_commits_by_gen(const void *_a, const void *_b)
+{
+	const struct commit *a = *(const struct commit * const *)_a;
+	const struct commit *b = *(const struct commit * const *)_b;
+
+	timestamp_t generation_a = commit_graph_generation(a);
+	timestamp_t generation_b = commit_graph_generation(b);
+
+	if (generation_a < generation_b)
+		return -1;
+	if (generation_a > generation_b)
+		return 1;
+	return 0;
+}
+
 static int queue_has_nonstale(struct prio_queue *queue)
 {
 	int i;
@@ -651,21 +666,6 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
 	return repo_is_descendant_of(the_repository, commit, list);
 }
 
-static int compare_commits_by_gen(const void *_a, const void *_b)
-{
-	const struct commit *a = *(const struct commit * const *)_a;
-	const struct commit *b = *(const struct commit * const *)_b;
-
-	timestamp_t generation_a = commit_graph_generation(a);
-	timestamp_t generation_b = commit_graph_generation(b);
-
-	if (generation_a < generation_b)
-		return -1;
-	if (generation_a > generation_b)
-		return 1;
-	return 0;
-}
-
 int can_all_from_reach_with_flag(struct object_array *from,
 				 unsigned int with_flag,
 				 unsigned int assign_flag,
-- 
gitgitgadget

