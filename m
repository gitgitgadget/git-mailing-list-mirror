Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FA6C433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 22:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242159AbiFTWGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 18:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiFTWGn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 18:06:43 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B5C19C2C
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 15:06:41 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x75so8775381qkb.12
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iq7leaim6TUqavsIcGeKlRgHrAew7HGpFxbt5Pju310=;
        b=DKaMSKaOrgiKgCXQCZRSTEea209L2cSqFwSjv2tSYkXo1iT1TlXbFBLd5hlD/EhzAR
         ig7hcHi2XKzmGfeFAD5MGsBKdoCCoOFxOEBrxZ/wNWbdtTnxmNZFivfNOGk8XlVJk2Yd
         w1Iw+Cj+W/5ejioZRvFEXTCxKsqAwOd/cUoVNUnBFVIwZC+Nt116we/PSJAi86NqP1Al
         y0PGx6IWBifRmy79j2G7X0qTQWi+dmlW7lrFrAOwU3nIA3jAj/BlXavaZka9vu+ETl1x
         7kHZsS5Evm58fjVibuUlXvKGHZpNroLRl9HWe2/FZUTMBP0ukSSRwBfKXuo5FtjHx584
         QazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iq7leaim6TUqavsIcGeKlRgHrAew7HGpFxbt5Pju310=;
        b=MbkN+ICcZXKl2xOshtwZa/rupVfkfZxRpR+xmwoFyUHm0GSu7MGfHJIvWxyxE9oX3i
         kKfEMFCn3TVg47aXWxttOaSN3D49coezuvFxS0h/D8emSnbFx6VzFFFfu/IF2+EdzbiL
         Xim2hLYRQZ2FlByarQVP6R1S5IsETGUi0Z2YDunLxyn+U5tk9tcGy1e7IThXbEYBa/bh
         vZ3gKLG15hBeo803TyMMZJXl907CEAebsJJ45Y4D/Vjdet9e94otnSB7gKLpoWdmeSLI
         /aeGuIAq22HqrO2+DwxKtM7uA8tE/1qs40TdfTlqw+gYiudkdXT8vJ6j5Hmy1Kkts4/G
         ozDw==
X-Gm-Message-State: AJIora8ZqPRKjCShSEiGjznPLYLvTVBOOoNfq1TrFRDEA8scAEeRK61j
        Rv3V4qC4f/9dRdyXwQD732cTHw==
X-Google-Smtp-Source: AGRyM1vvmtDNFD74MtQNqGC/e3C3L25YNqC5gXlk7/+m51zFozQEaLpj8AXwNttebH+XcbIctmwkBA==
X-Received: by 2002:a05:620a:22d2:b0:6a6:bb15:d521 with SMTP id o18-20020a05620a22d200b006a6bb15d521mr17969405qki.114.1655762800569;
        Mon, 20 Jun 2022 15:06:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v63-20020a372f42000000b006a6a5d1e240sm12051470qkh.34.2022.06.20.15.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 15:06:40 -0700 (PDT)
Date:   Mon, 20 Jun 2022 18:06:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 2/6] pack-bitmap: prepare to read lookup table extension
Message-ID: <YrDvaMHz9DnjBqLs@nand.local>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <d139a4c48aa058b142c4860721b10344c5498031.1655728395.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d139a4c48aa058b142c4860721b10344c5498031.1655728395.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 20, 2022 at 12:33:10PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> Bitmap lookup table extension can let git to parse only the necessary
> bitmaps without loading the previous bitmaps one by one.
>
> Teach git to read and use the bitmap lookup table extension.
>
> Co-Authored-by: Taylor Blau <ttaylorr@github.com>
> Mentored-by: Taylor Blau <ttaylorr@github.com>
> Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>  pack-bitmap.c | 172 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  pack-bitmap.h |   1 +
>  2 files changed, 166 insertions(+), 7 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 36134222d7a..d5e5973a79f 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -15,6 +15,7 @@
>  #include "list-objects-filter-options.h"
>  #include "midx.h"
>  #include "config.h"
> +#include "hash-lookup.h"
>
>  /*
>   * An entry on the bitmap index, representing the bitmap for a given
> @@ -82,6 +83,13 @@ struct bitmap_index {
>  	/* The checksum of the packfile or MIDX; points into map. */
>  	const unsigned char *checksum;
>
> +	/*
> +	 * If not NULL, these point into the various commit table sections
> +	 * (within map).
> +	 */
> +	unsigned char *table_lookup;
> +	unsigned char *table_offsets;
> +

If table_offsets ends up being a list of just offsets, we could assign
this to the appropriate type, e.g., 'uint64_t *'. We would want to
avoid using a type whose width is platform dependent, like off_t.

