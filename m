Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75CD32047F
	for <e@80x24.org>; Thu,  3 Aug 2017 10:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbdHCKPw (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 06:15:52 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:6095 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbdHCKPu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 06:15:50 -0400
Received: from [192.168.2.201] ([92.22.28.33])
        by smtp.talktalk.net with SMTP
        id dDARdnpMV3CyHdDASdldUt; Thu, 03 Aug 2017 11:15:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1501755348; bh=cOdV/nawFO+1UaKtQTrYRPRAvq0QBim2VLlN+nfw3Zw=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=o95d1d+K4JIa9LwrjvnabWCU5rR1iMq+p2v96yGs605DyNH4b4P8RG2E3MnasBH3n
         tZsQynDCZ/L1NBujlNw/fo5sU4vpniBO/tJ642He7ifP1V+0DCRRpYGU3DqTdPZykY
         xXglrkpkgZJaTaZ365I9kR4mTp4T2TtCFM88Exv8=
X-Originating-IP: [92.22.28.33]
X-Spam: 0
X-OAuthority: v=2.2 cv=Zo+dE5zG c=1 sm=1 tr=0 a=BeSdjzhxhZnKGFP9cxuqMA==:117
 a=BeSdjzhxhZnKGFP9cxuqMA==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=nN7BH9HXAAAA:8 a=evINK-nbAAAA:8 a=jXHeF1nPi7Ykd0SGJz0A:9
 a=siTAzFYvtCBd-EJv:21 a=WY8eTnZ8ocSMVg1M:21 a=QEXdDO2ut3YA:10
 a=UF-tvkePCJwA:10 a=SHUmGpGg8TAA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/6] cherry-pick/revert: reject --rerere-autoupdate when
 continuing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170802104420.12809-1-phillip.wood@talktalk.net>
 <20170802104420.12809-7-phillip.wood@talktalk.net>
 <xmqqpocdr5tu.fsf@gitster.mtv.corp.google.com>
 <xmqqlgn1r4bu.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <6a7c9661-9f12-99c9-1fc1-4a4abd3d0660@talktalk.net>
Date:   Thu, 3 Aug 2017 11:15:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqlgn1r4bu.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPn3+SKFxorD+AgrRDBFEcb8fDphoLC0AkRTB8oHfO/zDbLsCgukRDUTRHFGZrI/5/6y4x2HDCsL1w7rIhQmhP0AadRAYQvZ8Asqfd8MLzw+lTZi7Z9q
 Dhix62mcoYs78CbogpgY0EMNN8C3eaYORUJvtrOsI0/q4/Z6XcaM5oRMvsXmgRLTuXw7sQS1DrLZaimVuRnkoU/929RTdI9+oq7CkPYqnhlPtgNZwSCdK8dS
 aN6fGXAS0VHAzWsUDxzPAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

Thanks for your comments.

On 02/08/17 23:29, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> cherry-pick and revert should not accept --[no-]rerere-autoupdate once
>>> they have started.
>>
>> Hmph, why shouldn't they?  In other words, shouldn't the usual "try
>> to carry forward from the original invocation (saved in the state
>> file), but allow overriding from the command line" rule apply?
> 
> Actually, I do not care _too_ deeply between
> 
>  * You can only give "--[no-]rerere-autoupdate" at the beginning and
>    cannot change your mind later.
> 
> and
> 
>  * The "--[no-]rerere-autoupdate" you give at the beginning is used
>    throughout your multi-commit cherry-pick session, but you can
>    give an opposite one from the command line when you say
>    "--continue", and in that case it takes effect only for a single
>    commit.
> 
> If I understand correctly, the former is what 5-6/6 implements.

Yes, that's correct. It was easier to implement it that way

> The
> latter makes it more in line with how "am -3" followed by "am --no-3
> --continue" behaves.

I'm a bit confused about what am does when you pass extra options to
--continue. It looks like they do not persist if there's another
conflict and may only apply to the first patch that is applied when
resuming - I'd need to spend more time looking at the code or run a test
to be sure.

Best Wishes

Phillip


