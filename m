Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 821901F404
	for <e@80x24.org>; Wed, 28 Feb 2018 20:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934767AbeB1U5a (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 15:57:30 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:35730 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934698AbeB1U53 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 15:57:29 -0500
Received: by mail-qt0-f178.google.com with SMTP id z14so4825191qti.2
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 12:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mUzZzxNp81xCOUwqq5ipasvrvQwUWQApXLIGhaHfOVc=;
        b=CNS1qs3R0IhaGxEOZK7YTjsM2rCbbqV6+rQ3iVh+lFuhhDd4mX1fyu2/b2oOn3Iu/0
         R/I9sL3UJ5r4+T9dqsWgmV50FgSHDbe3ylvTsmqi1z4IJbYp2p8R/vO/pzk9t2YiuBBx
         rB/PW8cvZYo7dRQh2OaxXX2oBnyhtvdjTM8OilLXGRcFIqk53+nvST2vEsTfK6RkcIKd
         s0yS/jZGTdoK2PUhrJLhbs3exp3hsWFSgt43QzNDMPzkgGZjIqNI3qn2B9srLv0+Yq2y
         NSHKpf5bCEiMHr9fzBx01tb0zeuYyRXUOJOCXKeF6o+pzPv4q0rJXE2KPPLGZn4UcKnI
         pfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mUzZzxNp81xCOUwqq5ipasvrvQwUWQApXLIGhaHfOVc=;
        b=PeqvSrbGx7PZuPoFqOYqH0UVF9fjg+0AR07fHEDeHs9FHBs58lHQT0OOyQxSbGXXg8
         YPZS7yFjVV+P+y3hViY6DOrDm5k6NqFq5KMeIbEuTQVUKQwdG0FFzRQfhuJyKcZndiU0
         jL2qqTfnmakhKHAXhGkV8wWpKeva/VZbu9JpjUWaJsi1VcRKhPbf22xVARXIhghFlYBr
         8CNW+OQRY2c1ULgi6lD2N8NSJR28AJ0bJj0HDeC3LScALpbeeBeeUEW2owMjaSESKd1r
         rH3Yqdd1WZnQTRa7zjcL6vyBKk2Mg7HS2Rn2lQajjT/C9jb0J387d8Ym8E7vplnCIzRh
         IRNw==
X-Gm-Message-State: APf1xPD0ozT49rAUOSWTW3gWXfU6oZIYKm8JZqsIR6EtgJiHCliu7VSV
        i3XKVMUT2mwsPtDVRqDgcgE=
X-Google-Smtp-Source: AG47ELuanlfdq3gs8wopI6ioXMGzKuxblFndwCj3DhR70la8nmQkJWD8JQVNzQjQa5GLueYs5OcF5g==
X-Received: by 10.237.50.37 with SMTP id y34mr32626332qtd.234.1519851448347;
        Wed, 28 Feb 2018 12:57:28 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id q24sm1762704qkq.75.2018.02.28.12.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 12:57:27 -0800 (PST)
Subject: Re: [PATCH v2] sha1_name: fix uninitialized memory errors
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net, christian.couder@gmail.com
References: <20180226204151.GA12598@sigill.intra.peff.net>
 <20180227114704.193145-1-dstolee@microsoft.com>
 <xmqqy3jckfe3.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ce8421bb-4519-c4e5-ff0a-98ae532d764b@gmail.com>
Date:   Wed, 28 Feb 2018 15:57:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3jckfe3.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/28/2018 3:50 PM, Junio C Hamano wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> diff --git a/sha1_name.c b/sha1_name.c
>> index 611c7d24dd..a041d8d24f 100644
>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -547,15 +547,15 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
>>   	 */
>>   	mad->init_len = 0;
>>   	if (!match) {
>> -		nth_packed_object_oid(&oid, p, first);
>> -		extend_abbrev_len(&oid, mad);
>> +		if (nth_packed_object_oid(&oid, p, first))
>> +			extend_abbrev_len(&oid, mad);
>>   	} else if (first < num - 1) {
>> -		nth_packed_object_oid(&oid, p, first + 1);
>> -		extend_abbrev_len(&oid, mad);
>> +		if (nth_packed_object_oid(&oid, p, first + 1))
>> +			extend_abbrev_len(&oid, mad);
>>   	}
>>   	if (first > 0) {
>> -		nth_packed_object_oid(&oid, p, first - 1);
>> -		extend_abbrev_len(&oid, mad);
>> +		if (nth_packed_object_oid(&oid, p, first - 1))
>> +			extend_abbrev_len(&oid, mad);
>>   	}
>>   	mad->init_len = mad->cur_len;
>>   }
> I do not think they are wrong, but aren't the latter two somewhat
> redundant?  "num" is p->num_objects, and we call (first+1)th element
> only after we see (first < num - 1), i.e. first+1 < num, and the
> access to (first-1)th is done only when first > 0.  The first one,
> i.e. when first points at where we _would_ find it if it existed,
> can access "first" that could be p->num_objects, so the change there
> makes sense, though.
>

Yes. But I'd rather keep the blocks consistent and use the return value 
of nth_packed_object_oid() when possible.

Thanks,
-Stolee
