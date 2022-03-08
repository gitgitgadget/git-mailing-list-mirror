Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84261C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 21:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350337AbiCHVKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 16:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbiCHVKg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 16:10:36 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A35049C8D
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 13:09:39 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C57843F4163;
        Tue,  8 Mar 2022 16:09:38 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4ADE53F4161;
        Tue,  8 Mar 2022 16:09:38 -0500 (EST)
Subject: Re: [PATCH v6 16/30] compat/fsmonitor/fsm-listen-darwin: add MacOS
 header files for FSEvent
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <cdef9730b3f93a6f0f98d68ffb81bcb89d6e698e.1646160212.git.gitgitgadget@gmail.com>
 <220307.86h78a2gcn.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <aa6276f9-8d10-22f9-bfc0-2aa718d002e1@jeffhostetler.com>
Date:   Tue, 8 Mar 2022 16:09:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <220307.86h78a2gcn.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/7/22 5:37 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>> [...]
[...]
> 
>> +#else
>> +/*
>> + * Let Apple's headers declare `isalnum()` first, before
>> + * Git's headers override it via a constant
>> + */
> 
> 
> 
> 
>> +#include <string.h>
>> +#include <CoreFoundation/CoreFoundation.h>
>> +#include <CoreServices/CoreServices.h>
>> +#endif
> 
> In cache.h which you'rejust about to include we don't include string.h,
> but we do in git-compat-util.h, but that one includes string.h before
> doing those overrides.
> 
> This either isn't needed, or really should be some addition to
> git-compat-util.h instead. I.e. if we've missed some edge case with
> string.h and ctype.h on OSX we should handle that in git-compat-util.h
> rather than <some other file/header> needing a portability workaround.
> 
>> +
>>   #include "cache.h"
>>   #include "fsmonitor.h"
>>   #include "fsm-listen.h"
> 

You may be right here.  I commented out the <string.h> and
the <...CoreFoundation.h> lines and everything still compiled
and t7527 passed.

I'm not sure why <string.h> was added here (I inherited that
file when I took over the feature).  It may be that recent SDK
updates have eliminated the need for it.  Or it may be that it
was never necessary.  (However, the comment above it suggests
that there was a problem in the past.)

While it may not (now at least) be necessary, it's not doing
any harm, so I'd rather leave it and not interrupt things.
We can always revisit it later if we want.

Thanks,
Jeff
