Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496EAC43334
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 01:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiGZBNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 21:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiGZBNy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 21:13:54 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C76286EB
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 18:13:53 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id n2so9988996qkk.8
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 18:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jNGmz6w6EYml1D8zRN8ktR9szYtYTHdXzz2yEAoPknw=;
        b=p7XMofmTHxsAszrt/V+BgAOPapb7XvLgAwIqZ2pg6aAsSf01HKqyFW+ybSZ/luSO4C
         WPMJLLsvx5PwIANqNcmnARxJ5lRL0ydUMRKAL4yQvS90K5hSpq9yioMLbqV7VRjzInSw
         wYZ9n+qGLqhbm16jyH58WsSoOkcvFTMmSaJ2PsycPFFb6zQyG9rKg75y5ZXlmDqknBxj
         AfivvNBsq6pMeC5IPXGJ2QU/rNCO19GubJ1hwGj9eHlqH0ZfjRsLi3wnTY7KxU5tgqGT
         PEb9pbKYdEsr3BAJJQwklWD86CRuv+oya3m68CVaO50Uk4lgIG9L7nls3EF5AHCKLgth
         4hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jNGmz6w6EYml1D8zRN8ktR9szYtYTHdXzz2yEAoPknw=;
        b=R74FD+iLBMN1bKTYIJSk7D3vEprKirDZJhpqb/AhZXSnQ4j3gMzgs+D3DAV4obgRaN
         taQQY4N0FUuYaedJSy5m0KflgGmO74DgsKRfzEzBdw4OTaoNjP7HfXxbKcBJdMt1610V
         hVeawMwsS7WqVmNhL+B9uzwJ44f2EI3YH/IFXSz1RU4IQeNqZAKicxZTTL2r/fcnX1Cs
         Qve6dUxSo5GDq/LFSqF6y0MIlqGvT2EMSJcA2lfRdCnAucXRoZLzX+D5AEi2zBK/cjgy
         28FaRlmWCwfOaMnPTmzpoF9CGoxlYZvhGyQ9CqaRIsFdBUXX/Txc0AJf2o/J8rWNs+AG
         O3Nw==
X-Gm-Message-State: AJIora9CV51IS1xUQ10lXKY1NTSGcqn8e4KugueC+z4noMp3N09OCL60
        hAluJvcUES1auHkYXzbvICtHToi9lOLKEA==
X-Google-Smtp-Source: AGRyM1sBCkQTWa6JAKVPnQHvR6tobf/QIsiYN76PLtNaPdR3lXNuA0rFPzxO89tlk1cvIUa6LL/6uQ==
X-Received: by 2002:ae9:eb8f:0:b0:6b5:d0d3:e6f8 with SMTP id b137-20020ae9eb8f000000b006b5d0d3e6f8mr10925859qkg.745.1658798032159;
        Mon, 25 Jul 2022 18:13:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t2-20020ac85882000000b0031eb02307a9sm8292791qta.80.2022.07.25.18.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 18:13:51 -0700 (PDT)
Date:   Mon, 25 Jul 2022 21:13:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v5 4/6] pack-bitmap: prepare to read lookup table
 extension
Message-ID: <Yt8/zl/uOLRBRS4h@nand.local>
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
 <6918f0860adbea1156fb7a9f1a5aedd211872481.1658342304.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6918f0860adbea1156fb7a9f1a5aedd211872481.1658342304.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 20, 2022 at 06:38:22PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:

