From: Jeff King <peff@peff.net>
Subject: Re: best practices against long git rebase times?
Date: Mon, 7 Dec 2015 16:02:12 -0500
Message-ID: <20151207210212.GF30203@sigill.intra.peff.net>
References: <20151204150546.GA17210@inner.h.apk.li>
 <20151204153103.GP18913@serenity.lan>
 <20151206164345.GH22288@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 07 22:02:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a62vL-00016g-96
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 22:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933094AbbLGVCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 16:02:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:38512 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932813AbbLGVCP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 16:02:15 -0500
Received: (qmail 17133 invoked by uid 102); 7 Dec 2015 21:02:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 15:02:14 -0600
Received: (qmail 23390 invoked by uid 107); 7 Dec 2015 21:02:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 16:02:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Dec 2015 16:02:12 -0500
Content-Disposition: inline
In-Reply-To: <20151206164345.GH22288@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282124>

On Sun, Dec 06, 2015 at 05:43:45PM +0100, Andreas Krey wrote:

> On Fri, 04 Dec 2015 15:31:03 +0000, John Keeping wrote:
> ...
> > I'm pretty sure that you're right and the cherry-pick analysis is where
> > the time is spent.
> 
> But I'm pretty surprised as to the amount of CPU time that goes there.
> 
> I'm now rebasing a single commit with a single blank line added,
> and for 3000 new commits to rebase over (with 64 MByte of git log -
> for them) it takes twelve minutes, or about for commits per second,
> and all user CPU, no I/O. It's pretty linear in number of commits, too.

You're computing the patch against the parent for each of those 3000
commits (to get a hash of it to compare against the single hash on the
other side). Twelve minutes sounds long, but if you have a really
gigantic tree, it might not be unreasonable.

You can also try compiling with "make XDL_FAST_HASH=" (i.e., setting
that option to the empty string). Last year I found there were some
pretty suboptimal corner cases, and you may be hitting one (we should
probably turn that option off by default; I got stuck on trying to find
a hash that would perform faster and never followed up[1].

I doubt that is your problem, but it's possible).

-Peff

[1] http://thread.gmane.org/gmane.comp.version-control.git/261638
