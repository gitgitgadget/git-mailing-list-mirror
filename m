Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CD2520196
	for <e@80x24.org>; Thu, 14 Jul 2016 16:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbcGNQpw (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 12:45:52 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:33898 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265AbcGNQpv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 12:45:51 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rr1mD4XMcz5tlK;
	Thu, 14 Jul 2016 18:45:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 8CF4452A1;
	Thu, 14 Jul 2016 18:45:47 +0200 (CEST)
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
 <20160630090857.GB17463@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607141745420.6426@virtualbox>
Cc:	git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <19a2d02e-3918-3bc9-db34-66e12ab950e4@kdbg.org>
Date:	Thu, 14 Jul 2016 18:45:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1607141745420.6426@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 14.07.2016 um 17:47 schrieb Johannes Schindelin:
> On Thu, 30 Jun 2016, Jeff King wrote:
>> The ustar format only has room for 11 (or 12, depending on
>> some implementations) octal digits for the size and mtime of
>> each file. For values larger than this, we have to add pax
>> extended headers to specify the real data, and git does not
>> yet know how to do so.
>>
>> [...]
>>  t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a | Bin 0 -> 2048 bytes
>
> It appears that this blob cannot be read when sizeof(unsigned long) == 4.
> This happens to break the t5000 test on Windows, where that comparison
> holds true.

The problem occurs in parse_sha1_header_extended(), where the 
calculation of the size in the object header overflows our 32-bit 
unsigned long.

-- Hannes

