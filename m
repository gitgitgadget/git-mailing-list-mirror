Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14E13207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 21:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756048AbcIPVvq (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 17:51:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:44435 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755857AbcIPVvo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 17:51:44 -0400
Received: (qmail 17636 invoked by uid 109); 16 Sep 2016 21:51:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Sep 2016 21:51:44 +0000
Received: (qmail 20813 invoked by uid 111); 16 Sep 2016 21:51:55 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Sep 2016 17:51:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Sep 2016 14:51:41 -0700
Date:   Fri, 16 Sep 2016 14:51:41 -0700
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC/PATCH 3/3] mailinfo: handle in-body header continuations
Message-ID: <20160916215140.eocblts556lzdk7k@sigill.intra.peff.net>
References: <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net>
 <cover.1474047135.git.jonathantanmy@google.com>
 <0152df30db0972d61ff45b2b099ad1242aacd431.1474047135.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0152df30db0972d61ff45b2b099ad1242aacd431.1474047135.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 10:37:24AM -0700, Jonathan Tan wrote:

> Mailinfo currently handles multi-line headers, but it does not handle
> multi-line in-body headers. Teach it to handle such headers, for
> example, for this input:
> 
>   Subject: a very long
>    broken line
> 
>   Subject: another very long
>    broken line
> 
> interpret the in-body subject to be "another very long broken line"
> instead of "another very long".

This puzzled me; we should stop parsing in-body headers after the first
blank line. But then I realized you probably meant the first "Subject"
to be the real mail header.

I wonder if it would be more obvious with an example like:

  From: ...
  Date: ...
  Subject: the actual mail subject

  Subject: a very long
    broken line

Or something.

-Peff
