Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F40EDE9A1
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 10:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjINKte (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 06:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjINKtd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 06:49:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59A51FCE
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 03:49:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-307d58b3efbso705720f8f.0
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 03:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694688567; x=1695293367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gKmKcesYVKl5Q8lESATslYcF0FweW0naMZ+dst0oxQo=;
        b=Q3pNeviyBh3bMLsiCFz5DaIT3EsNz+LHyesBSAB9YlmySd/bGTabhcfd15twKyDtMv
         SuKyBh/LT76FeM4tCBepJehcbrLvPEeCsO3GfrG9PsNjKl7VSlZb8Y5YvuU8grpMUeYr
         opgh7Xt4YHmx9GEJz2dWJFqFJeQPpCYL0Yxc3ZrKp/oBAk/kUYy3eRjrTME27tSlwj/L
         fcM2dpR9J7//zJ+BDnwPHpt1PaAwsh0zyw/cFzSTkdxC4uXl5AdwUuBhuzdB3n6w5OgH
         mLlxG9LqHvsPH5fjqdXQL4jxnKJICmSXy7o2dZvFnkavZdVPI4YH0NrgUrBvxil5UQWo
         HlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694688567; x=1695293367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKmKcesYVKl5Q8lESATslYcF0FweW0naMZ+dst0oxQo=;
        b=C4VHB+1Qnb87Ao7GIMcc8kHDFKnIcDBFV4vIKHT8bPfAaL4YmEaGKHkkPnLoBzRryA
         9fbIyhitdGEAo602OdHY4uq0EbsPOnGdbBoY6F0cquNoVtMEEvUvXHvxJDtIjQx8Ln2a
         53BIqVeTcJ4pncfxPIll8B4Ny40Uj4EKWtN1qd7DoB7HQm8oyKPFitW9EGQonk0r8JGe
         O1CyVBpmkjSrKCgiGQ5FjT0/zL57wowSFBfJVFpXy+gMUmWNEvnAi51jTSjKYKUxyguX
         H3JGnoZFmJsVKXK28NRZr41j62yN8vYrjP5o6HXwMU5emeCr6CfWvV0d3hzOdZab9XJ4
         zrSw==
X-Gm-Message-State: AOJu0Yzz1kbSWAfIEVagGNdmZvH6hX5wXrNM7ccYywV/cq6XVkpgrkLi
        aTba/rcU1+6rlii7+2TkrUM=
X-Google-Smtp-Source: AGHT+IF5o7/bowcayyUYHBdrYgpuDqnoFtLZYHQ/QJvGIzYB0aqZXoOEy2G8jyZXQz/sgMRLDIuzqA==
X-Received: by 2002:a5d:4950:0:b0:31a:e6c2:7705 with SMTP id r16-20020a5d4950000000b0031ae6c27705mr4047663wrs.50.1694688566958;
        Thu, 14 Sep 2023 03:49:26 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id t3-20020a5d5343000000b00317ab75748bsm1438118wrv.49.2023.09.14.03.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 03:49:26 -0700 (PDT)
Message-ID: <9f59df48-77be-485b-9208-6e2082af5963@gmail.com>
Date:   Thu, 14 Sep 2023 11:49:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] replacing ci/config/allow-ref with a repo variable
Content-Language: en-US
To:     Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20230830194919.GA1709446@coredump.intra.peff.net>
 <8624fc43-ab42-442b-a141-851fc35dd24f@gmail.com>
 <20230901173214.GA1947546@coredump.intra.peff.net>
 <d3d1109b-3a1f-4e8b-be8d-6581d45f1b81@gmail.com>
 <20230905072444.GH199565@coredump.intra.peff.net>
 <fcdc682b-cf6c-4db9-9970-be136f48de58@gmail.com>
 <20230911093616.GA1605460@coredump.intra.peff.net>
 <59b423e9-d99e-4817-8a33-c50419593740@gmail.com>
 <20230914003010.GA1709842@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230914003010.GA1709842@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/09/2023 01:30, Jeff King wrote:
> On Wed, Sep 13, 2023 at 04:16:48PM +0100, Phillip Wood wrote:
> We can do the loop-unroll thing if we really want to support multiple
> prefixes, but if you're OK with it, let's try the single-prefix way and
> see if anybody runs into problems (I'm still convinced there's only a
> few of us using this stuff anyway). I'm hesitant to do the unroll just
> because it requires picking a maximum value, with a bizarre failure if
> you happen to have 4 prefixes or whatever.

Lets start with a single-prefix and see if anyone complains

>> Aside: what I'd really like is to be able to set an environment variable
>> when I push to skip or force the CI
>>
>> 	GITHUB_SKIP_CI=1 git push github ...
>>
>> but that would require support from the git client, the protocol and the
>> server.
> 
> We have the necessary bits at the protocol: push-options. But it's up to
> the server-side hooks to decide which ones are meaningful and to do
> something useful with them. It looks like GitLab supports:
> 
>    git push -o ci.skip=1 ...

Oh I didn't know about that

> but I don't think GitHub respects any equivalent option.

That's a shame

Best Wishes

Phillip
