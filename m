Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A8AC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 17:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239542AbiF0Rr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 13:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238092AbiF0Rr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 13:47:57 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63CFD111
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 10:47:56 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id c1so15767147qvi.11
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 10:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uj4TCVvtzsQOhA5xo+Mu5IzFEE/6rFZoBxfWHB4hjJk=;
        b=Z3t8K1E/R2dNPatY/EQv94Et0ERNNnMGWI3Rysgjhln93WxvKgO9AFEfsfDS+tZ/VY
         wUrd3AwzadOCKB35PlgbJwjyN4T6jBzW2JddGfAUj2Dr0XEasXVYD28jYdjFV3c61sfs
         QgJMpLBRzDbUbvTTp/TyVM+pT5feWfSvnxkhRxyh6RF/0/hTAMRucNKmnplbZIFRFziI
         zvQupQAAgFTAQknzbXEOE1axthC55Va49/lWJAMpwI+6O1ZGqtQSFZyxyCIfj/FnLvk1
         Ct3ZbAOPaRgIE/Q1wJC2NCr48++DNP6sOB81knQRSMGV2bjHkDoNcGWuQLQfvGE0Xd9Z
         fpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uj4TCVvtzsQOhA5xo+Mu5IzFEE/6rFZoBxfWHB4hjJk=;
        b=jzhd6Z4XnHxHszESEw0Z3fuFmaw4fUIQDx8fOH/EZEn5N+kldoKmOf7c8bCinWkAGH
         1XsH4UbWg37BkTc1a9HLTfZ3RiRtRAQcLP409/bmhjbJgDSAgyJ7cmQfNby5pAo6lDgy
         SIDalLizrjqWfoX2tWHvHtAkntrJrv0KCwPm1pWW0W+LRU/oavFZqW0XUXNdoqt711Pz
         NnYgLJ8EGsJvfy/0nyErVDY/b8CncIXKiByNxxdwMi1YIEgXxzzrCtxRa6IUcW8MluGZ
         dgYSKvwIRSIMG9u9+yjKyasJQ2GWfbcfCRssC3IyHWIF+zed6d0rij+PcvHFBRwSslGu
         46jQ==
X-Gm-Message-State: AJIora/ilHVju+u8zyl2O3+3OU3PWm3mXubPnUpv2OSevpxp/5TAh8KG
        ryFVN5tBZxW+zF6ZOjqQIAL+TA==
X-Google-Smtp-Source: AGRyM1vrfZCvvWehA2NjOFwKBnJfuwe133J4/6WKxLEjfC+3f1EjaY7MDL8s4K7l38L1kltXytMnOw==
X-Received: by 2002:ac8:5a10:0:b0:31a:755c:c613 with SMTP id n16-20020ac85a10000000b0031a755cc613mr4590726qta.158.1656352075816;
        Mon, 27 Jun 2022 10:47:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s9-20020ac85289000000b00304efba3d84sm7433753qtn.25.2022.06.27.10.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 10:47:55 -0700 (PDT)
Date:   Mon, 27 Jun 2022 13:47:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 3/6] pack-bitmap-write: learn
 pack.writeBitmapLookupTable and add tests
Message-ID: <YrntSpG5asIPNdZz@nand.local>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <7786dc879f006c8316c33dd70e98888ceb50a014.1656249017.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7786dc879f006c8316c33dd70e98888ceb50a014.1656249017.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 26, 2022 at 01:10:14PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> Teach git to provide a way for users to enable/disable bitmap lookup
> table extension by providing a config option named 'writeBitmapLookupTable'.
> Default is true.
>
> Also add test to verify writting of lookup table.
>
> Co-Authored-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> Mentored-by: Taylor Blau <me@ttaylorr.com>
> Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>

I think that this was covered earlier in the review of this round, but
in general your Signed-off-by (often abbreviated as "S-o-b") should come
last. The order should be chronological, so I'd probably suggest
something like:

    Mentored-by: Taylor Blau <me@ttaylorr.com>
    Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
    Co-Authored-by: Taylor Blau <me@ttaylorr.com>
    Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 5edbb7fe86e..3757616f09c 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -87,6 +87,13 @@ static int git_multi_pack_index_write_config(const char *var, const char *value,
>  			opts.flags &= ~MIDX_WRITE_BITMAP_HASH_CACHE;
>  	}
>
> +	if (!strcmp(var, "pack.writebitmaplookuptable")) {
> +		if (git_config_bool(var, value))
> +			opts.flags |= MIDX_WRITE_BITMAP_LOOKUP_TABLE;
> +		else
> +			opts.flags &= ~MIDX_WRITE_BITMAP_LOOKUP_TABLE;
> +	}
> +
>  	/*
>  	 * We should never make a fall-back call to 'git_default_config', since
>  	 * this was already called in 'cmd_multi_pack_index()'.
> @@ -123,6 +130,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
>  	};
>
>  	opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
> +	opts.flags |= MIDX_WRITE_BITMAP_LOOKUP_TABLE;

I wonder if this should respect pack.writeBitmapLookupTable, too.
Probably both of them should take into account their separate
configuration values, but cleaning up the hashcache one can be done
separately outside of this series.

Everything else looks good.

> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 899a4a941e1..79be0cf80e6 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -713,6 +713,7 @@ static void write_lookup_table(struct hashfile *f,
>  	for (i = 0; i < writer.selected_nr; i++)
>  		table_inv[table[i]] = i;
>
> +	trace2_region_enter("pack-bitmap-write", "writing_lookup_table", the_repository);
>  	for (i = 0; i < writer.selected_nr; i++) {
>  		struct bitmapped_commit *selected = &writer.selected[table[i]];
>  		uint32_t xor_offset = selected->xor_offset;
> @@ -725,6 +726,7 @@ static void write_lookup_table(struct hashfile *f,
>
>  	free(table);
>  	free(table_inv);
> +	trace2_region_leave("pack-bitmap-write", "writing_lookup_table", the_repository);

This region may make more sense to include in the previous commit,
though I don't have a strong feeling about it.

Thanks,
Taylor
