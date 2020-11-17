Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192E5C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C08E241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="WRePy25X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgKQVqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbgKQVqW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:46:22 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E615DC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:46:20 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id z17so11561880qvy.11
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lkuoh1C47LhtJ+wkzZFKZpUxBei7Vk7BpCzHdwo2oRw=;
        b=WRePy25Xwip0SShOM88T9V+NqfIZX3xbSMIoLS1aSR6lYlCe+esbGUjoudYh9ZJNZg
         MXNWYf0eApEwjZwAbszx//Xb6l59lng+vv0ii4ZC4QKzMjzNFhufdHL/wW3QseeZUcHj
         rwMIUUIi4xL3R3UnQSI51e2qM8SbdsySfQ3CaMOUmgbGrgfTYSDT2SvHYK90SJ7xxrHK
         Ldp+O++IScSWqgetMz+8tz8ccbtLlYeF4E+StfnDofPWU2ZhMIkuE6YreExj13o4AFB3
         HnbQkNKtsBL5rwg+CGgx5WmudDKRSrO2L41HI7ey7TepPP6VSB7ZGivtHERY8wWaUvQP
         csaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lkuoh1C47LhtJ+wkzZFKZpUxBei7Vk7BpCzHdwo2oRw=;
        b=geoviSkzrRwgJyy8ktaPq48q+cFYRqrLjBQfkw0gkZvWZxCfVbgEykeUEhambzZwlU
         RIi+tXTqPJiyZ/U6BEM3Zs8uFMWLx878cjfRBx6UoaXzTcVvdQPsDoU5aj8fqzoRHEmo
         0ArKGexIfLj/8/b6aEcSttXaQjXEGTVLquPD/jy8wmC0XBmDh9/RhKQ9Nc3mwqD1TcRI
         I0XSz4AEJwpjVdK9gQXHDK097suZOw+9q9suFKZ6VS6tu1W+SIj0raJKKLoFcGslGQ1e
         1JLqj+QFNBCTnRfDXRUW1Lwnk7ZRX11dEDjjegR+jeUZJAHgEuzAXzLdFYjItoSEvO0k
         jIoA==
X-Gm-Message-State: AOAM531GN111xAhUydGBu7XEh1nAZGvRvKT6FKjJJ5FYNk1VvPTlQYFO
        ulw3nJ6skTPt6pS9IBGH6jI7Mg3lHpMq8eor
X-Google-Smtp-Source: ABdhPJz7ey60i1J8g4hxeqBRF6LLl+fjL+rkOqkV3OAncEbyycD55SlbwYIW+z/JUxbMsoQjUenOhg==
X-Received: by 2002:a0c:e443:: with SMTP id d3mr1904132qvm.18.1605649579307;
        Tue, 17 Nov 2020 13:46:19 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id y1sm9136207qky.63.2020.11.17.13.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:46:18 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:46:16 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 00/24] pack-bitmap: bitmap generation improvements
Message-ID: <cover.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is an updated version of this series, which improves the
performance of generating reachability bitmaps in large repositories.

Not very much has changed since last time, but a range-diff is below
nonetheless. The major changes are:

  - Avoid an overflow when bounds checking in the second and third
    patches (thanks, Martin, for noticing).
  - Incorporate a fix to avoid reading beyond an EWAH bitmap by double
    checking our read before actually doing it (thanks, Peff).
  - Harden the tests so that they pass under sha256-mode (thanks SZEDER,
    and Peff).

Derrick Stolee (9):
  pack-bitmap-write: fill bitmap with commit history
  bitmap: add bitmap_diff_nonzero()
  commit: implement commit_list_contains()
  t5310: add branch-based checks
  pack-bitmap-write: rename children to reverse_edges
  pack-bitmap-write: build fewer intermediate bitmaps
  pack-bitmap-write: use existing bitmaps
  pack-bitmap-write: relax unique rewalk condition
  pack-bitmap-write: better reuse bitmaps

Jeff King (11):
  pack-bitmap: fix header size check
  pack-bitmap: bounds-check size of cache extension
  t5310: drop size of truncated ewah bitmap
  rev-list: die when --test-bitmap detects a mismatch
  ewah: factor out bitmap growth
  ewah: make bitmap growth less aggressive
  ewah: implement bitmap_or()
  ewah: add bitmap_dup() function
  pack-bitmap-write: reimplement bitmap writing
  pack-bitmap-write: pass ownership of intermediate bitmaps
  pack-bitmap-write: ignore BITMAP_FLAG_REUSE

Taylor Blau (4):
  ewah/ewah_bitmap.c: grow buffer past 1
  pack-bitmap.c: check reads more aggressively when loading
  pack-bitmap: factor out 'bitmap_for_commit()'
  pack-bitmap: factor out 'add_commit_to_bitmap()'

 builtin/pack-objects.c  |   1 -
 commit.c                |  11 +
 commit.h                |   2 +
 ewah/bitmap.c           |  54 ++++-
 ewah/ewah_bitmap.c      |   2 +-
 ewah/ewok.h             |   3 +-
 pack-bitmap-write.c     | 452 +++++++++++++++++++++++++---------------
 pack-bitmap.c           | 139 ++++++------
 pack-bitmap.h           |   8 +-
 t/t5310-pack-bitmaps.sh | 164 ++++++++++++---
 10 files changed, 555 insertions(+), 281 deletions(-)