> @@ -557,13 +575,238 @@ struct include_data {
>  	struct bitmap *seen;
>  };
>
> +struct bitmap_lookup_table_triplet {
> +	uint32_t commit_pos;
> +	uint64_t offset;
> +	uint32_t xor_row;
> +};
> +
> +struct bitmap_lookup_table_xor_item {
> +	struct object_id oid;
> +	uint64_t offset;
> +};
> +
> +/*
> + * Given a `triplet` struct pointer and pointer `p`, this
> + * function reads the triplet beginning at `p` into the struct.
> + * Note that this function assumes that there is enough memory
> + * left for filling the `triplet` struct from `p`.
> + */
> +static int lookup_table_get_triplet_by_pointer(struct bitmap_lookup_table_triplet *triplet,
> +					       const unsigned char *p)
> +{
> +	if (!triplet)
> +		return -1;
> +
> +	triplet->commit_pos = get_be32(p);
> +	p += sizeof(uint32_t);
> +	triplet->offset = get_be64(p);
> +	p += sizeof(uint64_t);
> +	triplet->xor_row = get_be32(p);
> +	return 0;

Just noticing this now, but I wonder if we could avoid incrementing `p`
here and instead write something like:

    triplet->commit_pos = get_be32(p);
    triplet->offset = get_be64(p + sizeof(uint32_t));
    triplet->xor_row = get_be64(p + sizeof(uint64_t) + sizeof(uint32_t));

I don't have a strong feeling about it, though, it just seems to read a
little more directly to me and avoid modifying a variable that is only
going to live as long as the function executes (p).

> +/*
> + * This function gets the raw triplet from `row`'th row in the
> + * lookup table and fills that data to the `triplet`.
> + */
> +static int lookup_table_get_triplet(struct bitmap_index *bitmap_git,
> +				    uint32_t pos,
> +				    struct bitmap_lookup_table_triplet *triplet)
> +{
> +	unsigned char *p = NULL;
> +	if (pos >= bitmap_git->entry_count)
> +		return error(_("corrupt bitmap lookup table: triplet position out of index"));
> +
> +	p = bitmap_git->table_lookup + st_mult(pos, BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH);
> +
> +	return lookup_table_get_triplet_by_pointer(triplet, p);
> +}

Very nice. This cleans things up nicely by being able to call
lookup_table_get_triplet_by_pointer().

Since these are static functions, it doesn't really matter whether or
not they are prefixed with 'bitmap_', since they won't be visible
outside of pack-bitmap.c's compilation unit. But it may be nice to
prefix them with 'bitmap_' just to make it extra clear that these are
internal functions meant to be used within the bitmap machinery only.

> +static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_git,
> +					  struct commit *commit)
> +{
> +	uint32_t commit_pos, xor_row;
> +	uint64_t offset;
> +	int flags, found;
> +	struct bitmap_lookup_table_triplet triplet;
> +	struct object_id *oid = &commit->object.oid;
> +	struct ewah_bitmap *bitmap;
> +	struct stored_bitmap *xor_bitmap = NULL;
> +	const int bitmap_header_size = 6;
> +	static struct bitmap_lookup_table_xor_item *xor_items = NULL;
> +	static size_t xor_items_nr = 0, xor_items_alloc = 0;

I had to double check, but xor_items_alloc inherits the same storage
class at xor_items_nr, so they are both static size_t's.

> +	static int is_corrupt = 0;
> +
> +	if (is_corrupt)
> +		return NULL;

What is the purpose of this conditional? We don't modify `is_corrupt`
before reading it here, so this should be dead code, unless I'm missing
something.

> +	found = bsearch_pos(bitmap_git, oid, &commit_pos);
> +
> +	if (!found)
> +		return NULL;

FWIW, we could eliminate this variable from a particularly long list of
stack variables above by just writing:

    if (!bsearch_pos(bitmap_git, oid, &commit_pos))
      return NULL;

and I think that would be OK.

> +	if (bsearch_triplet_by_pos(commit_pos, bitmap_git, &triplet) < 0)
> +		return NULL;
> +
> +	xor_items_nr = 0;

This initialization *is* necessary, since the xor_items_nr and
xor_items_alloc variable are statically allocated.

> +	offset = triplet.offset;
> +	xor_row = triplet.xor_row;
> +
> +	if (xor_row != 0xffffffff) {

Is this outer conditional needed? I don't think it is. If xor_row is
0xffffffff, then the while loop below won't be entered, and
xor_items_nr will be zero, meaning that the second while loop will also
be skipped.

So I think we can just as easily get rid of this outermost if-statement
and de-dent the main part of this function's body.

> +		int xor_flags;
> +		khiter_t hash_pos;
> +		struct bitmap_lookup_table_xor_item *xor_item;
> +
> +		while (xor_row != 0xffffffff) {
> +			ALLOC_GROW(xor_items, xor_items_nr + 1, xor_items_alloc);
> +
> +			if (xor_items_nr + 1 >= bitmap_git->entry_count) {
> +				error(_("corrupt bitmap lookup table: xor chain exceed entry count"));
> +				goto corrupt;
> +			}
> +
> +			if (lookup_table_get_triplet(bitmap_git, xor_row, &triplet) < 0)
> +				goto corrupt;
> +
> +			xor_item = &xor_items[xor_items_nr];
> +			xor_item->offset = triplet.offset;
> +
> +			if (nth_bitmap_object_oid(bitmap_git, &xor_item->oid, triplet.commit_pos) < 0) {
> +				error(_("corrupt bitmap lookup table: commit index %u out of range"),
> +					triplet.commit_pos);
> +				goto corrupt;
> +			}
> +
> +			hash_pos = kh_get_oid_map(bitmap_git->bitmaps, xor_item->oid);
> +
> +			/*
> +			 * If desired bitmap is already stored, we don't need
> +			 * to iterate further. Because we know that bitmaps
> +			 * that are needed to be parsed to parse this bitmap
> +			 * has already been stored. So, assign this stored bitmap
> +			 * to the xor_bitmap.
> +			 */
> +			if (hash_pos < kh_end(bitmap_git->bitmaps) &&
> +			    (xor_bitmap = kh_value(bitmap_git->bitmaps, hash_pos)))
> +				break;
> +			xor_items_nr++;
> +			xor_row = triplet.xor_row;
> +		}
> +
> +		while (xor_items_nr) {
> +			xor_item = &xor_items[xor_items_nr - 1];
> +			bitmap_git->map_pos = xor_item->offset;
> +			if (bitmap_git->map_size - bitmap_git->map_pos < bitmap_header_size) {
> +				error(_("corrupt ewah bitmap: truncated header for bitmap of commit \"%s\""),
> +					oid_to_hex(&xor_item->oid));
> +				goto corrupt;
> +			}
> +
> +			bitmap_git->map_pos = bitmap_git->map_pos + sizeof(uint32_t) + sizeof(uint8_t);

Could we write:

    bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t)

or similar? Also, a clarifying comment would help explain why we are
advancing, what we're skipping past, and why it's OK.

> +			xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
> +			bitmap = read_bitmap_1(bitmap_git);
> +
> +			if (!bitmap)
> +				goto corrupt;
> +
> +			xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_item->oid, xor_bitmap, xor_flags);
> +			xor_items_nr--;
> +		}
> +	}
> +
> +	bitmap_git->map_pos = offset;
> +	if (bitmap_git->map_size - bitmap_git->map_pos < bitmap_header_size) {
> +		error(_("corrupt ewah bitmap: truncated header for bitmap of commit \"%s\""),
> +			oid_to_hex(oid));
> +		goto corrupt;
> +	}
> +
> +	bitmap_git->map_pos = bitmap_git->map_pos + sizeof(uint32_t) + sizeof(uint8_t);
> +	flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
> +	bitmap = read_bitmap_1(bitmap_git);
> +
> +	if (!bitmap)
> +		goto corrupt;
> +
> +	return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags);
> +
> +corrupt:
> +	free(xor_items);
> +	is_corrupt = 1;
> +	return NULL;
> +}

Thanks,
Taylor
