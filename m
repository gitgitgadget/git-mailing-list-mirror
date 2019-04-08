Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76EC520248
	for <e@80x24.org>; Mon,  8 Apr 2019 19:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfDHTUA (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 15:20:00 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:4996 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfDHTUA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 15:20:00 -0400
Received: from [192.168.1.12] ([2.101.245.142])
        by smtp.talktalk.net with SMTP
        id DZoDhM2CZniZTDZoDhR9JF; Mon, 08 Apr 2019 20:19:58 +0100
X-Originating-IP: [2.101.245.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=B8HHL9lM c=1 sm=1 tr=0 a=mQgiQ6BlbOv19lEfDgieCg==:117
 a=mQgiQ6BlbOv19lEfDgieCg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=aulWLQ49AAAA:20 a=XKtjkRDYAAAA:20
 a=TPdw0ElWz-GiiVxp7BgA:9 a=QEXdDO2ut3YA:10
Subject: Re: [GSoC][RFC] Proposal: Make pack access code thread-safe
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <CAHd-oW7KMrDJ-cyzk63oqW9-QVpag6fKnDp+Mo5bWxg1KfzY3g@mail.gmail.com>
 <CAP8UFD0qeOaS8NBOaMjzDf_tWJrgkYSAOgn8D=4JER2atg3H8g@mail.gmail.com>
 <CACsJy8DxW7ZcSNQBZq4+A6c+9xZopg79sXfi6Na61Xgcoqd6ng@mail.gmail.com>
 <79ecdc5b-2ccf-ae4d-3775-b850641f8c3e@iee.org>
 <CAHd-oW5PFmj4u2YB-1TcHWNxkokfCEsUq_zB=Rx2Vmdk5Z9eMw@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <1348d823-9729-a5eb-2104-df7c4a41911d@iee.org>
Date:   Mon, 8 Apr 2019 20:19:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHd-oW5PFmj4u2YB-1TcHWNxkokfCEsUq_zB=Rx2Vmdk5Z9eMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHJaMeEY+H/FwccQ+WF/xoBpsckBLS0cjvoOlPNvUcTepMZ9vtKTLAAkS2r1S5YY27E3ccwxmzzdqwupy18hFFIe9a9T9EgMWHJei4cSnl4unh8HG2vB
 RO0WAkuCgR32Jo0sk5eybl7y6731kUmm6PTtvNvCz51w5tNQBu5a7FSFJu7vChhsGtrP8RNEfuKvWpK+OG2mxTZddBQY8pQY87wFntp3x3LLR5H93OzCJFCm
 MEISdweScV0ImqeQUq1WlukSif2DQW9uInigcDQE7yLeH9Kqm/oNlYONTcHYbo4RvAzAJWPGUFqRsJ9GrtmZFEy0nQwE+bQ9IjCVRnuqyd9hpy3mCTcK9o5c
 XISD4jKMOBLGCCgjelZdo3jVGMQq+WSUwzbYRDcz024rnNB6SkCcxUXgt8h+oHxLhpcnr3SVzSHCL+l0btHcLAeDwCpEIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus

On 08/04/2019 18:04, Matheus Tavares Bernardino wrote:
>> Another "32-bit problem" should also be expressly considered during the
>> GSoC work because of the MS Windows definition of uInt / long to be only
>> 32 bits, leading to much of the Git code failing on the Git for Windows
>> port and on the Git LFS (for Windows) for packs and files greater than
>> 4Gb.https://github.com/git-for-windows/git/issues/1063

> Thanks for pointing it out. I didn't get it, thought, if your
> suggestion was to also propose tackling this issue in this GSoC
> project. Was it that? I read the link but it seems to be a kind of
> unrelated problem from what I'm planing to do with the pack access
> code (which is tread-safety). I may have understood this wrongly,
> though. Please, let me know if that's the case :)
> 
The main point was to avoid accidental regressions by re-introducing 
simple 'longs' where memsized types were more appropriate.

Torsten has already done a lot of work at 
https://github.com/tboegi/git/tree/tb.190402_1552_convert_size_t_only_git_master_181124_mk_size_t

HTH
Philip
(I'm off line for a few days)
