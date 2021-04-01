Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACFCC433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A5D61002
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhDABcs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhDABcR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:32:17 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2417C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:32:17 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q3so733415qkq.12
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uuLMa4xusjA/p9UCyIkXDIqKqZCHc3VpkTT4qOnH+Z8=;
        b=Ysw3tnjaH+SaBrKA23rwQBJSeTxm3y+RoKabgdrpJ5kHDKbn/hahOHCWS1s6x+ugPO
         hLs3KaBH6orSqM559gdDkBtf0kkaM547vzj3lIv+iQwZ7yJMxluGDTbs1mH/gIq2a5s6
         T0Y8bdqb/kAUNR8E7SK/hU2Z4bdWz9u2Hq231gbb3BRD2HU2+sGrBeZoamIaM7016rt4
         NSMeKYfHzrghFGA369KjyN/1i2y6e3xIDZ4GEmKCYckse9vcYGX+PutC9iGsXR7Z4tyW
         NIYv/Dy+NUCy6NmLK+sQ6NDr9FZWhKGET39mLf60oWcbyv99n1+JHLwd0QBMT3DY1ywK
         KXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uuLMa4xusjA/p9UCyIkXDIqKqZCHc3VpkTT4qOnH+Z8=;
        b=AFot66DhvtSm6pC4SCLLt/171+u4/fwToQGtFYYabVkQMkdoPF8TqrmBQsv4N6DnMJ
         SFpk72x7bDNOlRRInO4HboxlHDkXQCsnsLv1is7VSuN2ppDlNYKlivuWufZxLUSWm2lH
         74taSTcwVgr7h1fOOdREpvsf3eg8b/9nefeDNsdg5UDmR1DWDXYu6YT25GIYewo4p0Hd
         NvbWS+GCczRpCQlO8QSvFpqMAJRfiBxe1JNYWhP+zP3kIsm2ZD0WZZhqxKx3vQ8VKsXv
         p0j/97RDlyXX/Oo1pOKAseaQMOZxw8V3+M0HHJ6fYJDCWWpzWQKioK6+JvP+U6hIGocW
         hY4w==
X-Gm-Message-State: AOAM531s8Nmxr8jNg0A5pEZyNhRmUG8cfqCozUCqkuqSigi87iQi8zC1
        N2hCNYAUrrYmVjQlxz44Rjo0RRR7/oAFjg==
X-Google-Smtp-Source: ABdhPJytyu09bO1pmfh7RfxY2l36jZ8RuSQp+bAviZJUZpdrLoh6zsf7XA5AACo6vK3LZ9TG0nvy2A==
X-Received: by 2002:a05:620a:954:: with SMTP id w20mr6151983qkw.208.1617240736479;
        Wed, 31 Mar 2021 18:32:16 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:90ff:e0f0:a41:6c5a])
        by smtp.gmail.com with ESMTPSA id l16sm2780929qkg.91.2021.03.31.18.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:32:16 -0700 (PDT)
Date:   Wed, 31 Mar 2021 21:32:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [PATCH 3/3] builtin/pack-objects.c: respect 'pack.preferBitmapTips'
Message-ID: <5e10199dae5e342c0482497b038b3299a8ed046b.1617240723.git.me@ttaylorr.com>
References: <cover.1617240723.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617240723.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a new pack with a bitmap, it is sometimes convenient to
indicate some reference prefixes which should receive priority when
selecting which commits to receive bitmaps.

A truly motivated caller could accomplish this by setting
'pack.islandCore', (since all commits in the core island are similarly
marked as preferred) but this requires callers to opt into using delta
islands, which they may or may not want to do.

Introduce a new multi-valued configuration, 'pack.preferBitmapTips' to
allow callers to specify a list of reference prefixes. All references
which have a prefix contained in 'pack.preferBitmapTips' will mark their
tips as "preferred" in the same way as commits are marked as preferred
for selection by 'pack.islandCore'.

The choice of the verb "prefer" is intentional: marking the NEEDS_BITMAP
flag on an object does *not* guarantee that that object will receive a
bitmap. It merely guarantees that that commit will receive a bitmap over
any *other* commit in the same window by bitmap_writer_select_commits().

