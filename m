Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4297AC77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 07:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDLHaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjDLHaE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 03:30:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4962A103
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 00:30:03 -0700 (PDT)
Received: (qmail 18394 invoked by uid 109); 12 Apr 2023 07:30:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Apr 2023 07:30:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17501 invoked by uid 111); 12 Apr 2023 07:30:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Apr 2023 03:30:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Apr 2023 03:30:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] date: remove approxidate_relative()
Message-ID: <20230412073001.GA1695531@coredump.intra.peff.net>
References: <f5b9a290-7cec-7a83-660b-e15494d2cdc8@web.de>
 <xmqqjzyjemji.fsf@gitster.g>
 <20230410202536.GE104097@coredump.intra.peff.net>
 <xmqqy1mzcus6.fsf@gitster.g>
 <20230411093005.GB398350@coredump.intra.peff.net>
 <xmqqsfd6bf0s.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsfd6bf0s.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2023 at 08:43:47AM -0700, Junio C Hamano wrote:

> > Ooh, I like that very much. In that sense it really feels like an
> > extension of --function-context. Would the regexes be searches starting
> > from the edge of some context (as they more or less are under the hood
> > for function context), or would you search within the whole file for
> > ranges (and then presumably use them when a hunk's context is adjacent
> > to or overlaps a range)?
> >
> > If the latter, I guess you could also allow both absolute and relative
> > line numbers, similar to how "-L" accepts range input.
> 
> We want the latter.
> 
> If we further imagine that approxidate_careful() were defined very
> far away (in either direction) from approxidate_relative() that
> "extending" the patch context to show the removal of the latter to
> cover the former would show too much irrelevant information, I think
> René would have wanted to show a normal patch plus an extra hunk
> that contains the entirety of approxidate_careful() that shows no
> modification (i.e. all lines are prefixed with an SP).  The way I
> think about this new "feature" is "compute what hunks should be
> shown, honoring all other options.  Then pretend no-op hunks to
> cover all specified lines in the postimage [*] are also in the
> result.  Combine them all, ignoring parts of the made-up no-op hunks
> when they contradict the real hunks.".  The end result should show
> all specified lines from the postimage plus the usual diff.

Right, that makes perfect sense. Thanks for explaining.

Now we just need somebody to implement it. ;)

-Peff
