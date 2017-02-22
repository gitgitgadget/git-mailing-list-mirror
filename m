Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB6B8201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 18:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933338AbdBVS5P (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 13:57:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:60105 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932156AbdBVS5P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 13:57:15 -0500
Received: (qmail 16536 invoked by uid 109); 22 Feb 2017 18:57:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 18:57:14 +0000
Received: (qmail 27227 invoked by uid 111); 22 Feb 2017 18:57:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 13:57:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2017 13:57:11 -0500
Date:   Wed, 22 Feb 2017 13:57:11 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jon Loeliger <jdl@jdl.com>, Stefan Beller <sbeller@google.com>,
        Toolforger <toolforger@durchholz.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: url.<base>.insteadOf vs. submodules
Message-ID: <20170222185711.2kpzeypptg6deytc@sigill.intra.peff.net>
References: <28fb85d4-89cd-1f32-3063-2f48d8b935be@durchholz.org>
 <20170221070653.65ho2anbp55uzjeu@sigill.intra.peff.net>
 <CAGZ79kZgMbEZy7hoA+VxsKdKBavt59SmC1c6FpDdgrW2GKMHvQ@mail.gmail.com>
 <20170221230029.cs36tjwpsw2opuwp@sigill.intra.peff.net>
 <CAGZ79kby-UhUqci9Mgdhw+wvS5Y39=Q7AmCrWaTMWbcZPNT6Dw@mail.gmail.com>
 <xmqqo9xvdsji.fsf@gitster.mtv.corp.google.com>
 <CAGZ79ka2S=V1x2fSQq+E-yE0Ao36-4tuTvnD6uXpPXJPLFN3JA@mail.gmail.com>
 <xmqqbmtvdj7p.fsf@gitster.mtv.corp.google.com>
 <E1cgXSe-0007jp-QI@mylo.jdl.com>
 <xmqqh93mcelv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh93mcelv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2017 at 09:36:12AM -0800, Junio C Hamano wrote:

> >> My gut feeling is that we should do the selective/filtered include
> >> Peff mentioned when a repository is known to be used as a submodule
> >> of somebody else.
> >
> > Does the management of these submodue-related config values
> > become easier if, instead of placing them in .config, we
> > place them in a git/.context file?
> 
> Do you mean that Git users that use submodules adopt a convention
> where a separate file in $GIT_DIR of the toplevel superproject holds
> pieces of configuration that are meant to be shared between the
> superproject and across all its submodules, and the $GIT_DIR/config
> file in submodules and the superproject all include that shared one
> via include.path mechanism?
> 
> That may allow us to do without being responsible for sifting of
> configuration variables into safe and unsafe bins.
> 
> I dunno.

Hmm. I certainly like that we punt on having to decide on the "should
this be shared with submodules" decision. That makes the end result more
flexible, and we don't have to get into a never-ending stream of
"whitelist this config option" patches.

My only concern is that it's not as discoverable. In the situation that
kicked off this thread, somebody put url.X.insteadOf into their
super-project .git/config, expecting it to work in the submodules. That
_still_ wouldn't work with this proposal. They'd have to:

  1. Put it in .git/context (or whatever we call it)

  2. Maybe add include.path=context in .git/config if they want the
     config shared with the super-project (or this could be automatic?)

I guess it gives _a_ solution, which is more than we have now, but it
doesn't feel very ergonomic.

-Peff
