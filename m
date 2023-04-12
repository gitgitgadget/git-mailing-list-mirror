Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0320BC77B6C
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 22:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjDLWUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 18:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDLWUR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 18:20:17 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7657249FE
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:20:16 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id h198so19979728ybg.12
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681338015; x=1683930015;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hGMxOlGz8tK52BpZL7jEMPrlpZsrxYHizYGrDkpl9b4=;
        b=vnhEJxyCCNf8oQVrzVoLwFnp5lp72KPRLJVZa2m8COyu6WLqdWCuZB2Nn8TmNVBv79
         4csrQR8TOaoQ0mOJ2ZRiGfloDkHoF0nTVBIIpGVcwAIQTHY6i80wRU2ZchwXNHQ2dFBa
         nAA6eSvWJeYqzkaJvO2xk12MAWGQJgKpSkEuBEy/PEv4EI8FlZH5F2TYBIO0QqqlC3V6
         UXruXRRfgXuM+80qcc0SBUFK+ectKRWLDOEWg410TyWYBbwtRijKPzc9sxFdLaQCBr+v
         r52FIOERFtWw/vB7vnCkqwT8M+ID1hPkTOKEOpT9WRnA9OXPl/auYTJCtNq59dN729ct
         rYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681338015; x=1683930015;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGMxOlGz8tK52BpZL7jEMPrlpZsrxYHizYGrDkpl9b4=;
        b=FwAPVexDUFzX9SbnlIZIcITGINV4XCSGU8cPfsI6l8L9Cw002O17qf3IYSHlLZHfBM
         aGUm2z7PNWzjQOsw4FzGJeIzRnQKTHQB+oJ+pvjyRNXPQGp+/bIMrusKjiN0pvwy/EDx
         U0Tbx0So9h6dAdZDU352DpHN1Egh8N2SAx7m3IQFOTpt8quPb9k/MlOv8gQal+l8P/JH
         2pNgTJbU2ghJzQvCEKUYDDGgjSGkiv/xPBY0JsbAWxPqHNAEieYUjiA7UrBItWh+OKmY
         7ReYG8/KEHSv4l9SsdIqH2ffh43ACIejNjRySV993peIAvf9Q6XZVYBG9Cx4hErT+rpo
         Io+A==
X-Gm-Message-State: AAQBX9cdNjd3gVGDkU83bil0gjkQMbb4gJBNLIWzE7/77g6kUbbmjx8F
        bkH5fPGttWkb1WukgRHyFbM5csC4epvFCwsUF7Mq2Q==
X-Google-Smtp-Source: AKy350Y1WmmzBcR/uB3fyWHtaqLzbgjreGifGXYAMVygWVpQSb2kul5Zbp9ta10/BKLJNTDSD5Lokg==
X-Received: by 2002:a25:aba9:0:b0:b65:89bd:3c85 with SMTP id v38-20020a25aba9000000b00b6589bd3c85mr134408ybi.4.1681338015439;
        Wed, 12 Apr 2023 15:20:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m15-20020a056902118f00b00b7767ca7482sm356087ybu.31.2023.04.12.15.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:20:15 -0700 (PDT)
Date:   Wed, 12 Apr 2023 18:20:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/7] pack-revindex: enable on-disk reverse indexes by
 default
Message-ID: <cover.1681338013.git.me@ttaylorr.com>
References: <cover.1681166596.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1681166596.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a (tiny) reroll of my series to enable pack reverse-indexes to
be written to disk by default instead of computed on-the-fly in memory.

The original cover letter[1] and commits herein have all of the gore-y
details. Not much has changed since last time, except:

  - squashing in a patch from Stolee to propagate a `struct repository
    *` a little further out from `load_pack_revindex()`

  - a tweak to the linux-TEST-vars CI job to continue running it with
    GIT_TEST_NO_WRITE_REV_INDEX

  - and an additional benchmark to demonstrate the performance of `git
    cat-file --batch-check='%(objectsize:disk)' --batch--all-objects
    --unordered` with and without on-disk reverse indexes

As always, a range-diff is included below for convenience. Thanks in
advance for taking (another) look!

[1]: https://lore.kernel.org/git/cover.1681166596.git.me@ttaylorr.com/

