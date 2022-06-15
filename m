Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F04C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 23:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351973AbiFOXgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 19:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350811AbiFOXf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 19:35:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4F81EACA
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:35:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m24so17232234wrb.10
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C780sC91xhPPLJe3OMpTJIx0Gc8ojEZaalLWRRgRH2U=;
        b=cJ6epaLLR9uhaxwcwQOpCPwcNVgAXY+U67NigdcpoSaHLjG5tARlbIMzaN9sX4hpL+
         WDFBMoxeUhQkJQ9K+a+pjCCiRMoMS/7ZB/PmZ1KMIPtOybal7S4+QVpHrSYm0uklmiyY
         QVwKYKERY42d1861phUtuLNlnana9cYU4ls5wquKyZ1sZwlk3ZtzeGnrNTwoitQ08DyN
         asaG3OnvIBJoDYQwqSS8sJHSoIqZYVQzkidkK1PUtDExOIogwkWA78sZxblIBN1qS2nY
         +Zmfje/y3bv8UJ2hq/pVvNz7kMz3q0pAM2X+M4r9QSEkKn/npsD7bdwtF8nIvBz42wxF
         5wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C780sC91xhPPLJe3OMpTJIx0Gc8ojEZaalLWRRgRH2U=;
        b=v0RWli2l0XU6ImPIuOcyN64lLhf32yM0/CWM+q3orGL/4cZ/qALFL5ywbCpXlzCupG
         ET8lOorV3jDKvyMPftsJ4as3ifLPQFgiHjQdVwpC6CK0YlMGp8x+AhSBT9B5Jw06mUmI
         aMR1jCi8cNAWI+AHgV8dE4gISHDQS+ALHouWBF7m0xIoRhHBO4cpNGdSxeK2ux1EXKe4
         TMzf4dykY9Y1GeLXa5hp7iPpiKe1mBZQfmGlRjewDmTDxZdw/y8KeKf9LtrSBQOd9FZl
         HYnAaSXauaGkUw+mZ+3BeGgKkqd/BoQFO5CeI+dfklFN2cfzZJqsHPTi/leMVbNE7OQW
         kiyw==
X-Gm-Message-State: AJIora+s16rNHs97g9+n9h5qk6pcLn6ngq82zExgVMyIX4RASEEQI3oV
        /khveg7s8Fw6Wy90s0qT4N2ddRFrNBRR9A==
X-Google-Smtp-Source: AGRyM1vOVVkKQqtnE7pOPeOfFA/9phTND1w4nLZSMEBrh9ouRq3x2ak/DM7AZnqvK/sWLYKIkLeN9w==
X-Received: by 2002:a05:6000:1549:b0:218:56b3:e3 with SMTP id 9-20020a056000154900b0021856b300e3mr1937973wry.403.1655336156326;
        Wed, 15 Jun 2022 16:35:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m188-20020a1c26c5000000b0039c4945c753sm3852392wmm.39.2022.06.15.16.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 16:35:55 -0700 (PDT)
Message-Id: <591166e07d87fdb5efc2769d3e2963e3f0412720.1655336146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 23:35:39 +0000
Subject: [PATCH 05/11] submodule-config: avoid memory leak
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 961b130d20c9 (branch: add --recurse-submodules option for branch
creation, 2022-01-28), a funny pattern was introduced where first some
struct is `xmalloc()`ed, then we resize an array whose element type is
the same struct, and then the first struct's contents are copied into
the last element of that array.

Crucially, the `xmalloc()`ed memory never gets released.

Let's avoid that memory leak and that memory allocation dance altogether
by first reallocating the array, then using a pointer to the last array
element to go forward.

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 submodule-config.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index ce3beaf5d4f..51ecbe901ec 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -756,7 +756,10 @@ static void traverse_tree_submodules(struct repository *r,
 
 		if (S_ISGITLINK(name_entry->mode) &&
 		    is_tree_submodule_active(r, root_tree, tree_path)) {
-			st_entry = xmalloc(sizeof(*st_entry));
+			ALLOC_GROW(out->entries, out->entry_nr + 1,
+				   out->entry_alloc);
+			st_entry = &out->entries[out->entry_nr++];
+
 			st_entry->name_entry = xmalloc(sizeof(*st_entry->name_entry));
 			*st_entry->name_entry = *name_entry;
 			st_entry->submodule =
@@ -766,9 +769,6 @@ static void traverse_tree_submodules(struct repository *r,
 						root_tree))
 				FREE_AND_NULL(st_entry->repo);
 
-			ALLOC_GROW(out->entries, out->entry_nr + 1,
-				   out->entry_alloc);
-			out->entries[out->entry_nr++] = *st_entry;
 		} else if (S_ISDIR(name_entry->mode))
 			traverse_tree_submodules(r, root_tree, tree_path,
 						 &name_entry->oid, out);
-- 
gitgitgadget

