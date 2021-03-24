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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB05DC433E0
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46FD61A1E
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhCXVdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 17:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbhCXVcm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 17:32:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F429C061763
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:32:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 12so54053wmf.5
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sIoLEFCpV3kQMDL0jJKIAKrKsyCh3Picyuf14rjmjxQ=;
        b=RQEoPzCOHe/HIWvU3QrBapijgldeuAPQomFAtYO8U6FOYa8IJ+iucj9Uv5YGE3CnRM
         Dm7zHpn6ZsyVjy0zUZUKlv5vlh3jbIzDsbui/UKn1Iz12FUHigqqV67Lo/PfnT3CV63Z
         TQsT3byZOI07tbJp6eY80o3gXwg7Pg5MqMGl+lUBusqrNLPScJons4CeSP2zxQFz6864
         bev0wHHZsVPSqX8idL8bNcNgSInZIofOTh5mJRsqk4zmoUvEHSU1K68XZMv/1mi9x9Go
         3SOU6Syf2+rH0a3iJr3Z5w1wRxz1ufJ/RUjnmsHlRg8jfmrjVtESbr3fCdkbhcqf/ABL
         rz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sIoLEFCpV3kQMDL0jJKIAKrKsyCh3Picyuf14rjmjxQ=;
        b=LHTOqc2rqqxEVmTR0Np3g1p8hTuUPNyhU2VIxhLSlIOcqHZqSjxKXfhjO+QTn78wDf
         efXbygzRumXgEB17pyh9pvhMAV1Hofm8xlidPqc3wUas2c9DIDOW7ED+pHhFBRbh5F+k
         U3EAfiVBWarYSvL+o+ULwHucIMpwTv06yzLwPxuBIka3ld7TtQTfOyUcRgton67b1Ufo
         FFEmq5fLTJuba4q43aNTtFnIxWN5f5SXX//mTEjrSUlcsBySv+QJG/nZx+dI5vn8z5tR
         hEVPxIgDFLU0Voc+dUnIH+s+9T9I8NaKfPnv6Ak4va0WPj8u1r3uIAMOrbKAvW17tTQf
         FM4A==
X-Gm-Message-State: AOAM531DRlAPbQQ/J6jrdZqpya3PkPtQG1qUO0BlUTgrsdE78XkUwasy
        9+uIybB1wPwp53SKTrF415ZZw9KVxD0=
X-Google-Smtp-Source: ABdhPJx5draj712IleMBvfzZjXlNty4peTle6I7lgmYQ01SlhEScx/DCM2y4S478qOESR7AWc2QpPw==
X-Received: by 2002:a1c:ac02:: with SMTP id v2mr4786404wme.111.1616621559809;
        Wed, 24 Mar 2021 14:32:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j30sm5212714wrj.62.2021.03.24.14.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:32:39 -0700 (PDT)
Message-Id: <7d5d94b34ba5afdb406ee806434d66b7ddf85dcf.1616621554.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.git.1616621553.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Mar 2021 21:32:32 +0000
Subject: [PATCH 6/7] merge-ort: add helper functions for using cached renames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

If we have a usable rename cache, then we can remove from
relevant_sources all the paths that were cached;
diffcore_rename_extended() can then consider an even smaller set of
relevant_sources in its rename detection.

However, when diffcore_rename_extended() is done, we will need to take
the renames it detected and then add back in all the ones we had cached
from before.

Add helper functions for doing these two operations; the next commit
will make use of them.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 0dffd65ee1a3..8d0353ffbca2 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2360,6 +2360,53 @@ static void resolve_diffpair_statuses(struct diff_queue_struct *q)
 	}
 }
 
+MAYBE_UNUSED
+static void prune_cached_from_relevant(struct rename_info *renames,
+				       unsigned side)
+{
+	/* Reason for this function described in add_pair() */
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	/* Remove from relevant_sources all entries in cached_pairs[side] */
+	strmap_for_each_entry(&renames->cached_pairs[side], &iter, entry) {
+		strintmap_remove(&renames->relevant_sources[side],
+				 entry->key);
+	}
+	/* Remove from relevant_sources all entries in cached_irrelevant[side] */
+	strset_for_each_entry(&renames->cached_irrelevant[side], &iter, entry) {
+		strintmap_remove(&renames->relevant_sources[side],
+				 entry->key);
+	}
+}
+
+MAYBE_UNUSED
+static void use_cached_pairs(struct merge_options *opt,
+			     struct strmap *cached_pairs,
+			     struct diff_queue_struct *pairs)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	/*
+	 * Add to side_pairs all entries from renames->cached_pairs[side_index].
+	 * (Info in cached_irrelevant[side_index] is not relevant here.)
+	 */
+	strmap_for_each_entry(cached_pairs, &iter, entry) {
+		struct diff_filespec *one, *two;
+		const char *old_name = entry->key;
+		const char *new_name = entry->value;
+		if (!new_name)
+			new_name = old_name;
+
+		/* We don't care about oid/mode, only filenames and status */
+		one = alloc_filespec(old_name);
+		two = alloc_filespec(new_name);
+		diff_queue(pairs, one, two);
+		pairs->queue[pairs->nr-1]->status = entry->value ? 'R' : 'D';
+	}
+}
+
 static void possibly_cache_new_pair(struct rename_info *renames,
 				    struct diff_filepair *p,
 				    unsigned side,
-- 
gitgitgadget

