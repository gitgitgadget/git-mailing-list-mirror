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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5261C4332D
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 12:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 873AF64EBD
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 12:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhBSMfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 07:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhBSMfG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 07:35:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362A9C06178B
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 04:34:15 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l12so8250006wry.2
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 04:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/VQnHejz3F4+Nb7sLVqUxe8wEvgRIjrbaqweMGJyjRI=;
        b=pEGzAL8h0QPtTww6MLlyMmMExxVeOD0Ws+3AR5KjrKysLRpxc/pRgV1Ch7MUSfitd9
         POHrJPq3slOVQdLmgdwQ5ef6QfvFVzfsEos5JlntUDqInxp0pSzOG0UIvgJi2eaFOY/f
         lymiKnV+Rzgyp8aDY9WKycLyg8MpeeUO4uYRw9LUd9G8HN6PyYZM2QRtuVOajcWbTOGn
         F/5fDY3OC8zYakQ0gVs7IRmWOOfxE+7Wfaf6r8WzjlOosqXN+KMDDQ1CjZ5APkF3bkrd
         R4c+7jsBJ3kI9oec1dMcPT442Y7iPSxFAmk2x6SOQYOtQCBAxJ7lW3G+9hjzL/QIw+vV
         Bclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/VQnHejz3F4+Nb7sLVqUxe8wEvgRIjrbaqweMGJyjRI=;
        b=OGXckDT4pOxfAcXE5+QRKCTYKp7ukS9qZPimHXmzVN17UN82NzDZHzF8PbcmU2GIv/
         GhdG86Y269cy2lfUGyKIhyba6FoR1lemqCz0ai/ds6sqEPwqVN2pF6iwlbabHayESbZL
         NypE/6Ryyyj42KW7T4ifEVwv3I6Qff7wdPrEnmDf4WgUow6V6pmLzCoaeZMnFK7m3JvQ
         paAfOb/5sr+o+6SCvU42Gb12W5Af4Ws5NTFUtZfXcNlsBGT8VGjP14Ykqmzq+geJegdC
         h41FU0SSvHVRqmeBnzVGH0BLuKVbVRTHpicMQFDiWHALXYSQ7E9cyWwTiyeR0NVt1EUj
         0/Sw==
X-Gm-Message-State: AOAM531wZvNedR2d2QI79L/39/zYp8LvDxE2U9zhCMbsDTKaCMW0YpKm
        ucrZnkIEOlZk+uOLnGsBH3yKL26D744=
X-Google-Smtp-Source: ABdhPJx1p9dnOap2J/6uo+NCxZBAO9uqoGil2tBtfZkr3pBFEM+OCgVSLPKsVYdTp2sikgk6+oJhuQ==
X-Received: by 2002:adf:e98d:: with SMTP id h13mr9116606wrm.246.1613738054031;
        Fri, 19 Feb 2021 04:34:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10sm7011514wrx.5.2021.02.19.04.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 04:34:13 -0800 (PST)
Message-Id: <1d3c5ebbb632b33c6623c3c5ad120f1ec9884756.1613738051.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.852.v3.git.1613738051.gitgitgadget@gmail.com>
References: <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
        <pull.852.v3.git.1613738051.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Feb 2021 12:34:08 +0000
Subject: [PATCH v3 3/5] commit-reach: move compare_commits_by_gen
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
index 7a3a1eb1a26e..a34c5ba09e81 100644
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
@@ -647,21 +662,6 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
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

