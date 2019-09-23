Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47DAB1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 19:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfIWTQ3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 15:16:29 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:36036 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727284AbfIWTQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 15:16:29 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46cYvv3H5Lz5tl9;
        Mon, 23 Sep 2019 21:16:27 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 391554AAB;
        Mon, 23 Sep 2019 21:16:26 +0200 (CEST)
Subject: Re: [PATCH] name-rev: avoid cutoff timestamp underflow
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <20190922180143.25026-1-szeder.dev@gmail.com>
 <5692e751-ae5b-e1c8-e5f7-79f0b43e20c0@gmail.com>
 <20190922195312.GC10866@szeder.dev>
 <8e7617ef-85d0-df3f-4418-5a2502b8e726@kdbg.org>
 <20190923083723.GD10866@szeder.dev>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <fe58f33f-a3ae-4981-5bb7-d1659f3ab189@kdbg.org>
Date:   Mon, 23 Sep 2019 21:16:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923083723.GD10866@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.09.19 um 10:37 schrieb SZEDER Gábor:
> On Sun, Sep 22, 2019 at 11:01:26PM +0200, Johannes Sixt wrote:
>> Huh? For signed cutoff and positive CUTOFF_DATE_SLOP,
>> cutoff - CUTOFF_DATE_SLOP < cutoff is ALWAYS true. Signed interger
>> underflow is undefined behavior and signed integer arithmetic does not
>> wrap around!
>>
>> IOW, the new condition makes only sense today, because cutoff is an
>> unsigned type, but breaks down should we switch to a signed type.
> 
> Yeah, that's what I meant with worrying about signed underflow in the
> commit message.  As long as the cutoff is at least a day later than
> the minimum value of our future signed 'timestamp_t', the condition
> does the right thing.  And considering that oldest time a signed 64
> bit timestamp can represent far exceeds the age of the universe, and
> the oldest value of even a signed 32 bit timestamp is almost half the
> age of the Earth, I wasn't too worried.

Note that commits and timestamps can be forged easily. I'm not worried
that Git does not work "correctly" with forged timestamps (as long as it
is not exploitable); but when it is simple to make foolproof, we should
do it.

BTW, 32-bit timestamps cover just ~135 years (not half the age of
Earth). That's too little for people who want to store historic
documents in a Git repository.

-- Hannes
