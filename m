Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F03101F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 19:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbcHXThy (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 15:37:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58512 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751139AbcHXTg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 15:36:26 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 3DBF51F6C1;
        Wed, 24 Aug 2016 19:27:25 +0000 (UTC)
Date:   Wed, 24 Aug 2016 19:27:25 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Arif Khokar <arif_khokar@hotmail.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        git@vger.kernel.org
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
Message-ID: <20160824192725.GD8578@whir>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
 <46a5b9b6-f3f6-7650-8a5b-b0b52223e375@gmail.com>
 <DM5PR17MB1353EFB1F6FE3B05EFDF86DCD3EB0@DM5PR17MB1353.namprd17.prod.outlook.com>
 <alpine.DEB.2.20.1608241509200.4924@virtualbox>
 <20160824184938.GB8578@whir>
 <20160824191238.taeodwd2hz7q55gv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160824191238.taeodwd2hz7q55gv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Wed, Aug 24, 2016 at 06:49:38PM +0000, Eric Wong wrote:
> > > > Given that public-inbox provides an NNTP interface, couldn't the ARTICLE
> > > > <message-id> NNTP command be used to easily retrieve the messages in a
> > > > given patch series (at least compared to POP or IMAP).  Perhaps
> > > > git-send-email could be modified to include the message-id value of each
> > > > patch in the series that it sends to the mailing list and include it in
> > > > the cover letter.
> > 
> > I think that makes sense; perhaps an X-Git-Followups: header
> > from send-email which lists the child Message-IDs the same way
> > References: does for ancestors.  (perhaps there's already a
> > standardized header for listing children)
> 
> I think that's harder to adapt to some workflows, since it implies
> generating all of the message-ids ahead of time (whereas if you are
> feeding the messages into an existing MUA, it may generate them on the
> fly as it sends).

Yeah, it would be limited to git send-email users, only :<

> > I thought about allowing a giant MIME message with all the
> > patches attached, too but that won't work for a large patch
> > series due to size limits along various SMTP hops.
> > Compression might make spam filters unhappy, too.
> 
> This was a problem faced by binary groups on Usenet, which had to split
> large files across many messages.
> 
> It has been a long time since I've dealt with those, but I think the
> state of the art involved using "1/20", "2/20", etc in the subjects to
> piece together the original. There may also have been header or body
> content that included a unique id, so you always knew which messages
> were part of a set.
> 
> They also used things like forward error correction to handle dropped
> messages, but I don't think we need to go that far.
> 
> So parsing the "PATCH 1/20" headers sounds hacky, but I think it has
> worked for years in other communities.

nzb (an XML format) seems to be the thing for Usenet binaries,
nowadays.  Maybe it's workable for git, maybe it's overkill or
not worth it for the two (non-.onion) NNTP servers we have.

nzb seems widely supported enough (on a Debian jessie system):

$ apt-cache search nzb
sabnzbdplus - web-based binary newsgrabber with nzb support
sabnzbdplus-theme-classic - classic interface templates for the SABnzbd+ binary newsgrabber
sabnzbdplus-theme-iphone - transitional package for migration to sabnzbdplus-theme-mobile
sabnzbdplus-theme-mobile - mobile interface templates for the SABnzbd+ binary newsgrabber
sabnzbdplus-theme-plush - plush interface templates for the SABnzbd+ binary newsgrabber
sabnzbdplus-theme-smpl - smpl interface templates for the SABnzbd+ binary newsgrabber
libnzb-dev - An nzb based Usenet binary grabber (development files)
libnzb0c2a - An nzb based Usenet binary grabber (runtime library)
lottanzb - simple and automated Usenet downloader for Newzbin (NZB) files
nzb - Usenet binary grabber
nzbget - command-line based binary newsgrabber for nzb files
python-pynzb - unified API for parsing NZB files from NNTP (Usenet) servers
spotweb - web interface to search and filter Usenet spots
