Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD62CC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 22:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F6CC6056C
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 22:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbhIGW3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 18:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhIGW3J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 18:29:09 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F68C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 15:28:02 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id j18so555648ioj.8
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 15:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SY4HzA/WRD4acwiA2yIxJuAHroIvnXpgVFmcJgT6Yj8=;
        b=lWoZgaQUN6se8saqvcgNHuF6V+y6YGCr2SSxdFgJ9v+GWy71X/FBl4M/RigeNOod9R
         WAKQHs2l9Xr4aUidOAuBjRgQRDzZ4StlqbMvP/0IUzNA9/ty/vhvDfBR/lteK53tYbtQ
         iVwgjOUAU7+QNFwOXq7WgTTp4LBER6tMQaVLkgDdzRTEJT+ih6T8MHi3ux+Js0W/9yO7
         lAuXuZkxPRFgAq1GwEZBj9EBG+F05/XDATohJrYSsjbURrpqE2H7GbTUZagyzmNArOCP
         XPc35udr4J+3rDMWcCXrUtsWMOZ0G3TL+m7tYUL45ixuZPx/nnAY9b4hl0jxAPZWSDRl
         5RTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SY4HzA/WRD4acwiA2yIxJuAHroIvnXpgVFmcJgT6Yj8=;
        b=G64Rww0nFVVENHJVQuabVIiVCtfbI2v2HKA3K9B5ka5ZjGUIgImVNK1f5rsGAYbBiO
         R9D6Sm6NoJe9GFuG7ELCuGLn6J+6rNTr4tq7J1tlAhq7Q0QzRrsS8S7KN0i47sCskikC
         NUFXK9/OTBRIFhDOYzFaSBo43HDD2EbZYRgamfyUl/SC/T/mIIlpNV3sZqgTcpDuoCCq
         nsHXKV3YM3o8EWk4FRyjaIGMhD+1Lm4AB9CwXyZv9sTFYStlmECbnQ5MXztZgQIjBBh9
         C0fQP8fnfwdA3sRlkFt9+4etMO9fAmttuzxkj9scDTLhWfto1+jQsEQDYFU7MrzHvP0O
         whwQ==
X-Gm-Message-State: AOAM530Pugm4QcBC4JU3PdyiSGRRKVNz+/0BpL2KZX30hrxEmIo4iRCp
        tNc9Pfo5D8YlnLqJvNIcgbJlRw==
X-Google-Smtp-Source: ABdhPJzavkk16j7mEVQm6DiRFRyp4BOcd4rBayGoc1uqurByRHq3/gzR1pCLp1Igcdsht2/Udbg1dw==
X-Received: by 2002:a02:908a:: with SMTP id x10mr577840jaf.30.1631053681575;
        Tue, 07 Sep 2021 15:28:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g16sm209461ilr.40.2021.09.07.15.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 15:28:01 -0700 (PDT)
Date:   Tue, 7 Sep 2021 18:28:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] pack-write: split up finish_tmp_packfile() function
Message-ID: <YTfncHIiljW/E5Lz@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover-0.3-00000000000-20210907T193600Z-avarab@gmail.com>
 <patch-2.3-42f83774fe8-20210907T193600Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.3-42f83774fe8-20210907T193600Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 09:42:37PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Split up the finish_tmp_packfile() function and use the split-up
> version in pack-objects.c. This change should not change any
> functionality, but sets up code flow for a bug fix where we'll be able
> to move the *.idx in-place after the *.bitmap is written.

Seems like a logical step to make, and all makes sense to me. One
thought for future clean-up...

> diff --git a/pack-write.c b/pack-write.c
> index 57b9fc11423..ba5c4767dc8 100644
> --- a/pack-write.c
> +++ b/pack-write.c
> @@ -468,16 +468,33 @@ void finish_tmp_packfile(const struct strbuf *tmp_basename,
>  			 uint32_t nr_written,
>  			 struct pack_idx_option *pack_idx_opts,
>  			 unsigned char hash[])
> +{
> +	char *idx_tmp_name = NULL;
> +
> +	stage_tmp_packfile(tmp_basename, pack_tmp_name, written_list,
> +			   nr_written, pack_idx_opts, hash, &idx_tmp_name);
> +	rename_tmp_packfile_idx(tmp_basename, hash, &idx_tmp_name);
> +
> +	free(idx_tmp_name);
> +}
> +

I was surprised that you did not replace the caller in write_pack_file
with this (and instead open-coded the implementation). But that makes
sense, since the very next commit is going to move the bitmap into place
between staging and renaming the .idx.

The only other caller of finish_tmp_packfile is in the bulk-checkin
code. So I might suggest that we get rid of this function altogether and
instead call stage_tmp_packfile() and rename_tmp_packfile_idx() directly
in bulk-checkin.c:finish_bulk_checkin().

That would allow us to slim down the header, but more importantly would
make it clear that something like finish_tmp_packfile() shouldn't be
used blindly in case there is other work to be down between staging and
remaing into place.

> -	idx_tmp_name = write_idx_file(NULL, written_list, nr_written,
> -				      pack_idx_opts, hash);
> -	if (adjust_shared_perm(idx_tmp_name))
> +	*idx_tmp_name = (char *)write_idx_file(NULL, written_list, nr_written,
> +					       pack_idx_opts, hash);

Yuck (and unavoidable!)

Thanks,
Taylor
