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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E69C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9FF660D07
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhETGL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 02:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhETGLO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 02:11:14 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98C3C06138C
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q5so16288710wrs.4
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8xG2BSo/LUna7kC4NadHvqfwx1/zLIC3qNW9Kfn5ChU=;
        b=b7BbFg9BBO/ffKq3ACD0LxShjY3vWzIzMzyyALkIX05v9RjRnTEa1N4qlNhiZUIuHm
         rpb5qC57l3LDewOXPKylBv3YdW7L30VhOhDmiSdlhP7Vazx0zue3LdEJBp3JNWlIilKX
         s6YGEKPhGZGFTaSJ+y/cTPr8Q3w2opNz3AV5F0bbqokoqEVHL+LsnFGnH5yHcl8qeyip
         kRP5gUUdob5BnBWAnW0PQTxSqlBhIpKOr/e6k/pG7PEzQO4cOGDWBJoNRe/2l9nQw/uh
         nJCvZwA7MZycBUuJ3umjrzMTPj0L+kn0ozO52Dyq7eDfYRH2n0G/wOS07QoIKhNmR301
         AnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8xG2BSo/LUna7kC4NadHvqfwx1/zLIC3qNW9Kfn5ChU=;
        b=njwlpdaGLH2EzOlrNPTaTGHINP3TjJsBCQa3mQCTRXa5UaB0YL8DSgdULnU38J9HDj
         8w91OGFoYmxosyZbNV6GRQOGt4TGNsbjyMA6m5cYqb4DOPUVMxmMUoMzjovzoQ2m17iH
         s6ag6x9+HWGTJ9vA+0swk9Y3t4ZEHfj879MmDh3mUDFiyqL1qU6eGvWnk55V8WEYLyLV
         qw3eojaAsAKArvpKJN7sx7JYSGrzagHpctjThOX2wJ9IwC1bHTCODUUXsAG9W3wTF82R
         q3wFLKVrAcpfwktEDHN0FP7OGKrwGzV65Udm0JVmz8pZM4LOUT9HKODu5sZG2NYgIvX+
         E+vA==
X-Gm-Message-State: AOAM531I1IeCqsBR9x4CUKI8DWUsJrTPfVJ+y4v4WPx1rXxUor3v0h2V
        wdTuvp8hYotXMLWE3JbPsMUYVrL2UF4=
X-Google-Smtp-Source: ABdhPJyM4ZdrdlbDojuuVPLd3vJuiNtueF5HLpVAfhkBTDpF498g4pPpEZ06yDRJLH5r4t/5HLiZ8Q==
X-Received: by 2002:adf:fd45:: with SMTP id h5mr2300208wrs.383.1621490990607;
        Wed, 19 May 2021 23:09:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y14sm1805030wrr.82.2021.05.19.23.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 23:09:50 -0700 (PDT)
Message-Id: <386fd24cb0e32ff18b238e3e240307236cefab0e.1621490982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
References: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
        <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 May 2021 06:09:39 +0000
Subject: [PATCH v3 11/13] merge-ort: add helper functions for using cached
 renames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
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
index 8d4b2ec40e3d..9a229128a9a0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2371,6 +2371,53 @@ static void resolve_diffpair_statuses(struct diff_queue_struct *q)
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
 static void cache_new_pair(struct rename_info *renames,
 			   int side,
 			   char *old_path,
-- 
gitgitgadget

