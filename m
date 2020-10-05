Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA1DC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE59C2078D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgJEIkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:40:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:49414 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgJEIkw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 04:40:52 -0400
Received: (qmail 31286 invoked by uid 109); 5 Oct 2020 08:40:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 08:40:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17456 invoked by uid 111); 5 Oct 2020 08:40:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 04:40:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 04:40:51 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 5/7] t0060: test obscured .gitattributes and .gitignore
 matching
Message-ID: <20201005084051.GD2862927@coredump.intra.peff.net>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005072102.GE2291074@coredump.intra.peff.net>
 <20201005080353.GH1166820@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005080353.GH1166820@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 05, 2020 at 01:03:53AM -0700, Jonathan Nieder wrote:

> > Note that the ntfs magic prefix names in the tests come from the
> > algorithm described in e7cb0b4455 (and are different for each file).
> 
> Doesn't block this patch, but I'm curious: how hard would it be to make
> a test with an NTFS prerequisite that makes sure we got the magic prefix
> right?

I suspect hard since Dscho punted on it in the original series. :) If I
understand correctly, it would require having an NTFS filesystem, and
generating 10,000+ files with a clashing prefix.

> > +	for (; *argv; argv++) {
> > +		if (!strcmp("--not", *argv))
> > +			expect = !expect;
> > +		else if (expect != (is_hfs(*argv) || is_ntfs(*argv)))
> > +			 res = error("'%s' is %s.%s", *argv,
> > +				     expect ? "not " : "", x);
> > +		else
> > +			fprintf(stderr, "ok: '%s' is %s.%s\n",
> > +				*argv, expect ? "" : "not ", x);
> 
> micronit: extra space on the "res" line.

Thanks, fixed.

> This "if" cascade is a little hard to read, even though it does the
> right thing.  Can we make it more explicit?  E.g.

This is directly moved from the existing code. I'd prefer to keep the
overall structure intact to make that clear.

> I think it's a little easier to read with either (a) the dot included
> in the 'x' parameter or (b) the entire ".git" missing from the 'x'
> parameter.

Yeah, I agree that's worth doing. I took (b), as "dotgitx" implies that
"x" is "modules", etc. I had originally planned to automatically turn
"gitmodules" into "is_ntfs_dotgitmodules", too, but it required
macros and string-pasting. So I decided it was a bit too ugly. :)

-Peff
