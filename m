Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E26C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 04:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1985C64F6A
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 04:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhBDEA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 23:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhBDD7l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 22:59:41 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ECFC0613ED
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 19:59:00 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id o18so1488025qtp.10
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 19:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gxrlNMz2QDR056RmX2LunugGE3qRRmBmpvjbiNyIYLo=;
        b=i/dAdc83+RxjxFeIqw/nUBK4yDJq7laOuBuGC7oOJhNkohUCX1+pUyzVSDMpRswZ94
         VtSHjRa9BnV4/1kJ5JUJEvr401BhaP5zTvwzvnkjlyoKb0ApYaaYQcXkRtSfvlQjSwlY
         +JLRGybWVXl9XlFhymsRF7xULaYR71GQJfTDKMQWRVMlKQhdQ6jF9t6vlX3oReiRstFq
         Q4NxEFtR+PVHYTRsP4oNqlXa4y0hYR7R+PT8xoTeBqOZTGywSi9l2Yl26ZclZq8WR/C6
         P6MInkJEjDLThutNJCFhd8tlQIhbYTQvvxqErZtmvS2/YdcyJF7UoMyid63gRhsTJ0cu
         Ycug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gxrlNMz2QDR056RmX2LunugGE3qRRmBmpvjbiNyIYLo=;
        b=UgBpXuhYPWjdcF6iUNAjv5hToNC448p+G7WN5qL06TDqfwZHPfQ+liEcRAdYBvTBfm
         7gCvmg/MMribLiovMaJwSO3wWf8w3hsJiWuaxTiQk51uGSzXwH8ENfBEPtI7M/Z99hzn
         S+D2R3ArDjawTf1EnNBT4HU3Eru57DcHKSConiEl0iJud6y84nysmFRghtd2iBl5IgNE
         T3fRUkFm4i8sNTyfDcsJUyAheUZq+FUqzKy+UAGgsb8hYRhzP80Su0qF55k4W/+Q94kT
         ym0BGAVM4OwClNfCw9oiSPgBjh8HNUE3cZimfo8HtSDCOzxpZtWYv8NCziE0kV0d7feR
         eMnA==
X-Gm-Message-State: AOAM533Z5p8x1olKUJBIJQ3tR9Q6U2k8XSCF/aVYfdAnBNBoQZJRwmI+
        UgwtI3HJxqvx7iVHnHJz/7v9olnrOlK/gA==
X-Google-Smtp-Source: ABdhPJwf+abhOtcT2tP5VF7Um15SlUG9+bbsJfmTxC3XouonzmiMjcgRFBFo7fP3wVhIGAIfzEXw/Q==
X-Received: by 2002:ac8:78a:: with SMTP id l10mr5549849qth.10.1612411139796;
        Wed, 03 Feb 2021 19:58:59 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:3a5f:649:7bf7:4ac8])
        by smtp.gmail.com with ESMTPSA id k90sm2200249qtd.0.2021.02.03.19.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 19:58:59 -0800 (PST)
Date:   Wed, 3 Feb 2021 22:58:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH v2 2/8] revision: learn '--no-kept-objects'
Message-ID: <ddc2896caa13b9f1cdccb2f0a5892143fa98237c.1612411123.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1612411123.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A future caller will want to be able to perform a reachability traversal
which terminates when visiting an object found in a kept pack. The
closest existing option is '--honor-pack-keep', but this isn't quite
what we want. Instead of halting the traversal midway through, a full
traversal is always performed, and the results are only trimmed
afterwords.

Besides needing to introduce a new flag (since culling results
post-facto can be different than halting the traversal as it's
happening), there is an additional wrinkle handling the distinction
in-core and on-disk kept packs. That is: what kinds of kept pack should
stop the traversal?

Introduce '--no-kept-objects[=<on-disk|in-core>]' to specify which kinds
of kept packs, if any, should stop a traversal. This can be useful for
callers that want to perform a reachability analysis, but want to leave
certain packs alone (for e.g., when doing a geometric repack that has
some "large" packs which are kept in-core that it wants to leave alone).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/rev-list-options.txt |  7 +++
 list-objects.c                     |  7 +++
 revision.c                         | 15 +++++++
 revision.h                         |  4 ++
 t/t6114-keep-packs.sh              | 69 ++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+)
 create mode 100755 t/t6114-keep-packs.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 96cc89d157..f611832277 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -861,6 +861,13 @@ ifdef::git-rev-list[]
 	Only useful with `--objects`; print the object IDs that are not
 	in packs.
 
+--no-kept-objects[=<kind>]::
+	Halts the traversal as soon as an object in a kept pack is
+	found. If `<kind>` is `on-disk`, only packs with a corresponding
+	`*.keep` file are ignored. If `<kind>` is `in-core`, only packs
+	with their in-core kept state set are ignored. Otherwise, both
+	kinds of kept packs are ignored.
+
 --object-names::
 	Only useful with `--objects`; print the names of the object IDs
 	that are found. This is the default behavior.
diff --git a/list-objects.c b/list-objects.c
index e19589baa0..b06c3bfeba 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -338,6 +338,13 @@ static void traverse_trees_and_blobs(struct traversal_context *ctx,
 			ctx->show_object(obj, name, ctx->show_data);
 			continue;
 		}
