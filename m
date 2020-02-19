Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB24C34031
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 01:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCD624654
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 01:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgBSB5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:57:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:47556 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727811AbgBSB5e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 20:57:34 -0500
Received: (qmail 21345 invoked by uid 109); 19 Feb 2020 01:57:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Feb 2020 01:57:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24171 invoked by uid 111); 19 Feb 2020 02:06:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 21:06:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 20:57:33 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        rhi@pengutronix.de
Subject: Re: [PATCH] describe: output tag's ref instead of embedded name
Message-ID: <20200219015733.GA81560@coredump.intra.peff.net>
References: <xmqqd0ahp0na.fsf@gitster-ct.c.googlers.com>
 <fcf19a46b80322c5579142efe4ec681a4dcbdd28.1581802264.git.matheus.bernardino@usp.br>
 <20200216065101.GA2937208@coredump.intra.peff.net>
 <xmqqd0abk7zc.fsf@gitster-ct.c.googlers.com>
 <20200218195402.GA21586@coredump.intra.peff.net>
 <xmqq4kvnijim.fsf@gitster-ct.c.googlers.com>
 <xmqqzhdfh3vr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhdfh3vr.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 03:28:24PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Coming back to the original topic, ...
> >
> >> If a tag describes a commit, we currently output not the tag's ref but
> >> its embedded name. This means that when the tag is locally stored under
> >> a different name, the output given cannot be used to access the tag in
> >> any way. A warning is also emitted in this case, but the message is not
> >> very enlightening:
> >
> > None of the above is wrong per-se, but the reason why we chose to
> > use the real name of the tag in the tag object, while issuing a
> > warning, was so that people can correct the mistake of storing an
> > annotated tag A to a wrong refname Q.  If "describe" gave a name
> > based on refname Q, there is no incentive to correct the situation
> > to use the right refname.  The name that describes the commits
> > relative to the real name of the A is *not* usable by design, until
> > the refname is corrected (i.e. the tag is stored in the right
> > place).
> >
> > So I am not 100% confident that the original patch is a good idea.
> 
> FWIW, this design came from 212945d4 ("Teach git-describe to verify
> annotated tag names before output", 2008-02-28).  Shawn was quite
> explicit that use of the real name was deliberate:
> 
>     If an annotated tag describes a commit we want to favor the name
>     listed in the body of the tag, rather than whatever name it has
>     been stored under locally.  By doing so it is easier to converse
>     about tags with others, even if the tags happen to be fetched to
>     a different name than it was given by its creator.
> 
> and I tend to agree with the original rationale.

Thanks, I should have dug into the history in the first place.

Still, I'm not entirely convinced. As a decentralized system, I think
our first duty is to make things convenient and workable for the
preferences of the local repository, and second to facilitate
communication with other people's clones of the same repository.

If for whatever reason I chose to call my version of the global v1.0 tag
as "v1.0-bob", then it seems friendlier to me to report the name that
can actually be used with further local commands (and remind the user of
the global name) than the other way around.

Though TBH the situation is rare enough that I kind of doubt it matters
all that much either way. It's been like this for over a decade, and
this is the first time I recall it being brought up.

-Peff
