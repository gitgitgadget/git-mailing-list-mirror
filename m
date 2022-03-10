Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AF0C433FE
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 14:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244940AbiCJOzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347950AbiCJOvh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 09:51:37 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00F93A1BE
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:50:35 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bg10so12649881ejb.4
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Ja9D/jv9nS1w/AAdFeMzjTaxqy8H1/8sh3BbEWXOABE=;
        b=aIJZJ5BflV7wktyy5AvlDYmPYCD4rgT7gnNofu6byWQhH9pyt0xWuUo6C2B05FZtVs
         zWvVb9KJ6d6EcHxG7cpUj161F4REkT4eRBKuQwhoJGMm8JzsSIHu5lshvzRwHzlFWaRK
         rNv9PGBAJbHcbJOjR4ugwupZhKbp5o8/Axz00trdiDiVs/Lpme+r4GWglzzW8K8j3E4R
         4V3q6Yk6nXinRPPCw9hr+DeoawUdDXpataUNpqi9FVIs1f3zBBVw26e340HKotAgTWME
         onKmIEu4eBYp5i2zaUy1Krqws85waSj/REWTm9rb+kU1kHhuUzgVj9THx1IHUhtUc6Pe
         ZCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Ja9D/jv9nS1w/AAdFeMzjTaxqy8H1/8sh3BbEWXOABE=;
        b=azoBdsBS7DqGWnvqrm3YjvkLx9cxgNXlMLx0uK3zRMsWU5f3Td2gcCXxcIJRmf9iAF
         P9ipBuzed6/1Todboq1iL+KR/R2MBDbPXnTVM8arEi80rz6m43GI+ooFPGKDDpb+G0aV
         mxYCX82z+guACziEW5ipqo9H6WII+YiEKtgADhEZsmFmOWGjBFLBz/PlMc4zB9m9VJSb
         C2x8MmMEnq48a7CAWCfylD7HzvDwXaWlyahwEgOMWjR81ZEIRXtJzNlb5trG+zCLSDqN
         95E2CU8KKRdE7QH89+EZDhsHwAXI5wJL2sTmeOW7A8OTcEI2YvoS/mkR8x21uUqtgl7e
         LCMw==
X-Gm-Message-State: AOAM533vXNkt2qTwyQsEeVMFZRTJq/C1hluIc3uF0UxjyhuNe7+2q+L9
        2j+W4TeqwY/0PxketTPBjbg=
X-Google-Smtp-Source: ABdhPJwJ3RLa7EQP4AH0CohXw4I3kGaRRYIfjZT6/aFyOsW3RZQuaviz5TvwBTm6jn3wHvl9JA+XKg==
X-Received: by 2002:a17:907:3ea3:b0:6da:6f16:bd9b with SMTP id hs35-20020a1709073ea300b006da6f16bd9bmr4592048ejc.308.1646923834228;
        Thu, 10 Mar 2022 06:50:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m19-20020a1709062ad300b006d1289becc7sm1821234eje.167.2022.03.10.06.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 06:50:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSK7c-000XKl-Kf;
        Thu, 10 Mar 2022 15:50:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 16/30] compat/fsmonitor/fsm-listen-darwin: add MacOS
 header files for FSEvent
Date:   Thu, 10 Mar 2022 15:42:00 +0100
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <cdef9730b3f93a6f0f98d68ffb81bcb89d6e698e.1646160212.git.gitgitgadget@gmail.com>
        <220307.86h78a2gcn.gmgdl@evledraar.gmail.com>
        <aa6276f9-8d10-22f9-bfc0-2aa718d002e1@jeffhostetler.com>
        <220309.86bkyfmctk.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2203101445360.357@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2203101445360.357@tvgsbejvaqbjf.bet>
