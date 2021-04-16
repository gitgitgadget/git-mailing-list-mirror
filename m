Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45B3C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 02:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761FA610A1
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 02:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhDPCj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 22:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbhDPCjy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 22:39:54 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B59C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 19:39:30 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 142so2868206qkj.1
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 19:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GCzFzcAYOI6RM3PBPvfdXjERA8BZt4qX7nuEnRiK5l4=;
        b=qkyz0tar6Iq+ERrAXORjUsJ6+G+ImeHbYOumsOETSYo2cMhwPmx0ysasrK9epDk1fp
         vF8wGhRxSfhfAw6sXvDmD9T8lnDYy51CMJyJPtdavLT9NsMBdWJXRziSvMCmzM4aDJ67
         T05EJ3BxpfrLA1UTlVyPHGS5hWU/XgBaHBklrDNHFNmlCd5/OOX3WMkefZfsUROcP9NZ
         mgX5xfojdQ1tEphDNlpDcd1T0K2l5fRpBahrQQfQ1IdHF3T5OBBuwvE9lmup9vXT2EKj
         +Mn0n58BLhHAYAyB9q2xqWOEfPQ6lR5AXRu0dKMIGQFAL8VrBDWyJeyK8jV0re2UR+aY
         kokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GCzFzcAYOI6RM3PBPvfdXjERA8BZt4qX7nuEnRiK5l4=;
        b=T0ZLMcvN/1GQIEwszUlEaw6+PJeVcEh0AWDW0zXkREXuDC4qr3bVcKjCZMv7hG0MVl
         hWKTGBn5VPymTooD75DjQvSlYGeEAL7d7GLcn1qylKpW2qvqlAJpxTRvJRsR2YgcyNgS
         bgaH6oJ4Fnl6005sVnyYeHyH9nnHMxDEU9XqTXVKTJfe5PyMBryCrFWIxou/pUXFtIc7
         AprNar2YS34YxAvc4gSNwPyQaj6NvlCwJDIPWBOXJDjqZu4VuGXaPgKVA5xIhn10Nhvi
         Z4TJUoQgkUs+S5SKkjowD4M65bwKtnnwYuoh7mfAO320pm49ooOgPN5RyBtx6bbVeCk5
         mqIA==
X-Gm-Message-State: AOAM5304ztYG9h+ndkj0mOhowUYTg5Nae6bkw7ANp+sBx4hWxPBxakc6
        Fw80yxfQEs0zHT2h/HNlnBUITmdKUh2shThw9Iw4
X-Google-Smtp-Source: ABdhPJwF4EGJTlgJbUZQhg6n4Fc1U4JuPfAkM7dJewUWWb/c9RTcXr0BB5CFCC8ERBO4r9FQjn9HbxLGs4DCcTec+dmV
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:fa8e:: with SMTP id
 o14mr6482440qvn.45.1618540769673; Thu, 15 Apr 2021 19:39:29 -0700 (PDT)
Date:   Thu, 15 Apr 2021 19:39:25 -0700
In-Reply-To: <d5eeca4f112f70343b069fcb68fe61e26831843f.1617991824.git.me@ttaylorr.com>
Message-Id: <20210416023925.16736-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <d5eeca4f112f70343b069fcb68fe61e26831843f.1617991824.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: Re: [PATCH 12/22] pack-bitmap: read multi-pack bitmaps
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll review until this patch for now. Hopefully I'll get to the rest
soon.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 5205dde2e1..a4e4e4ebcc 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -984,7 +984,17 @@ static void write_reused_pack(struct hashfile *f)
>  				break;
>  
>  			offset += ewah_bit_ctz64(word >> offset);
> -			write_reused_pack_one(pos + offset, f, &w_curs);
> +			if (bitmap_is_midx(bitmap_git)) {
> +				off_t pack_offs = bitmap_pack_offset(bitmap_git,
> +								     pos + offset);
> +				uint32_t pos;
> +
> +				if (offset_to_pack_pos(reuse_packfile, pack_offs, &pos) < 0)
> +					die(_("write_reused_pack: could not locate %"PRIdMAX),
> +					    (intmax_t)pack_offs);
> +				write_reused_pack_one(pos, f, &w_curs);
> +			} else
> +				write_reused_pack_one(pos + offset, f, &w_curs);
>  			display_progress(progress_state, ++written);
>  		}
>  	}

