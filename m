Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B33C433E4
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB3F2053B
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbgG1Qxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:53:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:39982 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731406AbgG1Qxi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 12:53:38 -0400
Received: (qmail 27894 invoked by uid 109); 28 Jul 2020 16:53:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 16:53:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26795 invoked by uid 111); 28 Jul 2020 16:53:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 12:53:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 12:53:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] making --first-parent imply -m
Message-ID: <20200728165337.GB2650574@coredump.intra.peff.net>
References: <20200728163617.GA2649887@coredump.intra.peff.net>
 <xmqqeeovegbv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeeovegbv.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 09:48:20AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > For some projects, it's useful to walk the first parent history, looking
> > at each merge commit as a normal commit introducing all of the changes
> > no its side branch. E.g.:
> >
> >   git log --first-parent -m -Sfoo -p
> >
> > might show you the topic or pull request that introduced code "foo". But
> > I quite often forget to add "-m", and get confused that it doesn't
> > return any results.
> 
> Yes.  I agree that --first-parent should imply -m when combined with
> diff options like -p, --raw, etc.  I am not sure if -m should kick
> in without any diff options, though.  Doesn't it have side effects?

I couldn't find any. It impacts log_tree_diff() if we see a commit with
two parents, but --first-parent will already override that.

I poked around in the code and couldn't find any other cases that would
be impacted, nor do any tests fail. Definitely if you can find a case
where it matters outside of the diff, I'd be interested to see it. :)

-Peff
