Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EAB01F453
	for <e@80x24.org>; Tue, 30 Apr 2019 22:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfD3W7n (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 18:59:43 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:17457 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfD3W7m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 18:59:42 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44txms06dCz5tlB;
        Wed,  1 May 2019 00:59:41 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A9B1D49BA;
        Wed,  1 May 2019 00:59:40 +0200 (CEST)
Subject: Re: [PATCH 2/2] mingw: enable DEP and ASLR
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@i10z.com>,
        =?UTF-8?Q?=c4=b0smail_D=c3=b6nmez_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <pull.134.git.gitgitgadget@gmail.com>
 <e142c1396ec3541486317819e885cf42be24af34.1556575015.git.gitgitgadget@gmail.com>
 <8e59dbf6-a339-74f3-4e60-e56b3817aea5@kdbg.org>
 <nycvar.QRO.7.76.6.1904301838400.45@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <9ec02c05-daf9-ffe3-ef64-2c550e29f5b7@kdbg.org>
Date:   Wed, 1 May 2019 00:59:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1904301838400.45@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.05.19 um 00:41 schrieb Johannes Schindelin:
> On Tue, 30 Apr 2019, Johannes Sixt wrote:
>> Am 29.04.19 um 23:56 schrieb İsmail Dönmez via GitGitGadget:
>>> diff --git a/config.mak.uname b/config.mak.uname
>>> index e7c7d14e5f..a9edcc5f0b 100644
>>> --- a/config.mak.uname
>>> +++ b/config.mak.uname
>>> @@ -570,6 +570,12 @@ else
>>>  	ifeq ($(shell expr "$(uname_R)" : '2\.'),2)
>>>  		# MSys2
>>>  		prefix = /usr/
>>> +		# Enable DEP
>>> +		BASIC_LDFLAGS += -Wl,--nxcompat
>>> +		# Enable ASLR (unless debugging)
>>> +		ifneq (,$(findstring -O,$(CFLAGS)))
>>> +			BASIC_LDFLAGS += -Wl,--dynamicbase
>>> +		endif
>>>  		ifeq (MINGW32,$(MSYSTEM))
>>>  			prefix = /mingw32
>>>  			HOST_CPU = i686
>>>
>>
>> I'm a bit concerned that this breaks my debug sessions where I use -O0.
>> But I'll test without -O0 before I really complain.
> 
> Weird. Jameson Miller also mentioned this very concern in an internal
> review.
> 
> I guess I'll do something like
> 
> 	ifneq (,$(findstring -O,$(filter-out -O0,$(CFLAGS))))
> 
> Does that work for you?

That could work. I'm a bit distracted at the moment, so it may take some
time until I can test.

-- Hannes
