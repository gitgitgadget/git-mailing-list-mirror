From: Jeff King <peff@peff.net>
Subject: Re: Git gc removes all packs
Date: Fri, 27 Feb 2015 08:14:26 -0500
Message-ID: <20150227131425.GA13005@peff.net>
References: <CAC+L6n1M7LtGaJy94fnhXm94zJ32HXLNVGMguWSqHm=qqLLDxA@mail.gmail.com>
 <20150205200332.GD15326@peff.net>
 <CAC+L6n3OFYsjm+5PMW3DBzJo7LnUsxRq1TRE4PMvFvWVG6DQ+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dmitry Neverov <dmitry.neverov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 14:14:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRKkW-0007Fs-PX
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 14:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbbB0NO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 08:14:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:54115 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751899AbbB0NO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 08:14:28 -0500
Received: (qmail 25453 invoked by uid 102); 27 Feb 2015 13:14:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Feb 2015 07:14:28 -0600
Received: (qmail 943 invoked by uid 107); 27 Feb 2015 13:14:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Feb 2015 08:14:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Feb 2015 08:14:26 -0500
Content-Disposition: inline
In-Reply-To: <CAC+L6n3OFYsjm+5PMW3DBzJo7LnUsxRq1TRE4PMvFvWVG6DQ+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264495>

On Fri, Feb 27, 2015 at 11:16:09AM +0100, Dmitry Neverov wrote:

> I followed your advice and removed a symlink ref from my repository.
> But didn't help.. automatic GC has just removed all packs again. May
> alternates cause such a behavior? Are any ways to make gc log
> somewhere why it removes packs?

If you have two repositories, A and B, and A points to B via alternates,
then you cannot safely run "git gc" in B unless it knows about all of
the refs in A. As we discussed before, symlinking the refs is not
enough, because those symlinks get stale. But nor is removing the
symlinks and just not knowing about the refs. :)

The only safe thing to do is to fetch all of the refs from A into B just
before running the gc (and consequently, you probably want to disable
gc.auto in B).

-Peff
