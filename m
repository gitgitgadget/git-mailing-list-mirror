Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59363C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiG1Qyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiG1Qyf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:54:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6789570E7F
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:54:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id va17so4265470ejb.0
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=rkg6N5RTKGGnO1xsIyznPlUFRwoKCgtnb0I2Hv8e/Dw=;
        b=FdQEHtoHhFSlhHLi97XXlLaUhSBrBVh4+NuEfJ0/rLk+/J+EphvwGQNmShWIm0YHC0
         2KklZowWkB+FMM55QffDLqh4N5bbclxKYeEXVctbH0+h3bGYcBouhzlsHsXG5tCOqjhY
         pC6L4YLTMT8oFP1tlDI4deRR0RCuyhwYI8Rx0hG7ggP/c3RkOZfpynQzhJ7p3jGLrx7Y
         SUOTLeurroTcENvl7HsIhwVk5L13yPY1YZAHYmNWbs1qLqe3cCpAP+B8n9Nu5XEMmoJf
         3ZeSWefhsCtiLov7oI5zaDSHqoSlxci2coVDoTfXeHKnqhmxlJdDUevxz+1ierG5m2L/
         HKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=rkg6N5RTKGGnO1xsIyznPlUFRwoKCgtnb0I2Hv8e/Dw=;
        b=IHiKRiG3r6k2gyQ8zpmiJAWuJjR4e2JPRZuZ/mm87MHLQX+r24Bcbx2iNgAouk6SVx
         Ub4yaOm8cYOBDKnVQci9jFz1C2StE2oa0XRkP7CueLIQWiZuQrsMdEcgJHdUSQBeCbxS
         lH7Ayx21gvahhmcPUBY6ci4shnfawx0VSII/Csbo6ayS5dl/dArbxM6ONQCNoEVuvpoQ
         pg1FmVvgT7ATbi8QvJt1On8TTXasFjGk1X0T5raMeen7yEXzPusg6LDy5v/nhGVVYWyn
         I3HrZmMMnb5GusIRtLa0zvPwLxVAk1hQZ6mzjatLOyX/q3DiC8AYHhVy1GEImiPy2dtt
         m2cw==
X-Gm-Message-State: AJIora88MAg7ok3nA8JaFUezX1CFPhOzY0/S6kiZybpV0Q7BbaH22Sfh
        0QKeyZfEvvoEhX2fq24OHXE=
X-Google-Smtp-Source: AGRyM1tqPLZJ/DpUvOnNrz01zSzufkjNxKvg9XVZMPH9RjUoEDa5k+bVHys5HlwH7/NDGV7vKviJ5w==
X-Received: by 2002:a17:906:8a65:b0:72b:67b7:2c26 with SMTP id hy5-20020a1709068a6500b0072b67b72c26mr21667154ejc.212.1659027272599;
        Thu, 28 Jul 2022 09:54:32 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id l15-20020a170906644f00b0072efb6c9697sm607163ejn.101.2022.07.28.09.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:54:31 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oH6mM-007BR8-Ms;
        Thu, 28 Jul 2022 18:54:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Glen Choo <chooglen@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] CI: add SANITIZE=[address|undefined] jobs
Date:   Thu, 28 Jul 2022 18:52:25 +0200
References: <patch-1.1-e48b6853dd5-20220726T110716Z-avarab@gmail.com>
 <d4dcb1f6-6076-3725-d479-7e9f1fece2a3@github.com>
 <xmqqilnityp0.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqilnityp0.fsf@gitster.g>
Message-ID: <220728.86sfmljhyx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 27 2022, Junio C Hamano wrote:

> Derrick Stolee <derrickstolee@github.com> writes:
>
>>>            - jobname: linux-leaks
>>>              cc: gcc
>>>              pool: ubuntu-latest
>>> +          - jobname: SANITIZE=address
>>> +            cc: gcc
>>> +            pool: ubuntu-latest
>>> +          - jobname: SANITIZE=undefined
>>> +            cc: gcc
>>> +            pool: ubuntu-latest
>>
>>> @@ -277,6 +277,12 @@ linux-leaks)
>>>  	export SANITIZE=leak
>>>  	export GIT_TEST_PASSING_SANITIZE_LEAK=true
>>>  	;;
>>> +SANITIZE=address)
>>> +	export SANITIZE=address
>>> +	;;
>>> +SANITIZE=undefined)
>>> +	export SANITIZE=undefined
>>> +	;;
>>
>> In both of these cases, we are breaking from the nearby pattern. These
>> jobs could be renamed to linux-address and linux-undefined to match the
>> linux-leaks job.
>>
>> Alternatively, we could rename linux-leaks to SANITIZE=leak, since the
>> point is not to test the Linux platform but to use the additional runtime
>> checks (and Linux is the fasted CI platform).
>
> I tend to agree that in the existing linux-leaks job, the
> "linux"-ness is much less important than the "leaks"-ness, so the
> "alternative" might be slightly more preferable, but I do not mind
> the renaming goes the other way, either.

I'm fine with it either way, but to add a prep patch to this series to
do s/linux-leaks/SANITIZE=leak/g would cause a semantic conflict with my
in-flight
https://lore.kernel.org/git/cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com/;
It refers to "linux-leaks" in newly added documentation.

So what would you prefer here, to take a lightly altered re-roll of this
(I think Jeff's suggestion of bundling "undefined" into one job makes
sense), or have it build on top of that otherwise unrelated series, or
just do the s/linux-leaks/.../g as an eventual follow-up?