+		if (ctx->revs->no_kept_objects) {
+			struct pack_entry e;
+			if (find_kept_pack_entry(ctx->revs->repo, &obj->oid,
+						 ctx->revs->keep_pack_cache_flags,
+						 &e))
+				continue;
+		}
 		if (!path)
 			path = "";
 		if (obj->type == OBJ_TREE) {
diff --git a/revision.c b/revision.c
index fbc3e607fd..4c5adb90b1 100644
--- a/revision.c
+++ b/revision.c
@@ -2336,6 +2336,16 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->unpacked = 1;
 	} else if (starts_with(arg, "--unpacked=")) {
 		die(_("--unpacked=<packfile> no longer supported"));
+	} else if (!strcmp(arg, "--no-kept-objects")) {
+		revs->no_kept_objects = 1;
+		revs->keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
+		revs->keep_pack_cache_flags |= ON_DISK_KEEP_PACKS;
+	} else if (skip_prefix(arg, "--no-kept-objects=", &optarg)) {
+		revs->no_kept_objects = 1;
+		if (!strcmp(optarg, "in-core"))
+			revs->keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
+		if (!strcmp(optarg, "on-disk"))
+			revs->keep_pack_cache_flags |= ON_DISK_KEEP_PACKS;
 	} else if (!strcmp(arg, "-r")) {
 		revs->diff = 1;
 		revs->diffopt.flags.recursive = 1;
@@ -3797,6 +3807,11 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 		return commit_ignore;
 	if (revs->unpacked && has_object_pack(&commit->object.oid))
 		return commit_ignore;
+	if (revs->no_kept_objects) {
+		if (has_object_kept_pack(&commit->object.oid,
+					 revs->keep_pack_cache_flags))
+			return commit_ignore;
+	}
 	if (commit->object.flags & UNINTERESTING)
 		return commit_ignore;
 	if (revs->line_level_traverse && !want_ancestry(revs)) {
diff --git a/revision.h b/revision.h
index e6be3c845e..a20a530d52 100644
--- a/revision.h
+++ b/revision.h
@@ -148,6 +148,7 @@ struct rev_info {
 			edge_hint_aggressive:1,
 			limited:1,
 			unpacked:1,
+			no_kept_objects:1,
 			boundary:2,
 			count:1,
 			left_right:1,
@@ -317,6 +318,9 @@ struct rev_info {
 	 * This is loaded from the commit-graph being used.
 	 */
 	struct bloom_filter_settings *bloom_filter_settings;
+
+	/* misc. flags related to '--no-kept-objects' */
+	unsigned keep_pack_cache_flags;
 };
 
 int ref_excluded(struct string_list *, const char *path);
diff --git a/t/t6114-keep-packs.sh b/t/t6114-keep-packs.sh
new file mode 100755
index 0000000000..9239d8aa46
--- /dev/null
+++ b/t/t6114-keep-packs.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+test_description='rev-list with .keep packs'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit loose &&
+	test_commit packed &&
+	test_commit kept &&
+
+	KEPT_PACK=$(git pack-objects --revs .git/objects/pack/pack <<-EOF
+	refs/tags/kept
+	^refs/tags/packed
+	EOF
+	) &&
+	MISC_PACK=$(git pack-objects --revs .git/objects/pack/pack <<-EOF
+	refs/tags/packed
+	^refs/tags/loose
+	EOF
+	) &&
+
+	touch .git/objects/pack/pack-$KEPT_PACK.keep
+'
+
+rev_list_objects () {
+	git rev-list "$@" >out &&
+	sort out
+}
+
+idx_objects () {
+	git show-index <$1 >expect-idx &&
+	cut -d" " -f2 <expect-idx | sort
+}
+
+test_expect_success '--no-kept-objects excludes trees and blobs in .keep packs' '
+	rev_list_objects --objects --all --no-object-names >kept &&
+	rev_list_objects --objects --all --no-object-names --no-kept-objects >no-kept &&
+
+	idx_objects .git/objects/pack/pack-$KEPT_PACK.idx >expect &&
+	comm -3 kept no-kept >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success '--no-kept-objects excludes kept non-MIDX object' '
+	test_config core.multiPackIndex true &&
+
+	# Create a pack with just the commit object in pack, and do not mark it
+	# as kept (even though it appears in $KEPT_PACK, which does have a .keep
+	# file).
+	MIDX_PACK=$(git pack-objects .git/objects/pack/pack <<-EOF
+	$(git rev-parse kept)
+	EOF
+	) &&
+
+	# Write a MIDX containing all packs, but use the version of the commit
+	# at "kept" in a non-kept pack by touching $MIDX_PACK.
+	touch .git/objects/pack/pack-$MIDX_PACK.pack &&
+	git multi-pack-index write &&
+
+	rev_list_objects --objects --no-object-names --no-kept-objects HEAD >actual &&
+	(
+		idx_objects .git/objects/pack/pack-$MISC_PACK.idx &&
+		git rev-list --objects --no-object-names refs/tags/loose
+	) | sort >expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.30.0.533.g2f8b6b552f.dirty

