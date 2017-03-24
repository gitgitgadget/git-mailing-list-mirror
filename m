Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1C3A1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 15:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbdCXPJZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 11:09:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:50996 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751701AbdCXPJY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 11:09:24 -0400
Received: (qmail 6625 invoked by uid 109); 24 Mar 2017 15:09:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 15:09:23 +0000
Received: (qmail 18476 invoked by uid 111); 24 Mar 2017 15:09:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 11:09:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 11:09:21 -0400
Date:   Fri, 24 Mar 2017 11:09:21 -0400
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <git@grubix.eu>
Cc:     Joan Aguilar <joan.aguilar.lorente@gmail.com>, git@vger.kernel.org
Subject: Re: report on a possible bug: git commit -p myfile.py unexpected
 output
Message-ID: <20170324150921.vwh4yqpz25ph3zxe@sigill.intra.peff.net>
References: <CAG+Y4s8m2MqA0yAiZFzv2bAx7g5xktNRb=S-Ej0tvMwU-Un0Og@mail.gmail.com>
 <26915be5-8749-7f66-4d60-516e7ed60adc@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26915be5-8749-7f66-4d60-516e7ed60adc@grubix.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 03:59:07PM +0100, Michael J Gruber wrote:

> > [master 96d1c24] myfile.py -> old unused methods removed...
> >  1 file changed, 182 insertions(+), 302 deletions(-)
> >  rewrite myfile.py (60%)
> [...]
> > myfile.py | 120
> > ---------------------------------------------------------------------------------------------------------------------
> > 1 file changed, 120 deletions(-)
> 
> 182-302 = -120
> 
> Did you make any changes in the lines that you left? Apparantly, that's
> what the rewrite looked like to git commit.

Even without changes to the remaining lines, a rewrite diff would
consider them removed from the preimage and added again in the
post-image.

The difference between the two commands is that "commit" turns on "-B"
break detection by default, and "git show", "tig", etc, do not.

Looking at the actual diff with "git show -B" should show something
like:

  -old
  -lines
  -that
  -weren't
  -touched
  -some
  -lines
  -that
  -were
  -deleted
  +old
  +lines
  +that
  +weren't
  +touched

The change is the same no matter how you view it; the "-B" flag just
asks Git to show a non-minimal diff when the file was substantially
changed.

-Peff
