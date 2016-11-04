Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B15532022D
	for <e@80x24.org>; Fri,  4 Nov 2016 21:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759629AbcKDVbG (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 17:31:06 -0400
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:60593 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759427AbcKDVbF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 17:31:05 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id E8EAD47B51E
        for <git@vger.kernel.org>; Fri,  4 Nov 2016 22:20:06 +0100 (CET)
Received: from mfilter26-d.gandi.net (mfilter26-d.gandi.net [217.70.178.154])
        by relay2-d.mail.gandi.net (Postfix) with ESMTP id 10252C5A5A;
        Fri,  4 Nov 2016 22:20:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter26-d.gandi.net
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
        by mfilter26-d.gandi.net (mfilter26-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id N-Iie_NqSGO7; Fri,  4 Nov 2016 22:20:03 +0100 (CET)
X-Originating-IP: 198.233.217.214
Received: from x (unknown [198.233.217.214])
        (Authenticated sender: josh@joshtriplett.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C8728C5A4E;
        Fri,  4 Nov 2016 22:20:01 +0100 (CET)
Date:   Fri, 4 Nov 2016 15:19:59 -0600
From:   Josh Triplett <josh@joshtriplett.org>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>
Subject: Re: Regarding "git log" on "git series" metadata
Message-ID: <20161104211959.3532uiud27nhumt7@x>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD2+A0MUKazAfSwCvv61TJRPuoOzH5EkqcrBOUi4TcuoDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD2+A0MUKazAfSwCvv61TJRPuoOzH5EkqcrBOUi4TcuoDw@mail.gmail.com>
User-Agent: NeoMutt/20161014 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2016 at 09:47:41PM +0100, Christian Couder wrote:
> On Fri, Nov 4, 2016 at 6:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Imagine we invent a new tree entry type, "gitref", that is similar
> > to "gitlink" in that it can record a commit object name in a tree,
> > but unlike "gitlink" it does imply reachability.  And you do not add
> > phony parents to your commit object.  A tree that has "gitref"s in
> > it is about annotating the commits in the same repository (e.g. the
> > tree references two commits, "base" and "tip", to point into a slice
> > of the main history).  And it is perfectly sensible for such a
> > pointer to imply reachability---after all it serves different
> > purposes from "gitlink".
> 
> The more I think about this (and also about how to limit ref
> advertisements as recently discussed in
> https://public-inbox.org/git/20161024132932.i42rqn2vlpocqmkq@sigill.intra.peff.net/),
> the more I think about Shawn's RefTree:
> 
> https://public-inbox.org/git/CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com/
> 
> Couldn't a RefTree be used to store refs that point to the base
> commit, the tip commit and the blob that contains the cover letter,
> and maybe also a ref pointing to the RefTree of the previous version
> of the series?

That's really interesting!  The Software Heritage project is working on
something similar, because they want to store all the refs as part of
their data model as well.  I'll point them to the reftree work.

If upstream git supported RefTree, I could potentially use that for
git-series.  However, I do want a commit message and history for the
series itself, and using refs in the reftree to refer to the parents
seems like abusing reftree to recreate commits, in a reversal of the
hack of using commit parents as a reftree. :)

What if, rather than storing a hash reference to a reftree as a single
reference and replacing it with no history, a reftree could be
referenced from a commit and have history?  (That would also allow
tagging a version of the reftree.)
