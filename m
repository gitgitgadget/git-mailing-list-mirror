Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADFCC433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 03:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769686117A
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 03:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbhDPDN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 23:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbhDPDNw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 23:13:52 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01F5C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 20:13:25 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id s5so18786849qkj.5
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 20:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FPmV0Be+F0bpw/pSTM1f/RLctlsktZsZp5eQrVZtuwQ=;
        b=fyVBZ0FS61wNjngElcuPkQrxYHdmACrj0j4LEXFxWlBhued/H8FbMl5HvWjflVOI3G
         sK09c5fS6nY115GJgTPwiWRsYSfu3AYec6geocMQCVk3lsezuct9PItqer2v3a1gDevq
         xZjlYUg92OgfxEbaSeVHwm2NxS0hEIH8VVVyCoCptqgSnHfGBk24/yX4/pxEVI7IDxDI
         Y+YuvlqTZghrVvqEMETZfm1N8XATqEY2H0Pf59DnZFh6/aNbg0SkXuCTtCMU8xfNRttV
         o76tASj/iomHhaJ1CcZJ0Kp3/I9kFksamG0bcvdahcgyfuWhfopB7Q2EH+mwKDM/P2vZ
         Zx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FPmV0Be+F0bpw/pSTM1f/RLctlsktZsZp5eQrVZtuwQ=;
        b=O4I1nN9C4M0gAG3IECUFKhqSNv+hgKF+wHiTCVocwJsHFzqgNUd1R4GmC94aD4cprU
         B8C+Sl0SKL4q6tonBMYcQeQdGvT4JN4l3aR2ABGAw1RaSBACKwxhbYNDNh8kT8YoBiSX
         HcY4IJ00zYW3z8658+DBEWLl6WBaJAHoFgwVeU4dQO32TMSS0SFXaqG6SaZ5dPG1AWyu
         2S6ipx9yP6NjjcXUXVi4NUfvSsu+vB894IIMQDxzS4s2P3gJcrvfYHMgLKIK/rSgk2hg
         R3xt+dHQzyhiyjEwahjBoBEXfWYBArNW9w2+sWZxd5C0XzW81INJE9lxUo2dClz92NwZ
         iKFA==
X-Gm-Message-State: AOAM533zq6sIspx59L7wLhbTRziON27DrFABhu7hr+Z0GYu07gTCUGkc
        n325nyvR29fYRh02ggmxEhQDZg==
X-Google-Smtp-Source: ABdhPJwcjtCdrbbsHSefV3fKRrANMLDazq1VrwiKF5o9+XV98iYqlORmt5yZbes0JIu0j5XZDjFO9A==
X-Received: by 2002:a37:6882:: with SMTP id d124mr6923864qkc.80.1618542804763;
        Thu, 15 Apr 2021 20:13:24 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1d44:1ab9:7b2b:a806])
        by smtp.gmail.com with ESMTPSA id o7sm3398281qkb.104.2021.04.15.20.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 20:13:24 -0700 (PDT)
Date:   Thu, 15 Apr 2021 23:13:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH 12/22] pack-bitmap: read multi-pack bitmaps
Message-ID: <YHkA0m8yZJ5lc/yo@nand.local>
References: <d5eeca4f112f70343b069fcb68fe61e26831843f.1617991824.git.me@ttaylorr.com>
 <20210416023925.16736-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210416023925.16736-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 15, 2021 at 07:39:25PM -0700, Jonathan Tan wrote:
> I'll review until this patch for now. Hopefully I'll get to the rest
> soon.

Thanks in advance. I always find that you leave insightful comments, so
I appreciate you taking the time to review my patches.

> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 5205dde2e1..a4e4e4ebcc 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -984,7 +984,17 @@ static void write_reused_pack(struct hashfile *f)
> >  				break;
> >
> >  			offset += ewah_bit_ctz64(word >> offset);
> > -			write_reused_pack_one(pos + offset, f, &w_curs);
> > +			if (bitmap_is_midx(bitmap_git)) {
> > +				off_t pack_offs = bitmap_pack_offset(bitmap_git,
> > +								     pos + offset);
> > +				uint32_t pos;
> > +
> > +				if (offset_to_pack_pos(reuse_packfile, pack_offs, &pos) < 0)
> > +					die(_("write_reused_pack: could not locate %"PRIdMAX),
> > +					    (intmax_t)pack_offs);
> > +				write_reused_pack_one(pos, f, &w_curs);
> > +			} else
> > +				write_reused_pack_one(pos + offset, f, &w_curs);
> >  			display_progress(progress_state, ++written);
> >  		}
> >  	}
>
> When bitmaps are used, pos + offset is the pseudo-pack (a virtual
> concatenation of all packfiles in the MIDX) position (as in, first
> object is 0, second object is 1, and so on), not a position in
> a single packfile. From it, we obtain a pack offset, and from it, we
> obtain a position in the reused packfile (reuse_packfile). In this way,
> the code is equivalent to the non-MIDX case. Looks good.
>
> (There is no need to select a packfile here in the case of MIDX because,
> as the code later shows, we always reuse only one packfile - assigned to
> reuse_packfile.)

You're exactly right here on both points.

It's worth noting that the "reuse" you're describing here is only about
reusing sections of the original packfile byte-for-byte (with the
exception of fixing the offsets in any OFS_DELTAs). That's not to be
confused with delta reuse, which is entirely different.

I think that both Peff and I are dubious that the pack-reuse stuff is
kicking in all that much, since there are some heuristics in place about
when it is allowed to take over and when it isn't, but that's a topic
for another thread.

