Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E046C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 19:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D38821556
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 19:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff0Hq0gi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgAMTsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 14:48:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40966 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgAMTsH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 14:48:07 -0500
Received: by mail-qk1-f194.google.com with SMTP id x129so9688833qke.8
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 11:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=htiKS2THDhj5dELb2JSNNyhZeap/LYUE7YPtFO4b80I=;
        b=Ff0Hq0givxWwEWNAv0cPrG3y/YWxi+weJavjsjEGNC1M9lzxstETwoYGqYqmeuvPLD
         gjyfw9y0mxI3PL+L8w9/27PTt/d3f8zVKin7Q+cQxFpN9gSh3gAbN+cZL+hx2TAny9K5
         58XLZKi3nl3h4M9gE4OQ7mjurPdcus7VlUi9kxcuKoQAV5ofdedpes82xgNwjBuWDcT3
         g6NJgrLXjzv9f3c6lv0tggJxwh3DyxpShGE+nIu1r7z1x7cQwQzbs1K30w03pytu0qRk
         KC6NSVhg9u52nslkvqbs0Ym3pjiee2M45lxyFKLR1tr6oC9Y7knm2Q87pirRWYf360oB
         IqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=htiKS2THDhj5dELb2JSNNyhZeap/LYUE7YPtFO4b80I=;
        b=Jttp1icbaLB/scqyROLkoAa37NZx4xXBituk/PH8svn3cmlWa2hESPiHlNKd7PuJ9a
         r6k+O/+YO3BN2dzIwgFmRKhbeq4VA2h9qGHZYEUY2TSZ4BcMSsqWF9UZCld9NlN2F/Zk
         23MHmKXHFI98uMdCgGGybh2anGta3Iwn1s09IGAySEB+14PePmOruKI1BrJ7CwRk5JKL
         GjYgUwvepYIHYURrEMFI081eKee6CcWJ405OTgg8Mi8NPSpiFb8QhDNASJkJibMR6jsq
         wvy+E0C60m16FY5fiVVgO22vSVMpfiqWXXXxtmjT2VPBIRQiF7mKRcMlz/8/pEHklvu0
         Vsdw==
X-Gm-Message-State: APjAAAW40XsQoKKgOMrat7Rg8Szkii74KEPXMn7Qaw76eGbSGEf0sx8y
        tbT4FhiiR7lTExgT0dLetbI=
X-Google-Smtp-Source: APXvYqwL0XB9dzpokwqC82LRo4Ap/Ettu3WHG3i8fHJK6VzwnJP3lCXjcFF0lnr8x4OjkeYDAJe+hQ==
X-Received: by 2002:ae9:f714:: with SMTP id s20mr17689732qkg.236.1578944886468;
        Mon, 13 Jan 2020 11:48:06 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13f:69fe:2d70:2369:9bfd? ([2001:4898:a800:1010:1b35:2d70:2369:9bfd])
        by smtp.gmail.com with ESMTPSA id o9sm5511245qko.16.2020.01.13.11.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 11:48:06 -0800 (PST)
Subject: Re: [PATCH 2/9] commit-graph: write changed paths bloom filters
To:     Jakub Narebski <jnareb@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <e52c7ad37a306891487bd79a09b040bfb657d723.1576879520.git.gitgitgadget@gmail.com>
 <86eewczapt.fsf@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <6cefadde-7171-e081-ba5b-ba2543d9f22f@gmail.com>
Date:   Mon, 13 Jan 2020 14:48:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <86eewczapt.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 1/6/2020 1:44 PM, Jakub Narebski wrote:

> "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes: 
>> 3. The filters are sized according to the number of changes in the each commit,
>>    with minimum size of one 64 bit word.
> 
> Do I understand it correctly that the size of filter is 10*(number of
> changed files) bits, rounded up to nearest multiple of 64?
>

Yes.
  
>> +
>> +struct pathmap_hash_entry {
>> +    struct hashmap_entry entry;
>> +    const char path[FLEX_ARRAY];
>> +};
> 
> Hmmm... I wonder why use hashmap and not string_list.  This is for
> adding path with leading directories to the Bloom filter, isn't it?
> 

Yes. We do not want to repeat directories in the filter.

Thanks!
Garima Singh

