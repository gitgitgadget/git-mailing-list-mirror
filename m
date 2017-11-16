Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28C36202AF
	for <e@80x24.org>; Thu, 16 Nov 2017 10:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933563AbdKPKny (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 05:43:54 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:49857 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933448AbdKPKnw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 05:43:52 -0500
Received: from [192.168.2.240] ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id FHe8e7MJ4Ap17FHe9eVamO; Thu, 16 Nov 2017 10:43:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510829030;
        bh=78IvpeIofmozE60r3L82+w2SXPP6zTN6NEYUok7/FrA=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=O5/+HWTIG18zLBKN1DBmodTiN0XadqO3nPOvptC2PE/+xNOy8TBSLjrjqNfIcCOxc
         lzUxQAeH8i3SUsfrCZgwDkfhBhfRVAYZtALSQ2gWP4vOc6guFHtKeU6Nqvw/WRiIHC
         XAhemybcxvES97LlSu6y2HylP9CXmIMtf8qThQdQ=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=8flSwIWK3WbnnK1REEUA:9 a=DBz6aBKGvNjS1pTX:21
 a=Q8_OzMeTLar5iaip:21 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: reschedule pick if index can't be locked
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20171115104125.1686-1-phillip.wood@talktalk.net>
 <CAN0heSrbszhhFauYHNs70-WWk+bju0sSVzjavRcwg09CzCXSjA@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <804e30dd-3c06-02c1-e5c0-f07265635943@talktalk.net>
Date:   Thu, 16 Nov 2017 10:43:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSrbszhhFauYHNs70-WWk+bju0sSVzjavRcwg09CzCXSjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfA/GTp2lTkk+UHsR1I3i5f46VJ9QEM7uyB3kv9LWccvJN8xehXpf+LHpcG4ngxu8pevlQOysTN97SRUAzQTJnApS/7U7NyNYgrJclBciFAPiF/jPckZT
 wZNAk+cTwQMeGgW4z9mYFESWQ3TORV3K3EViDNAGUXdbBTgxG3opc+JPYZ++sSX5aThFOuu780b9IthVNQ9NXsEHv5Xd9nUY9k3VXgaIjedW4UemuKnJm6D0
 7Porbwj3jSf7V7voUQvKiS/WIYHBsLhnDzbUsA965YPq/hQsqejRV79OeQWa3gUym/mVa6JXifsHAh8DchuuqQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/11/17 18:44, Martin Ågren wrote:
> On 15 November 2017 at 11:41, Phillip Wood <phillip.wood@talktalk.net> wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Return an error instead of dying if the index cannot be locked in
>> do_recursive_merge() as if the commit cannot be picked it needs to be
>> rescheduled when performing an interactive rebase. If the pick is not
>> rescheduled and the user runs 'git rebase --continue' rather than 'git
>> rebase --abort' then the commit gets silently dropped.
> 
> Makes sense. (Your analysis, not the current behavior. ;-) )
> 
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   sequencer.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 6d027b06c8d8dc69b14d05752637a65aa121ab24..8c10442b84068d3fb7ec809ef1faa0203cb83e60 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -438,7 +438,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>>          char **xopt;
>>          static struct lock_file index_lock;
>>
>> -       hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
>> +       if (hold_locked_index(&index_lock, LOCK_REPORT_ON_ERROR))
>> +               return -1;
>>
>>          read_cache();
> 
>  From the commit message, I would have expected the flags to be zero. This patch
> does not only turn off the die-ing, it also tells the lockfile-API to print an
> error message before returning. I don't have an opinion on whether that extra
> verboseness is good or bad, but if it's wanted, I think the commit message
> should mention this change.

Hi Martin, thanks for your comments. LOCK_DIE_ON_ERROR also prints the 
same warning so that behavior is unchanged by this patch, though 
mentioning it in the commit message would be no bad thing.

> 
> Also, don't you want to check "< 0" rather than "!= 0"? If all goes
> well, the return value will be a file descriptor. I think that it will
> always be non-zero, so I think you'll always return -1 here.

Yes you're right, thanks. I thought I had tested this but I now realise 
my so called test just fast-forwarded so didn't touch this code path

Best Wishes

Phillip

> Martin
> 

