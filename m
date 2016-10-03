Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682AD20986
	for <e@80x24.org>; Mon,  3 Oct 2016 11:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbcJCL07 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 07:26:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:51213 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751493AbcJCL05 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 07:26:57 -0400
Received: (qmail 13193 invoked by uid 109); 3 Oct 2016 11:26:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 11:26:56 +0000
Received: (qmail 26579 invoked by uid 111); 3 Oct 2016 11:27:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 07:27:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 07:26:54 -0400
Date:   Mon, 3 Oct 2016 07:26:54 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [Q] would it be bad to make /etc/gitconfig runtime configurable?
Message-ID: <20161003112654.3vca4zmctslcudfz@sigill.intra.peff.net>
References: <xmqqoa39p926.fsf@gitster.mtv.corp.google.com>
 <20160927192539.ybooc34iodnzs2ab@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610031303000.35196@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610031303000.35196@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 01:06:10PM +0200, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 27 Sep 2016, Jeff King wrote:
> 
> > On Tue, Sep 27, 2016 at 10:05:37AM -0700, Junio C Hamano wrote:
> > 
> > > The subject says it all.  Would it be bad if we introduce an
> > > environment variable, GIT_SYSTEM_CONFIG=/etc/gitconfig, that names
> > > an alternative location of the system-wide configuration file?
> > > 
> > > That would supersede/deprecate GIT_CONFIG_NOSYSTEM that we
> > > introduced primarily so that we can run our tests without getting
> > > affected by the configuration that happens to be effective on the
> > > host that the test is being run.
> > 
> > I can't think of a reason it would be bad.
> 
> I cannot think of any reason right now, either, but my gut tells me that
> this needs to simmer a while in the backs of our minds, to give potential
> reasons a chance to come forward.
> 
> What would be the use case, BTW? IOW what would it solve that cannot
> already be solved by using XDG_CONFIG_HOME?

The patches Junio posted later use it for the test suite (and I also
have had to skip some tests in the past related to system config because
of its lack).

I would also use it when doing git experiments on GitHub servers. We
keep several relevant config settings in /etc/gitconfig, so if I were to
say, build a new version of git and test how it repacked torvalds/linux,
I need to make sure it picks up the same config. Usually I do it by
baking in the right /etc/gitconfig at build time, but it would be less
annoying to be able to override it at run-time.

I admit both of those are uses for git _developers_, though, not git
_users_.

-Peff
