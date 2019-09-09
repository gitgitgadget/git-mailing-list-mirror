Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B4031F463
	for <e@80x24.org>; Mon,  9 Sep 2019 20:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405962AbfIIUDM (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 16:03:12 -0400
Received: from siwi.pair.com ([209.68.5.199]:42576 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405890AbfIIUDM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 16:03:12 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0F4313F4088;
        Mon,  9 Sep 2019 16:03:11 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:6099:d0b3:95b6:588c] (unknown [IPv6:2001:4898:a800:1012:11cd:d0b3:95b6:588c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8843F3F4047;
        Mon,  9 Sep 2019 16:03:10 -0400 (EDT)
Subject: Re: [PATCH v3 1/2] list-objects-filter: only parse sparse OID when
 'have_git_dir'
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jon Simons <jon@jonsimons.org>, git@vger.kernel.org,
        me@ttaylorr.com, sunshine@sunshineco.com, stolee@gmail.com
References: <20190829231925.15223-1-jon@jonsimons.org>
 <20190829231925.15223-2-jon@jonsimons.org>
 <xmqqr252y199.fsf@gitster-ct.c.googlers.com>
 <20190904045424.GA6488@sigill.intra.peff.net>
 <xmqqv9u6po4j.fsf@gitster-ct.c.googlers.com>
 <f32d2e8c-abec-0ec1-daa7-4c10470c5553@jeffhostetler.com>
 <20190909170823.GA30470@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7883417c-56a8-a38e-af2f-81b90b2dd7d3@jeffhostetler.com>
Date:   Mon, 9 Sep 2019 16:03:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190909170823.GA30470@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/9/2019 1:08 PM, Jeff King wrote:
> On Mon, Sep 09, 2019 at 09:54:36AM -0400, Jeff Hostetler wrote:
> 
>> It would be nice if we could continue to let parse_list_objects_filter()
>> do the syntax checking -- that is, we can still check that we received a
>> ulong in "blob:limit:<nr>" and that "sparse:oid:<oid>" looks like a hex
>> value, for example.  Just save the actual <oid> lookup to the higher
>> layer, if and when that makes sense.
> 
> Yeah, I agree that is the right place to do syntactic checking. But I
> think we can't do much checking for the sparse-oid. We currently accept
> not just a hex oid, but any name. And I think that is useful; I should
> be able to say "master:sparse-file" and have it resolved by the remote
> side.

Right. I forgot about the "master:sparse-file" case and was only
thinking about the hex oid case.  The sparse-file case is very
useful.

> 
> So it really is "any name which is syntactically resolvable as a sha1
> expression". At which point I think you might as well punt and just wait
> until we _actually_ try to resolve the name to see if it's valid.
> 
> I'll work up what I sent earlier into a real patch, and include some of
> this discussion.
> 
> -Peff
> 

thanks
Jeff

