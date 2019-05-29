Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF7EE1F462
	for <e@80x24.org>; Wed, 29 May 2019 23:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfE2X1t (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 19:27:49 -0400
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:58868 "EHLO
        resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbfE2X1t (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 May 2019 19:27:49 -0400
Received: from resomta-po-11v.sys.comcast.net ([96.114.154.235])
        by resqmta-po-06v.sys.comcast.net with ESMTP
        id W5kwh4HRquZnZW7z3h6q8M; Wed, 29 May 2019 23:27:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559172469;
        bh=SJ7cvUEiN0F5Ebu/DClz83D3TRju1R3dpYi7/bSgKng=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=aP2V9hCZv+A84rXV2PjD2GcvARVAD10MqKPagdeqica1xjS5LuEoL/XLPOwQfObOq
         1KGnrN5YeLVvxHbw+I4/tf4UxoHq3jCEMy4tplDL6G+1K1nfhlcTwWyFNZ4c1k23Kw
         NOdw5PDMxWvjumLo1pBrggBZQXgAbLUz0zywn6Oj0jYFuyInvxdCrYT12Nq19d2fap
         pgG0PGRg33rORd8F+hbu2qMIOcrGwSUDe1eEpOp6nWyA1tZglBtCSmb4WRhN0aMsky
         bZb19aQ5AXv5csEWaheoYSPy3GKRIsLDu3TXOqOJiN3FWmXJLCJREEXbg9zrrsauez
         jnGTzDYu2k3+g==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:fc46:edea:c698:2e7a])
        by resomta-po-11v.sys.comcast.net with ESMTPSA
        id W7z1h0xFkVCZLW7z2hqtXy; Wed, 29 May 2019 23:27:48 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Wed, 29 May 2019 16:27:46 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
Message-ID: <20190529232746.GE4700@comcast.net>
References: <cover.1558484115.git.matvore@google.com>
 <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
 <2b47d4b1-ea62-d59e-77e0-d95dfad084e0@jeffhostetler.com>
 <xmqqh89e31fg.fsf@gitster-ct.c.googlers.com>
 <20190529150228.GC4700@comcast.net>
 <9f1025ec-a3d7-c5f4-4a7a-15e4131f2b87@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f1025ec-a3d7-c5f4-4a7a-15e4131f2b87@jeffhostetler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 29, 2019 at 05:29:14PM -0400, Jeff Hostetler wrote:
> Was sparse:path filter the only reason for needing all the URL encoding?
> The sparse:oid form allows values <ref>:<path> and these (or at least
> the <path> portion) may contain special characters.  So don't we need to
> URL encode this form too?

Oh, I missed this. I was only thinking an oid was allowed after "sparse:". So as
I suspected I was overlooking something obvious.

Now I just want to understand the objection to URL encoding a little better. I
haven't worked with in a project that requires a lot of boilerplate before, so I
may be asking obvious things again. If so, sorry in advance.

So the objections, as I interpret them so far, are that:

 a the URL encoding/decoding complicates the code base
 b explaining the URL encoding, while it allows for future expansion, requires
   some verbose documentation in git-rev-list that is potentially distracting or
   confusing
 c there may be a better way to allow for future expansion that does not require
   URL encoding
 d the URL encoding is unpleasant to use (note that my patchset makes it
   optional for the user to use and it is only mandatory in sending it over the
   wire)

I think these are reasonable and I'm willing to stop digging my heels in :) Does
the above sum everything up?
