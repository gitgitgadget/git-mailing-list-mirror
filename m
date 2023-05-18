Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2EAC77B7D
	for <git@archiver.kernel.org>; Thu, 18 May 2023 18:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjERSZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 14:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjERSZM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 14:25:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F80A0
        for <git@vger.kernel.org>; Thu, 18 May 2023 11:25:11 -0700 (PDT)
Received: (qmail 1183 invoked by uid 109); 18 May 2023 18:25:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 May 2023 18:25:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23305 invoked by uid 111); 18 May 2023 18:25:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 May 2023 14:25:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 May 2023 14:25:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Christian Hesse <list@eworm.de>,
        git@vger.kernel.org, Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
Message-ID: <20230518182504.GA557383@coredump.intra.peff.net>
References: <20230517070632.71884-1-list@eworm.de>
 <xmqqwn17q7ou.fsf@gitster.g>
 <ZGT6fEZFumAsZnxu@nand.local>
 <ZGT/eK6+IKlCM6Sg@nand.local>
 <xmqqcz2yrjbe.fsf@gitster.g>
 <xmqq8rdmrixc.fsf@gitster.g>
 <ZGUVvjG+xou3w8YW@nand.local>
 <xmqqy1lmq183.fsf@gitster.g>
 <ZGVFnzyStiscDKh3@nand.local>
 <xmqq7ct5vdbk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7ct5vdbk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2023 at 09:01:19AM -0700, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> >> My inclination is punt and simply do not to claim that we have done
> >> a good due diligence to ensure with all permutations of ifdef we are
> >> including necessary headers.
> >
> > I think that's the best course of action, too. I see that it's already
> > on 'next', thanks.
> 
> Yeah, I am actuall hoping that somebody clever, with time, comes up
> with a systematic way to give us better coverage, but until then, I
> think it is better to honestly record where we are to future
> developers.

I faced a similar issue with the -Wunused-parameter patches. Just when I
thought I had everything annotated, I'd find some obscure Makefile knob
that compiled new code (or even in one case disabled some code that used
a variable!).

I never came up with a good solution, but relying on CI helped, since it
just builds more of the combinations. Obviously that didn't catch this
case. We could try to hit more platforms / combinations of knobs in CI,
but there are diminishing returns on the compute time.

But at least in this case, the old "if it is important, somebody will
build it and report the problem" line of thinking worked out. So maybe
that is enough.

I guess maybe that was more philosophical than helpful. ;)

-Peff
