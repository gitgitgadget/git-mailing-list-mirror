Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 802E62047F
	for <e@80x24.org>; Thu, 21 Sep 2017 07:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbdIUHeK (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 03:34:10 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:53105 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751588AbdIUHeJ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Sep 2017 03:34:09 -0400
X-AuditID: 12074414-0d3ff70000006ddf-be-59c36b70dca3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 44.5A.28127.07B63C95; Thu, 21 Sep 2017 03:34:08 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCB74.dip0.t-ipconnect.de [87.188.203.116])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8L7Y4xv020945
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 21 Sep 2017 03:34:06 -0400
Subject: Re: [PATCH v2 08/21] read_packed_refs(): read references with minimal
 copying
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <cover.1505799700.git.mhagger@alum.mit.edu>
 <597241da13f62d51fefd3396bfbab22a8f633a56.1505799700.git.mhagger@alum.mit.edu>
 <20170920182732.wy6bojeaonpxb3mc@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <b7936c07-a2a2-f17c-b557-2b4916cac3bc@alum.mit.edu>
Date:   Thu, 21 Sep 2017 09:34:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170920182732.wy6bojeaonpxb3mc@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsUixO6iqFuQfTjSYO1+AYu1z+4wWTxff4Ld
        outKN5NFQ+8VZov+5V1sFt1T3jJa/GjpYbZom/mDyWLz5nYWB06P5Tf/MnnsnHWX3ePDxziP
        BZtKPZ717mH0uHhJ2ePzJrkA9igum5TUnMyy1CJ9uwSujN7/J5kL9vNVzPos0cC4kruLkZND
        QsBEYkXDHNYuRi4OIYEdTBJnF21hAkkICVxgkni6KLmLkYNDWCBCYv6SIJCwiICsxPfDGxlB
        6pkFFjFLvDp2kxGi+RCjxL3DK1lBqtgEdCUW9TSDDeIVsJfYObGJEWQQi4CqxOF7wSBhUaCZ
        fW8vs0OUCEqcnPmEBaSEU8BFYvI1MZAws4C6xJ95l5ghbHGJW0/mM0HY8hLb385hnsAoMAtJ
        9ywkLbOQtMxC0rKAkWUVo1xiTmmubm5iZk5xarJucXJiXl5qka6FXm5miV5qSukmRki0iOxg
        PHJS7hCjAAejEg/vBJPDkUKsiWXFlbmHGCU5mJREeSdlAoX4kvJTKjMSizPii0pzUouBgcDB
        rCTCmxEElONNSaysSi3Kh0lJc7AoifN+W6zuJySQnliSmp2aWpBaBJOV4eBQkuC1zwJqFCxK
        TU+tSMvMKUFIM3FwggznARquCFLDW1yQmFucmQ6RP8WoKCXOWwiSEABJZJTmwfXCktkrRnGg
        V4R500GqeICJEK77FdBgJqDB2RsOgAwuSURISTUwOrWtKJ/wKrNyyc7tt7+Z2nNdkkr79U20
        qsXa+fKMkx8Uip2bT7HdZsnkrlPv7ry5deGcjolP3n6Vkt4TssBK0SBHJP6E18f5bxOLbt6O
        0V1j8GNu+Wbbab1/Xr0/pb2e+/NLmxCR1Rq21pvt41fWGmeHHbiddb3qzJsY16MzPh9fofjM
        MerrWyWW4oxEQy3mouJEAOn/PYNBAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/20/2017 08:27 PM, Jeff King wrote:
> On Tue, Sep 19, 2017 at 08:22:16AM +0200, Michael Haggerty wrote:
> 
>> Instead of copying data from the `packed-refs` file one line at time
>> and then processing it, process the data in place as much as possible.
>>
>> Also, instead of processing one line per iteration of the main loop,
>> process a reference line plus its corresponding peeled line (if
>> present) together.
>>
>> Note that this change slightly tightens up the parsing of the
>> `parse-ref` file. Previously, the parser would have accepted multiple
> 
> s/parse-ref/packed-refs/, I assume

Thanks; will fix.

> The patch itself looks good, though I did notice an interesting tangent.
> 
>> +		if (eof - pos < GIT_SHA1_HEXSZ + 2 ||
>> +		    parse_oid_hex(p, &oid, &p) ||
>> +		    !isspace(*p++))
>> +			die_invalid_line(refs->path, pos, eof - pos);
> 
> I wondered why you didn't just check the output of parse_oid_hex(), and
> included the length check (since in the long run we'd like to get rid of
> uses of the static GIT_SHA1_HEXSZ macro). I imagine the answer is that
> this is an mmap'd buffer, and we can't guarantee that parse_oid_hex()
> wouldn't walk off the end of it.

Yes.

> That's fine for now, but I suspect it may become a problem when we move
> to having a second hash function with a different length. You can't just
> say "it must have as many bytes as the longest hash", because of course
> we could have the shorter hash at the end of the buffer. But we also
> can't say "it must have as many bytes as the shortest hash", because if
> the content implies it's a longer hash, we'd read off the end of the
> buffer.
> 
> I think in the long run we will need a parse_oid_hex() function that
> takes a ptr/len (or start/end) pair.

Yes, that makes sense.

> [...]

Michael
