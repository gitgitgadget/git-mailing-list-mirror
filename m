Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A083C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 14:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 656CA22DFA
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 14:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbhAXOZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 09:25:17 -0500
Received: from avasout04.plus.net ([212.159.14.19]:54832 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbhAXOZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 09:25:16 -0500
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id 3gJWlWg41rXCc3gJYlyuWw; Sun, 24 Jan 2021 14:24:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1611498268; bh=Q0FyREAEBDRYM9D/lpv8V+dz9oqp+PazjzlJSi7+PzY=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=Vy8z7VkUH3aPCCGOU+RmUTL0p3m0qN9oN1CjGh1D2XXN967qPbZSYWDYbBr2NYSs0
         AiM6J8fHDbbp3Ac/Re4U4ucfXas7YVUi6HEsz4wCk5iW5n3zOH+1TVVRpDukM3uGHZ
         vaiQMO6kp0byEzVMXGA36xEl1lNrGDQiwrrpH6CiqYJTrNEH93kP53E+e+t8K499KX
         jEaOcS4yCwjvkRVu4cjrWDKRomuneyFqv8PQPSuBYaatJ73JhKFXlx7tR4EHePgPrU
         St3+s82LBSqcwD0WM7n3qjO1g9SAbhcnN6xXT+dl3ec/ZduI1pwzBiCarn6yzAdoJZ
         WMKnkQpcnlqlg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Q+xJH7+a c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=lMhe8o9mDcM7-9lvHNAA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4 2/2] grep/pcre2: better support invalid UTF-8 haystacks
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>
References: <20210124021229.25987-1-avarab@gmail.com>
 <20210124114855.13036-3-avarab@gmail.com>
 <6fe69ede-d24b-1742-f699-c9af05560c0c@ramsayjones.plus.com>
Message-ID: <3f32c0da-ddb9-d821-5d37-5c002b48f9f9@ramsayjones.plus.com>
Date:   Sun, 24 Jan 2021 14:24:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6fe69ede-d24b-1742-f699-c9af05560c0c@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNfwGE5+U4lbY1fWrr3HTA3dY3hCC5fPRKqnmaF3kM931DHEku6/d1s4lmtQ9DGBijWtBRED964kdfal6ER5g80iKmtK1n2vKxbJyEYafSQRhGFC3JUf
 Kutsew4Hx8CqG4GaLki3Ze7LD/p9k+YXkGnijW6aux/Xo7+8p+ZwF25H/URBK/uOxrjVztIx7PyjTw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/01/2021 13:53, Ramsay Jones wrote:
[snip]

>> diff --git a/grep.c b/grep.c
>> index efeb6dc58d..e329f19877 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -492,7 +492,13 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
>>  	}
>>  	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
>>  	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>> -		options |= PCRE2_UTF;
>> +		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>> +
>> +	if (PCRE2_MATCH_INVALID_UTF &&
>> +	    options & (PCRE2_UTF | PCRE2_CASELESS) &&
>> +	    !(PCRE2_MAJOR >= 10 && PCRE2_MAJOR >= 36))
>                                    ^^^^^^^^^^^^^^^^^^
> I assume that this should be s/_MAJOR/_MINOR/. ;-)
> 

Although, perhaps you want:

            !(((PCRE2_MAJOR * 100) + PCRE2_MINOR) >= 1036)

... or something similar.

ATB,
Ramsay Jones



