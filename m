Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3DC51F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 18:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755740AbcHXS5P (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 14:57:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56508 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753368AbcHXS5N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 14:57:13 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D9E011F6C1;
        Wed, 24 Aug 2016 18:49:38 +0000 (UTC)
Date:   Wed, 24 Aug 2016 18:49:38 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Arif Khokar <arif_khokar@hotmail.com>
Cc:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        meta@public-inbox.org, git@vger.kernel.org
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
Message-ID: <20160824184938.GB8578@whir>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
 <46a5b9b6-f3f6-7650-8a5b-b0b52223e375@gmail.com>
 <DM5PR17MB1353EFB1F6FE3B05EFDF86DCD3EB0@DM5PR17MB1353.namprd17.prod.outlook.com>
 <alpine.DEB.2.20.1608241509200.4924@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.20.1608241509200.4924@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Arif,
> 
> On Tue, 23 Aug 2016, Arif Khokar wrote:
> 
> > On 08/20/2016 03:57 PM, Jakub Narębski wrote:
> > 
> > > But perhaps the problem is current lack of tooling in the opposite
> > > direction, namely getting patches from mailing list and applying them
> > > to GitHub repo, or Bitbucket, or GitLab.  Though with working Git, it
> > > is something easier than sending patches via email; it is enough that
> > > email client can save email to a file (or better, whole sub-thread to
> > > file or files).
> > 
> > Given that public-inbox provides an NNTP interface, couldn't the ARTICLE
> > <message-id> NNTP command be used to easily retrieve the messages in a
> > given patch series (at least compared to POP or IMAP).  Perhaps
> > git-send-email could be modified to include the message-id value of each
> > patch in the series that it sends to the mailing list and include it in
> > the cover letter.

I think that makes sense; perhaps an X-Git-Followups: header
from send-email which lists the child Message-IDs the same way
References: does for ancestors.  (perhaps there's already a
standardized header for listing children)

I thought about allowing a giant MIME message with all the
patches attached, too but that won't work for a large patch
series due to size limits along various SMTP hops.
Compression might make spam filters unhappy, too.

> I am no expert in the NNTP protocol (I abandoned News long ago), but if
> you go from HTML, you can automate the process without requiring changes
> in format-patch.
> 
> > Then a script could be written (i.e., git-download-patch) which could
> > parse the cover letter message (specified using its message-id), and
> > download all the patches in series, which can then be applied using
> > git-am.  This would in fact take the email client out of the equation in
> > terms of saving patches.

	w3m -dump -dump_source nntp://<NNTP-server>/<Message-ID>

ought to already work for news.gmane.org and news.public-inbox.org

The Net::NNTP Perl module is a standard part of the Perl distro
for many years, now (along with Net::SMTP), so that would not
be a roadblock for implementing a custom downloader distributed
with git.

> I recently adapted an old script I had to apply an entire patch series
> given the GMane link to its cover letter:
> 
> https://github.com/git-for-windows/build-extra/blob/master/apply-from-gmane.sh
> 
> Maybe you find it in you to adapt that to work with public-inbox.org?

I would be hesitant to depend too much on public-inbox.org until
more mirrors appear.  Even then, NNTP is a better-established
protocol and a fallback to news.gmane still works.
(public-inbox.org is powered by hamsters running on wheels,
 sometimes I let them rest :)
