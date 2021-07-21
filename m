Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBDDC6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C80961249
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhGUWUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhGUWUm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:20:42 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A3DC061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:01:18 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id u7so4254822ion.3
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6xDzFYJzJbcrBUVeAqCJt0514by0hkaYHgufYJ6Rwp0=;
        b=rMShFG1w2cxRwZxSgpwpnEc+OB4Zo2pWkcmKmQDYz2xJPis+TpYk7LPoBYrcMjHWd0
         BSOUHvETFTYZthMpYORz0Or1OE5GOXPaPVLjP+o4qbJ+c7NDqGuubJk1nM5Uj/qxprmi
         p1zZyIWs94klkK5WTZDRyFLuRunWZj42b9RjTteGQ8v11XifTyj/M+wm+p7MvyoY0K8f
         WkssKJh2zj3QBw3x6Ljz5IIPUaYZVfkWQrf7Eyq3lnMd2tOeeFupUgzGrruYCE4QhT5b
         aRV/TRYQGLqS9dxnDGMACTpdHgGw726lzWkd62LJWiS4xMc1I1PU6RMWsUdJ3MAfjHPs
         Pxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6xDzFYJzJbcrBUVeAqCJt0514by0hkaYHgufYJ6Rwp0=;
        b=Z84AWTZMQ6pHTBa0wFl4/HIzbMwLDUu+yFig6OMqNbdcoHH/h/u5dJUQxBAkT9QEUe
         FELnqZ18yVZtjypzz80woBGZPwz/+biNaI8dB1YSHNXaSjxWxNwtMT6hWSRib5KZ1+sJ
         wPMRNbBXlA/6TPnQ2Sb6IoSRSQnAcyJAiJ7VIOruYPZE20LMm0MxRHcZNSTeCf/WYU3W
         AygzrPSkKhvc4aVKUPqwKQJWMLtYg7kH5IYJd/XZB9teqP+cw7OyeGNZRd9ygxR7PViD
         hPtHdkLYVt0xLWMKaTuIpgeTMLUwqNq/Xfxwx/TyPi8OW1zLlLKjxskmJF2z6sjR+fvg
         aJpg==
X-Gm-Message-State: AOAM531CtT3RXGvVJ0o7llVqyNAAJYlH2ZtIHxEmqgfO3HTn7dlhsSpO
        H3eSt/w8xCTaJG9SZO0i/XxQBw==
X-Google-Smtp-Source: ABdhPJzOIvUdFSJBgklKJ+/w/v1tXczYF8EsF4w9/JROa8J54u/2OIHmxvpa+9wUzWDJ3Uvvb8nKvA==
X-Received: by 2002:a5e:8c07:: with SMTP id n7mr22427485ioj.26.1626908477352;
        Wed, 21 Jul 2021 16:01:17 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:2c46:d8ae:a4c3:9466])
        by smtp.gmail.com with ESMTPSA id z11sm14792399ioh.14.2021.07.21.16.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:01:16 -0700 (PDT)
Date:   Wed, 21 Jul 2021 19:01:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 13/24] pack-bitmap: read multi-pack bitmaps
Message-ID: <YPinPFW50Mj8cVkP@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <7d44ba6299c06c956d5ac8ba01a0288d109c3cae.1624314293.git.me@ttaylorr.com>
 <YPgF4X2PeFvBuJXm@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPgF4X2PeFvBuJXm@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 07:32:49AM -0400, Jeff King wrote:
