Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688D4C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 16:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E1AF20786
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 16:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="rWHkgmWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgHYQEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgHYQEm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 12:04:42 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F9AC061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 09:04:42 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id k20so5764436qtq.11
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 09:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h4gSGXt6cvZR8feRVQV9O3+vgKzo//dCQb8fIe+AvyQ=;
        b=rWHkgmWDY0O89Qu/vYlDkeohH9X9g/zcRfiSwMjPm1UxMHNPX2cYIlrCImkGfhLCef
         /M08rUXWM8dJMRaDkl6ZZ46iwA8KbWTNA5sKaCV7GSa8j9TZenNmUq7l3LP+BwSikby2
         D5jA4HBABmSONlFQi+js814pI9LELw/By1CoPPuCQq5bp+paL4qZg7qDGHPUnkOPWcqY
         x9gpRHQrQMxsABDVOBybcX66V4IPVYtuVIcYIhdYFE8UGtgSQWIGGo+kc2jkplR8Dpan
         +8GnR8mMhGFfS/26weFeudKeZ+d7uX1A+yv0d1s12fxlGIOkPSSOj8ifySpEUEHlzshn
         m5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h4gSGXt6cvZR8feRVQV9O3+vgKzo//dCQb8fIe+AvyQ=;
        b=qOoX+m3boRJlIO5ROH0Q904lwFuHNK/Ik03YwmhhgklrpwlRozPVM3wqC5Q01rT/fO
         3CFuBfeAXo6fUV+G1hrazbLJifc/ZllcwbpLp+at7cPaGUES9tG7uRzfQkZQiFsIe+mZ
         dtrQwSc2C9LEUPAyRCchUgVbYP+sUrhlGAkBHxYnpr5+gBYXl6OgwrtQJBy8urcD7n0v
         uF/TF+xQlD4o0JqKEMXivWW1Qw+HolYF0YKKgdvpWo79bJTfMCToKByxSs/BiZSzTKLI
         HTUbvfVFSKvd12GSs27zyeVZ8mfzWBlknxpjMa9F2B+twrTsMVsHjR3laXzvohAws7zt
         5dTg==
X-Gm-Message-State: AOAM530oL9XI5AhwGXPR6wiTcgPN499NdrhGchrAwy+38RoUGso0sY3z
        ruhzX9u4nQfC8KoBLycstnnUXgCxL6L1J306
X-Google-Smtp-Source: ABdhPJwbJ45tyCFk5N2oBLRT2fijjY4shCIZJ0J4pIgTRp0NOJjT2SFSj3ikodDrLLiZQSvsc9NNDw==
X-Received: by 2002:ac8:480c:: with SMTP id g12mr9869791qtq.257.1598371479238;
        Tue, 25 Aug 2020 09:04:39 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1558:8dc0:5209:36ba])
        by smtp.gmail.com with ESMTPSA id n85sm12108056qkn.80.2020.08.25.09.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 09:04:37 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:04:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, peff@peff.net, sluongng@gmail.com
Subject: [PATCH v2] builtin/repack.c: invalidate MIDX only when necessary
Message-ID: <87a3b7a5a2f091e2a23c163a7d86effbbbedfa3a.1598371475.git.me@ttaylorr.com>
References: <20200825144515.GB7671@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825144515.GB7671@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 525e18c04b (midx: clear midx on repack, 2018-07-12), 'git repack'
learned to remove a multi-pack-index file if it added or removed a pack
from the object store.

This mechanism is a little over-eager, since it is only necessary to
drop a MIDX if 'git repack' removes a pack that the MIDX references.
Adding a pack outside of the MIDX does not require invalidating the
MIDX, and likewise for removing a pack the MIDX does not know about.

