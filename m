Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0040208CD
	for <e@80x24.org>; Sat,  2 Sep 2017 08:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbdIBItr (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Sep 2017 04:49:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:55696 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751603AbdIBItq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2017 04:49:46 -0400
Received: (qmail 29110 invoked by uid 109); 2 Sep 2017 08:49:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 02 Sep 2017 08:49:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9341 invoked by uid 111); 2 Sep 2017 08:50:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 02 Sep 2017 04:50:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Sep 2017 04:49:44 -0400
Date:   Sat, 2 Sep 2017 04:49:44 -0400
From:   Jeff King <peff@peff.net>
To:     Aleksandar Pavic <pavic.aleksandar@nsinfo.co.rs>
Cc:     git@vger.kernel.org
Subject: Re: Bug report
Message-ID: <20170902084944.2mw64l5wod6vj3fh@sigill.intra.peff.net>
References: <db0580dc-3ce0-47ba-b82a-b1e50b9d0a3a@nsinfo.co.rs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db0580dc-3ce0-47ba-b82a-b1e50b9d0a3a@nsinfo.co.rs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 11:25:00PM +0200, Aleksandar Pavic wrote:

>  I have a file
> 
>  app/Controller/CustomerCardVerificationController.php
> 
> And when I take a look at changes log, I get this (no matter which tool I
> use):
> 
> 2017-07-31 19:41 dule             o membership renew payment email
> 2017-06-07 08:59 Dusan Tatic      o cc refund clean
> 2017-04-15 00:16 Miodrag Dragić   o refound admin payment
> 2017-03-20 12:02 Dusan Tatic      o CardVerification card connect
> 2017-03-16 15:59 Aleksandar Pavic o paypal
> 2017-03-10 13:34 Aleksandar Pavic o Production branch
> 2017-03-10 13:01 Aleksandar Pavic I Migrating dev
>
> However if I manually browse thru revisions and open revision from
> 03/27/2017 07:05 PM
> 
> I can see the change in that file which is unlisted above, at revision
> ff9f4946e109bd234d438e4db1d319b1f6cb6580

How are you invoking the log? Are you doing:

  git log app/Controller/CustomerCardVerificationController.php

or similar? If that is the case, then history simplification may be
causing the results you see. And even you don't _see_ any merges in the
output, that is because they were simplified away. And the commit you
are looking for may have been on a side branch that was simplified away.

If you do:

  git log --full-history app/...

does the commit you are interested in show up? If so, then it was
removed due to history simplification. And if you are surprised that a
side branch was simplified away, that is most likely because there is a
mis-merge in your history (some merge which threw away the changes on a
side branch).

Try:

  git log --graph --oneline --name-status --full-history app/...

to see the whole shape of history, including which commits touched the
file.

You can read more about it in the "History Simplification" section of
"git help log".

-Peff
