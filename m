Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF31C433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 21:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiF0Vig (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 17:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiF0Vie (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 17:38:34 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF1CB39
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 14:38:33 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id cu16so17331046qvb.7
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 14:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hu5sII5M8eEdb7YBuxuXm3XDuzInjQBpDM01PE/fAAk=;
        b=rSYjDBMF+9SZLZYpOhmkQiILaK/xu5B2gpGrVj2k8d2wbfXzlSe3+hal+X/itOExF7
         StYVFj1R6PYTxI+UeIIlB3nIw9VHGX3twG6jlZ6IAyunZEWKUN+L5obIji35Jh2Mbv22
         MAR/MTS1PAEF4ld8U+3c4nGGbg1mjLw235P2aNBljmTO2OQvqEBsmgFKjwLhMpR3XJC4
         0LB8fTm4d0Aab2bMIn8l4W1PzMTEEMuVo6ibcWeEgyc9IIWSOw3vuOuo84dj3o3996Rt
         Hv+MudbPXN0Rjj3JPJW2RESc3I4PXhs+7c1/6O29n7Qp5A1k1sSHkRoWS1SwLqj0jiNk
         JxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hu5sII5M8eEdb7YBuxuXm3XDuzInjQBpDM01PE/fAAk=;
        b=ICoH8oHfblpx2xGou5cJ72CE0eoJ4xQZfrDFE/tGHRjEFVx83Adp2GZDo+q6x23UPX
         bcmzO8MZyuPKj4cEAkovY2d+N2rMZS77Nkcx5D7l8BY61yRi5Qx3FF6HaZFkgfKzJjTg
         JoNdkH6rSCH5NjkamBgTGt/NQWwdwAMVZC2B0ngrzqyZD2PPd8/Xq2tMp5rJUDFZfMIq
         67lNkBGIaRxasmrXx/mOaa4ypYO9YP28/hCR2l9ECiRCY23sBMigx0AstGuYT1OQMtDr
         6DKCHAiaOIePikbczgutjslU7cEv8C8uSo1iGTGO61AnqSLmVe6WTyY0/2XboLE9dKSz
         Kgjw==
X-Gm-Message-State: AJIora9V7Gd6thm7g9KgxY0EU5f6DDFSkvqu7hPoBrjm+bpDOZZyD6uQ
        QuraS6puUAgnx4O26MQwelNR9/g0aN4qqg==
X-Google-Smtp-Source: AGRyM1sTe9WqJ8fhoPxNzqq8W2+sEl9Yn2vtsW/Ea4n/PnBvrYT/n0yI+x6XeG5QF98iy4aQfgcuZw==
X-Received: by 2002:a05:6214:1c8c:b0:46e:15b2:3f35 with SMTP id ib12-20020a0562141c8c00b0046e15b23f35mr1274883qvb.76.1656365912445;
        Mon, 27 Jun 2022 14:38:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f15-20020ac87f0f000000b00304e8938800sm8042279qtk.96.2022.06.27.14.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 14:38:31 -0700 (PDT)
Date:   Mon, 27 Jun 2022 17:38:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 4/6] pack-bitmap: prepare to read lookup table
 extension
Message-ID: <YrojV5aYCzxXlV3c@nand.local>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <4fbfcff8a208798146cd561b0185e094a116cf0e.1656249017.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4fbfcff8a208798146cd561b0185e094a116cf0e.1656249017.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 26, 2022 at 01:10:15PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> Earlier change teaches Git to write bitmap lookup table. But Git
> does not know how to parse them.
>
> Teach Git to parse the existing bitmap lookup table. The older
> versions of git are not affected by it. Those versions ignore the

s/git/Git

> lookup table.
>
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> Mentored-by: Taylor Blau <me@ttaylorr.com>
> Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
>  pack-bitmap.c                 | 193 ++++++++++++++++++++++++++++++++--
>  t/t5310-pack-bitmaps.sh       |   7 ++
>  t/t5326-multi-pack-bitmaps.sh |   1 +
>  3 files changed, 191 insertions(+), 10 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 36134222d7a..9e09c5824fc 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -82,6 +82,12 @@ struct bitmap_index {
>  	/* The checksum of the packfile or MIDX; points into map. */
>  	const unsigned char *checksum;
>
> +	/*
> +	 * If not NULL, this point into the commit table extension
> +	 * (within map).

It may be worth replacing "within map" to "within the memory mapped
region `map`" to make clear that this points somewhere within the mmap.

> +	 */
> +	unsigned char *table_lookup;
> +


> @@ -185,6 +191,22 @@ static int load_bitmap_header(struct bitmap_index *index)
>  			index->hashes = (void *)(index_end - cache_size);
>  			index_end -= cache_size;
>  		}
> +
> +		if (flags & BITMAP_OPT_LOOKUP_TABLE &&
> +			git_env_bool("GIT_TEST_READ_COMMIT_TABLE", 1)) {

I should have commented on this in an earlier round, but I wonder what
the behavior should be when we have BITMAP_OPT_LOOKUP_TABLE in our
flags, but GIT_TEST_READ_COMMIT_TABLE is disabled.

Right now, it doesn't matter, since there aren't any flags in bits above
BITMAP_OPT_LOOKUP_TABLE. But in the future, if there was some
BITMAP_OPT_FOO that was newer than BITMAP_OPT_LOOKUP_TABLE, we would
want to be able to read it without needing to read the lookup table.

At least, I think that should be true, though I would be interested to
hear if anybody has a differing opinion there.

> +			size_t table_size = 0;
> +			size_t triplet_sz = st_add3(sizeof(uint32_t),    /* commit position */
> +							sizeof(uint64_t),    /* offset */
> +							sizeof(uint32_t));    /* xor offset */

I don't think we need a st_add3() call here, since the size of these
three types is known to be small and thus won't overflow the available
range of size_t.

> +			table_size = st_add(table_size,
> +					st_mult(ntohl(header->entry_count),
> +						triplet_sz));

And table_size here is going to start off at zero, so the outer st_add()
call isn't necessary, either. This should instead be:

    size_t table_size = st_mult(ntohl(header->entry_count),
                                sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uint32_t));

It might be nice to have triplet_sz #define'd somewhere else, since
there are a handful of declarations in this patch that are all
identical. Probably something like:

    #define BITMAP_LOOKUP_TABLE_RECORD_WIDTH (sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uin32_t))

or even:

    /*
     * The width in bytes of a single record in the lookup table
     * extension:
     *
     *   (commit_pos, offset, xor_pos)
     *
     * whose fields are 32-, 64-, and 32-bits wide, respectively.
     */
    #define BITMAP_LOOKUP_TABLE_RECORD_WIDTH (16)

> +			if (table_size > index_end - index->map - header_size)
> +				return error("corrupted bitmap index file (too short to fit lookup table)");

if we decide to still recognize the lookup table extension without
*reading* from it when GIT_TEST_READ_COMMIT_TABLE is unset, I think we
should do something like:

    if (git_env_bool("GIT_TEST_READ_COMMIT_TABLE", 1))
        index->table_lookup = (void *)(index_end - table_size);
    index_end -= table_size;

...where the subtraction on index_end happens unconditionally.

> +static inline const void *bitmap_get_triplet(struct bitmap_index *bitmap_git, uint32_t xor_pos)
> +{
> +	size_t triplet_sz = st_add3(sizeof(uint32_t), sizeof(uint64_t), sizeof(uint32_t));

Same note about the #define constant here.

> +	const void *p = bitmap_git->table_lookup + st_mult(xor_pos, triplet_sz);

And this can be returned directly. Just:

    return bitmap_git->table_lookup + st_mult(xor_pos, BITMAP_LOOKUP_TABLE_RECORD_WIDTH);

although I wonder: why "xor_pos" and not just "pos" here?

> +static uint64_t triplet_get_offset(const void *triplet)
> +{
> +	const void *p = (unsigned char*) triplet + sizeof(uint32_t);
> +	return get_be64(p);
> +}
> +
> +static uint32_t triplet_get_xor_pos(const void *triplet)
> +{
> +	const void *p = (unsigned char*) triplet + st_add(sizeof(uint32_t), sizeof(uint64_t));
> +	return get_be32(p);
> +}

I wonder if we could get rid of these functions altogether and return a
small structure like:

    struct bitmap_lookup_table_record {
        uint32_t commit_pos;
        uint64_t offset;
        uint32_t xor_pos;
    };

or similar.

> +static int triplet_cmp(const void *va, const void *vb)
> +{
> +	int result = 0;
> +	uint32_t *a = (uint32_t *) va;
> +	uint32_t b = get_be32(vb);

Hmm. This is a little tricky to read. Here we're expecting "va" to hold
commit_pos from below, and "vb" to be a pointer at a lookup record.
Everything here is right, though I wonder if a comment or two might
clarify why one is "*(uint32_t *)va" and the other is "get_be32(vb)".

> +	if (*a > b)
> +		result = 1;
> +	else if (*a < b)
> +		result = -1;
> +	else
> +		result = 0;

Let's just return the result of the comparison directly here. And while
I'm looking at it, I think we can avoid dereferencing "a" on each use,
and instead just dereference va on assignment after casting, e.g.:

    uint32_t a = *(uint32_t*)va;

> +static uint32_t bsearch_pos(struct bitmap_index *bitmap_git, struct object_id *oid,
> +						uint32_t *result)
> +{
> +	int found;
> +
> +	if (bitmap_git->midx)

Nit: let's use the bitmap_is_midx() helper here instead of looking at
bitamp_git->midx directly.

> +		found = bsearch_midx(oid, bitmap_git->midx, result);
> +	else
> +		found = bsearch_pack(oid, bitmap_git->pack, result);
> +
> +	return found;
> +}

Makes sense.

> +static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_git,
> +					  struct commit *commit)
> +{
> +	uint32_t commit_pos, xor_pos;
> +	uint64_t offset;
> +	int flags;
> +	const void *triplet = NULL;
> +	struct object_id *oid = &commit->object.oid;
> +	struct ewah_bitmap *bitmap;
> +	struct stored_bitmap *xor_bitmap = NULL;
> +	size_t triplet_sz = st_add3(sizeof(uint32_t), sizeof(uint64_t), sizeof(uint32_t));
> +
> +	int found = bsearch_pos(bitmap_git, oid, &commit_pos);
> +
> +	if (!found)
> +		return NULL;
> +
> +	triplet = bsearch(&commit_pos, bitmap_git->table_lookup, bitmap_git->entry_count,
> +						triplet_sz, triplet_cmp);
> +	if (!triplet)
> +		return NULL;

OK. If you don't mind, I'm going to "think aloud" while I read through
this function to make sure that we're on the same page.

First thing is to convert the commit OID we're looking for into its
position within the corresponding pack index or MIDX file so that we can
use it as a search key to locate in the lookup table. If we didn't find
anything, or the commit doesn't exist in our pack / MIDX, nothing to do.

> +
> +	offset = triplet_get_offset(triplet);
> +	xor_pos = triplet_get_xor_pos(triplet);

Otherwise, record its offset and XOR "offset".

> +
> +	if (xor_pos != 0xffffffff) {
> +		int xor_flags;
> +		uint64_t offset_xor;
> +		uint32_t *xor_positions;
> +		struct object_id xor_oid;
> +		size_t size = 0;
> +
> +		ALLOC_ARRAY(xor_positions, bitmap_git->entry_count);

If we are XOR'd with another bitmap, make a stack of those bitmaps so
that we can decompress ourself.

I'm a little surprised that we're allocating an array as large as
bitmap_git->entry_count. It's not wrong, but it does waste some bytes
since we likely don't often have these long chains of XOR'd bitmaps.

We should instead allocate a smaller array and grow it over time (search
for examples of ALLOC_GROW() to see the canonical way to do this in
Git's codebase).

> +		while (xor_pos != 0xffffffff) {
> +			xor_positions[size++] = xor_pos;
> +			triplet = bitmap_get_triplet(bitmap_git, xor_pos);
> +			xor_pos = triplet_get_xor_pos(triplet);
> +		}
> +
> +		while (size){

Nit: missing space after ")" and before "{".

> +			xor_pos = xor_positions[size - 1];
> +			triplet = bitmap_get_triplet(bitmap_git, xor_pos);

We already have to get the triplets in the loop above, and then we dig
them back out here. Would it be easier to keep track of a list of
pointers into the mmaped region instead of looking up these triplets
each time?

> +			commit_pos = get_be32(triplet);
> +			offset_xor = triplet_get_offset(triplet);
> +
> +			if (nth_bitmap_object_oid(bitmap_git, &xor_oid, commit_pos) < 0) {

Should it be an error if we can't look up the object's ID here? I'd
think so.

> +				free(xor_positions);
> +				return NULL;
> +			}
> +
> +			bitmap_git->map_pos = offset_xor + sizeof(uint32_t) + sizeof(uint8_t);
> +			xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
> +			bitmap = read_bitmap_1(bitmap_git);
> +
> +			if (!bitmap){

Nit: missing space between ")" and "{".

> +				free(xor_positions);
> +				return NULL;
> +			}
> +
> +			xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_oid, xor_bitmap, xor_flags);
> +			size--;

Makes sense. Nicely done!

> +		}
> +
> +		free(xor_positions);
> +	}
> +
> +	bitmap_git->map_pos = offset + sizeof(uint32_t) + sizeof(uint8_t);
> +	flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
> +	bitmap = read_bitmap_1(bitmap_git);

Great, and now we can finally read the original bitmap that we wanted
to...

> +	if (!bitmap)
> +		return NULL;
> +
> +	return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags);

...and XOR it with the thing we built up in the loop. Very nicely done.
Do we have a good way to make sure that we're testing this code in CI?
It *seems* correct to me, but of course, we should have a computer check
that this produces OK results, not a human ;).

> +}
> +
>  struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
>  				      struct commit *commit)
>  {
>  	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
>  					   commit->object.oid);
> -	if (hash_pos >= kh_end(bitmap_git->bitmaps))
> -		return NULL;
> +	if (hash_pos >= kh_end(bitmap_git->bitmaps)) {
> +		struct stored_bitmap *bitmap = NULL;
> +		if (!bitmap_git->table_lookup)
> +			return NULL;
> +
> +		/* NEEDSWORK: cache misses aren't recorded */

For what it's worth, I think that it's completely fine to leave this as
a NEEDSWORK for the purposes of this series. I think we plausibly could
improve this in certain scenarios by finding some threshold on cache
misses when we should just fault in all bitmaps, but that can easily be
done on top.

> +		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
> +		if(!bitmap)

Nit: missing space between "if" and "(".

> +			return NULL;
> +		return lookup_stored_bitmap(bitmap);
> +	}
>  	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
>  }
>
> @@ -1699,9 +1861,13 @@ void test_bitmap_walk(struct rev_info *revs)
>  	if (revs->pending.nr != 1)
>  		die("you must specify exactly one commit to test");
>
> -	fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
> +	fprintf(stderr, "Bitmap v%d test (%d entries)\n",
>  		bitmap_git->version, bitmap_git->entry_count);
>
> +	if (!bitmap_git->table_lookup)
> +		fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
> +			bitmap_git->version, bitmap_git->entry_count);
> +

