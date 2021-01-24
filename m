Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BA0C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 16:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24742229F0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 16:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbhAXQUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 11:20:18 -0500
Received: from avasout03.plus.net ([84.93.230.244]:37407 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbhAXQUP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 11:20:15 -0500
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jan 2021 11:20:15 EST
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id 3hxvlGwvN99nq3hxwlHTVR; Sun, 24 Jan 2021 16:10:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1611504625; bh=sBLPteynDfg15CaCDW6Pl4W5FpNpwveXPyt6P6j+fis=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=pLVU4enl6kHj5t6wo5yq6LffrA/v1EmQyCPpoMVWODxGxOrA/7GbGISXzGaSdzHxQ
         ZeLRcH5a0AbZ3HUIOWvwdIKnv3Jrnp4MkKFbr8Fmedh1/D6waOQhOaQR3v8OTNkFOa
         aKcCsuSjXmC6FN2SrebP6v2h+6jMAlTnQYxW5bvRv5PT2t34e6n4VFSmiJ3O2SBzxX
         RVvuOEhMu60edmmCpoDMYXRFSTpYlcV5Y8ORxQlhgcNEGjXUPBYz6MgiEprpHcDhcc
         dFo9G0QwgLp7/jkXKpnQ/NTtPRtIAm6YS/dTCWK5f5tfrOTEwODFgw7EXwMi2WOtWj
         2GLdBKnAXhLsg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uoz4y94B c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=zILzx5ACvcZng3TLz4sA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4 2/2] grep/pcre2: better support invalid UTF-8 haystacks
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>
References: <20210124021229.25987-1-avarab@gmail.com>
 <20210124114855.13036-3-avarab@gmail.com>
 <6fe69ede-d24b-1742-f699-c9af05560c0c@ramsayjones.plus.com>
 <3f32c0da-ddb9-d821-5d37-5c002b48f9f9@ramsayjones.plus.com>
 <87a6sy75ka.fsf@evledraar.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <a75cfde9-0ac3-9af4-777c-1824063c6b0b@ramsayjones.plus.com>
Date:   Sun, 24 Jan 2021 16:10:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87a6sy75ka.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOGs5Cwt8QeEdrOIADc4IDhQ7vJ1Lr87xdLfuBna8bCHkPztAiXYs+vneE2+JzmaINss/CKsMZA+80SJqyaBdiXwTTtIt/Db4qzxUvhhrpJ3ru6tUBDm
 ST/Wjk/HmhpSsK5NChlyafkeGr3p5m2yNDJbtVfBal5PfNwkUrtRfPs7efjgqy8qGTS7YTpfNfELgQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/01/2021 14:49, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Jan 24 2021, Ramsay Jones wrote:
> 
>> On 24/01/2021 13:53, Ramsay Jones wrote:
>> [snip]
>>
>>>> diff --git a/grep.c b/grep.c
>>>> index efeb6dc58d..e329f19877 100644
>>>> --- a/grep.c
>>>> +++ b/grep.c
>>>> @@ -492,7 +492,13 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
>>>>  	}
>>>>  	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
>>>>  	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>>>> -		options |= PCRE2_UTF;
>>>> +		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>>>> +
>>>> +	if (PCRE2_MATCH_INVALID_UTF &&
>>>> +	    options & (PCRE2_UTF | PCRE2_CASELESS) &&
>>>> +	    !(PCRE2_MAJOR >= 10 && PCRE2_MAJOR >= 36))
>>>                                    ^^^^^^^^^^^^^^^^^^
>>> I assume that this should be s/_MAJOR/_MINOR/. ;-)
>>>
> 
> Oops on the s/MAJOR/MINOR/g. Well spotted, I think I'll wait a bit more
> for other comments for a re-roll.
> 
> Perhaps Junio can be kind and do the s/_MAJOR/_MINOR/ fixup in the
> meantime to save be from spamming the list too much...

Umm, sorry for not making myself clear, _just_ changing MAJOR to
MINOR is insufficient.

> 
> FWIW I have tested this on a verion without PCRE2_MATCH_INVALID_UTF, but
> I think I did that by manually editing the "PCRE2_UTF" line above, and
> then wrote this bug.

Yep, I seem to have 10.34 on Linux Mint 20.1 (based on Ubuntu 20.04).

> 
>> Although, perhaps you want:
>>
>>             !(((PCRE2_MAJOR * 100) + PCRE2_MINOR) >= 1036)
>>
>> ... or something similar.
> 
> Probably better to use pcre2_config(PCRE2_CONFIG_VERSION) at that point
> and versioncmp() the string.

OK, but it needs to be 'something similar' (try putting, say, MAJOR 11
and MINOR 0->35 in your expression).

ATB,
Ramsay Jones
