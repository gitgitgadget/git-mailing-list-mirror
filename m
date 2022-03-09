Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A7CC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 14:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiCIOQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 09:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiCIOQx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 09:16:53 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1065A419B
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 06:15:54 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id yy13so5380779ejb.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 06:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=MaGQ4BHmOUF2cOvgsAQOd9amV9C9w0lW1US+FAtxuE0=;
        b=HgNebGq7zZxfkHLrbWk+IQR8YeDcadpQbLtuv0+01yqPFQ75SzsGtaCFXXqDA4z4xW
         HsQyDFmmMZpldatS5Wo93FGVi+ieIN44/jT5CWRQjqbE6mb1yEDUUH7FDJ7ME37COb3p
         zDy+gAf2B+KIifB04rOTkKd0YeZW8Mf0aPK9cE1cJWrkFV67PDmHv/Rg/Ttox+j4HIVS
         R3J6GGoLFVIw9wULO8Q+kSPoojEL33CKC6em/VCeOj+5e5JND2LWTk1cTWFlWbijZnHu
         uaKp+7zD3FQ5ycA7lcuqu3uyeEVJpTI/ty+KcYN78u4UWm2NZ/0AwM6o0FlxI2eN0xl5
         yyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=MaGQ4BHmOUF2cOvgsAQOd9amV9C9w0lW1US+FAtxuE0=;
        b=AYmVBo41KiT5EcJj8E3tMsOW6vH6L4c60FJpvemCm8Io+kSwIACmyG3w4GQwiTWr1I
         B/F+BPkrhd+5SwDjND6SGwEsyrdw6Lzm2funV2dHWPUCiKRnBFReNu0Eafp1jQWfekDT
         F2HkR4HZeQMvZVOIdFW0vLdueD2gfKGYhMZ5WcjH0xZ5LESMyogFafR0T4iJC6hSpZ2J
         AReEsqA6pxhqNx3X8DiP6L75tjLA0vZLhc5AtMej17mFSKFR2Xj/zGyscMmE6qL20kOL
         S+NxGR/unRmUZVthG6+kJkhwjoYClFb2c7h/mo+N0VYhY8VtgWraKtMFb9CO+F4RtTzF
         +klA==
X-Gm-Message-State: AOAM531+i5M6LFJbKKzkUI5Z1Gi9atT/idme5mY6WlgwQM2/QRTnLLjC
        WNvFgYwXEEPE7HIE+XnMz2k=
X-Google-Smtp-Source: ABdhPJwZi8p+ZpmTvS8AgtiiS8QOyFlekiVlrtiohGm0gjVjFohrHDWogSZKwZmJkQHfpF7+7nkpdg==
X-Received: by 2002:a17:906:a046:b0:6b9:20c:47c1 with SMTP id bg6-20020a170906a04600b006b9020c47c1mr17582354ejb.615.1646835353043;
        Wed, 09 Mar 2022 06:15:53 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7cc0a000000b0040f826f09fdsm864026edt.81.2022.03.09.06.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 06:15:52 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRx6V-000BZr-Rp;
        Wed, 09 Mar 2022 15:15:51 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 16/30] compat/fsmonitor/fsm-listen-darwin: add MacOS
 header files for FSEvent
Date:   Wed, 09 Mar 2022 15:14:40 +0100
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <cdef9730b3f93a6f0f98d68ffb81bcb89d6e698e.1646160212.git.gitgitgadget@gmail.com>
 <220307.86h78a2gcn.gmgdl@evledraar.gmail.com>
 <aa6276f9-8d10-22f9-bfc0-2aa718d002e1@jeffhostetler.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <aa6276f9-8d10-22f9-bfc0-2aa718d002e1@jeffhostetler.com>
Message-ID: <220309.86bkyfmctk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 08 2022, Jeff Hostetler wrote:

> On 3/7/22 5:37 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:
>>=20
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>> [...]
> [...]
>>=20
>>> +#else
>>> +/*
>>> + * Let Apple's headers declare `isalnum()` first, before
>>> + * Git's headers override it via a constant
>>> + */
>>=20
>>=20
>>> +#include <string.h>
>>> +#include <CoreFoundation/CoreFoundation.h>
>>> +#include <CoreServices/CoreServices.h>
>>> +#endif
>> In cache.h which you'rejust about to include we don't include
>> string.h,
>> but we do in git-compat-util.h, but that one includes string.h before
>> doing those overrides.
>> This either isn't needed, or really should be some addition to
>> git-compat-util.h instead. I.e. if we've missed some edge case with
>> string.h and ctype.h on OSX we should handle that in git-compat-util.h
>> rather than <some other file/header> needing a portability workaround.
>>=20
>>> +
>>>   #include "cache.h"
>>>   #include "fsmonitor.h"
>>>   #include "fsm-listen.h"
>>=20
>
> You may be right here.  I commented out the <string.h> and
> the <...CoreFoundation.h> lines and everything still compiled
> and t7527 passed.
>
> I'm not sure why <string.h> was added here (I inherited that
> file when I took over the feature).  It may be that recent SDK
> updates have eliminated the need for it.  Or it may be that it
> was never necessary.  (However, the comment above it suggests
> that there was a problem in the past.)
>
> While it may not (now at least) be necessary, it's not doing
> any harm, so I'd rather leave it and not interrupt things.
> We can always revisit it later if we want.

In terms of figuring out some mysterious portability issue, I think the
right time is now rather than later.

I.e. now this doesn't have anyone relying on it, so we can easily
(re)discover whatever issue this was trying to solve.

Whereas anyone who'd need to figure out why we include string.h on OSX
early in this case later would be left with this otherwise dead-end
thread, and a change at that point would possibly break existing code...
