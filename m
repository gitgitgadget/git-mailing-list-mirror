Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3FDC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 17:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347844AbiDUR2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 13:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390754AbiDUR2v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 13:28:51 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073DF42A33
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 10:26:01 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id f14so3789877qtq.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 10:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RAWxeDgWqb610XIR70R/C4c8E3to590Zfx8fWC3BnIU=;
        b=SBkBryMXt5iIh6FtQTA2/tdboHPllg17ykZ7X2+o38XYrasKZy4/SWJbO98tRzwqng
         jXgeDKgPMGz9e5CPoDTPet5j7rruoYfaQ/iiDFI1HkrSmPR5x0RLHHklxgKSP2jxjcBQ
         uHBeMG8PBKkF9pLhgZbUydE1FBPeW3FFR7MOYqaO//9vK73oWBPQCb+JoaGMOP+umERW
         YXB2NBATG6auz7C8zEmQ81uitpgxoeuLIgCCz6QMGaQxv58XV+83Fv9PFdLTwThZjYJ5
         zLytQ0ZHcVGPwWqP1HanVlaXw0B18WJ/EpPhFcIOrivN5vyzYNNh+nZ5t3LDzQ7WFSQO
         4K1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RAWxeDgWqb610XIR70R/C4c8E3to590Zfx8fWC3BnIU=;
        b=npzhTh+VdgJtrkFOR/GHLDPWe94wALfCm7b3lqBeRZtxMoa8Immn7+7xMIDGG+EsQL
         K25VOX+3aMAJsz9MplM/T/MkYmBcqTp5X5hNQycyo1eGEC/aP88sgjyC7DU3C6Susj+g
         BpUAv+BRZY259BQFHdHvY9HAPqlHcZbH+1ZP4jLMoN4hD+0rvuj/iVb/sD8LXND8Zv3h
         NV+hFUcjNV2VVTMSM/QJwjpjdRn0KLXq5TFMPYo2IFp0xIkvqd1ATzgRafUPoyou/fE4
         GNnakxUO8uYPYcA66CnNGAesaK+Hikq/rVQXI1xNW4MiVNVUee8P4tDstAd+HM48GFGp
         Nc+g==
X-Gm-Message-State: AOAM532RK42a6l/taynEtFCXPZOGqXg0Yt1hSu7RVbUKD507YYwPGlOl
        48B8Dm6DltjUQUwsEuR9C8NtZQ==
X-Google-Smtp-Source: ABdhPJzbRUV1TeRaVBLYiV1jSDx7d+W47++P9G0+4P0i/tNp2yDwol75VJBe5BWL4iqf9R8vPBDO3w==
X-Received: by 2002:ac8:5946:0:b0:2f2:487:26e5 with SMTP id 6-20020ac85946000000b002f2048726e5mr386535qtz.317.1650561960142;
        Thu, 21 Apr 2022 10:26:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u187-20020a3792c4000000b0067e679cfe5asm3253432qkd.59.2022.04.21.10.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:25:59 -0700 (PDT)
Date:   Thu, 21 Apr 2022 13:25:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com, gitster@pobox.com
Subject: Re: [PATCH v2 3/5] pack-bitmap.c: make warnings more detailed when
 opening bitmap
Message-ID: <YmGTphnsVJn7CX5V@nand.local>
References: <cover.1650547400.git.dyroneteng@gmail.com>
 <5a8f5afccf6e2b451c76306e04ca9ef300c92fdd.1650547400.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a8f5afccf6e2b451c76306e04ca9ef300c92fdd.1650547400.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 09:26:38PM +0800, Teng Long wrote:
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index f13a6bfe3a..1b268f655e 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -330,7 +330,8 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  		struct strbuf buf = STRBUF_INIT;
>  		get_midx_filename(&buf, midx->object_dir);
>  		/* ignore extra bitmap file; we can only handle one */
> -		warning("ignoring extra bitmap file: %s", buf.buf);
> +		warning(_("a normal or midx bitmap already has been opened"));
> +		warning(_("ignoring extra bitmap file: %s"), buf.buf);

I'm glad that the existing warning has been marked for translation.
There's no reason that it couldn't have been before, so I'm glad to see
it added now.

But I'm not sure that the new warning tells the user anything that the
old one didn't. The old warning says "ignoring extra bitmap file: ...",
leading us to believe that another one has already been opened. The new
warning makes the latter part explicit, but I don't think it adds any
new information that wasn't already readily available.

> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index f775fc1ce6..eb63b71852 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -421,6 +421,7 @@ test_expect_success 'complains about multiple pack bitmaps' '
>  		test_line_count = 2 bitmaps &&
>
>  		git rev-list --use-bitmap-index HEAD 2>err &&
> +		grep "a bitmap has been opened" err &&

This is out of sync with the warning you added, causing t5310.74 to
fail.

Thanks,
Taylor
