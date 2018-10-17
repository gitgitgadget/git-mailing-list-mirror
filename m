Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30E011F453
	for <e@80x24.org>; Wed, 17 Oct 2018 18:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeJRCIt (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 22:08:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:43686 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727435AbeJRCIt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 22:08:49 -0400
Received: (qmail 6857 invoked by uid 109); 17 Oct 2018 18:11:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Oct 2018 18:11:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21655 invoked by uid 111); 17 Oct 2018 18:11:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Oct 2018 14:11:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2018 14:11:56 -0400
Date:   Wed, 17 Oct 2018 14:11:56 -0400
From:   Jeff King <peff@peff.net>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, git@vger.kernel.org,
        rpeterso@redhat.com, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] revision: Add --sticky-default option
Message-ID: <20181017181156.GA28326@sigill.intra.peff.net>
References: <20181016212438.30176-1-agruenba@redhat.com>
 <20181017091215.GA2052@sigill.intra.peff.net>
 <alpine.DEB.2.21.1810170620260.166761@matvore-linux.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810170620260.166761@matvore-linux.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 06:24:05AM -0700, Matthew DeVore wrote:

> > Yuck, t4202 is a mix of older and newer styles. I'm OK with this as-is
> > because you've matched the surrounding code, but these days I'd probably
> > write:
> > 
> >  test_expect_success '--sticky-default ^<rev>' '
> > 	{
> > 		echo sixth
> > 		echo fifth
> > 	} >expect &&
> > 	git log --format=%s --sticky-default ^HEAD~2 >actual &&
> > 	test_cmp expect actual
> >  '
> > 
> 
> How about test_write_lines? That is a little more readable to me than
> the echos in a subshell. A patch was recently queued with a usage of
> that function:

Ah, yeah, that would be fine. I was trying to avoid a cat/here-doc combo
since it incurs a process, but test_write_lines is readable and fast.

The main style things I wanted to show are:

  - setting up the expect file should go in the test_expect block

  - no space between ">" and the filename

Those are both present in the surrounding code, but we're slowly
cleaning them up.

-Peff
