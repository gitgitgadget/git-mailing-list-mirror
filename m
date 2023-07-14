Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E17CEB64DA
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 09:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjGNJzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 05:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbjGNJzP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 05:55:15 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C43A7
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 02:55:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31438512cafso1724094f8f.2
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 02:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689328512; x=1691920512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1SrjgzPyK+hetmreggLlHtAOYRFR+ZsgiQTCexPh8qk=;
        b=B5A8+rzpEInhZjE1nIpFyoGNQ2s2ZMrQrnlZE0VxZ02nhAnNwFgmRaCCFPHHKLlklS
         kBe7PdqqSkKu1GGwoH27xy06JaNjeqCTWDMfA0ORmc0kLfuof+5A+3ORQxQks6MBVJIs
         an/vIAvNy9mBSQF4CVWmwqjw/VvejN6/8kHlf9QO4B8VpP30cu6OtHGn9uEFyVvmh6oi
         o5gnkm4JA37UfXaKJK1YohgWhI+rtWJrJOSkINb0RNmNpD6/jhmrlXsIg4rHoLnaI/3G
         W9iYIqjHcaye0+6Dds20l3gd9+97YHoZ8DHyu4z7T8ZRdaANiICYUFlmZ/1TtnKTEF+n
         53eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328512; x=1691920512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SrjgzPyK+hetmreggLlHtAOYRFR+ZsgiQTCexPh8qk=;
        b=I/X3ZAkMPUlUOObMxWXnm7EWPoRF4ri8p7hDgWcjH0eoXUBpcxvhSLeEZAE6X9rvTZ
         JtHl7WAI3ekaK5kx4conCme0oeIrTzxqaurQ0GmH/XDzSzURLEe07TVCCEATBkTSv/Bp
         Waytu/u4ihQP45K3Aewau1XyMD9dZrJrE1fDpVQBcgsLy9UxDxfOueazp9+O4KAagouv
         1npHzd3p5rGLBKxecy0OyrQhyyQAb+MOyFjOifXJB/dzkpZZgKXE1aFUU/YPnMNJOady
         kXxte8J0hqO/iwSEt8bWmcnhlJEcMCTIlDmIuX+MLMP9qV6yoAFqJna7KLL8i9jsJvOZ
         +YDg==
X-Gm-Message-State: ABy/qLbfwtv5CUmnbO81WEdUuKslx31D2x5jwWRf5u2AzbKtif4oY0ZM
        ATZ6QmVbCR397Y9aNqZtNXvYC/n0wwe75w==
X-Google-Smtp-Source: APBJJlFqFNKDRzTHKVwP0ofzDwxq/wSHPGh12jyINrf8EiS4W9gW24qmChPDc7dEbguEOb33UncSxA==
X-Received: by 2002:a05:6000:18cf:b0:315:a32d:311f with SMTP id w15-20020a05600018cf00b00315a32d311fmr3840802wrq.14.1689328512354;
        Fri, 14 Jul 2023 02:55:12 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id q10-20020adff50a000000b003144bfbd0b3sm10382483wro.37.2023.07.14.02.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 02:55:11 -0700 (PDT)
Message-ID: <7b5d695e-07da-adba-d9ff-5551102881e1@gmail.com>
Date:   Fri, 14 Jul 2023 10:55:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 02/20] packfile.c: prevent overflow in `load_idx()`
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
References: <cover.1689205042.git.me@ttaylorr.com>
 <d6902cd9e7f7f2a6b8044c8fb782a28c23e15600.1689205042.git.me@ttaylorr.com>
 <5d2cf09f-34c7-9a88-bab2-8bf348dd13bb@gmail.com>
 <ZLAJNbIBFUPHYhlt@nand.local>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZLAJNbIBFUPHYhlt@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/07/2023 15:24, Taylor Blau wrote:
> On Thu, Jul 13, 2023 at 09:21:55AM +0100, Phillip Wood wrote:
>>> diff --git a/packfile.c b/packfile.c
>>> index 89220f0e03..70acf1694b 100644
>>> --- a/packfile.c
>>> +++ b/packfile.c
>>> @@ -186,7 +186,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
>>>    		     */
>>>    		    (sizeof(off_t) <= 4))
>>>    			return error("pack too large for current definition of off_t in %s", path);
>>> -		p->crc_offset = 8 + 4 * 256 + nr * hashsz;
>>> +		p->crc_offset = st_add(8 + 4 * 256, st_mult(nr, hashsz));
>>
>> p->crc_offset is a uint32_t so we're still prone to truncation here unless
>> we change the crc_offset member of struct packed_git to be a size_t. I
>> haven't checked if the other users of crc_offset would need adjusting if we
>> change its type.
> 
> Thanks for spotting. Luckily, this should be a straightforward change:
> 
>      $ git grep crc_offset
>      builtin/index-pack.c:	idx1 = (((const uint32_t *)((const uint8_t *)p->index_data + p->crc_offset))
>      object-store-ll.h:	uint32_t crc_offset;
>      packfile.c:		p->crc_offset = st_add(8 + 4 * 256, st_mult(nr, hashsz));
> 
> The single usage in index-pack is OK, so we only need to change its type
> to a size_t.

That's good, it is nice it is such a simple change

> I could see an argument that this should be an off_t, since it is an
> offset into a file. But since we memory map the whole thing anyway, I
> think we are equally OK to treat it as a pointer offset. A similar
> argument is made in f86f769550e (compute pack .idx byte offsets using
> size_t, 2020-11-13), so I am content to leave this as a size_t.


If we're already using size_t where one could argue in favor of using 
off_t I think that makes sense.

Best Wishes

Phillip

