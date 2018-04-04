Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F11841F404
	for <e@80x24.org>; Wed,  4 Apr 2018 12:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbeDDMIj (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 08:08:39 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44819 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeDDMIh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 08:08:37 -0400
Received: by mail-qt0-f194.google.com with SMTP id j26so22758339qtl.11
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 05:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zMlmClKcFEgAamBeomisnjs+Ctrmni6SyYtyDlEoa/4=;
        b=c7I7P1Ok0Vz/65K1G3sCy1+I1+rQnw83YdiDWd86Cowg+EKy3vQhVDGUXLUZWVDrqi
         4Ikn8qwBBLXr7AFh2Bqld8t8BqS2vpf4sDsXDTxJDy1mBK0psrXWuGqbL1jwFF0+T7yG
         1mDCkzx9o0h9KswoWAVG9SDGJfvETa92Pz3Ow98eO5Nay8ydoenQzNL7eDPWAn0AwkpR
         RyqVyET+wvkvluGN8lkAwmZYRCuXBoAYaRRv+tAYCcDNpvZ4ZOMwxLVYpkvMxZesksl7
         AHrylpSzzVUlhW4p5+cRjVxjVdxhVD9r1y0t0av5LyEQaHEYafSZV9WsW0EkB8jOlcen
         NixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zMlmClKcFEgAamBeomisnjs+Ctrmni6SyYtyDlEoa/4=;
        b=mVtlDNV1oYh4XyRCu5YsCfAVzUEFY0KHOQyQ7cW9DGwUIW6be7842dpa9F9td2bVhS
         1UNO024lTqggDxP5IUE5f8xB+B90J8ZcwhRv7dCvhb33+UYLVE3CzIWaJT3ZaoggnyZw
         4DD15EbZh3qH3+/Mkq0m/5c7+3MWNG4bA7VyT6Q2Ee1w+zZIu6+S1jUkk2SXL5hOL3dF
         U3rNbisWKhg5WakpNx38JZzv7kXGxMNFsfbpLsuRgaBGoINFpCwJeWF29N5nqxVdzz/A
         0hJrNRuOZvZSfdmBq65sMBEy3Qqt2zPADBpOBcKJAdlHuhCS3yGL4h/00EL+DVKwsOtQ
         JlsQ==
X-Gm-Message-State: ALQs6tCbpVSxT630WlWfrmXMI+a4H3ldrbiZ4K6K3lTbXHxRr7CX13kK
        XMhm+3xnUU1lfDdyLtP82b4=
X-Google-Smtp-Source: AIpwx4/jqHzIPeSfx5uL6xtAijUcunukcaG8M97sDaCbQa3mMG0NyKmdf6uhi6kj672Ggj0vuqgXiA==
X-Received: by 10.200.44.207 with SMTP id 15mr26412553qtx.238.1522843716596;
        Wed, 04 Apr 2018 05:08:36 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id m31sm3888044qtd.95.2018.04.04.05.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 05:08:35 -0700 (PDT)
Subject: Re: [PATCH 0/3] Lazy-load trees when reading commit-graph
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com
References: <20180403120057.173849-1-dstolee@microsoft.com>
 <20180403130615.GA18824@sigill.intra.peff.net>
 <007c630a-0df8-803c-b637-fb5ccefa7b7c@gmail.com>
 <20180403202030.GA15157@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <73e884cb-ff75-9f1d-f5d1-1624371ab15e@gmail.com>
Date:   Wed, 4 Apr 2018 08:08:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403202030.GA15157@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/3/2018 4:20 PM, Jeff King wrote:
> On Tue, Apr 03, 2018 at 09:14:50AM -0400, Derrick Stolee wrote:
>
>>> I'm not sure what the exact solution would be, but I imagine something
>>> like variable-sized "struct commit"s with the parent pointers embedded,
>>> with some kind of flag to indicate the number of parents (and probably
>>> some fallback to break out to a linked list for extreme cases of more
>>> than 2 parents).  It may end up pretty invasive, though, as there's a
>>> lot of open-coded traversals of that parent list.
>>>
>>> Anyway, not anything to do with this patch, but food for thought as you
>>> micro-optimize these traversals.
>> One other thing that I've been thinking about is that 'struct commit' is so
>> much bigger than the other structs in 'union any_object'. This means that
>> the object cache, which I think creates blocks of 'union any_object' for
>> memory-alignment reasons, is overly bloated. This would be especially true
>> when walking many more trees than commits.
>>
>> Perhaps there are other memory concerns in that case (such as cached
>> buffers) that the 'union any_object' is not a concern, but it is worth
>> thinking about as we brainstorm how to reduce the parent-list memory.
> It definitely bloats any_object, but I don't think we typically allocate
> too many of those. Those should only come from lookup_unknown_object(),
> but typically we'll come across objects by traversing the graph, in
> which case we have an expectation of the type (and use the appropriate
> lookup_foo() function, which uses the type-specific block allocators).

Thanks for the clarification here. I'm glad I was wrong about how often 
any_object is used.

Thanks,
-Stolee
