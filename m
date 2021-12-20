Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE6BC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 20:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhLTUJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 15:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhLTUJb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 15:09:31 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC59C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 12:09:31 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id u74so17469624oie.8
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 12:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gHMCG9ofz1AUqd6B67qyomh2JlqYfO4ayUcmO/VseIE=;
        b=dWQ/SOdt+3wzscYGy8RMnzEaa38qU8hsM8MCKKyT84rPPg5W6gPoUGP741XAphyt5H
         lbHuRAAJ+F+lruZLH5czPG1CLu1HJeOGb1bytpbGKL7UFEIu957LB0nZBc1FR4z6nWXc
         1oTTmKFhOAuFwuMGUoBgS5JzNckHeTKEwNucXYSkFi6GMDtuZs0zrYyRQn/DxAstRTUE
         l8ySF9HW1vnJ4Maj9GBL/O+PDcnVUYS9dhsVVPxvEnzz5oauL+tg1goskZzEQzbO3bcw
         l49A/wISwUgJgAgAxkR28+y8d+BjB1LwxjgMONWpoxzYnDG2e3QD5QBJk/+1GmJ0FBzr
         OCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gHMCG9ofz1AUqd6B67qyomh2JlqYfO4ayUcmO/VseIE=;
        b=kTIe2DWKfiiK6Plx0uCQCuVeJuHq61o3/izLrD7gaYESPnT4cGJbwe++vxF/4/vftE
         rXX74MleyEKG7YowHUlugpe2Yam0AImwFZx8CTwW4ZKS+IXJCLFxTNNSe4S8NTLj5LsX
         Mv/htgcZ66yendUvrGvISym53RDrp+JpZez8ROsvWVAyG4VFOH0ZgkxfMsvNvm7ZddAh
         9MmvsvEUiYKp5ofw5zo7+9psvv6EN9mRve8IOFKyN0lZHEWgisk25lskT4ZDjnzYSDUA
         cT1P5LyWAdUmTIamKXp4txhehfZxNGsLc+SI4/uZnOKdpZW4Bb2txkSSSMbMUNQgHUwg
         VZ5g==
X-Gm-Message-State: AOAM533lRc9sBsklUCczZlanbCQjoFrY4cP6QrqRYMKam9/auR10V46J
        9a/QC3pgYFVLOBKO4kW/AlI=
X-Google-Smtp-Source: ABdhPJw2otkz9Zk4WEGNJwminl5E9sjMZGBNblM0H3A0hSMnyN8MX8750WcK2roOg3i0z+5Vcpw/Sw==
X-Received: by 2002:aca:d6cb:: with SMTP id n194mr578698oig.60.1640030970260;
        Mon, 20 Dec 2021 12:09:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1dd9:8fb3:37da:4055? ([2600:1700:e72:80a0:1dd9:8fb3:37da:4055])
        by smtp.gmail.com with ESMTPSA id bd6sm3739858oib.53.2021.12.20.12.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 12:09:29 -0800 (PST)
Message-ID: <c729fbc5-9f59-27d3-5f1b-0b339446174e@gmail.com>
Date:   Mon, 20 Dec 2021 15:09:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/8] midx: prevent bitmap corruption when permuting
 pack order
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1639446906.git.me@ttaylorr.com> <xmqqee6d648n.fsf@gitster.g>
 <886da3f3-aa6a-ac74-2aa2-26abdf832ebd@gmail.com>
 <YcDe9wl4XwH7PjX1@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YcDe9wl4XwH7PjX1@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20/2021 2:52 PM, Taylor Blau wrote:
> On Mon, Dec 20, 2021 at 01:51:22PM -0500, Derrick Stolee wrote:

>> 3. Should the chunk be made mandatory?
>>
>> Unfortunately, the chunk format did not follow the index format's
>> example of making lowercase chunk IDs required. Instead, the chunks
>> that are necessary for v1 are necessary forever and all other chunks
>> are deemed optional. Changing this would require something more
>> drastic like updating the version number or giving some grace period
>> where released versions start treating lowercase chunk IDs as required
>> before creating a new "required" chunk.
>>
>> This does mean that if there is a version incompatibility, the RIDX
>> chunk will just be ignored by the older version of Git.
>>
>> In terms of making this a safe format upgrade, I think Taylor has
>> achieved that.
> 
> Thanks. And yeah, the chunk should (and is) mandatory when writing a
> MIDX bitmap. But if we ran `git multi-pack-index write` without
> `--bitmap`, then we would be free to not write the RIDX chunk (and
> indeed that is what we do).

I just want to be careful of the language here, with respect to how
chunks are listed as required or optional in
Documentation/technical/pack-format.txt. "Required" means every MIDX
needs one or is invalid. "Optional" means that all versions of Git
should ignore the chunk if it does not recognize the ID.

So here, the new RIDX chunk will be ignored by older versions and
will be written only when we care about bitmaps.

(Nothing I say here is in conflict with what you said, but I
anticipate confusion with your use of the word "mandatory".)

>> The only thing I can think is that server operators might want to
>> deploy this version with GIT_TEST_MIDX_WRITE_REV=1 for a while, so
>> any need to downgrade would not suffer a performance penalty for a
>> missing .rev file. If that is a planned way to safely deploy this
>> change, then it might be worth adding a test that we safely delete
>> a .rev file after writing both a .rev file and a RIDX chunk. (The
>> RIDX chunk will be preferred, so maybe the previous .rev file hits
>> some logic that would skip its deletion?)
> 
> That logic (that we delete auxiliary files--including the .rev file--not
> matching the checksum of the MIDX we just wrote) is unchanged. So I
> think we should be good there since we have existing coverage.

Sounds good.

Thanks,
-Stolee
