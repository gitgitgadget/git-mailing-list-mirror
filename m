Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5054D208E8
	for <e@80x24.org>; Tue, 24 Jul 2018 22:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388716AbeGXXMA (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 19:12:00 -0400
Received: from s019.cyon.net ([149.126.4.28]:50584 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388619AbeGXXMA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 19:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YRNGU1DVdr8uRRvfupGYQL1kEVAK3hQqfD/nR+U/Mi0=; b=Gs5WxhMwCiEF70fmSMJEzOiFKA
        2rq/KMdGX7kAwyhc1ihq/0rNk7MTOagB2/rz3k3JSb8yonU4iCzy7D1138/lbWsGITY71tFnsdPaH
        KyioLCE1PynRHtk5yAkfsyIGTuz96LHGpnmJl5JFrLAeqexHfFbdTtfMptCJLq6E39K76tgmxyNSX
        9Vajbllwmq2xscKffbbXV6xcP+rtutgKPi5om3KBzmDovT/ZmnOQRM/Wdr4qVGm4A/EK+fa8tnJup
        WN1HaM6Wksccy7FdhB7M6g1ElbAdYTS685x8eu0F1KW9laipW2pNcJ/jilwebdzL02u7yr3VFUqko
        ODq3R7og==;
Received: from [10.20.10.232] (port=2606 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <dev+git@drbeat.li>)
        id 1fi5Ov-00B8pv-QW; Wed, 25 Jul 2018 00:03:27 +0200
Subject: Re: [PATCH 2/2] remote-odb: un-inline function remote_odb_reinit
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Christian Couder <christian.couder@gmail.com>
References: <20180724215223.27516-1-dev+git@drbeat.li>
 <20180724215223.27516-3-dev+git@drbeat.li>
 <20180724215953.GD136514@aiede.svl.corp.google.com>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <cf9889ba-89c5-dc97-d888-aa42aa9dee68@drbeat.li>
Date:   Wed, 25 Jul 2018 00:03:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724215953.GD136514@aiede.svl.corp.google.com>
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

Hi Jonathan

On 24.07.18 23:59, Jonathan Nieder wrote:
> Hi,
> 
> Beat Bolli wrote:
> 
>> When compiling under Apple LLVM version 9.1.0 (clang-902.0.39.2) with
>> "make DEVELOPER=1 DEVOPTS=pedantic", the compiler says
>>
>>     remote-odb.c:87:2: error: static function 'remote_odb_do_init' is
>>     used in an inline function with external linkage
>>     [-Werror,-Wstatic-in-inline]
>>
>> Remove the inline specifier that would only make sense if
>> remote_odb_reinit were defined in the header file. Moving it into the
>> header is not possible because the called function remote_odb_do_init is
>> static and thus not visible from the includers of the header.
>>
>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>> ---
>>  remote-odb.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> What branch does this apply to?

To pu as of today.

> [...]
>> --- a/remote-odb.c
>> +++ b/remote-odb.c
>> @@ -82,7 +82,7 @@ static inline void remote_odb_init(void)
>>  	remote_odb_do_init(0);
>>  }
>>  
>> -inline void remote_odb_reinit(void)
>> +void remote_odb_reinit(void)
> 
> This looks like an oversight in
> https://public-inbox.org/git/20180713174959.16748-6-chriscool@tuxfamily.org/:
> there isn't any reason for this function to be inline.
> 
> Christian, can you squash it in on your next reroll?

That would probably make sense. I didn't check how mature the topics
were that caused errors.

Beat
