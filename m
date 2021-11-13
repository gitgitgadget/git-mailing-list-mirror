Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DCDC433EF
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 00:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E56610A1
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 00:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhKMARK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 19:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhKMARJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 19:17:09 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D2BC061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 16:14:17 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so7977811wmd.1
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 16:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=8GX4iSGtqLbycuFykAdPXV6wk9Gmv9Y9v8I6xc12h8Q=;
        b=gXoXdMwfBtzMdIc8IJuZLrLta+ImKllWCs52GWhgW5r6wGwMb/FgvQMDMgXT2m5Tb6
         XrC7jjFGsY84V9TxO6IbWBREKAL/L9wSKy2itkulOTMAtD6C9l5/O0pMLpbDPBu5tv0X
         6uUefVwVyL81Ex5kLVA+75jSc0jR03nOs8y1kVyrpXZhwSjLrH3sQyp8PUJZiIKCpm+G
         hAQfLtlrDoS6DFoHy4PM87mk70qSFT9+P7pIc+CeGtzSWc40Xsf+ehaspS3zpFA2GWD6
         iVNwV/fT9AhLAWDEIZq5upYXhClxTGEyMbHVdlex6NX7bHa6gJPt/DB72Iv3AuEjYVsk
         LVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8GX4iSGtqLbycuFykAdPXV6wk9Gmv9Y9v8I6xc12h8Q=;
        b=gfm4L2NBvN9q1GIewnfhhs2f+eOtyxH6hhz3B3CGX2PUmVN+JYd12ZjallUQypNyWm
         c81NB5yRjAR7FKI9U90fJKRsY3KGlu7/R0sfMEjkVsgmHqDME/yiBvGrnWFDkzKyRlNz
         ivzFTbuToTwEbvnsQVqMPMjVorbzJsksUXjTz3XE9Zm0KU/iQOezFndnAz6+AIjWfcMC
         coLBZc9rAJIq6NsOqhq3USj6OqnK1t8ZkNsTUbH+T0kRz1BWoPDuf54l8W236hxgvqe4
         qR6PkA8k9G1nSEcrloI+WQZeUBtXTiJzECOzfLdRApPgDhKKeZiJla5m/Jhut7SHvkXA
         pqFA==
X-Gm-Message-State: AOAM531E1vmQZ8TC8YtkuzSmrR2Fvxx9hexY8XnIjcIEx5o8UrPQHvO9
        zeWKE/uTFnym3ejlYz3UhfzIYQm/U8c=
X-Google-Smtp-Source: ABdhPJxMJqJZpY3C3aKyCIZNc+A/kDZuEAN/wbqiOp+Av/s+oWZWjAPiLDHZoVoDGbNWIjoIuG5xnQ==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr21882221wmq.117.1636762456272;
        Fri, 12 Nov 2021 16:14:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10sm8713116wrb.75.2021.11.12.16.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 16:14:15 -0800 (PST)
Message-Id: <pull.1119.git.git.1636762454792.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Nov 2021 00:14:14 +0000
Subject: [PATCH] name-rev: prefer shorter names over following merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

name-rev has a MERGE_TRAVERSAL_WEIGHT to say that traversing a second or
later parent of a merge should be 65535 times more expensive than a
first-parent traversal, as per ac076c29ae8d (name-rev: Fix non-shortest
description, 2007-08-27).  The point of this weight is to prefer names
like

    v2.32.0~1471^2

over names like

    v2.32.0~43^2~15^2~11^2~20^2~31^2

which are two equally valid names in git.git for the same commit.  Note
that the first follows 1472 parent traversals compared to a mere 125 for
the second.  Weighting all traversals equally would clearly prefer the
second name since it has fewer parent traversals, but humans aren't
going to be traversing commits and they tend to have an easier time
digesting names with fewer segments.  The fact that the former only has
two segments (~1471, ^2) makes it much simpler than the latter which has
six segments (~43, ^2, ~15, etc.).  Since name-rev is meant to "find
symbolic names suitable for human digestion", we prefer fewer segments.

However, the particular rule implemented in name-rev would actually
prefer

    v2.33.0-rc0~11^2~1

over

    v2.33.0-rc0~20^2

because both have precisely one second parent traversal, and it gives
the tie breaker to shortest number of total parent traversals.  Fewer
segments is more important for human consumption than number of hops, so
we'd rather see the latter which has one fewer segment.

Include the generation in is_better_name() and use a new
effective_distance() calculation so that we prefer fewer segments in
the printed name over fewer total parent traversals performed to get the
answer.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    name-rev: prefer shorter names over following merges

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1119%2Fnewren%2Fprefer-shorter-names-in-name-rev-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1119/newren/prefer-shorter-names-in-name-rev-v1
Pull-Request: https://github.com/git/git/pull/1119

 builtin/name-rev.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index b221d300147..27f60153a6c 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -44,11 +44,20 @@ static struct rev_name *get_commit_rev_name(const struct commit *commit)
 	return is_valid_rev_name(name) ? name : NULL;
 }
 
+static int effective_distance(int distance, int generation)
+{
+	return distance + (generation > 0 ? MERGE_TRAVERSAL_WEIGHT : 0);
+}
+
 static int is_better_name(struct rev_name *name,
 			  timestamp_t taggerdate,
+			  int generation,
 			  int distance,
 			  int from_tag)
 {
+	int name_distance = effective_distance(name->distance, name->generation);
+	int new_distance = effective_distance(distance, generation);
+
 	/*
 	 * When comparing names based on tags, prefer names
 	 * based on the older tag, even if it is farther away.
@@ -56,7 +65,7 @@ static int is_better_name(struct rev_name *name,
 	if (from_tag && name->from_tag)
 		return (name->taggerdate > taggerdate ||
 			(name->taggerdate == taggerdate &&
-			 name->distance > distance));
+			 name_distance > new_distance));
 
 	/*
 	 * We know that at least one of them is a non-tag at this point.
@@ -69,8 +78,8 @@ static int is_better_name(struct rev_name *name,
 	 * We are now looking at two non-tags.  Tiebreak to favor
 	 * shorter hops.
 	 */
-	if (name->distance != distance)
-		return name->distance > distance;
+	if (name_distance != new_distance)
+		return name_distance > new_distance;
 
 	/* ... or tiebreak to favor older date */
 	if (name->taggerdate != taggerdate)
@@ -88,7 +97,7 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 	struct rev_name *name = commit_rev_name_at(&rev_names, commit);
 
 	if (is_valid_rev_name(name)) {
-		if (!is_better_name(name, taggerdate, distance, from_tag))
+		if (!is_better_name(name, taggerdate, generation, distance, from_tag))
 			return NULL;
 
 		/*

base-commit: 9d530dc0024503ab4218fe6c4395b8a0aa245478
-- 
gitgitgadget
