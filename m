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
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C741F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 00:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfJJX77 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 19:59:59 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:45832 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfJJX77 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 19:59:59 -0400
Received: by mail-vk1-f201.google.com with SMTP id q84so2787303vkb.12
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 16:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EUzrvPJhy/M9DVr44zt1/VlWBlxf6299V5s1WsQ+4Yw=;
        b=lwy8ZGMHOaqFNdbLYldlhnmQ1xeXoxB8XeTDjdiYznNIju8/xyjw5dGwPxUToUj0dJ
         Rhh4bEDsyPbzsNoFyKaWBwZygF56Cvu1F1ynAclJCDv8fvPFNH9mwu8RB9jnPYl0hEii
         Qnug8VihtTVwwc9XSyHviFNeH0iBDtfRjgWYtBE3gcSwwP/Vd1xEtKTOQ9she7jxogLI
         5OaPDgpR/zXWK1QJ8iVIklcPuGO1ZSQzV4BTbg6wTh6nP3/C/yHZgLB5GMBDAnmxDTmR
         lyWeHkUcX6a3JYGt8eTz/mP6lvot2rXOOfxpf3l7UzBtovgrL/hewAds73LVL/1eugNA
         a2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EUzrvPJhy/M9DVr44zt1/VlWBlxf6299V5s1WsQ+4Yw=;
        b=F3XFOx/dZUDUoUljgGcNRP4k0rK0u1lNuZS3R6usVMRViqCKrQaexoKmQQzcA6Pdic
         8ugxzdrJu7i7swc2dz62pXRhe5l13mSsxG7dDGE28srAIVZxlCMHHB6r5UsUY+FPtc42
         yk9ZfKJqID5NVvFIB3/MQ2Yvyun0Onm7RAA24EO38yF7xHp+L5CN317tSD52MjzwGZs+
         bwlKUiXF9EcM8wvGRZf6LSYgeZ2y7eBp1ivS75vzTkr6YSG5biDSytl7V98zuN3mFNRR
         zpChZvrpaxzH2L+0FkQv3su4xWU592ZoXUqjHZ/eaBfyP1eQUL2+GXMnLbHUa86jeegY
         IHWg==
X-Gm-Message-State: APjAAAU1C3I0WC0KgKyIsaS9ODC4r9gWFgY1BAIcC4MfV8sOLV8H9kNe
        MLhQY3NXiIN2amLwma4WzQM/D7ueVL+LixcPbLli
X-Google-Smtp-Source: APXvYqyrOElxFRCLtWsn5RezCIfYYkEoJ0dPiR4BdQQ+BnnjsHBiCNVS1l8lu/qYB0/BfOmxlYp+U21e9DkkBjOjO1+U
X-Received: by 2002:a05:6102:20cf:: with SMTP id i15mr976613vsr.124.1570751997616;
 Thu, 10 Oct 2019 16:59:57 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:59:52 -0700
In-Reply-To: <20190913130226.7449-11-chriscool@tuxfamily.org>
Message-Id: <20191010235952.174426-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190913130226.7449-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: Re: [RFC PATCH 10/10] pack-objects: improve partial packfile reuse
From:   Jonathan Tan <jonathantanmy@google.com>
To:     christian.couder@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        chriscool@tuxfamily.org, ramsay@ramsayjones.plus.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm going to start with pack-bitmap.h, then builtin/pack-objects.c.

>  int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
>  				       struct packed_git **packfile,
> -				       uint32_t *entries, off_t *up_to);
> +				       uint32_t *entries,
> +				       struct bitmap **bitmap);

Makes sense. The existing code determines if the given packfile is
suitable, and if yes, the span of the packfile to use. With this patch,
we resolve to use the given packfile, and want to compute which objects
to use, storing the computation result in an uncompressed bitmap.
(Resolving to use the given packfile is not that much different from
existing behavior, as far as I know, since we currently only consider
one packfile at most anyway.)

So replacing the out param makes sense, although a more descriptive name
than "bitmap" would be nice.

Skipping pack-bitmaps.c for now.

OK, builtin/pack-objects.c.

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

This makes sense - offsets may be different when we omit objects from
the packfile. I think this can be computed by calculating the number of
zero bits between the current object's index and the nth object prior
(where n is the offset) in the bitmap resulting from
reuse_partial_packfile_from_bitmap() above, thus eliminating the need
for this array, but I haven't tested it.

> +static void write_reused_pack_one(size_t pos, struct hashfile *out,
> +				  struct pack_window **w_curs)
> +{
> +	off_t offset, next, cur;
> +	enum object_type type;
> +	unsigned long size;
>  
> +	offset = reuse_packfile->revindex[pos].offset;
> +	next = reuse_packfile->revindex[pos + 1].offset;
>  
> +	record_reused_object(offset, offset - hashfile_total(out));
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
> +		if (fixup) {
> +			unsigned char ofs_header[10];
> +			unsigned i, ofs_len;
> +			off_t ofs = offset - base_offset - fixup;
> +
> +			len = encode_in_pack_object_header(header, sizeof(header),
> +							   OBJ_OFS_DELTA, size);
> +
> +			i = sizeof(ofs_header) - 1;
> +			ofs_header[i] = ofs & 127;
> +			while (ofs >>= 7)
> +				ofs_header[--i] = 128 | (--ofs & 127);
> +
> +			ofs_len = sizeof(ofs_header) - i;
> +
> +			if (0) {
> +				off_t expected_size = cur - offset;
> +
> +				if (len + ofs_len < expected_size) {
> +					unsigned max_pad = (len >= 4) ? 9 : 5;
> +					header[len - 1] |= 0x80;
> +					while (len < max_pad && len + ofs_len < expected_size)
> +						header[len++] = 0x80;
> +					header[len - 1] &= 0x7F;
> +				}
> +			}

This if(0) should be deleted.

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

I didn't look into detail, but this looks like it's writing a single
object. In particular, it can convert OFS into REF, something that the
existing code cannot do.

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
> +		hashflush(out);
> +		copy_pack_data(out, reuse_packfile, w_curs,
> +			sizeof(struct pack_header), to_write);
>  
>  		display_progress(progress_state, written);
>  	}
> +	return pos;
> +}

I presume this optimization is needed for the case where we are using
*all* objects of a packfile, as is typical during a clone.

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

I didn't look into detail, but it looks like a straightforward loop.

> @@ -1002,6 +1132,10 @@ static int have_duplicate_entry(const struct object_id *oid,
>  {
>  	struct object_entry *entry;
>  
> +	if (reuse_packfile_bitmap &&
> +	    bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid))
> +		return 1;

Hmm...why did we previously not need to check the reuse information, but
we do now? I gave the code a cursory glance but couldn't find the
answer.

> @@ -2571,7 +2706,9 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
>  
>  static int obj_is_packed(const struct object_id *oid)
>  {
> -	return !!packlist_find(&to_pack, oid, NULL);
> +	return packlist_find(&to_pack, oid, NULL) ||
> +		(reuse_packfile_bitmap &&
> +		 bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));

Same question here - why do we need to check the reuse information?

> @@ -3061,7 +3199,6 @@ static void loosen_unused_packed_objects(void)
>  static int pack_options_allow_reuse(void)
>  {
>  	return pack_to_stdout &&
> -	       allow_ofs_delta &&
>  	       !ignore_packed_keep_on_disk &&
>  	       !ignore_packed_keep_in_core &&
>  	       (!local || !have_non_local_packs) &&

Relaxing of the allow_ofs_delta condition - makes sense given (as above)
we can convert OFS to REF.

Overall I think that this makes sense, except for my unanswered
questions (and the presence of reused_chunk).
