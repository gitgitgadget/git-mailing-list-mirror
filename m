Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A412C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 03:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE77611BD
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 03:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbhIKDeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 23:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbhIKDeA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 23:34:00 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF70C061756
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 20:32:49 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id b7so4885474iob.4
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 20:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VJpZVkqRjSBizAd4VUhQzPiopMFRuuF2IEzkU/g6r7M=;
        b=BjIhkhrYXobJubqbkQSuRSCCfPoW3NcU1/z1jk4Zf+RwD4/tpGpIdoRC3p+btvEKAa
         VKsAvTMefEApIixmMqJ5Qk6eGC359NkTzS6tvwieBAQMqt6jFf4oMeizvQ/yNTki23A/
         kk89xIZphlrQ/KExeBmLbvq6zGwm1PtGLxEpOzxaEPHn+9M1GKiEHHby52hu0YSjXYpj
         Xnn9RYJTWVJChVQtngdGmTy4F3wtw+pJvuBCyUv7/jKq0SDCOTcDJ5InaB7zHWj4RvjZ
         NE61ixED2PVjpJYazfl7I4sp12nxU3lqX2SeOFvXR+ku7J7eCIq04p2gXzSrpfD0sf/u
         4FRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VJpZVkqRjSBizAd4VUhQzPiopMFRuuF2IEzkU/g6r7M=;
        b=XY1Cku3FNXK6EPdDS6EDLiOYuJSmcYY+sMOMOLUb972w4HyoxtWLHw6SkzSJmON5Fa
         r7yxJj8ltdHXFSLGwg2Z+7D80Jm3CUQBwJbWMnXHpGLrtHOBNO+KEW1kAKq0jh9Tox5c
         snacX1fL+g2PfoMptTqsPSlnA3MPPQFtuFifRqxn1ydQzU0bDl0eNsZf4qFeFjk89vZo
         qrlrxRP2iI2ey7lAAIvar5saSLIxDmW2w0DOwlKbK56dWF70TrzzOEYmQH2kZj05EkYK
         gTR/zuRu6vmGIXvOoXOgTgvAJO3W+YoYrzs+t9ff84w4gbWnlvR35waf+XgX0ImNiHPP
         D0/g==
X-Gm-Message-State: AOAM530GEzvqo8LToIS66kk5cyr1ZbOhWqA4M2o+a1f3T4ENQjc39KBn
        AmEBuvBGB71GE9chsLeDXxc43/UXKpHPMKy7
X-Google-Smtp-Source: ABdhPJw6AdL5kmoyCKIhBMuvODbh4KPRXSr3MMmwrQL3YjTc1BWVGZetgRDmqe9m40eM3ibAdstvgA==
X-Received: by 2002:a02:cc30:: with SMTP id o16mr760067jap.101.1631331168330;
        Fri, 10 Sep 2021 20:32:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c5sm304009ilk.48.2021.09.10.20.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 20:32:48 -0700 (PDT)
Date:   Fri, 10 Sep 2021 23:32:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 7/8] builtin/repack.c: make largest pack preferred
Message-ID: <a790ee5ac6c03d6832599e77f84c352f577d6287.1631331139.git.me@ttaylorr.com>
References: <cover.1631331139.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631331139.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When repacking into a geometric series and writing a multi-pack bitmap,
it is beneficial to have the largest resulting pack be the preferred
object source in the bitmap's MIDX, since selecting the large packs can
lead to fewer broken delta chains and better compression.

Teach 'git repack' to identify this pack and pass it to the MIDX write
machinery in order to mark it as preferred.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-repack.txt |  4 ++++
 builtin/repack.c             | 23 ++++++++++++++++++++++-
 pack-bitmap.c                |  2 +-
 pack-bitmap.h                |  1 +
 t/helper/test-read-midx.c    | 25 ++++++++++++++++++++++++-
 t/t7703-repack-geometric.sh  | 23 +++++++++++++++++++++++
 6 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 0f2d235ca5..7183fb498f 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -190,6 +190,10 @@ this "roll-up", without respect to their reachability. This is subject
 to change in the future. This option (implying a drastically different
 repack mode) is not guaranteed to work with all other combinations of
 option to `git repack`.
++
+When writing a multi-pack bitmap, `git repack` selects the largest resulting
+pack as the preferred pack for object selection by the MIDX (see
+linkgit:git-multi-pack-index[1]).
 
 -m::
 --write-midx::
diff --git a/builtin/repack.c b/builtin/repack.c
index cb4292ab37..e958caff8b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -422,6 +422,13 @@ static void split_pack_geometry(struct pack_geometry *geometry, int factor)
 	geometry->split = split;
 }
 
