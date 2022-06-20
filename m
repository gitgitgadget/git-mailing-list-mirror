Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE3DC433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 22:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbiFTWQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 18:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiFTWQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 18:16:27 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DA218B1E
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 15:16:25 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 89so17909237qvc.0
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 15:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0+PWFAgnDWZeXzX2GJR+lSQ5BUAdakwt4P11IbNUFi4=;
        b=JzwloRxAW6jDu3OPtMyY2G3Dfm7Eln1TM2XAMPfVTZ+NzjYFogBNnLB5UgiESYkV4f
         l3KhqemmOvDpYzVT2ATxThFzFYi7C1NgFa0uQ3nlD2qCP0LMZsEyqMS1aZ/sPtdmVRi4
         3qLnCskW+DNOKG/UCwmgK2uilwY0X8LbQ14M4/25YZNhO84RfOrTQZRdJjoruNbnHt50
         pgcXzmeRHNc4iTyPtWNYrSt/i5p03dXV3bQT0UOttMRdsyGj2fJrOej/BZhqycH80b4T
         M89Yua4Jw1dKv/20ugqCAGREvyna3i92U7p9Vv5dMF+GDnMK1WJTUV4NQyRAZ+5UJiJr
         RzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0+PWFAgnDWZeXzX2GJR+lSQ5BUAdakwt4P11IbNUFi4=;
        b=g08FaamfNWV8E40jRWkzngo/SWz8op2As4Sq63pAp91IXFR2lNghEn4U0MF2ZZo/e/
         gD5GZ5YJFazSpfwnmhcJtBmryvYrwhUxwhdKCrzXe0EOnuoLGC7TGkTHNqUY6tNO5z/k
         vsGLJpcrzd2U+28Oo7cWR3JtPY60kPTJy+dkZutgtQlakA/Lxsq4ujvUF5x8pQ4nNWby
         ft2cTv7Ug2wyrrwyYlp+TXha9VZc4QgL/hJj+8BLjrjdB6mReeRNOA05LNSTseYS6Stv
         v4c3ED5xYPN/TnGjh2YJTZOVA1W9iTkAdnKTdQaEy5x6rBP2Iv2FW8AEzhpRMSNcIqgV
         4ekw==
X-Gm-Message-State: AJIora+TM4rEhrf/Samo2drtd1EvUEC1uaT2dqu3uQrDhS7kPvMEAR9l
        qo+ea/oT4nnDwJiFNwoE5fQzcA==
X-Google-Smtp-Source: AGRyM1ucTorwKCxJyGiFkKZOfSCQGa2wIBQeGehc6Nwh2jcxCWDme3T0f42yiAcqoCJU4klbUAIQkA==
X-Received: by 2002:ac8:7fc2:0:b0:304:f234:4597 with SMTP id b2-20020ac87fc2000000b00304f2344597mr21585823qtk.673.1655763385096;
        Mon, 20 Jun 2022 15:16:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m22-20020a05620a291600b006a370031c3esm13181624qkp.106.2022.06.20.15.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 15:16:24 -0700 (PDT)
Date:   Mon, 20 Jun 2022 18:16:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 3/6] pack-bitmap-write.c: write lookup table extension
Message-ID: <YrDxt1MkQKdNJL1F@nand.local>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <ed91ebf69a84405f16a4390e6fd208251b8ec53e.1655728395.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed91ebf69a84405f16a4390e6fd208251b8ec53e.1655728395.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 20, 2022 at 12:33:11PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> Teach git to write bitmap lookup table extension. The table has the
> following information:
>
>     - `N` no of Object ids of each bitmapped commits

s/no/number, s/Object/object, s/ids/IDs, and s/commits/commit

>     - A list of offset, xor-offset pair; the i'th pair denotes the
>       offsets and xor-offsets of i'th commit in the previous list.

s/pair/pairs

>     - 4-byte integer denoting the flags
>
> Co-authored-by: Taylor Blau <ttaylorr@github.com>
> Mentored-by: Taylor Blau <ttaylorr@github.com>
> Co-mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>  pack-bitmap-write.c | 59 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index c43375bd344..9e88a64dd65 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -650,7 +650,8 @@ static const struct object_id *oid_access(size_t pos, const void *table)
>
>  static void write_selected_commits_v1(struct hashfile *f,
>  				      struct pack_idx_entry **index,
> -				      uint32_t index_nr)
> +				      uint32_t index_nr,
> +				      off_t *offsets)
>  {
>  	int i;
>
> @@ -663,6 +664,9 @@ static void write_selected_commits_v1(struct hashfile *f,
>  		if (commit_pos < 0)
>  			BUG("trying to write commit not in index");
>
> +		if (offsets)
> +			offsets[i] = hashfile_total(f);
> +

Makes sense; we record the offset for the ith commit as however many
bytes we've already written into the hashfile up to this point, since
the subsequent byte will begin the bitmap (well, the preceding few
bytes of it, anyways) itself.

>  		hashwrite_be32(f, commit_pos);
>  		hashwrite_u8(f, stored->xor_offset);
>  		hashwrite_u8(f, stored->flags);
> @@ -671,6 +675,49 @@ static void write_selected_commits_v1(struct hashfile *f,
>  	}
>  }
>
> +static int table_cmp(const void *_va, const void *_vb)
> +{
> +	return oidcmp(&writer.selected[*(uint32_t*)_va].commit->object.oid,
> +		      &writer.selected[*(uint32_t*)_vb].commit->object.oid);

This implementation looks right to me, but perhaps we should expand it
out from the one-liner here to make it more readable. Perhaps something
like:

    static int table_cmp(const void *_va, const void *_vb)
    {
      struct commit *c1 = &writer.selected[*(uint32_t*)_va];
      struct commit *c2 = &writer.selected[*(uint32_t*)_vb];

      return oidcmp(&c1->object.oid, &c2->object.oid);
    }

which is arguably slightly more readable than the one-liner (but I don't
feel that strongly about it.)

> +static void write_lookup_table(struct hashfile *f,
> +			       off_t *offsets)
> +{
> +	uint32_t i;
> +	uint32_t flags = 0;
> +	uint32_t *table, *table_inv;
> +
> +	ALLOC_ARRAY(table, writer.selected_nr);
> +	ALLOC_ARRAY(table_inv, writer.selected_nr);
> +
> +	for (i = 0; i < writer.selected_nr; i++)
> +		table[i] = i;
> +	QSORT(table, writer.selected_nr, table_cmp);
> +	for (i = 0; i < writer.selected_nr; i++)
> +		table_inv[table[i]] = i;

Right... so table[0] will give us the index into writer.selected of the
commit with the earliest OID in lexicographic order. And table_inv goes
the other way around: table_inv[i] will tell us the lexicographic
position of the commit at writer.selected[i].

> +	for (i = 0; i < writer.selected_nr; i++) {
> +		struct bitmapped_commit *selected = &writer.selected[table[i]];
> +		struct object_id *oid = &selected->commit->object.oid;
> +
> +		hashwrite(f, oid->hash, the_hash_algo->rawsz);
> +	}
> +	for (i = 0; i < writer.selected_nr; i++) {
> +		struct bitmapped_commit *selected = &writer.selected[table[i]];
> +
> +		hashwrite_be32(f, offsets[table[i]]);
> +		hashwrite_be32(f, selected->xor_offset
> +			       ? table_inv[table[i] - selected->xor_offset]

...which we need to discover the position of the XOR'd bitmap. Though
I'm not sure if I remember why `table[i] - selected->xor_offset` is
right and not `i - selected->xor_offset`.

Thanks,
Taylor
