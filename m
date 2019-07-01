Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64AEE1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 06:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfGAGdW (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 02:33:22 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:27508 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfGAGdW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 02:33:22 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45ccy73wbpz5tlV;
        Mon,  1 Jul 2019 08:33:19 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9B16C37B;
        Mon,  1 Jul 2019 08:33:18 +0200 (CEST)
Subject: Re: [PATCH] t5319: don't trip over a user name with whitespace
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.261.git.gitgitgadget@gmail.com>
 <d4a3f56b-5eaa-1325-f8c1-be6797a9ac03@kdbg.org>
 <CAPig+cRpOHRgtCXXiqAZtmEtkWnMy7=4GsTVv0XB9R3fF0-66A@mail.gmail.com>
 <1a5bb5f9-e090-7f42-ec3f-cd74bcad831f@kdbg.org>
 <20190630222537.GA21696@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3e5c0286-7514-9e00-fbc5-5b0ad9403d30@kdbg.org>
Date:   Mon, 1 Jul 2019 08:33:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190630222537.GA21696@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.07.19 um 00:25 schrieb Jeff King:
> On Sun, Jun 30, 2019 at 10:59:34PM +0200, Johannes Sixt wrote:
> 
>> Am 30.06.19 um 21:48 schrieb Eric Sunshine:
>>> On Sun, Jun 30, 2019 at 2:57 PM Johannes Sixt <j6t@kdbg.org> wrote:
>>>> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
>>>> @@ -443,7 +443,7 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
>>>> -               MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
>>>> +               MINSIZE=$(stat -c %s .git/objects/pack/*pack | sort -n | head -n 1) &&
>>>
>>> Unfortunately, this is not portable. While "stat -c %s" works on Linux
>>> and MSYS2, neither that option nor the format directive are recognized
>>> on BSD-like platforms (I tested Mac OS and FreeBSD), which instead
>>> need "stat -f %z".
>>
>> Ouch! I did notice that stat(1) is not in POSIX, but hoped that it was
>> sufficiently portable. I need a new idea...
> 
> If we are OK relying on rudimentary perl[1], then:
> 
>   perl -le "print((stat)[7]) for @ARGV"

I'm fine with that. But then we should do the sort + head -n 1 at the
same time. I can do that with a small script, but I'm sure it's possible
in a one-liner...

-- Hannes
