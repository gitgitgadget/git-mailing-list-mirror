Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E0E81FF76
	for <e@80x24.org>; Fri, 25 Nov 2016 03:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbcKYDOb (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Nov 2016 22:14:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:47005 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751119AbcKYDO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2016 22:14:28 -0500
Received: (qmail 3662 invoked by uid 109); 25 Nov 2016 03:14:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Nov 2016 03:14:28 +0000
Received: (qmail 15759 invoked by uid 111); 25 Nov 2016 03:15:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Nov 2016 22:15:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Nov 2016 22:14:26 -0500
Date:   Thu, 24 Nov 2016 22:14:26 -0500
From:   Jeff King <peff@peff.net>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Greg KH (gregkh@linuxfoundation.org)" <gregkh@linuxfoundation.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc-next] mei: request async autosuspend at the end of
 enumeration
Message-ID: <20161125031425.gefijvssvygp6pl4@sigill.intra.peff.net>
References: <1479987242-32050-1-git-send-email-tomas.winkler@intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B5433132E@hasmsx108.ger.corp.intel.com>
 <20161124204316.sqxjpc7uzbrzhvho@sigill.intra.peff.net>
 <5B8DA87D05A7694D9FA63FD143655C1B54331476@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B54331476@hasmsx108.ger.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2016 at 10:37:14PM +0000, Winkler, Tomas wrote:

> > > > Cc: <stable@vger.kernel.org> # 4.4+
> > >
> > > Looks like git send-email is not able to parse this address correctly
> > > though this is suggested format by Documentation/stable_kernel_rules.txt.
> > > Create wrong address If git parsers is used : 'stable@vger.kernel.org#4.4+'
> > >
> > > Something like s/#.*$// is needed before parsing Cc:
> > 
> > This should be fixed by e3fdbcc8e (parse_mailboxes: accept extra text after
> > <...> address, 2016-10-13), which will be released next week as part of v2.11. As
> > a workaround, you can also install the Mail::Address perl module.  See [1] for
> > the gory details.
> 
> Thanks for update, I failed to understand from the thread though what
> decision was actually applied, I will look at the patch itself.  I've
> tried to install Mail::Address and it fixes the actual address, but it
> appends  the # 4.4+ suffix into the name  as also mentioned in the
> thread, which doesn't fit the stable rules doc.

The patch just brings parity to the Mail::Address behavior and git's
fallback parser, so that you don't end up with the broken
stable@vger.kernel.org#4.4+ address. Instead, that content goes into the
name part of the address.

It sounds like you want the "# 4.4+" to be dropped entirely in the
rfc822 header. It looks like send-email used to do that, but stopped in
b1c8a11c8 (send-email: allow multiple emails using --cc, --to and --bcc,
2015-06-30).

So perhaps there are further fixes required, but it's hard to know. The
input isn't a valid rfc822 header, so it's not entirely clear what the
output is supposed to be. I can buy either "drop it completely" or
"stick it in the name field of the cc header" as reasonable.

-Peff
