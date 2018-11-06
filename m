Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F20A81F453
	for <e@80x24.org>; Tue,  6 Nov 2018 14:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388550AbeKFX2J (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 18:28:09 -0500
Received: from avasout03.plus.net ([84.93.230.244]:35895 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388521AbeKFX2I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 18:28:08 -0500
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id K1wJgxNYSd3rWK1wKg03BV; Tue, 06 Nov 2018 14:02:45 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uv9Nyd4B c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=PxuYgiTRUxYzQQWbh14A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 12/16] parse-options: replace opterror() with optname()
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181105192059.20303-1-pclouds@gmail.com>
 <20181105192059.20303-13-pclouds@gmail.com>
 <xmqqpnvjexzf.fsf@gitster-ct.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d29c4fcc-0591-fc45-5a5d-65d2874d98a7@ramsayjones.plus.com>
Date:   Tue, 6 Nov 2018 14:02:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqpnvjexzf.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCoSV3+4AuKwgyXzU9vhdGsH1NlNRKmd3+JDe85yqwBN/RsIPOmI05r+KrVHI/Sy+NPxToI+agHpC+OFiVHMBKIvkFRVk/qjGHf/yInxXqHh2GYnTEIW
 tkyVI40ZH6a72kWUCTCx6HO3CAvHpROfgs1R9mBmiGSVuAss0LmabGCrHH+0Ieu5sxY9GwrdyRMJOQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 06/11/2018 02:33, Junio C Hamano wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
> 
>> There are a few issues with opterror()
>>
>> - it tries to assemble an English sentence from pieces. This is not
>>   great for translators because we give them pieces instead of a full
>>   sentence.
>>
>> - It's a wrapper around error() and needs some hack to let the
>>   compiler know it always returns -1.
>>
>> - Since it takes a string instead of printf format, one call site has
>>   to assemble the string manually before passing to it.
>>
>> Kill it and produce the option name with optname(). The user will use
>> error() directly. This solves the second and third problems.
> 
> The proposed log message is not very friendly to reviewers, as there
> is no hint what optname() does nor where it came from; it turns out
> that this patch introduces it.
> 
>     Introduce optname() that does the early half of original
>     opterror() to come up with the name of the option reported back
>     to the user, and use it to kill opterror().  The callers of
>     opterror() now directly call error() using the string returned
>     by opterror() instead.
> 
> or something like that perhaps.
> 
> Theoretically not very friendly to topics in flight, but I do not
> expect there would be any right now that wants to add new callers of
> opterror().
> 
> I do agree with the reasoning behind this change.  Thanks for
> working on it.
> 

Also, this patch does not replace opterror() calls outside of
the 'parse-options.c' file with optname(). This tickles my
static-check.pl script, since optname() is an external function
which is only called from 'parse-options.c'.

So, at present, optname() could be marked as a local 'static'
symbol. However, I could also imagine it being used by new callers
outside of 'parse-options.c' in the future. (maybe) Your call. ;-)

ATB,
Ramsay Jones