> > @@ -35,8 +36,15 @@ struct stored_bitmap {
> >   * the active bitmap index is the largest one.
> >   */
> >  struct bitmap_index {
> > -	/* Packfile to which this bitmap index belongs to */
> > +	/*
> > +	 * The pack or multi-pack index (MIDX) that this bitmap index belongs
> > +	 * to.
> > +	 *
> > +	 * Exactly one of these must be non-NULL; this specifies the object
> > +	 * order used to interpret this bitmap.
> > +	 */
> >  	struct packed_git *pack;
> > +	struct multi_pack_index *midx;
>
> Makes sense.
>
> > @@ -71,6 +79,8 @@ struct bitmap_index {
> >  	/* If not NULL, this is a name-hash cache pointing into map. */
> >  	uint32_t *hashes;
> >
> > +	const unsigned char *checksum;
> > +
> >  	/*
> >  	 * Extended index.
> >  	 *
>
> I see later that this checksum is used, OK. Maybe comment that this
> points into map (just like "hashes", as quoted above).

Yep, quite fair.

> > +	if (bitmap_git->pack || bitmap_git->midx) {
> > +		/* ignore extra bitmap file; we can only handle one */
> > +		return -1;
>
> Here, fd is not closed? Maybe better to have multiple cleanup stages
> (one when the mmap has been built, and one when not).

Good eyes. That's an oversight, and we should be closing fd there, too.
It looks like we're also missing a warning(), although I am skeptical
that the warning would ever kick in. The pack-based version of this
function is run in a loop over all packs, but the loop doesn't terminate
once a pack bitmap is opened, since we make sure that no *other* packs
have bitmaps, too.

But we don't do the same for multi-pack bitmaps, i.e., once we find a
MIDX that has a bitmap, we terminate immediately. It may be worth
scanning through the list of all MIDXs to make sure that only one has a
bitmap, but to be honest I could go either way on that point, too, since
any MIDX bitmap is worth loading. But the warning doesn't hurt, so I'll
add that, too.

> > +	if (!is_pack_valid(packfile)) {
> > +		close(fd);
> > +		return -1;
> > +	}
>
> Why is this needed now (and presumably, not before)?

It does appear as a stray hunk, and I'm sure that it probably could be
extracted into its own patch. I can't recall anything about this
particular patch that makes it necessary, but maybe Peff remembers
something I don't.

> > @@ -1081,15 +1253,29 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
> >  			      struct bitmap *reuse,
> >  			      struct pack_window **w_curs)
> >  {
> > -	off_t offset, header;
> > +	struct packed_git *pack;
> > +	off_t offset, delta_obj_offset;
> >  	enum object_type type;
> >  	unsigned long size;
> >
> >  	if (pos >= bitmap_num_objects(bitmap_git))
> >  		return; /* not actually in the pack or MIDX */
> >
> > -	offset = header = pack_pos_to_offset(bitmap_git->pack, pos);
> > -	type = unpack_object_header(bitmap_git->pack, w_curs, &offset, &size);
> > +	if (bitmap_is_midx(bitmap_git)) {
> > +		uint32_t pack_id, midx_pos;
> > +
> > +		midx_pos = pack_pos_to_midx(bitmap_git->midx, pos);
> > +		pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
> > +
> > +		pack = bitmap_git->midx->packs[pack_id];
> > +		offset = nth_midxed_offset(bitmap_git->midx, midx_pos);
>
> Would it be useful to assert somewhere here that "pack" is the preferred
> pack?

An assertion like that may hurt this function's cache performance, since
the way we determine the preferred pack is by looking at which pack is
the donor for the 0th object in the MIDX's .rev file. And this function
is rather hot, since it is invoked once per-bit. So it may cause us to
hit more page faults than we currently do.

That all said, the assertion may not be helping much since we only call
this method on objects from a single pack (the bitmapped pack in the
single-pack case, or the preferred pack in the MIDX case). There's a
comment in reuse_partial_packfile_from_bitmap() to this effect, which
may or may not be good enough ;).

> Going further, is it reasonable to say that positions 0..n in the
> preferred pack (where n is the number of objects in the preferred pack)
> match positions 0..n in the pseudo-pack exactly? If yes, maybe we can
> simplify things by explaining that we can operate in the MIDX case
> exactly (or as similarly as possible) like we operate on a single
> packfile because of this, instead of always needing to consider if a
> delta base could appear in the MIDX as belonging to another packfile.

You're right, and there are two things going on here which allow us to
make that assumption:

  - The preferred pack sorts ahead of all other packs in the MIDX when
    assembling the pseudo-pack order, so bits 0..n (where 'n' is the
    number of objects in the preferred pack) of the pseudo pack are
    designated to the preferred pack.

  - When duplicates of objects exist, the MIDX *always* breaks ties in
    favor of the preferred pack, so it's never the case that a delta'd
    object from the preferred pack will find its base in another pack
    (if it asked the MIDX to locate a copy of the base object).

So we can safely remove the conditional on bitmap_is_midx() in the first
part of this function for exactly the reasons above, which is good. That
probably merits moving the comment beginning with "Note that the base
does not need to be repositioned ..." earlier in this function, to make
clear that we really can treat bits from the preferred pack as if they
don't have anything to do with the MIDX at all.

So long as we determine the preferred pack ahead of time (and not once
per-call), I think that it would be a win.

> > @@ -1538,6 +1792,29 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
> >
> >  			offset += ewah_bit_ctz64(word >> offset);
> >  			pos = base + offset;
> > +
> > +			if (bitmap_is_midx(bitmap_git)) {
> > +				uint32_t pack_pos;
> > +				uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, pos);
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
> > +			} else
> > +				pack = bitmap_git->pack;
> > +
> >  			total += pack_pos_to_offset(pack, pos + 1) -
> >  				 pack_pos_to_offset(pack, pos);
> >  		}
>
> "pos" is assigned to twice in the MIDX case (with different semantics).
> I think it's better to do it like in the rest of the patch - use "base +
> offset" as the argument to pack_pos_to_midx, and then you wouldn't need
> to assign to "pos" twice.

Good idea, thanks. Skimming again over the patch, this is the only place
that I could find where I double-assign pos like this.

> > diff --git a/packfile.c b/packfile.c
> > index 8668345d93..c444e365a3 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -863,7 +863,7 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
> >  	if (!strcmp(file_name, "multi-pack-index"))
> >  		return;
> >  	if (starts_with(file_name, "multi-pack-index") &&
> > -	    ends_with(file_name, ".rev"))
> > +	    (ends_with(file_name, ".bitmap") || ends_with(file_name, ".rev")))
> >  		return;
> >  	if (ends_with(file_name, ".idx") ||
> >  	    ends_with(file_name, ".rev") ||
>
> I guess this will come into play when we start writing MIDX bitmaps?

Yep, that's right. Since this patch is about making sure we can handle
the MIDX bitmap as described in
Documentation/technical/bitmap-format.txt, this is part of that.

Thanks,
Taylor
