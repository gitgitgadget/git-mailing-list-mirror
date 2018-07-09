Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B58801F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 19:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932789AbeGITaQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:30:16 -0400
Received: from s019.cyon.net ([149.126.4.28]:36106 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754520AbeGITaP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UstN8ZOus6NDPMZg1+uZf74ZsMk/KbbQX3F/w5t7Dvc=; b=eJw/4q164JCyA9UxbRf2Sv9+IO
        sOfXCMov/KO2Ld6xD9+gJmIwoLJkZANGEdqoVqQ7EXlRspwWVKbV2ANyDDYEL/t5X+xPQ+TIG0FJI
        jEmQaSpF33SdtL5jw/HOHNo/5uaX1qR723qL0FZEJsxd268vB4Uwm0UyoMIuIMljqxUrne3eQvKHY
        dtKOoZ7Ia8vJyLvW4E+I0ytVvV9sIlFf8modkeuamd13zCX4rJTdsO6/rVnKcltsT2EvvbYojkDfH
        kbNoB8KH+410tvKX+WSyciE0nuCFv7aRys3OqysW9GxGdVOGfSl4bzncQBToe0P61xXQzkO0FbfjV
        hePzgp6A==;
Received: from [10.20.10.233] (port=65162 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <dev+git@drbeat.li>)
        id 1fcbrQ-00ClGC-Ik; Mon, 09 Jul 2018 21:30:14 +0200
Subject: Re: [RFC PATCH 2/6] refs/refs-internal.h: avoid forward declaration
 of an enum
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
Newsgroups: gmane.comp.version-control.git
References: <20180708144342.11922-1-dev+git@drbeat.li>
 <20180708144342.11922-3-dev+git@drbeat.li>
 <20180709184632.GA9601@sigill.intra.peff.net>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <a3e6c187-74a5-1858-b207-b52d409b11be@drbeat.li>
Date:   Mon, 9 Jul 2018 21:30:12 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180709184632.GA9601@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.07.18 20:46, Jeff King wrote:
> On Sun, Jul 08, 2018 at 04:43:38PM +0200, Beat Bolli wrote:
> 
>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index dd834314bd..a78b5cb803 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -1,6 +1,8 @@
>>  #ifndef REFS_REFS_INTERNAL_H
>>  #define REFS_REFS_INTERNAL_H
>>  
>> +#include "iterator.h"   /* for enum iterator_selection */
> 
> IMHO this kind of comment does more harm than good, because it is so
> prone to going stale (nobody is going to bother updating it when they
> add new dependencies on iterator.h). Anybody who is interested in the
> original reason can use "git blame" to dig up your commit message. And
> anybody who is thinking about deleting that line would need to dig into
> whether anything had been added in the meantime that also requires the
> include.
> 
> So at best it's redundant, and at worst it's slightly misleading. :)
> 
> Not worth a re-roll by itself, but it looked like you had a few other
> bits in the other patches to address.
> 
> Other than this minor quibble, the whole series looks good to me, modulo
> the existing review.
> 
> -Peff
> 

Ooosp, I've just sent the non-RFC reroll without this change.

Junio, would you squash this into [1/6] and [2/6], please (if you agree,
of course :-)

Beat
