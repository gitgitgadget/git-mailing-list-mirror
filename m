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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EE5C4743C
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D4561246
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhFEBaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 21:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFEBaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 21:30:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9F1C061767
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 18:28:10 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h5-20020a05600c3505b029019f0654f6f1so8352548wmq.0
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 18:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FsV0ZsK7+oTIWLeUEGlaRrUlLJFeeMFVu+2g1iKUWr0=;
        b=FEH2fBgm/N9pvPKK097UpbY84fWq/+f3OyP5NBzyvlYcvEa/GONZH03ZKgyLVVfEZd
         svTxoNqiRwrRLiDOiXqMBQp1TAUQpKQ/3qvfZblk/2kb6m8rg1eLAcDXnsArPOVT9soT
         /Bt9Ax3cUURbD0ix83eL3J0VAI9q+v0h19mjgt3HQJPhCNlg0jtZtUy7G3wTj/OealvP
         ajRzyuNhy+clVyE/VaFVPv6rm5hxqTz7lOlYCfZuQ6/IwbtYqsq/QOi4533OTi4gZOg+
         v9QroqNPfvL93GGW88F6aRA76WoUZY8HL2APs09Y4dnRgun/UvnkCV2RyCHBgLvaEb3H
         6PdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FsV0ZsK7+oTIWLeUEGlaRrUlLJFeeMFVu+2g1iKUWr0=;
        b=MQ4YYf99Wrf6hTtkYyCEp8zreXK/tzB9Pc/H1HP8ImBnBpYc4NE8ZeGPaaXN9q5UFv
         y+M8W8N9f+VvuAfBGM5AYAMkMJTz4RbMMuP3ttF27nhRkCOUEd/BDhd0NwpoAPYfiBv9
         ywv4tDlUI/KklycOJ9vrQSd5evMuT8ozcAsuLEO/cYBm+Qo72he/xdvZA3nU4JsP5/uI
         eXUt4cUBf4MxxxPEYq2f4HVL5CBu5BMwx62XzuEQzg4RKdF9nzWjrZTk1hqEJbCZq1Tg
         UWjxjLueTrX8B909rCVwxKCMgvysutvvWAPszOUboI1J8lWBmWlvHOWlYMUpfvj0Rmf2
         4AMw==
X-Gm-Message-State: AOAM532qLNX4TEQ6hl+oq78EFRHAnswpyTc/wJcEAccIwJCiTNsIugxq
        0m/8i6ymZDV6byLiOv+QrqqCMAx3UJs=
X-Google-Smtp-Source: ABdhPJzVqPcPyFFY8wtrwghchH4J2aT8Exqspy9zl+t5aY7/xyiu6hrtSFfxY9/IeMKZOikYYsaUpQ==
X-Received: by 2002:a1c:43c3:: with SMTP id q186mr6007320wma.33.1622856489291;
        Fri, 04 Jun 2021 18:28:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t26sm7064097wmi.8.2021.06.04.18.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:28:09 -0700 (PDT)
Message-Id: <ca3b2a743b8e865e9e105620744f7a5aa16b24a4.1622856485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.969.git.1622856485.gitgitgadget@gmail.com>
References: <pull.969.git.1622856485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Jun 2021 01:28:04 +0000
Subject: [PATCH 5/5] merge-ort: add prefetching for content merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 7fbbcb21b1 ("diff: batch fetching of missing blobs", 2019-04-05)
introduced batching of fetching missing blobs, so that the diff
machinery would have one fetch subprocess grab N blobs instead of N
processes each grabbing 1.

However, the diff machinery is not the only thing in a merge that needs
to work on blobs.  The 3-way content merges need them as well.  Rather
than download all the blobs 1 at a time, prefetch all the blobs needed
for regular content merges.

This does not cover all possible paths in merge-ort that might need to
download blobs.  Others include:
  - The blob_unchanged() calls to avoid modify/delete conflicts (when
    blob renormalization results in an "unchanged" file)
  - Preliminary content merges needed for rename/add and
    rename/rename(2to1) style conflicts.  (Both of these types of
    conflicts can result in nested conflict markers from the need to do
    two levels of content merging; the first happens before our new
    prefetch_for_content_merges() function.)

