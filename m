Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FC721F453
	for <e@80x24.org>; Sun, 10 Feb 2019 09:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbfBJJkt (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 04:40:49 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:49699 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfBJJkt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 04:40:49 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43y3nV3Sv7z5tlF;
        Sun, 10 Feb 2019 10:40:46 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C56CE144;
        Sun, 10 Feb 2019 10:40:45 +0100 (CET)
Subject: Re: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
To:     Jeff King <peff@peff.net>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
References: <002501d4bfde$b26e6050$174b20f0$@nexbridge.com>
 <20190208191519.GF27673@sigill.intra.peff.net>
 <002b01d4bfe4$2d617f40$88247dc0$@nexbridge.com>
 <20190208193157.GA30952@sigill.intra.peff.net>
 <20190208220714.GG11927@genre.crustytoothpaste.net>
 <005901d4bffb$6d0c34c0$47249e40$@nexbridge.com>
 <20190208223512.GA2135@sigill.intra.peff.net>
 <006601d4c001$2de3a160$89aae420$@nexbridge.com>
 <20190209042456.GB18286@sigill.intra.peff.net>
 <38f594ed-0787-aeb5-d34f-2f4775243eb7@kdbg.org>
 <20190209232928.GA7135@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <de25ab29-e4dc-aee2-7396-657c71a550dd@kdbg.org>
Date:   Sun, 10 Feb 2019 10:40:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190209232928.GA7135@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.02.19 um 00:29 schrieb Jeff King:
> On Sat, Feb 09, 2019 at 09:39:43AM +0100, Johannes Sixt wrote:
>>  	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
>> -	dd if=/dev/zero of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=$(($orig_size - $zero_pos)) &&
>> +	printf "%0*d" $(($orig_size - $zero_pos)) 0 | tr 0 '\0' |
>> +		dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" &&
> 
> Using stdin instead of the tmpfile is nice, and shouldn't have any
> problems. I do think your printf suggestion looks nice, but I wondered
> if it might run into portability issues (not because of anything in
> particular, but I often find that the more clever a shell solution, the
> more likely we run into obscure problems).
> 
> But if it works everywhere, that's fine by me.

Unfortunately, it does not work as intended: the printf solution cannot
print nothing, but that should be the case in all but one of the tests.

-- Hannes
