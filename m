Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB1EC433E6
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9D164E3E
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBRDPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 22:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhBRDPD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 22:15:03 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CA8C0613D6
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:14:22 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id b24so443176qtp.13
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9gFIdURqgyY5neZOZpdb2y6B4ghQ88Obpt5irfLsWY0=;
        b=miNsWSv6dqCNq2u/JGENio+BN0zWf2rwmz/yIX7R5S5eAn5mVsiYrGdPiIpqC64Dlu
         XC9SWTEA0kymliHcPtv1RR67zbyhgB8+e0pGEl9QVusU1NXIHFaye9qrPLJWoBaeJP9p
         sYfrkse3mTThCID9xDdISXhDMZck/iylkZRQw4OlrxWTpOphiN1yuo2UVLGcRx2Pd7xT
         isF2qPsA8rOXBLFpZzDOjRyhTqWwbXWGA2/1OwS2PBqFKLo7xiveWkcTrx3QSf/x8arm
         5/oK5mFCAPXkrA/PPHrC+vu4u6k2qfbngR1NqWFc3rNolgRvjLlzypQBi905Qd1gYIgz
         rouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9gFIdURqgyY5neZOZpdb2y6B4ghQ88Obpt5irfLsWY0=;
        b=kkU0yI+ijBNzdEyFKO/Qu9lhj6eOq+hhXR8xjPFnJ50u0ZQVzc2J6v69gES0J4X46R
         p4uTBmDwOSeG31cZlgNnqOWUXTJRwDdelwEXmS/imV1Pdmeoz0iyqYCXOcKK9P38/wrZ
         zFYUHFb+PA28SVy64gZLD+5+umgyZs8kbuDkGk5cGuTcrbk0gmrBo7k4WDiL2FhDdOQj
         gfgxUYa3dNeZDlqxerFFzOY2GmuBWt/rt3lb7r/N5uNHlwGyr+2pd7EKJdrkjdJ+x2+B
         1569n6XofePaFO5ueBCZvipaPtbYz3fPxFWCo5ibqTFA+excsHeidXo3mc9E7sJIomtI
         agAg==
X-Gm-Message-State: AOAM533+nMzD8T/AykeFCJCCmEk4EDIC7GqPUMPDc9Tw9KmRlVPpa7sx
        am6ZE3mz1B+TMM+D8AtnuJCr0mW+MACNHdSv
X-Google-Smtp-Source: ABdhPJzs/MK5fsHLDBXpGmZt5Y5/f0iEzH+M7oCf2Vpw1ozahOalfO5BRH9QWAcRH2NaZ6GrkC53KQ==
X-Received: by 2002:ac8:110e:: with SMTP id c14mr2358418qtj.293.1613618061639;
        Wed, 17 Feb 2021 19:14:21 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:1f29:6ff9:b466:8c60])
        by smtp.gmail.com with ESMTPSA id 197sm3041430qkf.33.2021.02.17.19.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 19:14:21 -0800 (PST)
Date:   Wed, 17 Feb 2021 22:14:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH v3 2/8] revision: learn '--no-kept-objects'
Message-ID: <82f6b45463586a90b95d7457a463eb7c50838648.1613618042.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1613618042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1613618042.git.me@ttaylorr.com>
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
index 3efd994160..f9311f3a73 100644
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
@@ -3792,6 +3802,11 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
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

