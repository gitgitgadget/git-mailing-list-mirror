Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D12C34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 10:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A16207FD
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 10:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgBSKIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:08:44 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41421 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgBSKIo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 05:08:44 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rhi@pengutronix.de>)
        id 1j4MHW-0005oN-Am; Wed, 19 Feb 2020 11:08:38 +0100
Received: from rhi by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <rhi@pengutronix.de>)
        id 1j4MHS-0005rg-Js; Wed, 19 Feb 2020 11:08:34 +0100
Date:   Wed, 19 Feb 2020 11:08:34 +0100
From:   Roland Hieber <rhi@pengutronix.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        git@vger.kernel.org
Subject: Re: [PATCH] describe: output tag's ref instead of embedded name
Message-ID: <20200219100834.7456mp4qq5two4t7@pengutronix.de>
References: <xmqqd0ahp0na.fsf@gitster-ct.c.googlers.com>
 <fcf19a46b80322c5579142efe4ec681a4dcbdd28.1581802264.git.matheus.bernardino@usp.br>
 <20200216065101.GA2937208@coredump.intra.peff.net>
 <xmqqd0abk7zc.fsf@gitster-ct.c.googlers.com>
 <20200218195402.GA21586@coredump.intra.peff.net>
 <xmqq4kvnijim.fsf@gitster-ct.c.googlers.com>
 <xmqqzhdfh3vr.fsf@gitster-ct.c.googlers.com>
 <20200219015733.GA81560@coredump.intra.peff.net>
 <xmqqr1yrgt2d.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1yrgt2d.fsf@gitster-ct.c.googlers.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:06:16 up 226 days, 16:16, 93 users,  load average: 0.23, 0.28,
 0.25
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: rhi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 07:22:02PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> >> FWIW, this design came from 212945d4 ("Teach git-describe to verify
> >> annotated tag names before output", 2008-02-28).  Shawn was quite
> >> explicit that use of the real name was deliberate:
> >> 
> >>     If an annotated tag describes a commit we want to favor the name
> >>     listed in the body of the tag, rather than whatever name it has
> >>     been stored under locally.  By doing so it is easier to converse
> >>     about tags with others, even if the tags happen to be fetched to
> >>     a different name than it was given by its creator.
> >> 
> >> and I tend to agree with the original rationale.
> >
> > Thanks, I should have dug into the history in the first place.
> >
> > Still, I'm not entirely convinced. As a decentralized system, I think
> > our first duty is to make things convenient and workable for the
> > preferences of the local repository, and second to facilitate
> > communication with other people's clones of the same repository.
> 
> Yes, and that can be done by either (1) locally moving a tag that is
> stored in a wrong location to where it wants to be, or (2) locally
> *creating* a tag that suits the preferences of the local repository,
> ignoring the tag obtained from outside world that is stored in a
> wrong place.  The latter would not help to facilitate communication,
> though.

FWIW, I think the reason here was a move from SVN to git by the help of
git-svn, and in that process deciding that tag names should follow a
different (less out-dated?) format.

 - Roland