But if you end up taking my suggestion from a previous response (of
making each entry in the offset table a triple of commit, offset, and
xor position), make sure to _not_ get tempted to define a struct and
assign table_lookup to be a pointer of that structure type.

That's because even though the struct *should* be packed as you expect,
the packing is mostly up to the compiler, so you can't guarantee its
members won't have padding between them or at the end of the struct for
alignment purposes.

>  	/*
>  	 * Extended index.
>  	 *
> @@ -185,6 +193,24 @@ static int load_bitmap_header(struct bitmap_index *index)
>  			index->hashes = (void *)(index_end - cache_size);
>  			index_end -= cache_size;
>  		}
> +
> +		if (flags & BITMAP_OPT_LOOKUP_TABLE &&
> +		    git_env_bool("GIT_READ_COMMIT_TABLE", 1)) {

What is the purpose of the GIT_READ_COMMIT_TABLE environment variable? I
assume that it's to make it easier to run tests (especially performance
ones) with and without access to the lookup table. If so, we should
document that (lightly) in the commit message, and rename this to be
GIT_TEST_READ_COMMIT_TABLE to indicate that it shouldn't be used outside
of tests.

> +			uint32_t entry_count = ntohl(header->entry_count);
> +			uint32_t table_size =
> +				(entry_count * the_hash_algo->rawsz) /* oids */ +
> +				(entry_count * sizeof(uint32_t)) /* offsets */ +
> +				(entry_count * sizeof(uint32_t)) /* xor offsets */ +
> +				(sizeof(uint32_t)) /* flags */;

entry_count is definitely a 4-byte integer, so uint32_t is the right
type. But I think table_size should be a size_t, and computations on it
should be more strictly checked. Perhaps something like;

    size_t table_size = sizeof(uint32_t); /* flags */
    table_size = st_add(table_size, st_mult(entry_count, the_hash_algo->rawsz)); /* oids */
    table_size = st_add(table_size, st_mult(entry_count, sizeof(uint32_t))); /* offsets */
    table_size = st_add(table_size, st_mult(entry_count, sizeof(uint32_t))); /* xor offsets */

or even:

    size_t table_size = sizeof(uint32_t); /* flags */
    table_size = st_add(table_size,
                        st_mult(entry_count,
                                the_hash_algo->rawsz + /* oids */
                                sizeof(uint32_t) + /* offsets*/
                                sizeof(uint32_t) /* xor offsets */
                               ));

> +			if (table_size > index_end - index->map - header_size)
> +				return error("corrupted bitmap index file (too short to fit commit table)");
> +
> +			index->table_lookup = (void *)(index_end - table_size);
> +			index->table_offsets = index->table_lookup + the_hash_algo->rawsz * entry_count;
> +
> +			index_end -= table_size;
> +		}

Looks good.

> @@ -470,7 +496,7 @@ static int load_bitmap(struct bitmap_index *bitmap_git)
>  		!(bitmap_git->tags = read_bitmap_1(bitmap_git)))
>  		goto failed;
>
> -	if (load_bitmap_entries_v1(bitmap_git) < 0)
> +	if (!bitmap_git->table_lookup && load_bitmap_entries_v1(bitmap_git) < 0)
>  		goto failed;

No need to load each of the bitmaps individually via
load_bitmap_entries_v1() if we have a lookup table. That function
doesn't do any other initialization that we depend on, so it's OK to
just avoid calling it altogether.

>  	return 0;
> @@ -557,14 +583,145 @@ struct include_data {
>  	struct bitmap *seen;
>  };
>
> -struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
> -				      struct commit *commit)
> +static struct stored_bitmap *stored_bitmap_for_commit(struct bitmap_index *bitmap_git,
> +						      struct commit *commit,
> +						      uint32_t *pos_hint);
> +
> +static inline const unsigned char *bitmap_oid_pos(struct bitmap_index *bitmap_git,
> +						  uint32_t pos)
> +{
> +	return bitmap_git->table_lookup + (pos * the_hash_algo->rawsz);
> +}
> +
> +static inline const void *bitmap_offset_pos(struct bitmap_index *bitmap_git,
> +					    uint32_t pos)
> +{
> +	return bitmap_git->table_offsets + (pos * 2 * sizeof(uint32_t));
> +}
> +
> +static inline const void *xor_position_pos(struct bitmap_index *bitmap_git,
> +					   uint32_t pos)
> +{
> +	return (unsigned char*) bitmap_offset_pos(bitmap_git, pos) + sizeof(uint32_t);
> +}
> +
> +static int bitmap_lookup_cmp(const void *_va, const void *_vb)
> +{
> +	return hashcmp(_va, _vb);
> +}

