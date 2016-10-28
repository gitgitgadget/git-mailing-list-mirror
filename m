Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7861F2022A
	for <e@80x24.org>; Fri, 28 Oct 2016 08:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757842AbcJ1IKj (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 04:10:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:35300 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752497AbcJ1IKh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 04:10:37 -0400
Received: (qmail 16326 invoked by uid 109); 28 Oct 2016 08:10:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Oct 2016 08:10:35 +0000
Received: (qmail 27282 invoked by uid 111); 28 Oct 2016 08:11:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Oct 2016 04:11:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Oct 2016 04:10:33 -0400
Date:   Fri, 28 Oct 2016 04:10:33 -0400
From:   Jeff King <peff@peff.net>
To:     Aaron Pelly <aaron@pelly.co>
Cc:     git@vger.kernel.org
Subject: Re: Expanding Includes in .gitignore
Message-ID: <20161028081033.vaolxkofs6b4wfhf@sigill.intra.peff.net>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
 <b20b458c-440d-df09-d2c7-e510ac20492c@pelly.co>
 <20161027205508.vqw44zlbnqpj2cvd@sigill.intra.peff.net>
 <60a652f6-864e-bbda-7394-4751c92866b7@pelly.co>
 <91e0f377-ecfd-ab0a-4f4b-8c0f762228aa@pelly.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91e0f377-ecfd-ab0a-4f4b-8c0f762228aa@pelly.co>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 11:17:26AM +1300, Aaron Pelly wrote:

> On 28/10/16 10:55, Aaron Pelly wrote:
> > 2) I fetch a repo with a hostile ignore file. It includes files from
> > $GIT_DIR/test-data/ssl/private or some such. Change. Don't pay
> > attention. Commit. Push. Problems if my test data comes from production.
> > 
> > Is this mitigated currently?
> > 
> > Not that git should be an enabler, but surely it falls on the user of
> > untrusted software to ensure their own security?
> 
> Balls, I meant $GIT_WORK_TREE not $GIT_DIR

I was going to ask what you meant by "currently" here, as we do not yet
have an include mechanism, and generally things in the repository are
fair game. But I guess you mean that there could be untracked files even
inside the repository.

I'm not too worried about that in general. You have to be careful of a
lot of things inside the repository, like running "make" on malicious
code. Adding "don't stick secret files inside the repository, even
untracked", does seem like another sensible precaution.

The main thing with malicious repositories is that basic inspection like
"git clone $remote && git log" should not execute arbitrary code, leak
information, etc.

-Peff
