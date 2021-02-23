Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429CBC433E6
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 02:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01EE164E41
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 02:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhBWCZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 21:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhBWCZu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 21:25:50 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CABEC061786
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 18:25:10 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id w6so3445053qti.6
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 18:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Syl7pgPRDV3Zgw4+z7AOzr7mqoMDXf9fvjaN5CZKjXo=;
        b=dNJ0AYHfGTGnf+jPM5MoClBB0Tr2i0gqZCh02x/8E0P437MD290QbCqUMLO41L4S3C
         BZATGQIDi3mCmYQfAZsYk5QPuy5mBu+fNpeOXbYtv3nWVemAhpNo/7sPUF6GxuNKFVCW
         mjatyXdy7oVUUap4hUNHwT9mQZKDDYe13MYcAi0hRxNpvYO12l81cU/oYHn2PX9A3adD
         d/CUNhoJ+Kb6Mb2+R50y4G6r/eOAPBJBNsIxIzuu5DIcupvl5MMKqILqd9mK1rc3J+E8
         BRExsjzDDz69caoM6shK2DSnQCYO6QU8E99rg0295fxjLeztVrPM3Lwq78vzly/85uFB
         p/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Syl7pgPRDV3Zgw4+z7AOzr7mqoMDXf9fvjaN5CZKjXo=;
        b=EJ68jMdero3Tu9QEcnXBZPZ+4CzZ6mbUYuEoZHSI5B13r7yfH5PEFH9CKbIKuV7ZDb
         Lro+8tFKiFCGu1XHeCYHa9oHlB6glAKvU6Q5zMZB1VBDWiHVKI6EtxeKNBKzRrsD1o66
         EXT6lef2WMX48pl3M0mezdtyWLLdodIV+Skw+k8F+qN8EgxCKgjbEYyhwahdgKNbhkQA
         GTAO4JKRXlWsMBYxTEPMMQgVbxeNKFk01Yav39nYm7uoyyujOM5zEKXttHrx447a7QZW
         P9H/PePMTwIglJSf9V/E0t9ZyJRdnMMD8/jzhpyDt5C/u0vqjhduegGmnw8RGRbMqRw5
         CuUw==
X-Gm-Message-State: AOAM533mYSzVq/QvD+ezvVfYY7uY8oeS2B7uhA7A3COFUN4AhuZXGgBh
        m0ipekK9YXsWrlI3fJsjPFDbrm3UqdMHh6rs
X-Google-Smtp-Source: ABdhPJw5Lj0Miv5G6NCLVmizwE2RZYh9f9GMnuzoFqmixQCiPSmrtZPvXo+/M53HSUaf6WlVgWRlfw==
X-Received: by 2002:a05:622a:347:: with SMTP id r7mr21547484qtw.279.1614047108959;
        Mon, 22 Feb 2021 18:25:08 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:29df:918f:599f:2c96])
        by smtp.gmail.com with ESMTPSA id s60sm12602996qtd.16.2021.02.22.18.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 18:25:08 -0800 (PST)
Date:   Mon, 22 Feb 2021 21:25:07 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH v4 2/8] revision: learn '--no-kept-objects'
Message-ID: <c85a9155970aa3f59990d3678da21bb88a9cac08.1614047097.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1614047097.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614047097.git.me@ttaylorr.com>
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

Note that this option is not guaranteed to produce exactly the set of
objects that aren't in kept packs, since it's possible the traversal
order may end up in a situation where a non-kept ancestor was "cut off"
by a kept object (at which point we would stop traversing). But, we
don't care about absolute correctness here, since this will eventually
be used as a purely additive guide in an upcoming new repack mode.

Explicitly avoid documenting this new flag, since it is only used
internally. In theory we could avoid even adding it rev-list, but being
able to spell this option out on the command-line makes some special
cases easier to test without promising to keep it behaving consistently
forever. Those tricky cases are exercised in t6114.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 revision.c            | 15 ++++++++++
 revision.h            |  4 +++
 t/t6114-keep-packs.sh | 69 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100755 t/t6114-keep-packs.sh

diff --git a/revision.c b/revision.c
index b78733f508..dca2b8c801 100644
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
@@ -3795,6 +3805,11 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
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
2.30.0.667.g81c0cbc6fd