+static struct packed_git *get_largest_active_pack(struct pack_geometry *geometry)
+{
+	if (geometry->split == geometry->pack_nr)
+		return NULL;
+	return geometry->pack[geometry->pack_nr - 1];
+}
+
 static void clear_pack_geometry(struct pack_geometry *geometry)
 {
 	if (!geometry)
@@ -469,6 +476,7 @@ static void midx_included_packs(struct string_list *include,
 }
 
 static int write_midx_included_packs(struct string_list *include,
+				     struct pack_geometry *geometry,
 				     int show_progress, int write_bitmaps)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -490,6 +498,19 @@ static int write_midx_included_packs(struct string_list *include,
 	if (write_bitmaps)
 		strvec_push(&cmd.args, "--bitmap");
 
+	if (geometry) {
+		struct packed_git *largest = get_largest_active_pack(geometry);
+		if (largest)
+			strvec_pushf(&cmd.args, "--preferred-pack=%s",
+				     pack_basename(largest));
+		else
+			/*
+			 * The largest pack was repacked, meaning only one pack
+			 * exists (and tautologically, it is the largest).
+			 */
+			;
+	}
+
 	ret = start_command(&cmd);
 	if (ret)
 		return ret;
@@ -776,7 +797,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		midx_included_packs(&include, &existing_packs,
 				    &existing_kept_packs, &names, geometry);
 
-		ret = write_midx_included_packs(&include,
+		ret = write_midx_included_packs(&include, geometry,
 						show_progress, write_bitmaps > 0);
 
 		string_list_clear(&include, 0);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 8504110a4d..67be9be9a6 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1418,7 +1418,7 @@ static int try_partial_reuse(struct packed_git *pack,
 	return 0;
 }
 
-static uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git)
+uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git)
 {
 	struct multi_pack_index *m = bitmap_git->midx;
 	if (!m)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 469090bad2..7d407c5a4c 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -55,6 +55,7 @@ int test_bitmap_commits(struct repository *r);
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 					 struct list_objects_filter_options *filter,
 					 int filter_provided_objects);
+uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git);
 int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
 				       struct packed_git **packfile,
 				       uint32_t *entries,
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index cb0d27049a..0038559129 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -3,6 +3,7 @@
 #include "midx.h"
 #include "repository.h"
 #include "object-store.h"
+#include "pack-bitmap.h"
 
 static int read_midx_file(const char *object_dir, int show_objects)
 {
@@ -72,14 +73,36 @@ static int read_midx_checksum(const char *object_dir)
 	return 0;
 }
 
+static int read_midx_preferred_pack(const char *object_dir)
+{
+	struct multi_pack_index *midx = NULL;
+	struct bitmap_index *bitmap = NULL;
+
+	setup_git_directory();
+
+	midx = load_multi_pack_index(object_dir, 1);
+	if (!midx)
+		return 1;
+
+	bitmap = prepare_bitmap_git(the_repository);
+	if (!(bitmap && bitmap_is_midx(bitmap)))
+		return 1;
+
+
+	printf("%s\n", midx->pack_names[midx_preferred_pack(bitmap)]);
+	return 0;
+}
+
 int cmd__read_midx(int argc, const char **argv)
 {
 	if (!(argc == 2 || argc == 3))
-		usage("read-midx [--show-objects|--checksum] <object-dir>");
+		usage("read-midx [--show-objects|--checksum|--preferred-pack] <object-dir>");
 
 	if (!strcmp(argv[1], "--show-objects"))
 		return read_midx_file(argv[2], 1);
 	else if (!strcmp(argv[1], "--checksum"))
 		return read_midx_checksum(argv[2]);
+	else if (!strcmp(argv[1], "--preferred-pack"))
+		return read_midx_preferred_pack(argv[2]);
 	return read_midx_file(argv[1], 0);
 }
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 5ccaa440e0..7bdeffa111 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -180,4 +180,27 @@ test_expect_success '--geometric ignores kept packs' '
 	)
 '
 
+test_expect_success '--geometric chooses largest MIDX preferred pack' '
+	git init geometric &&
+	test_when_finished "rm -fr geometric" &&
+	(
+		cd geometric &&
+		git config core.multiPackIndex true &&
+
+		# These packs already form a geometric progression.
+		test_commit_bulk --start=1 1 && # 3 objects
+		test_commit_bulk --start=2 2 && # 6 objects
+		ls $objdir/pack/pack-*.idx >before &&
+		test_commit_bulk --start=4 4 && # 12 objects
+		ls $objdir/pack/pack-*.idx >after &&
+
+		git repack --geometric 2 -dbm &&
+
+		comm -3 before after | xargs -n 1 basename >expect &&
+		test-tool read-midx --preferred-pack $objdir >actual &&
+
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.33.0.96.g73915697e6