> On Mon, Jun 21, 2021 at 06:25:31PM -0400, Taylor Blau wrote:
> > +	if (!is_pack_valid(packfile)) {
> > +		close(fd);
> > +		return -1;
> > +	}
> > +
>
> What's this extra is_pack_valid() doing? I wouldn't expect many changes
> at all to this non-midx code path (aside from the "did we already load a
> midx bitmap" in the earlier part of the hunk, which makes sense).

That looks like a mistake to me. I did a little digging and tried to
remember if it could have ever been useful, but I think that it's just a
stray change that has no value. Removed.

> > -static int load_pack_bitmap(struct bitmap_index *bitmap_git)
> > +static int load_reverse_index(struct bitmap_index *bitmap_git)
> > +{
> > +	if (bitmap_is_midx(bitmap_git)) {
> > +		uint32_t i;
> > +		int ret;
> > +
> > +		ret = load_midx_revindex(bitmap_git->midx);
> > +		if (ret)
> > +			return ret;
> > +
> > +		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
> > +			if (prepare_midx_pack(the_repository, bitmap_git->midx, i))
> > +				die(_("load_reverse_index: could not open pack"));
> > +			ret = load_pack_revindex(bitmap_git->midx->packs[i]);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +		return 0;
> > +	}
> > +	return load_pack_revindex(bitmap_git->pack);
> > +}
>
> OK, this new function is used in load_bitmap(), which is used for both
> pack and midx bitmaps. So if we have a midx bitmap, we'll
> unconditionally load the revindex here. But:
>
>   - why do we then load individual pack revindexes? I can believe it may
>     be necessary to meet the assumptions of some other part of the code,
>     but it would be nice to have a comment giving us some clue.

Good suggestion. We will need to reference the reverse index belonging
to individual packs in a few locations in pack-objects (for e.g.,
write_reuse_object() calls offset_to_pack_pos(), and
pack_pos_to_offset(), both with arbitrary packs, not just the preferred
one).

I left the comment vague; something along the lines of "lots of routines
in pack-objects will need these structures to be ready to use".

I think there's room for improvement there, since for e.g., `git
rev-list --count --objects --use-bitmap-index` doesn't need to load the
reverse indexes. But that's already the case with classic bitmaps, too,
which eagerly call load_pack_revindex().

>   - in open_midx_bitmap_1(), we also unconditionally load the midx
>     reverse index. I think that will always happen before us here (we
>     cannot load_bitmap() a bitmap that has not been opened). So is this
>     load_midx_revindex() call always a noop?

Great catch. I removed the call to load_midx_revindex(), and replaced it
with a comment explaining why we don't need to call it (because we
already did).

> >  static int bitmap_position(struct bitmap_index *bitmap_git,
> >  			   const struct object_id *oid)
> >  {
> > -	int pos = bitmap_position_packfile(bitmap_git, oid);
> > +	int pos;
> > +	if (bitmap_is_midx(bitmap_git))
> > +		pos = bitmap_position_midx(bitmap_git, oid);
> > +	else
> > +		pos = bitmap_position_packfile(bitmap_git, oid);
> >  	return (pos >= 0) ? pos : bitmap_position_extended(bitmap_git, oid);
> >  }
>
> Makes sense. Not new in your patch, but this "int" return is fudging the
> same 32-bit space we were talking about elsewhere (i.e., "pos" really
> could be 2^32, or even more due to extended objects).

:-). It bothers me to no end, too, because of all of the recent effort
to improve the reverse-index APIs to avoid exactly this issue. But I
tend to agree that the concern is more theoretical than anything,
because we're only using the MSB, so the remaining 2^31 possible objects
still seems pretty generous.

> In practice I think even 2^31 objects is pretty out-of-reach, but it may
> be worth changing the return type (and the callers), or even just
> catching the overflow with an assertion.

Possibly, but keep in mind that the former is basically the same
refactor as we did with the "tell me whether this object was found via
this extra pointer". But bitmap_position() has a lot more callers than
that, so the plumbing required would be a little more prevalent.

So I'd be content to just punt on it for now, if you'd be OK with it.

> >  	if (pos < bitmap_num_objects(bitmap_git)) {
> > -		off_t ofs = pack_pos_to_offset(pack, pos);
> > +		struct packed_git *pack;
> > +		off_t ofs;
> > +
> > +		if (bitmap_is_midx(bitmap_git)) {
> > +			uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, pos);
> > +			uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
> > +
> > +			pack = bitmap_git->midx->packs[pack_id];
> > +			ofs = nth_midxed_offset(bitmap_git->midx, midx_pos);
> > +		} else {
> > +			pack = bitmap_git->pack;
> > +			ofs = pack_pos_to_offset(pack, pos);
> > +		}
> > +
>
> All of the hunks like this make perfect sense. The big problem would be
> if we _missed_ a place that needed conversion to handle midx. But the
> nice thing is that it would segfault quickly in such an instance. So
> there I'm mostly relying on test coverage, plus our experience running
> with this code at scale.

Yeah; I'm definitely happy to rely on our experience running this and
related patches at GitHub for several months to give us confidence that
we didn't miss anything here.

> >  static void try_partial_reuse(struct bitmap_index *bitmap_git,
> > +			      struct packed_git *pack,
> >  			      size_t pos,
> >  			      struct bitmap *reuse,
> >  			      struct pack_window **w_curs)
> >  {
> > -	off_t offset, header;
> > +	off_t offset, delta_obj_offset;
>
> I'm OK with all of this in one big patch. But I suspect you _could_
> just put:
>
>   if (bitmap_git->midx)
> 	return; /* partial reuse not implemented for midx yet */
>
> to start with, and then actually implement it later. I call out this
> code in particular just because it's got a lot of subtleties (the
> "reuse" bits are much more intimate with the assumptions of packs and
> bitmaps than most other code).
>
> I'm not sure if it's worth the trouble at this point or not.

Yeah, I'd definitely err on the side of not splitting this up now,
especially since you've already gone through the whole patch and
reviewed it. (Of course, if your response was "this patch is way too
big, please split it up so I can more easily review it", that would be a
different story).

But I appreciate the advice, since I have felt that a lot of these
format-level changes require a 3-patch arc where:

  - The first patch describes the new format in Documentation/technical.
  - The second patch implements support for reading files that are
    written in the new format.
  - And finally, the third patch implements support for writing such
    files.

...and it's usually the second of those three patches that is the most
complicated one by far. So this is a good way to split that patch up
into many pieces.

Of course, that only works if you delay adding tests until after support
is added for all parts of the new format, but that's more-or-less what
did here.

> > +static uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git)
> > +{
> > +	struct multi_pack_index *m = bitmap_git->midx;
> > +	if (!m)
> > +		BUG("midx_preferred_pack: requires non-empty MIDX");
> > +	return nth_midxed_pack_int_id(m, pack_pos_to_midx(bitmap_git->midx, 0));
> > +}
>
> This part is really subtle. We infer the preferred pack by looking at
> the pack of the 0th bit position. In general that works, since that's
> part of the definition of the preferred pack.
>
> Could this ever be fooled if we had a preferred pack with 0 objects in
> it? I don't know why we would have such a thing, but just trying to
> think of cases where our assumptions might not hold (and what bad things
> could happen).

An empty preferred pack would cause a problem, yes. The solution is
two-fold (and incorporated into the reroll that I plan on sending
shortly):

  - When the user specifies --preferred-pack, the MIDX code must make
    sure that the given pack is non-empty. That's a new patch, and
    basically adds a new conditional (to check the pack itself) and a
    test (to make sure that we catch the case we are trying to prevent).

  - When the user doesn't specify --preferred-pack (and instead asks us
    to infer one for them) we want to select not just the oldest pack,
    but the oldest *non-empty* pack. That is folded into the "midx:
    infer preferred pack when not given one" patch.

In that patch, I made a note, but I think that it's subtle enough to
merit sharing here again. In the loop over all packs, the conditional for swapping out the oldest pack for the current one was something like:

    if (p->mtime < oldest->mtime)
      oldest = p;

but now we want it to be:

    if (!oldest->num_objects || p->mtime < oldest->mtime)
      oldest = p;

to reject packs that have no objects. And we want to be extra careful in
the case where the only pack fed to the MIDX writer was empty. But we
don't have to do anything there, since there are no objects to write
anyway, so any "preferred_idx" would be fine.

> > +	if (bitmap_is_midx(bitmap_git))
> > +		pack = bitmap_git->midx->packs[midx_preferred_pack(bitmap_git)];
> > +	else
> > +		pack = bitmap_git->pack;
> > +	objects_nr = pack->num_objects;
> > +
> >  	while (i < result->word_alloc && result->words[i] == (eword_t)~0)
> >  		i++;
> >
> > -	/* Don't mark objects not in the packfile */
> > +	/*
> > +	 * Don't mark objects not in the packfile or preferred pack. This bitmap
> > +	 * marks objects eligible for reuse, but the pack-reuse code only
> > +	 * understands how to reuse a single pack. Since the preferred pack is
> > +	 * guaranteed to have all bases for its deltas (in a multi-pack bitmap),
> > +	 * we use it instead of another pack. In single-pack bitmaps, the choice
> > +	 * is made for us.
> > +	 */
> >  	if (i > objects_nr / BITS_IN_EWORD)
> >  		i = objects_nr / BITS_IN_EWORD;
>
> OK, so this clamps our "quick" contiguous set of bits to the number of
> objects in the preferred pack. Makes sense. And then we hit the
> object-by-object loop below...
>
> > @@ -1213,7 +1437,15 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
> >  				break;
> >
> >  			offset += ewah_bit_ctz64(word >> offset);
> > -			try_partial_reuse(bitmap_git, pos + offset, reuse, &w_curs);
> > +			if (bitmap_is_midx(bitmap_git)) {
> > +				/*
> > +				 * Can't reuse from a non-preferred pack (see
> > +				 * above).
> > +				 */
> > +				if (pos + offset >= objects_nr)
> > +					continue;
> > +			}
> > +			try_partial_reuse(bitmap_git, pack, pos + offset, reuse, &w_curs);
>
> ...and this likewise makes sure we never go past that first pack. Good.
>
> I think this "continue" could actually be a "break", as the loop is
> iterating over "offset" (and "pos + offset" always gets larger). In
> fact, it could break out of the outer loop as well (which is
> incrementing "pos"). It's probably a pretty small efficiency in
> practice, though.

Yeah; you're right. And we'll save up to BITS_IN_EWORD cycles of this
loop. (I wonder if smart-enough compilers will realize the same
optimization that you did and turn that `continue` into a `break`
automatically, but that's neither here nor there).

> > @@ -1511,8 +1749,13 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
> >  		struct object_id oid;
> >  		struct object_entry *oe;
> >
> > -		nth_packed_object_id(&oid, bitmap_git->pack,
> > -				     pack_pos_to_index(bitmap_git->pack, i));
> > +		if (bitmap_is_midx(bitmap_git))
> > +			nth_midxed_object_oid(&oid,
> > +					      bitmap_git->midx,
> > +					      pack_pos_to_midx(bitmap_git->midx, i));
> > +		else
> > +			nth_packed_object_id(&oid, bitmap_git->pack,
> > +					     pack_pos_to_index(bitmap_git->pack, i));
> >  		oe = packlist_find(mapping, &oid);
>
> Could this be using nth_bitmap_object_oid()? I guess not, because we are
> feeding from pack_pos_to_*. I'm not sure if another helper function is
> worth it (pack_pos_to_bitmap_index() or something?).

You're right that we can't call nth_bitmap_object_oid here directly,
sadly. But I think your suggestion for pack_pos_to_bitmap_index() (or
similar) would only benefit this caller, since most places that dispatch
conditionally to either pack_pos_to_{midx,index} want to pass the result
to a different function depending on which branch they took.

Definitely possible that I missed another case that would help, but that
was what I came up with after just a quick glance.

> > @@ -1575,7 +1831,31 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
> >  				break;
> >
> >  			offset += ewah_bit_ctz64(word >> offset);
> > -			pos = base + offset;
> > +
> > +			if (bitmap_is_midx(bitmap_git)) {
> > +				uint32_t pack_pos;
> > +				uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, base + offset);
> > +				uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
> > +				off_t offset = nth_midxed_offset(bitmap_git->midx, midx_pos);
> > +
> > +				pack = bitmap_git->midx->packs[pack_id];
> > +
> > +				if (offset_to_pack_pos(pack, offset, &pack_pos) < 0) {
> > +					struct object_id oid;
> > +					nth_midxed_object_oid(&oid, bitmap_git->midx, midx_pos);
> > +
> > +					die(_("could not find %s in pack #%"PRIu32" at offset %"PRIuMAX),
> > +					    oid_to_hex(&oid),
> > +					    pack_id,
> > +					    (uintmax_t)offset);
> > +				}
> > +
> > +				pos = pack_pos;
> > +			} else {
> > +				pack = bitmap_git->pack;
> > +				pos = base + offset;
> > +			}
> > +
> >  			total += pack_pos_to_offset(pack, pos + 1) -
> >  				 pack_pos_to_offset(pack, pos);
> >  		}
>
> In the midx case, we have to go from midx-bitmap-pos to midx-index-pos,
> to then get the pack/ofs combo, which then gives us a real "pos" in the
> pack. I don't think there's a faster way to do it (and this is still
> much faster than looking up objects in the pack only to check their
> revindex).
>
> But then with the result, we compare the offset of "pos" and "pos + 1".
> We need to know "pos" to find "pos + 1". But in the midx case, don't we
> already have the offset of "pos" (it is "offset" in the bitmap_is_midx()
> conditional, which is shadowing the completely unrelated "offset" in the
> outer loop).
>
> We could reuse it, saving ourselves an extra round-trip of pack_pos to
> index_pos to offset. It would just mean stuffing the "total +=" line
> into the two sides of the conditional.

Yep; agreed. And it allows us to clean up a few little other things, so
I squashed it in. Thanks for the suggestion!

> > +off_t bitmap_pack_offset(struct bitmap_index *bitmap_git, uint32_t pos)
> > +{
> > +	if (bitmap_is_midx(bitmap_git))
> > +		return nth_midxed_offset(bitmap_git->midx,
> > +					 pack_pos_to_midx(bitmap_git->midx, pos));
> > +	return nth_packed_object_offset(bitmap_git->pack,
> > +					pack_pos_to_index(bitmap_git->pack, pos));
> > +}
>
> Does anybody call this function? I don't see any users by the end of the
> series.

Nope, great catch. I looked at callers of nth_midxed_offset and
nth_packed_object_offset to see if they could use this function and
weren't, but the spots I looked at didn't appear to be able that they
would be helped by the existence of this helper, so I just removed it.

Phew! This was quite the email to respond to, but I suppose that's my
fault for writing such a monstrous patch. Thank you for taking the time
to read through it all so carefully. I think you got the short end of
the stick between writing this email and responding to it, so thank you
:-).

Thanks,
Taylor
