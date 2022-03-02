Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC23C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 18:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244513AbiCBSx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 13:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242007AbiCBSx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 13:53:57 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2105AEDC
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 10:53:13 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id j2so2593218oie.7
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 10:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oQHH9kgj1vW521UM93TZcWfbfoRNmW3SgOY7sviFc5U=;
        b=WYld/ZDL7HM7yjFybVR7/vS0uvE7cl+IBDoWlZ+dXISvwOGcY1AkGKgOC25QTBUmLa
         PWcM4FtpAd2YAm3RDtXhCPhcQxJecwWrFrlhgb0EnG0zQqdkjKxIgXPsZSecWkzCUKra
         tRBqW4Ovgz27ProvUpcltJBUC9fgK97PVoIN177qqM0a1i4rKxJagRo8kOOh8oCkUYDj
         SPegBbVCgyv6JMcL2fcJmZlvD9waulOuKZ2nrR79cVyymoqsGczw7hxHt1M2d9WwJVqS
         HubZhkH7cTWObA0Mdme3nzufOHC9MDbVlBuVwak+qQwu6GN6b9K6RrGWLuMA7bL51pnM
         bIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oQHH9kgj1vW521UM93TZcWfbfoRNmW3SgOY7sviFc5U=;
        b=NFrP670mecFvw3kjJj+dYP4gBVg3bWxOBqfaIuh+F14ZnDDI2HDT9thxaGRUDkopN1
         e6jiW3/xFMlMCQn60Wvti+vycu51jtbDi55z0XWeidRTgU3IrhbrRAaJTzKkiVWsNMLX
         oBZr9GYX27JgtJDROOpopPNZ8dHE9XRvJEXSQxTF5fhnAM1aEy5MrzPkqn22HG25CYhg
         eqmaB1+Ah4o9bMFaXr1464Dz3wBHIE1RsUTzfThmNK9OLHse/8ZpPyree0cRtnJ/rZpo
         IwHDEKFHKRaAqy5g15FwL1a07WbqGBoozgoomQUBQfBUFlyXKPkjIjhtxXC7rJltRbYJ
         wyvw==
X-Gm-Message-State: AOAM533Nn4xDwLUlc44jGG4pCnZ9M6QN8ryc9e7YBGSP8PKaoTY1abnY
        JJchf5GDTh57eA6Ca7N89x1Kf8PJEL+j
X-Google-Smtp-Source: ABdhPJxOpMy2Js2kz3B7WnscPckgnwtjOguPP8u9zmL83xMawcWWLdCK0oQdymIL/R9m350w671SNg==
X-Received: by 2002:a05:6808:30a3:b0:2d5:2019:97ac with SMTP id bl35-20020a05680830a300b002d5201997acmr1205327oib.40.1646247192667;
        Wed, 02 Mar 2022 10:53:12 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id n22-20020a056870e41600b000d6d4ac3c64sm7252214oag.39.2022.03.02.10.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 10:53:12 -0800 (PST)
Message-ID: <9a3b8e63-6b61-5e7a-ec71-3777f5bc45f7@github.com>
Date:   Wed, 2 Mar 2022 13:53:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/5] upload-pack: look up "want" lines via commit-graph
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
References: <cover.1645619224.git.ps@pks.im>
 <ca5e136cca495c7d927e99f5ae8a672d93823eea.1645619224.git.ps@pks.im>
 <ddb91a1d-6ddf-ba25-f1af-ba3f4c18726e@github.com> <Yh3cprbfc/UQ01fo@ncase>
 <Yh3mR3/h/+nFyF6V@ncase>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yh3mR3/h/+nFyF6V@ncase>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2022 4:24 AM, Patrick Steinhardt wrote:
> On Tue, Mar 01, 2022 at 09:43:19AM +0100, Patrick Steinhardt wrote:
>> On Wed, Feb 23, 2022 at 09:13:53AM -0500, Derrick Stolee wrote:
>>> On 2/23/2022 7:35 AM, Patrick Steinhardt wrote:

>>>> -		o = parse_object(the_repository, &oid);
>>>> +		commit = lookup_commit_in_graph(the_repository, &oid);
>>>> +		if (commit)
>>>> +			o = &commit->object;
>>>> +		else
>>>> +			o = parse_object(the_repository, &oid);
>>>> +
>>>
>>> This is a neat trick. I see that we've also done this trick in
>>> revision.c:get_reference(). Perhaps it is worth creating a helper,
>>> maybe named parse_probably_commit()?
>>
>> That might be a good idea, thanks. I'll have a look at what the end
>> result would look like.
>>
>> Patrick
> 
> I had a look at existing callsites which use `lookup_commit_in_graph()`,
> but I found that it wasn't easily possible to convert them all to use a
> new helper like you propose. Most of them have some custom logic like
> skipping `parse_object()` if it's part of a promisor pack, so I really
> only found two locations where such a new helper could be used without
> also adding and supporting flags. I don't really think that's worth it
> for now.

Thanks for taking the time to look into it.

-Stolee