Message-ID: <220310.86a6dxkgjr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 10 2022, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Wed, 9 Mar 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Tue, Mar 08 2022, Jeff Hostetler wrote:
>>
>> > On 3/7/22 5:37 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >> On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:
>> >>
>> >>> From: Jeff Hostetler <jeffhost@microsoft.com>
>> >>> [...]
>> > [...]
>> >>
>> >>> +#else
>> >>> +/*
>> >>> + * Let Apple's headers declare `isalnum()` first, before
>> >>> + * Git's headers override it via a constant
>> >>> + */
>> >>
>> >>
>> >>> +#include <string.h>
>> >>> +#include <CoreFoundation/CoreFoundation.h>
>> >>> +#include <CoreServices/CoreServices.h>
>> >>> +#endif
>> >>
>> >> In cache.h which you'rejust about to include we don't include
>> >> string.h, but we do in git-compat-util.h, but that one includes
>> >> string.h before doing those overrides.
>> >>
>> >> This either isn't needed, or really should be some addition to
>> >> git-compat-util.h instead. I.e. if we've missed some edge case with
>> >> string.h and ctype.h on OSX we should handle that in git-compat-util.h
>> >> rather than <some other file/header> needing a portability workaround.
>> >
>> > [...]
>> >
>> > While it may not (now at least) be necessary, it's not doing
>> > any harm, so I'd rather leave it and not interrupt things.
>> > We can always revisit it later if we want.
>>
>> In terms of figuring out some mysterious portability issue, I think the
>> right time is now rather than later.
>
> I do not see that.
>
> In FSMonitor, this was clearly a problem that needed to be solved (and if
> you try to compile on an older macOS, you will run into those problems
> again).

So you can reproduce an issue where removing the "#include <string.h>"
from compat/fsmonitor/fsm-listen-darwin.c has an effect? Does swaping it
for "ctype.h" also solve that issue?

I was asking why the non-obvious portability hack was needed, and it
seems Jeff suggested it might not be upthread in
<aa6276f9-8d10-22f9-bfc0-2aa718d002e1@jeffhostetler.com>, but here you
seem to have a reproduction of in being needed, without more of the
relevant details (e.g. what OSX version(s))?

> If you are talking about the mysterious portability issue with an eye on
> `git-compat-util.h`, well... you can successfully compile Git's source
> code without this hack in `git-compat-util.h`. That's why the hack is not
> needed. Problem solved. Actually, there was not even a problem.

Do you mean we don't need the ctype.h overrides in git-compat-util.h at
all? I haven't looked into it, but needing to

>> I.e. now this doesn't have anyone relying on it, so we can easily
>> (re)discover whatever issue this was trying to solve.
>>
>> Whereas anyone who'd need to figure out why we include string.h on OSX
>> early in this case later would be left with this otherwise dead-end
>> thread, and a change at that point would possibly break existing code...
>
> Anyone who would need to figure out why we `#include` this header early
> would read the comment about `isalnum()`, I would hope, and understand
> that there are circumstances when Git's `isalnum()` macro interferes with
> Apple's, and that this `#include` order addresses that problem.
>
> They might even get to the point where they find
> https://github.com/dscho/git/commit/0f89c726a1912dce2bdab14aff8ebfec85503=
40d,
> maybe even the "original original" commit at
> https://github.com/kewillford/git/commit/d11ee4698c63347f40a8993ab86ee4e9=
7f695d9b,
> which was a still-experimental version of the macOS backend, and where the
> `#include` order clearly mattered, else why would Kevin have bothered.
>
> Further, I strongly suspect that it had something to do with
> `CoreFoundation.h` or with `CoreServices.h` being `#include`d, and if you
> care to check the code above the quoted lines, you will see that you
> cannot even `#include` those headers using GCC, it only works with clang:
> https://github.com/jeffhostetler/git/commit/cdef9730b3f93a6f0f98d68ffb81b=
cb89d6e698e#diff-4e865160016fe490b80ad11273a10daca8bc412a75f2da4c6b08fb9e5e=
3b5e18R3
>
> At this stage, anybody investigating this issue who is a little bit like
> me would then be a bit bored with the investigation because there is
> actually no breakage here, just a curious `#include` order, and nothing
> else. So they might then drop it and move along.

My implicit observation upthread is that those sorts of details would
ideally be included in a comment or the commit message. I.e. I didn't
quite see why it was needed, and neither could the person submitting the
patch series when asked.

Sure, it's a minor issue, but patch review is also meant to uncover such
small issues.
