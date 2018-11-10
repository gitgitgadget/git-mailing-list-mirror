Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 984111F453
	for <e@80x24.org>; Sat, 10 Nov 2018 14:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbeKKAo1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 19:44:27 -0500
Received: from avasout05.plus.net ([84.93.230.250]:37260 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeKKAo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 19:44:26 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id LUj5gKS06b8UmLUj6gAzNN; Sat, 10 Nov 2018 14:59:08 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=cOzOTGWN c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=UCCwb3ANNhppX__sAh0A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 12/16] parse-options: replace opterror() with optname()
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181105192059.20303-1-pclouds@gmail.com>
 <20181105192059.20303-13-pclouds@gmail.com>
 <xmqqpnvjexzf.fsf@gitster-ct.c.googlers.com>
 <d29c4fcc-0591-fc45-5a5d-65d2874d98a7@ramsayjones.plus.com>
 <CACsJy8CM=0Cw1WCamJJe8aapA4-mdr+rMmbjVpYYQCj2++NQbA@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <2bbd6010-c4c5-df68-3583-51a354e3ab5a@ramsayjones.plus.com>
Date:   Sat, 10 Nov 2018 14:59:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8CM=0Cw1WCamJJe8aapA4-mdr+rMmbjVpYYQCj2++NQbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBod5+dOxaDDHT8qw6bfRB8VCpKZhNQOnmkHtU5eFxOqVXlKHa1nmGCp871TDJZhYILOZEcbcMwNht7d/lysIBg6O4V07i1thBMZsitO1qynNQLVC1Sk
 aqffJp/1QEIkCqvVmfsYa8zJrXtubds32j0PoqYTTNGbqpSl63/b1o+mZEvYvKiiW3iJbLr3ftlkUw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/11/2018 04:55, Duy Nguyen wrote:
> On Tue, Nov 6, 2018 at 3:07 PM Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>> Also, this patch does not replace opterror() calls outside of
>> the 'parse-options.c' file with optname(). This tickles my
>> static-check.pl script, since optname() is an external function
>> which is only called from 'parse-options.c'.
>>
>> So, at present, optname() could be marked as a local 'static'
>> symbol. However, I could also imagine it being used by new callers
>> outside of 'parse-options.c' in the future. (maybe) Your call. ;-)
> 
> I was making it static, but the compiler complained about undefined
> function and I would need to either move optname() up in
> parse-options.c or add a forward declaration (but I was going to
> _remove_ the declaration!)
> 
> Since it could be potentially used by Jeff's series (and I think it
> does have potential in parse-options-cb.c), I'll just leave it
> exported and caress your static-check.pl script

Fair enough.

>                                                (how did it not catch
> optbug() not being used outside parse-options.c either)?

It did, some time ago (presumably, I haven't checked). Which is to
say: the output from the master branch notes it:

    $ grep parse-options sc
    parse-options.o	- optbug
    $ 

... but if it gets to the master branch I tend to forget it. (I have
been meaning to go through the 'sc' file and clean out some of the
'easy' cases).

So, if optname() doesn't get any new callers, I will watch it go
from 'pu' to 'next' and then to 'master' and ... ;-)

ATB,
Ramsay Jones
