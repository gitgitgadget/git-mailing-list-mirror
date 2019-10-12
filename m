Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC76C1F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 12:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfJLMyG (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 08:54:06 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:14632 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfJLMyG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 08:54:06 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46r4Wr6HpJz5tl9;
        Sat, 12 Oct 2019 14:54:00 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 581821C93;
        Sat, 12 Oct 2019 14:54:00 +0200 (CEST)
Subject: Re: [PATCH] userdiff: Fix some corner cases in dts regex
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     git@vger.kernel.org, Adrian Johnson <ajohnson@redneon.com>,
        William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
        Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
        Junio C Hamano <gitster@pobox.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <20191004213029.145027-1-sboyd@kernel.org>
 <c3a054d9-2646-e440-40c5-b0aecf21e690@kdbg.org>
 <20191008144306.B2B0820659@mail.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ab9b0dba-5c5b-5a97-07c5-ce8344cd74cd@kdbg.org>
Date:   Sat, 12 Oct 2019 14:54:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191008144306.B2B0820659@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.10.19 um 16:43 schrieb Stephen Boyd:
> Quoting Johannes Sixt (2019-10-05 07:09:11)
>> Am 04.10.19 um 23:30 schrieb Stephen Boyd:
>>> --- /dev/null
>>> +++ b/t/t4018/dts-nodes-multiline-prop
>>> @@ -0,0 +1,12 @@
>>> +/ {
>>> +     label_1: node1@ff00 {
>>> +             RIGHT@deadf00,4000 {
>>> +                     multilineprop = <3>,
>>> +                                     <4>;
>>
>> You could insert more lines to demonstrate that "<x>," on a line by
>> itself is not picked up.
> 
> Maybe I should add another test?

This is is the _multi_line test case, right? ;) Just add one or two
lines between the <3> and the <4> that look like common real-world cases
to show that those lines won't be picked up. I don't think that another
test file is required.

>>> +/ { RIGHT /* Technically just supposed to be a slash and brace */
>>
>> Devil's advocate here: insert ';' or '=' in the comment, and the line
>> would not be picked up. Does that hurt in practice?
> 
> I don't think it hurts in practice so I'd like to ignore it.

Sure, no problem.

>>>  PATTERNS("dts",
>>>        "!;\n"
>>> +      "!.*=.*\n"
>>
>> This behaves the same way as just
>>
>>         "!=\n"
>>
>> no?
>>
> 
> Not exactly. Properties don't always get assigned.

I was just refering to the added line, not the combination of the two lines.

But while you are speaking of it:

> There are boolean
> properties that can be tested for by the presence of some string with an
> ending semi-colon, like 'this-is-true;'. If we just check for not equal
> to a line with a semicolon and newline then we'll see boolean
> properties. Should I add that as another test?

I agree that a test case with a Boolean property would be great.

-- Hannes
