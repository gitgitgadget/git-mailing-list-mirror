Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15AC02047F
	for <e@80x24.org>; Thu, 21 Sep 2017 08:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbdIUIEG (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 04:04:06 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:43208 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751649AbdIUIEF (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Sep 2017 04:04:05 -0400
X-AuditID: 12074411-f95ff70000007f0a-b4-59c372745cc7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 37.D5.32522.47273C95; Thu, 21 Sep 2017 04:04:04 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCB74.dip0.t-ipconnect.de [87.188.203.116])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8L841Ks022349
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 21 Sep 2017 04:04:02 -0400
Subject: Re: [PATCH v2 13/21] packed_ref_cache: keep the `packed-refs` file
 mmapped if possible
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <cover.1505799700.git.mhagger@alum.mit.edu>
 <b32234e07a1bd1e60442a13d97d7c4e51edf3336.1505799700.git.mhagger@alum.mit.edu>
 <20170920184058.w3tipgsz54ig7dm5@sigill.intra.peff.net>
 <20170920185119.upnyomtlxobxwvlw@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <b092c424-987a-fe00-43d4-17062000dfc0@alum.mit.edu>
Date:   Thu, 21 Sep 2017 10:04:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170920185119.upnyomtlxobxwvlw@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsUixO6iqFtadDjSoFPeYu2zO0wWz9efYLfo
        utLNZNHQe4XZon95F5tF95S3jBY/WnqYLTZvbmdx4PDYOesuu8eHj3EeCzaVejzr3cPocfGS
        ssfnTXIBbFFcNimpOZllqUX6dglcGfs6ZApeC1TsndnM2MA4l7eLkZNDQsBEou1/K1sXIxeH
        kMAOJolTTzYyQjgXmCQunDvLDFIlLJAosWD5A1YQW0RAVuL7YYgiZoFnTBKvb85jguj4wyjx
        5dpLJpAqNgFdiUU9zUA2BwevgL3E1nN8IGEWAVWJhlezwUpEBSIk+t5eZgexeQUEJU7OfMIC
        YnMKuEhMnLiEEcRmFlCX+DPvEjOELS5x68l8JghbXmL72znMExgFZiFpn4WkZRaSlllIWhYw
        sqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXVy80s0UtNKd3ECIkOwR2MM07KHWIU4GBU4uGd
        YHI4Uog1say4MvcQoyQHk5Io75FCoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3owgoBxvSmJl
        VWpRPkxKmoNFSZyXb4m6n5BAemJJanZqakFqEUxWg4NDoHfN6guMUix5+XmpShK8bMDkICRY
        lJqeWpGWmVOCUMrEwQmyiAdo0UOQI3iLCxJzizPTIfKnGBWlxHlrQBICIImM0jy4XlhSe8Uo
        DvSWMK8NSBUPMCHCdb8CGswENDh7wwGQwSWJCCmpBsb8yiuXkxrUXro+067i6LDa9WuNj9wP
        l331cS1CD5/FJVxTrT917fsuHcn/1/bnxfdLX/l34VP1pfm/+nwPPl2ovt3F431X+nq/O7/4
        2Fxjp5lOKD7Eonv+e8tk0e0GrJoKywSVY5ZpPzNks5C6kHpru/L30+6uf/5UZUtfStLqipb4
        Isk2X1aJpTgj0VCLuag4EQANUqhaRQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/20/2017 08:40 PM, Jeff King wrote:
> [...]
> The overall strategy for this compile-time knob makes sense, but one
> thing confused me:
> 
>> +ifdef MMAP_PREVENTS_DELETE
>> +	BASIC_CFLAGS += -DMMAP_PREVENTS_DELETE
>> +else
>> +	ifdef USE_WIN32_MMAP
>> +		BASIC_CFLAGS += -DMMAP_PREVENTS_DELETE
>> +	endif
>> +endif
> 
> So setting the knob does what you'd expect. But if you don't set it,
> then we still auto-tweak it based on the USE_WIN32_MMAP knob. Do we need
> that? It seems like we set our new knob in config.mak.uname any time
> we'd set USE_WIN32_MMAP. So this only has an effect in two cases:
> 
>  1. You aren't on Windows, but you set USE_WIN32_MMAP yourself.
> 
>  2. You are on Windows, but you manually unset MMAP_PREVENTS_DELETE.
> 
> I expect both cases are rare (and would probably involve somebody
> actively debugging these knobs). Probably it's a minor convenience in
> case 1, but in case 2 it would be actively confusing, I'd think.

Makes sense. I'll delete the `else` clause from the above hunk.

On 09/20/2017 08:51 PM, Jeff King wrote:
> On Wed, Sep 20, 2017 at 02:40:58PM -0400, Jeff King wrote:
> 
>>> +enum mmap_strategy {
>>> +	/*
>>> +	 * Don't use mmap() at all for reading `packed-refs`.
>>> +	 */
>>> +	MMAP_NONE,
>>> +
>>> +	/*
>>> +	 * Can use mmap() for reading `packed-refs`, but the file must
>>> +	 * not remain mmapped. This is the usual option on Windows,
>>> +	 * where you cannot rename a new version of a file onto a file
>>> +	 * that is currently mmapped.
>>> +	 */
>>> +	MMAP_TEMPORARY,
>>
>> I suspect you originally distinguished these cases so that NO_MMAP does
>> not read into a fake-mmap buffer, followed by us copying it into another
>> buffer. But AFAICT we handle the "NONE" and "TEMPORARY" cases exactly
>> the same (by just doing a read_in_full() into our own buffer). Do we
>> actually need separate strategies?
> 
> In case you are reading these sequentially, I think I talked myself into
> the utility of this during the next patch. ;)

Sorry about that. I'll add a forward breadcrumb to the log message of
this commit.

Michael
