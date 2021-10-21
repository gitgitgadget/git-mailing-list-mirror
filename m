Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE0AC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBDE610EA
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhJUO4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:56:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:43668 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhJUO4v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:56:51 -0400
Received: (qmail 15893 invoked by uid 109); 21 Oct 2021 14:54:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Oct 2021 14:54:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7209 invoked by uid 111); 21 Oct 2021 14:54:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Oct 2021 10:54:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Oct 2021 10:54:33 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] for-each-ref: delay parsing of --sort=<atom> options
Message-ID: <YXF/KTD7NgTAPw6G@coredump.intra.peff.net>
References: <xmqqv91uw5dl.fsf@gitster.g>
 <YW9EP5UNX0f+eOke@coredump.intra.peff.net>
 <xmqq4k9bssr7.fsf@gitster.g>
 <YXCAuAwZenM6EPug@coredump.intra.peff.net>
 <xmqqpmrzo00q.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpmrzo00q.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 20, 2021 at 02:32:21PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, I faced something similar with 7c5045fc18 (ref-filter: apply
> > fallback refname sort only after all user sorts, 2020-05-03). I suspect
> > you could use the same keys as those tests, though I am OK if we simply
> > leave it as a quietly-fixed bug.
> 
> Ah, I guess I can cheat and add a new test after these.
> 
> If --no-sort weren't taking effect, the expected outcome would be
> the asme as the previous step this copied from, but with --no-sort
> clearing the sort keys, we sort by taggerdate and then tiebreak with
> the refname, and taggeremail does not get into the picture (other
> than being repeated at the end of the refname).

Yeah, I think what you have here makes sense. It's too bad we can't run
it on the "before" state to double-check that we are triggering the old
breakage, but there is simply no "--no-sort" at all before your patch
(which is good, because it would have been broken ;) ).

-Peff
