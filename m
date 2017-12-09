Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 973BD1F406
	for <e@80x24.org>; Sat,  9 Dec 2017 12:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbdLIMxp (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 07:53:45 -0500
Received: from ikke.info ([178.21.113.177]:52998 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbdLIMxo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 07:53:44 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 51DB34400D4; Sat,  9 Dec 2017 13:53:43 +0100 (CET)
Date:   Sat, 9 Dec 2017 13:53:43 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 3/4] Makefile: use the sha1collisiondetection submodule
 by default
Message-ID: <20171209125343.GE6006@alpha.vpn.ikke.info>
References: <20171128213214.12477-1-avarab@gmail.com>
 <20171128213214.12477-4-avarab@gmail.com>
 <20171205070249.GC4788@sigill.intra.peff.net>
 <20171209123014.GD6006@alpha.vpn.ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171209123014.GD6006@alpha.vpn.ikke.info>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 09, 2017 at 01:30:14PM +0100, Kevin Daudt wrote:
> On Tue, Dec 05, 2017 at 02:02:50AM -0500, Jeff King wrote:
> > On Tue, Nov 28, 2017 at 09:32:13PM +0000, Ævar Arnfjörð Bjarmason wrote:
> > 
> > > Change the build process so that instead of needing to supply
> > > DC_SHA1_SUBMODULE=YesPlease to use the sha1collisiondetection
> > > submodule instead of the copy of the same code shipped in the sha1dc
> > > directory, it uses the submodule by default unless
> > > NO_DC_SHA1_SUBMODULE=UnfortunatelyYes is supplied.
> > > 
> > > This reverses the logic added by me in 86cfd61e6b ("sha1dc: optionally
> > > use sha1collisiondetection as a submodule", 2017-07-01). Git has now
> > > shipped with the submodule in git.git for two major releases, if we're
> > > ever going to migrate to fully using it instead of perpetually
> > > maintaining both sha1collisiondetection and the sha1dc directory this
> > > is a logical first step.
> > > 
> > > This change removes the "auto" logic Junio added in
> > > cac87dc01d ("sha1collisiondetection: automatically enable when
> > > submodule is populated", 2017-07-01), I feel that automatically
> > > falling back to using sha1dc would defeat the point, which is to smoke
> > > out any remaining users of git.git who have issues cloning the
> > > submodule for whatever reason.
> > 
> > I'm not sure how I feel about this. I see your point that there's no
> > real value in maintaining two systems indefinitely.  At the same time, I
> > wonder how much value the submodule strategy is actually bringing us.
> > 
> > IOW, are we agreed that the path forward is to get everybody using the
> > submodule?
> > 
> > It seems like it's going to cause some minor pain for CI and packaging
> > systems that now need to care about submodules (so at least flipping the
> > switch, but maybe also dealing with having a network dependency for the
> > build that was not already there).
> > 
> > I'll admit I'm more sensitive to this than most people, since I happen
> > to maintain a fork of Git that I run through an internal CI system. And
> > that CI otherwise depends only on the locally-held fork, not any
> > external resources. But I'm probably in a fairly unique situation there.
> > 
> > -Peff
> 
> To add to this point, package systems such as Alpinelinux and Archlinux
> (and probably others) work with released tarballs, not cloned
> repositories. For them, there is no easy way to get the submodule
> contents (the release tarballs would not contain it).
> 
> Once we would switch over to submodules only (because we do not want to
> maintain 2 separate systems), it would be a lot of hassle for those
> projects to get the sha1collisiondetection contents.
> 
> That's in my opinion a bigger disadvantage of submodules, commands like
> git archive do not support it, making it harder to get self-contained
> tarballs.
> 
> Perpahs there is a good solution to that problem, but then I'd like to
> hear it.
> 
> Kevin.

I missed the v2 Ævar sent. I see that there `make dist` is adjusted to
include sha1collisiondetection, so that would at least solve this
problem.
