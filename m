Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D13F20756
	for <e@80x24.org>; Tue, 17 Jan 2017 17:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbdAQRj3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 12:39:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:40308 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751380AbdAQRj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 12:39:28 -0500
Received: (qmail 13205 invoked by uid 109); 17 Jan 2017 17:32:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 17:32:41 +0000
Received: (qmail 19329 invoked by uid 111); 17 Jan 2017 17:33:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 12:33:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2017 12:32:39 -0500
Date:   Tue, 17 Jan 2017 12:32:39 -0500
From:   Jeff King <peff@peff.net>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v5 5/7] builtin/tag: add --format argument for tag -v
Message-ID: <20170117173239.ir6jxbz46vwwzoht@sigill.intra.peff.net>
References: <20170115184705.10376-1-santiago@nyu.edu>
 <20170115184705.10376-6-santiago@nyu.edu>
 <20170117153404.jp3ftdlzeyut6e7a@sigill.intra.peff.net>
 <20170117170018.nqk4yy5rrpomxr32@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170117170018.nqk4yy5rrpomxr32@LykOS.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 12:00:19PM -0500, Santiago Torres wrote:

> > >  {
> > > -	return verify_and_format_tag(sha1, name, NULL, GPG_VERIFY_VERBOSE);
> > > +	int flags;
> > > +	char *fmt_pretty = cb_data;
> > > +	flags = GPG_VERIFY_VERBOSE;
> > > +
> > > +	if (fmt_pretty)
> > > +		flags = GPG_VERIFY_QUIET;
> > > +
> > > +	return verify_and_format_tag(sha1, ref, fmt_pretty, flags);
> > 
> > It seems funny that VERBOSE and QUIET are bit-flags. What happens when
> > you ask for GPG_VERIFY_VERBOSE|GPG_VERIFY_QUIET?
> 
> If I'm not mistaken, the way the code works right now this is not
> possible (GPG_VERIFY_VERBOSE will be unset when GPG_VERIFY_QUIET). I
> would have to re-read the patch to make sure this is the case then.

No, you're right that the two flags are mutually exclusive in the
current callers. So I don't think there's a bug here. It's just that the
interface is potentially awkward/confusing, which may be a problem down
the line.

VERBOSE|QUIET _does_ have a meaning, which is "show the payload, but do
not print the signature buffer". Perhaps just renaming QUIET to
OMIT_STATUS or something would make it more clear.

-Peff
