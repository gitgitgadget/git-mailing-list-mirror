Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9B5C4332F
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 08:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJKIcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 04:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJKIcR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 04:32:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C8B84E4D
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 01:32:15 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id d26so22665189eje.10
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 01:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gNf6UeK12ewipXmUnpY6aNBh58SYktNzyc2bymbp2jI=;
        b=Z8UmMPJvBpA7vEsoPXDRNrwg310x1c1wffFQ8l3tDuwjYQ+0LOXzRkO/eyfFN8KLbY
         2PfOsflI5uYIikFPYQ/BQf7JvYStNBepxdiLEcKYjDxMHDLDZrFmP2Scox7G3oJnUnZi
         9FNbSC6a6DtwMc0wwOP4EIr8Zsvl3yd6bwO77JAs7Z7ZfA8mnroucRlarzrdhL+blmsA
         d7b5tFG15NB9xYdWGMezYstTXq2BOAGUzqfdSBUngiU4dGsS1Ufl3/80YlmXk6XVuyIw
         7KnzE/KZ1w6lK4gC44KZ4QMaarC5jWQcQKN+K+3mvjUzisnQomaMA2BClbvtwxvaGxC7
         ZSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNf6UeK12ewipXmUnpY6aNBh58SYktNzyc2bymbp2jI=;
        b=K3v3liPzg/Eo/CAvXnfxG9d9RkJ6AjYkX2eTdKV4PHvbAW4q4XgPR/OveNOi55KibC
         JhV0o06GDIl9s0L0kJrF0qJGeC3cr8iIZ9oodf64VA49nFXaRRssKoxL1uLh98dAumnN
         hRIzQW02mXUlHKDj2qSuo9LEZTHK1mQZHygkHti9vd09pevwYfICqttH4lEHWK2mq//9
         zb6Jc7rOaR2Ipy0EfvOPmLGQDSNf4IVLhA78GgzFSOCusybS7hmEPHPaN1iyQqoanwQc
         l4/QWg2sG1/krw+hm/pJhfs+j6nUD/gwW3wwleRy/ye6GifTXZo269nY3W5y4k8o2ReK
         9c6g==
X-Gm-Message-State: ACrzQf3Mhed4gIy5oheP3zm0Tw+IBCev3DFqwytg24wr5H4mX05E6gDO
        eciuwkImEvTKfxXl8c7HiA4=
X-Google-Smtp-Source: AMsMyM6dwjPDOBiOV7CjW2YjD5QwqGW/3XeDWde498R5Xz0Gyu5qMC7Pqj21f7AzweUYVNmu5sz/3Q==
X-Received: by 2002:a17:906:4795:b0:787:434f:d761 with SMTP id cw21-20020a170906479500b00787434fd761mr17959786ejc.597.1665477134086;
        Tue, 11 Oct 2022 01:32:14 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id q13-20020a5085cd000000b00458c7d569f7sm8500864edh.60.2022.10.11.01.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 01:32:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiAgO-003lwF-28;
        Tue, 11 Oct 2022 10:32:12 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 5/5] CodingGuidelines: recommend against unportable
 C99 struct syntax
Date:   Tue, 11 Oct 2022 10:30:34 +0200
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
 <20221010203800.2154698-1-gitster@pobox.com>
 <20221010203800.2154698-6-gitster@pobox.com>
 <Y0S0Tpn/uCjG9J61@coredump.intra.peff.net> <xmqqlepnxl1f.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqlepnxl1f.fsf@gitster.g>
Message-ID: <221011.86bkqipxpv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 10 2022, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> On Mon, Oct 10, 2022 at 01:38:00PM -0700, Junio C Hamano wrote:
>>
>>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>>> index 9598b45f7e..cbe0377699 100644
>>> --- a/Documentation/CodingGuidelines
>>> +++ b/Documentation/CodingGuidelines
>>> @@ -242,6 +242,10 @@ For C programs:
>>>       printf("%"PRIuMAX, (uintmax_t)v).  These days the MSVC version we
>>>       rely on supports %z, but the C library used by MinGW does not.
>>>  
>>> +   . Shorthand like ".a.b = *c" in struct assignments is known to trip
>>> +     up an older IBM XLC version, use ".a = { .b = *c }" instead. See
>>> +     the 33665d98e6b portability fix from mid-2022.
>>
>> FWIW, the use of the word "assignment" here left me scratching my head.
>> Reading 33665d98e6b, it is about struct initialization.
>
> Thanks, I missed that confusion in the new description.  Perhaps
> another round of reroll would make the series polished enough?

I could re-roll it, but I also see you extensively fixed it up v.s. my
version. I think a re-roll here would just be
s/assignments/initializations/, so if you wanted to squash that in to
your already extensive squashes...

...or I could also re-roll it, up to you. Just let me know what you'd
prefer, thanks!
