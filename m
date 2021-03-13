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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50311C433E6
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1511564EDF
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbhCMWWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 17:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbhCMWWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 17:22:14 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F6CC0613D7
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:13 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso17940369wma.4
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tPi3DBSzC86kR+0VoEHJPR67rvIFqEnSqY7AQaHD9wU=;
        b=WtrY9BlMvD16/o6sZfrZajdscEv7hCkCO1WFkY/cmlPfGxFyhTeTCTE6Gn8IJ5Gi3p
         hvcaw3gdzxUY2RA4RYcolCrzw1VpW2ZYi6KWDv34uX7KUUtlrq/9BmvLg3zXvwsq54W0
         gPVk4wQ2z8EYtEZj027+jOMAfQ8+zfp3bhOQpWt9ycY7mA0zQA5lL1yORQ7p2TC3WIQP
         1CSQpuSWfCRQ4RcTo9ofbr89CTf6fq+JVelHf2kT9ZwXplo0d1bZG03cU/pd8DZFynXe
         uN25zhh77SL4gNR2N4pGMv2bVo6u8Iaa8rb9moHzwcQaTBahkAUCeictNnoz2z3Knpdc
         /N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tPi3DBSzC86kR+0VoEHJPR67rvIFqEnSqY7AQaHD9wU=;
        b=GBmIieyznPlhgMOfoYyUcRVkxF3X8tqc5mBZLdUje7yv34r/qYcn+m2gxGNrRuRTo2
         1Mxh9dZ78PIECGVnMFT6w15MhxiZ2DsRB1EO37K/O9fvw9jDLSc9nfOe0tYmCljudsuh
         WTbSHJYyPa2vEXWYrs/qBafWoMFSANdC1Rpwa7+yIrEd+KlCox7h94agQm/DWCckgqEj
         eI7dMxDOshR6ndvKLMxvkKLQYWNEnhoU7oSgnrsdNR2bCc1iKawWLJIeJqFdaJbFQ36m
         zBkPvMkU4J5WgUXi1toTefqOxBcu7PLXX0/A50wbHyVWQL+jC2JyvIwYGwYVob8sSKvM
         pEBw==
X-Gm-Message-State: AOAM5332LM5uVWRhmkojOTZhB1WWlSDNAiXBsW5VGlPsWXZVydCnMKUf
        asr8dK7vEALkvtZkHIzdRWahqFmsZtg=
X-Google-Smtp-Source: ABdhPJxBlAqPCU5l9iN14KRcn50LHStwSbdt6KAo7Yna73D5ttTvhB4OqWtkm4vh6DGWXWvt32owlA==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr19878536wmc.185.1615674132613;
        Sat, 13 Mar 2021 14:22:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm7669661wmf.7.2021.03.13.14.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 14:22:12 -0800 (PST)
Message-Id: <a2dadbdf0d92f5c7cf466950e119e5c51014f118.1615674128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.853.git.1615674128.gitgitgadget@gmail.com>
References: <pull.853.git.1615674128.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Mar 2021 22:22:05 +0000
Subject: [PATCH 5/8] diffcore-rename: check if we have enough renames for
 directories early on
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As noted in the past few commits, if we can determine that a directory
already has enough renames to determine how directory rename detection
will be decided for that directory, then we can mark that directory as
no longer needing any more renames detected for files underneath it.
For such directories, we change the value in the dirs_removed map from
RELEVANT_TO_SELF to RELEVANT_FOR_ANCESTOR.

A subsequent patch will use this information while iterating over the
remaining potential rename sources to mark ones that were only
location_relevant as unneeded if no containing directory is still marked
as RELEVANT_TO_SELF.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 73 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 10 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 0a17abd46691..8fa29076e0aa 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -407,6 +407,28 @@ static const char *get_highest_rename_path(struct strintmap *counts)
 	return highest_destination_dir;
 }
 
+static char *UNKNOWN_DIR = "/";  /* placeholder -- short, illegal directory */
+
+static int dir_rename_already_determinable(struct strintmap *counts)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	int first = 0, second = 0, unknown = 0;
+	strintmap_for_each_entry(counts, &iter, entry) {
+		const char *destination_dir = entry->key;
+		intptr_t count = (intptr_t)entry->value;
+		if (!strcmp(destination_dir, UNKNOWN_DIR)) {
+			unknown = count;
+		} else if (count >= first) {
+			second = first;
+			first = count;
+		} else if (count >= second) {
+			second = count;
+		}
+	}
+	return first > second + unknown;
+}
+
 static void increment_count(struct dir_rename_info *info,
 			    char *old_dir,
 			    char *new_dir)
@@ -1096,17 +1118,48 @@ static void handle_early_known_dir_renames(struct dir_rename_info *info,
 					   struct strintmap *dirs_removed)
 {
 	/*
-	 * Not yet implemented; directory renames are determined via an
-	 * aggregate of all renames under them and using a "majority wins"
-	 * rule.  The fact that "majority wins", though, means we don't need
-	 * all the renames under the given directory, we only need enough to
-	 * ensure we have a majority.
-	 *
-	 * For now, we don't have enough information to know if we have a
-	 * majority after exact renames and basename-guided rename detection,
-	 * so just return early without doing any extra filtering.
+	 * Directory renames are determined via an aggregate of all renames
+	 * under them and using a "majority wins" rule.  The fact that
+	 * "majority wins", though, means we don't need all the renames
+	 * under the given directory, we only need enough to ensure we have
+	 * a majority.
 	 */
-	return;
+
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	if (!dirs_removed || !relevant_sources)
+		return; /* nothing to cull */
+	if (break_idx)
+		return; /* culling incompatbile with break detection */
+
+	/*
+	 * FIXME: Supplement dir_rename_count with number of potential
+	 * renames, marking all potential rename sources as mapping to
+	 * UNKNOWN_DIR.
+	 */
+
+	/*
+	 * For any directory which we need a potential rename detected for
+	 * (i.e. those marked as RELEVANT_FOR_SELF in dirs_removed), check
+	 * whether we have enough renames to satisfy the "majority rules"
+	 * requirement such that detecting any more renames of files under
+	 * it won't change the result.  For any such directory, mark that
+	 * we no longer need to detect a rename for it.  However, since we
+	 * might need to still detect renames for an ancestor of that
+	 * directory, use RELEVANT_FOR_ANCESTOR.
+	 */
+	strmap_for_each_entry(info->dir_rename_count, &iter, entry) {
+		/* entry->key is source_dir */
+		struct strintmap *counts = entry->value;
+
+		if (strintmap_get(dirs_removed, entry->key) ==
+		    RELEVANT_FOR_SELF &&
+		    dir_rename_already_determinable(counts)) {
+			strintmap_set(dirs_removed, entry->key,
+				      RELEVANT_FOR_ANCESTOR);
+		}
+	}
 }
 
 void diffcore_rename_extended(struct diff_options *options,
-- 
gitgitgadget

