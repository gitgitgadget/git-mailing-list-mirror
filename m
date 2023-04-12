Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8460C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 17:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjDLRds (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 13:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjDLRdq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 13:33:46 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6CE5FC6
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 10:33:42 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id f7-20020a4ab647000000b0054101f316c7so5182672ooo.13
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 10:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681320822; x=1683912822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=afsIhIi/3oNVgGsO9ySfKVR186L49lbq0mmespnqqJA=;
        b=WCwtvHrKhN1YcEFcF6WzP13nyF3cRhLLfT4dk6/bFfZohZqsfIUMqUB2QoIcW2mnEv
         kga850x3Z8tOeznvnMf+yI+lBovD9xWOc8I5Oju8tMEGP+8VrjKQgq4DI1EhvYV9wgM4
         vY/9aqxr+vy3Bs2zZ8L68t9bnQK6Chxi6ra2EpGL3lK8MfoDOm2Jd8BuajQj+dDhEijJ
         3Vww3syGeRqs+tlR59BbzeD5m927thxDMz8biEwHI86SaP1JHh1AcqPnKlvVJq4h2xzd
         PsE4JHsMlC6u/KFfkDG7FJlrJopUkhzpxWD0FZL8Cs63WjWzMgAZ0t5VaoZMIHHSfihd
         ESSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681320822; x=1683912822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afsIhIi/3oNVgGsO9ySfKVR186L49lbq0mmespnqqJA=;
        b=jqRxBZN1VMCy28SxjOpUGAgGUL3qyDeLi9TlXW+1vNirbnNDOFw32sCy5Pzfnp+x08
         +tKpZPi7p7wsdqasDrZDm3wnwDbFGAcWWvgbuJ59GccV/6fbi1K6iGwM63ZBch7ThERh
         5z3r6bC8/hxTvUU9Fc306JHk/4+z8wdGxhJmfsaVSCC6ADHR0XWb7ayEXZ/FcTihNLsR
         Hzp4FdRZMYPafwA2yOhMYqY87Rlw11RtriB+PBEOl3bFs/X6AFPcLXDD0dUdMj/6Urk+
         wXb6SrconAs2BbmP9con63ePhgLWESfK7bBOkCZZa5BXFUoDqywrXnJcIe+eshfojwzE
         Rngg==
X-Gm-Message-State: AAQBX9e+Jri4/nIIGcBlVn8hm4umh5dSUYqnfgqe506B/WyyEnB0RkIX
        7c7Ylae6YefpU8ew5JItzVS5
X-Google-Smtp-Source: AKy350b9AF9xsjX+IzC5Tgx0sJS2ftgoWox8Q4AtEBOL/XK1HDjYiXuf0gTavh0KCe2Uf7zvBfxr8w==
X-Received: by 2002:a4a:41ce:0:b0:538:57d4:2d62 with SMTP id x197-20020a4a41ce000000b0053857d42d62mr61050ooa.2.1681320822081;
        Wed, 12 Apr 2023 10:33:42 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l25-20020a05683016d900b0068bd6cf405dsm6755128otr.1.2023.04.12.10.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 10:33:41 -0700 (PDT)
Message-ID: <ba936ba7-b6f6-de57-ddca-accf6cebec72@github.com>
Date:   Wed, 12 Apr 2023 13:33:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/7] pack-revindex: make `load_pack_revindex` take a
 repository
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1681166596.git.me@ttaylorr.com>
 <be4faf11011efcfab479e5785e6c2bbac95309bd.1681166596.git.me@ttaylorr.com>
 <d81c0fe8-580f-dbab-9904-e0ea8459576c@github.com>
 <ZDXRajRky5XtFenU@nand.local>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZDXRajRky5XtFenU@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/11/2023 5:30 PM, Taylor Blau wrote:
> On Tue, Apr 11, 2023 at 09:45:21AM -0400, Derrick Stolee wrote:

>> @@ -581,7 +580,7 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
>>  {
>>  	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
>>
>> -	if (!open_bitmap(r, bitmap_git) && !load_bitmap(bitmap_git))
>> +	if (!open_bitmap(r, bitmap_git) && !load_bitmap(r, bitmap_git))
>>  		return bitmap_git;
>>
>>  	free_bitmap_index(bitmap_git);
> 
> Oops; we are indeed dropping the repository pointer that was given to
> prepare_bitmap_git() here. It's unfortunate that we have to work through
> so many layers to propagate it back down, but I agree that it's the
> right thing to do.
> 
>> @@ -590,9 +589,10 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
>>
>>  struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
>>  {
>> +	struct repository *r = the_repository;
> 
> OK; and here we're using the trick you mentioned in the patch message to
> avoid having to propagate this even further out. The rest of the patch
> looks sensible to me.
> 
> In terms of working this one in, it feels odd to include it as a
> separate commit since we know the one immediately prior to it is kind of
> broken.
> 
> Do you want to squash these together? Something else? Anything is fine
> with me here.

Feel free to squash it in, to avoid having a commit where the chain is
broken.

Thanks,
-Stolee
