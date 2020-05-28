Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B12AC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 16:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 780FC2068D
	for <git@archiver.kernel.org>; Thu, 28 May 2020 16:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405147AbgE1Qpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 12:45:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:58892 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405140AbgE1Qpe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 12:45:34 -0400
Received: (qmail 30639 invoked by uid 109); 28 May 2020 16:45:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 May 2020 16:45:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15393 invoked by uid 111); 28 May 2020 16:45:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 May 2020 12:45:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 May 2020 12:45:33 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH 0/4] Selectively show only blamed limes
Message-ID: <20200528164533.GA1223132@coredump.intra.peff.net>
References: <20200525215751.1735-1-philipoakley@iee.email>
 <20200527072318.GA4006199@coredump.intra.peff.net>
 <0da84168-3d81-fb14-32ad-010ef2436958@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0da84168-3d81-fb14-32ad-010ef2436958@iee.email>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 11:24:54AM +0100, Philip Oakley wrote:

> > I'm not convinced this is a useful thing to do in general. Lines don't
> > always stand on their own, and you'd lack context for deciphering them.
> > So a real example from "git blame -b --since=1.year.ago Makefile", for
> > example (pardon the long lines):
> 
> My contention is that there is a lot of effort needed _beforehand_ to
> reach that point. We've already had to page down 2700 line to get there,
> and then had to carefully select the differing before and after context
> lines.

I think:

  git blame -b --since=1.year.ago ... | less "+/^[^ ]"

works pretty well to get you to the right spot, with context (and then
"/<enter>" within less takes you to the next line).

But that's also pretty magical.

> The use of the --blame-only (especially with broad date range --since)
> is to quickly narrow focus with the rather large file to the few areas
> of concern (probably related why the -b was introduced initially?)

Perhaps. I think when you get an out-of-context chunk, though, it's
tricky to take the next step.

I'm still skeptical this will turn out to be all that useful in
practice. But it really isn't much code to carry, so I don't have any
real objection.

-Peff
