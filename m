Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF8EC432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18ADE61212
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhHXQQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhHXQQg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:16:36 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0DFC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:15:50 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y18so11449184ioc.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UAdtzQXF7Q8J1bFHRYGpUTLZyj0PoicmXepoxR9UH2E=;
        b=bvnoYSA7m1T2MJA1rbUDpVYa+InLodjZSCTLx2ER2NOM5NyigeiVGPMX3ZmPvpctBv
         oLtmSrXrFF0mI7WHM+X2R/YZelhzcvpnSan6qEm2IIZ32ncv/Hog4n8D7CshO71pRoVp
         LSoysF7mgpOFd6YoMdty898jmKnYQwLfUI3tb3DWCAjY+2lCryKxXwFuCxKn77E19cQZ
         fcF+IQ6o2FNnUZ6+qdX4EJ4lpVlGNJbubG7VuqTLXoK5f7EYhvd/KYRGhLuaIBOGhDDV
         tSn8nZPsLR5/kxs52cqnHKiO99O806yRyJY8YIlUzX9woNa96CBFG9zajofQ/gNhRrdE
         QfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UAdtzQXF7Q8J1bFHRYGpUTLZyj0PoicmXepoxR9UH2E=;
        b=OgUYNkfx5ab4fj0GOOmPDpLW5tRQ1eBddEToddhXixqnUxZOi3g64mcno6tUDFsWs2
         AnwVhF0cmTlmgWL23VY3+rMnPljmgWfp8wOhZvBvQZbsnQp8IO+6tEO2bznYY/IExrxP
         x7RipQ2YujjTMRv+esSWEpbxgfK9lfU6q8N7KJwqaBhm4JaKhVCq1zctwgvAmvRDomet
         nqn0ADe9nZiddO14988aFTV/m7kJZeGK8ihATsJJG7C4W2fbnl+Z2bUiG+seTw++OABR
         xyJzfW/VBeq3Ynb+kL//2KNySatXzGYPwmqMtJqfxuPdnWPcoEkfLw8s5vEf+7GCTNC4
         nP7w==
X-Gm-Message-State: AOAM533jXso1iLU59kcnsju380lagOFGEaTj9mKleEuiD0rfQdtm1k0F
        k7LHyvC+FsQ4ta1H/naXDDiWSc1ojEWq+5GU
X-Google-Smtp-Source: ABdhPJyLKNBX7gSIdIcsV5HRKEcvp9kpk1OFvLUhjmIVMNCRJmf3pbi5PB0zHpw5ZgxEpcRMhU7BaA==
X-Received: by 2002:a5d:990c:: with SMTP id x12mr12270916iol.122.1629821749591;
        Tue, 24 Aug 2021 09:15:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f6sm10220465ilr.77.2021.08.24.09.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:15:48 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:15:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 00/25] multi-pack reachability bitmaps
Message-ID: <cover.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is what I anticipate to be a final reroll of my series to implement
multi-pack reachability bitmaps, based on review feedback from Peff.

Most of the change since last time are cosmetic test clean-ups. The previous
reroll of this series incorporated feedback from a discussion[1] surrounding the
`multi-pack-index` builtin's `--object-dir` argument. This reroll fixes a bug
discussed here[2] where we should have been calling close_object_store() but
weren't; the remainder of that bug has already been dealt with.

Thanks everybody for dealing with multiple versions of this quite lengthy and
complicated series. Hopefully we are done in this round and can move on to
integrating this with `git repack`, which will complete the MIDX bitmaps topic.

[1]: https://lore.kernel.org/git/YQMFIljXl7sAAA%2FL@nand.local/
[2]: https://lore.kernel.org/git/YRWBZJDCVyUOhk2F@coredump.intra.peff.net/

Jeff King (2):
  t0410: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
  t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP

Taylor Blau (23):
  pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps
  pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
  pack-bitmap-write.c: free existing bitmaps
  Documentation: describe MIDX-based bitmaps
  midx: clear auxiliary .rev after replacing the MIDX
  midx: reject empty `--preferred-pack`'s
  midx: infer preferred pack when not given one
  midx: close linked MIDXs, avoid leaking memory
  midx: avoid opening multiple MIDXs when writing
  pack-bitmap.c: introduce 'bitmap_num_objects()'
  pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
  pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
  pack-bitmap.c: avoid redundant calls to try_partial_reuse
  pack-bitmap: read multi-pack bitmaps
  pack-bitmap: write multi-pack bitmaps
  t5310: move some tests to lib-bitmap.sh
  t/helper/test-read-midx.c: add --checksum mode
  t5326: test multi-pack bitmap behavior
  t5319: don't write MIDX bitmaps in t5319
  t7700: update to work with MIDX bitmap test knob
  midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
  p5310: extract full and partial bitmap tests
  p5326: perf tests for MIDX bitmaps

 Documentation/git-multi-pack-index.txt       |  18 +-
 Documentation/technical/bitmap-format.txt    |  71 ++-
 Documentation/technical/multi-pack-index.txt |  10 +-
 builtin/multi-pack-index.c                   |   2 +
 builtin/pack-objects.c                       |   8 +-
 builtin/repack.c                             |  12 +-
 ci/run-build-and-tests.sh                    |   1 +
 midx.c                                       | 319 +++++++++++-
 midx.h                                       |   5 +
 pack-bitmap-write.c                          |  79 ++-
 pack-bitmap.c                                | 499 ++++++++++++++++---
 pack-bitmap.h                                |   9 +-
 packfile.c                                   |   2 +-
 t/README                                     |   4 +
 t/helper/test-read-midx.c                    |  16 +-
 t/lib-bitmap.sh                              | 240 +++++++++
 t/perf/lib-bitmap.sh                         |  69 +++
 t/perf/p5310-pack-bitmaps.sh                 |  65 +--
 t/perf/p5326-multi-pack-bitmaps.sh           |  43 ++
 t/t0410-partial-clone.sh                     |  12 +-
 t/t5310-pack-bitmaps.sh                      | 231 +--------
 t/t5319-multi-pack-index.sh                  |  20 +-
 t/t5326-multi-pack-bitmaps.sh                | 286 +++++++++++
 t/t7700-repack.sh                            |  18 +-
 24 files changed, 1603 insertions(+), 436 deletions(-)
 create mode 100644 t/perf/lib-bitmap.sh
 create mode 100755 t/perf/p5326-multi-pack-bitmaps.sh
 create mode 100755 t/t5326-multi-pack-bitmaps.sh