When bitmaps are used, pos + offset is the pseudo-pack (a virtual
concatenation of all packfiles in the MIDX) position (as in, first
object is 0, second object is 1, and so on), not a position in
a single packfile. From it, we obtain a pack offset, and from it, we
obtain a position in the reused packfile (reuse_packfile). In this way,
the code is equivalent to the non-MIDX case. Looks good.

(There is no need to select a packfile here in the case of MIDX because,
as the code later shows, we always reuse only one packfile - assigned to
reuse_packfile.)

> @@ -35,8 +36,15 @@ struct stored_bitmap {
>   * the active bitmap index is the largest one.
>   */
>  struct bitmap_index {
> -	/* Packfile to which this bitmap index belongs to */
> +	/*
> +	 * The pack or multi-pack index (MIDX) that this bitmap index belongs
> +	 * to.
> +	 *
> +	 * Exactly one of these must be non-NULL; this specifies the object
> +	 * order used to interpret this bitmap.
> +	 */
>  	struct packed_git *pack;
> +	struct multi_pack_index *midx;

Makes sense.

> @@ -71,6 +79,8 @@ struct bitmap_index {
>  	/* If not NULL, this is a name-hash cache pointing into map. */
>  	uint32_t *hashes;
>  
> +	const unsigned char *checksum;
> +
>  	/*
>  	 * Extended index.
>  	 *

I see later that this checksum is used, OK. Maybe comment that this
points into map (just like "hashes", as quoted above).

> @@ -281,6 +304,54 @@ static char *pack_bitmap_filename(struct packed_git *p)
>  	return xstrfmt("%.*s.bitmap", (int)len, p->pack_name);
>  }
>  
> +static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
> +			      struct multi_pack_index *midx)
> +{
> +	struct stat st;
> +	char *idx_name = midx_bitmap_filename(midx);
> +	int fd = git_open(idx_name);
> +
> +	free(idx_name);
> +
> +	if (fd < 0)
> +		return -1;
> +
> +	if (fstat(fd, &st)) {
> +		close(fd);
> +		return -1;
> +	}
> +
> +	if (bitmap_git->pack || bitmap_git->midx) {
> +		/* ignore extra bitmap file; we can only handle one */
> +		return -1;

Here, fd is not closed? Maybe better to have multiple cleanup stages
(one when the mmap has been built, and one when not).

> @@ -302,12 +373,18 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
>  		return -1;
>  	}
>  
> -	if (bitmap_git->pack) {
> +	if (bitmap_git->pack || bitmap_git->midx) {
> +		/* ignore extra bitmap file; we can only handle one */
>  		warning("ignoring extra bitmap file: %s", packfile->pack_name);
>  		close(fd);
>  		return -1;
>  	}
>  
> +	if (!is_pack_valid(packfile)) {
> +		close(fd);
> +		return -1;
> +	}

Why is this needed now (and presumably, not before)?

> -static int load_pack_bitmap(struct bitmap_index *bitmap_git)
> +static int load_reverse_index(struct bitmap_index *bitmap_git)
> +{
> +	if (bitmap_is_midx(bitmap_git)) {
> +		uint32_t i;
> +		int ret;
> +
> +		ret = load_midx_revindex(bitmap_git->midx);
> +		if (ret)
> +			return ret;
> +
> +		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
> +			if (prepare_midx_pack(the_repository, bitmap_git->midx, i))
> +				die(_("load_reverse_index: could not open pack"));
> +			ret = load_pack_revindex(bitmap_git->midx->packs[i]);

I was thinking about why we still need per-pack revindex, but I think
the answer is that we still need to convert pack offsets (roughly
speaking, 0 to size of packfile in bytes) to pack positions (0 to number
of objects) (and one such conversion is in the quoted section of
builtin/pack-objects.c above), and MIDX does not provide this. OK, makes
sense.

> +			if (ret)
> +				return ret;
> +		}
> +		return 0;
> +	}
> +	return load_pack_revindex(bitmap_git->pack);
> +}

[snip]

> @@ -428,10 +552,26 @@ static inline int bitmap_position_packfile(struct bitmap_index *bitmap_git,
>  	return pos;
>  }
>  
> +static int bitmap_position_midx(struct bitmap_index *bitmap_git,
> +				const struct object_id *oid)
> +{
> +	uint32_t want, got;
> +	if (!bsearch_midx(oid, bitmap_git->midx, &want))
> +		return -1;
> +
> +	if (midx_to_pack_pos(bitmap_git->midx, want, &got) < 0)
> +		return -1;
> +	return got;
> +}

bsearch_midx() gives us the position in the MIDX (e.g. if we had an
object with the name 00...00, "want" will be 0, and if we had an
object with the name ff...ff, "want" will be the number of objects
minus 1). midx_to_pack_pos() converts that into the position in the
pseudo-pack, which is what we want. OK.

> @@ -730,14 +871,28 @@ static void show_objects_for_type(
>  
>  			offset += ewah_bit_ctz64(word >> offset);
>  
> -			index_pos = pack_pos_to_index(bitmap_git->pack, pos + offset);
> -			ofs = pack_pos_to_offset(bitmap_git->pack, pos + offset);
> -			nth_packed_object_id(&oid, bitmap_git->pack, index_pos);
> +			if (bitmap_is_midx(bitmap_git)) {
> +				struct multi_pack_index *m = bitmap_git->midx;
> +				uint32_t pack_id;
> +
> +				index_pos = pack_pos_to_midx(m, pos + offset);
> +				ofs = nth_midxed_offset(m, index_pos);
> +				nth_midxed_object_oid(&oid, m, index_pos);
> +
> +				pack_id = nth_midxed_pack_int_id(m, index_pos);
> +				pack = bitmap_git->midx->packs[pack_id];

This is similar to the builtin/pack-objects.c case right at the start of
this patch. (bitmap_pack_offset(), used in builtin/pack-objects.c, is
pack_pos_to_midx() and nth_midx_offset() chained.) OK.

> +			} else {
> +				index_pos = pack_pos_to_index(bitmap_git->pack, pos + offset);
> +				ofs = pack_pos_to_offset(bitmap_git->pack, pos + offset);
> +				nth_bitmap_object_oid(bitmap_git, &oid, index_pos);
> +
> +				pack = bitmap_git->pack;
> +			}
>  
>  			if (bitmap_git->hashes)
>  				hash = get_be32(bitmap_git->hashes + index_pos);
>  
> -			show_reach(&oid, object_type, 0, hash, bitmap_git->pack, ofs);
> +			show_reach(&oid, object_type, 0, hash, pack, ofs);
>  		}
>  	}
>  }
> @@ -749,8 +904,13 @@ static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
>  		struct object *object = roots->item;
>  		roots = roots->next;
>  
> -		if (find_pack_entry_one(object->oid.hash, bitmap_git->pack) > 0)
> -			return 1;
> +		if (bitmap_is_midx(bitmap_git)) {
> +			if (bsearch_midx(&object->oid, bitmap_git->midx, NULL))
> +				return 1;
> +		} else {
> +			if (find_pack_entry_one(object->oid.hash, bitmap_git->pack) > 0)
> +				return 1;
> +		}
>  	}
>  
>  	return 0;

