Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 218E11F404
	for <e@80x24.org>; Mon, 26 Mar 2018 21:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeCZVmS (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 17:42:18 -0400
Received: from siwi.pair.com ([209.68.5.199]:65065 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751913AbeCZVmR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 17:42:17 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6608B3F4026;
        Mon, 26 Mar 2018 17:42:16 -0400 (EDT)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DFE8D3F401E;
        Mon, 26 Mar 2018 17:42:15 -0400 (EDT)
Subject: Re: Including object type and size in object id (Re: Git Merge
 contributor summit notes)
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org,
        jonathantanmy@google.com, bmwill@google.com, stolee@gmail.com,
        sbeller@google.com, peff@peff.net, johannes.schindelin@gmx.de,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
 <874ll3yd75.fsf@evledraar.gmail.com>
 <0c3bb65f-d418-b39e-34c7-c2f3efec7e50@jeffhostetler.com>
 <20180326210039.GB21735@aiede.svl.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b7b6d617-1951-5934-5b1d-bb1a300006ef@jeffhostetler.com>
Date:   Mon, 26 Mar 2018 17:42:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326210039.GB21735@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/26/2018 5:00 PM, Jonathan Nieder wrote:
> Jeff Hostetler wrote:
> [long quote snipped]
> 
>> While we are converting to a new hash function, it would be nice
>> if we could add a couple of fields to the end of the OID:  the object
>> type and the raw uncompressed object size.
>>
>> If would be nice if we could extend the OID to include 6 bytes of data
>> (4 or 8 bits for the type and the rest for the raw object size), and
>> just say that an OID is a {hash,type,size} tuple.
>>
>> There are lots of places where we open an object to see what type it is
>> or how big it is.  This requires uncompressing/undeltafying the object
>> (or at least decoding enough to get the header).  In the case of missing
>> objects (partial clone or a gvfs-like projection) it requires either
>> dynamically fetching the object or asking an object-size-server for the
>> data.
>>
>> All of these cases could be eliminated if the type/size were available
>> in the OID.
> 
> This implies a limit on the object size (e.g. 5 bytes in your
> example).  What happens when someone wants to encode an object larger
> than that limit?

I could say add a full uint64 to the tail end of the hash, but
we currently don't handle blobs/objects larger then 4GB right now
anyway, right?

5 bytes for the size is just a compromise -- 1TB blobs would be
terrible to think about...
  
> 
> This also decreases the number of bits available for the hash, but
> that shouldn't be a big issue.

I was suggesting extending the OIDs by 6 bytes while we are changing
the hash function.

> Aside from those two, I don't see any downsides.  It would mean that
> tree objects contain information about the sizes of blobs contained
> there, which helps with virtual file systems.  It's also possible to
> do that without putting the size in the object id, but maybe having it
> in the object id is simpler.
> 
> Will think more about this.
> 
> Thanks for the idea,
> Jonathan
> 

Thanks
Jeff

