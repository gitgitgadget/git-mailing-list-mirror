Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D62C77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 20:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjEEUpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 16:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjEEUpj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 16:45:39 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E3C4C38
        for <git@vger.kernel.org>; Fri,  5 May 2023 13:45:37 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-55cc8aadc97so33261777b3.3
        for <git@vger.kernel.org>; Fri, 05 May 2023 13:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1683319537; x=1685911537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbfU1VgD7ROtN3cm2ltL21eoqBZV4GJoZZp7tNVoJw4=;
        b=Kp8P6YlxKAbr/FZUDAwb4w39SNKwlURHCSffur0eJKz5Rzwqxjl9TbzGDtYhACJD9J
         RxbY+SLoZn81/ULmGoLnurJOBl+iFTe2pfQ5SMICRAY4w9KEUKYLt9mwkyvlQAj8ehjB
         QQnmjFEtLQ4SdOdMs4Ir5zypWHy6TKqsfuxvKKxvqfq8WLmO4w1cNyNfIBnXgxtCnMhA
         jls+78gvVDLdSz9KfHgOKgQoJEhqfONsFx4YaB74GgneHQAjo5KXC9SqHTljSos2ME/9
         REOlBI202gD5+8FX3JO/LDeuTcG+5RedK3ydAuZp5pUH1oUkgpJjLUxkHPWB07irVnsz
         MH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683319537; x=1685911537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbfU1VgD7ROtN3cm2ltL21eoqBZV4GJoZZp7tNVoJw4=;
        b=G6rB4TB70+ysv4eJjXRiFM3OE1XOF1riP+YH+rRXpg2oytuTeYt5vvbaD3iV6v7Cch
         FYkm4/OUij340JDDoMKDmYxqVQcrXgORIFRUhLISla3dpRxuvkU3q0fdyEuMzAlkIpls
         hcgKLYg2xbsEVGj/utJ3v2sJMJGeh6QMnSXxovLMdFRzg2QYXELd0lJYdp1olQ9yqFBv
         8xMiavRcTDHFzatXvaXMh5jyZzFXOZFmH2Kkw1I5RQU7RaTp5AF9umfmUS7X4T+r2u55
         m+ynrRZLxad6WETnfid6JsNvVZ0eARsKYH7O36tc99gOPXFTZq1pofsNCn3/GbIcPQg6
         sg+A==
X-Gm-Message-State: AC+VfDzpJja0T0ZERZKHVfrt2L01JfAAAFviU/YNBMfdgQJjph4tnunr
        RkpZDF/tWnxWQkOUuNmI1uvpsui/06y9yqrR+A==
X-Google-Smtp-Source: ACHHUZ4+6WMcHuBPYussJ9rOB2deGTLvRtOTWktPEskMJq4hin0S4tmxIWevsQ7Kd8b8qzNu/9LfxQ==
X-Received: by 2002:a0d:d549:0:b0:54f:e6cb:fc68 with SMTP id x70-20020a0dd549000000b0054fe6cbfc68mr2965859ywd.38.1683319536909;
        Fri, 05 May 2023 13:45:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fcac:2b0b:1f40:7f1a? ([2600:1700:e72:80a0:fcac:2b0b:1f40:7f1a])
        by smtp.gmail.com with ESMTPSA id z7-20020a81a247000000b00559ec10f245sm677549ywg.103.2023.05.05.13.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 13:45:36 -0700 (PDT)
Message-ID: <4ce3ff5f-e7cd-f604-f5da-66939be7d314@github.com>
Date:   Fri, 5 May 2023 16:45:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 0/2] pack-bitmap: boundary-based bitmap traversalt
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1682380788.git.me@ttaylorr.com>
 <cover.1683307620.git.me@ttaylorr.com>
 <6c8d9142-9013-f3f0-0619-b3780b86b6ab@github.com>
 <ZFVO9kFZ+lr32WxY@nand.local>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZFVO9kFZ+lr32WxY@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/5/2023 2:46 PM, Taylor Blau wrote:
> On Fri, May 05, 2023 at 01:59:31PM -0400, Derrick Stolee wrote:
>> On 5/5/2023 1:27 PM, Taylor Blau wrote:
>>> Here is a reroll of my series to implement a boundary-based bitmap
>>> traversal algorithm that I worked on towards the end of 2021 with Peff.
>>>
>>> The algorithm is unchanged from the last version, but the implementation
>>> has been made much more straightforward, thanks to a very helpful
>>> suggestion from Stolee.
>>>
>>> Instead of hackily trying to write down all of the UNINTERESTING commits
>>> between the tips and boundary within limit_list(), we can just perform a
>>> commit-only walk, which will give us the set of commits that we need.
>>
>> Something that didn't seem to get attention in this version was buried
>> deep in the commentary of my high-level review [1]:
> 
> Oops, sorry, I definitely missed this unintentionally and did not mean
> to ignore it.

I had to dig deep to find it, even after knowing it was in there
somewhere, so I'm not upset it didn't happen this version.

>>> For these reasons, I'm surprised that this patch completely replaces
>>> the old algorithm for the new one. I would prefer to see a config
>>> option that enables this new algorithm. It would be safer to deploy
>>> that way, too.
>>
>> I still think it would be nice to keep the two algorithms for at least
>> a little while instead of completely removing the old one. Let's gather
>> some more evidence and get more reps in with the new algorithm before
>> making it the new default. I could imagine a scenario where someone
>> really wants to spend the extra time to make sure none of the objects
>> reachable from the UNINTERESTING commits are included in the output of
>> this diff.
>>
>> [1] https://lore.kernel.org/git/a143150d-7cf5-c697-0e48-0f7af1c6de8f@github.com/
> 
> Hmm. I'm not opposed to keeping the old algorithm around, though I
> wonder what the configuration option would look like here. I imagine
> that we don't want to support the old algorithm indefinitely, though.
> 
> Perhaps something like `pack.useBoundaryBitmapTraversal` (implied by
> `feature.experimental`), defaulting to "false", and then eventually
> "true"?

This name makes sense to me. Including it in feature.experimental right
away seems like a good idea. Incrementing it to "true" by default after
a single release would make sense, too, since the performance benefits
are so clear. Just important to have that emergency toggle.

Thanks,
-Stolee
