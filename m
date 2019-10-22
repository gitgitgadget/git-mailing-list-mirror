Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 634CA1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 19:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbfJVTsN (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 15:48:13 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:37349 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbfJVTsN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 15:48:13 -0400
Received: by mail-pf1-f201.google.com with SMTP id p2so14185620pff.4
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wx/3iKT6Ym7/+xqboxsA0w7JxF7F4KUvEXGRRQCOQjU=;
        b=Rkk+vg9e5L5ZGSTGDV5hHXEe8spDFF1D6JWsXx74oEOnbycQzU3/qA1C7nRKbIE3Z+
         QA3bMhj+8KfZFmkCQFmdbrDazGUTpGz9EKUrCKZnupmcuwvruAxR7nZNR3fKPaqvxj7f
         6U6wCXZSyKNGtDkGjHXjsRSUP1SAbS3nds+339IVuWSX+ZCppQqsT24xpJI2oF9lvIj/
         P4DbjiD+O00XV6NvsbWu/x9uoGnTOcyKZ6gE8Tz6x+EVMb1/3Lh1x496uUJ1at9mwO/8
         XDRMCx1Hpe+irLX42RPebK5SoyFV3o7FzudwMVS/RI7RgTB/+DdvPs048X8n1H9UAfS+
         abkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wx/3iKT6Ym7/+xqboxsA0w7JxF7F4KUvEXGRRQCOQjU=;
        b=b15lm5ZGduVBayG17JxRVL+F6lSI3yl1b5/XGtp0ev+u96CRRLGRAD2I2+Hceoejid
         IqZuCC5brnf2fvHuc2l9/Clo/n/WN6jiuxsSf3yO2sb+1wjhxkhpap75dFUpoUCk0nJE
         q5i0FiyNCGG6xYs9mtLnU2+X40I+Ek7uN3mAVyOb/S5iMKzhBDILcNkF8WvjLuxCOdBv
         +kbDdIcaKYeiGOULgkKQrgX7iakU64ZqR5ynBUqvcUTf060ole2p+m4jbDw4j1bZ3/4Z
         wRM9zckHhmY7/vzZh46m0gcklXGkrN6wcwbe7gwsme3gfrYghgEgZOH8SexR48DNMzNM
         CLDg==
X-Gm-Message-State: APjAAAWbr8SsxWvzAuygoKj9uLMUrt9zajjHaXXAA4+pkTyFyI6V2Tb5
        yLGuYD/xIFUGFkLwlql/3xu59/4HfseWojRzdrBR
X-Google-Smtp-Source: APXvYqyCNNhCljPMUArNmCtK0591vIp80wjBIY/TbTs9GoCqipdkdfFrRr/SbCTfV/yscPt9YU5ZXDJ6QPfaYxLw6GGQ
X-Received: by 2002:a65:504b:: with SMTP id k11mr5647117pgo.13.1571773690063;
 Tue, 22 Oct 2019 12:48:10 -0700 (PDT)
Date:   Tue, 22 Oct 2019 12:48:05 -0700
In-Reply-To: <20191019103531.23274-10-chriscool@tuxfamily.org>
Message-Id: <20191022194805.139215-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191019103531.23274-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: Re: [PATCH v2 9/9] pack-objects: improve partial packfile reuse
From:   Jonathan Tan <jonathantanmy@google.com>
To:     christian.couder@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        chriscool@tuxfamily.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First, the commit message could probably be reordered to start with the
main point (reusing of packfiles at object granularity instead of
allowing reuse of only one contiguous region). To specific points:

> The dynamic array of `struct reused_chunk` is useful
> because we need to know not just the number of zero bits,
> but the accumulated offset due to missing objects.

The number of zero bits is irrelevant, I think. (I know I introduced
this idea, but at that time I was somehow confused that the offset was a
number of objects and not a number of bytes.)

> If a client both asks for a tag by sha1 and specifies
> "include-tag", we may end up including the tag in the reuse
> bitmap (due to the first thing), and then later adding it to
> the packlist (due to the second). This results in duplicate
> objects in the pack, which git chokes on. We should notice
> that we are already including it when doing the include-tag
> portion, and avoid adding it to the packlist.

I still don't understand this part. Going off what's written in the
commit message here, it seems to me that the issue is that (1) an object
can be added to the reuse bitmap without going through to_pack, and (2)
this is done when the client asks for a tag by SHA-1. But all objects
when specified by SHA-1 go through to_pack, don't they?

On to the review of the code. The ordering of - and + lines are
confusing, so I have just removed all - lines.

> +/*
> + * Record the offsets needed in our reused packfile chunks due to
> + * "gaps" where we omitted some objects.
> + */
> +static struct reused_chunk {
> +	off_t start;
> +	off_t offset;
> +} *reused_chunks;
> +static int reused_chunks_nr;
> +static int reused_chunks_alloc;

A chunk is a set of objects from the original packfile that we are
reusing; all objects in a chunk have the same relative position in the
original packfile and the generated packfile. (This does not mean that
the bytes are exactly the same or, even, that the last object in the
chunk has the same size in the original packfile and the generated
packfile.)

"start" is the offset of the first object of the chunk in the original
packfile.

"offset" is "start" minus the offset of the first object of the chunk in
the generated packfile. (I think it is easier to understand if this was
"new minus old" instead of "old minus new", that is, the negation of its
current value.)

So I would prefer:

  /*
   * A reused set of objects. All objects in a chunk have the same
   * relative position in the original packfile and the generated
   * packfile.
   */
  struct reused_chunk {
    /* The offset of the first object of this chunk in the original
     * packfile. */
    off_t original;
    /* The offset of the first object of this chunk in the generated
     * packfile minus "original". */
    off_t difference;
  }

> +static void record_reused_object(off_t where, off_t offset)

Straightforward, other than the renaming of parameters.

> +/*
> + * Binary search to find the chunk that "where" is in. Note
> + * that we're not looking for an exact match, just the first
> + * chunk that contains it (which implicitly ends at the start
> + * of the next chunk.
> + */
> +static off_t find_reused_offset(off_t where)

Also straightforward.

> +static void write_reused_pack_one(size_t pos, struct hashfile *out,
> +				  struct pack_window **w_curs)
> +{
> +	off_t offset, next, cur;
> +	enum object_type type;
> +	unsigned long size;
> +
> +	offset = reuse_packfile->revindex[pos].offset;
> +	next = reuse_packfile->revindex[pos + 1].offset;
>  
> +	record_reused_object(offset, offset - hashfile_total(out));

This is where I understood what "offset" meant in struct reused_chunk.

>  
> +	cur = offset;
> +	type = unpack_object_header(reuse_packfile, w_curs, &cur, &size);
> +	assert(type >= 0);
>  
> +	if (type == OBJ_OFS_DELTA) {
> +		off_t base_offset;
> +		off_t fixup;
> +
> +		unsigned char header[MAX_PACK_OBJECT_HEADER];
> +		unsigned len;
> +
> +		base_offset = get_delta_base(reuse_packfile, w_curs, &cur, type, offset);
> +		assert(base_offset != 0);
> +
> +		/* Convert to REF_DELTA if we must... */
> +		if (!allow_ofs_delta) {
> +			int base_pos = find_revindex_position(reuse_packfile, base_offset);
> +			const unsigned char *base_sha1 =
> +				nth_packed_object_sha1(reuse_packfile,
> +						       reuse_packfile->revindex[base_pos].nr);
> +
> +			len = encode_in_pack_object_header(header, sizeof(header),
> +							   OBJ_REF_DELTA, size);
> +			hashwrite(out, header, len);
> +			hashwrite(out, base_sha1, 20);
> +			copy_pack_data(out, reuse_packfile, w_curs, cur, next - cur);
> +			return;
> +		}
>  
> +		/* Otherwise see if we need to rewrite the offset... */
> +		fixup = find_reused_offset(offset) -
> +			find_reused_offset(base_offset);

The "offset" in "reused offset" is actually the difference in offset
between the original packfile and the generated packfile, as I explained
earlier. If the base_original->base_generated and
delta_original->delta_generated distances are the same, then nothing
needs to be done, as the comment above correctly explains.

> +		if (fixup) {
> +			unsigned char ofs_header[10];
> +			unsigned i, ofs_len;
> +			off_t ofs = offset - base_offset - fixup;
>  
> +			len = encode_in_pack_object_header(header, sizeof(header),
> +							   OBJ_OFS_DELTA, size);
>  
> +			i = sizeof(ofs_header) - 1;
> +			ofs_header[i] = ofs & 127;
> +			while (ofs >>= 7)
> +				ofs_header[--i] = 128 | (--ofs & 127);
> +
> +			ofs_len = sizeof(ofs_header) - i;
> +
> +			hashwrite(out, header, len);
> +			hashwrite(out, ofs_header + sizeof(ofs_header) - ofs_len, ofs_len);
> +			copy_pack_data(out, reuse_packfile, w_curs, cur, next - cur);
> +			return;
> +		}
> +
> +		/* ...otherwise we have no fixup, and can write it verbatim */
> +	}
> +
> +	copy_pack_data(out, reuse_packfile, w_curs, offset, next - offset);
> +}

We can write verbatim if (OFS + allow_ofs_delta + no fixup necessary) or
if it is REF.

> +static size_t write_reused_pack_verbatim(struct hashfile *out,
> +					 struct pack_window **w_curs)
> +{
> +	size_t pos = 0;
> +
> +	while (pos < reuse_packfile_bitmap->word_alloc &&
> +			reuse_packfile_bitmap->words[pos] == (eword_t)~0)
> +		pos++;
> +
> +	if (pos) {
> +		off_t to_write;
> +
> +		written = (pos * BITS_IN_EWORD);
> +		to_write = reuse_packfile->revindex[written].offset
> +			- sizeof(struct pack_header);
> +
> +		record_reused_object(sizeof(struct pack_header), 0);

Probably worth a comment, since we're recording one chunk, not one
object. The code is correct, though - one big chunk with original offset
as written, and no difference between original and generated offsets.

> +		hashflush(out);
> +		copy_pack_data(out, reuse_packfile, w_curs,
> +			sizeof(struct pack_header), to_write);
>  
>  		display_progress(progress_state, written);
>  	}
> +	return pos;
> +}

The number of objects written is always a multiple of <number of bits in
eword_t>, but that's fine.

> +static void write_reused_pack(struct hashfile *f)
> +{
> +	size_t i = 0;
> +	uint32_t offset;
> +	struct pack_window *w_curs = NULL;
> +
> +	if (allow_ofs_delta)
> +		i = write_reused_pack_verbatim(f, &w_curs);
> +
> +	for (; i < reuse_packfile_bitmap->word_alloc; ++i) {
> +		eword_t word = reuse_packfile_bitmap->words[i];
> +		size_t pos = (i * BITS_IN_EWORD);
> +
> +		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
> +			if ((word >> offset) == 0)
> +				break;
> +
> +			offset += ewah_bit_ctz64(word >> offset);
> +			write_reused_pack_one(pos + offset, f, &w_curs);
> +			display_progress(progress_state, ++written);
> +		}
> +	}
>  
> +	unuse_pack(&w_curs);
>  }

