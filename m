Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D847C43334
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 00:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbiGZAw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 20:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiGZAw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 20:52:58 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BB727164
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 17:52:57 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c20so9507644qtw.8
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 17:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hg2y0TYAjJoEGKdANPvYKfZe7s9qB0gU8Z5snr01hHk=;
        b=LCbCfWM1PS0JY3ww1QfteDvfGLJuanp0YrN1MCX8l4//OoE/oLev5gMuRIGQeYtWt7
         hEiJf3rUmK+s1QvdAbdprFOoWYP65ObUFL6+4S+9jY7tWoKu6fU7G8luTwrvHp4KRF6A
         RFC4TWv3MlRDZC/0kk0YAXxShHgSmfRl4ONOHpuv6p32uIDjkEeZm3sq4tIdfbxX/u+b
         H0afjnOPAz37TluXRsBBE8hA41Y24KgtGiqYzr+sZGWEieGdYtYxkq/YmpO6pAiuHWFJ
         5e0JMmvnjp89s5SPfxOjuoZlebtwpp/atGEhjS1oeSwsetUtNc/HuDBFNC+cmliVLkvv
         rXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hg2y0TYAjJoEGKdANPvYKfZe7s9qB0gU8Z5snr01hHk=;
        b=fiOBTCX9Mm53/Fnx/2I1H0yFASIPS/xrmJVmITJNbY48HhtQO/r+2cJfF4K04OqHHP
         DXTcFvHtytc0o7uYSWC3pYRcipk991ZUK67AB0XH1c1tnaAfU8hv4bDhU1Xi7xf72/Ac
         M4Mhb/qmWWeIe3TWrkhhtBs5BY5V4GUFHF3bSXWHQ1er1yFc4TIUd+4dAvIcQfW8BJ/O
         TMZziHxtLDYfWPwKRru2dwc4Zuspqb6vTy6YsSi+ZJgF6RU8vKuv463xwL7svHe7grpC
         BbQqRwznL6+ydBJyYNuAbXxejnBvmD2+q+rf5Uj+y1ojjI8RgxXNKnHl3IAQSfaAZRUN
         FLQg==
X-Gm-Message-State: AJIora9bVjN7EjrB/VAeuxHc2X/7TlLuyuUJIZiJHkxWxEiDsetqa91i
        jgXGGr4IBhygBGIj8wsU0bt4FA==
X-Google-Smtp-Source: AGRyM1u+ZAE5bjaLAXuv+XaF82enyj9Ax9kJlcWVcvuRgYwbrgtac8psD44sEL/+7Sbx0+KbHbZKEA==
X-Received: by 2002:a05:622a:46:b0:31e:f7b2:fff2 with SMTP id y6-20020a05622a004600b0031ef7b2fff2mr12367759qtw.613.1658796776493;
        Mon, 25 Jul 2022 17:52:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u22-20020a05620a431600b006af147d4876sm10363140qko.30.2022.07.25.17.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 17:52:56 -0700 (PDT)
Date:   Mon, 25 Jul 2022 20:52:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v5 2/6] pack-bitmap-write.c: write lookup table extension
Message-ID: <Yt8650eWLfm5VlLe@nand.local>
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
 <a913e6a2cb36d8ec7900b60820d8ab3c35f60164.1658342304.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a913e6a2cb36d8ec7900b60820d8ab3c35f60164.1658342304.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 20, 2022 at 06:38:20PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> The bitmap lookup table extension was documented by an earlier