Range-diff against v1:
 -:  ---------- >  1:  07054ff8ee ewah/ewah_bitmap.c: grow buffer past 1
 1:  1970a70207 !  2:  74a13b4a6e pack-bitmap: fix header size check
    @@ pack-bitmap.c: static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *ind
     +	size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;

     -	if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)
    -+	if (index->map_size < header_size)
    - 		return error("Corrupted bitmap index (missing header data)");
    +-		return error("Corrupted bitmap index (missing header data)");
    ++	if (index->map_size < header_size + the_hash_algo->rawsz)
    ++		return error("Corrupted bitmap index (too small)");

      	if (memcmp(header->magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE)) != 0)
    + 		return error("Corrupted bitmap index file (wrong header)");
     @@ pack-bitmap.c: static int load_bitmap_header(struct bitmap_index *index)
      	}

 2:  36b1815d03 !  3:  db11116dac pack-bitmap: bounds-check size of cache extension
    @@ Commit message
         pack-bitmap: bounds-check size of cache extension

         A .bitmap file may have a "name hash cache" extension, which puts a
    -    sequence of uint32_t bytes (one per object) at the end of the file. When
    -    we see a flag indicating this extension, we blindly subtract the
    +    sequence of uint32_t values (one per object) at the end of the file.
    +    When we see a flag indicating this extension, we blindly subtract the
         appropriate number of bytes from our available length. However, if the
         .bitmap file is too short, we'll underflow our length variable and wrap
         around, thinking we have a very large length. This can lead to reading
    @@ pack-bitmap.c: static int load_bitmap_header(struct bitmap_index *index)
      	/* Parse known bitmap format options */
      	{
      		uint32_t flags = ntohs(header->options);
    -+		uint32_t cache_size = st_mult(index->pack->num_objects, sizeof(uint32_t));
    ++		size_t cache_size = st_mult(index->pack->num_objects, sizeof(uint32_t));
     +		unsigned char *index_end = index->map + index->map_size - the_hash_algo->rawsz;

      		if ((flags & BITMAP_OPT_FULL_DAG) == 0)
    @@ pack-bitmap.c: static int load_bitmap_header(struct bitmap_index *index)
      		if (flags & BITMAP_OPT_HASH_CACHE) {
     -			unsigned char *end = index->map + index->map_size - the_hash_algo->rawsz;
     -			index->hashes = ((uint32_t *)end) - index->pack->num_objects;
    -+			if (index->map + header_size + cache_size > index_end)
    ++			if (cache_size > index_end - index->map - header_size)
     +				return error("corrupted bitmap index file (too short to fit hash cache)");
     +			index->hashes = (void *)(index_end - cache_size);
     +			index_end -= cache_size;
 3:  edfec2ea62 =  4:  f779e76f82 t5310: drop size of truncated ewah bitmap
 4:  f3fec466f7 =  5:  1a9ac1c4ae rev-list: die when --test-bitmap detects a mismatch
 5:  b35012f44d =  6:  9bb1ea3b19 ewah: factor out bitmap growth
 6:  53b8bea98c =  7:  f8426c7e8b ewah: make bitmap growth less aggressive
 7:  98e3bfc1b2 =  8:  674e31f98e ewah: implement bitmap_or()
 8:  1bd115fc51 =  9:  a903c949d8 ewah: add bitmap_dup() function
 9:  adf16557c2 = 10:  c951206729 pack-bitmap-write: reimplement bitmap writing
10:  27992687c9 = 11:  466dd3036a pack-bitmap-write: pass ownership of intermediate bitmaps
11:  d92fb0e1e1 = 12:  8e5607929d pack-bitmap-write: fill bitmap with commit history
12:  bf86cb6196 = 13:  4840c64c51 bitmap: add bitmap_diff_nonzero()
13:  78cdf847aa = 14:  63e846f4e8 commit: implement commit_list_contains()
14:  778e9e9c44 = 15:  8b5d239333 t5310: add branch-based checks
15:  526d3509ef = 16:  60a46091bb pack-bitmap-write: rename children to reverse_edges
 -:  ---------- > 17:  8f7bb2dd2e pack-bitmap.c: check reads more aggressively when loading
16:  86d77fd085 ! 18:  5262daa330 pack-bitmap-write: build fewer intermediate bitmaps
    @@ t/t5310-pack-bitmaps.sh: test_expect_success 'setup repo with moderate-sized his
      '

      test_expect_success 'rev-list --test-bitmap verifies bitmaps' '
    +@@ t/t5310-pack-bitmaps.sh: test_expect_success 'truncated bitmap fails gracefully (ewah)' '
    + 	git rev-list --use-bitmap-index --count --all >expect &&
    + 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
    + 	test_when_finished "rm -f $bitmap" &&
    +-	test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
    ++	test_copy_bytes 270 <$bitmap >$bitmap.tmp &&
    + 	mv -f $bitmap.tmp $bitmap &&
    + 	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
    + 	test_cmp expect actual &&
17:  e4f296100c = 19:  a206f48614 pack-bitmap-write: ignore BITMAP_FLAG_REUSE
18:  6e856bcf75 = 20:  9928b3c7da pack-bitmap: factor out 'bitmap_for_commit()'
19:  9b5f595f50 = 21:  f40a39a48a pack-bitmap: factor out 'add_commit_to_bitmap()'
20:  c458f98e11 = 22:  4bf5e78a54 pack-bitmap-write: use existing bitmaps
21:  3026876e7a = 23:  1da4fa0fb8 pack-bitmap-write: relax unique rewalk condition
22:  ce2716e291 = 24:  42399a1c2e pack-bitmap-write: better reuse bitmaps
--
2.29.2.312.gabc4d358d8
