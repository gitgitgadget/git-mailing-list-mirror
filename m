Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 044D31F403
	for <e@80x24.org>; Tue, 12 Jun 2018 16:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934016AbeFLQU5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 12:20:57 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:29312 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933666AbeFLQU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 12:20:56 -0400
Received: from [192.168.2.240] ([92.22.39.132])
        by smtp.talktalk.net with SMTP
        id Sm2OfDklppXFjSm2Pf5Zfm; Tue, 12 Jun 2018 17:20:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1528820454;
        bh=8Gk3jU/SMZ+UE5b+gyEsEJ68BV0IY8fNVvfTQVNzJ0I=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=H7c+C6F6jd2koKbqoCgzFTSCfFeTZfPGrW3f2RcRL+CRryV9kyqlLOyzMnmB/ohlW
         S6KC1KJjqGHKvVqBiMQegIjeeOtOaCAv14+0kARSb1jCCl3ILTSUeI6TCEQL72QDCp
         /SVsSEYMds/ufJ5q6sqlN/JYYen/u9Buny1RMbMg=
X-Originating-IP: [92.22.39.132]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=AATg4WxWBR3MjRzlB3y0Ow==:117
 a=AATg4WxWBR3MjRzlB3y0Ow==:17 a=IkcTkHD0fZMA:10 a=nlLf84GAuinx8fP2qYgA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH 1/1] rebase--interactive: rewrite the edit-todo
 functionality in C
To:     Alban Gruin <alban.gruin@gmail.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
References: <20180611135714.29378-1-alban.gruin@gmail.com>
 <20180611135714.29378-2-alban.gruin@gmail.com>
 <3bfd3470-4482-fe6a-2cd9-08311a0bbaac@talktalk.net>
 <801da146-6905-5f7b-12c0-7239108b6207@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <7b9134a2-8e23-e089-0fd3-0e67f384eba0@talktalk.net>
Date:   Tue, 12 Jun 2018 17:20:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <801da146-6905-5f7b-12c0-7239108b6207@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAOPSKviZT5G1lHAxkUObCleAX7gZLtSZxzDxX4nkPXdWCuS421NCd0yW4ah3O8Cz6633bxBrhRQAvpN9JMcMRAuVOW40GNIiiaXi1O5/nWadsp8syH0
 Mwzv5EN5O0buPh3DVyVyF/nlbf9JXRvx5Z4ZP9I7MkClNJJmYnReqV5s3ItKwDYAZ+umswxvc4u4ilcZOSZD/k/beNu5KEQFRuVsP5DaGZLS59xZ0VqziTwR
 J3g2Q/rEKrSnDsj3WRUW+NoknpYBY/s4fRLwj5EqQkKUV7y3mUCErXIQvebv+57Ke0oHaTnZ8b84vrIInnJ4d+6zMbTaOscWhIusDQKTtdz3psoCkI0kH1sr
 MU8tHXJIWQiTKdnpnEjkkSPkpsK7HA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 12/06/18 13:33, Alban Gruin wrote:
> Hi Phillip,
> 
> Le 11/06/2018 à 17:32, Phillip Wood a écrit :
>>> +    if (launch_editor(todo_file, NULL, NULL))
>>
>> I'm not sure that this will respect GIT_SEQUENCE_EDITOR, it would be
>> nice to have a launch_sequence_editor() function that shared as much
>> code as possible with launch_editor()
>>
> 
> It could be done by making launch_editor() and launch_sequence_editor()
> some kind of wrapper around a function like launch_specified_editor()
> (or something like that), that would take the editor as a parameter, in
> addition to the path, the buffer and environment variables.  It would be
> also very trivial to implement your first point above on top of that.

That sounds like a good way forward, launch_sequence_editor() could just 
call launch_editor() if GIT_SEQUENCE_EDITOR and sequence.editor are not set.

>>>    int append_todo_help(unsigned edit_todo, unsigned keep_empty);
>>
>> Can this declaration be removed now?
> 
> No, it’s still used in rebase--helper.c for now.

Ah, sorry I missed that

Best Wishes

Phillip

> 
>>
>>> +int edit_todo_list(unsigned flags);
>>>    int skip_unnecessary_picks(void);
>>>    int rearrange_squash(void);
>>
>> Best Wishes
>>
>> Phillip
>>
> 
> Cheers,
> Alban
> 

