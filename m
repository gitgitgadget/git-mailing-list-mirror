Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84400C4332F
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 18:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJOSXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 14:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJOSXI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 14:23:08 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFB04660B
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 11:23:06 -0700 (PDT)
Received: (qmail 19435 invoked by uid 109); 15 Oct 2022 18:23:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 15 Oct 2022 18:23:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12145 invoked by uid 111); 15 Oct 2022 18:23:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 15 Oct 2022 14:23:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 15 Oct 2022 14:23:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonas Bernoulli <jonas@bernoul.li>, git@vger.kernel.org
Subject: Re: "submodule foreach" much slower than removed "submodule--helper
 --list"
Message-ID: <Y0r6iAv1OVUVYNGc@coredump.intra.peff.net>
References: <Y0r4US7AKxT/BLiY@coredump.intra.peff.net>
 <xmqqilkl54wp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilkl54wp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 15, 2022 at 11:16:06AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, that's not too surprising that it's slower. It's exec-ing a bunch
> > of shells to do that.
> > ...
> > I'm not sure if those are exactly equivalent, either. It looks like the
> > old code was probably respecting submodule active markers (though in my
> > test repo without the submodule actually checked out, it's still
> > reported). There is probably room for a user-facing "git submodule list"
> > command, but again, I don't really know enough about the space to say
> > what it should report.
> 
> We could mimic "find" and make "foreach" that has no action default
> to an equivalent of "echo" that is done internally without forking.

That would be reasonable to me, though I wonder what the output format
should be. Just name, or name/oid? Once you start having options, you
might as well just add a separate "git submodule list" that can take
them.

-Peff