OK - we don't actually care about the position, just that it exists,
which is why we can pass NULL as the last argument to bsearch_midx().

> @@ -839,14 +999,26 @@ static void filter_bitmap_blob_none(struct bitmap_index *bitmap_git,
>  static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
>  				     uint32_t pos)
>  {
> -	struct packed_git *pack = bitmap_git->pack;
>  	unsigned long size;
>  	struct object_info oi = OBJECT_INFO_INIT;
>  
>  	oi.sizep = &size;
>  
>  	if (pos < bitmap_num_objects(bitmap_git)) {
> -		off_t ofs = pack_pos_to_offset(pack, pos);
> +		struct packed_git *pack;
> +		off_t ofs;
> +
> +		if (bitmap_is_midx(bitmap_git)) {
> +			uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, pos);
> +			uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
> +
> +			pack = bitmap_git->midx->packs[pack_id];
> +			ofs = nth_midxed_offset(bitmap_git->midx, midx_pos);
> +		} else {
> +			pack = bitmap_git->pack;
> +			ofs = pack_pos_to_offset(pack, pos);
> +		}
> +
>  		if (packed_object_info(the_repository, pack, ofs, &oi) < 0) {
>  			struct object_id oid;
>  			nth_bitmap_object_oid(bitmap_git, &oid,

Makes sense - "pos" is the position in the pseudo-pack. From it we get
the MIDX position, and then we can get the pack ID and pack offset as
usual.

> @@ -1081,15 +1253,29 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
>  			      struct bitmap *reuse,
>  			      struct pack_window **w_curs)
>  {
> -	off_t offset, header;
> +	struct packed_git *pack;
> +	off_t offset, delta_obj_offset;
>  	enum object_type type;
>  	unsigned long size;
>  
>  	if (pos >= bitmap_num_objects(bitmap_git))
>  		return; /* not actually in the pack or MIDX */
>  
> -	offset = header = pack_pos_to_offset(bitmap_git->pack, pos);
> -	type = unpack_object_header(bitmap_git->pack, w_curs, &offset, &size);
> +	if (bitmap_is_midx(bitmap_git)) {
> +		uint32_t pack_id, midx_pos;
> +
> +		midx_pos = pack_pos_to_midx(bitmap_git->midx, pos);
> +		pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
> +
> +		pack = bitmap_git->midx->packs[pack_id];
> +		offset = nth_midxed_offset(bitmap_git->midx, midx_pos);

Would it be useful to assert somewhere here that "pack" is the preferred
pack?

Going further, is it reasonable to say that positions 0..n in the
preferred pack (where n is the number of objects in the preferred pack)
match positions 0..n in the pseudo-pack exactly? If yes, maybe we can
simplify things by explaining that we can operate in the MIDX case
exactly (or as similarly as possible) like we operate on a single
packfile because of this, instead of always needing to consider if a
delta base could appear in the MIDX as belonging to another packfile.

> @@ -1538,6 +1792,29 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
>  
>  			offset += ewah_bit_ctz64(word >> offset);
>  			pos = base + offset;
> +
> +			if (bitmap_is_midx(bitmap_git)) {
> +				uint32_t pack_pos;
> +				uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, pos);
> +				uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
> +				off_t offset = nth_midxed_offset(bitmap_git->midx, midx_pos);
> +
> +				pack = bitmap_git->midx->packs[pack_id];
> +
> +				if (offset_to_pack_pos(pack, offset, &pack_pos) < 0) {
> +					struct object_id oid;
> +					nth_midxed_object_oid(&oid, bitmap_git->midx, midx_pos);
> +
> +					die(_("could not find %s in pack #%"PRIu32" at offset %"PRIuMAX),
> +					    oid_to_hex(&oid),
> +					    pack_id,
> +					    (uintmax_t)offset);
> +				}
> +
> +				pos = pack_pos;
> +			} else
> +				pack = bitmap_git->pack;
> +
>  			total += pack_pos_to_offset(pack, pos + 1) -
>  				 pack_pos_to_offset(pack, pos);
>  		}

"pos" is assigned to twice in the MIDX case (with different semantics).
I think it's better to do it like in the rest of the patch - use "base +
offset" as the argument to pack_pos_to_midx, and then you wouldn't need
to assign to "pos" twice.

> diff --git a/packfile.c b/packfile.c
> index 8668345d93..c444e365a3 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -863,7 +863,7 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
>  	if (!strcmp(file_name, "multi-pack-index"))
>  		return;
>  	if (starts_with(file_name, "multi-pack-index") &&
> -	    ends_with(file_name, ".rev"))
> +	    (ends_with(file_name, ".bitmap") || ends_with(file_name, ".rev")))
>  		return;
>  	if (ends_with(file_name, ".idx") ||
>  	    ends_with(file_name, ".rev") ||

I guess this will come into play when we start writing MIDX bitmaps?
