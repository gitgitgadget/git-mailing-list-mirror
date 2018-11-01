Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C58A21F453
	for <e@80x24.org>; Thu,  1 Nov 2018 16:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbeKBBbX (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 21:31:23 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:12565 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbeKBBbV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 21:31:21 -0400
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id IFoogYQTDoI6LIFoognIDb; Thu, 01 Nov 2018 16:27:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1541089660;
        bh=Ampkke6sXiz5FVgcAYBXX9wEu4VYtBbO71acpEj5nvk=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=F8NuCrfkXrpuGEpuUw1jdAd2ZlOSJWJcif7KtJjjXU/FBencKtOXm55BxrkUZBYUR
         Wr4s2It24pZaYGOeHhq3QaDcl7zOSgZV/MsMZ8uAgED8fpdEoypqAhah4qeJtkvJgo
         lekUMnuGsp/QT5YlCJ60/avUk7h69zmInabiXTQc=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=Zxutbm4hZRnDf5dgABkA:9 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/5] am/rebase: share read_author_script()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
 <20181031101556.27169-1-phillip.wood@talktalk.net>
 <xmqq7ehxv6v0.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <d1c28479-d0a5-8f0a-3a3b-d46477731a0f@talktalk.net>
Date:   Thu, 1 Nov 2018 16:27:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqq7ehxv6v0.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfI1zEq10WZj2TbaFPlERxijNzEiLB20hNDcqKnhW6CQyquXaT424hdiobyvcltUX56YquXWyyoJSitoiTL/G+qVsnaHKpBUNE7TOzX/IQpUvRIGdNJXV
 zMbKZzrh6UnwT2+Uv9ckil4w9ysGmASGXExr3tEKtwN7BBCDFsdh77fWKYzWSRcnWLD9ZhyHrrX4QQ+RU7cn1+0SjIbF2s9XEmYfjXE5HORPdgSVjdX3nSBw
 k7TYLBBRTy7n4ILAe9PjDKEFHazukkl6GIRIJbhqTWxLOCCHfliDGaCMkbTxZqsHNTkQ3QAjietyvSh3gZoitA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 01/11/2018 03:01, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Sorry for the confusion with v3, here are the updated patches.
>>
>> Thanks to Junio for the feedback on v2. I've updated patch 4 based on
>> those comments, the rest are unchanged.
> 
> The mistake of overwriting -1 (i.e. earlier we detected dup) with
> the third instance of the same originates at [2/5], so updating
> [4/5] without fixing it at its source would mean [4/5] is not a pure
> code movement to make it available to libgit users---it instead hides
> a (not so important) bugfix in it.

Facepalm. Thanks for clearing up my mess, what you've got in pu looks 
fine to me.

Thanks

Phillip

> 
>>
>> v1 cover letter:
>>
>> This is a follow up to pw/rebase-i-author-script-fix, it reduces code
>> duplication and improves rebase's parsing of the author script. After
>> this I'll do another series to share the code to write the author
>> script.
>>
>>
>> Phillip Wood (5):
>>    am: don't die in read_author_script()
>>    am: improve author-script error reporting
>>    am: rename read_author_script()
>>    add read_author_script() to libgit
>>    sequencer: use read_author_script()
>>
>>   builtin/am.c |  60 ++--------------
>>   sequencer.c  | 192 ++++++++++++++++++++++++++++++++-------------------
>>   sequencer.h  |   3 +
>>   3 files changed, 128 insertions(+), 127 deletions(-)