Looks straightforward to me. I found the inner "for" loop a bit
confusing, because the counter variable ("offset") is incremented both
in the 3rd clause and in the body.

>  		if (reuse_packfile) {
> -			off_t packfile_size;
>  			assert(pack_to_stdout);
> -
> -			packfile_size = write_reused_pack(f);
> -			offset += packfile_size;
> +			write_reused_pack(f);
> +			offset = hashfile_total(f);
>  		}

Straightforward.

> @@ -1001,6 +1119,10 @@ static int have_duplicate_entry(const struct object_id *oid,
>  {
>  	struct object_entry *entry;
>  
> +	if (reuse_packfile_bitmap &&
> +	    bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid))
> +		return 1;
> +
>  	entry = packlist_find(&to_pack, oid);
>  	if (!entry)
>  		return 0;
> @@ -2555,7 +2677,9 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
>  
>  static int obj_is_packed(const struct object_id *oid)
>  {
> +	return packlist_find(&to_pack, oid) ||
> +		(reuse_packfile_bitmap &&
> +		 bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));
>  }

These are the parts I was confused about, as I said when I was
discussing the commit message.

> @@ -2661,6 +2785,7 @@ static void prepare_pack(int window, int depth)
>  
>  	if (nr_deltas && n > 1) {
>  		unsigned nr_done = 0;
> +
>  		if (progress)
>  			progress_state = start_progress(_("Compressing objects"),
>  							nr_deltas);

Unnecessary added line - please remove.

On to pack-bitmap.c.

> +static void try_partial_reuse(struct bitmap_index *bitmap_git,
> +			      size_t pos,
> +			      struct bitmap *reuse,
> +			      struct pack_window **w_curs)
>  {
> +	struct revindex_entry *revidx;
> +	off_t offset;
> +	enum object_type type;
> +	unsigned long size;
> +
> +	if (pos >= bitmap_git->pack->num_objects)
> +		return; /* not actually in the pack */

Is this case possible? try_partial_reuse() is only called when there is
a 1 at the bit location.

> +
> +	revidx = &bitmap_git->pack->revindex[pos];
> +	offset = revidx->offset;
> +	type = unpack_object_header(bitmap_git->pack, w_curs, &offset, &size);
> +	if (type < 0)
> +		return; /* broken packfile, punt */
> +
> +	if (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA) {
> +		off_t base_offset;
> +		int base_pos;
> +
> +		/*
> +		 * Find the position of the base object so we can look it up
> +		 * in our bitmaps. If we can't come up with an offset, or if
> +		 * that offset is not in the revidx, the pack is corrupt.
> +		 * There's nothing we can do, so just punt on this object,
> +		 * and the normal slow path will complain about it in
> +		 * more detail.
> +		 */
> +		base_offset = get_delta_base(bitmap_git->pack, w_curs,
> +					     &offset, type, revidx->offset);
> +		if (!base_offset)
> +			return;
> +		base_pos = find_revindex_position(bitmap_git->pack, base_offset);
> +		if (base_pos < 0)
> +			return;
> +
> +		/*
> +		 * We assume delta dependencies always point backwards. This
> +		 * lets us do a single pass, and is basically always true
> +		 * due to the way OFS_DELTAs work. You would not typically
> +		 * find REF_DELTA in a bitmapped pack, since we only bitmap
> +		 * packs we write fresh, and OFS_DELTA is the default). But
> +		 * let's double check to make sure the pack wasn't written with
> +		 * odd parameters.
> +		 */
> +		if (base_pos >= pos)
> +			return;
> +
> +		/*
> +		 * And finally, if we're not sending the base as part of our
> +		 * reuse chunk, then don't send this object either. The base
> +		 * would come after us, along with other objects not
> +		 * necessarily in the pack, which means we'd need to convert
> +		 * to REF_DELTA on the fly. Better to just let the normal
> +		 * object_entry code path handle it.
> +		 */
> +		if (!bitmap_get(reuse, base_pos))
> +			return;
> +	}
> +
>  	/*
> +	 * If we got here, then the object is OK to reuse. Mark it.
>  	 */
> +	bitmap_set(reuse, pos);
> +}

OK. Thanks for the great comments.

> +int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
> +				       struct packed_git **packfile_out,
> +				       uint32_t *entries,
> +				       struct bitmap **reuse_out)
> +{
>  	struct bitmap *result = bitmap_git->result;
> +	struct bitmap *reuse;
> +	struct pack_window *w_curs = NULL;
> +	size_t i = 0;
> +	uint32_t offset;
>  
>  	assert(result);
>  
> +	while (i < result->word_alloc && result->words[i] == (eword_t)~0)
> +		i++;

Skip through fully-1 words so that we don't have to iterate through
every bit - sounds good.

>  
> +	/* Don't mark objects not in the packfile */
> +	if (i > bitmap_git->pack->num_objects / BITS_IN_EWORD)
> +		i = bitmap_git->pack->num_objects / BITS_IN_EWORD;

Why is this necessary? Let's say we have 42 fully-1 words, and therefore
i is 42. Shouldn't we allocate 42 words in our reuse bitmap?

>  
> +	reuse = bitmap_word_alloc(i);
> +	memset(reuse->words, 0xFF, i * sizeof(eword_t));
>  
> +	for (; i < result->word_alloc; ++i) {
> +		eword_t word = result->words[i];
> +		size_t pos = (i * BITS_IN_EWORD);
>  
> +		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
> +			if ((word >> offset) == 0)
> +				break;
>  
> +			offset += ewah_bit_ctz64(word >> offset);
> +			try_partial_reuse(bitmap_git, pos + offset, reuse, &w_curs);
> +		}
>  	}
>  
> +	unuse_pack(&w_curs);
>  
> +	*entries = bitmap_popcount(reuse);
> +	if (!*entries) {
> +		bitmap_free(reuse);
>  		return -1;
> +	}
>  
> +	/*
> +	 * Drop any reused objects from the result, since they will not
> +	 * need to be handled separately.
> +	 */
> +	bitmap_and_not(result, reuse);
> +	*packfile_out = bitmap_git->pack;
> +	*reuse_out = reuse;
>  	return 0;
>  }

Looks good.

And thanks for this patch - other than the difficult-to-understand parts
I described above, I found the overall flow easy to discern.

I presume tests would also need to be written. One way is to introduce
yet another test variable, but maybe that is overkill.
