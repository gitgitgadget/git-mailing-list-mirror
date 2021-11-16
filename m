Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6221C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 21:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0AF361BF5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 21:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhKPVNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 16:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhKPVNK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 16:13:10 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A177C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 13:10:12 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id l19so611465ilk.0
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 13:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iI0PxqtZ6jIkOS2kiAh1Jsw/At+CS6e92GseIj6Dkzw=;
        b=WPX2N2ocE8CAaH9U9owfw7fufO6CgDDb6gF2gouBjBpF62bxIdSxndZslqkTHymz7l
         /4p6t1+oUFUNRZIRvrCC2RRjhXin8mMfSfF5p9gNYNRnlnNA0WnSHO0jiCGxhCgusnL0
         YQ3fNqdGm5X7R3OyVuQ8pg7WIxmCS1qac0vd9LMG2yW6JfXAXmtaVK35dKA0PH47KCfO
         tc1Pln6a7jzIQ7Nq8ZJspIElzAgmSh9pWX+dh7rY2an1aXuJgpQ6E8p6n+olRB4yOJ5S
         5om87rtHPs3u/X/LsxDMMp56zK41DXT6cc/7cFKDv7fAPKCCwZ+tFLjhzXOfihrC8pob
         G0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iI0PxqtZ6jIkOS2kiAh1Jsw/At+CS6e92GseIj6Dkzw=;
        b=JXXm25DX+l1+pBYVjrALoBflCW6EGfMJKhlWyvMUAE3ZRDz6bv5XX08SrKaQEcE5N+
         bS4/fl4meS10yQKU9WGOj/HHALHVxug3teNQXZ6nE5GyovUQeINy81rjwefDRZH7S5GW
         potNrMCbrlLRS7FDzCMFePcqZzJxrPJCqDYypKYH8w6Lkegb6PW7BO3lClv61e4uToXj
         /xeWHs3bB/QmNGzOhyKybwqFQs2YK4avyPeyMOelaey0V7w+Riwfl0PN7eU94Cr5+oiz
         daJfM0smwzZ7Ax5XU4fk0iu0RS3fAZ5NJEfyXd7s2e2iHMoQZ4HcokOj7sl1TgmioN0n
         YQXg==
X-Gm-Message-State: AOAM530ud3AsWobZr46/gOAkMn2ZK/xSRdc1o6ETNbinudpkaCn1mcn6
        tkrpe1gMOnMhOOnxlUbCwBRfoCO7FMuETKn2
X-Google-Smtp-Source: ABdhPJx6alAnPdOxsE8lDdtgBT2MJCDKo86cCD53LZe88dzuae5OeafdoEtL+20xTLJTRU683zSObA==
X-Received: by 2002:a05:6e02:1521:: with SMTP id i1mr6736906ilu.101.1637097012062;
        Tue, 16 Nov 2021 13:10:12 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i25sm9438419iol.50.2021.11.16.13.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 13:10:11 -0800 (PST)
Date:   Tue, 16 Nov 2021 16:10:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 4/4] midx: report checksum mismatches during 'verify'
Message-ID: <YZQeMjjtxS2LU2Tk@nand.local>
References: <cover.1624473543.git.me@ttaylorr.com>
 <94e9de44e3b52513c5ab48aecd74f809dc34cbe3.1624473543.git.me@ttaylorr.com>
 <20211110231132.GB5811@szeder.dev>
 <YYzq0uBr+uoVvkbC@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YYzq0uBr+uoVvkbC@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 11, 2021 at 05:05:06AM -0500, Jeff King wrote:
> > Since SHA1 is essentially random, there's a 1:256 chance of that
> > happening, assuming that the file's content is random.
>
> The most exact fix here would be to read the final byte, increment it
> mod-256, and write it back, which would ensure it was always changed.
> But that's a bit annoying to do in shell. Perhaps just corrupting more
> bytes is a good solution? The patch below should reduce your changes to
> 1 in 2^80.
>
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 3f69e43178..a612e44547 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -482,8 +482,10 @@ test_expect_success 'corrupt MIDX is not reused' '
>  '
>
>  test_expect_success 'verify incorrect checksum' '
> -	pos=$(($(wc -c <$objdir/pack/multi-pack-index) - 1)) &&
> -	corrupt_midx_and_verify $pos "\377" $objdir "incorrect checksum"
> +	pos=$(($(wc -c <$objdir/pack/multi-pack-index) - 10)) &&
> +	corrupt_midx_and_verify $pos \
> +		"\377\377\377\377\377\377\377\377\377\377" \
> +		$objdir "incorrect checksum"
>  '
>
>  test_expect_success 'repack progress off for redirected stderr' '
>
> There are other variants, of course. Just appending a single byte to the
> file is enough to give you a high probability of failing the checksum
> (since it shifts it all by one byte, making it essentially random), but
> the corrupt_midx() helper doesn't support that.

Thanks SZEDER for the report, and thanks Peff for the fix :).

I agree that it's annoyingly cumbersome to write back the last byte
incremented mod-256. So I'm content to just make it astronomically
unlikely to run into a collision in practice. (As a matter of fact, I'm
surprised that the current implementation hasn't produced failures for
us more often).

Peff: do you want me to turn this into a patch or were you planning on
it?

Thanks,
Taylor
