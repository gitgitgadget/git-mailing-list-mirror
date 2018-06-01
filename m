Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 030921F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 09:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750868AbeFAJjD (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 05:39:03 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:4893 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeFAJjC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 05:39:02 -0400
Received: from [192.168.2.240] ([92.22.30.137])
        by smtp.talktalk.net with SMTP
        id OgWQfTJxwoI6LOgWRfr09u; Fri, 01 Jun 2018 10:39:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1527845940;
        bh=+T2HWChBYm2bFIUV0MY7OOZ8pXMfS0/RwoJAOgaX1no=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AWA7xZR9kC+okbjCxXKp3M5Q+nJiKjwS6r9/IGuGEgNbmk8bxjqdg2io7WDPQFglA
         bJXSjAkls/DIZPd72cN/q7Mjr0DzSH6ISkKph5+/7rgrKxMQ79b3dHmV2iic8vxfSF
         qK7wMYEWS2DY20fabBLP/I0+lbcFXYQpQxQHpmsk=
X-Originating-IP: [92.22.30.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=2E67H+H4u1YVIwSqTyRiqw==:117
 a=2E67H+H4u1YVIwSqTyRiqw==:17 a=IkcTkHD0fZMA:10 a=bK7-UzkCnlPzbSyKodAA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH 0/2] rebase -i: rewrite append_todo_help() in C
To:     Alban Gruin <alban.gruin@gmail.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20180531110130.18839-1-alban.gruin@gmail.com>
 <a6d6e5c1-e7ea-1131-c798-9d5e44603d87@talktalk.net>
 <edb744b1-f984-70fc-4639-f0414df8c669@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <db2bb0f9-b2ff-4482-a9bd-1cdd39a9ad08@talktalk.net>
Date:   Fri, 1 Jun 2018 10:38:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <edb744b1-f984-70fc-4639-f0414df8c669@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLd/ei6eFljF30Ys3FKYemu848+Ik7Hb00bpyoAGCUCJXoMXXOH8pRawn1Ug60KYEcDVrQxP1A/sj9Y7Lv6sSUQZwq7pHnCYczMt2jg1ru+iUsPME6LJ
 oEl/qRjg8B2eQAAO5Ks557x6PzFNLdpY+RyK0ItGev2zktw+UkURYolA3m1qfwLUB/U5okPD5YcFcnMDvHV2FRuNiUjqsu/Ls1AfSIONuzidAUuTAeSRsTYI
 hFy5WNOA3zfglsk9hywdyTZh07matXhFocA3LcxD3nYNzywJAJiE2zDIJMPwS+TCk6swfUniQrSOrQovBu7nAZtkfX4W8wbnrd2+3iQxY9wlSEvHfvsdsc1T
 0+Msr7Aj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/05/18 20:25, Alban Gruin wrote:
> Hi Phillip,
> 
> Le 31/05/2018 à 19:48, Phillip Wood a écrit :
>> Hi Alban, it's great to see you working on this
>>
>> On 31/05/18 12:01, Alban Gruin wrote:
>>> This series rewrites append_todo_help() from shell to C. This is part
>>> of the effort to rewrite interactive rebase in C.
>>>
>>> The first commit rewrites append_todo_help() in C (the C version
>>> covers a bit more than the old shell version), adds some parameters to
>>> rebase--helper, etc.
>>
>> I've had a read of the first patch and I think it looks fine, my only
>> comment would be that the help for '--edit-todo' is a bit misleading at
>> the moment as currently it's just a flag to tell rebase-helper that the
>> todo list is being edited rather than actually implementing the
>> functionality to edit the list
> 
> Right, what do you think about something like “appends the edit-todo
> message to the todo list”?

Yes that sounds good, though if you're about to implement editing the 
todo list with --edit-todo I wouldn't worry too much

Best Wishes

Phillip

>> (but hopefully that will follow in the
>> future).
>>
> 
> This is the next step :)
> 
> Cheers,
> Alban
> 

