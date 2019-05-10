Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0051F1F45F
	for <e@80x24.org>; Fri, 10 May 2019 15:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfEJPAC (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 11:00:02 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:22962 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfEJPAC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 11:00:02 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id P70AhhuoGdraxP70BhwmGq; Fri, 10 May 2019 15:59:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1557500399;
        bh=ok9s06DrvbKBgDgIJhuYZi3+zBLWXCEJrnmaddA/bPE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iRvu96R55KYxifdaxAVPSIZjj1fPGX7y0/aoE/KU8SDRu36Cl3ZpDpJ9QTknDnNrt
         MvLc0xBFiQPqJEiCBCUZBBUjbX4nkDL6Gauuu6FiOUpNaImAATl8gpx6RfsyDuCacZ
         YJDTfbjI4/Hk+xbPUan+G8njeKSkbv7cqkkLsXn0=
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=EDlGl3OzOG1hMp6laB0A:9 a=QEXdDO2ut3YA:10
Subject: Re: How to exchange rerere/redo resolutions?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
References: <b8e56556-6c83-9e37-38e9-ac67f51b5cd2@iee.org>
 <871s17xk79.fsf@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@talktalk.net>
Message-ID: <37ccaad0-40b4-ca63-e057-791119d7fa69@talktalk.net>
Date:   Fri, 10 May 2019 15:59:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <871s17xk79.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfKel4QL7nSgXFSXToailKwGi3tUSkCMum74FsKo2k+Ku8/5D8uS4spfETbIRUyBTbX2RWG1Ddop1MYkUaRSiiZH3TjEWHOEvrBzWeSrSffbZw5eA/Nme
 T68sg5kR24orr0wmwPmkHH3U0VSH6in9gL2fDJd24KqTxFWN7CGiXrR4Ye+EPZWePnkXDVnoxl/9yYDpWvk0cEtEx4Ul8fAYrQduUUO7fBoL7Kza/BVNCFto
 ow3wuQt/h9Wh8B0u2yNCqZztq0sG80VysqMOb/q6HVB1gWp8CYC4ANHUf2dVhBwD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/05/2019 00:49, Ævar Arnfjörð Bjarmason wrote:
> On Fri, May 10 2019, Philip Oakley wrote:
>
>> Is there a mechanism for exchanging the rerere resolutions, so that
>> future fixups, e.g. future clashes on pu rather than master, can be
>> sent with patch series?
>>
>> My current use case that there is a large patch [1] for updating long
>> to size_t for use on Windows, which notes that it will have clashes
>> with pu, but doesn't appear to have any method  of sending a rerere
>> resolution (which the author is already aware of) to the list. Being
>> able to flag up such fixes should simplify such conflict resolutions.
>>
>> I had some very rough ideas about how the resolutions should look
>> rather similar to three-way conflict markers, with the resolution as
>> the 'base' (between the ||| - ||| marks), which would be resolved via
>> a --base merge strategy.
>>
>> However if there is already a method for exchanging resolutions, where
>> should I look?
>>
>> Philip
>>
>> [1] <20190413151850.29037-1-tboegi@web.de> [PATCH v3 1/1] Use size_t
>> instead of 'unsigned long' for data in memory
> You can publish your merged branch somewhere, and others can use
> contrib/rerere-train.sh to learn from the resolution.
>
> Supposedly, I've never actually used it...
The tricky part is when the patch series doesn't apply so the conflict 
isn't yet on any branch..

I'm looking to write up some suggestions as a potential project, so that 
we can all make better use of this capability (hence the `redo` synonym 
alias suggestion).
Philip