> change, but Git does not yet know how to write that extension.
>
> Teach Git to write bitmap lookup table extension. The table contains
> the list of `N` <commit_pos, offset, xor_row>` triplets. These
> triplets are sorted according to their commit pos (ascending order).
> The meaning of each data in the i'th triplet is given below:
>
>   - commit_pos stores commit position (in the pack-index or midx).
>     It is a 4 byte network byte order unsigned integer.
>
>   - offset is the position (in the bitmap file) from which that
>     commit's bitmap can be read.
>
>   - xor_row is the position of the triplet in the lookup table
>     whose bitmap is used to compress this bitmap, or `0xffffffff`
>     if no such bitmap exists.
>
> Mentored-by: Taylor Blau <me@ttaylorr.com>
> Co-mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Co-authored-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>  pack-bitmap-write.c | 112 ++++++++++++++++++++++++++++++++++++++++----
>  pack-bitmap.h       |   5 +-
>  2 files changed, 107 insertions(+), 10 deletions(-)
>
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index c43375bd344..9843790cb60 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -650,20 +650,19 @@ static const struct object_id *oid_access(size_t pos, const void *table)
>
>  static void write_selected_commits_v1(struct hashfile *f,
>  				      struct pack_idx_entry **index,
> -				      uint32_t index_nr)
> +				      uint32_t index_nr,
> +				      off_t *offsets,
> +				      uint32_t *commit_positions)
>  {
>  	int i;
>
>  	for (i = 0; i < writer.selected_nr; ++i) {
>  		struct bitmapped_commit *stored = &writer.selected[i];
>
> -		int commit_pos =
> -			oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
> +		if (offsets)
> +			offsets[i] = hashfile_total(f);
>
> -		if (commit_pos < 0)
> -			BUG("trying to write commit not in index");
> -
> -		hashwrite_be32(f, commit_pos);
> +		hashwrite_be32(f, commit_positions[i]);

I wonder if it would make this patch a little more readable to construct
and use the commit_positions array as a single preparatory step before
this commit.

What do you think?

> +static void write_lookup_table(struct hashfile *f,
> +			       struct pack_idx_entry **index,
> +			       uint32_t index_nr,
> +			       off_t *offsets,
> +			       uint32_t *commit_positions)
> +{
> +	uint32_t i;
> +	uint32_t *table, *table_inv;
> +
> +	ALLOC_ARRAY(table, writer.selected_nr);
> +	ALLOC_ARRAY(table_inv, writer.selected_nr);
> +
> +	for (i = 0; i < writer.selected_nr; i++)
> +		table[i] = i;
> +
> +	/*
> +	 * At the end of this sort table[j] = i means that the i'th
> +	 * bitmap corresponds to j'th bitmapped commit (among the selected
> +	 * commits) in lex order of OIDs.
> +	 */
> +	QSORT_S(table, writer.selected_nr, table_cmp, commit_positions);
> +
> +	/* table_inv helps us discover that relationship (i'th bitmap
> +	 * to j'th commit by j = table_inv[i])
> +	 */
> +	for (i = 0; i < writer.selected_nr; i++)
> +		table_inv[table[i]] = i;
> +
> +	trace2_region_enter("pack-bitmap-write", "writing_lookup_table", the_repository);
> +	for (i = 0; i < writer.selected_nr; i++) {
> +		struct bitmapped_commit *selected = &writer.selected[table[i]];
> +		uint32_t xor_offset = selected->xor_offset;
> +		uint32_t xor_row;
> +
> +		if (xor_offset) {
> +			/*
> +			 * xor_index stores the index (in the bitmap entries)
> +			 * of the corresponding xor bitmap. But we need to convert
> +			 * this index into lookup table's index. So, table_inv[xor_index]
> +			 * gives us the index position w.r.t. the lookup table.
> +			 *
> +			 * If "k = table[i] - xor_offset" then the xor base is the k'th
> +			 * bitmap. `table_inv[k]` gives us the position of that bitmap
> +			 * in the lookup table.
> +			 */
> +			uint32_t xor_index = table[i] - xor_offset;
> +			xor_row = table_inv[xor_index];
> +		} else {
> +			xor_row = 0xffffffff;
> +		}
> +
> +		hashwrite_be32(f, commit_positions[table[i]]);
> +		hashwrite_be64(f, (uint64_t)offsets[table[i]]);
> +		hashwrite_be32(f, xor_row);
> +	}
> +	trace2_region_leave("pack-bitmap-write", "writing_lookup_table", the_repository);
> +
> +	free(table);
> +	free(table_inv);
> +}


> @@ -715,7 +791,25 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
>  	dump_bitmap(f, writer.trees);
>  	dump_bitmap(f, writer.blobs);
>  	dump_bitmap(f, writer.tags);
> -	write_selected_commits_v1(f, index, index_nr);
> +
> +	ALLOC_ARRAY(commit_positions, writer.selected_nr);
> +	for (uint32_t i = 0; i < writer.selected_nr; ++i) {

Nit; we don't typically write for-loop expressions with variable
declarations inside of them. Make sure to declare i outside of the loop,
and then this becomes:

    for (i = 0; i < writer.selected_nr; i++)

(also, we typically use the postfix ++ operator, that is "i++" instead
of "++i" unless there is a reason to prefer the latter over the former).

Thanks,
Taylor
