Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A2DC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2203D60F9E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241104AbhHaUwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhHaUwb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:52:31 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EAFC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:51:36 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id j18so761718ioj.8
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZKziShohOtJjnY0ZP9eZlP1ifnSPSIa4deb0UooUtew=;
        b=mR6hDMtOl9t1sJ5XAWiovX4gBzNrmm4m8u3K0jzu/I1ddTllB7azplCHPqeW5/tCG5
         CGTuoTp1JUWM5MYDfyIc3y9RvQvaf5IUZdZaLmdaOVWthMUhIhCBUL+thMpH/wBT7u/z
         vkSgVeGK0GK+Fi753Whv3a5MRgfVo1LIch3GjqHC8GrNvzi85MHkh4psZGzCZR7rIi/L
         hitGfVQSD+LboqczD8bQkdziamixjvHxcYAHMSrU/0dsEOfzXYHdIIgt/gNgZxWWn8Qg
         KO+kk4rp9/Kmeluc5xNCKgFqYGQEr3pXQjc8Rsi1FVm5ogeTOJSD0JNutB0r+7Np/RRT
         uo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZKziShohOtJjnY0ZP9eZlP1ifnSPSIa4deb0UooUtew=;
        b=geES0dD+E7xDOXRjm4Xp1oi1Hc/BTljss16NIa7DCI4kZ5/ipH8RRMR02GoaCKMyut
         CxJTnXrd8ABCIm1WdlwBK6Wtxo/aux5DH2SEQlFaH4/3BS3KhWr9A9fudFXJI7w0QcQv
         q/DookjFEMDmyeS/XmJY0HPmZZO8eDV3CxKXKo8e2WP3wGNbkmQyxJTJEJPBtDAAv7TF
         mcPuD2qK6sOMuIrQMaa1KejHM6zWc/GGEhiWnP+/sxT/HIUK0I3K4Kqeww2xR3brk3xI
         sV0BZoI65E6e7W7SlCJTRLiuE5vlBqN8UMkevYoPTyNPndpzYdE/3jynNVGJJNIuo/kE
         KuSw==
X-Gm-Message-State: AOAM532hC3gOX9jfV4bcjjjKX5t/aVRuqKReMqUCg7rNN3f3HXn0iZdP
        /PRxpuyD3mmkSuzvqZ5lnanm40Cy7hS7ZJap
X-Google-Smtp-Source: ABdhPJxojkVuv2zrQJkj6MX8SKJu82qj6BkoRNUB3R8OwrN/qC4NIyEF1a03AxbFO0uR0btI6JcwYA==
X-Received: by 2002:a5e:df0d:: with SMTP id f13mr24822213ioq.108.1630443095460;
        Tue, 31 Aug 2021 13:51:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s7sm9667095ioc.42.2021.08.31.13.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:51:34 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:51:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 00/27] multi-pack reachability bitmaps
Message-ID: <cover.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is another version of the multi-pack reachability bitmaps series. It is
virtually unchanged since last time.

The changes that did occur is that I integrated Johannes' patch from [1] to fix
cleaning up MIDX .rev and .bitmap files when using `--object-dir`. That inspired
a lengthy discussion [2] about `--object-dir`, alternates, object-format and
running the MIDX builtin outside of a Git repository.

This series resolves that discussion by leaving everything as-is, and only
changing the following:

  - `git multi-pack-index` will not run when outside of a Git
    repository.

  - The `--object-dir` argument will only recognize object directories
    belonging to an alternate of the current repository.

  - Using `--object-dir` to point to a repository which uses a
    different hash than the repository in the current working directory
    will continue to not work (as was the case before this series).

And because this incorporates [1], we will also not accidentally clean `.rev`
files from the wrong object directory.

I think that this version is ready-to-go, and that we can turn our attention to
squashing some of these cross-alternate buglets, and integrating MIDX bitmaps
with `git repack`.

[1]: https://lore.kernel.org/git/20210823171011.80588-1-johannes@sipsolutions.net/
[2]: https://lore.kernel.org/git/YSVsHo2wLhnraBnv@nand.local/

Jeff King (2):
  t0410: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
  t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP

Taylor Blau (25):
  pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps
  pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
  pack-bitmap-write.c: free existing bitmaps
  Documentation: describe MIDX-based bitmaps
  midx: disallow running outside of a repository
  midx: fix `*.rev` cleanups with `--object-dir`
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

 Documentation/git-multi-pack-index.txt       |  20 +-
 Documentation/technical/bitmap-format.txt    |  71 ++-
 Documentation/technical/multi-pack-index.txt |  10 +-
 builtin/multi-pack-index.c                   |   2 +
 builtin/pack-objects.c                       |   8 +-
 builtin/repack.c                             |  12 +-
 ci/run-build-and-tests.sh                    |   1 +
 git.c                                        |   2 +-
 midx.c                                       | 328 ++++++++++--
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
 t/t5319-multi-pack-index.sh                  |  53 +-
 t/t5326-multi-pack-bitmaps.sh                | 286 +++++++++++
 t/t7700-repack.sh                            |  18 +-
 25 files changed, 1644 insertions(+), 441 deletions(-)
 create mode 100644 t/perf/lib-bitmap.sh
 create mode 100755 t/perf/p5326-multi-pack-bitmaps.sh
 create mode 100755 t/t5326-multi-pack-bitmaps.sh