Range-diff against v3:
 1:  fa4cbed48e =  1:  92dc0bbc0d pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps
 2:  2b15c1fc5c =  2:  979276bc74 pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
 3:  2ad513a230 =  3:  8f00493955 pack-bitmap-write.c: free existing bitmaps
 4:  8da5de7c24 =  4:  bc7db926d8 Documentation: describe MIDX-based bitmaps
 5:  49297f57ed =  5:  771741844b midx: clear auxiliary .rev after replacing the MIDX
 6:  c5513f2a75 =  6:  dab5dbf228 midx: reject empty `--preferred-pack`'s
 7:  53ef0a6d67 =  7:  31f4517de0 midx: infer preferred pack when not given one
 8:  114773d9cd =  8:  aa3bd96d9b midx: close linked MIDXs, avoid leaking memory
 9:  40cff5beb5 !  9:  c9fea31fa8 midx: avoid opening multiple MIDXs when writing
    @@ Commit message
         one and should invalidate the object store's memory of any MIDX that
         might have existed beforehand.
     
    +    Note that this now forbids passing object directories that don't belong
    +    to alternate repositories over `--object-dir`, since before we would
    +    have happily opened a MIDX in any directory, but now restrict ourselves
    +    to only those reachable by `r->objects->multi_pack_index` (and alternate
    +    MIDXs that we can see by walking the `next` pointer).
    +
    +    As far as I can tell, supporting arbitrary directories with
    +    `--object-dir` was a historical accident, since even the documentation
    +    says `<alt>` when referring to the value passed to this option.
    +
    +    A future patch could clean this up and provide a warning() when a
    +    non-alternate directory was given, since we'll still write a new MIDX
    +    there, we just won't reuse any MIDX that might happen to already exist
    +    in that directory.
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## midx.c ##
    @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
     +			break;
     +		}
     +	}
    -+	if (!ctx.m)
    -+		ctx.m = get_local_multi_pack_index(the_repository);
      
      	if (ctx.m && !midx_checksum_valid(ctx.m)) {
      		warning(_("ignoring existing multi-pack-index; checksum mismatch"));
    +@@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
    + 	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
    + 
    + 	if (ctx.m)
    +-		close_midx(ctx.m);
    ++		close_object_store(the_repository->objects);
    + 
    + 	if (ctx.nr - dropped_packs == 0) {
    + 		error(_("no pack files to index."));
     @@ midx.c: int write_midx_file(const char *object_dir,
      		    const char *preferred_pack_name,
      		    unsigned flags)
10:  ca7f726abf ! 10:  ee72fb7e38 pack-bitmap.c: introduce 'bitmap_num_objects()'
    @@ pack-bitmap.c: static void show_extended_objects(struct bitmap_index *bitmap_git
      
      		obj = eindex->objects[i];
     @@ pack-bitmap.c: static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
    - 	 * individually.
    + 	 * them individually.
      	 */
      	for (i = 0; i < eindex->count; i++) {
     -		uint32_t pos = i + bitmap_git->pack->num_objects;
11:  67e6897a34 = 11:  ede0bf1ce1 pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
12:  743a1a138e = 12:  df6844def0 pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
13:  a3b641b3e6 = 13:  4e06f051a7 pack-bitmap.c: avoid redundant calls to try_partial_reuse
14:  141ff83275 = 14:  a0d73eb3d3 pack-bitmap: read multi-pack bitmaps
15:  54600b5814 ! 15:  9d83ad77ab pack-bitmap: write multi-pack bitmaps
    @@ midx.c: static int write_midx_internal(const char *object_dir,
      	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
      
     -	if (ctx.m)
    --		close_midx(ctx.m);
    +-		close_object_store(the_repository->objects);
     -
      	if (ctx.nr - dropped_packs == 0) {
      		error(_("no pack files to index."));
    @@ midx.c: static int write_midx_internal(const char *object_dir,
     +		}
     +	}
     +
    -+	close_midx(ctx.m);
    ++	close_object_store(the_repository->objects);
      
      	commit_lock_file(&lk);
      
16:  168b7b0976 ! 16:  a92af89884 t5310: move some tests to lib-bitmap.sh
    @@ Commit message
     
      ## t/lib-bitmap.sh ##
     @@
    -+# Helpers for scripts testing bitamp functionality; see t5310 for
    ++# Helpers for scripts testing bitmap functionality; see t5310 for
     +# example usage.
     +
      # Compare a file containing rev-list bitmap traversal output to its non-bitmap
17:  60ec8b3466 ! 17:  d47aa4a919 t/helper/test-read-midx.c: add --checksum mode
    @@ t/lib-bitmap.sh: have_delta () {
      }
     +
     +midx_checksum () {
    -+	test-tool read-midx --checksum "${1:-.git/objects}"
    ++	test-tool read-midx --checksum "$1"
     +}
18:  3258ccfc1c ! 18:  9d9d9f28a6 t5326: test multi-pack bitmap behavior
    @@ t/t5326-multi-pack-bitmaps.sh (new)
     +	git repack -ad &&
     +	git multi-pack-index write --bitmap &&
     +	test_path_is_file $midx &&
    -+	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
    ++	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
    ++	test_path_is_file $midx-$(midx_checksum $objdir).rev
     +'
     +
     +basic_bitmap_tests
    @@ t/t5326-multi-pack-bitmaps.sh (new)
     +	for i in $(test_seq 1 16)
     +	do
     +		test_commit "$i" &&
    -+		git repack -d
    ++		git repack -d || return 1
     +	done &&
     +
     +	git checkout -b other2 HEAD~8 &&
     +	for i in $(test_seq 1 8)
     +	do
     +		test_commit "side-$i" &&
    -+		git repack -d
    ++		git repack -d || return 1
     +	done &&
     +	git checkout second
     +'
    @@ t/t5326-multi-pack-bitmaps.sh (new)
     +	test_line_count = 25 packs &&
     +
     +	test_path_is_file $midx &&
    -+	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
    ++	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
    ++	test_path_is_file $midx-$(midx_checksum $objdir).rev
     +'
     +
     +basic_bitmap_tests
    @@ t/t5326-multi-pack-bitmaps.sh (new)
     +	git multi-pack-index write --bitmap &&
     +
     +	test_commit respect--no-bitmap &&
    -+	GIT_TEST_MULTI_PACK_INDEX=0 git repack -d &&
    ++	git repack -d &&
     +
     +	test_path_is_file $midx &&
     +	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
    ++	test_path_is_file $midx-$(midx_checksum $objdir).rev &&
     +
     +	git multi-pack-index write --no-bitmap &&
     +
     +	test_path_is_file $midx &&
    -+	test_path_is_missing $midx-$(midx_checksum $objdir).bitmap
    ++	test_path_is_missing $midx-$(midx_checksum $objdir).bitmap &&
    ++	test_path_is_missing $midx-$(midx_checksum $objdir).rev
     +'
     +
     +test_expect_success 'setup midx with base from later pack' '
    @@ t/t5326-multi-pack-bitmaps.sh (new)
     +			git config core.multiPackIndex true &&
     +			if test "MIDX" = "$from"
     +			then
    -+				GIT_TEST_MULTI_PACK_INDEX=0 git repack -Ad &&
    ++				git repack -Ad &&
     +				git multi-pack-index write --bitmap
     +			else
    -+				GIT_TEST_MULTI_PACK_INDEX=0 git repack -Adb
    ++				git repack -Adb
     +			fi
     +		)
     +	'
    @@ t/t5326-multi-pack-bitmaps.sh (new)
     +
     +			if test "MIDX" = "$to"
     +			then
    -+				GIT_TEST_MULTI_PACK_INDEX=0 git repack -d &&
    ++				git repack -d &&
     +				git multi-pack-index write --bitmap
     +			else
    -+				GIT_TEST_MULTI_PACK_INDEX=0 git repack -Adb
    ++				git repack -Adb
     +			fi
     +		)
     +	'
    @@ t/t5326-multi-pack-bitmaps.sh (new)
     +	test_commit loose &&
     +	git multi-pack-index write --bitmap 2>err &&
     +	test_path_is_file $midx &&
    -+	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
    ++	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
    ++	test_path_is_file $midx-$(midx_checksum $objdir).rev
     +'
     +
     +basic_bitmap_tests HEAD~
    @@ t/t5326-multi-pack-bitmaps.sh (new)
     +
     +		# Write a MIDX and bitmap; remove the MIDX but leave the bitmap.
     +		stale_bitmap=$midx-$(midx_checksum $objdir).bitmap &&
    ++		stale_rev=$midx-$(midx_checksum $objdir).rev &&
     +		rm $midx &&
     +
     +		# Then write a new MIDX.
    @@ t/t5326-multi-pack-bitmaps.sh (new)
     +
     +		test_path_is_file $midx &&
     +		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
    -+		test_path_is_missing $stale_bitmap
    ++		test_path_is_file $midx-$(midx_checksum $objdir).rev &&
    ++		test_path_is_missing $stale_bitmap &&
    ++		test_path_is_missing $stale_rev
     +	)
     +'
     +
    @@ t/t5326-multi-pack-bitmaps.sh (new)
     +		git multi-pack-index write --bitmap &&
     +		test_path_is_file $midx &&
     +		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
    ++		test_path_is_file $midx-$(midx_checksum $objdir).rev &&
     +
     +		test-tool bitmap list-commits | sort >bitmaps &&
     +		comm -13 bitmaps commits >before &&
19:  47c7e6bb9b = 19:  3e0da7e5ed t0410: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
20:  6a708858b1 = 20:  4e0d49a2dd t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
21:  1eaa744b24 = 21:  47eba8ecf9 t5319: don't write MIDX bitmaps in t5319
22:  a4a899e31f = 22:  3d78afa2ad t7700: update to work with MIDX bitmap test knob
23:  50865e52a3 = 23:  c2f94e033d midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
24:  0f1fd6e7d4 = 24:  6b03016c99 p5310: extract full and partial bitmap tests
25:  82e8133bf4 = 25:  d98faa4c2c p5326: perf tests for MIDX bitmaps
-- 
2.31.1.163.ga65ce7f831
