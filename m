From: Jeff King <peff@peff.net>
Subject: Re: best practices against long git rebase times?
Date: Mon, 7 Dec 2015 17:59:57 -0500
Message-ID: <20151207225957.GB3785@sigill.intra.peff.net>
References: <20151204150546.GA17210@inner.h.apk.li>
 <20151204153103.GP18913@serenity.lan>
 <20151206164345.GH22288@inner.h.apk.li>
 <20151207210212.GF30203@sigill.intra.peff.net>
 <xmqqmvtllvfi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 00:00:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a64lJ-0002Ig-Af
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 00:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756473AbbLGXAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 18:00:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:38617 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756074AbbLGW77 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 17:59:59 -0500
Received: (qmail 24432 invoked by uid 102); 7 Dec 2015 22:59:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 16:59:59 -0600
Received: (qmail 24821 invoked by uid 107); 7 Dec 2015 23:00:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 18:00:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Dec 2015 17:59:57 -0500
Content-Disposition: inline
In-Reply-To: <xmqqmvtllvfi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282140>

On Mon, Dec 07, 2015 at 02:56:33PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > You're computing the patch against the parent for each of those 3000
> > commits (to get a hash of it to compare against the single hash on the
> > other side). Twelve minutes sounds long, but if you have a really
> > gigantic tree, it might not be unreasonable.
> >
> > You can also try compiling with "make XDL_FAST_HASH=" (i.e., setting
> > that option to the empty string). Last year I found there were some
> > pretty suboptimal corner cases, and you may be hitting one (we should
> > probably turn that option off by default; I got stuck on trying to find
> > a hash that would perform faster and never followed up[1].
> >
> > I doubt that is your problem, but it's possible).
> >
> > -Peff
> >
> > [1] http://thread.gmane.org/gmane.comp.version-control.git/261638
> 
> I vaguely recall having discussed caching the patch-ids somewhere so
> that this does not have to be done every time.  Would such an
> extension help here, I wonder?

I think you missed John's earlier response which gave several pointers
to such caching schemes. :)

I used to run with patch-id-caching in my personal fork (I frequently
use "git log --cherry-mark" to see what has made it upstream), but I
haven't for a while. It did make a big difference in speed, but I never
resolved the corner cases around cache invalidation.

-Peff
