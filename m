Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13948C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 02:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241054AbiGOCWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 22:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiGOCWv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 22:22:51 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1E33B965
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:22:50 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o26so2650049qkl.6
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bmocDPyXH1uvCOnzg6uKTSdO18ZG/XsVTKn8aKXjNOM=;
        b=NawyN7OkiElqE1ZtC9uzRZNbLm6zqXZDIHbbYG+6dajzbn1UDdT+OKvZh3QaIXRE3a
         VnK6/P0BreuAJKDOGOzBWBrzd0o8pALG1qs1xSV/BQ4Gt86+zIuQsXh3rHZsjNnBlMzg
         zxFPisqvtSeGgr1xQa42xVR4ic/K7yiTbTUl70y9vTHHPLf/Da/1U6Gdu3ABhm8Me2OA
         yHwbEsI3YKL6g++bvOKTpP4TYnfR+GImbZ/6jAhTK4gr+MItQTVnc2Dyw5Q0fBN7wJ4q
         ZCmmSYhn5fMCoVVI0HL6cuNN6LTJ5DiAkGrvXlkx0LLT9tQAKi1d84l82cb8oov99dBm
         Oh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bmocDPyXH1uvCOnzg6uKTSdO18ZG/XsVTKn8aKXjNOM=;
        b=EKsOsN2GzHk1sS4fkYiE2ptpGLL2vLqwKZdpZDmRHM5QvrcN/yiB2hftgCV8uwRoua
         c0tBaRLEWKBtk1+3qXaad9uar9i83ANSscThxggi+rFaNKX2ZeKfuswfh2nlaopyo2Hs
         lBamSNj479ivwJEmqZcJUf5BEIbJHB1+ERWn6Wy5KmAx8vLYXK1IoyY3l+Wb5sUCrzrK
         dTnlihPCSAqYG23YGBnpTXwPUHL46QGKVYrvKNO6viAWz3LCgasOvZIftkfEDCaxlJid
         A6nNT0YYPCDE1H0TfZST5KCh6mVD/V+S0zLorMA9dO+AGxGvxdVuzJRenbUl+s28IS9W
         p+/Q==
X-Gm-Message-State: AJIora9uYXgmfhj3CnDw5nl2AfAMaPtVp02UrmIa3EHdfZcwrR7/VdF5
        6RhOzQzzetrozXaKsnEk0CoqsGG0W1KPsw==
X-Google-Smtp-Source: AGRyM1voCA2yZC5aD0kUHf/Bato4IHvxH2bIkiZorgBHBe/GoauTIED2Sn7snvPKyRnbHl1LKEBMqg==
X-Received: by 2002:a37:b947:0:b0:6b5:6604:60f3 with SMTP id j68-20020a37b947000000b006b5660460f3mr8252163qkf.170.1657851769752;
        Thu, 14 Jul 2022 19:22:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id br10-20020a05622a1e0a00b0031e9bd3586esm2544976qtb.79.2022.07.14.19.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 19:22:49 -0700 (PDT)
Date:   Thu, 14 Jul 2022 22:22:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v3 2/6] pack-bitmap-write.c: write lookup table extension
Message-ID: <YtDPePTo52A+Uo0p@nand.local>
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
 <5e9b985e39b0b9edee7af55dd8b0698a20062cf7.1656924376.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e9b985e39b0b9edee7af55dd8b0698a20062cf7.1656924376.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

I just wanted to make absolutely sure that I understood what the
implementation in this patch was doing, since I think generating and
converting between all of these different orderings is by far the most
confusing component of this series.

On Mon, Jul 04, 2022 at 08:46:12AM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> The bitmap lookup table extension was documented by an earlier
> change, but Git does not yet know how to write that extension.
> +static int table_cmp(const void *_va, const void *_vb, void *_data)
> +{
> +	uint32_t *commit_positions = _data;
> +	uint32_t a = commit_positions[*(uint32_t *)_va];
> +	uint32_t b = commit_positions[*(uint32_t *)_vb];
> +
> +	if (a > b)
> +		return 1;
> +	else if (a < b)
> +		return -1;
> +
> +	return 0;
> +}

Let's skip the above part for now, and just look at the implementation
of writing_lookup_table():

> +static void write_lookup_table(struct hashfile *f,
> +			       struct pack_idx_entry **index,
> +			       uint32_t index_nr,
> +			       off_t *offsets)
> +{
> +	uint32_t i;
> +	uint32_t *table, *table_inv, *commit_positions;
> +
> +	ALLOC_ARRAY(table, writer.selected_nr);
> +	ALLOC_ARRAY(table_inv, writer.selected_nr);
> +	ALLOC_ARRAY(commit_positions, writer.selected_nr);

Makes sense.

> +	/* store the index positions of the commits */
> +	for (i = 0; i < writer.selected_nr; i++) {
> +		int pos = commit_bitmap_writer_pos(&writer.selected[i].commit->object.oid,
> +						   index, index_nr);
> +		if (pos < 0)
> +			BUG(_("trying to write commit not in index"));
> +
> +		commit_positions[i] = pos;
> +	}

By the end of this loop, we have an array `commit_positions` which maps
the ith selected commit to its lexical position among all objects in the
bitmap. IOW, `commit_positions[i] = j` means the `i`th selected commit
can be found at index `j` among all objects in the pack/MIDX in their
lexical order.

> +	for (i = 0; i < writer.selected_nr; i++)
> +		table[i] = i;

At this point, table[i] = i.

> +	/*
> +	 * At the end of this sort table[j] = i means that the i'th
> +	 * bitmap corresponds to j'th bitmapped commit in lex order of
> +	 * OIDs.
> +	 */
> +	QSORT_S(table, writer.selected_nr, table_cmp, commit_positions);

And then we sort table by treating its values as indexes into
`commit_positions`. Here's where I'm not sure that I follow what's going
on. You say above that `table[j] = i`, where `i` corresponds to the
order of selected commits, and `j` is in lexical order.

If that's the case, then I'd expect that printing `index[table[j]]` for
increasing `j` would output OIDs in increasing lexical order. But that
doesn't quite seem to be the case. From a debugger session that has a
breakpoint after computing and sorting table, along with building
`table_inv`:

    (gdb) p oid_to_hex(&index[table[0]]->oid)
    $17 = 0x555555983ea0 <hexbuffer> "0006763074748d43b539c1c8e8882c08034ab178"
    (gdb) p oid_to_hex(&index[table[1]]->oid)
    $18 = 0x555555983ee1 <hexbuffer+65> "001ce83dd43f03dcfc67f29d38922e4a9682aab0"
    (gdb) p oid_to_hex(&index[table[2]]->oid)
    $19 = 0x555555983f22 <hexbuffer+130> "002db882ece2ab6a240e495a169c6e06422289c8"
    (gdb) p oid_to_hex(&index[table[3]]->oid)
    $20 = 0x555555983f63 <hexbuffer+195> "0007a5feb040e1ff704f3ad636619ddca3e7382b"

that doesn't look like the OIDs are increasing in lexical order.

I'm not quite sure if I'm even looking at the right thing, or if this is
to be expected, or if the comment isn't quite accurate. If you could
help clarify what's going on here, that would be great.

> +	/* table_inv helps us discover that relationship (i'th bitmap
> +	 * to j'th commit by j = table_inv[i])
> +	 */
> +	for (i = 0; i < writer.selected_nr; i++)
> +		table_inv[table[i]] = i;

This part makes sense, as does the rest of the implementation.

Thanks,
Taylor
