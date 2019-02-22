Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E94BE20248
	for <e@80x24.org>; Fri, 22 Feb 2019 21:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfBVV6S (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 16:58:18 -0500
Received: from avasout05.plus.net ([84.93.230.250]:51702 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVV6R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 16:58:17 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id xIpjg4eRiQ0U1xIpkgxsxs; Fri, 22 Feb 2019 21:58:16 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=YsghubQX c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=b4MSFsdFhresePWlHBYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 2/6] Makefile: move "strip" assignment down from flags
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Lars Schneider <larsxschneider@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
References: <20190222105658.26831-1-avarab@gmail.com>
 <20190222144127.32248-3-avarab@gmail.com>
 <20190222151834.GA21524@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <4821a31a-f5ee-39ef-5302-8b71430815fe@ramsayjones.plus.com>
Date:   Fri, 22 Feb 2019 21:58:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222151834.GA21524@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMkdb/e8Yo0EjLEax9qDS4b1UOh13bJpKWpnGSj2QKxwklSzhTH0d0xdMeOC1kZQh+u3jGgwGhfqc/YIp8f0XI8ig7mySFlCVl3aYvhkA1UXJNbCa2tt
 kmLV8MF/ZRVrJxQ9sicriNUxW7v0pa8Oh94hClAPzNcWsc/RSZsNhxhE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/02/2019 15:18, Jeff King wrote:
> On Fri, Feb 22, 2019 at 03:41:23PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
>> Move the assignment of the "STRIP" variable down to where we're
>> setting variables with the names of other programs.
>>
>> For consistency with those use "=" for the assignment instead of
>> "?=". I can't imagine why this would need to be different than the
>> rest, and 4dc00021f7 ("Makefile: add 'strip' target", 2006-01-12)
>> which added it doesn't provide an explanation.
> 
> This might annoy somebody expecting $STRIP in the environment to have
> precedence. But I agree that consistency is probably our best strategy
> here, and I don't see any reason the same argument would not apply to
> $SPATCH, or $CC for that matter.
> 
> (So I could see an argument for moving them all to "?=", but that can
> create its own confusion as environment variables accidentally start
> taking effect).

$STRIP and $SPATCH will work OK, but you would be disappointed
with $CC (or any other variable from make's built-in database). ;-)

Try this:

  $ cat -n Makefile 
       1	
       2	CC ?= gcc
       3	
       4	all:
       5		@echo "CC is $(CC), origin " $(origin CC)
       6	
  $ 

The command-line works OK:

  $ make CC=cmd-line
  CC is cmd-line, origin  command line
  $ 

So does the environment:

  $ CC=env make
  CC is env, origin  environment
  $ 

But that conditional assignment:

  $ make
  CC is cc, origin  default
  $ 
  
... not so much! :-D

ATB,
Ramsay Jones

