Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E282120958
	for <e@80x24.org>; Thu, 23 Mar 2017 18:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753678AbdCWSBi (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 14:01:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:50385 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753305AbdCWSBh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 14:01:37 -0400
Received: (qmail 7222 invoked by uid 109); 23 Mar 2017 18:01:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 18:01:36 +0000
Received: (qmail 8689 invoked by uid 111); 23 Mar 2017 18:01:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 14:01:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Mar 2017 14:01:34 -0400
Date:   Thu, 23 Mar 2017 14:01:34 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
Message-ID: <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net>
References: <20170322065612.18797-1-larsxschneider@gmail.com>
 <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703231716320.3767@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1703231716320.3767@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 05:22:51PM +0100, Johannes Schindelin wrote:

> > The benefit is that Windows CI does not have to subscribe to the
> > GitHub repository to get notified (instead uses Travis as a relay
> > for update notification) and the result can be seen at the same
> > place as results on other platforms Travis natively support are
> > shown?  
> 
> Almost... Windows CI *cannot* subscribe to the GitHub repository, as only
> owners can install web hooks and give permission to update build status.
> 
> But yeah, you understand correctly: this innocuous change (along with a
> ton of work I already finished on my side) allows us to let Travis trigger
> Windows build & test and to attach the log in the same place as the
> Linux/OSX results are already accessible.

I don't mind adding a webhook if it helps. If I understand correctly
that would just handle the notification site. But then if the Windows
build status were public, we could have Travis simply fetch it to keep
the build reports all together, without having to worry about a secret
token.

I don't mind proceeding with the secret token, though. You're the owner
of the service the token accesses, so if you're comfortable with it, I
am.

> > > Things, that would need to be done:
> > > * Someone with write access to https://travis-ci.org/git/git would need
> > >   to add the secret token as "GFW_CI_TOKEN" variable in the TravisCI
> > >   repository setting [1]. Afterwards the build should just work.
> > 
> > We need to make sure this does not leak to the execution log of
> > Travis.
> [...]
> 
> Right, typically there is a way in CI setups that marks certain strings as
> secret and whenever they appear in the log, they will be blotted out.

I think both Junio and I have access to the Travis config. Travis does
have a "this is secret" flag for setup config. But I think we'd need to
verify that running the Travis build does not leak the variable in any
other way.

For instance, if it's in the environment, can I push up a branch that
does "set | grep GFW_CI_TOKEN", open a PR, and see it? I don't know the
answer.

-Peff
