Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAC5F202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbdIVQYE (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:24:04 -0400
Received: from avasout07.plus.net ([84.93.230.235]:40006 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbdIVQYC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:24:02 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id CgQ01w0080M91Ur01gQ1SX; Fri, 22 Sep 2017 17:24:01 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=KIigPrQIV3MSycBmqhIA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 3/4] cache.h: hex2chr() - avoid -Wsign-compare warnings
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <ae537e7e-2c3d-f7f3-28f4-451c37c01bbb@ramsayjones.plus.com>
 <20170922054748.iseinawwwfw56vis@sigill.intra.peff.net>
 <89beb424-2cc0-bfe3-7847-c11035bfec70@ramsayjones.plus.com>
 <20170922161159.hkw4id4kpnwo7jou@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d47cdae8-b37f-f378-6df6-bf70a819dd5b@ramsayjones.plus.com>
Date:   Fri, 22 Sep 2017 17:24:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170922161159.hkw4id4kpnwo7jou@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/09/17 17:11, Jeff King wrote:
> On Fri, Sep 22, 2017 at 05:05:03PM +0100, Ramsay Jones wrote:
> 
>>> As an aside, I also see some uses of hexval() that don't appear to be
>>> quite as rigorous in checking for invalid characters. A few
>>> unconditionally shift the first nibble and assume that there will still
>>> be high bits set. I think that's generally true for twos-complement
>>> negative numbers, but isn't shifting off the left side of a signed
>>> integer undefined behavior?
>>
>> All uses of hexval() that I can see are shifting an unsigned value.
>> Have I missed something?
> 
> Hmm. get_hex_color() does:
> 
>   unsigned int val;
>   val = (hexval(in[0]) << 4) | hexval(in[1]));
> 
> Isn't that shifting the signed return value of hexval(), and then
> converting it to unsigned afterwards?

Err ... no. the return value of hexval() is *unsigned int*.
(which is kinda the point!)

> I've been confused by C's integer conversion rules before, though, so
> perhaps I'm wrong.
> 
> I think if this function is fed an empty string that it will also read
> past the end of the buffer for in[1]. It shouldn't matter, since the NUL
> in in[0] would cause us to return an error regardless, but it's still
> undefined behavior.

Correct.

> In fact, this whole function is just hex2chr() implemented badly. Who is
> responsible for this terrible code? ;)

;-)

ATB,
Ramsay Jones


