Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7C21F404
	for <e@80x24.org>; Fri, 24 Aug 2018 18:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeHXWQm (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 18:16:42 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:38037 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeHXWQm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 18:16:42 -0400
Received: by mail-qt0-f177.google.com with SMTP id x7-v6so11234381qtk.5
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kWzapvMEXN22SXm1KpCxmS0gqQJLVQL3PgtF/YBHptE=;
        b=Be8282iSvOM0iPK64QrIFeYWdjUlu3CuWlTvUb9RL26Q8r+jaNT158I9ENkQuY+/im
         FogcxgFzNTmyPniEGwVdDjr5G0+Ih94Bgu4nF1nkmszILDVpm1/DO4w9BtLo7x3UGwkD
         q+/TNUcuV3t40nXMeiLmssa0cqo8ya7dfVJqiZnc1jkgHM+D3ySGXAKd5QQtG/9beIDu
         1AoS6KRQvuFdM2GT/c7pJIEhXcO65O0p1fxpMyq5Aa1gvHt1JU9ZSucknAd3UFoO6lsP
         3w1p7U81EudiW3A0rUCd0tAyD/U17hwqNz09wVhVlaI+PxAKOhu7VlPZAddViyLT11eo
         qzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kWzapvMEXN22SXm1KpCxmS0gqQJLVQL3PgtF/YBHptE=;
        b=hRqr+OW8z8uVvVDAh6qgUqOjf3oeFa2jcRNk5gJXemcG6RfQJmdonIx/AjlolSn9qS
         k5w57XDBy23NNqQBoCTtSr1hi62fPqVqnowqN3i+y+XFZCIhGNlLcv1lebx53y6oXlLi
         jstY1CkDku+1mAxzKxae0HNH2dDS4F6q3mYnyaRdy9cg+pPo8ruY+7PTLeTm5Pv9jqBo
         mEIMlMwlpOHYgsj09K8PObzW8qt3IpPdEUnLBzCvpvqmxN6/MkG8mrVPDYmPTFW+uHPk
         7rqmSJAQFYNJzbITnUK9hr+/DRRRje2gMEVZiMbKnKsRUTAcmOjYtQsOX9HgNN9hr+Uz
         7/lw==
X-Gm-Message-State: APzg51BBeEXZWs1u3bZZ7ZNPlgZIYmzxUx3MmCEVvk+fG7MBSp0uP+O1
        6QPUMS14xf5/e2uPeWAteegtQABv
X-Google-Smtp-Source: ANB0VdbkpxJBrNq1+Wm6DuFEqlszaIBB8Q63JIkD8yf9zco1YYdPJsjBFbXX2dY5DbQeHmLVPryqGg==
X-Received: by 2002:a0c:bfe3:: with SMTP id u32-v6mr3131141qvj.172.1535136052495;
        Fri, 24 Aug 2018 11:40:52 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id n25-v6sm5928694qtb.32.2018.08.24.11.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 11:40:51 -0700 (PDT)
Subject: Re: [PATCH v1] read-cache: speed up index load through
 parallelization
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <xmqqin41hs8x.fsf@gitster-ct.c.googlers.com>
 <4c70ea50-5b43-8696-3c46-cf3d658a0ef8@gmail.com>
 <CACsJy8CUPGUhR3girstdqD6YVxOQ6_xE+gacT98KXgqOSPz0dw@mail.gmail.com>
 <CACsJy8BXy_7QbDtF8bY5YzwJf=JUwiODv0zKxoSXeu4rJ+xjwg@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <2ba0a9f7-8073-e606-d433-490ea605466b@gmail.com>
Date:   Fri, 24 Aug 2018 14:40:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8BXy_7QbDtF8bY5YzwJf=JUwiODv0zKxoSXeu4rJ+xjwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/24/2018 2:20 PM, Duy Nguyen wrote:
> On Fri, Aug 24, 2018 at 5:37 PM Duy Nguyen <pclouds@gmail.com> wrote:
>> On Thu, Aug 23, 2018 at 10:36 PM Ben Peart <peartben@gmail.com> wrote:
>>>> Nice to see this done without a new index extension that records
>>>> offsets, so that we can load existing index files in parallel.
>>>>
>>>
>>> Yes, I prefer this simpler model as well.  I wasn't sure it would
>>> produce a significant improvement given the primary thread still has to
>>> run through the variable length cache entries but was pleasantly surprised.
>>
>> Out of curiosity, how much time saving could we gain by recording
>> offsets as an extension (I assume we need, like 4 offsets if the
>> system has 4 cores)? Much much more than this simpler model (which may
>> justify the complexity) or just "meh" compared to this?
> 
> To answer my own question, I ran a patched git to precalculate
> individual thread parameters, removed the scheduler code and hard
> coded these parameters (I ran just 4 threads, one per core). I got
> 0m2.949s (webkit.git, 275k files, 100 read-cache runs). Compared to
> 0m4.996s from Ben's patch (same test settings of course) I think it's
> definitely worth adding some extra complexity.
> 

I took a run at doing that last year [1] but that was before the 
mem_pool work that allowed us to avoid the thread contention on the heap 
so the numbers aren't an apples to apples comparison (they would be 
better today).

The trade-off is the additional complexity to be able to load the index 
extension without having to parse through all the variable length cache 
entries.  My patch worked but there was feedback requested to make it 
more generic and robust that I haven't gotten around to yet.

This patch series went for simplicity over absolutely the best possible 
performance.

[1] 
https://public-inbox.org/git/20171109141737.47976-1-benpeart@microsoft.com/
