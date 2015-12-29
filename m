From: Jeff King <peff@peff.net>
Subject: Re: "git stash pop" is doing an unwanted "git add" when there are
 conflicts.
Date: Tue, 29 Dec 2015 02:53:30 -0500
Message-ID: <20151229075329.GA9254@sigill.intra.peff.net>
References: <20151221142953.GA12764@acm.fritz.box>
 <1450772258.7937.9.camel@kaarsemaker.net>
 <20151222093032.GA5173@sigill.intra.peff.net>
 <20151224092038.GA2397@acm.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
To: Alan Mackenzie <acm@muc.de>
X-From: git-owner@vger.kernel.org Tue Dec 29 08:53:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDp68-0004qU-Jc
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbbL2Hxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:53:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:46655 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751198AbbL2Hxc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:53:32 -0500
Received: (qmail 19165 invoked by uid 102); 29 Dec 2015 07:53:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:53:32 -0600
Received: (qmail 20146 invoked by uid 107); 29 Dec 2015 07:53:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:53:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 02:53:30 -0500
Content-Disposition: inline
In-Reply-To: <20151224092038.GA2397@acm.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283107>

On Thu, Dec 24, 2015 at 09:20:38AM +0000, Alan Mackenzie wrote:

> > It seems to be a side effect of merge-recursive to stage the results,
> > and in the no-conflict path we explicitly reset the index. For the
> > conflicting case, it's trickier, because we would want to retain the
> > unmerged entries.
> 
> > So I agree it's kind of weird, but the conflicting case is inherently
> > going to touch the index, and you'd generally have to `git add` to mark
> > the resolutions (but if you really want to just touch the working tree,
> > you'd need to `git reset`).
> 
> From the point of view of a user, this is suboptimal.  git stash is an
> abstraction: the preservation of uncomitted changes for later.  Staging
> previously unstaged changes with git stash pop severely damages this
> abstraction.

Yeah, I think I agree. But keep in mind that we have to mention the
conflicts _somewhere_, so we're going to touch the index regardless (and
the user is going to have to erase the conflicts in the index
eventually, either with `git add` or `git reset`).

> Are there any prospects of this getting fixed?

Somebody needs to write a patch. I am not 100% convinced that it
_should_ be fixed, but I am leaning that way. But I am not planning to
work on it myself anytime soon. The best way to get more discussion
going is to post a patch. :)

-Peff
