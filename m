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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F16AC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 22:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 372346008E
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 22:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhFOWoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 18:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhFOWn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 18:43:59 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84366C06175F
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 15:41:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b205so63602wmb.3
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 15:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YIf9ji05trrJItCTvVz7rkhv84p83dJwpdFScY8oKRk=;
        b=keSi2tAjGk0ReGru5DD0tK1lmDZIgE8URZRo5juon7FWjwr+w1HAjUf3DJ84shM0TP
         7h48DJWwWWvEUQWmSwmZolj2dhJm1NywzIIvbBvm67dKr3+UcWVHrdTtLQizXrknkIwf
         m9+0Q6Ev+4mFJ0vLPCjGco7TlqJ4/g3QaqZgtfMaXPNskvJyyekTfEyyzE53a+aOu1Wr
         N0hov07dFw8YU1fnbNKsH9cmeFKGsHaRD888hIqUeQkrRd9yryRbzRIcvb6vLBJPZYSr
         EvH6QDBr+kleck57whY1acVnGxOLC63/+ifobq2xITEyd57VP9bv7tFO8MYc65plEwcb
         VCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YIf9ji05trrJItCTvVz7rkhv84p83dJwpdFScY8oKRk=;
        b=DlyGB6AUqS2o0WQ7UxaD/UiIme3nYmd+owvnw5t8n22O7kcRaN8dfhmSm+X66ggaEN
         fBDDRwA0lgJV18Ql8NIHXBNVfUBdlHiuMMyu9mHd/pBDrwMq+TzSMLEsR8GolPf5sUYN
         xsqjyWGSB3KRzVG8i4rbFukh2lGwElBBc0W+4GMTa5HqC1vWilvWR5blijG3Wz6fj7Ss
         l6rX4PFcDy8EMPkydxvNQ7NUhl0rio14A1g33AsTsubHC+3qi6jFUcPxgwkIa1RWeJlV
         0tylvi+5sH2N6E9NVfS5/2dN6U2voZB47sHWX74bDHjcx0BbaGWfvFwiEX4KY+0QZTU3
         y1lw==
X-Gm-Message-State: AOAM531TPoiL0AiQuCBk7Jzn4V8N4k8UQ1BmhsbDwCIM/9G+pT6U84b2
        CYd5mICwDQfYa335cOuSjk5FaBl9uWs=
X-Google-Smtp-Source: ABdhPJzYiv9lU1cWzlmnCMqu8CR0al9EQr0+XhXFz9vOlh+qeV/eV04i0kKi4UuFg4TW09nDXss9Gg==
X-Received: by 2002:a1c:61d6:: with SMTP id v205mr1665253wmb.143.1623796912173;
        Tue, 15 Jun 2021 15:41:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x3sm3366613wmj.30.2021.06.15.15.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:41:51 -0700 (PDT)
Message-Id: <317bcc7f56cb718a8be625838576f33ce788c3ef.1623796907.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
References: <pull.969.git.1622856485.gitgitgadget@gmail.com>
        <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 22:41:46 +0000
Subject: [PATCH v2 5/5] merge-ort: add prefetching for content merges
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
index a011f8d27867..26964aa56256 100755
--- a/t/t6421-merge-partial-clone.sh
+++ b/t/t6421-merge-partial-clone.sh
@@ -396,7 +396,7 @@ test_expect_merge_algorithm failure success 'Objects downloaded when a directory
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
