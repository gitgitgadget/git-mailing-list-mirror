From: Jeff King <peff@peff.net>
Subject: Re: "git notes show" is orders of magnitude slower than doing it
 manually with ls-tree and cat-file
Date: Tue, 25 Nov 2014 23:49:35 -0500
Message-ID: <20141126044935.GB15252@peff.net>
References: <20141126004242.GA13915@glandium.org>
 <20141126010051.GA29830@peff.net>
 <20141126012448.GA11183@peff.net>
 <20141126013456.GA13622@peff.net>
 <20141126023039.GA19401@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 05:49:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtUXs-000698-BK
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 05:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbaKZEth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 23:49:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:45104 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751795AbaKZEtg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 23:49:36 -0500
Received: (qmail 26445 invoked by uid 102); 26 Nov 2014 04:49:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 22:49:36 -0600
Received: (qmail 4176 invoked by uid 107); 26 Nov 2014 04:49:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 23:49:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Nov 2014 23:49:35 -0500
Content-Disposition: inline
In-Reply-To: <20141126023039.GA19401@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260269>

On Wed, Nov 26, 2014 at 11:30:39AM +0900, Mike Hommey wrote:

> > Hmph. Having just written all that, I looked at your example again, and
> > you are running "git ls-tree -r", which would read the whole tree
> > anyway. So "git notes" should be _faster_ for a single lookup.
> 
> The -r actually doesn't matter, since what's being listed is a blob, not
> a tree, so there is no recursion.

Ah, right. I should have looked more carefully. I took the "-r" and the
patterns to mean "recursively list the tree, and I will grep for these
elements". But you were actually generating a set of pathspecs, which
git could then use to limit some of the walk.

-Peff
