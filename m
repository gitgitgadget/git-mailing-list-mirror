Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324DD1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 16:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbeGLQQT (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 12:16:19 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43876 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbeGLQQT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 12:16:19 -0400
Received: by mail-qt0-f194.google.com with SMTP id f18-v6so24528304qtp.10
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=llaXEMSDre2v2oYkHsmOJ4Rvlyvlr31uNoCwRnFX+3g=;
        b=eHmcEbWEhxFVEaFz1AxwuXEqwICI0SSZe8hqTmkvZTb0RWxda8gDpMep7p/Bu8XaKp
         BCs7IFqN0X7c8u7A8xngFY5x4R9w30LK+Zh4RtOOuJT0F1wOx5Q3zJfAGZvMsLoWoVlf
         MZjvTY2NvFtLXdMPGdIujHOq21WwygcpER2fljLVyLEzN3CaYCWN0Beb2aT67u8B76i0
         Vr0i1PcjcjDtyukz63tMjpH8ssh6G+5Rixd7kyqb7UhoA7FYgudnH3s46CBLk2NMGS0a
         jJ8fVIOFv4MtVnFPLfG0aaSUOAQ8eghBpvPvKHXnC2D/e8nNfE7zpw7/01n+U2o5IC/F
         1s5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=llaXEMSDre2v2oYkHsmOJ4Rvlyvlr31uNoCwRnFX+3g=;
        b=tiCjOVmctAoFudE2P7Wqy0VXtx4YJv9HvoCnyz7qAdmWNbr0rtf2+t/5CtdquYH2vs
         Y7WY3pzhbVJMCPAfq0DJVOFt0FUDmex5yClDc5wH7z5Pf8tQa5moBfR+2SPRL3e/Wj9H
         Fe9zOFpUwQabY6F6RTOi53tGHjOs/lmhpo7iaxs4cnPMGY1Gczg6Dk+912Hz+YlWn8xh
         JGv8qWO66JMC8AMrlfRsPUfIGQbUUEaCwx7uB62PYPLPpcHg11DzthQb1YkvXFzhVL/6
         R/hkx6R4l9P8xqrV0FP0O9YY9gdv5aNz2BVbfNf2xdK3Bopz1y74SDOvYsFikmLRKrpt
         YPsw==
X-Gm-Message-State: AOUpUlE3c5VWw0ls2ZFQQbgupfeEO8iENZWJhZ93MyuELW4Q2xX4hcWD
        On5Q3B39YMrzdl9IPRHrqPE=
X-Google-Smtp-Source: AAOMgpdPJ/oXT8MqHw2fE2Tok5knY+Peo/RdjZZjpllrpyCNeBvSKTNwglkLgHRprR1oCymmPkAGHg==
X-Received: by 2002:a0c:f386:: with SMTP id i6-v6mr3132660qvk.100.1531411566762;
        Thu, 12 Jul 2018 09:06:06 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7999:2a5f:44db:50fd? ([2001:4898:8010:0:62cf:2a5f:44db:50fd])
        by smtp.gmail.com with ESMTPSA id y132-v6sm4199073qkb.56.2018.07.12.09.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 09:06:06 -0700 (PDT)
Subject: Re: [PATCH v3 06/24] multi-pack-index: load into memory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-7-dstolee@microsoft.com>
 <xmqq36wsdy75.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1fb87ff0-5315-d96e-4671-433311746c31@gmail.com>
Date:   Thu, 12 Jul 2018 12:06:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqq36wsdy75.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2018 3:08 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>> diff --git a/midx.h b/midx.h
>> index dbdbe9f873..2d83dd9ec1 100644
>> --- a/midx.h
>> +++ b/midx.h
>> @@ -1,6 +1,10 @@
>>   #ifndef __MIDX_H__
>>   #define __MIDX_H__
>>   
>> +struct multi_pack_index;
> I actually was quite surprised that this struct is defined in
> object-store.h and not here.  It feels the other way around.
>
> The raw_object_store needs to know that such an in-core structure
> might exist as an optional feature in an object store, but as an
> optional feature, I suspect that it has a pointer to an instance of
> multi_pack_index, instead of embedding the struct itself in it, so I
> would have expected to see an "I am only telling you that there is a
> struct with this name, but I am leaving it opaque as you do not have
> any business looking inside the struct yourself.  You only need to
> be aware of the type's existence and a pointer to it so that you can
> call helpers that know what's inside and that should be sufficient
> for your needs." decl like this in object-store.h and instead an
> actual implementation in here.

I thought it natural to include the struct definition next to the 
definition for 'struct packed_git', but I like your separation of 
concerns. Perhaps we could move the packed_git definition to packfile.h 
as well (separately). Of course, that sounds like an unnecessary churn.

Thanks,

-Stolee