The first of these wouldn't be an extreme amount of work to support, and
even the second could be theoretically supported in batching, but all of
these cases seem unusual to me, and this is a minor performance
optimization anyway; in the worst case we only get some of the fetches
batched and have a few additional one-off fetches.  So for now, just
handle the regular 3-way content merges in our prefetching.

For the testcase from the previous commit, the number of downloaded
objects remains at 63, but this drops the number of fetches needed from
32 down to 20, a sizeable reduction.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c                    | 50 ++++++++++++++++++++++++++++++++++
 t/t6421-merge-partial-clone.sh |  2 +-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index cfa751053b01..e3a5dfc7b312 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -29,6 +29,7 @@
 #include "entry.h"
 #include "ll-merge.h"
 #include "object-store.h"
+#include "promisor-remote.h"
 #include "revision.h"
 #include "strmap.h"
 #include "submodule.h"
@@ -3485,6 +3486,54 @@ static void process_entry(struct merge_options *opt,
 	record_entry_for_tree(dir_metadata, path, &ci->merged);
 }
 
+static void prefetch_for_content_merges(struct merge_options *opt,
+					struct string_list *plist)
+{
+	struct string_list_item *e;
+	struct oid_array to_fetch = OID_ARRAY_INIT;
+
+	if (opt->repo != the_repository || !has_promisor_remote())
+		return;
+
+	for (e = &plist->items[plist->nr-1]; e >= plist->items; --e) {
+		/* char *path = e->string; */
+		struct conflict_info *ci = e->util;
+		int i;
+
+		/* Ignore clean entries */
+		if (ci->merged.clean)
+			continue;
+
+		/* Ignore entries that don't need a content merge */
+		if (ci->match_mask || ci->filemask < 6 ||
+		    !S_ISREG(ci->stages[1].mode) ||
+		    !S_ISREG(ci->stages[2].mode) ||
+		    oideq(&ci->stages[1].oid, &ci->stages[2].oid))
+			continue;
+
+		/* Also don't need content merge if base matches either side */
+		if (ci->filemask == 7 &&
+		    S_ISREG(ci->stages[0].mode) &&
+		    (oideq(&ci->stages[0].oid, &ci->stages[1].oid) ||
+		     oideq(&ci->stages[0].oid, &ci->stages[2].oid)))
+			continue;
+
+		for (i = 0; i < 3; i++) {
+			unsigned side_mask = (1 << i);
+			struct version_info *vi = &ci->stages[i];
+
+			if ((ci->filemask & side_mask) &&
+			    S_ISREG(vi->mode) &&
+			    oid_object_info_extended(opt->repo, &vi->oid, NULL,
+						     OBJECT_INFO_FOR_PREFETCH))
+				oid_array_append(&to_fetch, &vi->oid);
+		}
+	}
+
+	promisor_remote_get_direct(opt->repo, to_fetch.oid, to_fetch.nr);
+	oid_array_clear(&to_fetch);
+}
+
 static void process_entries(struct merge_options *opt,
 			    struct object_id *result_oid)
 {
@@ -3531,6 +3580,7 @@ static void process_entries(struct merge_options *opt,
 	 * the way when it is time to process the file at the same path).
 	 */
 	trace2_region_enter("merge", "processing", opt->repo);
+	prefetch_for_content_merges(opt, &plist);
 	for (entry = &plist.items[plist.nr-1]; entry >= plist.items; --entry) {
 		char *path = entry->string;
 		/*
diff --git a/t/t6421-merge-partial-clone.sh b/t/t6421-merge-partial-clone.sh
index fb7eb18cc80c..84642cb3831c 100755
--- a/t/t6421-merge-partial-clone.sh
+++ b/t/t6421-merge-partial-clone.sh
@@ -392,7 +392,7 @@ test_expect_merge_algorithm failure success 'Objects downloaded when a directory
 #
 #   Summary: 4 fetches (1 for 6 objects, 1 for 8, 1 for 3, 1 for 2)
 #
-test_expect_merge_algorithm failure failure 'Objects downloaded with lots of renames and modifications' '
+test_expect_merge_algorithm failure success 'Objects downloaded with lots of renames and modifications' '
 	test_setup_repo &&
 	git clone --sparse --filter=blob:none "file://$(pwd)/server" objects-many &&
 	(
-- 
gitgitgadget
