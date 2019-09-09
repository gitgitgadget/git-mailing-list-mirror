Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 102571F461
	for <e@80x24.org>; Mon,  9 Sep 2019 17:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405391AbfIIRIZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 13:08:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:44322 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2405382AbfIIRIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 13:08:25 -0400
Received: (qmail 20512 invoked by uid 109); 9 Sep 2019 17:08:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Sep 2019 17:08:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10557 invoked by uid 111); 9 Sep 2019 17:10:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2019 13:10:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Sep 2019 13:08:24 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jon Simons <jon@jonsimons.org>, git@vger.kernel.org,
        me@ttaylorr.com, sunshine@sunshineco.com, stolee@gmail.com
Subject: Re: [PATCH v3 1/2] list-objects-filter: only parse sparse OID when
 'have_git_dir'
Message-ID: <20190909170823.GA30470@sigill.intra.peff.net>
References: <20190829231925.15223-1-jon@jonsimons.org>
 <20190829231925.15223-2-jon@jonsimons.org>
 <xmqqr252y199.fsf@gitster-ct.c.googlers.com>
 <20190904045424.GA6488@sigill.intra.peff.net>
 <xmqqv9u6po4j.fsf@gitster-ct.c.googlers.com>
 <f32d2e8c-abec-0ec1-daa7-4c10470c5553@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f32d2e8c-abec-0ec1-daa7-4c10470c5553@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 09, 2019 at 09:54:36AM -0400, Jeff Hostetler wrote:

> It would be nice if we could continue to let parse_list_objects_filter()
> do the syntax checking -- that is, we can still check that we received a
> ulong in "blob:limit:<nr>" and that "sparse:oid:<oid>" looks like a hex
> value, for example.  Just save the actual <oid> lookup to the higher
> layer, if and when that makes sense.

Yeah, I agree that is the right place to do syntactic checking. But I
think we can't do much checking for the sparse-oid. We currently accept
not just a hex oid, but any name. And I think that is useful; I should
be able to say "master:sparse-file" and have it resolved by the remote
side.

So it really is "any name which is syntactically resolvable as a sha1
expression". At which point I think you might as well punt and just wait
until we _actually_ try to resolve the name to see if it's valid.

I'll work up what I sent earlier into a real patch, and include some of
this discussion.

-Peff
