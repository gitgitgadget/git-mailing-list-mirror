Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69EFD1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 09:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389782AbfHHJqJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 05:46:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:37560 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2389774AbfHHJqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 05:46:09 -0400
Received: (qmail 11198 invoked by uid 109); 8 Aug 2019 09:46:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Aug 2019 09:46:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18757 invoked by uid 111); 8 Aug 2019 09:48:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Aug 2019 05:48:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Aug 2019 05:46:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Lukas Gross <lukasgross@u.northwestern.edu>,
        git@vger.kernel.org
Subject: Re: amend warnings with no changes staged
Message-ID: <20190808094607.GB12257@sigill.intra.peff.net>
References: <CAOY1tUUmkRBEDkF3GiP45WSi50uUGBaamx9-PGej0Z-yt0ioPg@mail.gmail.com>
 <20190806013030.GA61803@google.com>
 <CAOY1tUVpeUftgHNuZg-2fMD9D+Qz08hfvRvQDe1f8+MV2xYv2w@mail.gmail.com>
 <20190806021618.GC61803@google.com>
 <20190806041911.GA9243@sigill.intra.peff.net>
 <xmqqblx2jeh2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblx2jeh2.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 06, 2019 at 12:11:53PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   git commit -m 'buggy commit'
> >   echo fix >>file.c
> >   git commit --amend ;# oops, should have been "-a"
> >   git push
> >
> > But perhaps that gets to the heart of the matter. Could we perhaps be
> > providing a more detailed summary of what happened for an --amend? I.e.,
> > to summarize _both_ sets of changes (and if one set is empty, say so)?
> > ...
> > judgement about whether it's an error, since it may well be that you
> > were simply rewording the commit message).
> 
> Perhaps "git range-diff HEAD@{1}...HEAD" being an empty is a sign
> that either the user intentionally or accidentally did not do
> anything other than "touch"ing the commit.
> 
> "git commit --amend --[no-]range-diff" that shows what you changed
> with the amending may be an interesting possibility; I am not yet
> ready to seriously encourage anybody to explore it, though, because
> "git diff HEAD@{1}" is much easier to see what code got changed, but
> one (and probably only) downside is that it does not cover the
> change in the log message.

I hadn't even thought of range-diff.

Showing the commit message diff would be a big improvement. A range-diff
would also show an update to the author (e.g., if you used --reset-author).

We don't really need the full power of range diff, though. After all, we
know there are exactly two patches to compare, so we don't care about it
trying to figure out which ones correlate (and it might even be a bad
thing for it to decide that two entries don't match). So I think we'd
probably want our own custom thing.

-Peff
