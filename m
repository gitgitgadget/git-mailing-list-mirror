Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC5441F453
	for <e@80x24.org>; Fri, 26 Oct 2018 09:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbeJZRgT (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 13:36:19 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:24627 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeJZRgT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 13:36:19 -0400
Received: from [192.168.2.201] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id FxyNgMSu3oI6LFxyNgkOQu; Fri, 26 Oct 2018 10:00:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1540544404;
        bh=LKf02EXKQU+fnUV3dgUc6UYDvmmVaX8C74MN7fYufdU=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jhUQMvxsfRwERh839ZqE4HBSxKwN+tb+p/AkRUuamdFkbqNiUZdizO/uBVt5ne1D2
         SEpHqTNNQlqbK984RmFxJ8OsxKp9TILnRINZq9U0CDA40gv5iD/Ps4FEP0w7OeWvgZ
         6HoCC1hQsyjna3ATU1k3e1iMo3piEAXQBqm50S0A=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=3U2mnjeyrRiQpUlo6loA:9 a=25uQfFpwN_cQFmI5:21
 a=KwuDtM7htvs2f1tp:21 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/5] am/rebase: share read_author_script()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
 <20181018100023.7327-1-phillip.wood@talktalk.net>
 <xmqqtvlah052.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <55a2a458-c71e-0018-5fd7-b66e349ddb3d@talktalk.net>
Date:   Fri, 26 Oct 2018 10:00:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqtvlah052.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJRRBNLeAICx/V32nhb1sPf07r77Udh5HJimMIuufPPRwiQqM1kfoYxZwLAoNZRveOraz6E3OAx5LbALEEYuu4DSMpQT8CjqNdCkrcbiTU4Lmv0qEgp+
 wBuPMy6N9asGqLRBf7AaqeEEnQNK8kCQAkpnRsrs8eL6CJRt7XX2FqFcBTq21lmaoCQ4Wl+KMp7E95qMYlcx63TnfXM7C1PVQ6Nt/73Quaqf5j6sWrl6jZL4
 dDRg+s4q36yDUrOBKtMKPSMB4KBl2sM/QhaQ2B8i6oYfQOoRsBjqPOrWlAB2j446ovPQo+MV7FR+Zr2reZRloQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 25/10/2018 09:59, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Thanks to Eric for his feedback on v1. I've rerolled based on
>> that. Patches 1 & 2 are new and try to address some of the concerns
>> Eric raised, particularly the error handling for a badly edited author
>> script. See the notes on patches 4 & 5 for the changes to those (they
>> were previously 2 & 3).
> 
> I spotted a weird corner case buglet, but it seems that this one is
> ready for 'next' even without fixing that "give it three times and
> we will happily continue" thing.

Well spotted on the corner case. If you're happy to hold off on moving
it to next I can send a re-roll with fixes for that next week or I can
do it as a fixup if you want to move this forward now.

> Do we know of any other issues?  Can we now move it forward?

I don't know of any other issues but I don't think anyone else has
looked at this iteration. Thanks for taking a look at these.

Best Wishes

Phillip



> Thanks.
> 

