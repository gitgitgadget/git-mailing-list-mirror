Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A02C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 22:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87CC22077D
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 22:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bike6k14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDWWOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 18:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgDWWOj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 18:14:39 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2702FC09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 15:14:39 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id c83so1682187oob.6
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 15:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rSq4jwPn/FOVyOjsZaGreMyxz4NpKTxM5IpinhrdVYc=;
        b=Bike6k14HMsSlgFM9FKlfODP4kHWdsVNqkmOtZvKESGRfhoaHMNfcwhkZIKpiP6NQy
         OB3ac9zw2lrNrhZKH/67085rSesdXxzBR7Il3P3z2W6krpWATurm2HahdSpsEFziddSQ
         hA+0P8b9dN8P2goHYEIq46OJ46LxD2crgTezqCxkj+KzGULISGnSswbnC//DmNn1K6I+
         UbNML+TdIMV86DG2tjHK2g165zK5sU71Tyf7A7D1ZHHRCgFO6XzxwxB1qa2sLtz8mlBj
         FHxgt+G3EI8vDYvi8+MmZJNaWkosmrsqhbNe15R/RgZlQZp6WFMi3D8RD/memu+/BYX0
         b2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rSq4jwPn/FOVyOjsZaGreMyxz4NpKTxM5IpinhrdVYc=;
        b=jArL4z8K7YgsmMdUmn2Qp7og5d0e3gxqCUdAa7MBzKZgqt9V3dKSOv4uniC1tMEQCZ
         QzXSNGPMK7Fo0H/fGIbTYUKlXlkxmClYLuwUGxwcXocm0rKD012ZEin2S2MV+3j2RHp4
         bTiznAav4LwIg+NqYVWj+DrsTYie7KFMNE8Rm3TSUWFPC+PWBRxubxvdNfGfE1UUV9l+
         /jfI6nKpmeTlIPzO18vE0zNGVF98G0+IPzD48kfbR+I/Gl5CZGGgvll/Tr1woJJl0tuQ
         foV9zLQi6Xe4mEusMAF0QUKZwROcDlFUcB2/Jc49kVQpi0LlkxAgHbHHkg0u+4nRClTb
         z0aw==
X-Gm-Message-State: AGi0PuYOepflzkF8ksJV07CyFdylMFjUT6qQDZYtM9inwJ1UMmFPjS4R
        bxeoaMRyBdcCueRD17StvpU=
X-Google-Smtp-Source: APiQypL6h2sr/CZXIrerb1WWTqpEb0mEffC7dK8W49hzbltwMteWCkKMeVEeu69dSlsmAWE39OtFfw==
X-Received: by 2002:a4a:e151:: with SMTP id p17mr5285122oot.28.1587680078388;
        Thu, 23 Apr 2020 15:14:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:b00:7980:9cd1:e4c2:b0cd:6da9? ([2600:1700:b00:7980:9cd1:e4c2:b0cd:6da9])
        by smtp.gmail.com with ESMTPSA id t203sm1009766oib.52.2020.04.23.15.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 15:14:37 -0700 (PDT)
Subject: Re: [PATCH 0/2] minor fixups for gs/commit-graph-path-filter
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20200423205851.GA1633985@coredump.intra.peff.net>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <dde036bb-303c-a9d1-6bf2-880428cfb7c0@gmail.com>
Date:   Thu, 23 Apr 2020 18:14:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423205851.GA1633985@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 4/23/2020 4:58 PM, Jeff King wrote:
> These are just a few bits I noticed in the test-tool helper when the
> topic hit next (my -Wunused-parameter patch complained that we never
> looked at argc).
> 
>   [1/2]: test-bloom: fix some whitespace issues
>   [2/2]: test-bloom: check that we have expected arguments
> 
>  t/helper/test-bloom.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> -Peff
> 

Thank you for doing this! 
Both patches look good to me. 
I also don't care about the brace/no-brace thing that 
Taylor brought up for 1/2. 

Cheers! 
Garima Singh
