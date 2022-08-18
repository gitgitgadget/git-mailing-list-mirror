Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC9CC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 05:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240884AbiHRFlp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 01:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiHRFll (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 01:41:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10E083BF8
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 22:41:40 -0700 (PDT)
Received: (qmail 11912 invoked by uid 109); 18 Aug 2022 05:41:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Aug 2022 05:41:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23252 invoked by uid 111); 18 Aug 2022 05:41:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Aug 2022 01:41:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Aug 2022 01:41:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/6] compat: add function to enable nonblocking pipes
Message-ID: <Yv3REyubPXQJVboY@coredump.intra.peff.net>
References: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
 <YvyFBzdO8PN7Ou0W@coredump.intra.peff.net>
 <xmqqwnb6ty9u.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwnb6ty9u.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2022 at 01:23:25PM -0700, Junio C Hamano wrote:

> The only small "huh?" factor was that the name of the helper is not
> enable_nonblock(), but singles out pipe as valid thing to work on.
> I think it is perfectly fine, given that the current plan we have is
> to use this on the pipe with the command we spawn with
> pipe_command(), and it probably is even preferrable to explicitly
> declare that this is designed to only work with pipes and future
> developers who try to abuse it on other kinds of file descriptors
> are on their own.  And "pipe" in the name of this helper may be such
> a declaration that is strong enough.

My goal was to explain that "huh" with this bit in the commit message:

> > The interface is as narrow as possible to let platforms do what's
> > natural there (rather than having to implement fcntl() and a fake
> > O_NONBLOCK for example, or having to handle other types of descriptors).

without going into too many details. I do think it would be easier to
explain if the Windows implementation was added in the same commit
(since it is explicitly just about pipes), but I wanted to credit René
as the author there. I'm not sure if it's worth folding them together
and adding a co-author credit instead. Or maybe I should state outright
in this commit message that we're doing it for Windows. ;)

-Peff
