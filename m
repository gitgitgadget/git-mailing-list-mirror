Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD40EC34049
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 19:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B619E24125
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 19:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5rUPspP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgBRT1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:27:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41281 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgBRT05 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 14:26:57 -0500
Received: by mail-pl1-f194.google.com with SMTP id t14so8470062plr.8
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 11:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5yhnOoTNcdfp/uzc+2+m5kYRrpk5IaXEdSAbrz/ZhVE=;
        b=W5rUPspPdGdwKNl/pAJaCjIgSKMoLEsxZVd16N8BU8kzVCXpI4ARAQSQj8NU9iE/2m
         UcEc5oGWRtaPnI/Q+CGqfPZ/nrkoLiMP/HVsaYry297W9GDTspK7il4Y/kXXL+3F1BCu
         Xn+T+yRnAFVvqaeTIaQo+H/fBpr3jjE70hK5MWYKfmcJ8I7AdQpGcqoL/q9V+9Q5SqqY
         hnFr96tlf601AM8vzL66njMqcTxs4ADbj6pCXmBcF3nrcNXJ2fj3ugx7E2sYMb8up6gP
         BNqcWQC1OltM7R06iVnAFyhuJQSBz7hVUm3AZSlVtOCIgFT/1BesGj8BnTX0dcXUNbxe
         nzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5yhnOoTNcdfp/uzc+2+m5kYRrpk5IaXEdSAbrz/ZhVE=;
        b=aUl0A73cLohT4MK7fJlFMAF+tQe08mmOlrG0P4Oz1quzfxtbYV4INRREpYUIDYhQV+
         V/b/ItVggul5jpx7ynlnMbeO6Fp6E8ZTcNDHEK8/TjChdNxW9Mj0CviWkjn5eF4GUqTZ
         axpTVVuAUZb/dimzmKmJPaQmK8goB/riIovDr92N1s/kWGraHsa0dwBSOQU7fZf3RlT1
         AmhVdcGYq4S+6bw6R1RJNJi+xkI5CWVvuqisjwmKrwrxxphmkW1Mau2IxAtIQuAjVCfM
         UsfVogDXDw1cFRDJUf1ieepHTkuKOBmUXTxB69fexX4cWeCxccGZKErTmUe6AQ35Za8y
         J6Tw==
X-Gm-Message-State: APjAAAVnLthUzWw9xrOSNdR/svCddNAfCwzC5OryW+M5MaJFOdlTZnXh
        ETlsdmskEd8mcFjg1Cw/aqg=
X-Google-Smtp-Source: APXvYqxESNHCrlx9qetPmbNRqlrYq26mv+zl1zTpHxyr7Ne5bgs2N6ccKiLO/NuzBMaXfyvFjiPrDg==
X-Received: by 2002:a17:90a:9dc3:: with SMTP id x3mr4453098pjv.45.1582054016508;
        Tue, 18 Feb 2020 11:26:56 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:493e:b22e:e9c8:d09a? ([2001:4898:e008:1:d27a:b22e:e9c8:d09a])
        by smtp.gmail.com with ESMTPSA id o10sm5596210pgq.68.2020.02.18.11.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 11:26:55 -0800 (PST)
Subject: Re: [PATCH v2 13/15] pack-bitmap: implement BLOB_NONE filtering
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182236.GM150965@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <800e4714-200e-6256-5538-ef39f6d9246c@gmail.com>
Date:   Tue, 18 Feb 2020 14:26:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200214182236.GM150965@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/14/2020 1:22 PM, Jeff King wrote:
> We can easily support BLOB_NONE filters with bitmaps. Since we know the
> types of all of the objects, we just need to clear the result bits of
> any blobs.
> 
> Note two subtleties in the implementation (which I also called out in
> comments):
> 
>   - we have to include any blobs that were specifically asked for (and
>     not reached through graph traversal) to match the non-bitmap version

I have a concern here, but maybe I'm worrying about nothing. When a
partial clone asks for a pack of missing blobs, will your code create
an empty bitmap and then add bits to that bitmap one-by-one instead
of appending to a simple object list?

In the typical case where we ask for specific commits and trees, we
expect a very small number of blobs to add to the resulting bitmap.
When no commits or trees are included in the wants, then we don't
need the bitmap at all. IIRC an EWAH bitmap is relatively expensive
to update bits one at a time, so this is not incredibly efficient.

I apologize that I don't have the time to dig into this myself.

>   - we have to handle in-pack and "ext_index" objects separately.
>     Arguably prepare_bitmap_walk() could be adding these ext_index
>     objects to the type bitmaps. But it doesn't for now, so let's match
>     the rest of the bitmap code here (it probably wouldn't be an
>     efficiency improvement to do so since the cost of extending those
>     bitmaps is about the same as our loop here, but it might make the
>     code a bit simpler).
> 
> Here are perf results for the new test on git.git:
> 
>   Test                                    HEAD^             HEAD
>   --------------------------------------------------------------------------------
>   5310.9: rev-list count with blob:none   1.67(1.62+0.05)   0.22(0.21+0.02) -86.8%
...
> diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
> index e52f66ec9e..936742314c 100755
> --- a/t/perf/p5310-pack-bitmaps.sh
> +++ b/t/perf/p5310-pack-bitmaps.sh
> @@ -47,6 +47,11 @@ test_perf 'rev-list (objects)' '
>  	git rev-list --all --use-bitmap-index --objects >/dev/null
>  '
>  
> +test_perf 'rev-list count with blob:none' '
> +	git rev-list --use-bitmap-index --count --objects --all \
> +		--filter=blob:none >/dev/null
> +'

I wondered why you chose to extend these tests instead of using
p5600-partial-clone.sh, but I guess this script definitely creates
the bitmap for the test. When I tested p5600-partial-clone.sh below,
I manually repacked the Linux repo to have a bitmap:

Test                          v2.25.0               HEAD                    
----------------------------------------------------------------------------
5600.2: clone without blobs   79.81(111.34+11.35)   36.00(69.37+7.30) -54.9%
5600.3: checkout of result    45.56(114.59+4.81)    46.43(80.50+5.41) +1.9% 

Perhaps results for these tests would also be appropriate for your
commit messages?

Note the +1.9% for the checkout. It's unlikely that this is actually
something meaningful, but it _could_ be related to my concerns above
about building a blob list from an empty bitmap.

Thanks,
-Stolee
