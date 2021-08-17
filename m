Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1C8C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF6060FD9
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhHQRJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhHQRJX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:09:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885D8C06179A
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:08:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o15so625440wmr.3
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ev/we/PiyCSnXRohXJH3BmgEao9qB47yJWiBW2A7p8c=;
        b=ZoEMaGOZUSzHqvjIArYvFwsZwtr0SutYPDBiIUCGVZyLpi4oMXUgyGfgG7U5JktnFk
         Kg8VB5ury8IqX1rZuLfeIX87Xig72+hKQcWPlVYD4jsfoUV5vdOhbma0LzZ33K+0jHW3
         BC9vLalxQXY7nTQdbRZJAjL4DwuuIE0GXY0i0emYLaSTsDHsMeXoLTl662StiwDN5CtZ
         MioeGaCOQS9umbTeQFdCUk7qTb49GMP4C9LdAbPeMAxK0qrpjxEKc4JkPG/K4EewdziD
         pjNsjyL4GJEilWbEhWGrlGpOSGTGuKfk5GR8fIRPGtF+EeObEpwV/SpYC0dQC24/8sGK
         xzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ev/we/PiyCSnXRohXJH3BmgEao9qB47yJWiBW2A7p8c=;
        b=En1MtbBMUJxRSq5gf11t6n8hXp1ZJMg/V4++7OSXZmoRvlEnehpusLebibhxw5IBeX
         CDAx9Vz2NLpg+6u3roWkpDS1bW7lEfT9YPndBNxzmnQtd3PM3gD+ENzlAPnmOEZnJ45y
         bhzl4FCC0453k3XNzYm8x1qZbSi0OIHIK/+0IMkMRSlbnmyi++Mrkd0szcApfFkISUeX
         hgkD+xInYnXhCvah+gDdV6fgRDR/mm7fZ6YD09F1bq0yABB325R/qm+GVhGgYQ9ps440
         idbuC6D/UOxbm99jxulJ2XWwm3vRGp8+2JSJgShxLPICPH5kWuJqsAGSiiCDz5J635/p
         eF6Q==
X-Gm-Message-State: AOAM5337WoqVb6opUFqcz2Mu5ZBC54QHC9Bj0i2UR1WLisyAhjXrOE5r
        L1U0EzHptMTsua/dwqOn0ufrpNC/4uI=
X-Google-Smtp-Source: ABdhPJypJuft8Ypcijv3OGSz4TgAOeA93l6Twc/oAAtHgx+dyPnT5NqcZEZZ3w0MVhbG5omqe4iwiA==
X-Received: by 2002:a1c:9ace:: with SMTP id c197mr4481609wme.170.1629220128030;
        Tue, 17 Aug 2021 10:08:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l19sm2849770wmi.4.2021.08.17.10.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:08:47 -0700 (PDT)
Message-Id: <e47b15554e3770571aafe44b4492d2f420f13919.1629220124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 17:08:42 +0000
Subject: [PATCH 4/6] merge-ort: expand only for out-of-cone conflicts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Merge conflicts happen often enough to want to avoid expanding a sparse
index when they happen, as long as those conflicts are within the
sparse-checkout cone. If a conflict exists outside of the
sparse-checkout cone, then we still need to expand before iterating over
the index entries. This is critical to do in advance because of how the
original_cache_nr is tracked to allow inserting and replacing cache
entries.

Iterate over the conflicted files and check if any paths are outside of
the sparse-checkout cone. If so, then expand the full index.

Add a test that demonstrates that we do not expand the index, even when
we hit a conflict within the sparse-checkout cone.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 merge-ort.c                              | 14 ++++++++---
 t/t1092-sparse-checkout-compatibility.sh | 30 ++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 8e754b769e1..590e52058cf 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -36,6 +36,7 @@
 #include "tree.h"
 #include "unpack-trees.h"
 #include "xdiff-interface.h"
+#include "dir.h"
 
 /*
  * We have many arrays of size 3.  Whenever we have such an array, the
@@ -4060,11 +4061,18 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 
 	/*
 	 * We are in a conflicted state. These conflicts might be inside
-	 * sparse-directory entries, so expand the index preemtively.
-	 * Also, we set original_cache_nr below, but that might change if
+	 * sparse-directory entries, so check if any entries are outside
+	 * of the sparse-checkout cone preemptively.
+	 *
+	 * We set original_cache_nr below, but that might change if
 	 * index_name_pos() calls ask for paths within sparse directories.
 	 */
-	ensure_full_index(index);
+	strmap_for_each_entry(&opt->priv->conflicted, &iter, e) {
+		if (!path_in_sparse_checkout(e->key, index)) {
+			ensure_full_index(index);
+			break;
+		}
+	}
 
 	/* If any entries have skip_worktree set, we'll have to check 'em out */
 	state.force = 1;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 781ebd9a656..a0ed2bec574 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -622,8 +622,21 @@ test_expect_success 'sparse-index is expanded and converted back' '
 ensure_not_expanded () {
 	rm -f trace2.txt &&
 	echo >>sparse-index/untracked.txt &&
-	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git -C sparse-index "$@" &&
+
+	if test "$1" = "!"
+	then
+		shift &&
+		(
+			GIT_TRACE2_EVENT="$(pwd)/trace2.txt" &&
+			GIT_TRACE2_EVENT_NESTING=10 &&
+			export GIT_TRACE2_EVENT &&
+			export GIT_TRACE2_EVENT_NESTING &&
+			test_must_fail git -C sparse-index "$@" || return 1
+		)
+	else
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+			git -C sparse-index "$@" || return 1
+	fi &&
 	test_region ! index ensure_full_index trace2.txt
 }
 
@@ -659,6 +672,19 @@ test_expect_success 'sparse-index is not expanded' '
 	ensure_not_expanded merge -s ort -m merge update-folder2
 '
 
+test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
+	init_repos &&
+
+	for side in right left
+	do
+		git -C sparse-index checkout -b expand-$side base &&
+		echo $side >sparse-index/deep/a &&
+		git -C sparse-index commit -a -m "$side" || return 1
+	done &&
+
+	ensure_not_expanded ! merge -m merged expand-right
+'
+
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 # in this scenario, but it shouldn't.
 test_expect_success 'reset mixed and checkout orphan' '
-- 
gitgitgadget

