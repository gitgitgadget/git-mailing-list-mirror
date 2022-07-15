Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03073CCA47C
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 10:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiGOKgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 06:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGOKgk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 06:36:40 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E01753BB
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 03:36:39 -0700 (PDT)
Received: from [78.147.178.211] (helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oCIgV-0003ql-Ff;
        Fri, 15 Jul 2022 11:36:36 +0100
Message-ID: <3320033a-54a3-ddbc-d03a-197f209541ec@iee.email>
Date:   Fri, 15 Jul 2022 11:36:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/6] Documentation/technical: describe bitmap lookup
 table extension
Content-Language: en-GB
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
References: <ac52cfea-edb0-b68b-36e2-ab45d2959727@iee.email>
 <20220709075310.83848-1-chakrabortyabhradeep79@gmail.com>
 <d70a4505-60ef-82c4-5497-499ac788782a@iee.email>
 <YtCjlkPdA3CUn/Aw@nand.local>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <YtCjlkPdA3CUn/Aw@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/07/2022 00:15, Taylor Blau wrote:
> On Sun, Jul 10, 2022 at 04:01:11PM +0100, Philip Oakley wrote:
>>>> Not sure if this is new in this extension, but should there be a link or
>>>> two to the basics of XOR compression and some of the bitmap look up
>>>> techniques?
>>>>
>>>> It's not always obvious if these techniques are 'heuristic' and only
>>>> have partial commit data, or they have all the commits listed, Nor
>>>> how/why they work. My point is more about giving new readers a hand-up
>>>> in their understanding, rather than simple implementation details for
>>>> those who already know what is going on. For example, are there any
>>>> external articles that you found helpful in getting started that could
>>>> be referenced somewhere in the docs?
>>> As this series is only about adding a lookup-table extension (and not
>>> about bitmap itself), I am not sure whether it's good to include those
>>> things in this series.
>> Thanks for the clarification. I must have slight misread some of the
>> discussions and falsely thought it was the XOR compression (which is a
>> technique I wasn't really aware of), that was being provided by the
>> extension - Where would it be best for me to look up the background to
>> your "extension" project?
> Yeah, Abhradeep is right that the XOR compression isn't new, we already
> serialize bitmaps with optional XOR offsets. The gist is that we give an
> offset of some previous bitmap that is used to compress the current one
> by XORing the bits in the current bitamp with the previous one. These
> XOR-compressed bitmaps are often sparse, so they compress well and
> reduce the overall size of the .bitmap.

I was thinking of a short paragraph that covers the broader 'why'
aspects, rather than the what/how. For me, XOR is a 'new' compression
method that (IIUC) takes advantage of certain features of the way the
data is arranged, such that the XOR has lots of leading zeros, leading
to the compression mentioned.

I think it's that we sort on oid name, so that despite the oid being
long, we have (typically) sufficient oids that the leading XOR bits of
adjacent pairs allows effective compression. But I could have guessed
wildly wrong.

I'd been looking at
https://www.timescale.com/blog/time-series-compression-algorithms-explained/
which gave an overview for sorted floats.
I'd not had time to review the paper "Gorilla: A Fast, Scalable,
In-Memory Time Series Database"
http://www.vldb.org/pvldb/vol8/p1816-teller.pdf
>
> A slightly more detailed overview can be found in
> Documentation/technical/bitmap-format.txt under the bullet point reading
> "1-byte XOR-offset".
>
A separate point is the linkage (or not) between the older reachability
bit maps, and the commit graph, which sound to be independent options
and features, yet appear rather interrelated.

Thanks

Philip