The test this patch adds reflects this quirk, too. It only tests that
a commit (which didn't receive bitmaps by default) is selected for
bitmaps after changing the value of 'pack.preferBitmapTips' to include
it. Other commits may lose their bitmaps as a byproduct of how the
selection process works (bitmap_writer_select_commits() ignores the
remainder of a window after seeing a commit with the NEEDS_BITMAP flag).

This configuration will aide in selecting important references for
multi-pack bitmaps, since they do not respect the same pack.islandCore
configuration. (They could, but doing so may be confusing, since it is
packs--not bitmaps--which are influenced by the delta-islands
configuration).

In a fork network repository (one which lists all forks of a given
repository as remotes), for example, it is useful to set
pack.preferBitmapTips to 'refs/remotes/<root>/heads' and
'refs/remotes/<root>/tags', where '<root>' is an opaque identifier
referring to the repository which is at the base of the fork chain.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/pack.txt | 15 ++++++++++++++
 builtin/pack-objects.c        | 34 +++++++++++++++++++++++++++++++
 pack-bitmap.c                 |  6 ++++++
 pack-bitmap.h                 |  3 +++
 t/t5310-pack-bitmaps.sh       | 38 +++++++++++++++++++++++++++++++++++
 5 files changed, 96 insertions(+)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 3da4ea98e2..c0844d8d8e 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -122,6 +122,21 @@ pack.useSparse::
 	commits contain certain types of direct renames. Default is
 	`true`.
 
+pack.preferBitmapTips::
+	When selecting which commits will receive bitmaps, prefer a
+	commit at the tip of any reference that is a suffix of any value
+	of this configuration over any other commits in the "selection
+	window".
++
+Note that setting this configuration to `refs/foo` does not mean that
+the commits at the tips of `refs/foo/bar` and `refs/foo/baz` will
+necessarily be selected. This is because commits are selected for
+bitmaps from within a series of windows of variable length.
++
+If a commit at the tip of any reference which is a suffix of any value
+of this configuration is seen in a window, it is immediately given
+preference over any other commit in that window.
+
 pack.writeBitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 525c2d8552..a1e33d7507 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3547,6 +3547,37 @@ static void record_recent_commit(struct commit *commit, void *data)
 	oid_array_append(&recent_objects, &commit->object.oid);
 }
 
+static int mark_bitmap_preferred_tip(const char *refname,
+				     const struct object_id *oid, int flags,
+				     void *_data)
+{
+	struct object_id peeled;
+	struct object *object;
+
+	if (!peel_iterated_oid(oid, &peeled))
+		oid = &peeled;
+
+	object = parse_object_or_die(oid, refname);
+	if (object->type == OBJ_COMMIT)
+		object->flags |= NEEDS_BITMAP;
+
+	return 0;
+}
+
+static void mark_bitmap_preferred_tips(void)
+{
+	struct string_list_item *item;
+	const struct string_list *preferred_tips;
+
+	preferred_tips = bitmap_preferred_tips(the_repository);
+	if (!preferred_tips)
+		return;
+
+	for_each_string_list_item(item, preferred_tips) {
+		for_each_ref_in(item->string, mark_bitmap_preferred_tip, NULL);
+	}
+}
+
 static void get_object_list(int ac, const char **av)
 {
 	struct rev_info revs;
@@ -3601,6 +3632,9 @@ static void get_object_list(int ac, const char **av)
 	if (use_delta_islands)
 		load_delta_islands(the_repository, progress);
 
+	if (write_bitmap_index)
+		mark_bitmap_preferred_tips();
+
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 	mark_edges_uninteresting(&revs, show_edge, sparse);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 7554510b14..bfe2943a9b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -13,6 +13,7 @@
 #include "repository.h"
 #include "object-store.h"
 #include "list-objects-filter-options.h"
+#include "config.h"
 
 /*
  * An entry on the bitmap index, representing the bitmap for a given
@@ -1529,3 +1530,8 @@ off_t get_disk_usage_from_bitmap(struct bitmap_index *bitmap_git,
 
 	return total;
 }
+
+const struct string_list *bitmap_preferred_tips(struct repository *r)
+{
+	return repo_config_get_value_multi(r, "pack.preferbitmaptips");
+}
diff --git a/pack-bitmap.h b/pack-bitmap.h
index c3cdd80756..78f2b3ff79 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -5,6 +5,7 @@
 #include "khash.h"
 #include "pack.h"
 #include "pack-objects.h"
+#include "string-list.h"
 
 struct commit;
 struct repository;
@@ -91,4 +92,6 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 			  const char *filename,
 			  uint16_t options);
 
+const struct string_list *bitmap_preferred_tips(struct repository *r);
+
 #endif
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 40b9f63244..f53efc8229 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -554,4 +554,42 @@ test_expect_success 'fetch with bitmaps can reuse old base' '
 	)
 '
 
+test_expect_success 'pack.preferBitmapTips' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		# create enough commits that not all are receive bitmap
+		# coverage even if they are all at the tip of some reference.
+		test_commit_bulk --message="%s" 103 &&
+
+		git rev-list HEAD >commits.raw &&
+		sort <commits.raw >commits &&
+
+		git log --format="create refs/tags/%s %H" HEAD >refs &&
+		git update-ref --stdin <refs &&
+
+		git repack -adb &&
+		test-tool bitmap list-commits | sort >bitmaps &&
+
+		# remember which commits did not receive bitmaps
+		comm -13 bitmaps commits >before &&
+		test_file_not_empty before &&
+
+		# mark the commits which did not receive bitmaps as preferred,
+		# and generate the bitmap again
+		perl -pe "s{^}{create refs/tags/include/$. }" <before |
+			git update-ref --stdin &&
+		git -c pack.preferBitmapTips=refs/tags/include repack -adb &&
+
+		# finally, check that the commit(s) without bitmap coverage
+		# are not the same ones as before
+		test-tool bitmap list-commits | sort >bitmaps &&
+		comm -13 bitmaps commits >after &&
+
+		! test_cmp before after
+	)
+'
+
 test_done
-- 
2.31.1.163.ga65ce7f831