Teach 'git repack' to check for this by loading the MIDX, and checking
whether the to-be-removed pack is known to the MIDX. This requires a
slightly odd alternation to a test in t5319, which is explained with a
comment. A new test is added to show that the MIDX is left alone when
both packs known to it are marked as .keep, but two packs unknown to it
are removed and combined into one new pack.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Range-diff against v1:
1:  ef9186a8df ! 1:  87a3b7a5a2 builtin/repack.c: invalidate MIDX only when necessary
    @@ Commit message
         Teach 'git repack' to check for this by loading the MIDX, and checking
         whether the to-be-removed pack is known to the MIDX. This requires a
         slightly odd alternation to a test in t5319, which is explained with a
    -    comment.
    +    comment. A new test is added to show that the MIDX is left alone when
    +    both packs known to it are marked as .keep, but two packs unknown to it
    +    are removed and combined into one new pack.
     
    +    Helped-by: Derrick Stolee <dstolee@microsoft.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## builtin/repack.c ##
    @@ t/t5319-multi-pack-index.sh: test_expect_success 'repack with the --no-progress
      	test_path_is_missing $objdir/pack/multi-pack-index
      '
      
    -+test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
    -+	git multi-pack-index write &&
    -+	cp $objdir/pack/multi-pack-index $objdir/pack/multi-pack-index.bak &&
    -+	test_when_finished "rm -f $objdir/pack/multi-pack-index.bak" &&
    -+
    -+	# Write a new pack that is unknown to the multi-pack-index.
    -+	git hash-object -w </dev/null >blob &&
    -+	git pack-objects $objdir/pack/pack <blob &&
    -+
    -+	GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
    -+	test_cmp_bin $objdir/pack/multi-pack-index \
    -+		$objdir/pack/multi-pack-index.bak
    ++test_expect_success 'repack preserves multi-pack-index when creating packs' '
    ++	git init preserve &&
    ++	test_when_finished "rm -fr preserve" &&
    ++	(
    ++		cd preserve &&
    ++		packdir=.git/objects/pack &&
    ++		midx=$packdir/multi-pack-index &&
    ++
    ++		test_commit 1 &&
    ++		pack1=$(git pack-objects --all $packdir/pack) &&
    ++		touch $packdir/pack-$pack1.keep &&
    ++		test_commit 2 &&
    ++		pack2=$(git pack-objects --revs $packdir/pack) &&
    ++		touch $packdir/pack-$pack2.keep &&
    ++
    ++		git multi-pack-index write &&
    ++		cp $midx $midx.bak &&
    ++
    ++		cat >pack-input <<-EOF &&
    ++		HEAD
    ++		^HEAD~1
    ++		EOF
    ++		test_commit 3 &&
    ++		pack3=$(git pack-objects --revs $packdir/pack <pack-input) &&
    ++		test_commit 4 &&
    ++		pack4=$(git pack-objects --revs $packdir/pack <pack-input) &&
    ++
    ++		GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -ad &&
    ++		ls -la $packdir &&
    ++		test_path_is_file $packdir/pack-$pack1.pack &&
    ++		test_path_is_file $packdir/pack-$pack2.pack &&
    ++		test_path_is_missing $packdir/pack-$pack3.pack &&
    ++		test_path_is_missing $packdir/pack-$pack4.pack &&
    ++		test_cmp_bin $midx.bak $midx
    ++	)
     +'
     +
      compare_results_with_midx "after repack"

 builtin/repack.c            | 12 +++++-----
 t/t5319-multi-pack-index.sh | 44 +++++++++++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 04c5ceaf7e..98fac03946 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -133,7 +133,11 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
 	struct strbuf buf = STRBUF_INIT;
-	strbuf_addf(&buf, "%s/%s.pack", dir_name, base_name);
+	struct multi_pack_index *m = get_multi_pack_index(the_repository);
+	strbuf_addf(&buf, "%s.pack", base_name);
+	if (m && midx_contains_pack(m, buf.buf))
+		clear_midx_file(the_repository);
+	strbuf_insertf(&buf, 0, "%s/", dir_name);
 	unlink_pack_path(buf.buf, 1);
 	strbuf_release(&buf);
 }
@@ -286,7 +290,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int keep_unreachable = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	int no_update_server_info = 0;
-	int midx_cleared = 0;
 	struct pack_objects_args po_args = {NULL};
 
 	struct option builtin_repack_options[] = {
@@ -439,11 +442,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
 			char *fname, *fname_old;
 
-			if (!midx_cleared) {
-				clear_midx_file(the_repository);
-				midx_cleared = 1;
-			}
-
 			fname = mkpathdup("%s/pack-%s%s", packdir,
 						item->string, exts[ext].name);
 			if (!file_exists(fname)) {
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 43b1b5b2af..f340b376bc 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -382,12 +382,52 @@ test_expect_success 'repack with the --no-progress option' '
 	test_line_count = 0 err
 '
 
-test_expect_success 'repack removes multi-pack-index' '
+test_expect_success 'repack removes multi-pack-index when deleting packs' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
-	GIT_TEST_MULTI_PACK_INDEX=0 git repack -adf &&
+	# Set GIT_TEST_MULTI_PACK_INDEX to 0 to avoid writing a new
+	# multi-pack-index after repacking, but set "core.multiPackIndex" to
+	# true so that "git repack" can read the existing MIDX.
+	GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -adf &&
 	test_path_is_missing $objdir/pack/multi-pack-index
 '
 
+test_expect_success 'repack preserves multi-pack-index when creating packs' '
+	git init preserve &&
+	test_when_finished "rm -fr preserve" &&
+	(
+		cd preserve &&
+		packdir=.git/objects/pack &&
+		midx=$packdir/multi-pack-index &&
+
+		test_commit 1 &&
+		pack1=$(git pack-objects --all $packdir/pack) &&
+		touch $packdir/pack-$pack1.keep &&
+		test_commit 2 &&
+		pack2=$(git pack-objects --revs $packdir/pack) &&
+		touch $packdir/pack-$pack2.keep &&
+
+		git multi-pack-index write &&
+		cp $midx $midx.bak &&
+
+		cat >pack-input <<-EOF &&
+		HEAD
+		^HEAD~1
+		EOF
+		test_commit 3 &&
+		pack3=$(git pack-objects --revs $packdir/pack <pack-input) &&
+		test_commit 4 &&
+		pack4=$(git pack-objects --revs $packdir/pack <pack-input) &&
+
+		GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -ad &&
+		ls -la $packdir &&
+		test_path_is_file $packdir/pack-$pack1.pack &&
+		test_path_is_file $packdir/pack-$pack2.pack &&
+		test_path_is_missing $packdir/pack-$pack3.pack &&
+		test_path_is_missing $packdir/pack-$pack4.pack &&
+		test_cmp_bin $midx.bak $midx
+	)
+'
+
 compare_results_with_midx "after repack"
 
 test_expect_success 'multi-pack-index and pack-bitmap' '
-- 
2.28.0.338.g87a3b7a5a2