I think we should probably print just one or the other here, perhaps
like:

    fprintf(stderr, "Bitmap v%d test (%d entries%s)",
            bitmap_git->version,
            bitmap_git->entry_count,
            bitmap_git->table_lookup ? "" : " loaded");

>  	root = revs->pending.objects[0].item;
>  	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
>
> @@ -1753,10 +1919,16 @@ void test_bitmap_walk(struct rev_info *revs)
>
>  int test_bitmap_commits(struct repository *r)
>  {
> -	struct bitmap_index *bitmap_git = prepare_bitmap_git(r);
> +	struct bitmap_index *bitmap_git = NULL;
>  	struct object_id oid;
>  	MAYBE_UNUSED void *value;
>
> +	/* As this function is only used to print bitmap selected
> +	 * commits, we don't have to read the commit table.
> +	 */
> +	setenv("GIT_TEST_READ_COMMIT_TABLE", "0", 1);
> +
> +	bitmap_git = prepare_bitmap_git(r);
>  	if (!bitmap_git)
>  		die("failed to load bitmap indexes");
>
> @@ -1764,6 +1936,7 @@ int test_bitmap_commits(struct repository *r)
>  		printf("%s\n", oid_to_hex(&oid));
>  	});
>
> +	setenv("GIT_TEST_READ_COMMIT_TABLE", "1", 1);
>  	free_bitmap_index(bitmap_git);

Hmm. I'm not sure I follow the purpose of tweaking
GIT_TEST_READ_COMMIT_TABLE like this with setenv(). Are we trying to
avoid reading the lookup table? If so, why? I'd rather avoid
manipulating the environment directly like this, and instead have a
function we could call to fault in all of the bitmaps (when a lookup
table exists, otherwise do nothing).

Thanks,
Taylor
