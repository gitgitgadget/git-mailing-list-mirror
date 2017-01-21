Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 563FB1F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 14:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750943AbdAUOZA (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 09:25:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:42613 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750886AbdAUOY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 09:24:58 -0500
Received: (qmail 2746 invoked by uid 109); 21 Jan 2017 14:24:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Jan 2017 14:24:58 +0000
Received: (qmail 11159 invoked by uid 111); 21 Jan 2017 14:25:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Jan 2017 09:25:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Jan 2017 09:24:56 -0500
Date:   Sat, 21 Jan 2017 09:24:56 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] Localise error headers
Message-ID: <20170121142455.qoyqagaw4atic5n6@sigill.intra.peff.net>
References: <cover.1483354746.git.git@drmicha.warpmail.net>
 <20170104070514.pxdthvilw66ierfz@sigill.intra.peff.net>
 <8d0966d0-1ef1-3d1e-95f5-6e6c1ad50536@drmicha.warpmail.net>
 <20170110090418.4egk4oflblshmjon@sigill.intra.peff.net>
 <CAGZ79kYVc0YQ4okrTHGiYQzPqfiVAm_f7orXdkhwgf5kMPXj-w@mail.gmail.com>
 <20170111113725.avl3wetwrfezdni2@sigill.intra.peff.net>
 <CAGZ79kYVFbaMy1_-6qqe9zYQyktE2-7xu1Zz_qyeLWK=scgFKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYVFbaMy1_-6qqe9zYQyktE2-7xu1Zz_qyeLWK=scgFKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2017 at 09:15:22AM -0800, Stefan Beller wrote:

> > That's the assumption I'm challenging. Certainly the behavior and
> > certain aspects of the output of a plumbing command should remain the
> > same over time. But error messages to stderr?
> 
> In an ideal world that assumption would hold true and any machine
> readable information from the plumbing commands are on stdout and
> nobody in their sane mind would ever try to parse stderr.
> 
> There is no easy way to check though except auditing all the code.
> Having pointed out some string handling mistakes in the prior email,
> my confidence is not high that plumbing commands are that strict about
> separating useful machine output and errors for human consumption.

I think it's impossible to audit all the code, because "all the code"
includes things not in git itself. It would really take a willingness to
declare "if you are parsing stderr you're doing it wrong".

I suppose the unpack-trees example speaks against that. I'm not sure
that is sane overall, but it is something we tried to account for in the
past.

If we are just talking about translation, though, it seems like the
right action for a script that really wants to parse stderr is to run
the sub-command with LC_MESSAGES=C. I know that's a breaking change, but
I wonder if it's a reasonable path forward.

-Peff
