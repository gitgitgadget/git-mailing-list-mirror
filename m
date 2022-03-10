Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5C3C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 15:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbiCJPng (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 10:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbiCJPne (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 10:43:34 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018592A0
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 07:42:29 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 61F2E3F4114;
        Thu, 10 Mar 2022 10:42:29 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D842D3F4096;
        Thu, 10 Mar 2022 10:42:28 -0500 (EST)
Subject: Re: [PATCH v6 16/30] compat/fsmonitor/fsm-listen-darwin: add MacOS
 header files for FSEvent
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <cdef9730b3f93a6f0f98d68ffb81bcb89d6e698e.1646160212.git.gitgitgadget@gmail.com>
 <220307.86h78a2gcn.gmgdl@evledraar.gmail.com>
 <aa6276f9-8d10-22f9-bfc0-2aa718d002e1@jeffhostetler.com>
 <220309.86bkyfmctk.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2203101445360.357@tvgsbejvaqbjf.bet>
 <220310.86a6dxkgjr.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <4fec0300-ff6b-f981-49f0-f8002847385f@jeffhostetler.com>
Date:   Thu, 10 Mar 2022 10:42:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <220310.86a6dxkgjr.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/10/22 9:42 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Mar 10 2022, Johannes Schindelin wrote:
> 
>> Hi Ævar,
>>
>> On Wed, 9 Mar 2022, Ævar Arnfjörð Bjarmason wrote:
>>
>>> On Tue, Mar 08 2022, Jeff Hostetler wrote:
>>>
>>>> On 3/7/22 5:37 AM, Ævar Arnfjörð Bjarmason wrote:
>>>>> On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:
>>>>>
>>>>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>>>> [...]
>>>> [...]
>>>>>
>>>>>> +#else
>>>>>> +/*
>>>>>> + * Let Apple's headers declare `isalnum()` first, before
>>>>>> + * Git's headers override it via a constant
>>>>>> + */
>>>>>
>>>>>
>>>>>> +#include <string.h>
>>>>>> +#include <CoreFoundation/CoreFoundation.h>
>>>>>> +#include <CoreServices/CoreServices.h>
>>>>>> +#endif
>>>>>
>>>>> In cache.h which you'rejust about to include we don't include
>>>>> string.h, but we do in git-compat-util.h, but that one includes
>>>>> string.h before doing those overrides.
>>>>>
>>>>> This either isn't needed, or really should be some addition to
>>>>> git-compat-util.h instead. I.e. if we've missed some edge case with
>>>>> string.h and ctype.h on OSX we should handle that in git-compat-util.h
>>>>> rather than <some other file/header> needing a portability workaround.
>>>>
>>>> [...]
>>>>
>>>> While it may not (now at least) be necessary, it's not doing
>>>> any harm, so I'd rather leave it and not interrupt things.
>>>> We can always revisit it later if we want.
>>>
>>> In terms of figuring out some mysterious portability issue, I think the
>>> right time is now rather than later.
>>
>> I do not see that.
>>
>> In FSMonitor, this was clearly a problem that needed to be solved (and if
>> you try to compile on an older macOS, you will run into those problems
>> again).
> 
> So you can reproduce an issue where removing the "#include <string.h>"
> from compat/fsmonitor/fsm-listen-darwin.c has an effect? Does swaping it
> for "ctype.h" also solve that issue?
> 
> I was asking why the non-obvious portability hack was needed, and it
> seems Jeff suggested it might not be upthread in
> <aa6276f9-8d10-22f9-bfc0-2aa718d002e1@jeffhostetler.com>, but here you
> seem to have a reproduction of in being needed, without more of the
> relevant details (e.g. what OSX version(s))?
> 
>> If you are talking about the mysterious portability issue with an eye on
>> `git-compat-util.h`, well... you can successfully compile Git's source
>> code without this hack in `git-compat-util.h`. That's why the hack is not
>> needed. Problem solved. Actually, there was not even a problem.
> 
> Do you mean we don't need the ctype.h overrides in git-compat-util.h at
> all? I haven't looked into it, but needing to
> 
>>> I.e. now this doesn't have anyone relying on it, so we can easily
>>> (re)discover whatever issue this was trying to solve.
>>>
>>> Whereas anyone who'd need to figure out why we include string.h on OSX
>>> early in this case later would be left with this otherwise dead-end
>>> thread, and a change at that point would possibly break existing code...
>>
>> Anyone who would need to figure out why we `#include` this header early
>> would read the comment about `isalnum()`, I would hope, and understand
>> that there are circumstances when Git's `isalnum()` macro interferes with
>> Apple's, and that this `#include` order addresses that problem.
>>
>> They might even get to the point where they find
>> https://github.com/dscho/git/commit/0f89c726a1912dce2bdab14aff8ebfec8550340d,
>> maybe even the "original original" commit at
>> https://github.com/kewillford/git/commit/d11ee4698c63347f40a8993ab86ee4e97f695d9b,
>> which was a still-experimental version of the macOS backend, and where the
>> `#include` order clearly mattered, else why would Kevin have bothered.
>>
>> Further, I strongly suspect that it had something to do with
>> `CoreFoundation.h` or with `CoreServices.h` being `#include`d, and if you
>> care to check the code above the quoted lines, you will see that you
>> cannot even `#include` those headers using GCC, it only works with clang:
>> https://github.com/jeffhostetler/git/commit/cdef9730b3f93a6f0f98d68ffb81bcb89d6e698e#diff-4e865160016fe490b80ad11273a10daca8bc412a75f2da4c6b08fb9e5e3b5e18R3
>>
>> At this stage, anybody investigating this issue who is a little bit like
>> me would then be a bit bored with the investigation because there is
>> actually no breakage here, just a curious `#include` order, and nothing
>> else. So they might then drop it and move along.
> 
> My implicit observation upthread is that those sorts of details would
> ideally be included in a comment or the commit message. I.e. I didn't
> quite see why it was needed, and neither could the person submitting the
> patch series when asked.
> 
> Sure, it's a minor issue, but patch review is also meant to uncover such
> small issues.
> 

There are two independent issues here.
(1) compiling something that includes <CoreServices.h> with GCC.
(2) the need for the #include <string.h> when compiling with clang.

To address (1), we've #ifdef'd the top of the file and insert just
the essential typedefs and prototypes.  (I'll pull them into a separate
local header file as you suggested earlier to make that easier to see.)
But otherwise, GCC is not an issue.

WRT (2) I have tried clang-11 on macOS 10.15 and clang-13 on 11.6 both
with and without the <string.h> and it doesn't matter.  Everything
compiles and t7527 passes in all [2x2] cases.  So I have to assume that
something has changed in the Apple/clang SDK or runtime libraries or
our source code in that single source file in the ~2 years since Kevin
needed to add it.  I do not have access to an older Mac (Apple makes it
hard to test back-compat with older OS's), so I cannot reproduce the
error.  But I don't doubt that there was an error at one point -- I just
don't know what it was.   So that's my context for saying that I don't
think it is needed now, but I was willing to carry it forward in case
it is still helpful for people with older Macs.  FWIW, it really seems
pretty isolated and trivial and would only affect code in this single
source file -- which from a quick scan, doesn't actually reference any
of the functions in <string.h>, so there shouldn't be any need to think
about git-compat-util.h or ctype.h, right?

Jeff