Range-diff against v4:
 1:  92dc0bbc0d =  1:  7815d9929d pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps
 2:  979276bc74 =  2:  629171115a pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
 3:  8f00493955 =  3:  d469c1d8f6 pack-bitmap-write.c: free existing bitmaps
 4:  bc7db926d8 =  4:  158ff797c4 Documentation: describe MIDX-based bitmaps
 -:  ---------- >  5:  5f24be8985 midx: disallow running outside of a repository
 -:  ---------- >  6:  0aacaa9283 midx: fix `*.rev` cleanups with `--object-dir`
 5:  771741844b !  7:  d30e6fe9a5 midx: clear auxiliary .rev after replacing the MIDX
    @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
      
      	if (flags & MIDX_WRITE_REV_INDEX)
      		write_midx_reverse_index(midx_name, midx_hash, &ctx);
    --	clear_midx_files_ext(the_repository, ".rev", midx_hash);
    +-	clear_midx_files_ext(object_dir, ".rev", midx_hash);
      
      	commit_lock_file(&lk);
      
    -+	clear_midx_files_ext(the_repository, ".rev", midx_hash);
    ++	clear_midx_files_ext(object_dir, ".rev", midx_hash);
     +
      cleanup:
      	for (i = 0; i < ctx.nr; i++) {
 6:  dab5dbf228 =  8:  db2a24a8ae midx: reject empty `--preferred-pack`'s
 7:  31f4517de0 =  9:  059c583e34 midx: infer preferred pack when not given one
 8:  aa3bd96d9b = 10:  6f5ca446f3 midx: close linked MIDXs, avoid leaking memory
 9:  c9fea31fa8 ! 11:  4656608f73 midx: avoid opening multiple MIDXs when writing
    @@ Commit message
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    + ## Documentation/git-multi-pack-index.txt ##
    +@@ Documentation/git-multi-pack-index.txt: OPTIONS
    + 	Use given directory for the location of Git objects. We check
    + 	`<dir>/packs/multi-pack-index` for the current MIDX file, and
    + 	`<dir>/packs` for the pack-files to index.
    +++
    ++`<dir>` must be an alternate of the current repository.
    + 
    + --[no-]progress::
    + 	Turn progress on/off explicitly. If neither is specified, progress is
    +
      ## midx.c ##
     @@ midx.c: static int midx_checksum_valid(struct multi_pack_index *m)
      	return hashfile_checksum_valid(m->data, m->data_len);
10:  ee72fb7e38 = 12:  4c793df9d1 pack-bitmap.c: introduce 'bitmap_num_objects()'
11:  ede0bf1ce1 = 13:  9f165037ce pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
12:  df6844def0 = 14:  ba5fd71fb3 pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
13:  4e06f051a7 = 15:  06db8dbbc1 pack-bitmap.c: avoid redundant calls to try_partial_reuse
14:  a0d73eb3d3 = 16:  61798853b6 pack-bitmap: read multi-pack bitmaps
15:  9d83ad77ab ! 17:  4968229663 pack-bitmap: write multi-pack bitmaps
    @@ midx.c: static int write_midx_internal(const char *object_dir,
     +			 * corresponding bitmap (or one wasn't requested).
     +			 */
     +			if (!want_bitmap)
    -+				clear_midx_files_ext(the_repository, ".bitmap",
    ++				clear_midx_files_ext(object_dir, ".bitmap",
     +						     NULL);
     +			goto cleanup;
     +		}
    @@ midx.c: static int write_midx_internal(const char *object_dir,
     +		}
     +	}
     +
    -+	close_object_store(the_repository->objects);
    ++	if (ctx.m)
    ++		close_object_store(the_repository->objects);
      
      	commit_lock_file(&lk);
      
    -+	clear_midx_files_ext(the_repository, ".bitmap", midx_hash);
    - 	clear_midx_files_ext(the_repository, ".rev", midx_hash);
    ++	clear_midx_files_ext(object_dir, ".bitmap", midx_hash);
    + 	clear_midx_files_ext(object_dir, ".rev", midx_hash);
      
      cleanup:
     @@ midx.c: static int write_midx_internal(const char *object_dir,
    @@ midx.c: void clear_midx_file(struct repository *r)
      	if (remove_path(midx))
      		die(_("failed to clear multi-pack-index at %s"), midx);
      
    -+	clear_midx_files_ext(r, ".bitmap", NULL);
    - 	clear_midx_files_ext(r, ".rev", NULL);
    ++	clear_midx_files_ext(r->objects->odb->path, ".bitmap", NULL);
    + 	clear_midx_files_ext(r->objects->odb->path, ".rev", NULL);
      
      	free(midx);
     
16:  a92af89884 = 18:  5d60b07e2e t5310: move some tests to lib-bitmap.sh
17:  d47aa4a919 = 19:  1a9c3538db t/helper/test-read-midx.c: add --checksum mode
18:  9d9d9f28a6 = 20:  8895114ace t5326: test multi-pack bitmap behavior
19:  3e0da7e5ed = 21:  94b1317e0c t0410: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
20:  4e0d49a2dd = 22:  a4f4d90bba t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
21:  47eba8ecf9 = 23:  92a6370e77 t5319: don't write MIDX bitmaps in t5319
22:  3d78afa2ad = 24:  c49dc46fb2 t7700: update to work with MIDX bitmap test knob
23:  c2f94e033d = 25:  44a4800756 midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
24:  6b03016c99 = 26:  bf0981b606 p5310: extract full and partial bitmap tests
25:  d98faa4c2c = 27:  6888fe01aa p5326: perf tests for MIDX bitmaps
-- 
2.33.0.96.g73915697e6
