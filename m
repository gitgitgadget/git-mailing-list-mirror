Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96FBC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 19:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352854AbiCXTMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 15:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347365AbiCXTMm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 15:12:42 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1826CB82E9
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 12:11:10 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h63so6515046iof.12
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XQh+4r715Dd5my2XXrSoMN9SiQYIKnN5BXQXihumaaI=;
        b=Fomq8fWjcmCH1zMnM5wMHJEI8VGjzbf7RP9f7FWg5/3uV7PmXJ8zVQtjrQ0aBHB+a8
         JK+diBIlIMRhk6B/VPqBwRKE6pesntD3c7cmOWD1b+vFe81FQMP6j8bla3Y6czMD5OlL
         jD1MphS44Tb9YZCmsIE7qQUgBUjDjkdKAE7wEtbMDRfqhs5G2BY2y5OV0R7EnTlYyFd7
         br7d7zNQF7sp+PFYsNcPaMXlMZt75diMbMky6D7Uks0ai9we+dKJdx4ufPJQPzdcYOZz
         1I9IjDIfzE5bzKt7CprmoGyDaTlFHyPBOavPd7QsX2r8mLKr00U8KJOMlj94dTYj3+YK
         GVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XQh+4r715Dd5my2XXrSoMN9SiQYIKnN5BXQXihumaaI=;
        b=vgO0DTNnMnJkZXmXJ5pyb0ZK+m08HTO3q4p3+asSXaIvEihTMzYpGa4YACo9pW0XiO
         fscj74/nrdjWY749vJO/jUwl6T3fOptvzFjxDs+xfujrs9iPnPo6gb1g2eFTqF4X4kgg
         sKV6hnSkyNfXNMaaIjOOu0S3FNj4G6EpaDYfiIEDWhLemeE5epRYc9QadpxD7o+7fUmJ
         G0MwxTR2KTKT3Aj2Y7r2DVkfyQEe9WmXQ/4WaVqs31KyTYMo5LHHig3zP0gp10WAuEx4
         mab7BlbG/dLSQ89vOXLxkTqI81OWDpb2DM3VFoZFutei3Hq8khPZTfLxuPG9v1pnrg87
         d0kA==
X-Gm-Message-State: AOAM532gaJNFu2gd43SWRY6FP6DZkWhIRcWvx6GMYnr26xVUhnhVeW9m
        esnhb9khsLOeTqInP6FZkYpS6g==
X-Google-Smtp-Source: ABdhPJxjuwsLwCDhpsTSl3Wq6sAU5meIojOEZP34jkoO8CiywQRjj8lrunrBLqjOQp/03PI5rKbI2Q==
X-Received: by 2002:a05:6638:d53:b0:31a:c87:a704 with SMTP id d19-20020a0566380d5300b0031a0c87a704mr3703840jak.207.1648149069413;
        Thu, 24 Mar 2022 12:11:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z17-20020a92da11000000b002c83987c2ffsm1778221ilm.76.2022.03.24.12.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 12:11:09 -0700 (PDT)
Date:   Thu, 24 Mar 2022 15:11:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, derrickstolee@github.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 1/3] pack-bitmap.c: use "ret" in "open_midx_bitmap()"
Message-ID: <YjzCTLLDCby+kJrZ@nand.local>
References: <cover.1648119652.git.dyroneteng@gmail.com>
 <3048b4dd2982932fa11ba8393895fa33a00a5b58.1648119652.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3048b4dd2982932fa11ba8393895fa33a00a5b58.1648119652.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 24, 2022 at 07:43:59PM +0800, Teng Long wrote:
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 9c666cdb8b..931219adf0 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -494,15 +494,18 @@ static int open_pack_bitmap(struct repository *r,
>  static int open_midx_bitmap(struct repository *r,
>  			    struct bitmap_index *bitmap_git)
>  {
> +	int ret = -1;
>  	struct multi_pack_index *midx;
>
>  	assert(!bitmap_git->map);
>
>  	for (midx = get_multi_pack_index(r); midx; midx = midx->next) {
> -		if (!open_midx_bitmap_1(bitmap_git, midx))
> -			return 0;
> +		if (!open_midx_bitmap_1(bitmap_git, midx)) {
> +			ret = 0;
> +			break;
> +		}
>  	}
> -	return -1;
> +	return ret;

This all looks like good clean-up to me, and it indeed preserves the
behavior before and after this patch is applied.

But thinking about some of my comments on patch 2/3 here, I think that
we don't want to break out of that loop until we have visited both the
MIDX in our repository, as well as any alternates (along with _their_
alternates, recursively).

That _is_ a behavior change with respect to the existing implementation
on master, but I think that what's on master is wrong to stop after
looking at the first MIDX bitmap. At least, it's wrong in the same sense
of: "we will only load _one_ of these MIDX bitmaps, so if there is more
than one to choose from, the caller is mistaken".

I think instead we'd want to do something like this on top:

--- 8< ---

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 410020c4d3..0c6640b0f6 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -500,10 +500,8 @@ static int open_midx_bitmap(struct repository *r,
 	assert(!bitmap_git->map);

 	for (midx = get_multi_pack_index(r); midx; midx = midx->next) {
-		if (!open_midx_bitmap_1(bitmap_git, midx)) {
+		if (!open_midx_bitmap_1(bitmap_git, midx))
 			ret = 0;
-			break;
-		}
 	}
 	return ret;
 }

--- >8 ---

Thanks,
Taylor
