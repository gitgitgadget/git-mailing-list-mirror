Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7A0C43331
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 15:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BAA2233A2
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 15:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbhATOvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389850AbhATOa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 09:30:26 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82BBC0613D3
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 06:29:45 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c124so3012479wma.5
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 06:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tgRXFEu3s1uhTfyeoMqtDFgV8ehw0xGXfEMZPjOJFgY=;
        b=qhUOTM+HTgPR06+NAO5fOGPCWLOCCTpVcB/fr1RJVpk71gBOnAgHnMR1Q1Ank42bVo
         NpiN8bW1NcAd98wq26tL+nGewIqywf03nw+0IBjfVKfOLJ/yNgBMdwymzzvVw3oo6Ubi
         52DekYyC/evlndc9SFMZmcU97RO1WFyvtzjjrgCFOOsX/eOghSLzA9xGUX4PlJJqEqrP
         EnGOn2YSRx1J8js6HjdY8jfCYq6kezT8oORTLwCxTCC288yBM+XVkiVmwoM37mpkIK9T
         WCVG83S6FvlXz+f+yVrLK01qpdpvVJjZN8qmMNz7L0uRLDj2uBuy4G7CyCDgzdY/CQmD
         bwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tgRXFEu3s1uhTfyeoMqtDFgV8ehw0xGXfEMZPjOJFgY=;
        b=d+uz+FplXobg7Jv5MS7JrRXl16FYhffy+Laq9LYrQMZP8bqYQwkoxhXROhPlIm3Ht/
         KhWCltu5/amfkelNwH8E6V8Fz03laCjTG2abiLbMaWd9CPqhLaaaJrnE1NWpQTlJYVwj
         nnQgA0aAoOLUXgOQR3ZQ4+yAFzWMSKWsARzMC5Nsl/G/2PqFvd1E86tjdM5Yu01VjueS
         Q5a1/CTNqn5bn//UpAIrT4+T0M0dxkhLFOzaUUiqfH0vh3dCBgVLvCTlUUXyANJer2Cj
         xj6R9uZ6LGDKJhWLd7h2bXCyJnjr20jPhczduvaHcq9oHor9Z1xlchXNkfRMKMSenY3o
         +mdQ==
X-Gm-Message-State: AOAM532S/UZHTzHavsLTExwxhaWIJCaDj/2X/7pSOLQA42jhizPl3W0F
        oiwAbFhtYVirMPHpj313os1usTx7GD4=
X-Google-Smtp-Source: ABdhPJw6pEbq1+rYjCtsUYYgYrlhNBQUIbgVtFepWiJLm7vNpi3e5kb2qts7zpM1M6/+PkfDcrg8Tg==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr2232847wmh.47.1611152984498;
        Wed, 20 Jan 2021 06:29:44 -0800 (PST)
Received: from [192.168.1.240] (112.16.7.51.dyn.plus.net. [51.7.16.112])
        by smtp.gmail.com with ESMTPSA id c7sm4808011wro.16.2021.01.20.06.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 06:29:32 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 9/9] doc/git-rebase: add documentation for fixup
 [-C|-c] options
To:     Charvi Mendiratta <charvi077@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Marc Branchaud <marcnarc@xiplink.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20210108092345.2178-1-charvi077@gmail.com>
 <20210119074102.21598-10-charvi077@gmail.com>
 <8fd2b72c-d1d0-98be-e6a5-fb7dc699d5d5@xiplink.com>
 <CAPSFM5euGE_bUDPgdzx4-q5zYtkDymHdJP9rw-YkVVVzpOKWkw@mail.gmail.com>
 <7c11da69-d2f1-0aab-80bc-d8ae8735f8ca@gmail.com>
 <CAPSFM5f9JJk5xY-f2mNwHjZZfo-=LzSCpA2Q73T-ASGMxfqqeg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <fda55ef5-ce37-67c0-f49b-fc2e5172853b@gmail.com>
Date:   Wed, 20 Jan 2021 14:29:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAPSFM5f9JJk5xY-f2mNwHjZZfo-=LzSCpA2Q73T-ASGMxfqqeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Charvi

On 20/01/2021 12:31, Charvi Mendiratta wrote:
> Hi Phillip,
> 
> On Wed, 20 Jan 2021 at 16:34, Phillip Wood <phillip.wood123@gmail.com> wrote:
> 
>>> [...]
>>> Similarly, if we have sequence like `fixup -c`, `fixup -c`, `fixup -c`
>>> then also it will fixup
>>> up all the content and here it allow user to edit the message, so
>>> opens the editor once
>>
>> It is good that we only open the editor once in this case - I'd not
>> thought about chains of `fixup -c` before reading this. Do we have a
>> test to verify that the editor is only opened once?
>>
> 
> No, we don't. But I also agree, it's a good idea to add a test for it.
> I think may be one sequence with 'fixup -C', 'fixup -c', 'fixup -c'
> and the other 'squash' , 'fixup -C', 'fixup -c', is sufficient for
> testing.

Those are both good sequences to test. I think we should check 'fixup 
-c' 'fixup' as well - with 'squash' 'fixup' we open the editor after the 
fixup so the user can see all the changes that will be committed when 
they edit the message, we should do the same for 'fixup -c' 'fixup'. 
Also 'fixup -c' 'squash' might be worth testing as well.

Best Wishes

Phillip


  Or any other suggestions for testing it ?
> 
> Thanks and regards,
> Charvi
> 
