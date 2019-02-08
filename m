Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C48E91F453
	for <e@80x24.org>; Fri,  8 Feb 2019 18:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfBHS3i (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 13:29:38 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:47764 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfBHS3i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 13:29:38 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43x3cZ4C53z5tlB;
        Fri,  8 Feb 2019 19:29:34 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 70B72211F;
        Fri,  8 Feb 2019 19:29:33 +0100 (CET)
Subject: Re: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
To:     Jeff King <peff@peff.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
References: <000f01d4bf9e$a508eab0$ef1ac010$@nexbridge.com>
 <20190208165052.GC23461@sigill.intra.peff.net>
 <001101d4bfd6$b9430230$2bc90690$@nexbridge.com>
 <20190208180321.GB27673@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0694f2f1-040a-1d8c-cd01-2cf51cdbe426@kdbg.org>
Date:   Fri, 8 Feb 2019 19:29:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190208180321.GB27673@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.02.19 um 19:03 schrieb Jeff King:
> On Fri, Feb 08, 2019 at 12:49:59PM -0500, Randall S. Becker wrote:
>> Would you object to something like this:
>>
>> if [ ! -e /dev/zero ]; then
>> 	# use shred or some other mechanism (still trying to figure out a solution)
>> else
>> 	# existing dd
>> fi
> 
> That's fine, as long as it's wrapped up in a function in order to keep
> the tests readable.
> 
> Though I suspect we may be able to just find a solution that works
> everywhere, without having two different implementations. If we know we
> need $count bytes for dd, we could probably just generate a file with
> that many NULs in it.
> 
> Other cases don't seem to actually care that they're getting NULs, and
> are just redirecting stdin from /dev/zero to get an infinite amount of
> input. They could probably use "yes" for that.

If the data does not have to be a sequence of zero bytes, the
alternatives are:

* `test-genrandom seed-string $size` for a sequence of reproducible
"random" bytes

* `printf "%0*d" $size 0` for a sequence of '0' characters.

In t5318, the zero bytes do matter, though.

-- Hannes