Taylor Blau (7):
  pack-write.c: plug a leak in stage_tmp_packfiles()
  t5325: mark as leak-free
  pack-revindex: make `load_pack_revindex` take a repository
  pack-revindex: introduce GIT_TEST_REV_INDEX_DIE_ON_DISK
  pack-revindex: introduce `pack.readReverseIndex`
  config: enable `pack.writeReverseIndex` by default
  t: invert `GIT_TEST_WRITE_REV_INDEX`

 Documentation/config/pack.txt     |  8 +++++++-
 builtin/index-pack.c              |  5 +++--
 builtin/pack-objects.c            |  5 +++--
 ci/run-build-and-tests.sh         |  2 +-
 pack-bitmap.c                     | 23 +++++++++++++----------
 pack-revindex.c                   | 12 +++++++++---
 pack-revindex.h                   |  6 ++++--
 pack-write.c                      |  2 ++
 packfile.c                        |  2 +-
 repo-settings.c                   |  1 +
 repository.h                      |  1 +
 t/README                          |  2 +-
 t/perf/p5312-pack-bitmaps-revs.sh |  3 +--
 t/t5325-reverse-index.sh          | 16 +++++++++++++++-
 14 files changed, 62 insertions(+), 26 deletions(-)

Range-diff against v1:
-:  ----------- > 1:  18be29c3988 pack-write.c: plug a leak in stage_tmp_packfiles()
-:  ----------- > 2:  affb5e2574b t5325: mark as leak-free
1:  be4faf11011 ! 3:  687a9a58924 pack-revindex: make `load_pack_revindex` take a repository
    @@ Commit message
         to `load_pack_revindex`, and update all callers to pass the correct
         instance (in all cases, `the_repository`).
     
    -    Signed-off-by: Taylor Blauy <me@ttaylorr.com>
    +    In certain instances, a new function-local variable is introduced to
    +    take the place of a `struct repository *` argument to the function
    +    itself to avoid propagating the new parameter even further throughout
    +    the tree.
    +
    +    Co-authored-by: Derrick Stolee <derrickstolee@github.com>
    +    Signed-off-by: Derrick Stolee <derrickstolee@github.com>
    +    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## pack-bitmap.c ##
    +@@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
    + 	return 0;
    + }
    + 
    +-static int load_reverse_index(struct bitmap_index *bitmap_git)
    ++static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_git)
    + {
    + 	if (bitmap_is_midx(bitmap_git)) {
    + 		uint32_t i;
     @@ pack-bitmap.c: static int load_reverse_index(struct bitmap_index *bitmap_git)
      		 * since we will need to make use of them in pack-objects.
      		 */
      		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
     -			ret = load_pack_revindex(bitmap_git->midx->packs[i]);
    -+			ret = load_pack_revindex(the_repository,
    -+						 bitmap_git->midx->packs[i]);
    ++			ret = load_pack_revindex(r, bitmap_git->midx->packs[i]);
      			if (ret)
      				return ret;
      		}
      		return 0;
      	}
     -	return load_pack_revindex(bitmap_git->pack);
    -+	return load_pack_revindex(the_repository, bitmap_git->pack);
    ++	return load_pack_revindex(r, bitmap_git->pack);
      }
      
    - static int load_bitmap(struct bitmap_index *bitmap_git)
    +-static int load_bitmap(struct bitmap_index *bitmap_git)
    ++static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
    + {
    + 	assert(bitmap_git->map);
    + 
    + 	bitmap_git->bitmaps = kh_init_oid_map();
    + 	bitmap_git->ext_index.positions = kh_init_oid_pos();
    + 
    +-	if (load_reverse_index(bitmap_git))
    ++	if (load_reverse_index(r, bitmap_git))
    + 		goto failed;
    + 
    + 	if (!(bitmap_git->commits = read_bitmap_1(bitmap_git)) ||
    +@@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_git(struct repository *r)
    + {
    + 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
    + 
    +-	if (!open_bitmap(r, bitmap_git) && !load_bitmap(bitmap_git))
    ++	if (!open_bitmap(r, bitmap_git) && !load_bitmap(r, bitmap_git))
    + 		return bitmap_git;
    + 
    + 	free_bitmap_index(bitmap_git);
    +@@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_git(struct repository *r)
    + 
    + struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
    + {
    ++	struct repository *r = the_repository;
    + 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
    + 
    +-	if (!open_midx_bitmap_1(bitmap_git, midx) && !load_bitmap(bitmap_git))
    ++	if (!open_midx_bitmap_1(bitmap_git, midx) && !load_bitmap(r, bitmap_git))
    + 		return bitmap_git;
    + 
    + 	free_bitmap_index(bitmap_git);
    +@@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
    + 	 * from disk. this is the point of no return; after this the rev_list
    + 	 * becomes invalidated and we must perform the revwalk through bitmaps
    + 	 */
    +-	if (load_bitmap(bitmap_git) < 0)
    ++	if (load_bitmap(revs->repo, bitmap_git) < 0)
    + 		goto cleanup;
    + 
    + 	object_array_clear(&revs->pending);
    +@@ pack-bitmap.c: int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
    + 				       uint32_t *entries,
    + 				       struct bitmap **reuse_out)
    + {
    ++	struct repository *r = the_repository;
    + 	struct packed_git *pack;
    + 	struct bitmap *result = bitmap_git->result;
    + 	struct bitmap *reuse;
    +@@ pack-bitmap.c: int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
    + 
    + 	assert(result);
    + 
    +-	load_reverse_index(bitmap_git);
    ++	load_reverse_index(r, bitmap_git);
    + 
    + 	if (bitmap_is_midx(bitmap_git))
    + 		pack = bitmap_git->midx->packs[midx_preferred_pack(bitmap_git)];
    +@@ pack-bitmap.c: int rebuild_bitmap(const uint32_t *reposition,
    + uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
    + 				struct packing_data *mapping)
    + {
    ++	struct repository *r = the_repository;
    + 	uint32_t i, num_objects;
    + 	uint32_t *reposition;
    + 
    + 	if (!bitmap_is_midx(bitmap_git))
    +-		load_reverse_index(bitmap_git);
    ++		load_reverse_index(r, bitmap_git);
    + 	else if (load_midx_revindex(bitmap_git->midx) < 0)
    + 		BUG("rebuild_existing_bitmaps: missing required rev-cache "
    + 		    "extension");
     
      ## pack-revindex.c ##
     @@ pack-revindex.c: static int load_pack_revindex_from_disk(struct packed_git *p)
2:  0f368e2347e = 4:  8eec5bacd3a pack-revindex: introduce GIT_TEST_REV_INDEX_DIE_ON_DISK
3:  6f692d470cb ! 5:  a62fc3e4ec1 pack-revindex: introduce `pack.readReverseIndex`
    @@ Commit message
               'git.compile -c pack.readReverseIndex=false cat-file --batch-check="%(objectsize:disk)" --batch-all-objects' ran
                 2.06 ± 0.02 times faster than 'git.compile -c pack.readReverseIndex=true cat-file --batch-check="%(objectsize:disk)" --batch-all-objects'
     
    +    Luckily, the results when running `git cat-file` with `--unordered` are
    +    closer together:
    +
    +        $ hyperfine -L v false,true 'git.compile -c pack.readReverseIndex={v} cat-file --unordered --batch-check="%(objectsize:disk)" --batch-all-objects'
    +        Benchmark 1: git.compile -c pack.readReverseIndex=false cat-file --unordered --batch-check="%(objectsize:disk)" --batch-all-objects
    +          Time (mean ± σ):      5.066 s ±  0.105 s    [User: 4.792 s, System: 0.274 s]
    +          Range (min … max):    4.943 s …  5.220 s    10 runs
    +
    +        Benchmark 2: git.compile -c pack.readReverseIndex=true cat-file --unordered --batch-check="%(objectsize:disk)" --batch-all-objects
    +          Time (mean ± σ):      6.193 s ±  0.069 s    [User: 5.937 s, System: 0.255 s]
    +          Range (min … max):    6.145 s …  6.356 s    10 runs
    +
    +        Summary
    +          'git.compile -c pack.readReverseIndex=false cat-file --unordered --batch-check="%(objectsize:disk)" --batch-all-objects' ran
    +            1.22 ± 0.03 times faster than 'git.compile -c pack.readReverseIndex=true cat-file --unordered --batch-check="%(objectsize:disk)" --batch-all-objects'
    +
         Because the equilibrium point between these two is highly machine- and
         repository-dependent, allow users to configure whether or not they will
         read any ".rev" file(s) with this configuration knob.
4:  56a0fc0098e = 6:  f8298fb0bac config: enable `pack.writeReverseIndex` by default
5:  9c803799588 ! 7:  edff6a80c63 t: invert `GIT_TEST_WRITE_REV_INDEX`
    @@ Commit message
         disable writing ".rev" files, thereby running the test suite in a mode
         where the reverse index is generated from scratch.
     
    -    This ensures that we are still running and exercising Git's behavior
    -    when forced to generate reverse indexes from scratch.
    +    This ensures that, when GIT_TEST_NO_WRITE_REV_INDEX is set to some
    +    spelling of "true", we are still running and exercising Git's behavior
    +    when forced to generate reverse indexes from scratch. Do so by setting
    +    it in the linux-TEST-vars CI run to ensure that we are maintaining good
    +    coverage of this now-legacy code.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ ci/run-build-and-tests.sh: linux-TEST-vars)
      	export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1
      	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     -	export GIT_TEST_WRITE_REV_INDEX=1
    ++	export GIT_TEST_NO_WRITE_REV_INDEX=1
      	export GIT_TEST_CHECKOUT_WORKERS=2
      	;;
      linux-clang)
-- 
2.40.0.323.gedff6a80c63
