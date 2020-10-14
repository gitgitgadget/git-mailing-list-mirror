Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC70C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5052222C
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgJNTe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 15:34:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:60170 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgJNTe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 15:34:57 -0400
Received: (qmail 18436 invoked by uid 109); 14 Oct 2020 19:34:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2020 19:34:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20176 invoked by uid 111); 14 Oct 2020 19:34:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2020 15:34:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Oct 2020 15:34:56 -0400
From:   Jeff King <peff@peff.net>
To:     Sean McAllister <smcallis@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Masaya Suzuki <masayasuzuki@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/3] http: automatically retry some requests
Message-ID: <20201014193456.GA365553@coredump.intra.peff.net>
References: <20201013191729.2524700-1-smcallis@google.com>
 <20201013191729.2524700-3-smcallis@google.com>
 <20201013211453.GB3678071@coredump.intra.peff.net>
 <CAM4o00eCKP1+f=xBw4LJfNqrstEnutAe9StxknW9qLMtPBdhKQ@mail.gmail.com>
 <CAM4o00fO++JMNdES03JKRyxmZtiLjkrJ2nux0-TZYBdH2+0ijA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM4o00fO++JMNdES03JKRyxmZtiLjkrJ2nux0-TZYBdH2+0ijA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 01:10:46PM -0600, Sean McAllister wrote:

> On Wed, Oct 14, 2020 at 1:09 PM Sean McAllister <smcallis@google.com> wrote:
> >
> > On Tue, Oct 13, 2020 at 3:14 PM Jeff King <peff@peff.net> wrote:
> > >
> > > I do think you could be leveraging CURLINFO_RETRY_AFTER rather than
> > > implementing your own header parsing, though.
> > >
> > Ah I didn't know about CURLINFO_RETRY_AFTER, I'll look at that and use
> > it if I can.
> >
> I took a look, it looks like CURLINFO_RETRY_AFTER was only added in
> 7.66 (September, 2019),  so
> I don't think it's reasonable to rely on it for getting the
> Retry-After value in this case.

I agree that's pretty recent.

How important is it that we respect it? I.e., we'd have some sane retry
behavior if the header is missing anyway. On older curl versions, how
bad would it be to just use that fallback behavior all the time?

-Peff
