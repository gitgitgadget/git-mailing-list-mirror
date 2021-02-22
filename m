Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F1CC433DB
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 23:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB6F64E00
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 23:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhBVXlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 18:41:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:40866 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhBVXlH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 18:41:07 -0500
Received: (qmail 22233 invoked by uid 109); 22 Feb 2021 23:40:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Feb 2021 23:40:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19239 invoked by uid 111); 22 Feb 2021 23:40:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Feb 2021 18:40:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Feb 2021 18:40:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>, git@vger.kernel.org
Subject: Re: [PATCH] docs/format-patch: mention handling of merges
Message-ID: <YDRA6RJdnFne2EBw@coredump.intra.peff.net>
References: <20210222211621.0C5D.409509F4@e16-tech.com>
 <YDQ27qbbblPfLCpU@coredump.intra.peff.net>
 <YDQ5YIeXGiR5nvLH@coredump.intra.peff.net>
 <xmqqv9aj65na.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9aj65na.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 03:31:53PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Subject: [PATCH] docs/format-patch: mention handling of merges
> >
> > Format-patch doesn't have a way to format merges in a way that can be
> > applied by git-am (or any other tool), and so it just omits them.
> > However, this may be a surprising implication for users who are not well
> > versed in how the tool works. Let's add a note to the documentation
> > making this more clear.
> > ...
> > +CAVEATS
> > +-------
> > +
> > +Note that `format-patch` cannot represent commits with more than one
> > +parent (i.e., merges) and will silently omit them entirely from its
> > +output, even if they are part of the requested range.
> 
> 
> I think "cannot represent" is a little bit misleading, unless we
> expect the readers already know what we are trying to say (in which
> case there is no point in documenting this).  Perhaps something like
> this might clarify a bit, though.
> 
>     Note that `format-patch` omits merge commits from the output,
>     because it is impossible to turn a merge commit into a simple
>     "patch" in such a way that allows receiving end to reproduce the
>     same merge commit.

That seems worse to me, because "it is impossible" implies that this
can never be changed. But I don't think that's true. We might one day
output something useful for merges.

I think one could argue that any merge information (including conflict
resolution) works against the root notion of format-patch, which is a
set of changes that can be applied on a range of basesa. But even that I
would be hesitant to commit to (since --base exists now). And certainly
it's more subtlety than I'd want to get in to for this note. :)

I almost softened it to "cannot yet represent". Does that read better to
your (or worse)? Likewise, I considered adding a note at the end along
the lines of "this may change in the future", though I suspect we'd only
do so in combination with a command-line option.

-Peff
