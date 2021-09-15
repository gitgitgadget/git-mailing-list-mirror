Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4D6C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3581B60E97
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhIOS0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhIOS0L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:26:11 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD63C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:52 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h20so3898549ilj.13
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5AGcdBZYcDwaHEeZUNIAZB4LYXSN6ldlxO327+NfrQs=;
        b=SvnaI8L6/X0aH5y55BWhosyM+XtJGxiT+maDsvdiOQwvGt4b3PwHPEpgLV1ZPAQnxe
         V+WvAtc8rJ0ZrXQKQUqmTtBJG+PmLmJNKObIaDJEfBokJ64+zwAqhPM3JR6TO6/8cVRF
         Zlgo2xXNp6Zp263a+Ds/CxAaSFFzAzO1bit97bxpyFBBUDy/femXcabQ7A4SmAOE2eIO
         GtUsiyClD6dHrOT8jaYErNwA2qqxiIXJt54Ec87i+3e+mw6z4277m++SjQqh3KI8nywY
         h/Z+3OW+v+PZjkspgrDA1wI3oqY5J8/lT/pAU+EWcFnxIUdzsVzA3OhLfXksA963un4B
         nn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5AGcdBZYcDwaHEeZUNIAZB4LYXSN6ldlxO327+NfrQs=;
        b=JkBrmhnxL8nBSHE1yKyPlCsd8KobLAG6JwjEff8dOKvxDrXc3+JOdapI7Bn+RiGoNC
         mgKH7snCAteMan0ZIDG6sNGtY4seLq+7JgP0JcwpCpR549zQLsDgBprfXQ5ucZeQpJGi
         4htR1JICKYIGBjKRsn/jP8Ggk7LeoX4Nmnfv9PzhYfWkFctzmNgSoAPtViFBIxOV3uOi
         QwY+GagOdp3WFLdGeWl1KSE6yjPwvzvIp6lA7MPYzVq+Kdq9ePmhgINTysuuEBGNeXGG
         549H1LoQH+rEe/rXg+dwAlDHnDdwsfd6nm8YqZ7hPmAnHLEt4Co9KOYxRdUOvChShzDQ
         7ZUA==
X-Gm-Message-State: AOAM531kzxwCAWjNFOD2DE+IFJnD+lkR9Xz8i1S84c+dq+RVtQd6WA5E
        Y1xkNHLmQ2jfsiCLOhYwuGXuW9xdZdl4PwKE
X-Google-Smtp-Source: ABdhPJxrYY4p5KCFNDdW6iw9fl4xDHeVrhABjXC3xK/38U83OBVwKI5UEgTOMfW9Ic2BGDVkP5/rXw==
X-Received: by 2002:a05:6e02:144c:: with SMTP id p12mr1122000ilo.292.1631730291025;
        Wed, 15 Sep 2021 11:24:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m5sm413539ila.10.2021.09.15.11.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:24:50 -0700 (PDT)
Date:   Wed, 15 Sep 2021 14:24:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 7/8] builtin/repack.c: make largest pack preferred
Message-ID: <68bc49d8aed438303e422530c74f2e970c7d66a4.1631730270.git.me@ttaylorr.com>
References: <cover.1631331139.git.me@ttaylorr.com>
 <cover.1631730270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631730270.git.me@ttaylorr.com>
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
 builtin/repack.c             | 27 ++++++++++++++++++++++++++-
 pack-bitmap.c                |  2 +-
 pack-bitmap.h                |  1 +
 t/helper/test-read-midx.c    | 25 ++++++++++++++++++++++++-
 t/t7703-repack-geometric.sh  | 22 ++++++++++++++++++++++
 6 files changed, 78 insertions(+), 3 deletions(-)

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
index ca18d3dd2e..8c7bc4551e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -422,6 +422,25 @@ static void split_pack_geometry(struct pack_geometry *geometry, int factor)
 	geometry->split = split;
 }
 
+static struct packed_git *get_largest_active_pack(struct pack_geometry *geometry)
+{
+	if (!geometry) {
+		/*
+		 * No geometry means either an all-into-one repack (in which
+		 * case there is only one pack left and it is the largest) or an
+		 * incremental one.
+		 *
+		 * If repacking incrementally, then we could check the size of
+		 * all packs to determine which should be preferred, but leave
+		 * this for later.
+		 */
+		return NULL;
+	}
+	if (geometry->split == geometry->pack_nr)
+		return NULL;
+	return geometry->pack[geometry->pack_nr - 1];
+}
+
 static void clear_pack_geometry(struct pack_geometry *geometry)
 {
 	if (!geometry)
@@ -467,10 +486,12 @@ static void midx_included_packs(struct string_list *include,
 }
 
 static int write_midx_included_packs(struct string_list *include,
+				     struct pack_geometry *geometry,
 				     int show_progress, int write_bitmaps)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
+	struct packed_git *largest = get_largest_active_pack(geometry);
 	FILE *in;
 	int ret;
 
@@ -488,6 +509,10 @@ static int write_midx_included_packs(struct string_list *include,
 	if (write_bitmaps)
 		strvec_push(&cmd.args, "--bitmap");
 
+	if (largest)
+		strvec_pushf(&cmd.args, "--preferred-pack=%s",
+			     pack_basename(largest));
+
 	ret = start_command(&cmd);
 	if (ret)
 		return ret;
@@ -773,7 +798,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
index 5ccaa440e0..54360c9878 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -180,4 +180,26 @@ test_expect_success '--geometric ignores kept packs' '
 	)
 '
 
+test_expect_success '--geometric chooses largest MIDX preferred pack' '
+	git init geometric &&
+	test_when_finished "rm -fr geometric" &&
+	(
+		cd geometric &&
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

