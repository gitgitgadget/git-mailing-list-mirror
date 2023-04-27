Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F91C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 16:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbjD0Q5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 12:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244313AbjD0Q5N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 12:57:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D854273B
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 09:57:11 -0700 (PDT)
Received: (qmail 23985 invoked by uid 109); 27 Apr 2023 16:57:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Apr 2023 16:57:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20970 invoked by uid 111); 27 Apr 2023 16:57:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Apr 2023 12:57:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Apr 2023 12:57:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 3/4] parse_commit(): handle broken whitespace-only
 timestamp
Message-ID: <20230427165709.GC1976451@coredump.intra.peff.net>
References: <20230427081330.GA1461786@coredump.intra.peff.net>
 <20230427081715.GA1478467@coredump.intra.peff.net>
 <xmqqleidl2ch.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqleidl2ch.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2023 at 09:25:02AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In practice this can't cause us to walk off the end of an array, because
> > we always add an extra NUL byte to the end of objects we load from disk
> > (as a defense against exactly this kind of bug). However, you can see
> > the behavior in action when "committer" is the final header (which it
> > usually is, unless there's an encoding ...
> 
> ... or it is a signed commit or a commit that merges a signed tag.
> 
> There is no need for us to be exhaustive here, but I just wondered
> which one of these three commit object headers is more common.  I
> guess the reason "encoding" came to your mind first is because it is
> the oldest among the three.

Mostly the others did not occur to me at all. :)

I expect that "gpgsig" lines are probably the most common these days,
but that may be my biased view (I guess in the kernel workflow it is
probably signed tags).

-Peff
