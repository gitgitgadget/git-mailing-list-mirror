Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0416D1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 21:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeHVAxx (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 20:53:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:51048 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726628AbeHVAxx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 20:53:53 -0400
Received: (qmail 12446 invoked by uid 109); 21 Aug 2018 21:32:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 21:32:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27318 invoked by uid 111); 21 Aug 2018 21:32:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 17:32:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 17:32:00 -0400
Date:   Tue, 21 Aug 2018 17:32:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] pack-objects: reuse on-disk deltas for thin "have"
 objects
Message-ID: <20180821213200.GD24431@sigill.intra.peff.net>
References: <20180821184140.GA24165@sigill.intra.peff.net>
 <20180821190705.GF30764@sigill.intra.peff.net>
 <xmqqin438pze.fsf@gitster-ct.c.googlers.com>
 <xmqqbm9v8pou.fsf@gitster-ct.c.googlers.com>
 <20180821200747.GA21955@sigill.intra.peff.net>
 <xmqq36v78ml8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq36v78ml8.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 01:57:07PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Ah, yeah, I think you're right. We call find_patch_start(), which thinks
> > the "---" line is the end of the commit message. That makes sense when
> > parsing trailers out of "format-patch" output, but not when we know we
> > have just the commit message.
> 
> Yes, but that does not explain what we are seeing.  If the code
> mistakenly thinks that the log message ends before that table, then
> it should have inserted the S-o-b: _before_ that table, but that is
> not happening.
> 
> So there are three issues; (1) find-patch-start uses too weak a
> logic to find the beginning of a patch section (2) even if it found
> the right place, its caller does not tell "commit --amend -s" where
> the log message ends correctly and (3) some callchains that get
> there know they only have a log message but there is no way to take
> advantage of that information and skip the call to find-patch-start.

Yes, I'd agree with all of that.

I'm going offline, so if you are part-way through a patch, please do not
worry that we might duplicate effort. :)

-Peff
