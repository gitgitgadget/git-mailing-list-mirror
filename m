From: Jeff King <peff@peff.net>
Subject: Re: "git stash pop" is doing an unwanted "git add" when there are
 conflicts.
Date: Wed, 30 Dec 2015 02:02:38 -0500
Message-ID: <20151230070238.GA29896@sigill.intra.peff.net>
References: <20151221142953.GA12764@acm.fritz.box>
 <1450772258.7937.9.camel@kaarsemaker.net>
 <20151222093032.GA5173@sigill.intra.peff.net>
 <20151224092038.GA2397@acm.fritz.box>
 <20151229075329.GA9254@sigill.intra.peff.net>
 <20151229212038.GD1884@acm.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
To: Alan Mackenzie <acm@muc.de>
X-From: git-owner@vger.kernel.org Wed Dec 30 08:02:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEAmT-0006KE-DS
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 08:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbbL3HCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 02:02:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:47045 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750876AbbL3HCk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 02:02:40 -0500
Received: (qmail 17023 invoked by uid 102); 30 Dec 2015 07:02:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Dec 2015 01:02:41 -0600
Received: (qmail 28459 invoked by uid 107); 30 Dec 2015 07:02:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Dec 2015 02:02:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Dec 2015 02:02:38 -0500
Content-Disposition: inline
In-Reply-To: <20151229212038.GD1884@acm.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283166>

On Tue, Dec 29, 2015 at 09:20:38PM +0000, Alan Mackenzie wrote:

> > Yeah, I think I agree. But keep in mind that we have to mention the
> > conflicts _somewhere_, so we're going to touch the index regardless (and
> > the user is going to have to erase the conflicts in the index
> > eventually, either with `git add` or `git reset`).
> 
> When the stash consists entirely of changes in the working directory,
> and "git stash pop" has conflicts, why can't these conflicts simply be
> marked by "<<<<<<<<" (etc.) in the working directory, leaving the index
> unchanged?  The index is left unchanged when there are no conlicts.

I don't think that's a good idea. Git always marks conflicts in the
index for other operations. Besides being inconsistent with the rest of
git, it drops useful information that other tools can use. For example,
one cannot "git checkout --conflict=diff3" afterwards, or use "git
mergetool" to kick off a third-party merge tool.

Not to mention that the information is lost to the user themselves. If
we touched 10 files and 2 had conflicts, there is now no way for the
user to ask "where were the conflicts?". They can either find the stash
output in their terminal scrollback, or grep for things that look like
conflict markers.

-Peff
