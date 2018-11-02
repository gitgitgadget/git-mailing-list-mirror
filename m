Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C24E1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 17:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeKCCRK (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 22:17:10 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:61061 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbeKCCRK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 22:17:10 -0400
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id IcwggcnN3pXFjIcwggEHrW; Fri, 02 Nov 2018 17:09:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1541178559;
        bh=pLY4Di0i002MOLnRiM8oRkvKxDpAcNqX/HrNZOCPOe4=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SR/QXcjjP3/O3GNkL1KW9KqoRQEL1S3NwJwXHbjiClgW5En3f5lI0Ztgwyf/fpY+F
         2Wv+F2Mn92VnAl3nVpPbSx1PjG86Piqoa0v0Yg3b0kowVBTM5am+AtcR+/VjOsV0Ng
         aC2kLwwLS4KRyrviuqd8FF2H+OAMl1MxOI5pz+tM=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=nF0OYWXJvAXkQDamSGMA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 06/16] sequencer: refactor
 sequencer_add_exec_commands() to work on a todo_list
To:     Alban Gruin <alban.gruin@gmail.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181027212930.9303-7-alban.gruin@gmail.com>
 <12e849d3-351b-7673-1f14-742d0fbb1ac1@talktalk.net>
 <c57384de-0996-2294-db8f-0204f9c16226@gmail.com>
 <351e3398-8239-5348-2880-d253d8a125d7@talktalk.net>
 <878848f4-f8f6-25cb-061e-5f7aef9ca1a9@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <1f16fa71-2ff0-d0b3-0d90-f330788351d8@talktalk.net>
Date:   Fri, 2 Nov 2018 17:09:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <878848f4-f8f6-25cb-061e-5f7aef9ca1a9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfG+8i+80FsOJKeELkIFXOTgFK7f0Oju55zHFU+bkOp0Q1jy1gaI9jOLPrqC0mvNRwFFAikHaIeDmSBuJNppBRvgds2wmVp75OblW6fqL5lcQ6USZCj4o
 vHJZ8MG4k7jb4gyWZKpAA06qfmdKJGyzx/EfRv+9nyBEtxD3uQU2v/PumvGveDV5sVFwknMbbn8Fjh0a8YbcCGsbCdvy5KFqIHYEhcAnDT5biOuuvsGk6cqF
 gZXfmLoXx1ZEGgOBfNi5jW73SeFo1iPAZu6blK+haSWsmOoGL1ORYiIAvheZIquL/eirstjhuA/dv64qEVU3Cg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 02/11/2018 16:26, Alban Gruin wrote:
> Hi Phillip,
> 
> Le 02/11/2018 à 11:09, Phillip Wood a écrit :
>>>>> +    struct todo_item *items = NULL,
>>>>> +        base_item = {TODO_EXEC, NULL, 0, 0, commands_len, 0};
>>>>> +
>>>>> +    strbuf_addstr(buf, commands);
>>>>> +    base_item.offset_in_buf = buf->len - commands_len - 1;
>>>>> +    base_item.arg = buf->buf + base_item.offset_in_buf;
>>>>
>>>> I think if the user gives --exec more than once on the command line then
>>>> commands will contain more than one exec command so this needs to parse
>>>> commands and create one todo_item for each command.
>>>>
>>>
>>> Ouch, you’re right.  Thanks for the heads up.
>>
>> I haven't looked how difficult it would be but it might be best to
>> change the option parsing to pass an array of strings containing the
>> exec commands rather than one long string so we can just loop over the
>> array here.
>>
> 
> It would be the best way to do so.  This string comes from git-rebase.sh
> (or builtin/rebase.c) -- they format it this way before invoking
> git-rebase--interactive.  So either I modify both of them (for this, I
> would need to rebase my branch on master), or I can split this string in
> builtin/rebase--interactive.c.  I prefer the first option, but maybe
> changing the base of this series will not please Junio.

I think in the last 'what's cooking' email Junio said he was going to 
merge all the builtin/rebase.c stuff to master so there may not be a 
problem if you wait a couple of days.

Best Wishes

Phillip

> Cheers,
> Alban
> 

