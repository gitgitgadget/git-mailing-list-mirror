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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5241FC433E0
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 18:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22FB6229C4
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 18:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbhAPSMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 13:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbhAPSMp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 13:12:45 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ACFC0613D6
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 10:11:30 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id v184so6139511wma.1
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 10:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1q6JEHI6MMjayciIxC6QRwexPgqQg5dji/4US0XAiSY=;
        b=oFH0rz3LvkpEFW6Jvx9zqEcpX0K6wALWo7BoXSDixFfY1M++1Wc0U2Y+hFj+w0WgzB
         BiunsJXNIucvBKNRLHlB6ZmikQkoAuBFleT+lPC+uafLrAlcYWfPacDAgu1nSjT/j8N8
         UJRMEljQXs+T6Quf7BG7UlsjQ/y3gwaJR328q+3KBWQ5PqXfvtO/c+YYSC+s5LsjIyF0
         QDkD1a/VTfQfpLG4kOiY21fDkAJU40PVfFxGnMKfAvmVf0fsDOGtou0jleQHU61F1DXP
         BMrEBu4+J7BqpZ0NXHImHxw9mjiSWUkl80N1JHF18tL+TrTvG3pzlw5I3uB/9eJU7R4S
         uNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1q6JEHI6MMjayciIxC6QRwexPgqQg5dji/4US0XAiSY=;
        b=bEpkuaeIRHd4WzMlj/ZEqJG2jNl6rVZA3TrLZwVo74imqjQhvxI8QY6cn3Q67EC8kS
         UD4oXOlA84I1xk161rOwzCdw0qUpfiTUwnJ0QP1clfAGuKKo8tDi0WqRgvHGDqYomWcg
         FZpHW6+wg8RIgNUvM15P40qvFjIGkcC2SbXxBrRhpOVU2Of2HjiYcScNHuascWkZDZTx
         qbCydeFx199JoWVCktQf2cMzDmPi62t+M7GnmjuUIehYrFuPfZHfhkb+3uitW/++blBO
         TBU9DSnxEgSMjY1uW2GotNQEbdLZzYSm4EeySrPwPiKvjB4OSsRXW+M3OSD0YtUUiNpt
         uQdQ==
X-Gm-Message-State: AOAM531md7gZ/JKGrYIv9AE2Svk3E5yG6bzPLO4gQOTRgtsnhWD/Y0SR
        gamZ1oLmv/EATMz6SrnTyMk2nrr8UtU=
X-Google-Smtp-Source: ABdhPJwObuljrYTC+xJvBMn9jrlrZKzFV78ZyvrSGS054Uc/+hd2g9kas0Poy0QUGs1LX57nnka+rw==
X-Received: by 2002:a1c:68d5:: with SMTP id d204mr13931978wmc.178.1610820689118;
        Sat, 16 Jan 2021 10:11:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j2sm19936467wrh.78.2021.01.16.10.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 10:11:28 -0800 (PST)
Message-Id: <8fbe74864059ddde1c4107c0986b99518183de40.1610820679.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
References: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
        <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 16 Jan 2021 18:11:14 +0000
Subject: [PATCH v6 07/11] commit-graph: implement corrected commit date
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

With most of preparations done, let's implement corrected commit date.

The corrected commit date for a commit is defined as:

* A commit with no parents (a root commit) has corrected commit date
  equal to its committer date.
* A commit with at least one parent has corrected commit date equal to
  the maximum of its commit date and one more than the largest corrected
  commit date among its parents.

As a special case, a root commit with timestamp of zero (01.01.1970
00:00:00Z) has corrected commit date of one, to be able to distinguish
from GENERATION_NUMBER_ZERO (that is, an uncomputed corrected commit
date).

To minimize the space required to store corrected commit date, Git
stores corrected commit date offsets into the commit-graph file. The
corrected commit date offset for a commit is defined as the difference
between its corrected commit date and actual commit date.

Storing corrected commit date requires sizeof(timestamp_t) bytes, which
in most cases is 64 bits (uintmax_t). However, corrected commit date
offsets can be safely stored using only 32-bits. This halves the size
of GDAT chunk, which is a reduction of around 6% in the size of
commit-graph file.

However, using offsets be problematic if a commit is malformed but valid
and has committer date of 0 Unix time, as the offset would be the same
as corrected commit date and thus require 64-bits to be stored properly.

While Git does not write out offsets at this stage, Git stores the
corrected commit dates in member generation of struct commit_graph_data.
It will begin writing commit date offsets with the introduction of
generation data chunk.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6d42e30cd9a..a899f429093 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1343,9 +1343,11 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
 		uint32_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
+		timestamp_t corrected_commit_date = commit_graph_data_at(ctx->commits.list[i])->generation;
 
 		display_progress(ctx->progress, i + 1);
-		if (level != GENERATION_NUMBER_ZERO)
+		if (level != GENERATION_NUMBER_ZERO &&
+		    corrected_commit_date != GENERATION_NUMBER_ZERO)
 			continue;
 
 		commit_list_insert(ctx->commits.list[i], &list);
@@ -1354,17 +1356,24 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			struct commit_list *parent;
 			int all_parents_computed = 1;
 			uint32_t max_level = 0;
+			timestamp_t max_corrected_commit_date = 0;
 
 			for (parent = current->parents; parent; parent = parent->next) {
 				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
+				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
 
-				if (level == GENERATION_NUMBER_ZERO) {
+				if (level == GENERATION_NUMBER_ZERO ||
+				    corrected_commit_date == GENERATION_NUMBER_ZERO) {
 					all_parents_computed = 0;
 					commit_list_insert(parent->item, &list);
 					break;
-				} else if (level > max_level) {
-					max_level = level;
 				}
+
+				if (level > max_level)
+					max_level = level;
+
+				if (corrected_commit_date > max_corrected_commit_date)
+					max_corrected_commit_date = corrected_commit_date;
 			}
 
 			if (all_parents_computed) {
@@ -1373,6 +1382,10 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
 					max_level = GENERATION_NUMBER_V1_MAX - 1;
 				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
+
+				if (current->date && current->date > max_corrected_commit_date)
+					max_corrected_commit_date = current->date - 1;
+				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
 			}
 		}
 	}
-- 
gitgitgadget

