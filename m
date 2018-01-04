Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56D771F404
	for <e@80x24.org>; Thu,  4 Jan 2018 19:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeADT0H (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:26:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:53378 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750959AbeADT0G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:26:06 -0500
Received: (qmail 12329 invoked by uid 109); 4 Jan 2018 19:26:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Jan 2018 19:26:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7324 invoked by uid 111); 4 Jan 2018 19:26:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 04 Jan 2018 14:26:37 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Jan 2018 14:26:04 -0500
Date:   Thu, 4 Jan 2018 14:26:04 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/5] core.aheadbehind: add new config setting
Message-ID: <20180104192604.GA27528@sigill.intra.peff.net>
References: <20171221190909.62995-1-git@jeffhostetler.com>
 <20171221190909.62995-2-git@jeffhostetler.com>
 <20171221204356.GA58971@aiede.mtv.corp.google.com>
 <xmqq3742tyho.fsf@gitster.mtv.corp.google.com>
 <20171224143318.GC23648@sigill.intra.peff.net>
 <xmqq1sjgoyph.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1sjgoyph.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 27, 2017 at 09:41:30AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I, too, had a funny feeling about calling this "core". But I didn't have
> > a better name, as I'm not sure what other place we have for config
> > options that cross many command boundaries. "diff" and "status" don't
> > seem quite right to me. While you can argue they are subsystems, it
> > seems too easy for users to confuse them with the commands of the same
> > names.
> >
> > Maybe there should be a "ui.*" config hierarchy for these kinds of
> > cross-command interface options?
> 
> I had an impression that ui.* was primarily pretty-printing,
> colouring and things of such nature.

I didn't think we had a "ui.*" so far. We have "color.ui" and
"column.ui", but I think that's it.

At any rate, my intent was to consider this a "ui" issue, in that we are
deciding how the ahead/behind hints should be shown to the user.

> I do not think it is such a
> bad idea to honor a status.frotz variable that affects how (e.g. to
> what degree of detailedness) status on frotz are reported in Git
> subcommands other than 'git status' if they report the same sort of
> information on 'frotz' that 'git status' makes.

Is ahead/behind uniquely attached to git-status? IOW, could this be called
"branch.aheadbehind" and git-status respects it? It seems like putting
it in status introduces a weird asymmetry.

I buy the argument more that "status" here is not "this is a git-status
config option", but "this config section encompasses various things
about the status of a repository reported by many commands". But then
it's kind of funny to have many of the existing options there that
really are specific to git-status.

In can be both of those things, of course, but then it becomes less
clear to the user which config options affect which command.

I dunno. It is probably not _that_ big a deal, and I can live with it
wherever. But Git has a reputation for having inconsistencies and weird
asymmetries in its UI, so I like to give some thought to squashing them
preemptively.

-Peff
