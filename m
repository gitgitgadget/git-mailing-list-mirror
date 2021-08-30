Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAF1C43214
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 229E060F5C
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbhH3Rbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhH3Rbn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 13:31:43 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49CBC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 10:30:49 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso9077466otu.0
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 10:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RSqGbFRLVJkFVNhOwYFzAq4+msVkaIqK8Ed425s42kE=;
        b=R6wdxmcLlUrqe0YlAM/OVzbP7TVDHB06QJSFFF7vkT3wFx60GjSfEzCuAjTNrqjO66
         CU3Y5L+tiSVYWFCYhdHRmviVNJ5QZ90cZ8bNqOfcgs4oAEs0NLbCfpkyurysXYjCew95
         bF6+JTSTNqJXR0CwCHBu7bt1RSGH5eRDXJO+ZtqAeqICe19IBnpreeXpQm5tv+LYkLPt
         QCGkXH84d9RvXQG5zsrKpBGeimn8SVgSxbrpYcxwM8m/AJBzw9zUE/4vcbjhuvx1RFv0
         Bdj6K9ooacBYFF7z45SBoUfh6E0yeoqDqsuC2rHM0Yeca4SB3fZIlJFdTAMLcUgPd9GC
         U2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RSqGbFRLVJkFVNhOwYFzAq4+msVkaIqK8Ed425s42kE=;
        b=ebylECUMlHZsFxLdwP+Wy62EJnxUx12R/65TgrWmm/3jcPSk5I2VCoAdwMaVni+x9q
         48RoRPpt5s+Rh5+zmjLVnqx+Xz2xC3MT2TntPoefFz0LE79VnVUVMeOgaEi2iOBiiu25
         5KVhvhgsxqGsDUwnBiWtdVqCIndcIb4ROt71qY0XYZnnvS+2ZoNtheerj/IAVa6m0OpF
         Xh335bYsnvdLj08+AbIfRzlbFaYK1kMWbgUwlT0Rp35iWElSqpwX7asvbZdiuFcCCKDQ
         uxSeefYlgVzjRDLPWcWvaz7ZsD1iCHNPbZKLfTN/DqHN58KfyDwmRjOW5CcwRDG6vZvA
         s5+Q==
X-Gm-Message-State: AOAM530CKytQuS7xscH7TlaW1MJPmoAcTIAH7ueWFvN/U8tJVnJFIiqz
        jXti1Se+M3HjmZ2/BMxQkWw=
X-Google-Smtp-Source: ABdhPJy8gC8Er+NwqkxhMkKc6GJugdoBSwPJIlQ+umrJTP3XoxgiW8eDK21/IZT+imW8jUuOZTWU+g==
X-Received: by 2002:a9d:6055:: with SMTP id v21mr19742807otj.265.1630344648994;
        Mon, 30 Aug 2021 10:30:48 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e4d6:1362:a8d2:be4e? ([2600:1700:e72:80a0:e4d6:1362:a8d2:be4e])
        by smtp.gmail.com with ESMTPSA id 186sm3088051ood.39.2021.08.30.10.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 10:30:48 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] strvec: add a strvec_pushvec()
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
 <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
 <patch-v3-2.5-321b8ba3f0e-20210826T140414Z-avarab@gmail.com>
 <xmqq8s0m9xbl.fsf@gitster.g> <xmqq4kba9x1h.fsf@gitster.g>
 <YSm3ofxlRB1ViBf5@coredump.intra.peff.net> <xmqqzgsz7qnq.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <85e539bc-7af5-595e-bcf4-bf577eb3bdfd@gmail.com>
Date:   Mon, 30 Aug 2021 13:30:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqqzgsz7qnq.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/29/2021 7:54 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> I think we'd want the patch below. It can be applied independently
>> (though if we do take the index-iterating version of Ævar's patch, I
>> think it should switch to size_t).
> 
> Yeah, I do not see a strong need for _pushvec(), especially the
> variant that does not preallocate, when we have _pushv().  But the
> type fix below does make sense.

Thanks for chiming in. I was not aware of _pushv() when I asked
about the _pushvec() variant. Sorry, Ævar, for sending you down
an unnecessary direction.
 
>> -- >8 --
>> Subject: [PATCH] strvec: use size_t to store nr and alloc
>>
>> We converted argv_array (which later became strvec) to use size_t in
>> 819f0e76b1 (argv-array: use size_t for count and alloc, 2020-07-28) in
>> order to avoid the possibility of integer overflow. But later, commit
>> d70a9eb611 (strvec: rename struct fields, 2020-07-28) accidentally
>> converted these back to ints!
>>
>> Those two commits were part of the same patch series. I'm pretty sure
>> what happened is that they were originally written in the opposite order
>> and then cleaned up and re-ordered during an interactive rebase. And
>> when resolving the inevitable conflict, I mistakenly took the "rename"
>> patch completely, accidentally dropping the type change.
>>
>> We can correct it now; better late than never.
...
>>  struct strvec {
>>  	const char **v;
>> -	int nr;
>> -	int alloc;
>> +	size_t nr;
>> +	size_t alloc;
>>  };

This is also a good change to take.

Thanks,
-Stolee
