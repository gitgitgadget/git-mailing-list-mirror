Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3441C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 05:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FCA20722
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 05:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgCTFU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:20:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:44702 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725446AbgCTFU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 01:20:56 -0400
Received: (qmail 30905 invoked by uid 109); 20 Mar 2020 05:20:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Mar 2020 05:20:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2872 invoked by uid 111); 20 Mar 2020 05:30:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Mar 2020 01:30:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Mar 2020 01:20:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] t4124: fix test for non-compliance diff
Message-ID: <20200320052055.GA499858@coredump.intra.peff.net>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <285c6830c5182cb602d4fe559525083f69a158e9.1584625896.git.congdanhqx@gmail.com>
 <20200319163334.GG3513282@coredump.intra.peff.net>
 <xmqqlfnwc5p0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfnwc5p0.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 19, 2020 at 03:58:51PM -0700, Junio C Hamano wrote:

> >> Workaround this problem by assuming `diff(1)` output is unified
> >> if we couldn't make anything from normal-diff format.
> 
> I do not mind working it around, but I am a bit disturbed by an
> uneven attitude towards POSIX noncompliance this series has.  If
> we were willing to break other people's "sed" that does not do BRE
> correctly, instead of using '[+]' trick to accomodate them while
> making sure that an implementation that does not use nonstandard
> extension and does only BRE, we should just similarly be writing
> such an implementation of noncompliant diff off as broken, yet we
> bend backwards over to make sure we can work with them here.
> 
> IOW, I do not have trouble changing the test so that it works with
> noncompliant "diff".  But then in the same series, I would prefer to
> see the existing test keeps working with a possibly noncompliant
> "sed" implementation that has been working well with the tests.

I don't think it's inconsistent. Real-world experience trumps standards.
We _know_ that there is a real-world diff that generates only unified
diffs, and it is not too hard to work around it. So we should do so.

A sed that uses ERE and requires backslash-escaping pluses is
theoretical at this point. POSIX forbids it, and I would guess that
working around it would be more than just the "[+]" we found, because
other patterns probably need it, too. But we won't know until we find
one to test on.

So I'm not entirely against "[+]" as a defensive measure. But I have a
slight preference to avoid it until we know it's needed, not because
it's hard to do once, but because I don't want to grow too many
defensive superstitions if we don't know they're warranted.

-Peff
