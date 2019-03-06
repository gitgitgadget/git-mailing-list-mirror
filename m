Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B428202BB
	for <e@80x24.org>; Wed,  6 Mar 2019 00:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfCFAXX (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 19:23:23 -0500
Received: from avasout01.plus.net ([84.93.230.227]:41259 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfCFAXX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 19:23:23 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id 1KLBhOhEpzxF51KLChyZdU; Wed, 06 Mar 2019 00:23:22 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=UqFNyd4B c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=9xaNMK5YK-_FNhiWxf4A:9
 a=38krvPT-CBjM5xhQ:21 a=QcDHnBNEsRriIWNB:21 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files, if
 possible
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.130.git.gitgitgadget@gmail.com>
 <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com>
 <20190301213619.GA1518@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903022058230.45@tvgsbejvaqbjf.bet>
 <20190303171951.GD23811@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903041206300.45@tvgsbejvaqbjf.bet>
 <20190304214155.GB3347@sigill.intra.peff.net>
 <xmqqzhq9vpik.fsf@gitster-ct.c.googlers.com>
 <20190305230723.GB22901@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <42d125d4-76bf-afc3-8f12-a9fa1296c85c@ramsayjones.plus.com>
Date:   Wed, 6 Mar 2019 00:23:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305230723.GB22901@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOTT9G3k96WskxD/pt7PjP3Ogt6L21WQ0bgKToJn+vc1uQxiBRxe/cIpMbqprVDLk+3YjF1kNzM5AXFEwTyp4+Vim9GFQFQEPlidAq7IJyxn+ifoFU0X
 T8hajh+9NbkQHjfP/9cwz98BMyGNsMbPv6Uto6ocWnBaG4PcpIc/bVE1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/03/2019 23:07, Jeff King wrote:
> On Tue, Mar 05, 2019 at 02:50:11PM +0900, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> This makes sense to me, though as you noted elsewhere, it doesn't fix
>>> the gcrypt problem, since that file unconditionally wants to look at the
>>> system gcrypt.h (and we control at the Makefile level whether we
>>> actually look at sha256/gcrypt.h).
>>
>> Hmm, is that because the header check target does not know which *.h
>> files we ship are actually used in a particular build?
> 
> Yes, exactly.
> 
>> After a normal build, with dynamic dependency checking on, we would
>> have sufficient information to figure it out.  Would that help?
> 
> Yeah, that's what I was hinting at earlier in the thread. Here it is
> sketched out to an actual working patch. The sub-make bits could
> actually be a shell script instead of a Makefile; the only point in
> using make is to use the parent "-j" for parallelism.

sigh. :(

I wish my patch removing this target had been picked up now!

Earlier this evening I spent an hour or so writing an email which
tried to discourage spending any time on this, because of the
potential for this to be a huge time-suck. An unrewarding one at
that! :-D

The email was actually prompted by someone mentioning 'dynamic
compiler dependencies', because that's how it always starts ...

I deleted that email (it's not in my drafts folder anyway)
because, in the end, it is not up to me to say how people should
spend their time.

So I won't! :-D

ATB,
Ramsay Jones
