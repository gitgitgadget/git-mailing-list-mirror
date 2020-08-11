Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589E5C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 06:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA502078E
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 06:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgHKGku (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:40:50 -0400
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:60484 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727066AbgHKGku (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Aug 2020 02:40:50 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2020 02:40:49 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 4F78018016EAE
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 06:33:58 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 894A618224D61;
        Tue, 11 Aug 2020 06:33:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mass64_380d12a26fe0
X-Filterd-Recvd-Size: 3080
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue, 11 Aug 2020 06:33:56 +0000 (UTC)
Message-ID: <c2c4f7106f400260ca7ee2ba709fa43c2f0072c9.camel@perches.com>
Subject: Re: [PATCH v2] gitweb: map names/emails with mailmap
From:   Joe Perches <joe@perches.com>
To:     Eric Wong <e@80x24.org>, Emma Brooks <me@pluvano.com>,
        Florian Mickler <florian@mickler.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Mon, 10 Aug 2020 23:33:55 -0700
In-Reply-To: <20200811061729.GA7134@dcvr>
References: <20200808213457.13116-1-me@pluvano.com>
         <20200809230436.2152-1-me@pluvano.com>
         <20200810100249.GC37030@coredump.intra.peff.net>
         <20200811041728.GA1748@pluvano.com> <20200811061729.GA7134@dcvr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2020-08-11 at 06:17 +0000, Eric Wong wrote:
> Emma Brooks <me@pluvano.com> wrote:
> > On 2020-08-10 06:02:49-0400, Jeff King wrote:
> > > There was a little discussion in response to v1 on whether we could
> > > reuse the existing C mailmap code:
> > > 
> > >   https://lore.kernel.org/git/20200731010129.GD240563@coredump.intra.peff.net/
> > > 
> > > Did you have any thoughts on that?
> > 
> > I think it's probably not worth the effort to make the necessary changes
> > to "rev-list --header" Junio mentioned, just for gitweb.
> > 
> > I agree it's a bit worrisome to have a second parser that could
> > potentially behave slightly differently than the main implementation.
> 
> +Cc Joe Perches
> 
> Fwiw, there's already a GPL-2.0 Perl .mailmap parser in
> scripts/get_maintainer.pl of the Linux kernel which Joe
> maintains:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/get_maintainer.pl

+cc Florian Mickler

Might be different behavior, dunno.

Florian Mickler wrote most of that and I
believe I rewrote it a bit, mostly for style.

If the perl code is useful to you, do what
you will with it, I give you my permission.

I don't believe get_maintainer needs to be
changed unless it's shown to be different
than what git does already.  I think it's
the same output.

> Been thinking about adding mailmap support to public-inbox in
> the send-email reply instructions, too.  (but public-inbox is
> AGPL-3+, so I can't steal the code w/o permission)
> 
> > What if we added tests for gitweb's mailmap parsing based on the same
> > cases used for Git itself?
> 
> That's probably fine IMHO; especially if it's just for gitweb display
> (and not writing anything that's meant to be stored forever).
> 
> There's already dozens of different parsers for email addresses,
> MIME, mailbox formats, etc. all with slightly different edge cases;
> things still mostly work well enough to not be a huge problem.
> (Same goes for Markdown, HTML, formats and even JSON :x)