All makes sense. Some light documentation might help explain what this
comparator function is used for (the bsearch() call below in
bitmap_table_lookup()), although I suspect that this function will get
slightly more complicated if you pack the table contents as I suggest,
in which case more documentation will definitely help.

> +
> +static int bitmap_table_lookup(struct bitmap_index *bitmap_git,
> +			       struct object_id *oid,
> +			       uint32_t *commit_pos)
> +{
> +	unsigned char *found = bsearch(oid->hash, bitmap_git->table_lookup,
> +				       bitmap_git->entry_count,
> +				       the_hash_algo->rawsz, bitmap_lookup_cmp);
> +	if (found)
> +		*commit_pos = (found - bitmap_git->table_lookup) / the_hash_algo->rawsz;

If you end up chaning the type of bitmap_git->table_lookup, make sure
that you scale the result of the pointer arithmetic accordingly, or cast
down to an 'unsigned char *' before you do any math.

> +	return !!found;
> +}
> +
> +static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_git,
> +						    struct object_id *oid,
> +						    uint32_t commit_pos)
> +{
> +	uint32_t xor_pos;
> +	off_t bitmap_ofs;
> +
> +	int flags;
> +	struct ewah_bitmap *bitmap;
> +	struct stored_bitmap *xor_bitmap;
> +
> +	bitmap_ofs = get_be32(bitmap_offset_pos(bitmap_git, commit_pos));
> +	xor_pos = get_be32(xor_position_pos(bitmap_git, commit_pos));
> +
> +	/*
> +	 * Lazily load the xor'd bitmap if required (and we haven't done so
> +	 * already). Make sure to pass the xor'd bitmap's position along as a
> +	 * hint to avoid an unnecessary binary search in
> +	 * stored_bitmap_for_commit().
> +	 */
> +	if (xor_pos == 0xffffffff) {
> +		xor_bitmap = NULL;
> +	} else {
> +		struct commit *xor_commit;
> +		struct object_id xor_oid;
> +
> +		oidread(&xor_oid, bitmap_oid_pos(bitmap_git, xor_pos));

Interesting; this is a point that I forgot about from the original
patch. xor_pos is an index (not an offset) into the list of commits in
the table of contents in the order appear in that table. We should be
clear about (a) what that order is, and (b) that xor_pos is an index
into that order.

The rest of this function looks good to me.

> +static struct stored_bitmap *stored_bitmap_for_commit(struct bitmap_index *bitmap_git,
> +						      struct commit *commit,
> +						      uint32_t *pos_hint)
>  {
>  	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
>  					   commit->object.oid);
> -	if (hash_pos >= kh_end(bitmap_git->bitmaps))
> +	if (hash_pos >= kh_end(bitmap_git->bitmaps)) {
> +		uint32_t commit_pos;
> +		if (!bitmap_git->table_lookup)
> +			return NULL;

I was going to suggest moving this check into the caller
bitmap_for_commit() and making it a BUG() to call
stored_bitmap_for_commit() with a NULL bitmap_git->table_lookup pointer.

And I think this makes sense... if we return NULL here, then we know
that we definitely don't have a stored bitmap, since there's no table to
look it up in and we have already loaded everything else. So we
propagate that NULL to the return value of bitmap_for_commit(), and that
makes sense. Good.

> +		/* NEEDSWORK: cache misses aren't recorded. */

Yeah. The problem here is that we can't record every commit that
_doesn't_ have a bitmap every time we return NULL from one of these
queries, since there are arbitrarily many such commits that don't have
bitmaps.

We could approximate it using a Bloom filter or something, and much of
that code is already written and could be interesting to try and reuse.

But I wonder if we could get by with something simpler, though, which
would cause us to load all bitmaps from the lookup table after a fixed
number of cache misses (at which point we should force ourselves to load
everything and just read everything out of a single O(1) lookup in the
stored bitmap table).

That may or may not be a good idea, and the threshold will probably be
highly dependent on the system. So it may not even be worth it, but I
think it's an interesting area to experiemnt in and think a little more
about.

> +		if (pos_hint)
> +			commit_pos = *pos_hint;

How does this commit_pos work again? I confess I have forgetten since I
wrote some of this code a while ago... :-).

> @@ -1699,8 +1856,9 @@ void test_bitmap_walk(struct rev_info *revs)
>  	if (revs->pending.nr != 1)
>  		die("you must specify exactly one commit to test");
>
> -	fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
> -		bitmap_git->version, bitmap_git->entry_count);
> +	if (!bitmap_git->table_lookup)
> +		fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
> +			bitmap_git->version, bitmap_git->entry_count);

Should we print this regardless of whether or not there is a lookup
table? We should be able to learn the entry count either way.

Thanks,
Taylor
