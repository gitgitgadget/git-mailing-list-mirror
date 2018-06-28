Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DB141F516
	for <e@80x24.org>; Thu, 28 Jun 2018 18:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030559AbeF1Sxb (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 14:53:31 -0400
Received: from avasout08.plus.net ([212.159.14.20]:49624 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752281AbeF1Sxa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 14:53:30 -0400
Received: from [10.0.2.15] ([80.189.70.235])
        by smtp with ESMTPA
        id Yc2qfQklNhidhYc2rf6HyD; Thu, 28 Jun 2018 19:53:29 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=B6uXLtlM c=1 sm=1 tr=0
 a=YX39wz5waiCDnkc2J8opfw==:117 a=YX39wz5waiCDnkc2J8opfw==:17
 a=IkcTkHD0fZMA:10 a=9wvYwXf8nDrVumTalMAA:9 a=Se_SLbcJ4ZArTuUj:21
 a=w9s0o3Dlg1PrVKjS:21 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] fsck: check skiplist for object in fsck_blob()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
References: <2fc2d53f-e193-2a2a-9f8f-b3e1d256d940@ramsayjones.plus.com>
 <20180628114912.GA12901@sigill.intra.peff.net>
 <0a18acbd-0124-1c92-0046-05b8b035dd28@ramsayjones.plus.com>
 <20180628174501.GC31766@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <db7683ab-1025-d7bb-d0ce-fc4ee28681e1@ramsayjones.plus.com>
Date:   Thu, 28 Jun 2018 19:53:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628174501.GC31766@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfO+vzyN70iXMOHQJTdtBS5cKbMx9tqzcqbHjgX3y5UZGVwGOf+iqrmn/RD/O6bTH6A+RLZjdUlvi4KyvG19/hO1rqXJLi8ID0d4hkEkdnJfBiXI6TuPy
 u+HbB6l5f7vCzuQgfEQ37zraCHDMmx2B+nrrp547aXA9wNEj3zArPdIn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28/06/18 18:45, Jeff King wrote:
> On Thu, Jun 28, 2018 at 05:56:18PM +0100, Ramsay Jones wrote:
[snip]
>>> One thing we could do is turn the parse failure into a noop. The main
>>> point of the check is to protect people against the malicious
>>> .gitmodules bug. If the file can't be parsed, then it also can't be an
>>> attack vector (assuming the parser used for the fsck check and the
>>> parser used by the victim behave identically).
>>
>> Hmm, yeah, but I would have to provide a means of suppressing
>> the config parser error messages. Something I wanted to avoid. :(
> 
> Yes, though I don't think it's too bad. We already have a "die_on_error"
> flag in the config code. I think it just needs to become a tristate:
> die/error/silent (and probably get passed in via config_options, since I
> think we tie it right now to the file/blob source).

Yes, but this code is already very crufty - and I'm just
waiting for someone to want to have per-repo/submodule
config parsing i... ;-)

>> Junio, do you want me to address the above 'rejected push'
>> issue in this patch, or with a follow-up patch? (It should
>> be a pretty rare problem - famous last words!)
> 
> Hmm, if we end up doing the config thing above, then this patch would
> become unnecessary.

I was thinking of timing - the current patch could go
in quickly to solve the immediate problem (eg. in maint).

Also, it does not hurt to do this _as well as_ suppress
the config errors.

> And I think doing that would help _all_ cases, even ones without a
> skiplist. They don't need to see random config error messages either,
> even if we do eventually report an fsck error.

Oh, yes, I agree. You will have noticed that it was my
first suggested solution. (I have started writing that
patch a few times, but it just makes me want to throw
the current code away and start again)!

Hmm, BTW, the 'rejected push' problem would include *any*
'.gitmodules' blob that contained a syntax error, right?

Maybe it won't be as rare as all that! (Imagine not being
able to push due to a compiler error/warning in source files.
How irritating would that be! :-P ).

(if we fix this, you could hide some nefarious settings
after an obvious syntax error - then get the victim to
fix the syntax error ...)

ATB,
Ramsay Jones

